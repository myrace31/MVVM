//
//  Tax.swift
//  Created on May 16, 2019

import Foundation


class Tax : NSObject, NSCoding{

    var name : String!
    var value : Float!


    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        name = dictionary["name"] as? String
        value = dictionary["value"] as? Float
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if name != nil{
            dictionary["name"] = name
        }
        if value != nil{
            dictionary["value"] = value
        }
        return dictionary
    }

    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        name = aDecoder.decodeObject(forKey: "name") as? String
        value = aDecoder.decodeObject(forKey: "value") as? Float
    }

    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if name != nil{
            aCoder.encode(name, forKey: "name")
        }
        if value != nil{
            aCoder.encode(value, forKey: "value")
        }
    }
}
