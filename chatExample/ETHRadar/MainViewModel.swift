//
//  MainViewModel.swift
//  ETHRadar
//
//  Created by Raimon Lapuente Ferran on 13/02/2018.
//  Copyright © 2018 Raimon Lapuente. All rights reserved.
//

import Foundation

enum State {
    case loading
    case empty
    case done
}

protocol MainProtocol {
    var status: State { get }
    func update()
}

typealias ethBlock = (_ ethAmount: String) -> Void

class MainViewModel: MainProtocol {
    var status: State = .empty
    let dataRepo: ETHRepository
    private var ethBlock: ethBlock?
    private var tokenBlock: ethBlock?
    
    init(repository: ETHRepository) {
        dataRepo = repository
        dataRepo.updateCall {
            DispatchQueue.main.async {
                self.refreshUI()
            }
        }
    }
    
    func refreshUI() {
        if dataRepo.allTokens() != 0 {
            status = .loading
        }
        tokenBlock?(tokenInitialValue())
        ethBlock?(ethInitialValue())
    }
    
    func update() {
        self.refreshUI()
        dataRepo.fetchAll()
    }
    
    func populateETH(block: @escaping (_ ethAmount: String) -> Void) {
        ethBlock = block
    }
    
    func populateTokens(block: @escaping (_ ethAmount: String) -> Void) {
        tokenBlock = block
    }
    
    func ethInitialValue() -> String {
        if status == .empty {
            return "0 ETH"
        } else {
            return ethValue()
        }
    }
    
    func ethValue() -> String {
        return "\(dataRepo.getETHBalance()) ETH"
    }
    
    func tokenInitialValue() -> String {
        if status == .empty {
            return "0 ETH"
        } else {
            return tokenValue()
        }
    }
    
    func tokenValue() -> String {
        let total = dataRepo.getAllTokens().map({$0.amount*$0.rate}).reduce(0, +)
        return "\(total) ETH"
    }
    
    
}
