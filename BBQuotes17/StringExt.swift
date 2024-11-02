//
//  StringExt.swift
//  BBQuotes17
//
//  Created by Weerawut Chaiyasomboon on 1/11/2567 BE.
//

import Foundation

extension String{
    func removeSpaces() -> String{
        self.replacingOccurrences(of: " ", with: "")
    }
    
    func removeCaseAndSpaces() -> String{
        self.removeSpaces().lowercased()
    }
}
