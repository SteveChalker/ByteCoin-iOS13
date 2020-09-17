//
//  ExchangeRateModel.swift
//  ByteCoin
//
//  Created by Stephen Chalker on 6/6/20.
//  Copyright © 2020 The App Brewery. All rights reserved.
//

import Foundation

struct ExchangeRateModel: Codable {
    let rate: Double
    let asset_id_quote: String
}
