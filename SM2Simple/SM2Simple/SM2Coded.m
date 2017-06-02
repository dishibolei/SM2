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


+ (NSArray *)generyKeyPair
{
    unsigned char buff[64] = {0};
    unsigned char prikeyBuff[2000] = {0};
    unsigned long priLen = 2000;

    GM_GenSM2keypair(prikeyBuff, &priLen, buff);
     
    NSData *pubXD = [NSData dataWithBytes:buff length:32];
    NSData *pubYD = [NSData dataWithBytes:buff+32 length:32];
    NSData *priD = [NSData dataWithBytes:prikeyBuff length:priLen];
    
    NSString *pubX = [pubXD hexStringFromData:pubXD];
    NSString *pubY = [pubYD hexStringFromData:pubYD];
    NSString *pri = [priD hexStringFromData:priD];
    
    return @[pubX,pubY,pri];
}



@end
