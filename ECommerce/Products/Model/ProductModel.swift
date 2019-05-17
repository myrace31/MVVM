
//  ProductModel.swift

import Foundation


class ProductModel : NSObject, NSCoding{

    var categories : [Category]!
    var rankings : [Ranking]!


    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        
        categories = [Category]()
        if let categoriesArray = dictionary["categories"] as? [[String:Any]]{
            for dic in categoriesArray{
                let value = Category(fromDictionary: dic)
                categories.append(value)
            }
        }
        
        rankings = [Ranking]()
        if let rankingsArray = dictionary["rankings"] as? [[String:Any]]{
            for dic in rankingsArray{
                let value = Ranking(fromDictionary: dic)
                rankings.append(value)
            }
        }
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if categories != nil{
            var dictionaryElements = [[String:Any]]()
            for categoriesElement in categories {
                dictionaryElements.append(categoriesElement.toDictionary())
            }
            dictionary["categories"] = dictionaryElements
        }
        if rankings != nil{
            var dictionaryElements = [[String:Any]]()
            for rankingsElement in rankings {
                dictionaryElements.append(rankingsElement.toDictionary())
            }
            dictionary["rankings"] = dictionaryElements
        }
        return dictionary
    }

    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        categories = aDecoder.decodeObject(forKey: "categories") as? [Category]
        rankings = aDecoder.decodeObject(forKey: "rankings") as? [Ranking]
    }

    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if categories != nil{
            aCoder.encode(categories, forKey: "categories")
        }
        if rankings != nil{
            aCoder.encode(rankings, forKey: "rankings")
        }
    }
}
