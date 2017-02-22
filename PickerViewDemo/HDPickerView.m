//
//  HDPickerView.m
//  PickerViewDemo
//
//  Created by 郑超杰 on 2017/2/22.
//  Copyright © 2017年 ButterJie. All rights reserved.
//

#import "HDPickerView.h"
#import "Constants.h"
#import "UIView+Common.h"
#import "PickerToolBar.h"

static CGFloat const PickerViewHeight = 240;
static CGFloat const PickerViewLabelWeight = 32;

@interface HDPickerView () <UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic, strong) UIPickerView *pickerView;

@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, strong, nullable) PickerToolBar *toolbar;

@property (nonatomic, strong) NSArray *rootArray;
/** 当前省数组 */
@property (nonatomic, strong, nullable) NSMutableArray *arrayProvince;
/** 当前城市数组 */
@property (nonatomic, strong, nullable) NSMutableArray *arrayCity;
/** 当前地区数组 */
@property (nonatomic, strong, nullable) NSMutableArray *arrayArea;
/** 当前街道数组 */
@property (nonatomic, strong, nullable) NSMutableArray *arrayStreets;

@property (nonatomic, strong) NSMutableDictionary *tempCountyDic;

/** 省份 */
@property (nonatomic, strong, nullable)NSString *province;
/** 城市 */
@property (nonatomic, strong, nullable)NSString *city;
/** 地区 */
@property (nonatomic, strong, nullable)NSString *area;
/** 街道*/
@property (nonatomic, strong, nullable)NSString *streetsStr;

@end

@implementation HDPickerView

+ (instancetype)selectArea:(SelectAreaBlock)selectAreaBlock {
    HDPickerView *newPickerView = [[HDPickerView alloc] init];
    newPickerView.selectAreaBlock = selectAreaBlock;
    return newPickerView;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self customUI];
        [self loadData];
    }
    return self;
}

- (void)customUI {
    self.bounds = [UIScreen mainScreen].bounds;
    self.backgroundColor = RGBA(0, 0, 0, 102.0/255);
    [self.layer setOpaque:0.0];
    [self addSubview:self.pickerView];
    [self.pickerView addSubview:self.lineView];
    [self addSubview:self.toolbar];
    [self addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screenWidth(), 0.5)];
        [_lineView setBackgroundColor:RGB(205, 205, 205)];
    }
    return _lineView;
}

- (UIPickerView *)pickerView
{
    if (!_pickerView) {
        CGFloat pickerW = screenWidth();
        CGFloat pickerH = PickerViewHeight - 44;
        CGFloat pickerX = 0;
        CGFloat pickerY = screenHeight() + 44;
        _pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(pickerX, pickerY, pickerW, pickerH)];
        [_pickerView setBackgroundColor:[UIColor whiteColor]];
        [_pickerView setDataSource:self];
        [_pickerView setDelegate:self];
    }
    return _pickerView;
}

- (PickerToolBar *)toolbar {
    if (!_toolbar) {
        _toolbar = [[PickerToolBar alloc]initWithTitle:@"选择城市地区"
                                 cancelButtonTitle:@"取消"
                                     okButtonTitle:@"确定"
                                         addTarget:self
                                      cancelAction:@selector(dismiss)
                                          okAction:@selector(selectedOk)];
        _toolbar.x = 0;
        _toolbar.y = screenHeight();
    }
    return _toolbar;
}

- (void)selectedOk {
    if (self.selectAreaBlock) {
        self.selectAreaBlock(self.province, self.city, self.area, self.streetsStr);
    }
    [self dismiss];
}

- (NSArray *)rootArray {
    if (!_rootArray) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"area" ofType:@"plist"];
        _rootArray = [[NSArray array] initWithContentsOfFile:path];
    }
    return _rootArray;
}

- (NSMutableArray *)arrayProvince
{
    if (!_arrayProvince) {
        _arrayProvince = [NSMutableArray array];
    }
    return _arrayProvince;
}

- (NSMutableArray *)arrayCity
{
    if (!_arrayCity) {
        _arrayCity = [NSMutableArray array];
    }
    return _arrayCity;
}

- (NSMutableArray *)arrayArea
{
    if (!_arrayArea) {
        _arrayArea = [NSMutableArray array];
    }
    return _arrayArea;
}

- (NSMutableArray *)arrayStreets {
    if (!_arrayStreets) {
        _arrayStreets = [NSMutableArray array];
    }
    return _arrayStreets;
}


- (void)loadData {
    
    //1. 获取省份
    [self.rootArray enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.arrayProvince addObject:obj];//获取省名 obj[@"state"]
    }];
    
    //2. 随便获取一个省的城市
    NSMutableArray *citys = [NSMutableArray arrayWithArray:[self.arrayProvince firstObject][@"cities"]];
    [citys enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.arrayCity addObject:obj];//获取市名 obj[@"city"]
    }];
    
    //3. 随便获取一个城市的（县，区，等）
    NSMutableArray *countyAry = [NSMutableArray arrayWithArray:[self.arrayCity firstObject][@"areas"]];
    [countyAry enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.arrayArea addObject:obj];//获取区名字  obj[@"county"]
    }];
    
    //4. 随便获取一个（县，区，等）的（街道，乡，等）
    NSMutableArray *streetsAry = [NSMutableArray arrayWithArray:[self.arrayArea firstObject][@"streets"]];
    [streetsAry enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.arrayStreets addObject:obj];
    }];
    [self reloadSelectAddress];
}

