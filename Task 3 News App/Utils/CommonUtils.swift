//
//  CommonUtils.swift
//  Task 3 News App
//
//  Created by Nikolay Shiderov on 3.11.21.
//

import Foundation
import UIKit

class CommonUtils {
    static func convertUTCToLocal (utcDateString: String) -> String {
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let convertedDate = format.date(from: utcDateString)
        format.timeZone = TimeZone.current
        format.dateFormat = "MMM d, yyyy"
        let localDateString = format.string(from: convertedDate!)
        return localDateString
    }
}

