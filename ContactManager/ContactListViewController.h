#import <Cocoa/Cocoa.h>

@class ContactManagerViewModel;

@interface ContactListViewController : NSViewController <NSTableViewDelegate>

@property(nonatomic, readonly, assign) NSArray *contacts;

- (id)initWithContactManagerViewModel:(ContactManagerViewModel *)viewModel;

@end