//
//  HomeViewModel.swift
//  NeoStore
//
//  Created by neosoft on 10/02/22.
//

import Foundation

enum HomeResult{
    case success
    case failure
    case none
}

protocol HomeViewModelType {
    var homeStatus: ReactiveListener<HomeResult>{get set}
    func getHomeDetail()
}

class HomeViewModel: HomeViewModelType{
    var homeStatus: ReactiveListener<HomeResult> = ReactiveListener(.none)
    
    func getHomeDetail() {
        print("Home View Model")
    }
    
    
}
