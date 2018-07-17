//
//  SUTRuntimeMethod.m
//  Runtime
//
//  Created by mob on 2018/7/6.
//  Copyright © 2018年 mob. All rights reserved.
//

#import "SUTRuntimeMethod.h"

@implementation SUTRuntimeMethod

+(instancetype)boject
{
    return [[self alloc] init];
}

-(instancetype)init
{
    self = [super init];
    if (self != nil) {
        _helper = [[SUTRuntimeMethodHelper alloc] init];
    }
    return self;
}

-(void)test
{
    [self performSelector:@selector(method2)];
}

-(id)forwardingTargetForSelector:(SEL)aSelector
{
    NSLog(@"----- forwordingTargetFroSelectro------ ");
    NSString *selectorString = NSStringFromSelector(aSelector);
    if ([selectorString isEqualToString:@"method2"]) {
        return _helper;
    }
    return [super forwardingTargetForSelector:aSelector];
}

-(NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector
{
    NSMethodSignature *signature = [super methodSignatureForSelector:aSelector];
    if (!signature) {
        if ([SUTRuntimeMethodHelper instancesRespondToSelector:aSelector]) {
            signature = [SUTRuntimeMethodHelper instanceMethodSignatureForSelector:aSelector];
        }
    }
    return signature; 
}

-(void)forwardInvocation:(NSInvocation *)anInvocation
{
    if ([SUTRuntimeMethodHelper instancesRespondToSelector:anInvocation.selector]) {
        [anInvocation invokeWithTarget:_helper];
    }
}

@end
