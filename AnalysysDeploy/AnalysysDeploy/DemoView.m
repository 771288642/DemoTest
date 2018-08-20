//
//  DemoView.m
//  AnalysysDeploy
//
//  Created by analysysmac-1 on 2018/8/1.
//  Copyright © 2018年 analysysmac-1. All rights reserved.
//

#import "DemoView.h"
#import "UIView+Addition.h"
#import "ListView.h"
#import "SDAutoLayout.h"

@interface DemoView()<UITextFieldDelegate>

@end

@implementation DemoView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        //第一行app key
        UILabel *appKeyLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 30)];
        appKeyLabel.textColor = UIColor.grayColor;
        appKeyLabel.text = @"App Key:";
        [self addSubview:appKeyLabel];
        
        self.saveAppKeyButton = [[UIButton alloc] initWithFrame:CGRectMake(self.width * 4 / 5, appKeyLabel.top, self.width / 5, appKeyLabel.height)];
        [self.saveAppKeyButton addTarget:self action:@selector(saveAppKeyButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        self.saveAppKeyButton.layer.borderWidth = 2;
        [self.saveAppKeyButton.layer setCornerRadius:5];
        self.saveAppKeyButton.layer.masksToBounds = YES;
        [self.saveAppKeyButton.layer setBorderColor:[UIColor grayColor].CGColor];
        [self.saveAppKeyButton setTitle:@"保存Key" forState:UIControlStateNormal];
        self.saveAppKeyButton.titleLabel.font = [UIFont systemFontOfSize: 14];
        [self.saveAppKeyButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self addSubview:self.saveAppKeyButton];
        
        self.appKeyText = [[UITextField alloc] initWithFrame:CGRectMake(appKeyLabel.width, appKeyLabel.top, self.saveAppKeyButton.left - appKeyLabel.right - 10, appKeyLabel.height)];
        self.appKeyText.delegate = self;
        self.appKeyText.placeholder = @"paastest";
        self.appKeyText.clearButtonMode = UITextFieldViewModeAlways;
        self.appKeyText.autocapitalizationType = UITextAutocapitalizationTypeNone;
        [self addSubview:self.appKeyText];
        
        UIView *appKeyUnderLine = [[UIView alloc] initWithFrame:CGRectMake(0, self.appKeyText.height - 2, self.appKeyText.width, 2)];
        appKeyUnderLine.backgroundColor = UIColor.grayColor;
        [self.appKeyText addSubview:appKeyUnderLine];
        appKeyUnderLine.sd_layout.rightSpaceToView(self.appKeyText, 0);
        
        //第二行upload
        UILabel *uploadLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, appKeyLabel.top + 35, 60, 30)];
        uploadLabel.textColor = UIColor.grayColor;
        uploadLabel.text = @"upload";
        [self addSubview:uploadLabel];
        
        self.uploadBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.uploadBtn.frame = CGRectMake(uploadLabel.right, uploadLabel.top, 60, 30);
        self.uploadBtn.tag = 100;
        [self.uploadBtn setTitle:@"https://" forState:UIControlStateNormal];
        [self.uploadBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        httpBtn.backgroundColor = [UIColor redColor];
        [self.uploadBtn addTarget:self action:@selector(protocolBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.uploadBtn];
        
        self.saveUploadButton = [[UIButton alloc] initWithFrame:CGRectMake(self.width * 4 / 5, uploadLabel.top, self.width/5, 30)];
        [self.saveUploadButton addTarget:self action:@selector(saveUploadButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        self.saveUploadButton.layer.borderWidth = 2;
        [self.saveUploadButton.layer setCornerRadius:5];
        self.saveUploadButton.layer.masksToBounds = YES;
        [self.saveUploadButton.layer setBorderColor:[UIColor grayColor].CGColor];
        [self.saveUploadButton setTitle:@"保存upload" forState:UIControlStateNormal];
        self.saveUploadButton.titleLabel.font = [UIFont systemFontOfSize: 14];
        [self.saveUploadButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self addSubview:self.saveUploadButton];
        
        self.portBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.portBtn.tag = 200;
        self.portBtn.frame = CGRectMake(self.saveUploadButton.left - 40, uploadLabel.top, 40, 30);
        [self.portBtn setImage:[UIImage imageNamed:@"down"] forState:UIControlStateNormal];
        [self.portBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        //        httpBtn.backgroundColor = [UIColor redColor];
        [self.portBtn addTarget:self action:@selector(portBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.portBtn];
        
        self.uploadPortTF = [[UITextField alloc] initWithFrame:CGRectMake(self.portBtn.left - 45, uploadLabel.top, 45, 30)];
        self.uploadPortTF.placeholder = @"8089";
        self.uploadPortTF.font = [UIFont systemFontOfSize:15];
        self.uploadPortTF.delegate = self;
        UIView *uploadPTFUnderLine = [[UIView alloc] initWithFrame:CGRectMake(0, self.uploadPortTF.height - 2, self.uploadPortTF.width, 2)];
        uploadPTFUnderLine.backgroundColor = UIColor.grayColor;
        [self.uploadPortTF addSubview:uploadPTFUnderLine];
        [self addSubview:self.uploadPortTF];
        uploadPTFUnderLine.sd_layout.rightSpaceToView(self.uploadPortTF, 0);
        
        self.uploadColon = [[UILabel alloc] initWithFrame:CGRectMake(self.uploadPortTF.left - 7, uploadLabel.top, 5, 30)];
        self.uploadColon.textColor = UIColor.grayColor;
        self.uploadColon.text = @":";
        [self addSubview:self.uploadColon];

        self.uploadAddressTF = [[UITextField alloc] initWithFrame:CGRectMake(125, uploadLabel.top, self.uploadColon.left - 127, uploadLabel.height)];
        self.uploadAddressTF.placeholder = @"arkpaastest.analysys.cn";
        self.uploadAddressTF.font = [UIFont systemFontOfSize:15];
        self.uploadAddressTF.delegate = self;
        self.uploadAddressTF.clearButtonMode = UITextFieldViewModeAlways;
        self.uploadAddressTF.autocapitalizationType = UITextAutocapitalizationTypeNone;
        UIView *uploadATFUnderLine = [[UIView alloc] initWithFrame:CGRectMake(0, self.uploadAddressTF.height - 2, self.uploadAddressTF.width, 2)];
        uploadATFUnderLine.backgroundColor = UIColor.grayColor;
        [self addSubview:self.uploadAddressTF];
        [self.uploadAddressTF addSubview:uploadATFUnderLine];
        uploadATFUnderLine.sd_layout.rightSpaceToView(self.uploadAddressTF, 0);

        //第三行socket
        UILabel *socketLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, uploadLabel.top + 35, 60, 30)];
        socketLabel.textColor = UIColor.grayColor;
        socketLabel.text = @"socket";
        [self addSubview:socketLabel];
        
        self.socketBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.socketBtn.frame = CGRectMake(socketLabel.right, socketLabel.top, 60, 30);
        self.socketBtn.tag = 101;
        [self.socketBtn setTitle:@"wss://" forState:UIControlStateNormal];
        [self.socketBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        //        httpBtn.backgroundColor = [UIColor redColor];
        [self.socketBtn addTarget:self action:@selector(protocolBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.socketBtn];
        
        self.saveSocketButton = [[UIButton alloc] initWithFrame:CGRectMake(self.width * 4 / 5, socketLabel.top, self.width / 5, 30)];
        [self.saveSocketButton addTarget:self action:@selector(saveSocketButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        self.saveSocketButton.layer.borderWidth = 2;
        [self.saveSocketButton.layer setCornerRadius:5];
        self.saveSocketButton.layer.masksToBounds = YES;
        [self.saveSocketButton.layer setBorderColor:[UIColor grayColor].CGColor];
        [self.saveSocketButton setTitle:@"保存socket" forState:UIControlStateNormal];
        self.saveSocketButton.titleLabel.font = [UIFont systemFontOfSize: 14];
        [self.saveSocketButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self addSubview:self.saveSocketButton];
        
        self.socketPortBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.socketPortBtn.tag = 201;
        self.socketPortBtn.frame = CGRectMake(self.saveSocketButton.left - 40, socketLabel.top, 40, 30);
        [self.socketPortBtn setImage:[UIImage imageNamed:@"down"] forState:UIControlStateNormal];
        [self.socketPortBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        //        httpBtn.backgroundColor = [UIColor redColor];
        [self.socketPortBtn addTarget:self action:@selector(portBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.socketPortBtn];
        
        self.socketPortTF = [[UITextField alloc] initWithFrame:CGRectMake(self.socketPortBtn.left - 45, socketLabel.top, 45, 30)];
        self.socketPortTF.placeholder = @"9091";
        self.socketPortTF.font = [UIFont systemFontOfSize:15];
        self.socketPortTF.delegate = self;
        UIView *socketPTFUnderLine = [[UIView alloc] initWithFrame:CGRectMake(0, self.socketPortTF.height - 2, self.socketPortTF.width, 2)];
        socketPTFUnderLine.backgroundColor = UIColor.grayColor;
        [self addSubview:self.socketPortTF];
        [self.socketPortTF addSubview:socketPTFUnderLine];
        socketPTFUnderLine.sd_layout.rightSpaceToView(self.socketPortTF, 0);
        
        self.socketColon = [[UILabel alloc] initWithFrame:CGRectMake(self.socketPortTF.left - 7, socketLabel.top, 5, 30)];
        self.socketColon.textColor = UIColor.grayColor;
        self.socketColon.text = @":";
        [self addSubview:self.socketColon];
        
        self.socketAddressTF = [[UITextField alloc] initWithFrame:CGRectMake(125, socketLabel.top, self.socketColon.left - 127, socketLabel.height)];
        self.socketAddressTF.placeholder = @"arkpaastest.analysys.cn";
        self.socketAddressTF.font = [UIFont systemFontOfSize:15];
        self.socketAddressTF.delegate = self;
        self.socketAddressTF.clearButtonMode = UITextFieldViewModeAlways;
        self.socketAddressTF.autocapitalizationType = UITextAutocapitalizationTypeNone;
        UIView *socketATFUnderLine = [[UIView alloc] initWithFrame:CGRectMake(0, self.socketAddressTF.height - 2, self.socketAddressTF.width, 2)];
        socketATFUnderLine.backgroundColor = UIColor.grayColor;
        [self addSubview:self.socketAddressTF];
        [self.socketAddressTF addSubview:socketATFUnderLine];
        socketATFUnderLine.sd_layout.rightSpaceToView(self.socketAddressTF, 0);
        
        //第四行config
        UILabel *configLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, socketLabel.top + 35, 60, 30)];
        configLabel.textColor = UIColor.grayColor;
        configLabel.text = @"config";
        [self addSubview:configLabel];
        
        self.configBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.configBtn.frame = CGRectMake(configLabel.right, configLabel.top, 60, 30);
        self.configBtn.tag = 102;
        [self.configBtn setTitle:@"https://" forState:UIControlStateNormal];
        [self.configBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        //        httpBtn.backgroundColor = [UIColor redColor];
        [self.configBtn addTarget:self action:@selector(protocolBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.configBtn];
        
        self.saveConfigButton = [[UIButton alloc] initWithFrame:CGRectMake(self.width * 4 / 5, configLabel.top, self.width / 5, 30)];
        [self.saveConfigButton addTarget:self action:@selector(saveConfigButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        self.saveConfigButton.layer.borderWidth = 2;
        [self.saveConfigButton.layer setCornerRadius:5];
        self.saveConfigButton.layer.masksToBounds = YES;
        [self.saveConfigButton.layer setBorderColor:[UIColor grayColor].CGColor];
        [self.saveConfigButton setTitle:@"保存config" forState:UIControlStateNormal];
        self.saveConfigButton.titleLabel.font = [UIFont systemFontOfSize: 14];
        [self.saveConfigButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self addSubview:self.saveConfigButton];
        
        self.configPortBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.configPortBtn.tag = 202;
        self.configPortBtn.frame = CGRectMake(self.saveConfigButton.left - 40, configLabel.top, 40, 30);
        [self.configPortBtn setImage:[UIImage imageNamed:@"down"] forState:UIControlStateNormal];
        [self.configPortBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        //        httpBtn.backgroundColor = [UIColor redColor];
        [self.configPortBtn addTarget:self action:@selector(portBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.configPortBtn];
        
        self.configPortTF = [[UITextField alloc] initWithFrame:CGRectMake(self.configPortBtn.left - 45, configLabel.top, 45, 30)];
        self.configPortTF.placeholder = @"8089";
        self.configPortTF.font = [UIFont systemFontOfSize:15];
        self.configPortTF.delegate = self;
        UIView *configPTFUnderLine = [[UIView alloc] initWithFrame:CGRectMake(0, self.configPortTF.height - 2, self.configPortTF.width, 2)];
        configPTFUnderLine.backgroundColor = UIColor.grayColor;
        [self addSubview:self.configPortTF];
        [self.configPortTF addSubview:configPTFUnderLine];
        configPTFUnderLine.sd_layout.rightSpaceToView(self.configPortTF, 0);
        
        self.configColon = [[UILabel alloc] initWithFrame:CGRectMake(self.configPortTF.left - 7, configLabel.top, 5, 30)];
        self.configColon.textColor = UIColor.grayColor;
        self.configColon.text = @":";
        [self addSubview:self.configColon];
        
        self.configAddressTF = [[UITextField alloc] initWithFrame:CGRectMake(125, configLabel.top, self.configColon.left - 127, configLabel.height)];
        self.configAddressTF.placeholder = @"arkpaastest.analysys.cn";
        self.configAddressTF.font = [UIFont systemFontOfSize:15];
        self.configAddressTF.delegate = self;
        self.configAddressTF.clearButtonMode = UITextFieldViewModeAlways;
        self.configAddressTF.autocapitalizationType = UITextAutocapitalizationTypeNone;
        UIView *configAddressTFUnderLine = [[UIView alloc] initWithFrame:CGRectMake(0, self.configAddressTF.height - 2, self.configAddressTF.width, 2)];
        configAddressTFUnderLine.backgroundColor = UIColor.grayColor;
        [self addSubview:self.configAddressTF];
        [self.configAddressTF addSubview:configAddressTFUnderLine];
        configAddressTFUnderLine.sd_layout.rightSpaceToView(self.configAddressTF, 0);
        
        //保存全部按钮
        self.saveButton = [[UIButton alloc] initWithFrame:CGRectMake(0, configLabel.bottom + 5, self.width, 60)];
        [self.saveButton addTarget:self action:@selector(saveButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        self.saveButton.layer.borderWidth = 2;
        [self.saveButton.layer setCornerRadius:5];
        self.saveButton.layer.masksToBounds = YES;
        [self.saveButton.layer setBorderColor:[UIColor grayColor].CGColor];
        [self.saveButton setTitle:@"保存全部" forState:UIControlStateNormal];
        [self.saveButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self addSubview:self.saveButton];
        self.saveButton.sd_layout.rightSpaceToView(self, 0);
        
        //发送数据按钮
        self.sendDataButton = [[UIButton alloc] initWithFrame:CGRectMake(0, self.saveButton.top + 65, self.width, 60)];
        [self.sendDataButton addTarget:self action:@selector(sendDataAction:) forControlEvents:UIControlEventTouchUpInside];
        self.sendDataButton.layer.borderWidth = 2;
        [self.sendDataButton.layer setCornerRadius:5];
        self.sendDataButton.layer.masksToBounds = YES;
        [self.sendDataButton.layer setBorderColor:[UIColor grayColor].CGColor];
        [self.sendDataButton setTitle:@"发送数据" forState:UIControlStateNormal];
        [self.sendDataButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self addSubview:self.sendDataButton];
        self.sendDataButton.sd_layout.rightSpaceToView(self, 0);
        
        //显示地址
        UILabel *uploadAddressLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.sendDataButton.bottom, 85, 40)];
        uploadAddressLabel.text = @"upload地址:";
//        self.uploadAddressLabel.backgroundColor = [UIColor redColor];
        uploadAddressLabel.font = [UIFont systemFontOfSize:15];
        uploadAddressLabel.textColor = UIColor.blueColor;
        [self addSubview:uploadAddressLabel];
        
        self.showUpAddressTV = [[UITextView alloc] initWithFrame:CGRectMake(uploadAddressLabel.right, uploadAddressLabel.top, self.width - uploadAddressLabel.size.width, 40)];
//        self.uploadAddressText.backgroundColor = [UIColor greenColor];
        self.showUpAddressTV.font = [UIFont systemFontOfSize:15];
        self.showUpAddressTV.textColor = UIColor.blueColor;
        self.showUpAddressTV.editable = NO;
        [self addSubview:self.showUpAddressTV];
        self.showUpAddressTV.sd_layout.rightSpaceToView(self, 0);
        
        UILabel *socketAddressLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, uploadAddressLabel.bottom, 85, 40)];
        socketAddressLabel.text = @"socket地址:";
        socketAddressLabel.font = [UIFont systemFontOfSize:15];
        socketAddressLabel.textColor = UIColor.blueColor;
        [self addSubview:socketAddressLabel];
        
        self.showSocketAddressTV = [[UITextView alloc] initWithFrame:CGRectMake(socketAddressLabel.right, socketAddressLabel.top, frame.size.width - socketAddressLabel.size.width, 40)];
        self.showSocketAddressTV.font = [UIFont systemFontOfSize:15];
        self.showSocketAddressTV.textColor = UIColor.blueColor;
        self.showSocketAddressTV.editable = NO;
        [self addSubview:self.showSocketAddressTV];
        self.showSocketAddressTV.sd_layout.rightSpaceToView(self, 0);
        
        UILabel *configAddressLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, socketAddressLabel.bottom, 85, 40)];
        configAddressLabel.text = @"config地址:";
        configAddressLabel.font = [UIFont systemFontOfSize:15];
        configAddressLabel.textColor = UIColor.blueColor;
        [self addSubview:configAddressLabel];
        
        self.showConfigAddressTV = [[UITextView alloc] initWithFrame:CGRectMake(configAddressLabel.right, configAddressLabel.top, self.width - configAddressLabel.size.width, 40)];
        self.showConfigAddressTV.font = [UIFont systemFontOfSize:15];
        self.showConfigAddressTV.textColor = UIColor.blueColor;
        self.showConfigAddressTV.editable = NO;
        [self addSubview:self.showConfigAddressTV];
        self.showConfigAddressTV.sd_layout.rightSpaceToView(self, 0);
        
        UILabel *sendStatusLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, configAddressLabel.bottom, self.width, 30)];
        sendStatusLabel.textColor = [UIColor purpleColor];
        sendStatusLabel.text = @"数据发送结果:";
        [self addSubview:sendStatusLabel];
        
        //显示通知
        self.dataText = [[UITextView alloc] initWithFrame:CGRectMake(0, sendStatusLabel.bottom, self.width, self.height)];
        self.dataText.font = [UIFont systemFontOfSize:15];
        self.dataText.textColor = UIColor.grayColor;
        self.dataText.editable = NO;
        [self addSubview:self.dataText];
        self.dataText.sd_layout.rightSpaceToView(self, 0);
    }

    return self;
}

#pragma mark *** btn aciton ***

- (void)protocolBtnAction:(UIButton *)btn {
    [self endEditing:YES];
    NSArray *listArray;
    switch (btn.tag) {
        case 100:
            listArray = @[@"http://", @"https://"];
            break;
        case 101:
            listArray = @[@"ws://", @"wss://"];
            break;
        case 102:
            listArray = @[@"http://", @"https://"];
            break;
        default:
            break;
    }
    [ListView showWithView:btn dataArray:listArray block:^(NSIndexPath *indexPath, NSString *title) {
        NSLog(@"indexPath:%@ title:%@",indexPath, title);
        [btn setTitle:title forState:UIControlStateNormal];
    }];
}

- (void)portBtnAction:(UIButton *)btn {
    [self endEditing:YES];
    NSArray *listArray;
    switch (btn.tag) {
        case 200:
            listArray = @[@"4089",@"8089", @"443"];
            break;
        case 201:
            listArray = @[@"4091", @"9091"];
            break;
        case 202:
            listArray = @[@"4089", @"8089", @"443"];
            break;
        default:
            break;
    }
    
    [ListView showWithView:btn dataArray:listArray block:^(NSIndexPath *indexPath, NSString *title) {
        NSLog(@"indexPath:%@ title:%@",indexPath, title);
        switch (btn.tag) {
            case 200:
                self.uploadPortTF.text = title;
                break;
            case 201:
                self.socketPortTF.text = title;
                break;
            case 202:
                self.configPortTF.text = title;
                break;
            default:
                break;
        }
    }];
}

/** 保存App Key */
- (void)saveAppKeyButtonAction:(UIButton *)btn {
    if ([self.delegate respondsToSelector:@selector(saveAppKeyBtnAction:)]) {
        [self.delegate saveAppKeyBtnAction:btn];
    }
}

/** 保存upload */
- (void)saveUploadButtonAction:(UIButton *)btn {
    if ([self.delegate respondsToSelector:@selector(saveUploadBtnAction:)]) {
        [self.delegate saveUploadBtnAction:btn];
    }
}

/** 保存socket */
- (void)saveSocketButtonAction:(UIButton *)btn {
    if ([self.delegate respondsToSelector:@selector(saveSocketBtnAction:)]) {
        [self.delegate saveSocketBtnAction:btn];
    }
}

/** 保存config */
- (void)saveConfigButtonAction:(UIButton *)btn {
    if ([self.delegate respondsToSelector:@selector(saveConfigBtnAction:)]) {
        [self.delegate saveConfigBtnAction:btn];
    }
}

/** 保存全部 */
- (void)saveButtonAction:(UIButton *)btn {
    if ([self.delegate respondsToSelector:@selector(saveBtnAction:)]) {
        [self.delegate saveBtnAction:btn];
    }
}

/** 发送数据 */
- (void)sendDataAction:(UIButton *)btn {
    if ([self.delegate respondsToSelector:@selector(sendBtnAction:)]) {
        [self.delegate sendBtnAction:btn];
    }
}

#pragma mark - 隐藏键盘

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self endEditing:YES];
    
    return YES;
}

#pragma mark - TextField禁止输入空格

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSString *tem = [[string componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]componentsJoinedByString:@""];
    if (![string isEqualToString:tem]) {
        return NO;
    }
    return YES;
}

#pragma mark - 触摸屏幕时触发

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self endEditing:YES];
}

#pragma mark - 当前点击的text

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    self.currentText = textField;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    self.currentText = nil;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
