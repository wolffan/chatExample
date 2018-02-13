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
}

// Show us your ability to interact with external apis. You’ll have to deal with multiple calls
//to fetch the required information. We would like to see how you’ll design that and what
//will be your strategy to handle bad networking (and offline device), caching and
//refreshing.

class DataRepository: ETHRepository {
    
    static let address = "0x082d3e0f04664b65127876e9A05e2183451c792a"
    static let EtherscanAPIKey = "E5QFXD7ZYRH7THQM5PIXB8JD4GY38SEJZ4"
    
    var tokens: Array = [Token]()
    var balance: Double = 0
    let storage: TokenStorage
    
    init(storage: TokenStorage) {
        self.storage = storage
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
                print("Something went wrong...")
            }
        }
        
        task.resume()
    }
    
    func fetchAll() {
        for coin in allCoins() {
            guard let enumCoin = coins.init(rawValue: coin) else {
                return
            }
            updateCoin(coin: enumCoin)
        }
    }
    
    //update coin on memory
    func updateCoin(coin: coins) {
        let url = coin.tokenURL()
        fetch(url: url) { (result) in
            guard let numberOfTokens = result["result"] as? Double else {
                return
            }
            self.storage.update(token: coin.rawValue, value: numberOfTokens.cryptoBalueToDecimals())
            self.getRate(coin: coin)
        }
    }
    
    func getRate(coin: coins) {
        let url = coin.rateURL()
        fetch(url: url) { (result) in
            guard let rate = result["rate"] as? Double else {
                return
            }
            self.storage.update(token: coin.rawValue, value: rate)
        }
    }
    
    func allCoins() -> [String] {
        return [coins.GNT.rawValue, coins.REP.rawValue, coins.OMG.rawValue, coins.ETH.rawValue]
    }
    func allTokens() -> [String] {
        return [coins.GNT.rawValue, coins.REP.rawValue, coins.OMG.rawValue]
    }
    
    //repository
    
    func getAllTokens() -> [Token] {
        return self.storage.tokens.filter({$0.key != coins.ETH.rawValue}).map({$0.value})
    }
    
    func allTokens() -> NSInteger {
        return self.storage.tokens.count
    }
    
    func getETHBalance() -> Double {
        if let eth = self.storage.tokens[coins.ETH.rawValue] {
            return eth.amount
        } else {
            return 0
        }
    }
    
    func getToken(position: NSInteger) -> Token {
        return getAllTokens()[position]
    }
    
    // coins info
    
    enum coins: String {
        case GNT
        case REP
        case OMG
        case ETH
        
        func fullName() -> String {
            switch self {
            case .GNT: return "Golem"
            case .REP: return "Augur"
            case .OMG: return "OmniseGo"
            case .ETH: return "Ethereum"
            }
        }
        
        func address() -> String {
            switch self {
            case .GNT: return "0xa74476443119A942dE498590Fe1f2454d7D4aC0d"
            case .REP: return "0xe94327d07fc17907b4db788e5adf2ed424addff6"
            case .OMG: return "0xd26114cd6EE289AccF82350c8d8487fedB8A0C07"
            case .ETH: return "0x082d3e0f04664b65127876e9A05e2183451c792a"
            }
        }
        
        func rateString() -> String {
            return self.rawValue+"_"+"eth"
        }
        
        func rateURL() -> String {
            return "https://shapeshift.io/rate/\(self.rateString())"
        }
        
        func tokenURL() -> String {
            switch self {
            case .ETH:
                return "https://api.etherscan.io/api?module=account&action=balance&address=\(self.address)&tag=latest&apikey=\(DataRepository.EtherscanAPIKey)"
            default:
                return "https://api.etherscan.io/api?module=account&action=tokenbalance&contractaddress=\(self.address)&address=\(DataRepository.address)&tag=latest&apikey=\(DataRepository.EtherscanAPIKey)"
            }
        }
    }
}
