//
//  ViewController.m
//  Test
//
//  Created by analysysmac-1 on 2018/7/27.
//  Copyright © 2018年 analysysmac-1. All rights reserved.
//

#import "ViewController.h"
#import "JYSerialOperation.h"

@interface ViewController (){
    NSInteger tickets;//总票数
    NSInteger count;//当前卖出去票数
}

@property (nonatomic, strong) NSThread* ticketsThreadOne;
@property (nonatomic, strong) NSThread* ticketsThreadTwo;
@property (nonatomic, strong) NSLock *ticketsLock;

@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UIButton *button;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 50, self.view.frame.size.width, 30)];
    self.textField.text = @"123qweasfgr64543";
    [self.view addSubview:self.textField];
    
    self.button = [[UIButton alloc] initWithFrame:CGRectMake(0, 90, self.view.frame.size.width, 60)];
    self.button.backgroundColor = UIColor.blueColor;
    [self.button setTitle:@"发送通知" forState:UIControlStateNormal];
    [self.button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.button];
    
//    JYSerialOperation *op = [[JYSerialOperation alloc] init];
//    [op start];
//
//    op.comBlock = ^(NSData *imageData) {
//        UIImage *image = [UIImage imageWithData:imageData];
//        self.imageView.image = image;
//    }
    
//    tickets = 100;
//    count = 0;
//
//    //锁对象
//    self.ticketsLock = [[NSLock alloc] init];
//
//    self.ticketsThreadOne = [[NSThread alloc] initWithTarget:self selector:@selector(sellAction) object:nil];
//    self.ticketsThreadOne.name = @"thread-1";
//    [self.ticketsThreadOne start];
//
//    self.ticketsThreadTwo = [[NSThread alloc] initWithTarget:self selector:@selector(sellAction) object:nil];
//    self.ticketsThreadTwo.name = @"thread-2";
//    [self.ticketsThreadTwo start];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)buttonClick{
    NSDictionary *dict = [[NSDictionary alloc]initWithObjectsAndKeys:self.textField.text,@"textOne",nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"sendChatlist" object:nil userInfo:dict];
    //[self.navigationController popViewControllerAnimated:YES];
}

- (void)sellAction{
    while (true) {
        //上锁
        [self.ticketsLock lock];
        if (tickets > 0) {
            [NSThread sleepForTimeInterval:0.5];
            count = 100 - tickets;
            NSLog(@"当前总票数是：%ld----->卖出：%ld----->线程名:%@",tickets,count,[NSThread currentThread]);
            tickets--;
        }else{
            break;
        }
        //解锁
        [self.ticketsLock unlock];
    }
}


@end
