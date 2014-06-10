#import <Foundation/Foundation.h>
#import "CoreDataController.h"

@protocol CoreDataControllerDelegate <NSObject>

- (void)coreDataController:(CoreDataController *)controller encounteredIncorrectModelWithVersionIdentifiers:(NSSet *)identifiers;

@end
