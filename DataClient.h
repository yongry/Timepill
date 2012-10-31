//
//  DataClient.h
//  Timeline
//
//  Created by yongry on 12-10-30.
//  Copyright (c) 2012年 Sun Yat-sen University. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface DataClient : NSObject<NSFetchedResultsControllerDelegate>

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (strong, nonatomic) NSFetchedResultsController *personWeiboFetchedResultsController;
@property (strong, nonatomic) NSFetchedResultsController *friendWeiboFetchedResultsController;
@property (strong, nonatomic) NSFetchedResultsController *personInfoFetchedResultsController;
@property (strong, nonatomic) NSFetchedResultsController *friendListFetchedResultsController;
@property (strong, nonatomic) NSFetchedResultsController *RpersonInfoFetchedResultsController;
@property (strong, nonatomic) NSFetchedResultsController *RfriendListFetchedResultsController;
// test: @property (strong, nonatomic) NSFetchedResultsController *testFetchedResultsController;

+ (DataClient *)shareClient;
- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;
-(void)addItem:(NSDictionary *)item  withType:(int)type;
-(void)deleteItem:(NSIndexPath *)indexPath withController:(NSFetchedResultsController *)controller;


@end
