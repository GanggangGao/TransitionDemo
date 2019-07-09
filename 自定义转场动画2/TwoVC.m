//
//  TwoVC.m
//  自定义转场动画2
//
//  Created by zachary spark on 2019/7/9.
//  Copyright © 2019 Struggle3g. All rights reserved.
//

#import "TwoVC.h"
#import "GGCircleTransition.h"

@interface TwoVC ()<UIViewControllerTransitioningDelegate>

@end

@implementation TwoVC

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.transitioningDelegate = self;
        self.modalPresentationStyle = UIModalPresentationCustom;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"two  touchesBegan");
    
}


#pragma mark -- UIViewControllerTransitioningDelegate

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    
    UIButton *btn;
    if([self.handle respondsToSelector:@selector(CallbackHandle)]){
        btn = [self.handle CallbackHandle];
    }
    
   GGCircleTransition *ggtrans = [[GGCircleTransition alloc]initWithTransitionType:GGCircleTransitionTypePresentation View:btn];
    
    
    return ggtrans;
}


- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    
    UIButton *btn;
    if([self.handle respondsToSelector:@selector(CallbackHandle)]){
        
        btn = [self.handle CallbackHandle];
    }
    
    GGCircleTransition *ggtrans = [[GGCircleTransition alloc]initWithTransitionType:GGCircleTransitionTypeDissmiss View:btn];
    
    return ggtrans;
}


- (IBAction)TwoClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)dealloc
{
    NSLog(@"twoVC 释放了");
}


@end
