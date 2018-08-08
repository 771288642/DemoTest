//
//  ListView.h
//  AnalysysDeploy
//
//  Created by SoDo on 2018/8/7.
//  Copyright © 2018年 analysysmac-1. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^Block)(NSIndexPath *, id);

@interface ListView : UIView


/**
 显示下拉列表视图

 @param view 当前触发的视图
 @param dataArray 数据源列表
 @param block 回调函数
 */
+ (void)showWithView:(UIView *)view dataArray:(NSArray *)dataArray block:(Block)block;



@end
