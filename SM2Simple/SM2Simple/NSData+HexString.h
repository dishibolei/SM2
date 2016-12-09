//
//  NSData+HexString.h
//  FFProject
//
//  Created by xy_2501 on 9/21/15.
//  Copyright (c) 2015 pingan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (HexString)

+ (NSData *)dataFromHexString:(NSString*) hexString;

- (NSString *) hexStringFromData:(NSData*) data;

@end
