#import <XCTest/XCTest.h>

@interface BaseTestCase : XCTestCase

- (BOOL)checkControl:(NSControl *)control sendsAction:(SEL)action toTarget:(id)target;

- (BOOL)checkOutlet:(id)outlet connectsTo:(id)destination;

- (BOOL)checkObject:(id)source hasBinding:(NSString *)binding toObject:(id)destination through:(NSString *)keyPath;

@end
