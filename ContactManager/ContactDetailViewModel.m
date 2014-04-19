//
//  ContactDetailViewModel.m
//  ContactManager
//
//  Created by Scott Densmore on 4/13/14.
//  Copyright (c) 2014 Scott Densmore. All rights reserved.
//

#import "ContactDetailViewModel.h"

#import "Contact.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface ContactDetailViewModel()

@property (nonatomic, strong) Contact *contact;
@property (nonatomic, strong, readwrite) NSString *fullName;

@end

@implementation ContactDetailViewModel

- (instancetype)init {
    return [self initWithContact:nil];
}

- (instancetype)initWithContact:(Contact *)contact {
    NSParameterAssert(contact != nil);
    
    self = [super init];
    if (self) {
        self.contact = contact;
        RACChannelTo(self, firstName) = RACChannelTo(self.contact, firstName);
        RACChannelTo(self, lastName) = RACChannelTo(self.contact, lastName);
        RACChannelTo(self, emailAddress) = RACChannelTo(self.contact, emailAddress);
        RACChannelTo(self, phoneNumber) = RACChannelTo(self.contact, phoneNumber);
        RAC(self, fullName) = [RACSignal combineLatest:@[RACObserve(self.contact, firstName), RACObserve(self.contact, lastName)] reduce:^id(NSString *firstName, NSString *lastName){
            return [NSString stringWithFormat:@"%@ %@", firstName, lastName];
        }];
    
    }
    return self;
}

@end
