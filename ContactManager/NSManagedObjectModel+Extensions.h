#import <CoreData/CoreData.h>

@interface NSManagedObjectModel (Extensions)

- (NSArray *)objectsInEntityWithContext:(NSManagedObjectContext *)context name:(NSString *)name predicate:(NSPredicate *)predicate sortedWithDescriptors:(NSArray *)descriptors;

- (NSManagedObject *)insertNewObjectInEntityWithContext:(NSManagedObjectContext *)context name:(NSString *)name values:(NSDictionary *)values;

@end
