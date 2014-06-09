//
//  ContactDetailViewController.h
//  ContactManager
//
//  Created by Scott Densmore on 6/20/11.
//  Copyright 2011 Scott Densmore. All rights reserved.
//

#import <Cocoa/Cocoa.h>

//@class Contact;
@class ContactViewModel;
@class ContactManagerViewModel;

@interface ContactDetailViewController : NSViewController 

@property (nonatomic, strong) ContactViewModel *contact;

- (instancetype)initWithContactManagerViewModel:(ContactManagerViewModel *)viewModel;

@end
