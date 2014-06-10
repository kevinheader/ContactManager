#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface Contact : NSManagedObject

@property(nonatomic, strong) NSString *firstName;
@property(nonatomic, strong) NSString *lastName;
@property(nonatomic, strong) NSString *emailAddress;
@property(nonatomic, strong) NSString *phoneNumber;

@end
