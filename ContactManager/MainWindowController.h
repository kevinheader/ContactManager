//
//  MainWindowController.h
//  ContactManager
//
//  Created by Scott Densmore on 6/13/11.
//  Copyright 2011 Scott Densmore. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class ContactManagerViewModel;

@interface MainWindowController : NSWindowController

- (instancetype)initWithContactManagerViewModel:(ContactManagerViewModel *)viewModel;

@end
