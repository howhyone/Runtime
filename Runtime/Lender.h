//
//  Lender.h
//  Runtime
//
//  Created by mob on 2018/6/26.
//  Copyright © 2018年 mob. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Lender : NSObject

{
    float alone;
}
@property float alone;

-(void)lenderStart;

+(void)lenderEnd;
@end
