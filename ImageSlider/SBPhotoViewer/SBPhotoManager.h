//
//  SBPhotoManager.h
//  ImageSlider
//
//  Created by Soumalya Banerjee on 16/12/15.
//  Copyright © 2015 Soumalya Banerjee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "SBPhotoViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "AppDelegate.h"

@interface SBPhotoManager : NSObject


- (void)initializePhotoViewerFromViewControlller:(id)fromViewController forTargetImageView:(UIImageView *)targetImageView withPosition:(CGRect)startPosition;

@end
