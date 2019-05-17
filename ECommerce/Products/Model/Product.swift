//
//  Product.swift
//  Created on May 16, 2019

import Foundation


class Product : NSObject, NSCoding{

    var dateAdded : String!
    var id : Int!
    var name : String!
    var tax : Tax!
    var variants : [Variant]!


    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        dateAdded = dictionary["date_added"] as? String
        id = dictionary["id"] as? Int
        name = dictionary["name"] as? String
        if let taxData = dictionary["tax"] as? [String:Any]{
            tax = Tax(fromDictionary: taxData)
        }
        variants = [Variant]()
        if let variantsArray = dictionary["variants"] as? [[String:Any]]{
            for dic in variantsArray{
                let value = Variant(fromDictionary: dic)
                variants.append(value)
            }
        }
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if dateAdded != nil{
            dictionary["date_added"] = dateAdded
        }
        if id != nil{
            dictionary["id"] = id
        }
        if name != nil{
            dictionary["name"] = name
        }
        if tax != nil{
            dictionary["tax"] = tax.toDictionary()
        }
        if variants != nil{
            var dictionaryElements = [[String:Any]]()
            for variantsElement in variants {
                dictionaryElements.append(variantsElement.toDictionary())
            }
            dictionary["variants"] = dictionaryElements
        }
        return dictionary
    }

    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        dateAdded = aDecoder.decodeObject(forKey: "date_added") as? String
        id = aDecoder.decodeObject(forKey: "id") as? Int
        name = aDecoder.decodeObject(forKey: "name") as? String
        tax = aDecoder.decodeObject(forKey: "tax") as? Tax
        variants = aDecoder.decodeObject(forKey: "variants") as? [Variant]
    }

    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if dateAdded != nil{
            aCoder.encode(dateAdded, forKey: "date_added")
        }
        if id != nil{
            aCoder.encode(id, forKey: "id")
        }
        if name != nil{
            aCoder.encode(name, forKey: "name")
        }
        if tax != nil{
            aCoder.encode(tax, forKey: "tax")
        }
        if variants != nil{
            aCoder.encode(variants, forKey: "variants")
        }
    }
}
