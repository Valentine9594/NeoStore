//
//  ProductListingViewModel.swift
//  NeoStore
//
//  Created by neosoft on 21/02/22.
//

import Foundation
import RealmSwift
import Network

protocol ProductListingViewModelType {
    var tableShouldReload: ReactiveListener<Bool>{get set}
    func checkBeforeFetch(productCategoryId: Int, productsLimit: Int, productsPageNumber: Int)
    func fetchProductData(productCategoryId: Int, productsLimit: Int, productsPageNumber: Int)
    func totalNumberOfRows() -> Int
    func getItemAtIndex(index: Int) -> ProductData
}

class ProductListingViewModel: ProductListingViewModelType{
    var tableShouldReload: ReactiveListener<Bool> = ReactiveListener(true)
    var currentPage = 0
    var productList = [ProductData]()
    private var realmDatabase: RealmDBProvider?
    var monitor: NetworkMonitor?
    
    init() {
        monitor = NetworkMonitor()
        self.realmDatabase = RealmDBProvider()
//        self.realmDatabase?.deleteAll()
        monitor?.startMonitoring()
    }
    
    func totalNumberOfRows() -> Int {
        return productList.count
    }
    
    func getItemAtIndex(index: Int) -> ProductData {
        return productList[index]
    }
    
    func checkBeforeFetch(productCategoryId: Int, productsLimit: Int, productsPageNumber: Int){
        DispatchQueue.main.async {
            let isNetworkConnected = self.monitor?.isReachable ?? false
            if isNetworkConnected{
                self.monitor?.stopMonitoring()
                debugPrint("Fetching from API!")
                self.fetchProductData(productCategoryId: productCategoryId, productsLimit: productsLimit, productsPageNumber: productsPageNumber)
            }
            else{
                
                let savedFromRealmDatabase = self.realmDatabase?.realm.objects(ProductData.self)
                if let totalSaved = savedFromRealmDatabase, totalSaved.count > 0{
                    let ofCurrentProductCategoryId = Array(totalSaved)
                    self.productList = ofCurrentProductCategoryId.compactMap{
                        data in
                        if data.productCategoryId == productCategoryId{
                            return data
                        }
                        return nil
                    }
                }
                debugPrint("Fetching from Realm Database!")
                self.tableShouldReload.value = true
                }
                
            }
        
        }
    
    func fetchProductData(productCategoryId: Int, productsLimit: Int, productsPageNumber: Int) {
        guard currentPage + 1 == productsPageNumber else{ return }
        
        DispatchQueue.global(qos: .userInteractive).async {
            ProductService.getProductListing(productCategoryId: productCategoryId, productsLimit: productsLimit, productsPageNumber: productsPageNumber){ [weak self] (response) in
                switch response{
                    case .success(let data):
                        if data.status == 200{
                            self?.productList += data.data
//                            self?.realmQueue.async{
//                            let threadReference = ThreadSafeReference(to: data.data)
//                            guard let resolveIssue = realmDatabase?.realm.resolve(threadReference) else{ return }
//                                self?.realmDatabase?.save(data.data)
                            DispatchQueue.main.async {
                                try! self?.realmDatabase?.realm.write{
                                    self?.realmDatabase?.realm.add(data.data, update: .all)
                                }
                            }

//                            }
                            self?.currentPage += 1
                            self?.tableShouldReload.value = true
                        }
                        
                    case .failure(let error):
                        debugPrint(error.localizedDescription)
                        self?.tableShouldReload.value = false
                }
            }
        }

    }
            
    }
    

    
