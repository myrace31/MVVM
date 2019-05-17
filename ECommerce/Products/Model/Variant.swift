//
//  Variant.swift
//  Created on May 16, 2019

import Foundation


class Variant : NSObject, NSCoding{

    var color : String!
    var id : Int!
    var price : Int!
    var size : Int!


    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        color = dictionary["color"] as? String
        id = dictionary["id"] as? Int
        price = dictionary["price"] as? Int
        size = dictionary["size"] as? Int
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if color != nil{
            dictionary["color"] = color
        }
        if id != nil{
            dictionary["id"] = id
        }
        if price != nil{
            dictionary["price"] = price
        }
        if size != nil{
            dictionary["size"] = size
        }
        return dictionary
    }

    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        color = aDecoder.decodeObject(forKey: "color") as? String
        id = aDecoder.decodeObject(forKey: "id") as? Int
        price = aDecoder.decodeObject(forKey: "price") as? Int
        size = aDecoder.decodeObject(forKey: "size") as? Int
    }

    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if color != nil{
            aCoder.encode(color, forKey: "color")
        }
        if id != nil{
            aCoder.encode(id, forKey: "id")
        }
        if price != nil{
            aCoder.encode(price, forKey: "price")
        }
        if size != nil{
            aCoder.encode(size, forKey: "size")
        }
    }
}
