#import <XCTest/XCTest.h>
#import <ReactiveCocoa/ReactiveCocoa.h>

#import "ContactManagerViewModel.h"

#import "ContactViewModel.h"
#import "CoreDataController.h"
#import "ContactDataController.h"

@interface ContactManagerViewModel (Tests)

@property(nonatomic, strong) ContactViewModel *selectedContact;

- (RACSignal *)enableDeleteSignal;

@end

@interface ContactMangerViewModelTests : XCTestCase

@property(nonatomic, strong) ContactManagerViewModel *viewModel;
@property(nonatomic, strong) ContactDataController *contactDataController;
@property(nonatomic, strong) CoreDataController *coreDataController;

@end

@implementation ContactMangerViewModelTests

- (void)setUp {
    [super setUp];

    self.coreDataController = [[CoreDataController alloc] initWithInitialType:NSInMemoryStoreType modelName:@"ContactManagerModel.momd" applicationSupportName:nil dataStoreName:nil];
    self.contactDataController = [[ContactDataController alloc] initWithCoreDataController:self.coreDataController];
    self.viewModel = [[ContactManagerViewModel alloc] initWithContactDataController:self.contactDataController];
}

- (void)tearDown {

    self.viewModel = nil;

    [super tearDown];
}

- (void)testShouldCreatesNewContactWhenAddCommandExecuted {
    [[self.viewModel.addContactCommand execute:nil] asynchronouslyWaitUntilCompleted:NULL];
    
    XCTAssertEqual(self.viewModel.contacts.count, 1, @"");
}

- (void)testShouldRemoveSelectedContactWhenRemoveCommandExecuted {
    [self.contactDataController createContact];
    [self.viewModel selectContactViewModelForIndex:0];
    [[self.viewModel.deleteContactCommand execute:nil] asynchronouslyWaitUntilCompleted:NULL];
    
    XCTAssertEqual(self.viewModel.contacts.count, 0, @"");
}

- (void)testShouldDisableDeleteCommandWhenNoContactIsSelected {
    __block id result;

    [self.viewModel.enableDeleteSignal subscribeNext:^(id x) {
        result = x;
    }];

    XCTAssertEqualObjects(result, @0, @"");
}

- (void)testShouldEnableDeleteCommandWhenContactIsSelected {

    __block id result;
    Contact *contact = self.contactDataController.createContact;
    ContactViewModel *contactViewModel = [[ContactViewModel alloc] initWithContact:contact];
    self.viewModel.selectedContact = contactViewModel;

    [self.viewModel.enableDeleteSignal subscribeNext:^(id x) {
        result = x;
    }];

    XCTAssertEqualObjects(result, @1, @"");
}

- (void)testShouldSetContactWhenSelectingByIndex {
    Contact *contact = self.contactDataController.createContact;

    ContactViewModel *model = [self.viewModel selectContactViewModelForIndex:0];

    XCTAssertEqualObjects(contact, model.contact, @"");
    XCTAssertEqualObjects(model, self.viewModel.selectedContact, @"");
}

@end

