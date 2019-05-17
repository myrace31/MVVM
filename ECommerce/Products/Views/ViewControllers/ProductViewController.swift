//
//  ViewController.swift
//  Assignment
//
//  Created by prabhakar patil on 01/08/18.
//  Copyright © 2018 Prabhakar. All rights reserved.
//

import UIKit
import Floaty

protocol PrototypeCellReuseIdentifier {
    static var reusableCellIdentifier : String{ get }
}

protocol FilterProductsByRankingDelegates {
    func filterNewProducts(selectedFilterIndex: Int)
}

class ProductViewController: UIViewController, PrototypeCellReuseIdentifier, FloatyDelegate {
   
    var categoryListViewModel: ProductListViewModel!
    var productLists : [Product]!
    var filterProductLists : [Product]!
    var selectedINDEX: Int = 0
    var fab = Floaty()
    
    var filteredDelegate: FilterProductsByRankingDelegates?
    
    static var reusableCellIdentifier: String { get {return "ProductCell"} }
    
    @IBOutlet private var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
        layoutFAB()
    }
    
    
    func layoutFAB() {
        
        fab.addItem("Most Viewed Products", icon: UIImage(named: "icon_view")) { item in
            self.fab.close()
            self.filteredDelegate?.filterNewProducts(selectedFilterIndex: 0)
        }
        fab.addItem("Most OrdeRed Products", icon: UIImage(named: "tracking")) { item in
            self.fab.close()
            self.filteredDelegate?.filterNewProducts(selectedFilterIndex: 1)
        }
        fab.addItem("Most ShaRed Products", icon: UIImage(named: "share")){ item in
            self.fab.close()
            self.filteredDelegate?.filterNewProducts(selectedFilterIndex: 2)
        }
        fab.sticky = true
        fab.paddingX = self.view.frame.width/6 - fab.frame.width/2
        fab.fabDelegate = self
        self.view.addSubview(fab)
    }

    // MARK: - Floaty Delegate Methods
    func floatyWillOpen(_ floaty: Floaty) { }
    
    func floatyDidOpen(_ floaty: Floaty) { }
    
    func floatyWillClose(_ floaty: Floaty) { }
    
    func floatyDidClose(_ floaty: Floaty) { }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}


// MARK: - UITableViewDataSource
extension ProductViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.productLists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProductViewController.reusableCellIdentifier, for: indexPath) as! ProductTableViewCell
        
        cell.productTitleLabel.text = self.productLists[indexPath.row].name
        cell.productPriceLabel.text = "Price:- ₹\(self.productLists[indexPath.row].variants[0].price ?? 0)"
        if self.productLists[indexPath.row].variants[0].size != nil {
            cell.productSizeLabel.text = "Size:- \(self.productLists[indexPath.row].variants[0].size ?? 0)"
        }else {
            cell.productSizeLabel.isHidden = true
        }
        
        return cell
    }
}


// MARK: - UITableViewDelegate
extension ProductViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}


// MARK: - UITableViewDataSourcePrefetching
extension ProductViewController: UITableViewDataSourcePrefetching {
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        self.categoryListViewModel.populateProducts()
    }
}

