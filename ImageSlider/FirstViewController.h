//
//  FirstViewController.h
//  ImageSlider
//
//  Created by Soumalya Banerjee on 16/12/15.
//  Copyright © 2015 Soumalya Banerjee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SBSliderView.h"
#import "SBPhotoViewer/SBPhotoManager.h"

@interface FirstViewController : UIViewController<SBSliderDelegate>

@property (strong, nonatomic) IBOutlet UISwitch *autoPlayToggle;
@property (strong, nonatomic) IBOutlet UIImageView *sampleImageView;

- (IBAction)toggleAutoPlay:(id)sender;
- (IBAction)tappedOnSampleImage:(id)sender;

@end
