#import <OCMock/OCMock.h>

#import "BaseTestCase.h"
#import "ContactDataController.h"
#import "ContactListViewController.h"
#import "ContactManagerViewModel.h"
#import "MainWindowController.h"

@interface MainWindowController (Tests)

@property(nonatomic, assign) IBOutlet NSView *listView;
@property(nonatomic, assign) IBOutlet NSView *detailView;

@end

@interface MainWindowControllerTests : BaseTestCase

@property(nonatomic, strong) MainWindowController *mainWindowController;
@property(nonatomic, assign) NSWindow *window;

@end

@implementation MainWindowControllerTests

- (void)setUp {
    [super setUp];

    id contactDataController = [OCMockObject mockForClass:ContactDataController.class];
    [[[contactDataController stub] andReturn:nil] contacts];
    ContactManagerViewModel *viewModel = [[ContactManagerViewModel alloc] initWithContactDataController:contactDataController];
    self.mainWindowController = [[MainWindowController alloc] initWithContactManagerViewModel:viewModel];
    self.window = self.mainWindowController.window;
}

- (void)tearDown {
    [self.mainWindowController close];
    self.mainWindowController = nil;
    self.window = nil;

    [super tearDown];
}

- (void)testShouldHaveValidNibName {
    XCTAssertEqualObjects(self.mainWindowController.windowNibName, @"MainWindowController",
                    @"The nib for this window should be MainWindowController.xib");
}

- (void)testShouldLoadWindow {
    XCTAssertNotNil(self.window, @"The window should be connected to the window controller.");
}

- (void)testShouldConnectListView {
    XCTAssertNotNil(self.mainWindowController.listView, @"The list view should be connected to the window controller.");
}

- (void)testShouldConnectDetailView {
    XCTAssertNotNil(self.mainWindowController.detailView, @"The detail view should be connected to the window controller.");
}

@end
