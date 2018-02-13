//
//  DoubleExtension.swift
//  ETHRadar
//
//  Created by Raimon Lapuente Ferran on 11/02/2018.
//  Copyright © 2018 Raimon Lapuente. All rights reserved.
//

import Foundation

extension Double {
    func scientificToEightDecimals(decimals: Int) -> Double {
        let decimal = self / pow(10.0, Double(decimals))
        return decimal
    }
    func cryptoBalueToDecimals() -> Double {
        return scientificToEightDecimals(decimals: 18)
    }
}
