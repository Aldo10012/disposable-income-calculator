//
//  TaxModels.swift
//  disposable-income-calculator
//
//  Created by Alberto Dominguez on 1/8/21.
//

import Foundation

struct TaxModel: Codable{
    var annual: Annual
}

struct Annual: Codable{
    var fica: FicaModel
    var federal: FederalModel
    var state: StateModel
}

struct FicaModel: Codable{
    var amount: Double
}

struct FederalModel: Codable{
    var amount: Double
}

struct StateModel: Codable{
    var amount: Double?
}
