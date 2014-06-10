#import "ContactManagerAppDelegate.h"
#import "MainWindowController.h"
#import "CoreDataController.h"
#import "ContactDataController.h"

#import "ContactManagerViewModel.h"

@interface ContactManagerAppDelegate ()

@property(nonatomic, strong) MainWindowController *mainWindowController;
@property(nonatomic, strong) CoreDataController *coreDataController;
@property(nonatomic, strong) ContactDataController *contactDataController;
@property(nonatomic, strong) ContactManagerViewModel *viewModel;

- (void)showMainWindow;

@end

@implementation ContactManagerAppDelegate

#pragma mark - Memory Management

- (instancetype)init {
    self = [super init];
    if (self) {
        self.coreDataController = [[CoreDataController alloc] initWithInitialType:NSSQLiteStoreType modelName:@"ContactManagerModel.momd" applicationSupportName:@"ContactManager" dataStoreName:@"ContactManager.sql"];
        self.contactDataController = [[ContactDataController alloc] initWithCoreDataController:self.coreDataController];
        self.viewModel = [[ContactManagerViewModel alloc] initWithContactDataController:self.contactDataController];
        self.mainWindowController = [[MainWindowController alloc] initWithContactManagerViewModel:self.viewModel];
    }
    return self;
}


#pragma mark - NSApplicationDelegate methods

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    [self showMainWindow];
}

- (NSUndoManager *)windowWillReturnUndoManager:(NSWindow *)window {
    return [[self.coreDataController managedObjectContext] undoManager];
}

- (NSApplicationTerminateReply)applicationShouldTerminate:(NSApplication *)sender {
    NSError *error = nil;
    NSUInteger reply = NSTerminateNow;
    BOOL saved = [self.coreDataController save:&error];

    if (!saved) {
        BOOL errorResult = [[NSApplication sharedApplication] presentError:error];

        if (errorResult) {
            reply = NSTerminateCancel;
        } else {
            NSInteger alertReturn = NSRunAlertPanel(nil, FCLocalizedString(@"QuitQuestion"), FCLocalizedString(@"Quit"), FCLocalizedString(@"Cancel"), nil);
            if (alertReturn == NSAlertAlternateReturn) {
                reply = NSTerminateCancel;
            }
        }
    }
    return reply;
}

- (BOOL)applicationShouldHandleReopen:(NSApplication *)theApplication hasVisibleWindows:(BOOL)flag {
    if (flag) return YES;

    [self showMainWindow];
    return NO;
}

- (void)applicationWillTerminate:(NSNotification *)theNotification {
    [self.mainWindowController close];
}

#pragma mark - Private methods

- (void)showMainWindow {
    [[self.mainWindowController window] makeKeyAndOrderFront:self];
}

@end