- (void)show {
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [self setCenter:[UIApplication sharedApplication].keyWindow.center];
    [[UIApplication sharedApplication].keyWindow bringSubviewToFront:self];
    
    CGRect frameTool = self.toolbar.frame;
    frameTool.origin.y -= PickerViewHeight;
    
    CGRect framePicker =  self.pickerView.frame;
    framePicker.origin.y -= PickerViewHeight;
    [UIView animateWithDuration:0.33 animations:^{
        [self.layer setOpacity:1];
        self.toolbar.frame = frameTool;
        self.pickerView.frame = framePicker;
    } completion:^(BOOL finished) {
    }];
}

- (void)dismiss {
    CGRect frameTool = self.toolbar.frame;
    frameTool.origin.y += PickerViewHeight;
    
    CGRect framePicker =  self.pickerView.frame;
    framePicker.origin.y += PickerViewHeight;
    [UIView animateWithDuration:0.33 animations:^{
        [self.layer setOpacity:0];
        self.toolbar.frame = frameTool;
        self.pickerView.frame = framePicker;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

#pragma mark - --- delegate 视图委托 ---

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 4;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 0) {
        return self.arrayProvince.count;
    }else if (component == 1) {
        return self.arrayCity.count;
    }else if (component == 2){
        return self.arrayArea.count;
    }else {
        return self.arrayStreets.count;
    }
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return PickerViewLabelWeight;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    switch (component) {
        case 0:
            if (row < _arrayProvince.count) {
                [self updateComponentForCityWithProvinceNum:_arrayProvince[row] row:row];
            }
            break;
        case 1:
            if (row < _arrayCity.count) {
                [self updateComponentForCountyWithCityNum:_arrayCity[row] row:row];
            }
            break;
        case 2:
            if (row < _arrayArea.count) {
                [self updateComponentForStreetWithCountyNum:_arrayArea[row] row:row];
            }
            break;
        case 3:
            break;
        default:
            break;
    }
    [self reloadSelectAddress];
}


- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(nullable UIView *)view {
    UILabel* label = [[UILabel alloc] initWithFrame: CGRectMake(8, 0, self.frame.size.width/4 - 16, 30)];
    label.adjustsFontSizeToFitWidth = NO;
    label.font = [UIFont systemFontOfSize: 14];
    label.textAlignment = NSTextAlignmentCenter;
    NSString *text = @"";
    switch (component) {
        case 0:
            if (row < _arrayProvince.count) { text = _arrayProvince[row][@"state"]; }
            break;
        case 1:
            if (row < _arrayCity.count) { text = _arrayCity[row][@"city"]; }
            break;
        case 2:
            if (row < _arrayArea.count) { text = _arrayArea[row][@"county"]; }
            break;
        case 3:
            if (row < _arrayStreets.count) { text = _arrayStreets[row]; }
            break;
        default:
            break;
    }
    
    if (text.length != 0) { label.text = text; }
    return label;
}

- (void)updateComponentForCityWithProvinceNum:(NSDictionary *)dict row:(NSInteger)row {
    NSMutableArray *citys = [NSMutableArray arrayWithArray:dict[@"cities"]];
    [self.arrayCity removeAllObjects];
    [citys enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.arrayCity addObject:obj];
    }];
    [self.pickerView reloadComponent:1];
    [self.pickerView selectRow:0 inComponent:1 animated:YES];
    if (_arrayCity.count > 0) {
        [self updateComponentForCountyWithCityNum:self.arrayCity[0] row:0];
    }else {
        [self updateComponentForCountyWithCityNum:@{@"":@""} row:0];
        self.province = @"";
    }
}

- (void)updateComponentForCountyWithCityNum:(NSDictionary *)dict row:(NSInteger)row {
    [self.arrayArea removeAllObjects];
    NSMutableArray *countyAry = [NSMutableArray arrayWithArray:dict[@"areas"]];
    [countyAry enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.arrayArea addObject:obj];//获取区名字  obj[@"county"]
    }];
    [self.pickerView reloadComponent:2];
    [self.pickerView selectRow:0 inComponent:2 animated:YES];
    if (_arrayArea.count > 0 && row < _arrayArea.count) {
        [self updateComponentForStreetWithCountyNum:_arrayArea[row] row:0];
    }else {
        [self updateComponentForStreetWithCountyNum:@{@"":@""} row:0];
    }
}

- (void)updateComponentForStreetWithCountyNum:(NSDictionary *)dict row:(NSInteger)row {
    [self.arrayStreets removeAllObjects];
    [self.arrayStreets addObjectsFromArray:dict[@"streets"]];
    [self.pickerView reloadComponent:3];
    [self.pickerView selectRow:0 inComponent:3 animated:YES];
}

- (void)reloadSelectAddress {
    NSInteger tempRow1 = [self.pickerView selectedRowInComponent:0];
    NSInteger tempRow2 = [self.pickerView selectedRowInComponent:1];
    NSInteger tempRow3 = [self.pickerView selectedRowInComponent:2];
    NSInteger tempRow4 = [self.pickerView selectedRowInComponent:3];
    self.province = @""; self.city = @""; self.area = @""; self.streetsStr = @"";
    if (self.arrayProvince.count > 0) {
        self.province   = self.arrayProvince[tempRow1][@"state"];
    }
    if (self.arrayCity.count > 0) {
        self.city       = self.arrayCity[tempRow2][@"city"];
    }
    if (self.arrayArea.count > 0) {
        self.area       = self.arrayArea[tempRow3][@"county"];
    }
    if (self.arrayStreets.count > 0) {
        self.streetsStr = self.arrayStreets[tempRow4];
    }
    NSString *title = [NSString stringWithFormat:@"%@ %@ %@ %@", self.province, self.city, self.area, self.streetsStr];

    [self.toolbar setTitle:title];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
