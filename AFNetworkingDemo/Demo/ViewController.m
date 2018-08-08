//
//  ViewController.m
//  Demo
//
//  Created by analysysmac-1 on 2018/7/30.
//  Copyright © 2018年 analysysmac-1. All rights reserved.
//

#import "ViewController.h"
#import "DemoView.h"
#import <AnalysysAgent/AnalysysAgent.h>
#import "UIView+Addition.h"
#import "ListView.h"

#define isPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

static NSString *const SETTING_KEY = @"settingKey";  //  获取本地数据的key

static NSString *const APP_KEY = @"appKey";  //  appkey

static NSString *const UP_PROTOCOL = @"upProtocol";  //  up协议
static NSString *const UP_ADDRESS = @"upAddress";  //  up地址
static NSString *const UP_PORT = @"upPort";  //  up端口

static NSString *const WS_PROTOCOL = @"wsProtocol";  //  ws协议
static NSString *const WS_ADDRESS = @"wsAddress";  //  ws地址
static NSString *const WS_PORT = @"wsPort";  //  ws端口

static NSString *const CONFIG_PROTOCOL = @"configProtocol";  //  config协议
static NSString *const CONFIG_ADDRESS = @"configAddress";  //  config地址
static NSString *const CONFIG_PORT = @"configPort";  //  config端口


@interface ViewController ()<DemoViewProtocol>

//  承载视图
@property (nonatomic, strong) DemoView *demoView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //注册通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveSDKNotification:) name:@"uploadingMsgNotification" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveSDKNotification:) name:@"uploadMsgSuccessNotification" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveSDKNotification:) name:@"uploadMsgFailedsNotification" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveSDKNotification:) name:@"reUploadMsgNotification" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveSDKNotification:) name:@"NoNetWorkNotification" object:nil];
    
//    self.view.backgroundColor = [UIColor greenColor];
    
    CGRect statusBarFrame = [UIApplication sharedApplication].statusBarFrame;
    UINavigationBar *navigationBar = self.navigationController.navigationBar;
    CGFloat topViewHeight = navigationBar.height + statusBarFrame.size.height;
    CGFloat margin = 5;
    
    //  初始化底层视图
    self.demoView = [[DemoView alloc] initWithFrame:CGRectMake(margin, topViewHeight + margin, self.view.width - margin*2, self.view.height - topViewHeight - margin*2)];
    self.demoView.delegate = self;
    self.demoView.contentSize = CGSizeMake(self.demoView.width, self.demoView.height + 350);
//    self.demoView.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.demoView];
    
    if (isPhoneX) {
        self.demoView.height -= 34;
    }
    
    [self loadLocalDataupdateUI];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}


