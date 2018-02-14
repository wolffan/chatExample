//
//  DataRepository.swift
//  simpleChat
//
//  Created by Raimon Lapuente on 25/10/2016.
//  Copyright © 2016 Raimon Lapuente. All rights reserved.
//

import Foundation

protocol ETHRepository {
    func getAllTokens() -> [Token]
    func getETHBalance() -> Double
    func getToken(position: NSInteger) -> Token
    func allTokens() -> NSInteger
    
    func fetchAll()
     var loading: Bool { get }
    
    func updateCall(block: @escaping updateBlock)
}


typealias updateBlock = () -> ()

// Show us your ability to interact with external apis. You’ll have to deal with multiple calls
//to fetch the required information. We would like to see how you’ll design that and what
//will be your strategy to handle bad networking (and offline device), caching and
//refreshing.

class DataRepository: ETHRepository {
    
    static let address = "0x082d3e0f04664b65127876e9A05e2183451c792a"
    static let EtherscanAPIKey = "E5QFXD7ZYRH7THQM5PIXB8JD4GY38SEJZ4"
    
    let storage: TokenStorage
    var loading: Bool
    private var updateBlock: updateBlock?
    
    init(storage: TokenStorage) {
        self.storage = storage
        self.loading = false
    }
    
    // TODO - reque a request
    fileprivate func fetch(url: String, parser: @escaping (_ result:[String:Any]) -> Void){
        let url = URL(string:url)
        let request = NSMutableURLRequest(url:url!)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) -> Void in
            do {
                if let httpResponse = response as? HTTPURLResponse {
                    if httpResponse.statusCode != 200 {
                        print("Something went wrong...")
                    } else {
                        guard let safeData = data else {
                            print("error")
                            return
                        }
                        if let json = try JSONSerialization.jsonObject(with: safeData, options: JSONSerialization.ReadingOptions()) as? [String:Any] {
                            parser(json)
                        }
                        else {
                            print("error, no json info")
                        }
                    }
                }
            } catch {
                print("Something went wrong.. .2")
            }
        }
        
        task.resume()
    }
    
    func fetchAll() {
        for coin in allCoins() {
            guard let enumCoin = Coins(rawValue: coin) else {
                return
            }
            updateCoin(coin: enumCoin)
        }
    }
    
    //update coin on memory
    func updateCoin(coin: Coins) {
        let url = coin.tokenURL()
        fetch(url: url) { (result) in
            guard let numberOfTokens = result["result"] as? String else {
                return
            }
            self.storage.update(token: coin.rawValue, value: Double(numberOfTokens)!.cryptoBalueToDecimals())
            self.getRate(coin: coin)
        }
    }
    
    func getRate(coin: Coins) {
        let url = coin.rateURL()
        fetch(url: url) { (result) in
            guard let rate = result["rate"] as? String, let doubleRate = Double(rate) else {
                return
            }
            self.storage.updateRate(token: coin.rawValue, rate: doubleRate)
            self.updateBlock?()
        }
    }
    
    func allCoins() -> [String] {
        return [Coins.GNT.rawValue, Coins.REP.rawValue, Coins.OMG.rawValue, Coins.ETH.rawValue]
    }
    func allTokens() -> [String] {
        return [Coins.GNT.rawValue, Coins.REP.rawValue, Coins.OMG.rawValue]
    }
    
    func updateCall(block: @escaping updateBlock) {
        updateBlock = block
    }
    
    //repository
    
    func getAllTokens() -> [Token] {
        return self.storage.tokens.filter({$0.key != Coins.ETH.rawValue}).map({$0.value})
    }
    
    func allTokens() -> NSInteger {
        return self.getAllTokens().count
    }
    
    func getETHBalance() -> Double {
        if let eth = self.storage.tokens[Coins.ETH.rawValue] {
            return eth.amount
        } else {
            return 0
        }
    }
    
    func getToken(position: NSInteger) -> Token {
        return getAllTokens()[position]
    }
}
