#import <XCTest/XCTest.h>

#import "ContactViewModel.h"

#import "CoreDataController.h"
#import "ContactDataController.h"

#import "Contact.h"

@interface ContactViewModelTests : XCTestCase

@property(nonatomic, strong) CoreDataController *coreDataController;
@property(nonatomic, strong) ContactDataController *contactDataController;
@property(nonatomic, strong) Contact *contact;

@end

@implementation ContactViewModelTests

- (void)setUp {
    [super setUp];

    self.coreDataController = [[CoreDataController alloc] initWithInitialType:NSInMemoryStoreType modelName:@"ContactManagerModel.momd" applicationSupportName:nil dataStoreName:nil];
    self.contactDataController = [[ContactDataController alloc] initWithCoreDataController:self.coreDataController];
    self.contact = [self.contactDataController createContact];
    self.contact.firstName = @"Scott";
    self.contact.lastName = @"Densmore";
    self.contact.emailAddress = @"sd@icloud.com";
    self.contact.phoneNumber = @"555-555-5555";
}

- (void)tearDown {
    self.contactDataController = nil;
    self.coreDataController = nil;

    [super tearDown];
}

- (void)testWhenInitializedWithContactShouldNotThrow {
    XCTAssertNoThrow([[ContactViewModel alloc] initWithContact:self.contact], @"");
}

- (void)testWhenInitializedShouldSetFirstName {
    ContactViewModel *viewModel = [[ContactViewModel alloc] initWithContact:self.contact];

    XCTAssertEqualObjects(self.contact.firstName, viewModel.firstName, @"");
}

- (void)testWhenChangingViewModelFirstNameShouldChangeContactFirstName {
    ContactViewModel *viewModel = [[ContactViewModel alloc] initWithContact:self.contact];

    viewModel.firstName = @"New Value";

    XCTAssertEqualObjects(@"New Value", self.contact.firstName, @"");
}

- (void)testWhenInitializedShouldSetLastName {
    ContactViewModel *viewModel = [[ContactViewModel alloc] initWithContact:self.contact];

    XCTAssertEqualObjects(self.contact.lastName, viewModel.lastName, @"");
}

- (void)testWhenChangingViewModelLastNameShouldChangeContactLastName {
    ContactViewModel *viewModel = [[ContactViewModel alloc] initWithContact:self.contact];

    viewModel.lastName = @"New Value";

    XCTAssertEqualObjects(@"New Value", self.contact.lastName, @"");
}

- (void)testWhenInitializedShouldSetEmail {
    ContactViewModel *viewModel = [[ContactViewModel alloc] initWithContact:self.contact];

    XCTAssertEqualObjects(self.contact.emailAddress, viewModel.emailAddress, @"");
}

- (void)testWhenChangingViewModelEmailShouldChangeContactEmail {
    ContactViewModel *viewModel = [[ContactViewModel alloc] initWithContact:self.contact];

    viewModel.emailAddress = @"New Value";

    XCTAssertEqualObjects(@"New Value", self.contact.emailAddress, @"");
}

- (void)testWhenInitializedShouldSetPhoneNumber {
    ContactViewModel *viewModel = [[ContactViewModel alloc] initWithContact:self.contact];

    XCTAssertEqualObjects(self.contact.phoneNumber, viewModel.phoneNumber, @"");
}

- (void)testWhenChangingViewModelEmailShouldChangeContactPhoneNumber {
    ContactViewModel *viewModel = [[ContactViewModel alloc] initWithContact:self.contact];

    viewModel.phoneNumber = @"New Value";

    XCTAssertEqualObjects(@"New Value", self.contact.phoneNumber, @"");
}

- (void)testWhenInitializingViewModelWithContactShouldSetFullName {
    ContactViewModel *viewModel = [[ContactViewModel alloc] initWithContact:self.contact];

    NSString *fullName = [NSString stringWithFormat:@"%@ %@", self.contact.firstName, self.contact.lastName];
    XCTAssertEqualObjects(fullName, viewModel.fullName, @"");
}

- (void)testWhenFirstNameInViewModelChangesShouldSetFullName {
    ContactViewModel *viewModel = [[ContactViewModel alloc] initWithContact:self.contact];

    viewModel.firstName = @"New Value";

    NSString *fullName = [NSString stringWithFormat:@"%@ %@", viewModel.firstName, viewModel.lastName];
    XCTAssertEqualObjects(fullName, viewModel.fullName, @"");
}

- (void)testWhenLastNameInViewModelChangesShouldSetFullName {
    ContactViewModel *viewModel = [[ContactViewModel alloc] initWithContact:self.contact];

    viewModel.lastName = @"New Value";

    NSString *fullName = [NSString stringWithFormat:@"%@ %@", viewModel.firstName, viewModel.lastName];
    XCTAssertEqualObjects(fullName, viewModel.fullName, @"");
}


@end
