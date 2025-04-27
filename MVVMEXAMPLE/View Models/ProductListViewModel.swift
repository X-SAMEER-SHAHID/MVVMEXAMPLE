//
//  ProductListViewModel.swift
//  MVVMEXAMPLE
//
//  Created by Sameer,s Macbook on 4/27/25.
//

import Foundation

@MainActor
class ProductListViewModel : ObservableObject{
    
    // making the array in the end
    @Published var products : [ProductViewModel] = []
    @Published var errorMessage: String?
    @Published var isLoading = false
    
    // we add the dependency to  that class
    let webservice : Webservice
    
    init(webservice: Webservice) {
        self.webservice = webservice
    }
    
    func populateProducts() async {
        isLoading = true
        errorMessage = nil
        
        do {
            let products = try await self.webservice.getProducts()
            // in the end so that every product should be assigned to its data sepaartly
            self.products = products.map(ProductViewModel.init)
        } catch {
            errorMessage = error.localizedDescription
            print("Error fetching products: \(error)")
        }
        
        isLoading = false
    }
    
}

// so that the data should  be on the reprensentable form

struct ProductViewModel  : Identifiable{
    private var product : Product
    
    init(product: Product) {
        self.product = product
    }
    
    var id : Int {
        return self.product.id
    }
    
    var title : String {
        return self.product.title
    }
    
    var price : Double {
        return self.product.price
    }
    
}