-(void)dealloc {
    //  移除通知
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark *** UI ***

/**
 读取本地数据更新UI
 */
- (void)loadLocalDataupdateUI {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *configInfo = [defaults objectForKey:SETTING_KEY];
    
    //  本地是否存有数据
    if (configInfo) {
        self.demoView.appKeyText.text = configInfo[APP_KEY];
        
        [self.demoView.uploadBtn setTitle:configInfo[UP_PROTOCOL] ?: @"http://" forState:UIControlStateNormal] ;
        self.demoView.uploadAddressTF.text = configInfo[UP_ADDRESS];
        self.demoView.uploadPortTF.text = configInfo[UP_PORT];
        
        [self.demoView.socketBtn setTitle:configInfo[WS_PROTOCOL] ?: @"ws://" forState:UIControlStateNormal];
        self.demoView.socketAddressTF.text = configInfo[WS_ADDRESS];
        self.demoView.socketPortTF.text = configInfo[WS_PORT];
        
        [self.demoView.configBtn setTitle:configInfo[CONFIG_PROTOCOL] ?: @"http://" forState:UIControlStateNormal];
        self.demoView.configAddressTF.text = configInfo[CONFIG_ADDRESS];
        self.demoView.configPortTF.text = configInfo[CONFIG_PORT];
        
        
        //  修改SDK地址信息
        [AnalysysAgent setUploadURL:self.demoView.showUpAddressTV.text];
        [AnalysysAgent setVisitorDebugURL:self.demoView.showSocketAddressTV.text];
        [AnalysysAgent setVisitorConfigURL:self.demoView.showConfigAddressTV.text];
        
    } else {
        //  使用默认配置信息
        self.demoView.appKeyText.text = @"paastest";
        
        [self.demoView.uploadBtn setTitle:@"https://" forState:UIControlStateNormal] ;
        self.demoView.uploadAddressTF.text = @"arkpaastest.analysys.cn";
        self.demoView.uploadPortTF.text = @"4089";
        
        [self.demoView.socketBtn setTitle:@"wss://" forState:UIControlStateNormal];
        self.demoView.socketAddressTF.text = @"arkpaastest.analysys.cn";
        self.demoView.socketPortTF.text = @"4091";
        
        [self.demoView.configBtn setTitle:@"https://" forState:UIControlStateNormal];
        self.demoView.configAddressTF.text = @"arkpaastest.analysys.cn";
        self.demoView.configPortTF.text = @"4089";
        
        [self saveConfigInfo];
    }

    [self updateShowView];
}


#pragma mark *** 按钮事件 ***

/** 保存App Key信息 */
- (void)saveAppKeyButtonAction {
    if (self.demoView.appKeyText.text.length == 0) {
        [self showAlert:@"app key设置异常"];
        return;
    }
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *configInfo = [defaults objectForKey:SETTING_KEY];
     NSMutableDictionary *sdkConfigDic = [NSMutableDictionary dictionary];
    sdkConfigDic[APP_KEY] = self.demoView.appKeyText.text;
    
    sdkConfigDic[UP_PROTOCOL] = configInfo[UP_PROTOCOL];
    sdkConfigDic[UP_ADDRESS] = configInfo[UP_ADDRESS];
    sdkConfigDic[UP_PORT] = configInfo[UP_PORT];
    
    sdkConfigDic[WS_PROTOCOL] = configInfo[WS_PROTOCOL];
    sdkConfigDic[WS_ADDRESS] = configInfo[WS_ADDRESS];
    sdkConfigDic[WS_PORT] = configInfo[WS_PORT];
    
    sdkConfigDic[CONFIG_PROTOCOL] = configInfo[CONFIG_PROTOCOL];
    sdkConfigDic[CONFIG_ADDRESS] = configInfo[CONFIG_ADDRESS];
    sdkConfigDic[CONFIG_PORT] = configInfo[CONFIG_PORT];
    [defaults setObject:sdkConfigDic forKey:SETTING_KEY];
    //  必须使用 EGAppKey 存储本地，SDK使用ß®
    [defaults setObject:self.demoView.appKeyText.text forKey:@"EGAppKey"];
    
    [self showAlert:@"成功保存App Key ！"];

    [self.view endEditing:YES];
}

/** 保存配置信息 */
- (void)saveButtonAction {

    //  检查数据合法性
    if (self.demoView.appKeyText.text.length == 0) {
        [self showAlert:@"app key设置异常"];
        return;
    }
    if (self.demoView.uploadAddressTF.text.length == 0 ||
        self.demoView.uploadPortTF.text.length == 0) {
        [self showAlert:@"upload设置异常"];
        return;
    }
    if (self.demoView.socketAddressTF.text.length == 0 ||
        self.demoView.socketPortTF.text.length == 0) {
        [self showAlert:@"socket设置异常"];
        return;
    }
    if (self.demoView.configAddressTF.text.length == 0 ||
        self.demoView.configPortTF.text.length == 0) {
        [self showAlert:@"config设置异常"];
        return;
    }
    
    //  保存本地数据
    if ([self saveConfigInfo]) {
        
        [self updateShowView];
        
        //  修改SDK地址信息
        [AnalysysAgent setUploadURL:self.demoView.showUpAddressTV.text];
        [AnalysysAgent setVisitorDebugURL:self.demoView.showSocketAddressTV.text];
        [AnalysysAgent setVisitorConfigURL:self.demoView.showConfigAddressTV.text];
        
        [self showAlert:@"全部保存成功！"];
    } else {
        NSLog(@"数据存储失败!!!!!");
    }
    
    [self.view endEditing:YES];
}

/** 保存本地信息 */
- (BOOL)saveConfigInfo {
    NSMutableDictionary *sdkConfigDic = [NSMutableDictionary dictionary];
    
    sdkConfigDic[APP_KEY] = self.demoView.appKeyText.text;
    
    sdkConfigDic[UP_PROTOCOL] = self.demoView.uploadBtn.titleLabel.text;
    sdkConfigDic[UP_ADDRESS] = self.demoView.uploadAddressTF.text;
    sdkConfigDic[UP_PORT] = self.demoView.uploadPortTF.text;
    
    sdkConfigDic[WS_PROTOCOL] = self.demoView.socketBtn.titleLabel.text;
    sdkConfigDic[WS_ADDRESS] = self.demoView.socketAddressTF.text;
    sdkConfigDic[WS_PORT] = self.demoView.socketPortTF.text;
    
    sdkConfigDic[CONFIG_PROTOCOL] = self.demoView.configBtn.titleLabel.text;
    sdkConfigDic[CONFIG_ADDRESS] = self.demoView.configAddressTF.text;
    sdkConfigDic[CONFIG_PORT] = self.demoView.configPortTF.text;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:sdkConfigDic forKey:SETTING_KEY];
    //  必须使用 EGAppKey 存储本地，SDK使用
    [defaults setObject:self.demoView.appKeyText.text forKey:@"EGAppKey"];
    
    return [defaults synchronize];
}

