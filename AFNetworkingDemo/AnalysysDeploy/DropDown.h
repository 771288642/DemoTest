//
//  DropDown.h
//  Demo
//
//  Created by analysysmac-1 on 2018/7/30.
//  Copyright © 2018年 analysysmac-1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DropDown : UIView<UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>{
    UITableView *tv;//下拉列表
    NSArray *tableArray;//下拉列表数据
    UITextField *textField;//文本输入框
    BOOL showList;//是否弹出下拉列表
    CGFloat tabheight;//table下拉列表的高度
    CGFloat frameHeight;//frame的高度
}

@property (nonatomic,retain) UITableView *tv;
@property (nonatomic,retain) NSArray *tableArray;
@property (strong, nonatomic) NSDictionary *pickerDic;//获取文件里的字典
@property (strong, nonatomic) NSArray *provinceArray;//省、市
@property (nonatomic,retain) UITextField *textField;
@property (assign, nonatomic) BOOL showList;

-(void)dontshowlist;

@end
