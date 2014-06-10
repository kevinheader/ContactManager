#import "ContactDataController.h"
#import "CoreDataController.h"
#import "NSManagedObjectModel+Extensions.h"
#import "Contact.h"

@interface ContactDataController ()

@property(nonatomic, weak) CoreDataController *coreDataController;
@property(nonatomic, readwrite, strong) NSArray *contacts;

@end

@implementation ContactDataController


- (instancetype)init {
    return [self initWithCoreDataController:nil];
}

- (instancetype)initWithCoreDataController:(CoreDataController *)coreDataController {
    NSParameterAssert(coreDataController != nil);

    self = [super init];
    if (self) {
        self.coreDataController = coreDataController;
    }

    return self;
}

#pragma mark - Accessor

- (NSArray *)contacts {
    return [self.coreDataController.managedObjectModel objectsInEntityWithContext:self.coreDataController.managedObjectContext
                                                                             name:@"Contact"
                                                                        predicate:nil
                                                            sortedWithDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"lastName" ascending:YES]]];
}

#pragma mark - Data Methods

- (Contact *)createContact {
    [self willChangeValueForKey:@"contacts"];
    Contact *contact = (Contact *) [self.coreDataController.managedObjectModel insertNewObjectInEntityWithContext:self.coreDataController.managedObjectContext
                                                                                                             name:@"Contact"
                                                                                                           values:nil];

    [self didChangeValueForKey:@"contacts"];
    return contact;
}

- (void)deleteContact:(Contact *)contact {
    [self willChangeValueForKey:@"contacts"];
    [self.coreDataController.managedObjectContext deleteObject:contact];
    [self didChangeValueForKey:@"contacts"];
}

@end
