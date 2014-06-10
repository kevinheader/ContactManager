#import "NSManagedObjectModel+Extensions.h"


@implementation NSManagedObjectModel (Extensions)

- (NSArray *)objectsInEntityWithContext:(NSManagedObjectContext *)context name:(NSString *)name predicate:(NSPredicate *)predicate sortedWithDescriptors:(NSArray *)descriptors {
    if (!context || !name) {
        return nil;
    }

    NSEntityDescription *entity = [self entitiesByName][name];

    //If our entity doesn't exist return nil
    if (!entity) {
        LOG(@"entity doesn't exist in entities:%@", [self entitiesByName]);
        return nil;
    }

    NSFetchRequest *request = [[NSFetchRequest alloc] init];

    [request setEntity:entity];
    [request setPredicate:predicate];
    [request setSortDescriptors:descriptors];

    NSError *error = nil;
    NSArray *results = [context executeFetchRequest:request error:&error];

    //If there was an error then return nothing
    if (error) {
        LOG(@"error:%@", error);
        return nil;
    }

    return results;
}

- (NSManagedObject *)insertNewObjectInEntityWithContext:(NSManagedObjectContext *)context name:(NSString *)name values:(NSDictionary *)values {
    if (!context || !name) {
        return nil;
    }

    NSManagedObject *object = [NSEntityDescription insertNewObjectForEntityForName:name inManagedObjectContext:context];

    if (!object) {
        return nil;
    }

    for (NSString *key in [values allKeys]) {
        [object setValue:values[key] forKey:key];
    }
    return object;

}

@end
