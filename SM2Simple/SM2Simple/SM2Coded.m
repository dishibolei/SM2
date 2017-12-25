//
//  SM2Coded.m
//  SM2Simple
//
//  Created by bolei on 16/12/6.
//  Copyright © 2016年 pingan. All rights reserved.
//

#import "SM2Coded.h"
#import "sm2.h"
#import "NSData+HexString.h"

@implementation SM2Coded

#define kC1Length 64 * 2 //转成2进制后长度乘以2
#define kC3Length 32 * 2

+ (NSString *)sm2Encode:(NSString *)str key:(NSString *)key {
    if ([str length] == 0 || [key length] == 0) {
        return @"";
    }
    
    unsigned char result[1024] = {0};
    unsigned long outlen = 1024;
    const char *encryptData = [str cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *keyData =  [NSData dataFromHexString:key];
    
    int ret = GM_SM2Encrypt(result,&outlen,(unsigned char *)encryptData,strlen(encryptData),(unsigned char *)keyData.bytes,keyData.length);
    
    if (outlen < 2 || ret != MP_OKAY) {
        //加密出错了
        return @"";
    }
    
    //多一位\x04 需要去掉
    NSData *data = [NSData dataWithBytes:result + 1 length:outlen - 1];
    
    return [data hexStringFromData:data];
}

+ (NSString *)sm2Decode:(NSString *)str key:(NSString *)key {
    //密文长度至少也需要64+32位
    if ([str length] < 64 + 32 || [key length] == 0) {
        return @"";
    }
    
    unsigned char result[1024 * 8] = {0};
    
    unsigned char pass[1024] = {0};
    
    NSData *keyData =  [NSData dataFromHexString:key];
    
    NSData *data = [NSData dataFromHexString:str];
    pass[0] = '\x04'; //需要补一位\x04
    memcpy(pass + 1, data.bytes, data.length);
    
    unsigned long outlen = 1024;
    
    int ret = GM_SM2Decrypt((unsigned char *)result, &outlen, pass, data.length + 1, (unsigned char *)keyData.bytes, keyData.length);

    if (outlen == 0 || ret != MP_OKAY) {
        //加密出错了
        return @"";
    }
    NSString *resultStr = [[NSString alloc] initWithBytes:result length:outlen encoding:NSUTF8StringEncoding];
    
    return resultStr;
}




+ (NSString *)sm2Encode:(NSString *)str key:(NSString *)key mode:(SM2Mode)model {
    NSString *result = [self sm2Encode:str key:key];
    
    if (result.length == 0 || [result length] < 64 + 32) {
        return result;
    }
    
    switch (model) {
        case ESM2ModeC123:
            return result; //标准算法，直接返回
            break;
        case ESM2ModeC132:
        {
            NSString *C1 = [result substringToIndex:kC1Length];
            NSString *C2 = [result substringWithRange:NSMakeRange(kC1Length, result.length - kC1Length - kC3Length)];
            NSString *C3 = [result substringFromIndex:result.length - kC3Length];
            
            NSString *nResult = [NSString stringWithFormat:@"%@%@%@",C1,C3,C2];
            return nResult;
        }
            
            break;
        default:
            break;
    }
}



+ (NSString *)sm2Decode:(NSString *)str key:(NSString *)key mode:(SM2Mode)model {
    if ([str length] < 64 + 32 || [key length] == 0) {
        return @"";
    }
    
    switch (model) {
        case ESM2ModeC123:
            return [self sm2Decode:str key:key];
            break;
        case ESM2ModeC132: {
            //顺序是C1C3C2
            NSString *C1 = [str substringToIndex:kC1Length];
            NSString *C3 = [str substringWithRange:NSMakeRange(kC1Length, kC3Length)];
            NSString *C2 = [str substringFromIndex:kC1Length + kC3Length];
            
            NSString *nStr = [NSString stringWithFormat:@"%@%@%@",C1,C2,C3];
            return [self sm2Decode:nStr key:key];
        }
            break;
        default:
            break;
    }
}





@end
