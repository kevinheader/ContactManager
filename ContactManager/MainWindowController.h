#import <Cocoa/Cocoa.h>

@class ContactManagerViewModel;

@interface MainWindowController : NSWindowController

- (instancetype)initWithContactManagerViewModel:(ContactManagerViewModel *)viewModel;

@end
