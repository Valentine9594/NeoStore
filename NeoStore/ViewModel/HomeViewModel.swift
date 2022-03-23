//
//  HomeViewModel.swift
//  NeoStore
//
//  Created by neosoft on 10/02/22.
//

import Foundation

enum HomeResult{
    case success
    case failure(error: Error)
    case none
}

protocol HomeViewModelType {
    var homeStatus: ReactiveListener<HomeResult>{get set}
    func getHomeDetail()
    func getNumberOfTotalCarts() -> Int
}

class HomeViewModel: HomeViewModelType{
    var numberOfCarts = 0
    var homeStatus: ReactiveListener<HomeResult> = ReactiveListener(.none)
    
    func getHomeDetail() {
        UserService.fetchUserAccountDetails { response in
            switch response{
                case .success(let data):
                    if data.status == 200{
                        guard let response = data.data else{return}
                        guard let userCarts = response.totalCarts else{return}
                        self.numberOfCarts = userCarts
                        self.homeStatus.value = .success
                    }
                case .failure(let error):
                    self.homeStatus.value = .failure(error: error)
            }
        }
    }
    
    func getNumberOfTotalCarts() -> Int {
        return numberOfCarts
    }
    
    
}
