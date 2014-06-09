//
//  CoreDataController.h
//  ContactManager
//
//  Created by Scott Densmore on 6/21/11.
//  Copyright 2011 Scott Densmore. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol CoreDataControllerDelegate;

@interface CoreDataController : NSObject

@property (assign) id<CoreDataControllerDelegate> delegate;

@property (nonatomic, readonly, strong) NSString *applicationSupportFolder;
@property (nonatomic, readonly, strong) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (nonatomic, readonly, strong) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, readonly, strong) NSManagedObjectContext *managedObjectContext;

- (instancetype)initWithModelName:(NSString *)modelName applicationSupportName:(NSString *)applicationSupportName dataStoreName:(NSString *)dataStoreName;
- (instancetype)initWithInitialType:(NSString *)initialType modelName:(NSString *)modelName applicationSupportName:(NSString *)applicationSupportName dataStoreName:(NSString *)dataStoreName;

- (BOOL)save:(NSError **)error;


@end
