//
//  FirstViewController.m
//  ImageSlider
//
//  Created by Soumalya Banerjee on 16/12/15.
//  Copyright © 2015 Soumalya Banerjee. All rights reserved.
//

#import "FirstViewController.h"

#define _AUTO_SCROLL_ENABLED 0

@interface FirstViewController () {
    NSMutableArray *imagesArray;
    SBSliderView *slider;
}

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    imagesArray = [[NSMutableArray alloc] initWithObjects:@"Black-Car-HD-Wallpaper.jpg", @"lamborghini_murcielago_superveloce_2-2880x1800.jpg", @"nature-landscape-photography-lanscape-cool-hd-wallpapers-fullscreen-high-resolution.jpg", @"wallpaper-hd-3151.jpg", nil];
    
    _autoPlayToggle.on = _AUTO_SCROLL_ENABLED;
    
    slider = [[[NSBundle mainBundle] loadNibNamed:@"SBSliderView" owner:self options:nil] firstObject];
    slider.delegate = self;
    [self.view addSubview:slider];
    [slider createSliderWithImages:imagesArray WithAutoScroll:_AUTO_SCROLL_ENABLED inView:self.view];
    slider.frame = CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, 300.0f);
    
}

- (void)sbslider:(SBSliderView *)sbslider didTapOnImage:(UIImage *)targetImage andParentView:(UIImageView *)targetView {
    
    SBPhotoManager *photoViewerManager = [[SBPhotoManager alloc] init];
    [photoViewerManager initializePhotoViewerFromViewControlller:self forTargetImageView:targetView withPosition:sbslider.frame];
}

- (IBAction)toggleAutoPlay:(id)sender {
    
    UISwitch *toggleSwitch = (UISwitch *)sender;
    
    if ([toggleSwitch isOn]) {
        [slider startAutoPlay];
    } else {
        [slider stopAutoPlay];
    }
}

- (IBAction)tappedOnSampleImage:(id)sender {
    
    UIGestureRecognizer *gesture = (UIGestureRecognizer *)sender;
    UIImageView *targetView = (UIImageView *)gesture.view;
    
    SBPhotoManager *photoViewerManager = [[SBPhotoManager alloc] init];
    [photoViewerManager initializePhotoViewerFromViewControlller:self forTargetImageView:targetView withPosition:targetView.frame];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
