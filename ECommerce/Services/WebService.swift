//
//  WebService.swift
//  Assignment
//
//  Created by prabhakar patil on 01/08/18.
//  Copyright © 2018 Prabhakar. All rights reserved.
//

import Foundation

class Webservice {
    
    func loadProducts(RankingResponse: @escaping ([Ranking]) -> (), CategoryResponse: @escaping ([Category]) -> ()) {
        
        var allresponse = [ProductModel]()
        
        let productsURL = URL(string: PRODUCTS_URL)!
        let session = URLSession.shared
        let task = session.dataTask(with: productsURL) { data, response, error in
            print("Task completed")
            
            guard error == nil else {
                print("error while fetching the data: \(String(describing: error?.localizedDescription))")
                return
            }
            
            guard let fetchedData = data else {
                print("NO Data received for the specified URL")
                return
            }
            
            guard (try? JSONSerialization.jsonObject(with: fetchedData, options: JSONSerialization.ReadingOptions.allowFragments) as! [String: Any]) != nil else {
                
                print("Data error: \(fetchedData)")
                return
            }
            
            do {
                if let jsonResult = try JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary {
                    
                    allresponse = [ProductModel.init(fromDictionary: jsonResult as! [String : Any])]
                    
                    DispatchQueue.main.async {
                        RankingResponse(allresponse[0].rankings)
                        CategoryResponse(allresponse[0].categories)
                    }
                    
                    return
                    
                }
            } catch let parseError as NSError {
                print("JSON Error \(parseError.localizedDescription)")
            }
        }
        
        task.resume()
    }
}
