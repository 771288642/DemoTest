//
//  ViewController.m
//  AFNetworkingDemo
//
//  Created by analysysmac-1 on 2018/7/25.
//  Copyright © 2018年 analysysmac-1. All rights reserved.
//

#import "ViewController.h"
#import "CityModel.h"

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSArray *dataList;
@property (weak, nonatomic) UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view = [[UIView alloc]initWithFrame:[UIScreen mainScreen].applicationFrame];
    CGRect frame = self.view.bounds;
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height - 44) style:UITableViewStylePlain];

    [tableView setDataSource:self];
    [tableView setDelegate:self];
    [tableView setRowHeight:80];
    [self.view addSubview:tableView];
    self.tableView = tableView;
    UIToolbar *toolBar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, tableView.bounds.size.height, 320, 44)];
    [self.view addSubview:toolBar];
    

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"MyCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    //设置单元格内容
    CityModel *city = self.dataList[indexPath.row];
    
    cell.textLabel.text = city.name;
    cell.detailTextLabel.text = city.condition;
    return cell;
}



@end
