//
//  Coins.swift
//  ETHRadar
//
//  Created by Raimon Lapuente Ferran on 14/02/2018.
//  Copyright © 2018 Raimon Lapuente. All rights reserved.
//

import Foundation

// coins info

enum Coins: String {
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
            return "https://api.etherscan.io/api?module=account&action=balance&address=\(self.address())&tag=latest&apikey=\(DataRepository.EtherscanAPIKey)"
        default:
            return "https://api.etherscan.io/api?module=account&action=tokenbalance&contractaddress=\(self.address())&address=\(DataRepository.address)&tag=latest&apikey=\(DataRepository.EtherscanAPIKey)"
        }
    }
}
