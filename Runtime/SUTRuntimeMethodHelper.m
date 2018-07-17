//
//  SUTRuntimeMethodHelper.m
//  Runtime
//
//  Created by mob on 2018/7/6.
//  Copyright © 2018年 mob. All rights reserved.
//

#import "SUTRuntimeMethodHelper.h"

@implementation SUTRuntimeMethodHelper

-(void)method2
{
    NSLog(@"self = %@ ******************* _cmd =%p",self, _cmd);
}

@end
