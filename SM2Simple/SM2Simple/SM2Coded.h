//
//  SM2Coded.h
//  SM2Simple
//
//  Created by bolei on 16/12/6.
//  Copyright © 2016年 pingan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SM2Coded : NSObject

+ (NSString *)sm2Encode:(NSString *)str key:(NSString *)key;

+ (NSString *)sm2Decode:(NSString *)str key:(NSString *)key;

+ (NSArray *)generyKeyPair;

@end
