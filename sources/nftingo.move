module nftlingo::nftingo_module{

    use std::signer;

    struct Crypto has store{ val : u64 }

    struct Bal has key{
        tokens:Crypto
    }

    /// Error codes
    const ERR_BALANCE_NOT_EXISTS: u64 = 101;
    const ERR_BALANCE_EXISTS: u64 = 102;
    const EINSUFFICIENT_BALANCE: u64 = 1;
    const EALREADY_HAS_BALANCE: u64 = 2;
    const EEQUAL_ADDR: u64 = 4;

    public fun mint(val: u64):Crypto{
        let new_coin = Crypto{val};
        new_coin
    }

    public fun burn(coin : Crypto){
        let Crypto{val: _ } = coin;
    }

    public fun create_balancce(acc: &signer){
        let acc_addr = signer::address_of(acc);
        assert!(!balance_exists(acc_addr),ERR_BALANCE_EXISTS);
        let zero_coins = Crypto{val:0};
        move_to(acc,Bal{tokens : zero_coins});
    }

    public fun balance_exists(acc_addr: address):bool{
        exists<Bal>(acc_addr)
    }

     public fun balance(owner: address): u64 acquires Bal {
        borrow_global<Bal>(owner).tokens.val
    }

    public fun deposit(acc_addr: address,tokens:Crypto) acquires Bal{
        let balance = balance(acc_addr);
        assert!(balance_exists(acc_addr),ERR_BALANCE_NOT_EXISTS);
        let balance_ref = &mut borrow_global_mut<Bal>(acc_addr).tokens.val;
        let Crypto{val} = tokens;
        *balance_ref = balance + val;
    }


    public fun withdraw(acc: address,value : u64) : Crypto acquires Bal{
        assert!(balance_exists(acc),ERR_BALANCE_NOT_EXISTS);
        let balance = balance(acc);
        assert!(balance >= value, EINSUFFICIENT_BALANCE);
        let balance_ref = &mut borrow_global_mut<Bal>(acc).tokens.val;
        *balance_ref = balance - value;
         Crypto{ val: value }
    }
   /// Transfers `amount` of tokens from `from` to `to`.
    public fun transfer(from: &signer, to: address, amount: u64) acquires Bal {
        let from_addr = signer::address_of(from);
        assert!(from_addr != to, EEQUAL_ADDR);
        let check = withdraw(from_addr, amount);
        deposit(to, check);
    }
    

    #[test(acc=@0x123)]
    fun test_use_some_coins(acc: signer) acquires Bal{
        let acc_addr = signer::address_of(&acc);
        let coins_10 = mint(10);
        create_balancce(&acc);
        deposit(acc_addr,coins_10);
        assert!(balance(acc_addr)==10,EINSUFFICIENT_BALANCE);
        let coins_5 = withdraw(acc_addr, 5);
        assert!(balance(acc_addr)==5,EALREADY_HAS_BALANCE);
        burn(coins_5);
    }

}