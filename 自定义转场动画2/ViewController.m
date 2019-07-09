//
//  ViewController.m
//  自定义转场动画2
//
//  Created by zachary spark on 2019/7/9.
//  Copyright © 2019 Struggle3g. All rights reserved.
//

#import "ViewController.h"
#import "TwoVC.h"
#import "GGCircleTransition.h"
@interface ViewController ()<UIViewControllerTransitioningDelegate>

@end

@implementation ViewController

- (UIButton *)CallbackHandle{
    return _OneBut;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"touchesBegan");
    
}

- (IBAction)OneClick:(id)sender {
    TwoVC *tovc =  [[TwoVC alloc]init];
    tovc.handle = self;
    [self presentViewController:tovc animated:YES completion:nil];
    
}


- (void)dealloc
{
    NSLog(@"ViewController 释放了");
}



@end
