#import <ReactiveCocoa/ReactiveCocoa.h>

#import "MainWindowController.h"
#import "ContactListViewController.h"
#import "ContactDetailViewController.h"

#import "ContactManagerViewModel.h"

@interface MainWindowController ()

@property(nonatomic, assign) IBOutlet NSView *listView;
@property(nonatomic, assign) IBOutlet NSView *detailView;
@property(nonatomic, assign) IBOutlet NSButton *removeButton;
@property(nonatomic, assign) IBOutlet NSButton *addButton;

@property(nonatomic, strong) ContactListViewController *contactListViewController;
@property(nonatomic, strong) ContactDetailViewController *contactDetailViewController;

@property(nonatomic, weak) ContactManagerViewModel *viewModel;

@end

@implementation MainWindowController


- (instancetype)init {
    return [self initWithContactManagerViewModel:nil];
}

- (instancetype)initWithContactManagerViewModel:(ContactManagerViewModel *)viewModel {
    NSParameterAssert(viewModel != nil);

    self = [super initWithWindowNibName:@"MainWindowController"];
    if (self) {
        self.viewModel = viewModel;
        self.contactListViewController = [[ContactListViewController alloc] initWithContactManagerViewModel:self.viewModel];
        self.contactDetailViewController = [[ContactDetailViewController alloc] initWithContactManagerViewModel:self.viewModel];
    }
    return self;
}

#pragma mark - Windows methods

- (void)windowDidLoad {
    [super windowDidLoad];

    // setup detail first so we get the right notifications
    self.contactDetailViewController.view.frame = self.detailView.bounds;
    [self.detailView addSubview:self.contactDetailViewController.view];

    self.contactListViewController.view.frame = self.listView.bounds;
    [self.listView addSubview:self.contactListViewController.view];

    self.addButton.rac_command = self.viewModel.addContactCommand;
    self.removeButton.rac_command = self.viewModel.deleteContactCommand;
}

- (NSString *)windowNibName {
    return NSStringFromClass([self class]);
}

@end