/** 刷新页面展示地址视图 */
- (void)updateShowView {
    //  赋值 展示控件
    self.demoView.showUpAddressTV.text = [NSString stringWithFormat:@"%@%@:%@",self.demoView.uploadBtn.titleLabel.text ?: @"",self.demoView.uploadAddressTF.text,self.demoView.uploadPortTF.text];
    
    self.demoView.showSocketAddressTV.text = [NSString stringWithFormat:@"%@%@:%@",self.demoView.socketBtn.titleLabel.text ?: @"",self.demoView.socketAddressTF.text,self.demoView.socketPortTF.text];
    
    self.demoView.showConfigAddressTV.text = [NSString stringWithFormat:@"%@%@:%@",self.demoView.configBtn.titleLabel.text ?: @"",self.demoView.configAddressTF.text,self.demoView.configPortTF.text];
    self.demoView.dataText.text = @"";
}

/**  发送数据 */
- (void)sendDataButtonAction {
    [self.view endEditing:YES];
    
    self.demoView.dataText.text = @"";
    
    NSString *trackEvent = [NSString stringWithFormat:@"track_%ld", arc4random() % 100];
    [AnalysysAgent track:trackEvent properties:@{@"name":@"部署人员", @"city":@"北京"}];
}

#pragma mark *** DemoViewProtocol ***

- (void)saveAppKeyBtnAction:(UIButton *)btn {
    [self saveAppKeyButtonAction];
}

- (void)saveBtnAction:(UIButton *)btn {
    [self saveButtonAction];
}

- (void)sendBtnAction:(UIButton *)btn {
    [self sendDataButtonAction];
}

#pragma mark - 弹窗提示

- (void)showAlert:(NSString *)_message {
    UIAlertView *promptAlert = [[UIAlertView alloc] initWithTitle:@"提示:" message:_message delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
    [promptAlert show];
}

#pragma mark - 接收通知

- (void)receiveSDKNotification:(NSNotification *)notification {
    NSLog(@"收到数据接收通知:%@   :%@", notification.name, notification.object);
    dispatch_async(dispatch_get_main_queue(), ^{
        self.demoView.dataText.text = [NSString stringWithFormat:@"%@",notification.object];
    });
}

#pragma mark - 触摸屏幕时触发

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

@end
