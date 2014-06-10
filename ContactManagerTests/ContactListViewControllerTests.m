#import "BaseTestCase.h"
#import <OCMock/OCMock.h>

#import "ContactDataController.h"
#import "ContactListViewController.h"
#import "MainWindowController.h"
#import "ContactManagerViewModel.h"

@interface MainWindowController (Tests)

@property(nonatomic, strong) ContactListViewController *contactListViewController;

@end

@interface ContactListViewController (Tests)

@property(nonatomic, assign) IBOutlet NSArrayController *contactsArrayController;

@property(nonatomic, assign) IBOutlet NSTableView *tableView;

@end

@interface ContactListViewControllerTests : BaseTestCase

@property(nonatomic, strong) MainWindowController *mainWindowController;
@property(nonatomic, assign) NSWindow *window;
@property(nonatomic, assign) ContactListViewController *contactListViewController;

@end

@implementation ContactListViewControllerTests

- (void)setUp {
    [super setUp];
    /*
    CoreDataController *coreDataController = [[[CoreDataController alloc] initWithInitialType:NSInMemoryStoreType appSupportName:nil modelName:@"ContactManagerModel.momd" dataStoreName:nil] autorelease];
    ContactDataController *contactDataController = [[[ContactDataController alloc] initWithCoreDataController:coreDataController] autorelease];

    //NSMutableArray *contactsToReturn = [NSMutableArray array];
    NSArray *contacts = [[[NSBundle bundleForClass:ContactListViewControllerTests.class] infoDictionary] valueForKey:@"Contacts"];
	for (NSDictionary *contactDict in contacts) { 
        Contact *contact = [contactDataController createContact];
		[contact setFirstName:[contactDict valueForKey:@"firstName"]];
        [contact setLastName:[contactDict valueForKey:@"lastName"]];
        [contact setPhoneNumber:[contactDict valueForKey:@"phoneNumber"]];
		[contact setEmailAddress:[contactDict valueForKey:@"emailAddress"]];
        //[contactsToReturn addObject:contact];
	}
    */

    id contactDataController = [OCMockObject mockForClass:ContactDataController.class];
    [[[contactDataController stub] andReturn:nil] contacts];

    ContactManagerViewModel *viewModel = [[ContactManagerViewModel alloc] initWithContactDataController:contactDataController];
    self.mainWindowController = [[MainWindowController alloc] initWithContactManagerViewModel:viewModel];
    self.window = _mainWindowController.window;
    self.contactListViewController = self.mainWindowController.contactListViewController;
}

- (void)tearDown {
    self.mainWindowController = nil;
    self.window = nil;
    self.contactListViewController = nil;

    [super tearDown];
}

- (void)testShouldHaveValidNibName {
    XCTAssertEqualObjects(self.contactListViewController.nibName, @"ContactListViewController",
                    @"The nib for this view should be ContactListViewController.xib");
}

- (void)testShouldBeTableViewDelegate {
    XCTAssertTrue([self checkOutlet:[self.contactListViewController.tableView delegate]
                         connectsTo:self.contactListViewController],
                    @"The table view's delegate should be the view controller.");
}

- (void)testShouldBindContactsToArrayControllerContent {
    NSArrayController *contactsArrayController = self.contactListViewController.contactsArrayController;

    XCTAssertTrue([self checkObject:contactsArrayController hasBinding:NSContentArrayBinding
                           toObject:self.contactListViewController through:@"contacts"],
                    @"Bind contacts array controller content value to the controller's 'contacts' key path.");
}


- (void)testShouldBindSelectedObjectFromArrayControllerToFirstNameColumn {
    NSArrayController *contactsArrayController = self.contactListViewController.contactsArrayController;
    NSTableColumn *firstNameColumn = [self.contactListViewController.tableView tableColumnWithIdentifier:@"First"];

    XCTAssertTrue([self checkObject:firstNameColumn hasBinding:NSValueBinding
                           toObject:contactsArrayController through:@"arrangedObjects.firstName"],
                    @"Bind first name column value to the contacts array controller's 'arrangedObjects.firstName' key path.");
}

- (void)testShouldBindSelectedObjectFromArrayControllerToLastNameColumn {
    NSArrayController *contactsArrayController = self.contactListViewController.contactsArrayController;
    NSTableColumn *lastNameColumn = [self.contactListViewController.tableView tableColumnWithIdentifier:@"Last"];

    XCTAssertTrue([self checkObject:lastNameColumn hasBinding:NSValueBinding
                           toObject:contactsArrayController through:@"arrangedObjects.lastName"],
                    @"Bind last name column value to the contacts array controller's 'arrangedObjects.lastName' key path.");
}

@end
