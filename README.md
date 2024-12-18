# hemi-network

Script Miner Hemi Network
1. Run script in VPS
 ```bash
curl -sLO https://raw.githubusercontent.com/cryptoooq/hemi-network/main/hemi.sh && chmod +x hemi.sh && ./hemi.sh
```
2. [Generate](https://altquick.com/exchange/profile/deposit) LTC address and send LTC 1~5$
3. [Trade](https://altquick.com/exchange/market/Litecoin) LTC to BTC
4. [Trade](https://altquick.com/exchange/market/BitcoinTestnet3) BTC to tBTC
5. [Trade](https://altquick.com/exchange/profile/withdraw)Withdraw tBTC to pubkey_hash address 
Check your status:
 ```bash
sudo journalctl -u hemi -f
```
