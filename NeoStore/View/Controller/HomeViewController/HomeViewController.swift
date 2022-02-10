//
//  HomeViewController.swift
//  NeoStore
//
//  Created by neosoft on 10/02/22.
//

import UIKit

enum TotalCollectionViewsCell: String{
    case slideShow = "SlideShow"
}

class HomeViewController: UIViewController {
    @IBOutlet weak var slideShowCollectionView: UICollectionView!
    var viewModel: HomeViewModelType!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        DispatchQueue.main.async {
            self.setupSlideShow()
            
        }
    }
    
    init(viewModel: HomeViewModelType){
        self.viewModel = viewModel
        super.init(nibName: TotalViewControllers.HomeViewController.rawValue, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupSlideShow(){
        let slideShowCell = UINib(nibName: "SlideShowCollectionViewCell", bundle: nil)
        self.slideShowCollectionView.register(slideShowCell, forCellWithReuseIdentifier: TotalCollectionViewsCell.slideShow.rawValue)
        
    }

    

}
