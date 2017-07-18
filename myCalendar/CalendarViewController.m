//
//  CalendarViewController.m
//  myCalendar
//
//  Created by lqq on 17/4/12.
//  Copyright © 2017年 lqq. All rights reserved.
//

#import "CalendarViewController.h"
#import "NaviTitleView.h"
#import "CalendardateCell.h"
#import "DBCommon.h"
#import "HeaderCollectionReusableView.h"

#define screenWidth     [UIScreen mainScreen].bounds.size.width
#define screenHeight    [UIScreen mainScreen].bounds.size.height

@interface CalendarViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
// 当前日期
@property(nonatomic,copy) NSString *date;
// 当前日期数组
@property(nonatomic,strong) NSArray *dateArry;
@property(nonatomic,strong) UICollectionView *collectionView;

@property(nonatomic,assign) NSInteger weeks;

@property(nonatomic,strong) NaviTitleView *titleView;


@end

@implementation CalendarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 获取当前日期
    [self setUpdate];
    
    // 获取当前月份中有多少天，第一天是从星期几开始
    [self setData];
    
    // 设置内容
    [self setupCollectionView];
    
    // 设置标题
    [self setNaviTitleView];
}
- (NSArray *)dateArry
{
    if (_dateArry == nil) {
        _dateArry = [NSArray array];
    }
    return _dateArry;
}

- (void)setUpdate
{
    NSDateFormatter *format = [[NSDateFormatter alloc]init];
    format.dateFormat = @"yyyy-MM-dd";
    _date = [format stringFromDate: [NSDate date]];
}
#pragma mark - 设置数据
- (void)setData
{
    NSInteger week =  [DBCommon firstWeekdayInThisMonth:[NSDate date] with:_date];
    NSInteger days = [DBCommon totaldaysInThisMonth:[NSDate date] withDatestr:_date];

    // 一共的周数
    NSInteger w = (week + days) / 7;
    if ((week + days)% 7 > 0) {
        _weeks = w + 1;
    } else{
        _weeks = w;
    }
    NSMutableArray *daysAry = [NSMutableArray array];
    for (int i = 0; i < days + week ; i++) {
        if (i- week <0) {
            [daysAry addObject:@" "];
        } else
        {
            [daysAry addObject:[NSString stringWithFormat:@"%zd",i+1-week]];
        }
    }
    self.dateArry = [daysAry copy];
    
    [self.collectionView reloadData];
    
}

#pragma mark - 设置内容
- (void)setupCollectionView
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake(screenWidth/7, screenWidth/7);
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.headerReferenceSize = CGSizeMake(screenWidth, screenWidth/7);
    
    CGFloat height =  screenWidth / 7 * (self.weeks + 2) + 20;
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, height) collectionViewLayout:layout];
    collectionView.backgroundColor = [UIColor clearColor];
    collectionView.dataSource = self;
    collectionView.delegate = self;
    [self.view addSubview:collectionView];
    
    [collectionView registerClass:[CalendardateCell class] forCellWithReuseIdentifier:NSStringFromClass([CalendardateCell class])];
    
    [collectionView registerClass:[HeaderCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([HeaderCollectionReusableView class])];
    
    _collectionView = collectionView;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CalendardateCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([CalendardateCell class]) forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[CalendardateCell alloc]initWithFrame:CGRectMake(0, 0, screenWidth/ 7, screenWidth/7)];
    }
    
    cell.title = self.dateArry[indexPath.row];
    
    return cell;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        
        HeaderCollectionReusableView *headercollView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([HeaderCollectionReusableView class]) forIndexPath:indexPath];
        
        if (headercollView == nil) {
            headercollView = [[HeaderCollectionReusableView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, screenWidth/7)];
        }

        return headercollView;
        
    }
    else
        return nil;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dateArry.count;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{

    NSLog(@"%@",self.dateArry[indexPath.row]);
}


#pragma mark - 设置标题
- (void)setNaviTitleView
{
    NaviTitleView *titleView = [[NaviTitleView alloc]initWithFrame:CGRectMake(0, 0, 200, 44)];
    self.navigationItem.titleView = titleView;
    [titleView.lastBtn addTarget:self action:@selector(lastbtnClick) forControlEvents:UIControlEventTouchUpInside];
    [titleView.nextBtn addTarget:self action:@selector(nextBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.titleView = titleView;
    
    [self setTitleView];
    
}
- (void)setTitleView
{
    NSRange range = NSMakeRange(0, 7);
    self.titleView.titleLabel.text = [_date substringWithRange:range];
    
}

#pragma mark 上一个月和下一个月
// 上一个月
- (void)lastbtnClick
{
    NSLog(@"上一个月%@",_date);
    
    NSInteger year = [[_date substringWithRange:NSMakeRange(0, 4)] intValue];
    NSInteger month = [[_date substringWithRange:NSMakeRange(5, 2)] intValue];

    if (month>1) {
        _date = [_date stringByReplacingCharactersInRange:NSMakeRange(5, 2) withString:[NSString stringWithFormat:@"%.2ld",month -1]];
    } else {
        _date = [_date stringByReplacingCharactersInRange:NSMakeRange(0, 7) withString:[NSString stringWithFormat:@"%zd-12",year -1]];
    }
    
    [self setData];
    [self setTitleView];

}
// 下一个月
- (void)nextBtnClick
{
    NSInteger year = [[_date substringWithRange:NSMakeRange(0, 4)] intValue];
    NSInteger month = [[_date substringWithRange:NSMakeRange(5, 2)] intValue];
    
    if (month <= 11) {
        _date = [_date stringByReplacingCharactersInRange:NSMakeRange(5, 2) withString:[NSString stringWithFormat:@"%.2ld",month + 1]];
    } else {
        _date = [_date stringByReplacingCharactersInRange:NSMakeRange(0, 7) withString:[NSString stringWithFormat:@"%zd-01",year + 1]];
    }
    NSLog(@"下一个月 %@",_date);

    
    [self setData];
    
    [self setTitleView];

}


@end
