//
//  GGCircleTransition.h
//  自定义转场动画
//
//  Created by zachary spark on 2019/7/8.
//  Copyright © 2019 Struggle3g. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, GGCircleTransitionType) {
    GGCircleTransitionTypePresentation = 0,
    GGCircleTransitionTypeDissmiss = 1,
    GGCircleTransitionTypePush = 2,
    GGCircleTransitionTypePop = 3
};


@interface GGCircleTransition : NSObject<UIViewControllerAnimatedTransitioning>
@property(nonatomic,assign)GGCircleTransitionType Type;

- (instancetype)initWithTransitionType:(GGCircleTransitionType)type View:(UIView *)CircleView;



@end

NS_ASSUME_NONNULL_END
