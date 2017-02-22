

#import "UIView+Common.h"

@implementation UIView (Common)

@end

@implementation UIView (Postion)

/**
 * 获取屏幕宽度
 *
 * @return 屏幕宽度
 */
CGFloat screenWidth() {
    return [[UIScreen mainScreen] bounds].size.width;
}

/**
 * 获取屏幕高度
 *
 * @return 屏幕高度
 */
CGFloat screenHeight() {
    return [[UIScreen mainScreen] bounds].size.height;
}

/**
 *  根据 frame 返回宽高
 *
 *  @param rect 视图的 frame
 *
 *  @return frame 的宽高
 */
CGFloat width(CGRect rect) {
    return rect.size.width;
}

CGFloat height(CGRect rect) {
    return rect.size.height;
}

/**
 *  返回当前视图的宽
 *
 *  @return 视图的宽
 */
- (CGFloat)getWidth {
    return self.frame.size.width;
}
/**
 *  返回当前视图的高
 *
 *  @return 视图的高
 */
- (CGFloat)getHeight {
    return self.frame.size.height;
}
/**
 *  返回当前视图的点坐标
 *
 *  @param view 当前视图
 *
 *  @return 视图的点坐标
 */

CGFloat maxX(UIView *view) {
    return CGRectGetMaxX(view.frame);
}

CGFloat minX(UIView *view) {
    return CGRectGetMinX(view.frame);
}

CGFloat midX(UIView *view) {
    return CGRectGetMidX(view.frame);
}

CGFloat maxY(UIView *view) {
    return CGRectGetMaxY(view.frame);
}

CGFloat minY(UIView *view) {
    return CGRectGetMinY(view.frame);
}

CGFloat midY(UIView *view) {
    return CGRectGetMidY(view.frame);
}

/**
 *  获取子视图的父视图
 *
 *  @return
 */
- (UIViewController*)myViewController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}

/**
 *  根据View 和 view 的高 宽 返回起点 Y X
 *
 *  @param view
 *  @param height
 *
 *  @return 返回起点 Y X
 */
CGFloat center_Y(UIView *view ,CGFloat height) {
    return (CGRectGetHeight(view.frame) - height) / 2;
}

CGFloat center_X(UIView *view ,CGFloat width) {
    return (CGRectGetWidth(view.frame) - width) / 2;
}

CGFloat center_topY(UIView *view1 ,UIView *view2) {
    return (CGRectGetHeight(view1.frame) - CGRectGetHeight(view2.frame)) / 2;
}

CGFloat center_topX(UIView *view1 ,UIView *view2) {
    return (CGRectGetWidth(view1.frame) - CGRectGetWidth(view2.frame)) / 2;
}

- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)x
{
    return self.frame.origin.x;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (UIView * (^)(CGFloat x))setX
{
    return ^(CGFloat x) {
        self.x = x;
        return self;
    };
}

- (void)setCenterX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)centerX
{
    return self.center.x;
}

- (void)setCenterY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)centerY
{
    return self.center.y;
}

- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)size
{
    return self.frame.size;
}

- (void)setOrigin:(CGPoint)origin
{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGPoint)origin
{
    return self.frame.origin;
}

- (CGFloat)left {
    return self.frame.origin.x;
}

- (void)setLeft:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)top {
    return self.frame.origin.y;
}

- (void)setTop:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)right {
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setRight:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)bottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setBottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}


- (UIView *(^)(UIColor *color)) setColor
{
    return ^ (UIColor *color) {
        self.backgroundColor = color;
        return self;
    };
}

- (UIView *(^)(CGRect frame)) setFrame
{
    return ^ (CGRect frame) {
        self.frame = frame;
        return self;
    };
}

- (UIView *(^)(CGSize size)) setSize
{
    return ^ (CGSize size) {
        self.bounds = CGRectMake(0, 0, size.width, size.height);
        return self;
    };
}

- (UIView *(^)(CGPoint point)) setCenter
{
    return ^ (CGPoint point) {
        self.center = point;
        return self;
    };
}

- (UIView *(^)(NSInteger tag)) setTag
{
    return ^ (NSInteger tag) {
        self.tag = tag;
        return self;
    };
}

- (void)addTarget:(id)target
           action:(SEL)action;
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:target
                                                                         action:action];
    self.userInteractionEnabled = YES;
    [self addGestureRecognizer:tap];
}

- (void)addBorderColor:(UIColor *)color{
    [self.layer setBorderColor:color.CGColor];
    [self.layer setBorderWidth:0.5];
    [self.layer setCornerRadius:4];
}


@end
