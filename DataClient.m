//
//  DataClient.m
//  Timeline
//
//  Created by yongry on 12-10-30.
//  Copyright (c) 2012年 Sun Yat-sen University. All rights reserved.
//

#import "DataClient.h"


@implementation DataClient

@synthesize managedObjectContext = __managedObjectContext;
@synthesize managedObjectModel = __managedObjectModel;
@synthesize persistentStoreCoordinator = __persistentStoreCoordinator;
@synthesize personInfoFetchedResultsController = _personInfoFetchedResultsController;
@synthesize friendListFetchedResultsController = _friendListFetchedResultsController;
@synthesize personWeiboFetchedResultsController = _personWeiboFetchedResultsController;
@synthesize friendWeiboFetchedResultsController = _friendWeiboFetchedResultsController;
//test :@synthesize testFetchedResultsController = _testFetchedResultsController;

+ (DataClient *)shareClient
{
    static DataClient* shareClient;
    if (!shareClient) {
        shareClient = [[DataClient alloc] init];
    }
    return shareClient;
}

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        } 
    }
}

- (void) deleteItem:(NSIndexPath *)indexPath withController:(NSFetchedResultsController *)controller
{
   NSManagedObjectContext *context = [controller managedObjectContext];
   [context deleteObject:[controller objectAtIndexPath:indexPath]];
   NSError *error = nil;if (![context save:&error]) {    
       NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
       abort();
   }
}

#pragma mark - Fetched results controller

- (NSFetchedResultsController *)personWeiboFetchedResultsController
{
    if (_personWeiboFetchedResultsController != nil) {
        return _personWeiboFetchedResultsController;
    }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    // Edit the entity name as appropriate.
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"PersonWeibo" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    // Set the batch size to a suitable number.
    [fetchRequest setFetchBatchSize:200];
    
    // Edit the sort key as appropriate.
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"create_at" ascending:NO];
    NSArray *sortDescriptors = [NSArray arrayWithObjects:sortDescriptor, nil];
    
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:@"PersonWeibo"];
    aFetchedResultsController.delegate = self;
    self.personWeiboFetchedResultsController = aFetchedResultsController;
    
    NSError *error = nil;
    
    
    NSError *fetchError;
	if (![self.personWeiboFetchedResultsController performFetch:&fetchError]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
	    NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
	    abort();
	}
    
    return _personWeiboFetchedResultsController;
}  

#pragma mark - Fetched results controller

- (NSFetchedResultsController *)personDataFetchedResultsController
{
    if (_personInfoFetchedResultsController != nil) {
        return _personInfoFetchedResultsController;
    }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    // Edit the entity name as appropriate.
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"PersonInfo" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    // Set the batch size to a suitable number.
    [fetchRequest setFetchBatchSize:200];
    
    // Edit the sort key as appropriate.
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:NO];
    NSArray *sortDescriptors = [NSArray arrayWithObjects:sortDescriptor, nil];
    
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:@"PersonInfo"];
    aFetchedResultsController.delegate = self;
    self.personInfoFetchedResultsController = aFetchedResultsController;
    
    NSError *error = nil;
    
    
    NSError *fetchError;
	if (![self.personInfoFetchedResultsController performFetch:&fetchError]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
	    NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
	    abort();
	}
    
    return _personInfoFetchedResultsController;
}  
#pragma mark - Fetched results controller

- (NSFetchedResultsController *)friendWeiboFetchedResultsController
{
    if (_friendWeiboFetchedResultsController != nil) {
        return _friendWeiboFetchedResultsController;
    }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    // Edit the entity name as appropriate.
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"FriendWeibo" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    // Set the batch size to a suitable number.
    [fetchRequest setFetchBatchSize:200];
    
    // Edit the sort key as appropriate.
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"create_at" ascending:NO];
    NSArray *sortDescriptors = [NSArray arrayWithObjects:sortDescriptor, nil];
    
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    aFetchedResultsController.delegate = self;
    self.friendWeiboFetchedResultsController = aFetchedResultsController;
    
    NSError *error = nil;
    
    
    NSError *fetchError;
	if (![self.friendWeiboFetchedResultsController performFetch:&fetchError]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
	    NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
	    abort();
	}
    
    return _friendWeiboFetchedResultsController;
}  
#pragma mark - Fetched results controller

- (NSFetchedResultsController *)friendListFetchedResultsController
{
    if (_friendListFetchedResultsController != nil) {
        return _friendListFetchedResultsController;
    }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    // Edit the entity name as appropriate.
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"FriendList" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    // Set the batch size to a suitable number.
    [fetchRequest setFetchBatchSize:200];
    
    // Edit the sort key as appropriate.
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:NO];
    NSArray *sortDescriptors = [NSArray arrayWithObjects:sortDescriptor, nil];
    
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    aFetchedResultsController.delegate = self;
    self.friendListFetchedResultsController = aFetchedResultsController;
    
    NSError *error = nil;
    
    
    NSError *fetchError;
	if (![self.friendListFetchedResultsController performFetch:&fetchError]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
	    NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
	    abort();
	}
    
    return _friendListFetchedResultsController;
}  

