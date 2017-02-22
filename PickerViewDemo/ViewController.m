//
//  ViewController.m
//  TestPlist
//
//  Created by 郑超杰 on 2017/2/21.
//  Copyright © 2017年 ButterJie. All rights reserved.
//

#import "ViewController.h"
#import "HDPickerView.h"
#import "Constants.h"

@interface ViewController ()

@property (nonatomic, strong) HDPickerView *pickerView;
@property (nonatomic, strong) UILabel *addressLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.addressLabel.backgroundColor = [UIColor lightGrayColor];
}

- (UILabel *)addressLabel {
    if (!_addressLabel) {
        _addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, self.view.frame.size.width - 40, 40)];
        _addressLabel.textColor = [UIColor redColor];
        _addressLabel.center = self.view.center;
        _addressLabel.textAlignment = NSTextAlignmentCenter;
        _addressLabel.userInteractionEnabled = YES;
        _addressLabel.adjustsFontSizeToFitWidth = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectAddress)];
        tap.numberOfTapsRequired = 1;
        [_addressLabel addGestureRecognizer:tap];
        [self.view addSubview:_addressLabel];
    }
    return _addressLabel;
}

- (void)selectAddress {
    [self.pickerView show];
}

- (HDPickerView *)pickerView {
    if (!_pickerView) {
        @weakify(self)
        _pickerView = [HDPickerView selectArea:^(NSString *province, NSString *city, NSString *area, NSString *streets) {
            weak_self.addressLabel.text = [NSString stringWithFormat:@"%@ %@ %@ %@", province, city, area, streets];
        }];
    }
    return _pickerView;
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
