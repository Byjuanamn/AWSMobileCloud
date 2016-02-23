//
//  helpers.swift
//  MyVideoBlog
//


import Foundation



// MARK: - Esta funcion nos permite generar la url para guardar en el directorio documents un blob

func saveInDocuments(data : NSData) -> NSURL {
    
    let documents = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
    let writePath = documents.stringByAppendingString("/videotemp.mov")
    
    let array = NSArray(contentsOfFile: writePath) as? [String]
    
    if array == nil {
        
        data.writeToFile(writePath, atomically: true)
        
        
    }
    
    return (NSURL(fileURLWithPath: writePath))
}
