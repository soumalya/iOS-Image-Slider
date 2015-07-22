//
//  ViewController.m
//  ImageSlider
//
//  Created by Soumalya Banerjee on 21/07/15.
//  Copyright (c) 2015 Soumalya Banerjee. All rights reserved.
//

#import "ViewController.h"
#import "SBSliderView.h"

#define _AUTO_SCROLL_ENABLED 1

@interface ViewController () {
    NSMutableArray *imagesArray;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    imagesArray = [[NSMutableArray alloc] initWithObjects:@"Black-Car-HD-Wallpaper.jpg", @"lamborghini_murcielago_superveloce_2-2880x1800.jpg", @"nature-landscape-photography-lanscape-cool-hd-wallpapers-fullscreen-high-resolution.jpg", @"wallpaper-hd-3151.jpg", nil];
    
    SBSliderView *slider = [[[NSBundle mainBundle] loadNibNamed:@"SBSliderView" owner:self options:nil] firstObject];
    [self.view addSubview:slider];
    [slider createSliderWithImages:imagesArray WithAutoScroll:_AUTO_SCROLL_ENABLED inView:self.view];
    slider.frame = CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, 300.0f);
    
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
