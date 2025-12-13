//
//  CDEmployee+CoreDataProperties.swift
//  coreDataDemo
//
//  Created by Akanksha on 13.09.2025.
//
//

import Foundation
import CoreData


extension CDEmployee {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDEmployee> {
        return NSFetchRequest<CDEmployee>(entityName: "CDEmployee")
    }

    @NSManaged public var name: String?
    @NSManaged public var email: String?
    @NSManaged public var id: UUID?
    @NSManaged public var profilePic: Data?
    
    
    func convertToEmployee() -> Employee {
        return Employee(name: name!, email: email!, profilePicture: profilePic, id: id!)
    }

}

extension CDEmployee : Identifiable {

}
