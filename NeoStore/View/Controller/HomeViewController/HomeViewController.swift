//
//  HomeViewController.swift
//  NeoStore
//
//  Created by neosoft on 10/02/22.
//

import UIKit
import SideMenu

class HomeViewController: UIViewController, SideMenuControllerDelegate {
    func didSelectMenuItem(menuItem: MenuItems) {
        dismiss(animated: appAnimation, completion: nil)
        let currentMenuItemViewController = currentMenuItemsViewController(menuItem: menuItem)
        self.navigationController?.pushViewController(currentMenuItemViewController, animated: appAnimation)
    }
    
    @IBOutlet weak var slideShowCollectionView: UICollectionView!
    @IBOutlet weak var productsTypeCollectionView: UICollectionView!
    @IBOutlet weak var slideShowPageControl: UIPageControl!
    @IBOutlet weak var customNavigationBar: CustomNavigationBar!
    var viewModel: HomeViewModelType!
    private var sideMenu: SideMenuNavigationController?
    private var timer: Timer!
    private var currentCellIndex = 0
    
    enum TotalCollectionViewsCell: String{
        case slideShow = "SlideShow"
        case productDisplay = "ProductDisplayType"
    }
    let slideShowImageArray: [String] = ["slider_img1", "slider_img2", "slider_img3", "slider_img4"]
    let productTypesImageArray: [String] = ["tableicon", "sofaicon", "chairsicon", "cupboardicon"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//            let appDelegate = UIApplication.shared.delegate as! AppDelegate
//            appDelegate.switchRootViewcontrollerToHome()
//            self.navigationController?.isNavigationBarHidden = false
            
        self.setupSlideShow()
        self.setupProductTypesDisplay()
        self.setupPageControl()
//        self.setupCustomNavigationBar()
        self.setupSideMenu()
        self.setupNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(appAnimation)
//            let appdelegate = UIApplication.shared.delegate as! AppDelegate
//            appdelegate.switchRootViewcontrollerToHome()
        NotificationCenter.default.addObserver(self, selector: #selector(slideToMenuBar), name: .didClickMenuButton, object: nil)
        self.timer = Timer.scheduledTimer(timeInterval: 2.5, target: self, selector: #selector(self.slideToNext), userInfo: nil, repeats: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: .didClickMenuButton, object: nil)
        self.timer.invalidate()
    }
    
    private func setupNavigationBar(){
//        function to setup navigation bar
        let navigationBar = self.navigationController?.navigationBar
        navigationBar?.barTintColor = .appRed
        navigationBar?.tintColor = UIColor.white
        navigationBar?.isTranslucent = appAnimation
        navigationBar?.barStyle = .black
        navigationBar?.titleTextAttributes = [.foregroundColor: UIColor.white, .font: UIFont(name: "iCiel Gotham Medium", size: 23.0)!]

        navigationItem.title = "Home"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: AppIcons.menu.description), style: .plain, target: self, action: #selector(slideToMenuBar))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: AppIcons.search.description), style: .plain, target: self, action: nil)

    }
    
    private func setupSideMenu(){
        let menu = SideMenuController(with: MenuItems.allCases)
        menu.delegate = self
        self.sideMenu = SideMenuNavigationController(rootViewController: menu)
        sideMenu?.leftSide = true
        SideMenuManager.default.leftMenuNavigationController = sideMenu
        SideMenuManager.default.addPanGestureToPresent(toView: view)
    }
    
    @objc func popToPreviousViewController(){
        self.navigationController?.popViewController(animated: appAnimation)
    }
    
    @objc func slideToMenuBar(){
        present(sideMenu!, animated: appAnimation)
    }
    
//    @objc func goToTemporaryMenuBar(){
////        let temporaryMenuBar = TemporaryMenuBarViewController()
////        navigationController?.pushViewController(temporaryMenuBar, animated: appAnimation)
//
//        present(sideMenu!, animated: appAnimation)
//    }
    
//    private func setupCustomNavigationBar(){
//        DispatchQueue.main.async {
////        setting status bar color
////        self.view.backgroundColor = UIColor.appRed
//
//        let navigationBarView = UINib(nibName: "CustomNavigationBar", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
//        navigationBarView.translatesAutoresizingMaskIntoConstraints = false
//        self.customNavigationBar.addSubview(navigationBarView)
//
//        navigationBarView.topAnchor.constraint(equalTo: self.customNavigationBar.topAnchor).isActive = true
//        navigationBarView.leadingAnchor.constraint(equalTo: self.customNavigationBar.leadingAnchor).isActive = true
//        navigationBarView.trailingAnchor.constraint(equalTo: self.customNavigationBar.trailingAnchor).isActive = true
//        navigationBarView.bottomAnchor.constraint(equalTo: self.customNavigationBar.bottomAnchor).isActive = true
//        }
//    }
    
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
//        setting the collectionview which performs slideshow
        let slideShowCell = UINib(nibName: "SlideShowCollectionViewCell", bundle: nil)
        self.slideShowCollectionView.register(slideShowCell, forCellWithReuseIdentifier: TotalCollectionViewsCell.slideShow.rawValue)
        self.slideShowCollectionView.dataSource = self
        self.slideShowCollectionView.delegate = self
        self.slideShowCollectionView.isScrollEnabled = true
    }
    
