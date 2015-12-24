//
//  SBSliderView.h
//  ImageSlider
//
//  Created by Soumalya Banerjee on 22/07/15.
//  Copyright (c) 2015 Soumalya Banerjee. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SBSliderDelegate;

@protocol SBSliderDelegate <NSObject>

@optional
- (void)sbslider:(SBSliderDelegate *)sbslider didTapOnImage:(UIImage *)targetImage andParentView:(UIImageView *)targetView;

@end

@interface SBSliderView : UIView <UIScrollViewDelegate, UIGestureRecognizerDelegate> {
    
    id <SBSliderDelegate>_delegate;
    
}

@property (nonatomic, strong) id <SBSliderDelegate>delegate;
@property (nonatomic, strong) IBOutlet UIScrollView *sliderMainScroller;
@property (weak, nonatomic) IBOutlet UIPageControl *pageIndicator;

- (void)createSliderWithImages:(NSArray *)images WithAutoScroll:(BOOL)isAutoScrollEnabled inView:(UIView *)parentView;

-(void)startAutoPlay;
-(void)stopAutoPlay;

@end
