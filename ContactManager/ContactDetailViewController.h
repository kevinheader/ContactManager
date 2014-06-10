#import <Cocoa/Cocoa.h>

@class ContactViewModel;
@class ContactManagerViewModel;

@interface ContactDetailViewController : NSViewController

@property(nonatomic, strong) ContactViewModel *contact;

- (instancetype)initWithContactManagerViewModel:(ContactManagerViewModel *)viewModel;

@end
