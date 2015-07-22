//
//  ViewController.m
//  ImageSlider
//
//  Created by Soumalya Banerjee on 21/07/15.
//  Copyright (c) 2015 Soumalya Banerjee. All rights reserved.
//

#import "ViewController.h"
#define _AUTO_SCROLL_ENABLED 1

@interface ViewController () {
    NSMutableArray *imagesArray;
    NSTimer *activeTimer;
    
    BOOL _isManual;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    imagesArray = [[NSMutableArray alloc] initWithObjects:@"Black-Car-HD-Wallpaper.jpg", @"lamborghini_murcielago_superveloce_2-2880x1800.jpg", @"nature-landscape-photography-lanscape-cool-hd-wallpapers-fullscreen-high-resolution.jpg", @"wallpaper-hd-3151.jpg", nil];
    
    
    
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    [self createSliderWithImages:imagesArray WithAutoScroll:_AUTO_SCROLL_ENABLED];
}

#pragma mark - Create Slider with images

- (void)createSliderWithImages:(NSArray *)images WithAutoScroll:(BOOL)isAutoScrollEnabled {
    
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
    if (([imagesArray count] > 1) && (_AUTO_SCROLL_ENABLED)) {
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
    
    _isManual = YES;
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
    activeTimer = [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(slideImage) userInfo:nil repeats:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
