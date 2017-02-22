//
//  UIView+Common.h
//  KillingSpree
//
//  Copyright (c) 2015年 ZhengChaoJie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Common)

@end

@interface UIView (Postion)

/**
 * 获取屏幕宽度
 *
 * @return 屏幕宽度
 */
CGFloat screenWidth();
/**
 * 获取屏幕高度
 *
 * @return 屏幕高度
 */
CGFloat screenHeight();
/**
 *  根据 frame 返回宽高
 *
 *  @param rect 视图的 frame
 *
 *  @return frame 的宽高
 */
CGFloat width(CGRect rect);
CGFloat height(CGRect rect);

/**
 *  返回当前视图的宽
 *
 *  @return 视图的宽
 */
- (CGFloat)getWidth;
/**
 *  返回当前视图的高
 *
 *  @return 视图的高
 */
- (CGFloat)getHeight;

CGFloat maxX(UIView *view);
CGFloat minX(UIView *view);
CGFloat midX(UIView *view);
CGFloat maxY(UIView *view);
CGFloat minY(UIView *view);
CGFloat midY(UIView *view);
/**
 *  获取子视图的父视图
 *
 *  @return
 */
- (UIViewController*)myViewController;

/**
 *  根据View 和 view 的高 宽 返回起点 Y X
 *
 *  @param view
 *  @param height
 *
 *  @return 返回起点 Y X
 */
CGFloat center_Y(UIView *view ,CGFloat height);

CGFloat center_X(UIView *view ,CGFloat width);

CGFloat center_topY(UIView *view1 ,UIView *view2);

CGFloat center_topX(UIView *view1 ,UIView *view2);

/**
 *  1.间隔X值
 */
@property (nonatomic, assign) CGFloat x;

/**
 *  2.间隔Y值
 */
@property (nonatomic, assign) CGFloat y;

/**
 *  3.宽度
 */
@property (nonatomic, assign) CGFloat width;

/**
 *  4.高度
 */
@property (nonatomic, assign) CGFloat height;

/**
 *  5.中心点X值
 */
@property (nonatomic, assign) CGFloat centerX;

/**
 *  6.中心点Y值
 */
@property (nonatomic, assign) CGFloat centerY;

/**
 *  7.尺寸大小
 */
@property (nonatomic, assign) CGSize size;

/**
 *  8.起始点
 */
@property (nonatomic, assign) CGPoint origin;

/**
 *  9.上 < Shortcut for frame.origin.y
 */
@property (nonatomic) CGFloat top;

/**
 *  10.下 < Shortcut for frame.origin.y + frame.size.height
 */
@property (nonatomic) CGFloat bottom;

/**
 *  11.左 < Shortcut for frame.origin.x.
 */
@property (nonatomic) CGFloat left;

/**
 *  12.右 < Shortcut for frame.origin.x + frame.size.width
 */
@property (nonatomic) CGFloat right;


/**
 *  1.添加边框
 *
 *  @param color <#color description#>
 */
- (void)addBorderColor:(UIColor *)color;

/**
 *  2.UIView 的点击事件
 *
 *  @param target   目标
 *  @param action   事件
 */

- (void)addTarget:(id)target
           action:(SEL)action;

@end
