//
//  SBSliderView.h
//  ImageSlider
//
//  Created by Soumalya Banerjee on 22/07/15.
//  Copyright (c) 2015 Soumalya Banerjee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SBSliderView : UIView <UIScrollViewDelegate>

@property (nonatomic, strong) IBOutlet UIScrollView *sliderMainScroller;
@property (weak, nonatomic) IBOutlet UIPageControl *pageIndicator;
@property (nonatomic, strong) IBOutlet SBSliderView *view;

- (void)createSliderWithImages:(NSArray *)images WithAutoScroll:(BOOL)isAutoScrollEnabled inView:(UIView *)parentView;

@end
