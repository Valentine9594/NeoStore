//
//  ProductListingViewModel.swift
//  NeoStore
//
//  Created by neosoft on 21/02/22.
//

import Foundation

protocol ProductListingViewModelType {
    var tableShouldReload: ReactiveListener<Bool>{get set}
    func fetchProductData(productCategoryId: Int)
    
    func totalNumberOfRows() -> Int
    func getItemAtIndex(index: Int) -> ProductData
    
    func convertStringURLToImage(urlString: String) -> Data?
}

class ProductListingViewModel: ProductListingViewModelType{
    var tableShouldReload: ReactiveListener<Bool> = ReactiveListener(true)
    
    var productList = [ProductData]()
    
    func totalNumberOfRows() -> Int {
        return productList.count
    }
    
    func getItemAtIndex(index: Int) -> ProductData {
        return productList[index]
    }
    
    func fetchProductData(productCategoryId: Int) {
        ProductService.getProductListing(productCateoryId: productCategoryId){ (response) in
            switch response{
                case .success(let data):
                    if data.status == 200{
                        self.productList += data.data
                        self.tableShouldReload.value = true
                    }
                    
                case .failure(let error):
                    debugPrint(error.localizedDescription)
                    self.tableShouldReload.value = false
            }
        }
        debugPrint("Product Listing View Model.")
    }
    
    func convertStringURLToImage(urlString: String) -> Data?{
        guard let url = URL(string: urlString) else{ return nil}
        var imageData: Data? = nil
        debugPrint("String to ImageData 1")
        
        self.getDataFromSession(url: url) { data, response, error in
            guard let data = data, error == nil else{ return }
            debugPrint("String to ImageData 2")
            imageData = data
        }
        
        debugPrint("String to ImageData 3")
        return imageData
    }
    
    private func getDataFromSession(url: URL, completion: @escaping(Data?, URLResponse?, Error?) -> ()){
        URLSession.shared.dataTask(with: url) {(data, response, error) in
        }.resume()
    }

    
}
