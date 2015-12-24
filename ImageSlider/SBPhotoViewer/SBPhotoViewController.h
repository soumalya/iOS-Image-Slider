//
//  SBPhotoViewController.h
//  ImageSlider
//
//  Created by Soumalya Banerjee on 16/12/15.
//  Copyright © 2015 Soumalya Banerjee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SBPhotoViewController : UIViewController

@property (nonatomic) CGRect initialRect;
@property (nonatomic, retain) UIImage *targetImage;
@property (nonatomic, retain) UIImage *backGroundImage;
@property (strong, nonatomic) IBOutlet UIImageView *backGroundImageView;
@property (strong, nonatomic) IBOutlet UIView *maskView;

@end
