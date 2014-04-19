//
//  ContactDetailViewModel.h
//  ContactManager
//
//  Created by Scott Densmore on 4/13/14.
//  Copyright (c) 2014 Scott Densmore. All rights reserved.
//

@class Contact;

@interface ContactDetailViewModel : NSObject

@property (nonatomic, strong) NSString *firstName;
@property (nonatomic, strong) NSString *lastName;
@property (nonatomic, strong) NSString *emailAddress;
@property (nonatomic, strong) NSString *phoneNumber;
@property (nonatomic, strong, readonly) NSString *fullName;

- (instancetype)initWithContact:(Contact *)contact;

@end
