//
//  SBSliderView.m
//  ImageSlider
//
//  Created by Soumalya Banerjee on 22/07/15.
//  Copyright (c) 2015 Soumalya Banerjee. All rights reserved.
//

#import "SBSliderView.h"

@implementation SBSliderView {
    NSArray *imagesArray;
    BOOL autoSrcollEnabled;
    
    NSTimer *activeTimer;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

//- (id)initWithFrame:(CGRect)frame
//{
//    self = [super initWithFrame:frame];
//    if (self) {
//        
//    }
//    return self;
//}
//
//- (id)initWithCoder:(NSCoder *)aDecoder {
//    self = [super initWithCoder:aDecoder];
//    if(self) {
//        [self setup];
//    }
//    return self;
//}
//
//- (void)setup {
//    [[NSBundle mainBundle] loadNibNamed:@"SBSliderView" owner:self options:nil];
////    [self addSubview:self.view];
//}

#pragma mark - Create Slider with images

- (void)createSliderWithImages:(NSArray *)images WithAutoScroll:(BOOL)isAutoScrollEnabled inView:(UIView *)parentView {
//    self.backgroundColor = [UIColor blackColor];
    self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    
    imagesArray = [NSArray arrayWithArray:images];
    autoSrcollEnabled = isAutoScrollEnabled;

    _sliderMainScroller.pagingEnabled = YES;
    _sliderMainScroller.delegate = self;
    _pageIndicator.numberOfPages = [imagesArray count];
    _sliderMainScroller.contentSize = CGSizeMake(([UIScreen mainScreen].bounds.size.width * [imagesArray count] * 3), _sliderMainScroller.frame.size.height);
    
    int mainCount = 0;
    for (int x = 0; x < 3; x++) {
        
        for (int i=0; i < [imagesArray count]; i++) {
            
            UIImageView *imageV = [[UIImageView alloc] init];
            CGRect frameRect;
            frameRect.origin.y = 0.0f;
            frameRect.size.width = [UIScreen mainScreen].bounds.size.width;
            frameRect.size.height = _sliderMainScroller.frame.size.height;
            frameRect.origin.x = (frameRect.size.width * mainCount);
            imageV.frame = frameRect;
            imageV.contentMode = UIViewContentModeScaleAspectFill;
            imageV.image = [UIImage imageNamed:(NSString *)[imagesArray objectAtIndex:i]];
            [_sliderMainScroller addSubview:imageV];
            imageV.clipsToBounds = YES;
            imageV.userInteractionEnabled = YES;
            
            UITapGestureRecognizer *tapOnImage = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapOnImage:)];
            tapOnImage.delegate = self;
            tapOnImage.numberOfTapsRequired = 1;
            [imageV addGestureRecognizer:tapOnImage];
            
            mainCount++;
        }
        
    }
    
    CGFloat startX = (CGFloat)[imagesArray count] * [UIScreen mainScreen].bounds.size.width;
    [_sliderMainScroller setContentOffset:CGPointMake(startX, 0) animated:NO];
    
    if (([imagesArray count] > 1) && (isAutoScrollEnabled)) {
        [self startTimerThread];
    }
}

#pragma mark end -


#pragma mark - GestureRecognizer delegate

- (void)tapOnImage:(UITapGestureRecognizer *)gesture {
    
    UIImageView *targetView = (UIImageView *)gesture.view;
    [_delegate sbslider:self didTapOnImage:targetView.image andParentView:targetView];
    
}

#pragma mark end -

#pragma mark - UIScrollView delegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGFloat width = scrollView.frame.size.width;
    NSInteger page = (scrollView.contentOffset.x + (0.5f * width)) / width;
    
    NSInteger moveToPage = page;
    if (moveToPage == 0) {
        
        moveToPage = [imagesArray count];
        CGFloat startX = (CGFloat)moveToPage * [UIScreen mainScreen].bounds.size.width;
        [scrollView setContentOffset:CGPointMake(startX, 0) animated:NO];
        
    } else if (moveToPage == (([imagesArray count] * 3) - 1)) {
        
        moveToPage = [imagesArray count] - 1;
        CGFloat startX = (CGFloat)moveToPage * [UIScreen mainScreen].bounds.size.width;
        [scrollView setContentOffset:CGPointMake(startX, 0) animated:NO];
        
    }
    
    if (moveToPage < [imagesArray count]) {
        _pageIndicator.currentPage = moveToPage;
    } else {
        
        moveToPage = moveToPage % [imagesArray count];
        _pageIndicator.currentPage = moveToPage;
    }
    if (([imagesArray count] > 1) && (autoSrcollEnabled)) {
        [self startTimerThread];
    }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    
    CGFloat width = scrollView.frame.size.width;
    NSInteger page = (scrollView.contentOffset.x + (0.5f * width)) / width;
    
    NSInteger moveToPage = page;
    if (moveToPage == 0) {
        
        moveToPage = [imagesArray count];
        CGFloat startX = (CGFloat)moveToPage * [UIScreen mainScreen].bounds.size.width;
        [scrollView setContentOffset:CGPointMake(startX, 0) animated:NO];
        
    } else if (moveToPage == (([imagesArray count] * 3) - 1)) {
        
        moveToPage = [imagesArray count] - 1;
        CGFloat startX = (CGFloat)moveToPage * [UIScreen mainScreen].bounds.size.width;
        [scrollView setContentOffset:CGPointMake(startX, 0) animated:NO];
        
    }
    
    if (moveToPage < [imagesArray count]) {
        _pageIndicator.currentPage = moveToPage;
    } else {
        
        moveToPage = moveToPage % [imagesArray count];
        _pageIndicator.currentPage = moveToPage;
    }
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
    if (activeTimer) {
        [activeTimer invalidate];
        activeTimer = nil;
    }
}

#pragma mark end -

- (void)slideImage {
    
    CGFloat startX = 0.0f;
    CGFloat width = _sliderMainScroller.frame.size.width;
    NSInteger page = (_sliderMainScroller.contentOffset.x + (0.5f * width)) / width;
    NSInteger nextPage = page + 1;
    startX = (CGFloat)nextPage * width;
    //    [_sliderMainScroller scrollRectToVisible:CGRectMake(startX, 0, width, _sliderMainScroller.frame.size.height) animated:YES];
    [_sliderMainScroller setContentOffset:CGPointMake(startX, 0) animated:YES];
}

-(void)startTimerThread
{
    if (activeTimer) {
        [activeTimer invalidate];
        activeTimer = nil;
    }
    activeTimer = [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(slideImage) userInfo:nil repeats:YES];
}

-(void)startAutoPlay
{
    autoSrcollEnabled = YES;
    if (([imagesArray count] > 1) && (autoSrcollEnabled)) {
        [self startTimerThread];
    }
}

-(void)stopAutoPlay
{
    autoSrcollEnabled = NO;
    if (activeTimer) {
        [activeTimer invalidate];
        activeTimer = nil;
    }
}

@end
