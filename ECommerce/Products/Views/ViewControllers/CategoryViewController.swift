//
//  CategoryViewController.swift
//  ECommerce
//
//  Created by CodeNamaste on 16/05/19.
//  Copyright © 2019 CodeNamaste. All rights reserved.
//

import UIKit
import CarbonKit


class CategoryViewController: UIViewController, CarbonTabSwipeNavigationDelegate, FilterProductsByRankingDelegates {

    private var webService: Webservice!
    private var productListViewModel: ProductListViewModel!
    private var topItems = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webService = Webservice()
        productListViewModel = ProductListViewModel(webService: webService, completion: {
            
            // figure Out all the categories
            for i in 0 ..< self.productListViewModel.categoryViewModels.count {
                self.topItems.append(self.productListViewModel.categoryViewModels[i].categoryTitle)
            }
            
            //Mark:-
            self.ConfigureMenuView()
        })
    }
    
    func filterNewProducts(selectedFilterIndex: Int) {
        
        for filteredProduct in self.productListViewModel.rankingViewModels[selectedFilterIndex].productList {
            print(filteredProduct.id)
        }
    }
    
    //Mark:-
    func ConfigureMenuView() {
        let topMenuView = CarbonTabSwipeNavigation(items: topItems, delegate: self)
        topMenuView.setTabBarHeight(50)
        topMenuView.setIndicatorHeight(2.0)
        topMenuView.setTabExtraWidth(20)
        topMenuView.setIndicatorColor(UIColor.black)
        topMenuView.setNormalColor(UIColor.gray, font: UIFont(name: "Verdana", size: 16)!)
        topMenuView.setSelectedColor(UIColor.black, font:UIFont(name: "Verdana", size: 16)!)
        topMenuView.insert(intoRootViewController: self)
    }
    
    //Mark:- carbonTab Delegates
    func carbonTabSwipeNavigation(_ carbonTabSwipeNavigation: CarbonTabSwipeNavigation, viewControllerAt index: UInt) -> UIViewController {
        
        let viewVC = storyBoard_iPhone.instantiateViewController(withIdentifier: "productViewSegue") as! ProductViewController
        viewVC.productLists = self.productListViewModel.categoryViewModels[Int(index)].productList
        viewVC.categoryListViewModel = self.productListViewModel
        return viewVC
    }

}
