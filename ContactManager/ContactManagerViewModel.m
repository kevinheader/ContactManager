#import <ReactiveCocoa/ReactiveCocoa.h>
#import <ReactiveCocoa/RACEXTScope.h>

#import "ContactManagerViewModel.h"
#import "ContactViewModel.h"

#import "ContactDataController.h"

@interface ContactManagerViewModel ()

@property(nonatomic, strong) RACSubject *updatedContentSignal;
@property(nonatomic, strong) RACSubject *selectedContactChangedSignal;
@property(nonatomic, strong) ContactDataController *contactController;
@property(nonatomic, strong) RACCommand *addContactCommand;
@property(nonatomic, strong) RACCommand *deleteContactCommand;
@property(nonatomic, strong) ContactViewModel *selectedContact;
@property(nonatomic, strong) NSArray *viewModels;

- (RACSignal *)enableDeleteSignal;

@end

@implementation ContactManagerViewModel

- (instancetype)init {
    return [self initWithContactDataController:nil];
}

- (instancetype)initWithContactDataController:(ContactDataController *)controller {
    NSParameterAssert(controller != nil);

    self = [super init];
    if (self) {

        self.contactController = controller;
        self.updatedContentSignal = [[RACSubject subject] setNameWithFormat:@"ContactManagerViewModel updatedContentSignal"];
        @weakify(self);
        self.addContactCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            return [RACSignal createSignal:^RACDisposable *(id <RACSubscriber> subscriber) {
                @strongify(self);
                self.viewModels = nil;
                self.selectedContact = [[ContactViewModel alloc] initWithContact:[self.contactController createContact]];
                [(RACSubject *) self.selectedContactChangedSignal sendNext:self.selectedContact];
                [(RACSubject *) self.updatedContentSignal sendNext:nil];
                [subscriber sendCompleted];
                return nil;
            }];
        }];

        self.deleteContactCommand = [[RACCommand alloc] initWithEnabled:[self enableDeleteSignal] signalBlock:^RACSignal *(id input) {
            return [RACSignal createSignal:^RACDisposable *(id <RACSubscriber> subscriber) {
                @strongify(self);
                if (self.selectedContact) {
                    self.viewModels = nil;
                    [self.contactController deleteContact:self.selectedContact.contact];
                    [(RACSubject *) self.updatedContentSignal sendNext:nil];
                }
                [subscriber sendCompleted];
                return nil;
            }];
        }];

        self.selectedContactChangedSignal = [[RACSubject subject] setNameWithFormat:@"ContactManagerViewModel updatedContentSignal"];


    }
    return self;
}

- (RACSignal *)enableDeleteSignal {
    return [RACSignal combineLatest:@[RACObserve(self, selectedContact)] reduce:^id(ContactViewModel *contact){
        return @(contact != nil);
    }];
}

- (NSArray *)contacts {
    if (self.viewModels != nil) {
        return self.viewModels;
    }
    // TODO: This is to heavy weight... need to do something better
    self.viewModels = [[self.contactController.contacts.rac_sequence map:^id(Contact *value) {
        return [[ContactViewModel alloc] initWithContact:value];
    }] array];
    return self.viewModels;
}

- (ContactViewModel *)selectContactViewModelForIndex:(NSUInteger)index {
    ContactViewModel *contact = self.contacts[index];
    self.selectedContact = contact;
    [(RACSubject *) self.selectedContactChangedSignal sendNext:self.selectedContact];
    return self.selectedContact;
}


@end
