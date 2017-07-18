//
//  NaviTitleView.m
//  myCalendar
//
//  Created by lqq on 17/4/12.
//  Copyright © 2017年 lqq. All rights reserved.
//

#import "NaviTitleView.h"

@implementation NaviTitleView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        UILabel *titleLab = [[UILabel alloc]init];
        titleLab.textColor = [UIColor blackColor];
        titleLab.font = [UIFont systemFontOfSize:12];
        [self addSubview:titleLab];
        self.titleLabel = titleLab;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        
        UIButton *lastBtn = [[UIButton alloc]init];
        [lastBtn setImage:[UIImage imageNamed:@"last"] forState:UIControlStateNormal];
        lastBtn.frame = CGRectMake(0, 0, lastBtn.currentImage.size.width,  frame.size.height);
        [self addSubview:lastBtn];
        self.lastBtn = lastBtn;
        
        UIButton *nextBtn = [[UIButton alloc]init];
        [nextBtn setImage:[UIImage imageNamed:@"next"] forState:UIControlStateNormal];
        nextBtn.frame = CGRectMake(frame.size.width - lastBtn.currentImage.size.width, 0, lastBtn.currentImage.size.width, frame.size.height);
        [self addSubview:nextBtn];
        self.nextBtn = nextBtn;
        
        self.titleLabel.frame = CGRectMake(CGRectGetMaxX(lastBtn.frame), 0, frame.size.width - nextBtn.frame.size.width - lastBtn.frame.size.width, 44);
        
    }
    return self;
}
@end
