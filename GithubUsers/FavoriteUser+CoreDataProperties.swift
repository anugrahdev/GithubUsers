//
//  FavoriteUser+CoreDataProperties.swift
//  
//
//  Created by Anang Nugraha on 18/09/22.
//
//

import Foundation
import CoreData


extension FavoriteUser {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavoriteUser> {
        return NSFetchRequest<FavoriteUser>(entityName: "FavoriteUser")
    }

    @NSManaged public var username: String?
    @NSManaged public var avatarUrl: String?
    @NSManaged public var url: String?

}
