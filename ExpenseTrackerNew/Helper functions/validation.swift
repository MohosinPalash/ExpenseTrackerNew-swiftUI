//
//  validation.swift
//  ExpenseTrackerNew
//
//  Created by Mohosin Islam Palash on 16/1/24.
//

import Foundation

func textValidation (textToCheck: String) -> Bool {
    if textToCheck.count > 0 {
        return true
    } else {
        return false
    }
}
