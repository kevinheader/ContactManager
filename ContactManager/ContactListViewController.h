//
//  ContactListViewController.h
//  ContactManager
//
//  Created by Scott Densmore on 6/14/11.
//  Copyright 2011 Scott Densmore. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class ContactManagerViewModel;

@interface ContactListViewController : NSViewController <NSTableViewDelegate>

@property (nonatomic, readonly, assign) NSArray *contacts;

- (id)initWithContactManagerViewModel:(ContactManagerViewModel *)viewModel;

@end
