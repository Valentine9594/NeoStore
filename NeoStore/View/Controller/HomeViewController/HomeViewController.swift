//
//  HomeViewController.swift
//  NeoStore
//
//  Created by neosoft on 10/02/22.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var slideShowCollectionView: UICollectionView!
    @IBOutlet weak var productsTypeCollectionView: UICollectionView!
    @IBOutlet weak var slideShowPageControl: UIPageControl!
    var viewModel: HomeViewModelType!
    private var timer: Timer!
    private var currentCellIndex = 0
    
    enum TotalCollectionViewsCell: String{
        case slideShow = "SlideShow"
    }
    var slideShowImageArray: [String] = ["slider_img1", "slider_img2", "slider_img3", "slider_img4"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        DispatchQueue.main.async {
            self.setupSlideShow()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(appAnimation)
        DispatchQueue.main.async {
            self.timer = Timer.scheduledTimer(timeInterval: 3.2, target: self, selector: #selector(self.slideToNext), userInfo: nil, repeats: true)
        }
    }
    
    @objc func slideToNext(){
//        function to manage slideshow
        if self.currentCellIndex < self.slideShowImageArray.count-1{
            currentCellIndex += 1
        }
        else{
            self.currentCellIndex = 0
        }
        
        let indexPath = IndexPath(item: currentCellIndex, section: 0)
        self.slideShowCollectionView.layoutIfNeeded()
        self.slideShowCollectionView.scrollToItem(at: indexPath, at: .left, animated: appAnimation)
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
        self.slideShowCollectionView.dataSource = self
        self.slideShowCollectionView.delegate = self
        self.slideShowCollectionView.isScrollEnabled = true
    }


}



extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.slideShowCollectionView{
            return slideShowImageArray.count
        }
        else{
            return 0
        }

    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            if collectionView == self.slideShowCollectionView{
                let slideShowcell = collectionView.dequeueReusableCell(withReuseIdentifier: TotalCollectionViewsCell.slideShow.rawValue, for: indexPath) as! SlideShowCollectionViewCell
                let imageName = slideShowImageArray[indexPath.row]
                slideShowcell.slideShowImageView.image = UIImage(named: imageName)

                return slideShowcell
            }
            else{
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TotalCollectionViewsCell.slideShow.rawValue, for: indexPath)
                
                return cell
            }

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.slideShowCollectionView{
            return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
        }
        else{
            return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        self.currentCellIndex = indexPath.item
        self.slideShowPageControl.currentPage = self.currentCellIndex
    }
    
//    NEED TO CHECK DIRECTION OF SCROLLING !!!
//    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
////        if scroll view detects draggin on slideshow it will check cell index
//        if self.currentCellIndex == 0{
////            if cell index is first then go to last
//
//        }
//        else if self.currentCellIndex == self.slideShowImageArray.count-1{
////            if cell index is last then go to first
//            self.slideToNext()
//        }
//    }
    
}
