//
//  TwoVC.h
//  自定义转场动画2
//
//  Created by zachary spark on 2019/7/9.
//  Copyright © 2019 Struggle3g. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@protocol GGTwoCallbackHandle <NSObject>
- (UIButton *)CallbackHandle;
@end


@interface TwoVC : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *TwoBut;

@property(nonatomic,weak) id<GGTwoCallbackHandle> handle;
@end

NS_ASSUME_NONNULL_END
