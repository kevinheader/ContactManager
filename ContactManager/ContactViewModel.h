#import "RVMViewModel.h"

@class Contact;

@interface ContactViewModel : RVMViewModel

@property(nonatomic, strong) NSString *firstName;
@property(nonatomic, strong) NSString *lastName;
@property(nonatomic, strong) NSString *emailAddress;
@property(nonatomic, strong) NSString *phoneNumber;
@property(nonatomic, strong, readonly) NSString *fullName;
@property(nonatomic, strong, readonly) Contact *contact;

- (instancetype)initWithContact:(Contact *)contact;

@end
