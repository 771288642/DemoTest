//
//  DemoView.m
//  Demo
//
//  Created by analysysmac-1 on 2018/8/1.
//  Copyright © 2018年 analysysmac-1. All rights reserved.
//

#import "DemoView.h"
#import "UIView+Addition.h"

@interface DemoView()<UITextFieldDelegate>

@end

@implementation DemoView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        //第一行app key
        self.appKeyLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
        self.appKeyLabel.textColor = UIColor.grayColor;
        self.appKeyLabel.text = @"app key";
        [self addSubview:self.appKeyLabel];
        
        self.appKeyText = [[UITextField alloc] initWithFrame:CGRectMake(self.appKeyLabel.frame.size.width + 5, self.appKeyLabel.frame.origin.y, frame.size.width - self.appKeyLabel.frame.size.width - 5, self.appKeyLabel.frame.size.height)];
        self.appKeyText.delegate = self;
        self.appKeyText.text = @"Demo";
        self.appKeyText.clearButtonMode = UITextFieldViewModeAlways;
        [self addSubview:self.appKeyText];
        
        self.underLine1 = [[UIView alloc] initWithFrame:CGRectMake(0, self.appKeyText.frame.size.height - 2, self.appKeyText.frame.size.width, 2)];
        self.underLine1.backgroundColor = UIColor.grayColor;
        [self.appKeyText addSubview:self.underLine1];
        
        //第二行upload
        self.uploadLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.appKeyLabel.frame.origin.y + 35, 60, 30)];
        self.uploadLabel.textColor = UIColor.grayColor;
        self.uploadLabel.text = @"upload";
        [self addSubview:self.uploadLabel];
        
        self.colonLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(frame.size.width*3/4, self.uploadLabel.frame.origin.y, 5, 30)];
        self.colonLabel1.textColor = UIColor.grayColor;
        self.colonLabel1.text = @":";
        [self addSubview:self.colonLabel1];

        self.uploadText = [[UITextField alloc] initWithFrame:CGRectMake(145, self.uploadLabel.frame.origin.y, self.colonLabel1.frame.origin.x - 147, self.uploadLabel.frame.size.height)];
        self.uploadText.text = @"arkpaastest.analysys.cn";
        self.uploadText.font = [UIFont systemFontOfSize:15];
        self.uploadText.delegate = self;
        self.uploadText.clearButtonMode = UITextFieldViewModeAlways;
        UIView *underLine2 = [[UIView alloc] initWithFrame:CGRectMake(0, self.uploadText.frame.size.height - 2, self.uploadText.frame.size.width, 2)];
        underLine2.backgroundColor = UIColor.grayColor;
        [self addSubview:self.uploadText];
        [self.uploadText addSubview:underLine2];

        self.noText1 = [[UITextField alloc] initWithFrame:CGRectMake(self.colonLabel1.frame.origin.x + 7, self.colonLabel1.frame.origin.y, frame.size.width - self.colonLabel1.frame.origin.x - 39, 30)];
        self.noText1.text = @"8089";
        self.noText1.font = [UIFont systemFontOfSize:15];
        self.noText1.delegate = self;
        //self.noText1.clearButtonMode = UITextFieldViewModeAlways;
        UIView *underLine3 = [[UIView alloc] initWithFrame:CGRectMake(0, self.noText1.frame.size.height - 2, self.noText1.frame.size.width, 2)];
        underLine3.backgroundColor = UIColor.grayColor;
        [self.noText1 addSubview:underLine3];
        [self addSubview:self.noText1];
        
        //第三行socket
        self.socketLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.uploadLabel.frame.origin.y + 35, 60, 30)];
        self.socketLabel.textColor = UIColor.grayColor;
        self.socketLabel.text = @"socket";
        [self addSubview:self.socketLabel];
        
        self.colonLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(frame.size.width*3/4, self.socketLabel.frame.origin.y, 5, 30)];
        self.colonLabel2.textColor = UIColor.grayColor;
        self.colonLabel2.text = @":";
        [self addSubview:self.colonLabel2];
        
        self.socketText = [[UITextField alloc] initWithFrame:CGRectMake(145, self.socketLabel.frame.origin.y, self.colonLabel2.frame.origin.x - 147, self.socketLabel.frame.size.height)];
        self.socketText.text = @"arkpaastest.analysys.cn";
        self.socketText.font = [UIFont systemFontOfSize:15];
        self.socketText.delegate = self;
        self.socketText.clearButtonMode = UITextFieldViewModeAlways;
        UIView *underLine4 = [[UIView alloc] initWithFrame:CGRectMake(0, self.socketText.frame.size.height - 2, self.socketText.frame.size.width, 2)];
        underLine4.backgroundColor = UIColor.grayColor;
        [self addSubview:self.socketText];
        [self.socketText addSubview:underLine4];
        
        self.noText2 = [[UITextField alloc] initWithFrame:CGRectMake(self.colonLabel2.frame.origin.x + 7, self.colonLabel2.frame.origin.y, frame.size.width - self.colonLabel2.frame.origin.x - 39, 30)];
        self.noText2.text = @"9091";
        self.noText2.font = [UIFont systemFontOfSize:15];
        self.noText2.delegate = self;
        //self.noText2.clearButtonMode = UITextFieldViewModeAlways;
        UIView *underLine5 = [[UIView alloc] initWithFrame:CGRectMake(0, self.noText2.frame.size.height - 2, self.noText2.frame.size.width, 2)];
        underLine5.backgroundColor = UIColor.grayColor;
        [self addSubview:self.noText2];
        [self.noText2 addSubview:underLine5];
        
        //第四行config
        self.configLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.socketLabel.frame.origin.y + 35, 60, 30)];
        self.configLabel.textColor = UIColor.grayColor;
        self.configLabel.text = @"config";
        [self addSubview:self.configLabel];
        
        self.colonLabel3 = [[UILabel alloc] initWithFrame:CGRectMake(frame.size.width*3/4, self.configLabel.frame.origin.y, 5, 30)];
        self.colonLabel3.textColor = UIColor.grayColor;
        self.colonLabel3.text = @":";
        [self addSubview:self.colonLabel3];
        
        self.configText = [[UITextField alloc] initWithFrame:CGRectMake(145, self.configLabel.frame.origin.y, self.colonLabel3.frame.origin.x - 147, self.configLabel.frame.size.height)];
        self.configText.text = @"arkpaastest.analysys.cn";
        self.configText.font = [UIFont systemFontOfSize:15];
        self.configText.delegate = self;
        self.configText.clearButtonMode = UITextFieldViewModeAlways;
        UIView *underLine6 = [[UIView alloc] initWithFrame:CGRectMake(0, self.configText.frame.size.height - 2, self.configText.frame.size.width, 2)];
        underLine6.backgroundColor = UIColor.grayColor;
        [self addSubview:self.configText];
        [self.configText addSubview:underLine6];
        
        self.noText3 = [[UITextField alloc] initWithFrame:CGRectMake(self.colonLabel3.frame.origin.x + 7, self.colonLabel3.frame.origin.y, frame.size.width - self.colonLabel3.frame.origin.x - 39, 30)];
        self.noText3.text = @"8089";
        self.noText3.font = [UIFont systemFontOfSize:15];
        self.noText3.delegate = self;
        //self.noText3.clearButtonMode = UITextFieldViewModeAlways;
        UIView *underLine7 = [[UIView alloc] initWithFrame:CGRectMake(0, self.noText3.frame.size.height - 2, self.noText3.frame.size.width, 2)];
        underLine7.backgroundColor = UIColor.grayColor;
        [self addSubview:self.noText3];
        [self.noText3 addSubview:underLine7];
        
        //保存设置按钮
        self.saveButton = [[UIButton alloc] initWithFrame:CGRectMake(0, self.configLabel.frame.origin.y + 35, frame.size.width, 60)];
        self.saveButton.layer.borderWidth = 3;
        [self.saveButton.layer setCornerRadius:12];
        self.saveButton.layer.masksToBounds = YES;
        [self.saveButton.layer setBorderColor:[UIColor grayColor].CGColor];
        [self.saveButton setTitle:@"保存设置" forState:UIControlStateNormal];
        [self.saveButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self addSubview:self.saveButton];
        
        //发送数据按钮
        self.sendDataButton = [[UIButton alloc] initWithFrame:CGRectMake(0, self.saveButton.frame.origin.y + 65, frame.size.width, 60)];
        self.sendDataButton.layer.borderWidth = 3;
        [self.sendDataButton.layer setCornerRadius:12];
        self.sendDataButton.layer.masksToBounds = YES;
        [self.sendDataButton.layer setBorderColor:[UIColor grayColor].CGColor];
        [self.sendDataButton setTitle:@"发送数据" forState:UIControlStateNormal];
        [self.sendDataButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self addSubview:self.sendDataButton];
        
        //显示地址
        self.uploadAddressLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.sendDataButton.frame.origin.y + 65, 82, 40)];
        self.uploadAddressLabel.text = [NSString stringWithFormat:@"%@地址:",self.uploadLabel.text];
        self.uploadAddressLabel.font = [UIFont systemFontOfSize:15];
        self.uploadAddressLabel.textColor = UIColor.orangeColor;
        [self addSubview:self.uploadAddressLabel];
        
        self.uploadAddressText = [[UITextView alloc] initWithFrame:CGRectMake(82, self.uploadAddressLabel.frame.origin.y, frame.size.width - self.uploadAddressLabel.size.width, 40)];
        self.uploadAddressText.font = [UIFont systemFontOfSize:14];
        self.uploadAddressText.textColor = UIColor.orangeColor;
        self.uploadAddressText.editable = NO;
        [self addSubview:self.uploadAddressText];
        
        self.socketAddressLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.uploadAddressLabel.frame.origin.y + 45, 82, 40)];
        self.socketAddressLabel.text = [NSString stringWithFormat:@"%@地址:",self.socketLabel.text];
        self.socketAddressLabel.font = [UIFont systemFontOfSize:15];
        self.socketAddressLabel.textColor = UIColor.greenColor;
        [self addSubview:self.socketAddressLabel];
        
        self.socketAddressText = [[UITextView alloc] initWithFrame:CGRectMake(82, self.socketAddressLabel.frame.origin.y, frame.size.width - self.socketAddressLabel.size.width, 40)];
        self.socketAddressText.font = [UIFont systemFontOfSize:14];
        self.socketAddressText.textColor = UIColor.greenColor;
        self.socketAddressText.editable = NO;
        [self addSubview:self.socketAddressText];
        
        self.configAddressLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.socketAddressLabel.frame.origin.y + 45, 82, 40)];
        self.configAddressLabel.text = [NSString stringWithFormat:@"%@地址:",self.configLabel.text];
        self.configAddressLabel.font = [UIFont systemFontOfSize:15];
        self.configAddressLabel.textColor = UIColor.blueColor;
        [self addSubview:self.configAddressLabel];
        
        self.configAddressText = [[UITextView alloc] initWithFrame:CGRectMake(82, self.configAddressLabel.frame.origin.y, frame.size.width - self.configAddressLabel.size.width, 40)];
        self.configAddressText.font = [UIFont systemFontOfSize:14];
        self.configAddressText.textColor = UIColor.blueColor;
        self.configAddressText.editable = NO;
        [self addSubview:self.configAddressText];
        
        //显示通知
        self.dataText = [[UITextView alloc] initWithFrame:CGRectMake(0, self.configAddressLabel.frame.origin.y + 45, frame.size.width, frame.size.height - self.configAddressLabel.frame.origin.y - 65)];
        self.dataText.font = [UIFont systemFontOfSize:14];
        self.dataText.textColor = UIColor.grayColor;
        self.dataText.editable = NO;
        [self addSubview:self.dataText];
    }

    return self;
}

#pragma mark - 隐藏键盘

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.appKeyText resignFirstResponder];
    [self.uploadText resignFirstResponder];
    [self.noText1 resignFirstResponder];
    [self.socketText resignFirstResponder];
    [self.noText2 resignFirstResponder];
    [self.configText resignFirstResponder];
    [self.noText3 resignFirstResponder];
    return YES;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
