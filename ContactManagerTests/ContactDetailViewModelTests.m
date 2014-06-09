//
//  ContactDetailViewModel.m
//  ContactManager
//
//  Created by Scott Densmore on 4/13/14.
//  Copyright (c) 2014 Scott Densmore. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "ContactDetailViewModel.h"
#import "CoreDataController.h"
#import "ContactDataController.h"
#import "Contact.h"

@interface ContactDetailViewModelTests : XCTestCase

@property (nonatomic, strong) CoreDataController *coreDataController;
@property (nonatomic, strong) ContactDataController *contactDataController;
@property (nonatomic, strong) Contact *contact;

@end

@implementation ContactDetailViewModelTests

- (void)setUp
{
    [super setUp];
    
    _coreDataController = [[CoreDataController alloc] initWithInitialType:NSInMemoryStoreType modelName:@"ContactManagerModel.momd" applicationSupportName:nil dataStoreName:nil];
    _contactDataController = [[ContactDataController alloc] initWithCoreDataController:_coreDataController];
    _contact = [_contactDataController createContact];
    _contact.firstName = @"Scott";
    _contact.lastName = @"Densmore";
    _contact.emailAddress = @"sd@icloud.com";
    _contact.phoneNumber = @"555-555-5555";
}

- (void)tearDown
{
    _contactDataController = nil;
    _coreDataController = nil;
    
    [super tearDown];
}

- (void)testWhenInitiallizedWithContactShouldNotThrow
{
    
    XCTAssertNoThrow([[ContactDetailViewModel alloc] initWithContact:_contact], @"");
}

//- (void)testWhenInitiallizedShouldThrow
//{
//    XCTAssertThrows([[ContactDetailViewModel alloc] init], @"");
//}

- (void)testWhenInitializedShouldSetFirstName
{
    ContactDetailViewModel *viewModel = [[ContactDetailViewModel alloc] initWithContact:_contact];
    
    XCTAssertEqualObjects(_contact.firstName, viewModel.firstName, @"");
}

- (void)testWhenChaningingViewModelFirstNameShouldChangeContactFirstName
{
    ContactDetailViewModel *viewModel = [[ContactDetailViewModel alloc] initWithContact:_contact];
    
    viewModel.firstName = @"New Value";
    
    XCTAssertEqualObjects(@"New Value", _contact.firstName, @"");
}

- (void)testWhenInitializedShouldSetLastName
{
    ContactDetailViewModel *viewModel = [[ContactDetailViewModel alloc] initWithContact:_contact];
    
    XCTAssertEqualObjects(_contact.lastName, viewModel.lastName, @"");
}

- (void)testWhenChaningingViewModelLastNameShouldChangeContactLastName
{
    ContactDetailViewModel *viewModel = [[ContactDetailViewModel alloc] initWithContact:_contact];
    
    viewModel.lastName = @"New Value";
    
    XCTAssertEqualObjects(@"New Value", _contact.lastName, @"");
}

- (void)testWhenInitializedShouldSetEmail
{
    ContactDetailViewModel *viewModel = [[ContactDetailViewModel alloc] initWithContact:_contact];
    
    XCTAssertEqualObjects(_contact.emailAddress, viewModel.emailAddress, @"");
}

- (void)testWhenChaningingViewModelEmailShouldChangeContactEmail
{
    ContactDetailViewModel *viewModel = [[ContactDetailViewModel alloc] initWithContact:_contact];
    
    viewModel.emailAddress = @"New Value";
    
    XCTAssertEqualObjects(@"New Value", _contact.emailAddress, @"");
}

- (void)testWhenInitializedShouldSetPhoneNumber
{
    ContactDetailViewModel *viewModel = [[ContactDetailViewModel alloc] initWithContact:_contact];
    
    XCTAssertEqualObjects(_contact.phoneNumber, viewModel.phoneNumber, @"");
}

- (void)testWhenChaningingViewModelEmailShouldChangeContactPhoneNumber
{
    ContactDetailViewModel *viewModel = [[ContactDetailViewModel alloc] initWithContact:_contact];
    
    viewModel.phoneNumber = @"New Value";
    
    XCTAssertEqualObjects(@"New Value", _contact.phoneNumber, @"");
}

- (void)testWhenInitializingViewModelWithContactShouldSetFullName
{
    ContactDetailViewModel *viewModel = [[ContactDetailViewModel alloc] initWithContact:_contact];
    
    NSString *fullName = [NSString stringWithFormat:@"%@ %@", _contact.firstName, _contact.lastName];
    XCTAssertEqualObjects(fullName, viewModel.fullName, @"");
}

- (void)testWhenFirstNameInViewModelChangesShouldSetFullName
{
    ContactDetailViewModel *viewModel = [[ContactDetailViewModel alloc] initWithContact:_contact];
    
    viewModel.firstName = @"New Value";
    
    NSString *fullName = [NSString stringWithFormat:@"%@ %@", viewModel.firstName, viewModel.lastName];
    XCTAssertEqualObjects(fullName, viewModel.fullName, @"");
}

- (void)testWhenLastNameInViewModelChangesShouldSetFullName
{
    ContactDetailViewModel *viewModel = [[ContactDetailViewModel alloc] initWithContact:_contact];
    
    viewModel.lastName = @"New Value";
    
    NSString *fullName = [NSString stringWithFormat:@"%@ %@", viewModel.firstName, viewModel.lastName];
    XCTAssertEqualObjects(fullName, viewModel.fullName, @"");
}



@end
