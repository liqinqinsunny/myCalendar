//
//  HeaderCollectionReusableView.m
//  myCalendar
//
//  Created by lqq on 17/4/12.
//  Copyright © 2017年 lqq. All rights reserved.
//

#import "HeaderCollectionReusableView.h"

@implementation HeaderCollectionReusableView


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        NSArray *ary = @[@"周日",@"周一",@"周二",@"周三",@"周四",@"周五",@"周六"];
        
        UIView *bgView = [[UIView alloc]initWithFrame:frame];
        [self addSubview:bgView];
        for (int i = 0; i<ary.count; i++) {
            UILabel *label = [[UILabel alloc]init];
            label.textColor = [UIColor blackColor];
            label.font = [UIFont systemFontOfSize:12];
            label.textAlignment = NSTextAlignmentCenter;
            label.text = ary[i];
            [bgView addSubview:label];
            CGFloat w = frame.size.width / ary.count;
            label.frame = CGRectMake(i * w,0, w, frame.size.height);
        }
    }
    return self;
}

@end
