#import <ReactiveCocoa/ReactiveCocoa.h>

#import "ContactViewModel.h"

#import "Contact.h"

@interface ContactViewModel ()

@property(nonatomic, strong) Contact *contact;
@property(nonatomic, strong, readwrite) NSString *fullName;

@end

@implementation ContactViewModel

- (instancetype)init {
    return [self initWithContact:nil];
}

- (instancetype)initWithContact:(Contact *)contact {
    //NSParameterAssert(contact != nil);

    self = [super init];
    if (self && contact != nil) {
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
