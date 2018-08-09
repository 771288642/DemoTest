//
//  ListView.m
//  AnalysysDeploy
//
//  Created by SoDo on 2018/8/7.
//  Copyright © 2018年 analysysmac-1. All rights reserved.
//

#import "ListView.h"
#import "ListTableViewCell.h"

#import "UIView+Addition.h"


static CGFloat const tableViewHeight = 40.f;

@interface ListView()<UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, copy) Block selectBlock;

@property (nonatomic, strong) UIView *clickView;
@property (nonatomic, assign) CGRect clickViewRect;

@end

@implementation ListView

- (instancetype)init
{
    self = [super init];
    if (self) {
//        self.alpha = 0.5;
        self.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.1f];
        self.frame = [UIApplication sharedApplication].keyWindow.frame;
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenListView)];
        tapGesture.delegate = self;
        [self addGestureRecognizer:tapGesture];
    }
    return self;
}

#pragma mark *** UITapGestureRecognizer ***

/** 点击视图移除 */
- (void)hiddenListView {
    [self removeFromSuperview];
}

#pragma mark *** Interface Method ***

/** 显示下拉列表视图 */
+ (void)showWithView:(UIView *)view dataArray:(NSArray *)dataArray block:(Block)block {
    
    ListView *listView = [[ListView alloc] init];
    listView.clickView = view;
    listView.dataArray = dataArray;
    listView.selectBlock = [block copy];
    
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow addSubview:listView];
    
    //  坐标转换
    listView.clickViewRect = [view convertRect:view.bounds toView:keyWindow];
    NSLog(@"viewRect:%@", NSStringFromCGRect(listView.clickViewRect));
    
    [listView addSubview:listView.tableView];
}

#pragma mark *** Private Method ***

/** 懒加载tableview */
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 80, tableViewHeight*self.dataArray.count)];
        CGFloat centerX = self.clickViewRect.origin.x + self.clickViewRect.size.width/2.0;
        CGFloat centgerY = self.clickViewRect.origin.y + self.clickViewRect.size.height/2.0;
        _tableView.center = CGPointMake(centerX, centgerY);
        _tableView.top = self.clickViewRect.origin.y + self.clickView.height;
        [_tableView registerNib:[UINib nibWithNibName:@"ListTableViewCell" bundle:nil] forCellReuseIdentifier:@"ListTableViewCell"];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.separatorColor = [UIColor grayColor];
    }
    return _tableView;
}

#pragma mark *** UITableViewDelegate ***

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ListTableViewCell"];

    NSString *title = self.dataArray[indexPath.row];
    cell.titleLabel.text = title;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (self.selectBlock) {
        self.selectBlock(indexPath, self.dataArray[indexPath.row]);
    }
    [self hiddenListView];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return tableViewHeight;
}


#pragma mark *** UIGestureRecognizerDelegate ***

/** 处理子视图点击穿透到父视图，仅让承载视图响应tap事件 */
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if([touch.view isKindOfClass:[self class]]) {
        return YES;
    }
    return NO;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
