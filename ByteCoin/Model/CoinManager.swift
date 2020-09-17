//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

struct CoinManager {
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "8E5A7056-4029-46E5-A352-DA508B77186B"
    
    var delegate: CoinDelegate?
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]

    func getCoinPrice(for currency: String) {
        let url = "\(baseURL)/\(currency)?apikey=\(apiKey)"
        performRequest(with: url)
    }
    
    private func performRequest(with url: String) {
        if let url = URL(string: url) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if(error != nil) {
                    print(error!)
                    self.delegate?.onError(error!)
                    return
                }
                
                if let safedata = data {
                    if let safeRate = self.parseJson(data: safedata) {
                        self.delegate?.onSuccess(exchangeRate: safeRate)
                    }
                }
            }
            
            task.resume()
        }
    }
    
    private func parseJson(data: Data) -> ExchangeRateModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(ExchangeRateModel.self, from: data)
            return decodedData
        } catch {
            delegate?.onError(error)
            return nil
        }
    }
}

protocol CoinDelegate {
    func onSuccess(exchangeRate: ExchangeRateModel)
    func onError(_ error: Error)
}
