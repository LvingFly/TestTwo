//
//  MSGuideView.m
//  MinShengOK
//
//  Created by 飞光普 on 15/4/28.
//  Copyright (c) 2015年 飞光普. All rights reserved.
//

#import "MSGuideView.h"
#import "MSPageControl.h"

static NSString * const kGuideButtonName = @"guide_button";

@implementation MSGuideView
@synthesize delegate;
@synthesize imageList;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self initUIElement];
        self.isDismissing=NO;
        //默认滑动到最后一张引导图后，再向后滑动，退出引导页。
        self.allowExit = NO;
    }
    return self;
}

- (void)layoutSubviews
{
    bgScrollView.contentSize = CGSizeMake(imageList.count*self.width, self.height);
    
    [bgScrollView setContentOffset:CGPointMake(bgScrollView.width * pageControl.currentPage, 0)];
    
    [pageControl layoutSubviews];
}

-(void)initUIElement
{
    self.imageList = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"guide" ofType:@"plist"]];
    
    if (imageList==nil) {
        return;
    }
    
    bgScrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    bgScrollView.showsVerticalScrollIndicator = NO;
    bgScrollView.showsHorizontalScrollIndicator = NO;
    bgScrollView.pagingEnabled = YES;
    bgScrollView.scrollsToTop = NO;
    bgScrollView.bounces = NO;
    bgScrollView.delegate = self;
    bgScrollView.backgroundColor = [UIColor clearColor];
    bgScrollView.contentSize = CGSizeMake(imageList.count*CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
    [self addSubview:bgScrollView];

    [self loadAllPages]; //默认load首次启动引导界面
    
    pageControl = [[MSPageControl alloc]initWithFrameAndPageNumber:self.bounds pageNumber:imageList.count];
    pageControl.userInteractionEnabled = NO;
    [pageControl setCurrentPage:0];
    pageControl.centerX = self.centerX;
    pageControl.centerY = self.height - 37.5;
    [self addSubview:pageControl];
    pageControl.hidden = YES;
}

-(void)setPageControllerVisible:(BOOL)visible
{
    pageControl.hidden = !visible;
}

-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    CGPoint offset = bgScrollView.contentOffset;
    CGRect bounds = bgScrollView.frame;
    CGFloat index = (CGFloat)(offset.x / bounds.size.width);
    if(index >= 2.0)
    {
        return YES;
    }
    return NO;
}

- (void)oneFingerSwiperight:(UISwipeGestureRecognizer *)recognizer
{
    [self guideViewQuit];
}

-(void)loadAllPages
{
    float xPos=0;
    
    for (int x = 0; x < imageList.count; x++) {
        UIView *tempView = [[UIView alloc] initWithFrame:bgScrollView.bounds];
        tempView.left += xPos;
        [bgScrollView addSubview:tempView];
        xPos+=CGRectGetWidth(bgScrollView.frame);
        
        NSString *name = [imageList objectAtIndex:x];
        
        if (IS_IPHONE_6PLUS_SCREEN) {
            name = [name stringByAppendingString:@"_6plus"];
        } else if (IS_IPHONE_6_SCREEN) {
            name = [name stringByAppendingString:@"_6"];
        } else if (IS_IPHONE_5S_SCREEN) {
            name = [name stringByAppendingString:@"_5s"];
        }
//        else if (IS_IPHONE_4S_SCREEN) {
//            name = [name stringByAppendingString:@"_4s"];
//        }
        
        UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:name]];
        imageView.center = CGPointMake(tempView.width/2, tempView.height/2);
        [tempView addSubview:imageView];
        
        //最后一页添加按钮
        if (x == imageList.count-1)
        {
            imageView.userInteractionEnabled = YES;
            
            UIButton* startButton = [[UIButton alloc]init];
            startButton.backgroundColor = [UIColor clearColor];
            [startButton setImage:[UIImage imageNamed:@"start"] forState:UIControlStateNormal];
            [startButton addTarget:self action:@selector(startButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
            [startButton sizeToFit];
            
            startButton.centerX = self.centerX;
            
            if (IS_IPHONE_6PLUS_SCREEN) {
                startButton.bottom = self.height - 72;
            } else if (IS_IPHONE_6_SCREEN) {
                startButton.bottom = self.height - 72;
            } else if (IS_IPHONE_5S_SCREEN) {
                startButton.bottom = self.height - 72;
            }
//            else {
//                startButton.bottom = self.height - 51.5;
//            }
            
            [imageView addSubview:startButton];
        }
    }
}

-(void)startButtonClicked:(id)sender
{
    [self guideViewQuit];
}

- (void)enterAppView
{
    
    if (pageControl.currentPage != [self.imageList count] -1) {
        return;
    }
    
    [self guideViewQuit];
}

-(void)guideViewQuit
{
    
    if (![[self.superview subviews] containsObject:self]) {
        return;
    }
    if (self.isDismissing) {
        return;
    }
    self.isDismissing=YES;
    if ([delegate respondsToSelector:@selector(guideViewWillRemove)]) {
        [delegate guideViewWillRemove];
    }
    [UIView animateWithDuration:0.3 animations:^{
        self.transform=CGAffineTransformMakeScale(3, 3);
        self.alpha=0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        if ([delegate respondsToSelector:@selector(guideViewDidRemove)]) {
            [delegate guideViewDidRemove];
        }
    }];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
	CGFloat pageWidth = scrollView.frame.size.width;
	int page = floor((scrollView.contentOffset.x-pageWidth/2)/pageWidth)+1;
    [pageControl setCurrentPage:page];
    
    CGPoint offset = bgScrollView.contentOffset;
    CGRect bounds = bgScrollView.frame;
    CGFloat index = offset.x / bounds.size.width;
    
    //不允许退出，不用再检查滑动到了第几页
    if(!self.allowExit)
    {
        return;
    }
    
    if(index >= [self.imageList count]-1+0.05)
    {
        [self performSelector:@selector(guideViewQuit) withObject:self afterDelay:0.05];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
}

@end
