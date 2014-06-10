#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>

#import "BaseTestCase.h"
#import "ContactDataController.h"
#import "ContactDetailViewController.h"
#import "MainWindowController.h"
#import "ContactManagerViewModel.h"

@interface MainWindowController (Tests)

@property(nonatomic, strong) ContactDetailViewController *contactDetailViewController;

@end

@interface ContactDetailViewController (Tests)

@property(nonatomic, assign) IBOutlet NSTextField *firstNameTextField;
@property(nonatomic, assign) IBOutlet NSTextField *lastNameTextField;
@property(nonatomic, assign) IBOutlet NSTextField *emailTextField;
@property(nonatomic, assign) IBOutlet NSTextField *phoneNumberTextField;
@property(nonatomic, assign) IBOutlet NSObjectController *contactObjectController;

@end

@interface ContactDetailViewControllerTests : BaseTestCase

@property(nonatomic, strong) MainWindowController *mainWindowController;
@property(nonatomic, strong) NSWindow *window;
@property(nonatomic, strong) ContactDetailViewController *contactDetailViewController;

@end


@implementation ContactDetailViewControllerTests

- (void)setUp {
    [super setUp];

    id contactDataController = [OCMockObject mockForClass:ContactDataController.class];
    [[[contactDataController stub] andReturn:nil] contacts];

    ContactManagerViewModel *viewModel = [[ContactManagerViewModel alloc] initWithContactDataController:contactDataController];
    self.mainWindowController = [[MainWindowController alloc] initWithContactManagerViewModel:viewModel];
    self.window = self.mainWindowController.window;
    self.contactDetailViewController = self.mainWindowController.contactDetailViewController;
}

- (void)tearDown {
    self.mainWindowController = nil;
    self.window = nil;
    self.contactDetailViewController = nil;

    [super tearDown];
}

- (void)testShouldHaveValidNibName {
    XCTAssertEqualObjects(_contactDetailViewController.nibName, @"ContactDetailViewController",
                    @"The nib for this view should be ContactDetailViewController.xib");
}

- (void)testShouldBindObjectControllerFirstNameToFirstNameTextField {
    NSObjectController *contactObjectController = self.contactDetailViewController.contactObjectController;
    NSTextField *firstNameTextField = self.contactDetailViewController.firstNameTextField;

    XCTAssertTrue([self checkObject:firstNameTextField hasBinding:NSValueBinding
                           toObject:contactObjectController through:@"selection.firstName"],
                    @"Bind first name text field value to the object controller's 'selection.firstName' key path.");

}

- (void)testShouldBindObjectControllerLastNameToLastNameTextField {
    NSObjectController *contactObjectController = self.contactDetailViewController.contactObjectController;
    NSTextField *lastNameTextField = self.contactDetailViewController.lastNameTextField;

    XCTAssertTrue([self checkObject:lastNameTextField hasBinding:NSValueBinding
                           toObject:contactObjectController through:@"selection.lastName"],
                    @"Bind last name text field value to the object controller's 'selection.lastName' key path.");

}

- (void)testShouldBindObjectControllerPhoneNumberToPhoneNumberTextField {
    NSObjectController *contactObjectController = self.contactDetailViewController.contactObjectController;
    NSTextField *phoneNumberTextField = self.contactDetailViewController.phoneNumberTextField;

    XCTAssertTrue([self checkObject:phoneNumberTextField hasBinding:NSValueBinding
                           toObject:contactObjectController through:@"selection.phoneNumber"],
                    @"Bind phone number text field value to the object controller's 'selection.phoneNumber' key path.");

}

- (void)testShouldBindObjectControllerEmailToEmailTextField {
    NSObjectController *contactObjectController = self.contactDetailViewController.contactObjectController;
    NSTextField *emailTextField = self.contactDetailViewController.emailTextField;

    XCTAssertTrue([self checkObject:emailTextField hasBinding:NSValueBinding
                           toObject:contactObjectController through:@"selection.emailAddress"],
                    @"Bind email text field value to the object controller's 'selection.email' key path.");

}

@end
