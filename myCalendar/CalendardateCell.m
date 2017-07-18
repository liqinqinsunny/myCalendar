//
//  CalendardateCell.m
//  myCalendar
//
//  Created by lqq on 17/4/12.
//  Copyright © 2017年 lqq. All rights reserved.
//

#import "CalendardateCell.h"

@interface CalendardateCell()
@end

@implementation CalendardateCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        UILabel *textLab = [[UILabel alloc]init];
        textLab.textColor = [UIColor blackColor];
        textLab.font = [UIFont systemFontOfSize:12];
        textLab.textAlignment = NSTextAlignmentCenter;
        [self addSubview:textLab];
        self.titlelabel = textLab;
        textLab.frame = CGRectMake(0, 0, frame.size.width - 0.5, frame.size.height - 0.5);
    }
    return self;
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    self.titlelabel.text = title;
}


@end
