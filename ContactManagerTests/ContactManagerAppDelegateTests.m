#import <XCTest/XCTest.h>
#import "ContactManagerAppDelegate.h"

@interface ContactManagerAppDelegateTests : XCTestCase

@property(nonatomic, strong) ContactManagerAppDelegate *appDelegate;

@end

@implementation ContactManagerAppDelegateTests

- (void)setUp {
    [super setUp];

    self.appDelegate = [[ContactManagerAppDelegate alloc] init];
}

- (void)tearDown {
    self.appDelegate = nil;

    [super tearDown];
}

@end
