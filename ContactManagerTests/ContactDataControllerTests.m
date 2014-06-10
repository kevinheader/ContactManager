#import <XCTest/XCTest.h>

#import "CoreDataController.h"
#import "ContactDataController.h"
#import "Contact.h"

@interface ContactDataControllerTests : XCTestCase

@property(nonatomic, strong) CoreDataController *coreDataController;
@property(nonatomic, strong) ContactDataController *contactDataController;

@end

@implementation ContactDataControllerTests

- (void)setUp {
    [super setUp];

    self.coreDataController = [[CoreDataController alloc] initWithInitialType:NSInMemoryStoreType modelName:@"ContactManagerModel.momd" applicationSupportName:nil dataStoreName:nil];
    self.contactDataController = [[ContactDataController alloc] initWithCoreDataController:self.coreDataController];
}

- (void)tearDown {
    self.contactDataController = nil;
    self.coreDataController = nil;

    [super tearDown];
}

- (void)testShouldCreateNewNonNilContact {
    Contact *contact = [self.contactDataController createContact];

    XCTAssertNotNil(contact, @"Contact should not be nil");
}

- (void)testShouldBeAbleRetrieveNewContact {
    Contact *contact = [self.contactDataController createContact];
    contact.firstName = @"Scott";
    contact.lastName = @"Densmore";

    contact = [self.contactDataController contacts][0];

    XCTAssertNotNil(contact, @"Could not find inserted contact");
    XCTAssertEqualObjects(@"Scott", contact.firstName, @"Contact firstName did not match");
    XCTAssertEqualObjects(@"Densmore", contact.lastName, @"Contact firstName did not match");
}

- (void)testShouldRetrieveContactsInLastNameOrder {
    for (int idx = 4; idx >= 0; idx--) {
        Contact *contact = [self.contactDataController createContact];
        contact.firstName = [NSString stringWithFormat:@"%d First", idx];
        contact.lastName = [NSString stringWithFormat:@"%d Last", idx];
    }

    NSArray *contacts = [self.contactDataController contacts];

    for (NSUInteger idx = 0; idx < 5; idx++) {
        Contact *contact = contacts[idx];
        NSString *expectedLastName = [NSString stringWithFormat:@"%lu Last", (unsigned long)idx];
        XCTAssertEqualObjects(expectedLastName, contact.lastName, @"Did not get contacts ordered by last name");
    }
}

- (void)testShouldBeAbleToDeleteContactAfterInserting {
    Contact *contact = [self.contactDataController createContact];
    contact.firstName = @"Scott";
    contact.lastName = @"Densmore";

    [self.contactDataController deleteContact:contact];
    NSUInteger contactCount = [[self.contactDataController contacts] count];

    XCTAssertEqual((NSUInteger) 0, contactCount, @"Did not delete contact");
}

@end
