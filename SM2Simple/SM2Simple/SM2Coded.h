//
//  SM2Coded.h
//  SM2Simple
//
//  Created by bolei on 16/12/6.
//  Copyright © 2016年 pingan. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    ESM2ModeC123 = 0, //标准的国密加密算法，加密后的串顺序为C1C2C3
    ESM2ModeC132, //旧版的国密加密算法,加密后的串顺序为C1C3C2
} SM2Mode;



@interface SM2Coded : NSObject

+ (NSString *)sm2Encode:(NSString *)str key:(NSString *)key;

+ (NSString *)sm2Decode:(NSString *)str key:(NSString *)key;


+ (NSString *)sm2Encode:(NSString *)str key:(NSString *)key mode:(SM2Mode)model;

+ (NSString *)sm2Decode:(NSString *)str key:(NSString *)key mode:(SM2Mode)model;


@end
