//
//  Ranking.swift
//  Created on May 16, 2019

import Foundation


class Ranking : NSObject, NSCoding{

    var products : [RankingProduct]!
    var ranking : String!


    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        ranking = dictionary["ranking"] as? String
        products = [RankingProduct]()
        if let productsArray = dictionary["products"] as? [[String:Any]]{
            for dic in productsArray{
                let value = RankingProduct(fromDictionary: dic)
                products.append(value)
            }
        }
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if ranking != nil{
            dictionary["ranking"] = ranking
        }
        if products != nil{
            var dictionaryElements = [[String:Any]]()
            for productsElement in products {
                dictionaryElements.append(productsElement.toDictionary())
            }
            dictionary["products"] = dictionaryElements
        }
        return dictionary
    }

    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        products = aDecoder.decodeObject(forKey: "products") as? [RankingProduct]
        ranking = aDecoder.decodeObject(forKey: "ranking") as? String
    }

    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if products != nil{
            aCoder.encode(products, forKey: "products")
        }
        if ranking != nil{
            aCoder.encode(ranking, forKey: "ranking")
        }
    }
}
