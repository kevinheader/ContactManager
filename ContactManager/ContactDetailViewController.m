#import <ReactiveCocoa/ReactiveCocoa.h>
#import <ReactiveCocoa/RACEXTScope.h>

#import "ContactDetailViewController.h"

#import "ContactManagerViewModel.h"
#import "ContactViewModel.h"

@interface ContactDetailViewController ()

@property(nonatomic, assign) IBOutlet NSTextField *firstNameTextField;
@property(nonatomic, assign) IBOutlet NSTextField *lastNameTextField;
@property(nonatomic, assign) IBOutlet NSTextField *emailTextField;
@property(nonatomic, assign) IBOutlet NSTextField *phoneNumberTextField;
@property(nonatomic, assign) IBOutlet NSObjectController *contactObjectController;

@property(nonatomic, weak) ContactManagerViewModel *viewModel;

@end

@implementation ContactDetailViewController

- (instancetype)init {
    return [self initWithContactManagerViewModel:nil];
}

- (instancetype)initWithContactManagerViewModel:(ContactManagerViewModel *)viewModel {
    NSParameterAssert(viewModel != nil);

    self = [super init];
    if (self) {
        self.viewModel = viewModel;
    }
    return self;
}

#pragma mark - View methods

- (void)awakeFromNib {
    @weakify(self);
    [self.viewModel.selectedContactChangedSignal subscribeNext:^(ContactViewModel *selectedContact) {
        @strongify(self);
        self.contact = selectedContact;
    }];
}

- (NSString *)nibName {
    return NSStringFromClass([self class]);
}


@end
