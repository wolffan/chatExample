//
//  DateHelper.swift
//  simpleChat
//
//  Created by Raimon Lapuente on 27/10/2016.
//  Copyright © 2016 Raimon Lapuente. All rights reserved.
//

import Foundation

class DateHelper {
    
    class func getHourTime(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: date)
    }
}
