#import <XCTest/XCTest.h>

#import "CoreDataController.h"
#import "ContactDataController.h"
#import "Contact.h"

@interface ContactDataControllerKVOTests : XCTestCase

@property(nonatomic, strong) CoreDataController *coreDataController;
@property(nonatomic, strong) ContactDataController *contactDataController;
@property(nonatomic, assign) BOOL contactsChanged;

@end

@implementation ContactDataControllerKVOTests

- (void)setUp {
    [super setUp];

    self.coreDataController = [[CoreDataController alloc] initWithInitialType:NSInMemoryStoreType modelName:@"ContactManagerModel.momd" applicationSupportName:nil dataStoreName:nil];
    self.contactDataController = [[ContactDataController alloc] initWithCoreDataController:self.coreDataController];
    [self.contactDataController addObserver:self forKeyPath:@"contacts" options:NSKeyValueObservingOptionNew context:NULL];

    self.contactsChanged = NO;
}

- (void)tearDown {
    [self.contactDataController removeObserver:self forKeyPath:@"contacts"];
    self.contactDataController = nil;

    self.coreDataController = nil;

    [super tearDown];
}

- (void)testShouldFireChangeForContactsWhenAddingNewContact {
    [self.contactDataController createContact];

    XCTAssertTrue(self.contactsChanged, @"Adding new contact should fire change for contacts");
}

- (void)testShouldFireChangeForContactsWhenDeletingContact {
    Contact *contact = [self.contactDataController createContact];
    self.contactsChanged = NO;

    [self.contactDataController deleteContact:contact];

    XCTAssertTrue(self.contactsChanged, @"Adding new contact should fire change for contacts");
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    self.contactsChanged = YES;
}

@end
