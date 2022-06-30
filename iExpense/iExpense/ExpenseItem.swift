//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Jake Quinter on 6/30/22.
//

import Foundation

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}
