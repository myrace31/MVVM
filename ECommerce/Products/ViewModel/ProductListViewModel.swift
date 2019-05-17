//
//  ProductListViewModel.swift
//  ECommerce
//
//  Created by CodeNamaste on 16/05/19.
//  Copyright © 2019 CodeNamaste. All rights reserved.
//

import Foundation

class ProductListViewModel {
    
    var rankingViewModels: [RankingViewModel] = [RankingViewModel]()
    var categoryViewModels: [CategoryViewModel] = [CategoryViewModel]()
   
    private var webService: Webservice
    private var completion: ()->() = {  }

    init(webService: Webservice, completion: @escaping () -> ()) {
        self.webService = webService
        self.completion = completion
        populateProducts()
    }

    func populateProducts() {

        webService.loadProducts(RankingResponse: { (rankings) in
           
            if self.rankingViewModels.isEmpty {
                self.rankingViewModels = rankings.map(RankingViewModel.init)
            } else {
                for ranking in rankings {
                    self.rankingViewModels.append(RankingViewModel.init(ranking))
                }
            }
            
        }, CategoryResponse: { (categorys) in
            if self.categoryViewModels.isEmpty {
                self.categoryViewModels = categorys.map(CategoryViewModel.init)
            } else {
                for category in categorys {
                    self.categoryViewModels.append(CategoryViewModel.init(category))
                }
            }
            
            self.completion()
        })
    }

    func rankingAt(index: Int) -> RankingViewModel {
        return self.rankingViewModels[index]
    }
    
    func productAtCategory(index: Int) -> [Product] {
        return self.categoryViewModels[index].productList
    }
    
}

class RankingViewModel {
    
    var rankingTitle: String!
    var productList : [RankingProduct]!
    
    init(_ ranking: Ranking) {
        self.rankingTitle = ranking.ranking
        self.productList = ranking.products
    }
}

class CategoryViewModel {
    
    var categoryTitle: String!
    var productList : [Product]!
    
    init(_ category: Category) {
        self.categoryTitle = category.name
        self.productList = category.products
    }
    
    func productAt(index: Int) -> Product {
        return self.productList[index]
    }
}