    private func setupPageControl(){
//        setting the page control and indicator with slideshow
        self.slideShowPageControl.numberOfPages = self.slideShowImageArray.count
        self.slideShowPageControl.pageIndicatorTintColor = UIColor.appRed
        self.slideShowPageControl.currentPageIndicatorTintColor = UIColor.appGrey
        self.slideShowPageControl.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
//        FOR WHITE BORDER
//        for (_, dot) in slideShowPageControl.subviews.enumerated(){
//            dot.layer.borderWidth = 1
//            dot.layer.borderColor = UIColor.white.cgColor
//            dot.layer.cornerRadius = dot.frame.size.height / 2
//        }
    }
    
    private func setupProductTypesDisplay(){
        
        let productDisplayCell = UINib(nibName: "HomeProductsTypeDisplayCollectionViewCell", bundle: nil)
        self.productsTypeCollectionView.register(productDisplayCell, forCellWithReuseIdentifier: TotalCollectionViewsCell.productDisplay.rawValue)
        self.productsTypeCollectionView.dataSource = self
        self.productsTypeCollectionView.delegate = self
        self.productsTypeCollectionView.isScrollEnabled = false
        self.productsTypeCollectionView.backgroundColor = UIColor.white
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}



extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.slideShowCollectionView{
            return slideShowImageArray.count
        }
        else{
            return 4
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            if collectionView == self.slideShowCollectionView{
                let slideShowcell = collectionView.dequeueReusableCell(withReuseIdentifier: TotalCollectionViewsCell.slideShow.rawValue, for: indexPath) as! SlideShowCollectionViewCell
                let imageName = slideShowImageArray[indexPath.item]
                if let slideShowImage = UIImage(named: imageName){
                    slideShowcell.slideShowImageView.image = slideShowImage
                }
                return slideShowcell
            }
            else{
                let productDisplaycell = collectionView.dequeueReusableCell(withReuseIdentifier: TotalCollectionViewsCell.productDisplay.rawValue, for: indexPath) as! HomeProductsTypeDisplayCollectionViewCell
                let imageName = productTypesImageArray[indexPath.item]
                if let productTypeImage = UIImage(named: imageName){
                    productDisplaycell.productTypeImageView.image = productTypeImage
                }
                return productDisplaycell
            }

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.slideShowCollectionView{
            return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
        }
        else{
            let cellWidth = (collectionView.frame.size.width - 12)/2
            return CGSize(width: cellWidth, height: cellWidth)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if self.productsTypeCollectionView == collectionView{
            return 12
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        if self.productsTypeCollectionView == collectionView{
            return 12
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if collectionView == self.slideShowCollectionView{
            self.currentCellIndex = indexPath.item
            self.slideShowPageControl.currentPage = self.currentCellIndex
        }

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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.productsTypeCollectionView{
            let itemSelected = indexPath.item
            var productCategory: ProductCategory!
            
            switch itemSelected {
                case 0:
                    productCategory = .tables
                case 1:
                    productCategory = .sofas
                case 2:
                    productCategory = .chairs
                case 3:
                    productCategory = .cupboards
                default:
                    productCategory = .tables
            }
            
            let produtListingViewModel = ProductListingViewModel()
            let productListingViewController = ProductListingViewController(viewModel: produtListingViewModel)
            productListingViewController.productCategory = productCategory
            self.navigationController?.pushViewController(productListingViewController, animated: appAnimation)
            
        }
    }
    
}
