//
//  FirstView.m
//  Runtime
//
//  Created by mob on 2018/6/26.
//  Copyright © 2018年 mob. All rights reserved.
//

#import "FirstView.h"

#import <objc/message.h>

@implementation FirstView

-(id)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame]) {
        
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 200, 100, 100)];
        _nameLabel.text = @"hahahah";
        [self addSubview:_nameLabel];
        
    }
    return self;
}

void studyEngilsh(id self, SEL _cmd) {
    
    NSLog(@"动态添加了一个学习英语的方法");
}

-(void)run
{
    NSLog(@"People run");
}

-(void)studyChinese
{
    NSLog(@"studyChinese )_)__");
}

+(BOOL)resolveInstanceMethod:(SEL)sel
{
    if (sel == NSSelectorFromString(@"studyEngilsh")) {
        class_addMethod(self, sel, (IMP)studyEngilsh, "v@:");
        return YES;
    }
    return [super resolveInstanceMethod:sel];
}

@end
