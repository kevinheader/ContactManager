//
//  ContactManagerViewModel.h
//  ContactManager
//
//  Created by Scott Densmore on 6/1/14.
//  Copyright (c) 2014 Scott Densmore. All rights reserved.
//

#import "RVMViewModel.h"

@class ContactDataController;
@class RACCommand;
@class ContactViewModel;

@interface ContactManagerViewModel : RVMViewModel

@property (nonatomic, strong, readonly) RACSignal *updatedContentSignal;
@property (nonatomic, strong, readonly) RACSignal *selectedContactChangedSignal;
@property (nonatomic, strong, readonly) RACCommand *addContactCommand;
@property (nonatomic, strong, readonly) RACCommand *deleteContactCommand;
@property (nonatomic, strong, readonly) ContactViewModel *selectedContact;
@property (nonatomic, strong, readonly) NSArray *contacts;

- (instancetype)initWithContactDataController:(ContactDataController *)controller;

- (ContactViewModel *)selectContactViewModelForIndex:(NSUInteger)index;

@end
