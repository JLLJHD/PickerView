//
//  HDPickerView.h
//  PickerViewDemo
//
//  Created by 郑超杰 on 2017/2/22.
//  Copyright © 2017年 ButterJie. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SelectAreaBlock)(NSString *province, NSString *city, NSString *area, NSString *streets);

@interface HDPickerView : UIButton

@property (nonatomic, copy) SelectAreaBlock selectAreaBlock;


/**
 初始化

 @param selectAreaBlock <#selectAreaBlock description#>
 @return <#return value description#>
 */
+ (instancetype)selectArea:(SelectAreaBlock)selectAreaBlock;

- (void)show;

- (void)dismiss;
@end
