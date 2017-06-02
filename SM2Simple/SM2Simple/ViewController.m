//
//  ViewController.m
//  SM2Simple
//
//  Created by bolei on 16/12/1.
//  Copyright © 2016年 pingan. All rights reserved.
//

#import "ViewController.h"
#import "SM2Coded.h"
#import "sm2.h"

@interface ViewController ()
- (IBAction)testAction:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)testAction:(id)sender {
    
    NSArray *keyPair = [SM2Coded generyKeyPair];
    NSLog(@"keyPaic = %@",keyPair);
    
    NSString *publicKey = [NSString stringWithFormat:@"%@%@",keyPair[0],keyPair[1]];
    NSString *priviteKey = keyPair[2];
    
    NSLog(@"publicKey = %@ , priKey = %@",publicKey,priviteKey);
    
#ifdef _DEBUG //这个定义在了sm2上
    //测试 debug下的值
    //NSString *publicKey = @"435B39CCA8F3B508C1488AFC67BE491A0F7BA07E581A0E4849A5CF70628A7E0A75DDBA78F15FEECB4C7895E2C1CDF5FE01DEBB2CDBADF45399CCF77BBA076A42";
    
    //NSString *priviteKey = @"1649AB77A00637BD5E2EFE283FBF353534AA7F7CB89463F208DDBC2920BB0DA0";
    
    //NSString *publicKey = [NSString stringWithFormat:@"%@%@",keyPair[0],keyPair[1]];
    //NSString *priviteKey = keyPair[2];
    
    //NSLog(@"publicKey = %@ , priKey = %@",publicKey,priviteKey);
    
#else
    
    //标准曲线的公钥 如果没定义_DEBUG就用这个参数
   // NSString *publicKey = @"9dedc269d3a76b44fd8e3d88b8e7857f5b658a983c858bf1c76efdce5a6f6673af30d2c7acf1d43529ae369693f4dfdd26300705f00e228eb813d91af500df48";
    //NSString *priviteKey = @"37503364450f93fdb5c230b14bb166af209d5e0393575e8ec277a92dc6ec9b15";
    
#endif
    
    NSString *str = @"encryption standard";
    NSString *encode = [SM2Coded sm2Encode:str key:publicKey];
    NSLog(@"encode finished");
    NSString *decode = [SM2Coded sm2Decode:encode key:priviteKey];
    NSLog(@"encode = %@ , decode = %@",encode,decode);
    
}
@end