/* test controller
- (NSFetchedResultsController *)testFetchedResultsController
{
    if (_testFetchedResultsController != nil) {
        return _testFetchedResultsController;
    }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    // Edit the entity name as appropriate.
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Test" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    // Set the batch size to a suitable number.
    [fetchRequest setFetchBatchSize:200];
    
    // Edit the sort key as appropriate.
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"time" ascending:NO];
    NSArray *sortDescriptors = [NSArray arrayWithObjects:sortDescriptor, nil];
    
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    aFetchedResultsController.delegate = self;
    self.testFetchedResultsController = aFetchedResultsController;
    
    NSError *error = nil;
    
    
    NSError *fetchError;
	if (![self.testFetchedResultsController performFetch:&fetchError]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
	    NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
	    abort();
	}
    
    return _testFetchedResultsController;
}  
*/

#pragma mark - Core Data stack

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext
{
    if (__managedObjectContext != nil) {
        return __managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        __managedObjectContext = [[NSManagedObjectContext alloc] init];
        [__managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return __managedObjectContext;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel
{
    if (__managedObjectModel != nil) {
        return __managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"WeiboModel" withExtension:@"momd"];
    __managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return __managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (__persistentStoreCoordinator != nil) {
        return __persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"Timeline.sqlite"];
    
    NSError *error = nil;
    __persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![__persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter: 
         [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption, [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        //abort();
    }    
    
    return __persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (void)addItem:(NSDictionary *)dic withType:(int)type
{
     NSError *error = nil;
    if(dic != nil)
    {
        switch(type){
           case 1:
            {
                NSManagedObjectContext *context = [self.personInfoFetchedResultsController managedObjectContext];
                NSEntityDescription *entity = [[self.personInfoFetchedResultsController fetchRequest] entity];
                NSManagedObject *newManagedObject = [NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:context];

               [newManagedObject setValue:[dic valueForKey:@"gender"] forKey:@"gender"];
               [newManagedObject setValue:[dic valueForKey:@"id"] forKey:@"id"];
               [newManagedObject setValue:[dic valueForKey:@"idstr"] forKey:@"idstr"];
               [newManagedObject setValue:[dic valueForKey:@"location"] forKey:@"location"];
               [newManagedObject setValue:[dic valueForKey:@"name"] forKey:@"name"]; 
               [newManagedObject setValue:[dic valueForKey:@"profile_image_url"] forKey:@"profile_image_url"];
               [newManagedObject setValue:[dic valueForKey:@"screen_namee"] forKey:@"screen_name"];
               [newManagedObject setValue:[dic valueForKey:@"uDescription"] forKey:@"description"]; 
               [newManagedObject setValue:[dic valueForKey:@"url"] forKey:@"url"]; 
               // Save the context.

              if (![context save:&error]){
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
                 NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
                 abort();
                 }
        break;
            }
                
            case 2:
            {
                NSManagedObjectContext *context = [self.personWeiboFetchedResultsController managedObjectContext];
                NSEntityDescription *entity = [[self.personWeiboFetchedResultsController fetchRequest] entity];
                NSManagedObject *newManagedObject = [NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:context];
                
                [newManagedObject setValue:[dic valueForKey:@"bmiddle_pic"] forKey:@"bmiddle_pic"];
                [newManagedObject setValue:[dic valueForKey:@"comments_count"] forKey:@"comments_count"];
                [newManagedObject setValue:[dic valueForKey:@"created_at"] forKey:@"created_at"];
                [newManagedObject setValue:[dic valueForKey:@"geo"] forKey:@"geo"];
                [newManagedObject setValue:[dic valueForKey:@"id"] forKey:@"id"]; 
                [newManagedObject setValue:[dic valueForKey:@"idstr"] forKey:@"idstr"];
                [newManagedObject setValue:[dic valueForKey:@"in_reply_to_screen_name"] forKey:@"in_reply_to_screen_name"];
                [newManagedObject setValue:[dic valueForKey:@"in_reply_to_status_id"] forKey:@"in_reply_to_status_id"]; 
                [newManagedObject setValue:[dic valueForKey:@"in_reply_to_user_id"] forKey:@"in_reply_to_user_id"]; 
                [newManagedObject setValue:[dic valueForKey:@"mid"] forKey:@"mid"]; [newManagedObject setValue:[dic valueForKey:@"original_pic"] forKey:@"original_pic"]; 
                [newManagedObject setValue:[dic valueForKey:@"reposts_count"] forKey:@"reposts_count"]; 
                [newManagedObject setValue:[dic valueForKey:@"source"] forKey:@"source"]; 
                [newManagedObject setValue:[dic valueForKey:@"text"] forKey:@"text"]; 
                [newManagedObject setValue:[dic valueForKey:@"thumbnail_pic"] forKey:@"thumbnail_pic"]; 
                [newManagedObject setValue:[dic valueForKey:@"user"] forKey:@"user"]; 
                
                
                // Save the context.
               
                if (![context save:&error]){
                    // Replace this implementation with code to handle the error appropriately.
                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
                    NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
                    abort();
                }
                break;
            }

            case 3:
            {
                NSManagedObjectContext *context = [self.friendWeiboFetchedResultsController managedObjectContext];
                NSEntityDescription *entity = [[self.friendWeiboFetchedResultsController fetchRequest] entity];
                NSManagedObject *newManagedObject = [NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:context];
                
                [newManagedObject setValue:[dic valueForKey:@"bmiddle_pic"] forKey:@"bmiddle_pic"];
                [newManagedObject setValue:[dic valueForKey:@"comments_count"] forKey:@"comments_count"];
                [newManagedObject setValue:[dic valueForKey:@"created_at"] forKey:@"created_at"];
                [newManagedObject setValue:[dic valueForKey:@"geo"] forKey:@"geo"];
                [newManagedObject setValue:[dic valueForKey:@"id"] forKey:@"id"]; 
                [newManagedObject setValue:[dic valueForKey:@"idstr"] forKey:@"idstr"];
                [newManagedObject setValue:[dic valueForKey:@"in_reply_to_screen_name"] forKey:@"in_reply_to_screen_name"];
                [newManagedObject setValue:[dic valueForKey:@"in_reply_to_status_id"] forKey:@"in_reply_to_status_id"]; 
                [newManagedObject setValue:[dic valueForKey:@"in_reply_to_user_id"] forKey:@"in_reply_to_user_id"]; 
                [newManagedObject setValue:[dic valueForKey:@"mid"] forKey:@"mid"]; [newManagedObject setValue:[dic valueForKey:@"original_pic"] forKey:@"original_pic"]; 
                [newManagedObject setValue:[dic valueForKey:@"reposts_count"] forKey:@"reposts_count"]; 
                [newManagedObject setValue:[dic valueForKey:@"source"] forKey:@"source"]; 
                [newManagedObject setValue:[dic valueForKey:@"text"] forKey:@"text"]; 
                [newManagedObject setValue:[dic valueForKey:@"thumbnail_pic"] forKey:@"thumbnail_pic"]; 
                [newManagedObject setValue:[dic valueForKey:@"user"] forKey:@"user"]; 
                
                
                // Save the context.

                if (![context save:&error]){
                    // Replace this implementation with code to handle the error appropriately.
                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
                    NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
                    abort();
                }
                break;
            }
            case 4:
            {
                NSManagedObjectContext *context = [self.friendListFetchedResultsController managedObjectContext];
                NSEntityDescription *entity = [[self.friendListFetchedResultsController fetchRequest] entity];
                NSManagedObject *newManagedObject = [NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:context];
                
                [newManagedObject setValue:[dic valueForKey:@"gender"] forKey:@"gender"];
                [newManagedObject setValue:[dic valueForKey:@"id"] forKey:@"id"];
                [newManagedObject setValue:[dic valueForKey:@"idstr"] forKey:@"idstr"];
                [newManagedObject setValue:[dic valueForKey:@"location"] forKey:@"location"];
                [newManagedObject setValue:[dic valueForKey:@"name"] forKey:@"name"]; 
                [newManagedObject setValue:[dic valueForKey:@"profile_image_url"] forKey:@"profile_image_url"];
                [newManagedObject setValue:[dic valueForKey:@"profile_url"] forKey:@"profile_url"];
                [newManagedObject setValue:[dic valueForKey:@"screen_name"] forKey:@"screen_name"]; 
                
                // Save the context.
  
                if (![context save:&error]){
                    // Replace this implementation with code to handle the error appropriately.
                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
                    NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
                    abort();
                }
                break;
            }
                /*test case
            case 5:
            {
                NSManagedObjectContext *context = [self.testFetchedResultsController managedObjectContext];
                NSEntityDescription *entity = [[self.testFetchedResultsController fetchRequest] entity];
                NSManagedObject *newManagedObject = [NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:context];
                
                [newManagedObject setValue:[dic valueForKey:@"time"] forKey:@"time"];
                
                
                // Save the context.
                
                if (![context save:&error]){
                    // Replace this implementation with code to handle the error appropriately.
                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
                    NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
                    abort();
                }
                break;
            }*/

            default:break;
                
        }
        
    }

}




@end
