//
//  CSBannerTableViewCell.m
//  CloudShoppingSystem
//
//  Created by dengyuchi on 2017/5/3.
//  Copyright © 2017年 dengyuchi. All rights reserved.
//

#import "CSBannerTableViewCell.h"
#import "PMCircleCollectionView.h"

@interface CSBannerTableViewCell ()<PMCircleCollectionViewDelegate>

@property(nonatomic, strong)PMCircleCollectionView *circleBannerView;
@property(nonatomic, strong)UIPageControl *pageControl;
@property(nonatomic, strong)NSArray *bannerListArray;

@end

@implementation CSBannerTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initSubView];
    }
    return self;
}

-(void)initSubView
{
    [self.contentView addSubview:self.circleBannerView];
    [self.contentView addSubview:self.pageControl];
    
    self.pageControl.frame = CGRectMake(0, self.circleBannerView.bottom - 16 * SA_SCREEN_SCALE, SA_SCREEN_WIDTH, 10 * SA_SCREEN_SCALE);
    
    self.pageControl.currentPage = 0;
}

+(CGFloat)cellHeight
{
    return 190 * SA_SCREEN_SCALE;
}

+(CGFloat)cellWidth
{
    return SA_SCREEN_WIDTH;
}

+(NSString *)cellIdentifier
{
    return @"CSBannerTableViewCellId";
}

-(void)setBannerListArray:(NSArray *)bannerListArray
{
    _bannerListArray = bannerListArray;
    if (_bannerListArray) {
        __weak typeof(self) weakSelf = self;
        self.circleBannerView.imageArray = _bannerListArray;
        self.pageControl.numberOfPages = _bannerListArray.count;
        self.pageControl.centerX = self.contentView.centerX;
        [self.circleBannerView addPageScrollBlock:^(NSInteger index) {
            weakSelf.pageControl.currentPage = index;
        }];
    }
}

#pragma --mark 懒加载
-(PMCircleCollectionView *)circleBannerView
{
    if (!_circleBannerView ) {
        _circleBannerView = ({
//            PMCircleCollectionView *view = [PMCircleCollectionView circleViewWithFrame:CGRectZero urlImageArray:[NSArray array]];
            PMCircleCollectionView *view = [PMCircleCollectionView circleViewWithFrame:CGRectMake(0, 0, SA_SCREEN_WIDTH, 190 * SA_SCREEN_SCALE) localImageArray:[NSArray array]];
            view.delegate = self;
            view.autoScroll = YES;//开启自动轮播
            view.scrollByItem = NO;// YES 每次滑动一个item; NO 每次滑动一页
            [view addTapBlock:^(NSInteger index) {
                NSLog(@"circle1 clickat:%ld",index);
            }];
            view;
        });
    }
    return _circleBannerView;
}


-(UIPageControl *)pageControl
{
    if (!_pageControl) {
        _pageControl = ({
            UIPageControl *control = [[UIPageControl alloc]init];
            control.currentPageIndicatorTintColor = [UIColor colorWithHexString:@"#ff2d55"];
            control.pageIndicatorTintColor = [UIColor colorWithHexString:@"#efeff4"];
            control.backgroundColor = [UIColor clearColor];
            control;
        });
    }
    return _pageControl;
}

@end
