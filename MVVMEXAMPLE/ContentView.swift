//
//  ContentView.swift
//  MVVMEXAMPLE
//
//  Created by Sameer,s Macbook on 4/23/25.
//

import SwiftUI
import MapKit

struct ContentView: View {
    
    @StateObject private var vm = ProductListViewModel(webservice: Webservice())
                                                   
    var body: some View {
        List(vm.products) { product in
            VStack(alignment: .leading) {
                Text(product.title)
                    .font(.headline)
                Text("$\(String(format: "%.2f", product.price))")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
        }
        .task {
            await vm.populateProducts()
        }
    }
}

#Preview {
    ContentView()
}

