//
//  ViewController.h
//  ImageSlider
//
//  Created by Soumalya Banerjee on 21/07/15.
//  Copyright (c) 2015 Soumalya Banerjee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UIScrollViewDelegate>

@property (nonatomic, strong) IBOutlet UIScrollView *sliderMainScroller;
@property (weak, nonatomic) IBOutlet UIPageControl *pageIndicator;

@end

