//
//  Webservice.swift
//  MVVMEXAMPLE
//
//  Created by Sameer,s Macbook on 4/27/25.
//

import Foundation
enum NetworkError: Error {
    case invalidURL
    case decodingFailed
    case badrequest
}

class Webservice {
    
    func getProducts() async throws -> [Product] {
        // url will change on the base  of dev enviroment
        
        guard let url = URL(string: "https://fakestoreapi.com/products") else {
            throw NetworkError.invalidURL
        }
        
        // for the respnse and error handling side
        let (data,response) = try await URLSession.shared.data(from: url)
        if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode != 200 {
            throw NetworkError.badrequest
        }
        
        guard let products = try? JSONDecoder().decode([Product].self, from: data) else {
            throw NetworkError.decodingFailed
        }
        
        return products
        
    }
    
}
