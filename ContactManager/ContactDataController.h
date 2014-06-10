#import <Foundation/Foundation.h>

@class Contact;
@class CoreDataController;

@interface ContactDataController : NSObject

@property(nonatomic, readonly, strong) NSArray *contacts;

- (instancetype)initWithCoreDataController:(CoreDataController *)coreDataController;

- (Contact *)createContact;

- (void)deleteContact:(Contact *)contact;

@end
