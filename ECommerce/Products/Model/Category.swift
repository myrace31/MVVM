//
//  Category.swift
//  Created on May 16, 2019

import Foundation

class Category : NSObject, NSCoding{

    var id : Int!
    var name : String!
    var products : [Product]!


    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        id = dictionary["id"] as? Int
        name = dictionary["name"] as? String
        products = [Product]()
        if let productsArray = dictionary["products"] as? [[String:Any]]{
            for dic in productsArray{
                let value = Product(fromDictionary: dic)
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
        if id != nil{
            dictionary["id"] = id
        }
        if name != nil{
            dictionary["name"] = name
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
        id = aDecoder.decodeObject(forKey: "id") as? Int
        name = aDecoder.decodeObject(forKey: "name") as? String
        products = aDecoder.decodeObject(forKey: "products") as? [Product]
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if id != nil{
            aCoder.encode(id, forKey: "id")
        }
        if name != nil{
            aCoder.encode(name, forKey: "name")
        }
        if products != nil{
            aCoder.encode(products, forKey: "products")
        }
    }
}
