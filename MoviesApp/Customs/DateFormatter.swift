//
//  DateFormatter.swift
//  MoviesApp
//
//  Created by Doston Rustamov on 06/03/22.
//

import Foundation

extension DateFormatter {
    
    static func getFormated(date: String, with pattern: String) -> String? {
        
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd"

        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM dd,yyyy"

        if let date = dateFormatterGet.date(from: date) {
            return dateFormatterPrint.string(from: date)
        } else {
           print("There was an error decoding the string")
            return nil
        }
    }
}
