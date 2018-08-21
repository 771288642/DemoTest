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
        UILabel *appKeyLabel = [[UILabel alloc] init];
        appKeyLabel.textColor = UIColor.grayColor;
        appKeyLabel.text = @"App Key:";
        [self addSubview:appKeyLabel];
        appKeyLabel.sd_layout
        .leftSpaceToView(self, 0)
        .topSpaceToView(self, 7)
        .widthIs(80)
        .autoHeightRatio(0);
        
        self.saveAppKeyButton = [[UIButton alloc] init];
        [self.saveAppKeyButton addTarget:self action:@selector(saveAppKeyButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        self.saveAppKeyButton.layer.borderWidth = 2;
        [self.saveAppKeyButton.layer setCornerRadius:5];
        self.saveAppKeyButton.layer.masksToBounds = YES;
        [self.saveAppKeyButton.layer setBorderColor:[UIColor grayColor].CGColor];
        [self.saveAppKeyButton setTitle:@"保存Key" forState:UIControlStateNormal];
        self.saveAppKeyButton.titleLabel.font = [UIFont systemFontOfSize: 14];
        [self.saveAppKeyButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self addSubview:self.saveAppKeyButton];
        self.saveAppKeyButton.sd_layout
        .rightSpaceToView(self, 0)
        .topSpaceToView(self, 0)
        .widthRatioToView(self, 0.2)
        .heightIs(30);
        
        self.appKeyText = [[UITextField alloc] init];
        self.appKeyText.delegate = self;
        self.appKeyText.placeholder = @"paastest";
        self.appKeyText.clearButtonMode = UITextFieldViewModeAlways;
        self.appKeyText.autocapitalizationType = UITextAutocapitalizationTypeNone;
        [self addSubview:self.appKeyText];
        self.appKeyText.sd_layout
        .leftSpaceToView(appKeyLabel, 0)
        .rightSpaceToView(self.saveAppKeyButton, 5)
        .topEqualToView(appKeyLabel)
        .bottomEqualToView(appKeyLabel);
        
        UIView *appKeyUnderLine = [[UIView alloc] init];
        appKeyUnderLine.backgroundColor = UIColor.grayColor;
        [self.appKeyText addSubview:appKeyUnderLine];
        appKeyUnderLine.sd_layout
        .leftEqualToView(self.appKeyText)
        .rightEqualToView(self.appKeyText)
        .bottomSpaceToView(self.appKeyText, -3)
        .heightIs(2);
        
        //第二行upload
        UILabel *uploadLabel = [[UILabel alloc] init];
        uploadLabel.textColor = UIColor.grayColor;
        uploadLabel.text = @"upload";
        [self addSubview:uploadLabel];
        uploadLabel.sd_layout
        .leftEqualToView(appKeyLabel)
        .topSpaceToView(self.saveAppKeyButton, 12)
        .widthIs(60)
        .autoHeightRatio(0);
        
        self.uploadBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.uploadBtn.tag = 100;
        [self.uploadBtn setTitle:@"https://" forState:UIControlStateNormal];
        [self.uploadBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        httpBtn.backgroundColor = [UIColor redColor];
        [self.uploadBtn addTarget:self action:@selector(protocolBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.uploadBtn];
        self.uploadBtn.sd_layout
        .leftSpaceToView(uploadLabel, 0)
        .topSpaceToView(self.saveAppKeyButton, 5)
        .widthIs(60)
        .heightIs(30);
        
        self.saveUploadButton = [[UIButton alloc] init];
        [self.saveUploadButton addTarget:self action:@selector(saveUploadButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        self.saveUploadButton.layer.borderWidth = 2;
        [self.saveUploadButton.layer setCornerRadius:5];
        self.saveUploadButton.layer.masksToBounds = YES;
        [self.saveUploadButton.layer setBorderColor:[UIColor grayColor].CGColor];
        [self.saveUploadButton setTitle:@"保存upload" forState:UIControlStateNormal];
        self.saveUploadButton.titleLabel.font = [UIFont systemFontOfSize: 14];
        [self.saveUploadButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self addSubview:self.saveUploadButton];
        self.saveUploadButton.sd_layout
        .rightEqualToView(self.saveAppKeyButton)
        .topEqualToView(self.uploadBtn)
        .leftEqualToView(self.saveAppKeyButton)
        .bottomEqualToView(self.uploadBtn);
        
        self.portBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.portBtn.tag = 200;
        [self.portBtn setImage:[UIImage imageNamed:@"down"] forState:UIControlStateNormal];
        [self.portBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        //        httpBtn.backgroundColor = [UIColor redColor];
        [self.portBtn addTarget:self action:@selector(portBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.portBtn];
        self.portBtn.sd_layout
        .topEqualToView(self.saveUploadButton)
        .rightSpaceToView(self.saveUploadButton, 0)
        .bottomEqualToView(self.saveUploadButton)
        .widthIs(40);
        
        self.uploadPortTF = [[UITextField alloc] init];
        self.uploadPortTF.placeholder = @"8089";
        self.uploadPortTF.font = [UIFont systemFontOfSize:15];
        self.uploadPortTF.delegate = self;
        UIView *uploadPTFUnderLine = [[UIView alloc] init];
        uploadPTFUnderLine.backgroundColor = UIColor.grayColor;
        [self.uploadPortTF addSubview:uploadPTFUnderLine];
        [self addSubview:self.uploadPortTF];
        self.uploadPortTF.sd_layout
        .topEqualToView(uploadLabel)
        .bottomEqualToView(uploadLabel)
        .rightSpaceToView(self.portBtn, 0)
        .widthIs(45);
        
        uploadPTFUnderLine.sd_layout
        .leftEqualToView(self.uploadPortTF)
        .rightEqualToView(self.uploadPortTF)
        .bottomSpaceToView(self.uploadPortTF, -2)
        .heightIs(2);

        self.uploadColon = [[UILabel alloc] init];
        self.uploadColon.textColor = UIColor.grayColor;
        self.uploadColon.text = @":";
        [self addSubview:self.uploadColon];
        self.uploadColon.sd_layout
        .topEqualToView(uploadLabel)
        .rightSpaceToView(self.uploadPortTF, 0)
        .widthIs(5)
        .autoHeightRatio(0);

        self.uploadAddressTF = [[UITextField alloc] init];
        self.uploadAddressTF.placeholder = @"arkpaastest.analysys.cn";
        self.uploadAddressTF.font = [UIFont systemFontOfSize:15];
        self.uploadAddressTF.delegate = self;
        self.uploadAddressTF.clearButtonMode = UITextFieldViewModeAlways;
        self.uploadAddressTF.autocapitalizationType = UITextAutocapitalizationTypeNone;
        UIView *uploadATFUnderLine = [[UIView alloc] init];
        uploadATFUnderLine.backgroundColor = UIColor.grayColor;
        [self addSubview:self.uploadAddressTF];
        [self.uploadAddressTF addSubview:uploadATFUnderLine];
        self.uploadAddressTF.sd_layout
        .topEqualToView(uploadLabel)
        .bottomEqualToView(uploadLabel)
        .leftSpaceToView(self.uploadBtn, 0)
        .rightSpaceToView(self.uploadColon, 0);
        
        uploadATFUnderLine.sd_layout
        .leftEqualToView(self.uploadAddressTF)
        .rightEqualToView(self.uploadAddressTF)
        .bottomSpaceToView(self.uploadAddressTF, -2)
        .heightIs(2);

        //第三行socket
        UILabel *socketLabel = [[UILabel alloc] init];
        socketLabel.textColor = UIColor.grayColor;
        socketLabel.text = @"socket";
        [self addSubview:socketLabel];
        socketLabel.sd_layout
        .leftEqualToView(appKeyLabel)
        .topSpaceToView(self.saveUploadButton, 12)
        .widthIs(60)
        .autoHeightRatio(0);

        self.socketBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.socketBtn.tag = 101;
        [self.socketBtn setTitle:@"wss://" forState:UIControlStateNormal];
        [self.socketBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        //        httpBtn.backgroundColor = [UIColor redColor];
        [self.socketBtn addTarget:self action:@selector(protocolBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.socketBtn];
        self.socketBtn.sd_layout
        .leftSpaceToView(socketLabel, 0)
        .topSpaceToView(self.saveUploadButton, 5)
        .widthIs(60)
        .heightIs(30);

        self.saveSocketButton = [[UIButton alloc] init];
        [self.saveSocketButton addTarget:self action:@selector(saveSocketButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        self.saveSocketButton.layer.borderWidth = 2;
        [self.saveSocketButton.layer setCornerRadius:5];
        self.saveSocketButton.layer.masksToBounds = YES;
        [self.saveSocketButton.layer setBorderColor:[UIColor grayColor].CGColor];
        [self.saveSocketButton setTitle:@"保存socket" forState:UIControlStateNormal];
        self.saveSocketButton.titleLabel.font = [UIFont systemFontOfSize: 14];
        [self.saveSocketButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self addSubview:self.saveSocketButton];
        self.saveSocketButton.sd_layout
        .rightEqualToView(self.saveUploadButton)
        .topEqualToView(self.socketBtn)
        .leftEqualToView(self.saveUploadButton)
        .bottomEqualToView(self.socketBtn);

        self.socketPortBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.socketPortBtn.tag = 201;
        [self.socketPortBtn setImage:[UIImage imageNamed:@"down"] forState:UIControlStateNormal];
        [self.socketPortBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        //        httpBtn.backgroundColor = [UIColor redColor];
        [self.socketPortBtn addTarget:self action:@selector(portBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.socketPortBtn];
        self.socketPortBtn.sd_layout
        .topEqualToView(self.saveSocketButton)
        .rightSpaceToView(self.saveSocketButton, 0)
        .bottomEqualToView(self.saveSocketButton)
        .widthIs(40);

        self.socketPortTF = [[UITextField alloc] init];
        self.socketPortTF.placeholder = @"9091";
        self.socketPortTF.font = [UIFont systemFontOfSize:15];
        self.socketPortTF.delegate = self;
        UIView *socketPTFUnderLine = [[UIView alloc] init];
        socketPTFUnderLine.backgroundColor = UIColor.grayColor;
        [self addSubview:self.socketPortTF];
        [self.socketPortTF addSubview:socketPTFUnderLine];
        self.socketPortTF.sd_layout
        .topEqualToView(socketLabel)
        .bottomEqualToView(socketLabel)
        .rightSpaceToView(self.socketPortBtn, 0)
        .widthIs(45);
        
        socketPTFUnderLine.sd_layout
        .leftEqualToView(self.socketPortTF)
        .rightEqualToView(self.socketPortTF)
        .bottomSpaceToView(self.socketPortTF, -2)
        .heightIs(2);

        self.socketColon = [[UILabel alloc] init];
        self.socketColon.textColor = UIColor.grayColor;
        self.socketColon.text = @":";
        [self addSubview:self.socketColon];
        self.socketColon.sd_layout
        .topEqualToView(socketLabel)
        .rightSpaceToView(self.socketPortTF, 0)
        .widthIs(5)
        .autoHeightRatio(0);

        self.socketAddressTF = [[UITextField alloc] init];
        self.socketAddressTF.placeholder = @"arkpaastest.analysys.cn";
        self.socketAddressTF.font = [UIFont systemFontOfSize:15];
        self.socketAddressTF.delegate = self;
        self.socketAddressTF.clearButtonMode = UITextFieldViewModeAlways;
        self.socketAddressTF.autocapitalizationType = UITextAutocapitalizationTypeNone;
        UIView *socketATFUnderLine = [[UIView alloc] init];
        socketATFUnderLine.backgroundColor = UIColor.grayColor;
        [self addSubview:self.socketAddressTF];
        [self.socketAddressTF addSubview:socketATFUnderLine];
        self.socketAddressTF.sd_layout
        .topEqualToView(socketLabel)
        .bottomEqualToView(socketLabel)
        .leftSpaceToView(self.socketBtn, 0)
        .rightSpaceToView(self.socketColon, 0);
        
        socketATFUnderLine.sd_layout
        .leftEqualToView(self.socketAddressTF)
        .rightEqualToView(self.socketAddressTF)
        .bottomSpaceToView(self.socketAddressTF, -2)
        .heightIs(2);

        //第四行config
        UILabel *configLabel = [[UILabel alloc] init];
        configLabel.textColor = UIColor.grayColor;
        configLabel.text = @"config";
        [self addSubview:configLabel];
        configLabel.sd_layout
        .leftEqualToView(socketLabel)
        .topSpaceToView(self.saveSocketButton, 12)
        .widthIs(60)
        .autoHeightRatio(0);

        self.configBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.configBtn.tag = 102;
        [self.configBtn setTitle:@"https://" forState:UIControlStateNormal];
        [self.configBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        //        httpBtn.backgroundColor = [UIColor redColor];
        [self.configBtn addTarget:self action:@selector(protocolBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.configBtn];
        self.configBtn.sd_layout
        .leftSpaceToView(configLabel, 0)
        .topSpaceToView(self.saveSocketButton, 5)
        .widthIs(60)
        .heightIs(30);

        self.saveConfigButton = [[UIButton alloc] init];
        [self.saveConfigButton addTarget:self action:@selector(saveConfigButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        self.saveConfigButton.layer.borderWidth = 2;
        [self.saveConfigButton.layer setCornerRadius:5];
        self.saveConfigButton.layer.masksToBounds = YES;
        [self.saveConfigButton.layer setBorderColor:[UIColor grayColor].CGColor];
        [self.saveConfigButton setTitle:@"保存config" forState:UIControlStateNormal];
        self.saveConfigButton.titleLabel.font = [UIFont systemFontOfSize: 14];
        [self.saveConfigButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self addSubview:self.saveConfigButton];
        self.saveConfigButton.sd_layout
        .rightEqualToView(self.saveSocketButton)
        .topEqualToView(self.configBtn)
        .leftEqualToView(self.saveSocketButton)
        .bottomEqualToView(self.configBtn);

        self.configPortBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.configPortBtn.tag = 202;
        [self.configPortBtn setImage:[UIImage imageNamed:@"down"] forState:UIControlStateNormal];
        [self.configPortBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        //        httpBtn.backgroundColor = [UIColor redColor];
        [self.configPortBtn addTarget:self action:@selector(portBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.configPortBtn];
        self.configPortBtn.sd_layout
        .topEqualToView(self.saveConfigButton)
        .rightSpaceToView(self.saveConfigButton, 0)
        .bottomEqualToView(self.saveConfigButton)
        .widthIs(40);

        self.configPortTF = [[UITextField alloc] init];
        self.configPortTF.placeholder = @"8089";
        self.configPortTF.font = [UIFont systemFontOfSize:15];
        self.configPortTF.delegate = self;
        UIView *configPTFUnderLine = [[UIView alloc] init];
        configPTFUnderLine.backgroundColor = UIColor.grayColor;
        [self addSubview:self.configPortTF];
        [self.configPortTF addSubview:configPTFUnderLine];
        self.configPortTF.sd_layout
        .topEqualToView(configLabel)
        .bottomEqualToView(configLabel)
        .rightSpaceToView(self.configPortBtn, 0)
        .widthIs(45);
        
        configPTFUnderLine.sd_layout
        .leftEqualToView(self.configPortTF)
        .rightEqualToView(self.configPortTF)
        .bottomSpaceToView(self.configPortTF, -2)
        .heightIs(2);

        self.configColon = [[UILabel alloc] init];
        self.configColon.textColor = UIColor.grayColor;
        self.configColon.text = @":";
        [self addSubview:self.configColon];
        self.configColon.sd_layout
        .topEqualToView(configLabel)
        .rightSpaceToView(self.configPortTF, 0)
        .widthIs(5)
        .autoHeightRatio(0);

        self.configAddressTF = [[UITextField alloc] init];
        self.configAddressTF.placeholder = @"arkpaastest.analysys.cn";
        self.configAddressTF.font = [UIFont systemFontOfSize:15];
        self.configAddressTF.delegate = self;
        self.configAddressTF.clearButtonMode = UITextFieldViewModeAlways;
        self.configAddressTF.autocapitalizationType = UITextAutocapitalizationTypeNone;
        UIView *configAddressTFUnderLine = [[UIView alloc] init];
        configAddressTFUnderLine.backgroundColor = UIColor.grayColor;
        [self addSubview:self.configAddressTF];
        [self.configAddressTF addSubview:configAddressTFUnderLine];
        self.configAddressTF.sd_layout
        .topEqualToView(configLabel)
        .bottomEqualToView(configLabel)
        .leftSpaceToView(self.configBtn, 0)
        .rightSpaceToView(self.configColon, 0);
        
        configAddressTFUnderLine.sd_layout
        .leftEqualToView(self.configAddressTF)
        .rightEqualToView(self.configAddressTF)
        .bottomSpaceToView(self.configAddressTF, -2)
        .heightIs(2);

        //保存全部按钮
        self.saveButton = [[UIButton alloc] init];
        [self.saveButton addTarget:self action:@selector(saveButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        self.saveButton.layer.borderWidth = 2;
        [self.saveButton.layer setCornerRadius:5];
        self.saveButton.layer.masksToBounds = YES;
        [self.saveButton.layer setBorderColor:[UIColor grayColor].CGColor];
        [self.saveButton setTitle:@"保存全部" forState:UIControlStateNormal];
        [self.saveButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self addSubview:self.saveButton];
        self.saveButton.sd_layout
        .rightEqualToView(self.saveAppKeyButton)
        .topSpaceToView(self.saveConfigButton, 5)
        .leftEqualToView(uploadLabel)
        .heightIs(60);

        //发送数据按钮
        self.sendDataButton = [[UIButton alloc] init];
        [self.sendDataButton addTarget:self action:@selector(sendDataAction:) forControlEvents:UIControlEventTouchUpInside];
        self.sendDataButton.layer.borderWidth = 2;
        [self.sendDataButton.layer setCornerRadius:5];
        self.sendDataButton.layer.masksToBounds = YES;
        [self.sendDataButton.layer setBorderColor:[UIColor grayColor].CGColor];
        [self.sendDataButton setTitle:@"发送数据" forState:UIControlStateNormal];
        [self.sendDataButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self addSubview:self.sendDataButton];
        self.sendDataButton.sd_layout
        .rightEqualToView(self.saveAppKeyButton)
        .topSpaceToView(self.saveButton, 5)
        .leftEqualToView(uploadLabel)
        .heightIs(60);

        //显示地址
        UILabel *uploadAddressLabel = [[UILabel alloc] init];
        uploadAddressLabel.text = @"upload地址:";
//        self.uploadAddressLabel.backgroundColor = [UIColor redColor];
        uploadAddressLabel.font = [UIFont systemFontOfSize:15];
        uploadAddressLabel.textColor = UIColor.blueColor;
        [self addSubview:uploadAddressLabel];
        uploadAddressLabel.sd_layout
        .leftEqualToView(uploadLabel)
        .topSpaceToView(self.sendDataButton, 12)
        .widthIs(85)
        .autoHeightRatio(0);

        self.showUpAddressTV = [[UITextView alloc] init];
//        self.uploadAddressText.backgroundColor = [UIColor greenColor];
        self.showUpAddressTV.font = [UIFont systemFontOfSize:15];
        self.showUpAddressTV.textColor = UIColor.blueColor;
        self.showUpAddressTV.editable = NO;
        [self addSubview:self.showUpAddressTV];
        self.showUpAddressTV.sd_layout
        .leftSpaceToView(uploadAddressLabel, 0)
        .rightSpaceToView(self, 0)
        .topSpaceToView(self.sendDataButton, 5)
        .heightIs(40);

        UILabel *socketAddressLabel = [[UILabel alloc] init];
        socketAddressLabel.text = @"socket地址:";
        socketAddressLabel.font = [UIFont systemFontOfSize:15];
        socketAddressLabel.textColor = UIColor.blueColor;
        [self addSubview:socketAddressLabel];
        socketAddressLabel.sd_layout
        .leftEqualToView(uploadLabel)
        .topSpaceToView(self.showUpAddressTV, 12)
        .widthIs(85)
        .autoHeightRatio(0);

        self.showSocketAddressTV = [[UITextView alloc] init];
        self.showSocketAddressTV.font = [UIFont systemFontOfSize:15];
        self.showSocketAddressTV.textColor = UIColor.blueColor;
        self.showSocketAddressTV.editable = NO;
        [self addSubview:self.showSocketAddressTV];
        self.showSocketAddressTV.sd_layout
        .leftSpaceToView(socketAddressLabel, 0)
        .rightSpaceToView(self, 0)
        .topSpaceToView(self.showUpAddressTV, 5)
        .heightIs(40);

        UILabel *configAddressLabel = [[UILabel alloc] init];
        configAddressLabel.text = @"config地址:";
        configAddressLabel.font = [UIFont systemFontOfSize:15];
        configAddressLabel.textColor = UIColor.blueColor;
        [self addSubview:configAddressLabel];
        configAddressLabel.sd_layout
        .leftEqualToView(uploadLabel)
        .topSpaceToView(self.showSocketAddressTV, 12)
        .widthIs(85)
        .autoHeightRatio(0);

        self.showConfigAddressTV = [[UITextView alloc] init];
        self.showConfigAddressTV.font = [UIFont systemFontOfSize:15];
        self.showConfigAddressTV.textColor = UIColor.blueColor;
        self.showConfigAddressTV.editable = NO;
        [self addSubview:self.showConfigAddressTV];
        self.showConfigAddressTV.sd_layout
        .leftSpaceToView(configAddressLabel, 0)
        .rightSpaceToView(self, 0)
        .topSpaceToView(self.showSocketAddressTV, 5)
        .heightIs(40);

        UILabel *sendStatusLabel = [[UILabel alloc] init];
        sendStatusLabel.textColor = [UIColor purpleColor];
        sendStatusLabel.text = @"数据发送结果:";
        [self addSubview:sendStatusLabel];
        sendStatusLabel.sd_layout
        .leftEqualToView(uploadLabel)
        .topSpaceToView(self.showConfigAddressTV, 12)
        .rightEqualToView(self.saveAppKeyButton)
        .autoHeightRatio(0);

        //显示通知
        self.dataText = [[UITextView alloc] init];
        self.dataText.font = [UIFont systemFontOfSize:15];
        self.dataText.textColor = UIColor.grayColor;
        self.dataText.editable = NO;
        [self addSubview:self.dataText];
        self.dataText.sd_layout
        .leftEqualToView(uploadLabel)
        .rightEqualToView(self.saveAppKeyButton)
        .topSpaceToView(sendStatusLabel, 0)
        .heightIs(300);
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
