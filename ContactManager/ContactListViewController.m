//
//  ContactListViewController.m
//  ContactManager
//
//  Created by Scott Densmore on 6/14/11.
//  Copyright 2011 Scott Densmore. All rights reserved.
//

#import <ReactiveCocoa/ReactiveCocoa.h>
#import <ReactiveCocoa/RACEXTScope.h>

#import "ContactListViewController.h"

#import "ContactManagerViewModel.h"

#import "ContactDataController.h"

#import "Contact.h"

@interface ContactListViewController()

@property (nonatomic, assign) IBOutlet NSArrayController *contactsArrayController;
@property (nonatomic, assign) IBOutlet NSTableView *tableView;

@property (nonatomic, weak) ContactManagerViewModel *viewModel;

@end

@implementation ContactListViewController

#pragma mark - Memory Management

- (instancetype)init {
    return [self initWithContactManagerViewModel:nil];
}

- (instancetype)initWithContactManagerViewModel:(ContactManagerViewModel *)viewModel {
    NSParameterAssert(viewModel != nil);
    
    self = [super init];
    if (self) {
        self.viewModel = viewModel;
    }
    return self;
}


#pragma mark - Accessors

- (NSArray *)contacts {
    return self.viewModel.contacts;
}

#pragma mark - View methods

- (void)awakeFromNib {
    [super awakeFromNib];
    if (self.contactsArrayController.selectedObjects.count) {
        [self.viewModel selectContactViewModelForIndex:self.contactsArrayController.selectionIndex];
    }
    
    @weakify(self);
    [self.viewModel.updatedContentSignal subscribeNext:^(id x) {
        @strongify(self);
        [self willChangeValueForKey:@"contacts"];
        [self didChangeValueForKey:@"contacts"];
        //[self.viewModel selectContactViewModelForIndex:self.contactsArrayController.selectionIndex];
    }];
}

- (NSString *)nibName {
    return NSStringFromClass([self class]);
}

#pragma mark - NSTableViewDelegate methods

- (void)tableViewSelectionDidChange:(NSNotification *)aNotification  {
    [self.viewModel selectContactViewModelForIndex:self.contactsArrayController.selectionIndex];
}

@end
