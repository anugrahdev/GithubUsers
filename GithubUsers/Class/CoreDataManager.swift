//
//  CoreDataManager.swift
//  GithubUsers
//
//  Created by Anang Nugraha on 18/09/22.
//

import Foundation
import CoreData
 
class CoreDataManager {
    
    let persistentContainer: NSPersistentContainer
    static let shared = CoreDataManager()
    
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    func getAllFavoriteUsers() -> [FavoriteUser] {
        let request: NSFetchRequest<FavoriteUser> = FavoriteUser.fetchRequest()
        
        do {
            return try viewContext.fetch(request)
        } catch {
            return []
        }
    }

    
    func getFavoriteById(id: NSManagedObjectID) -> FavoriteUser? {
        do {
            return try viewContext.existingObject(with: id) as? FavoriteUser
        } catch {
            return nil
        }
    }
    
    func removeFromFavorite(user: FavoriteUser) {
        let user = getFavoriteById(id: user.objectID)
        if let user = user {
            viewContext.delete(user)
            save()
        }
    }
    
    func isUsersAlreadySaved(username: String) -> Bool {
        let request: NSFetchRequest<FavoriteUser> = FavoriteUser.fetchRequest()
        request.predicate = NSPredicate(format: "username == %@", "\(username)")
        do {
            let count = try viewContext.count(for: request) - 1
            return count > 0
        } catch {
            return false
        }
    }
    
    func save() {
        do {
            try viewContext.save()
        } catch {
            viewContext.rollback()
            print(error.localizedDescription)
        }
    }
    
    private init() {
        persistentContainer = NSPersistentContainer(name: "GithubUsers")
        persistentContainer.loadPersistentStores { desc, error in
            if let error = error {
                fatalError("unable to initialize Core Data Stack \(error)")
            }
        }
    }
    
}
