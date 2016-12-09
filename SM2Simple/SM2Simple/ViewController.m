//
//  ViewController.m
//  SM2Simple
//
//  Created by bolei on 16/12/1.
//  Copyright © 2016年 pingan. All rights reserved.
//

#import "ViewController.h"
#import "SM2Coded.h"

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
    NSString *publicKey = @"9dedc269d3a76b44fd8e3d88b8e7857f5b658a983c858bf1c76efdce5a6f6673af30d2c7acf1d43529ae369693f4dfdd26300705f00e228eb813d91af500df48";
    NSString *priviteKey = @"37503364450f93fdb5c230b14bb166af209d5e0393575e8ec277a92dc6ec9b15";
    
    NSString *str = @"12345678";
    NSString *encode = [SM2Coded sm2Encode:str key:publicKey];
    NSString *decode = [SM2Coded sm2Decode:encode key:priviteKey];
    NSLog(@"encode = %@ , decode = %@",encode,decode);
    
}
@end
