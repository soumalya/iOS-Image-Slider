//
//  SBPhotoManager.m
//  ImageSlider
//
//  Created by Soumalya Banerjee on 16/12/15.
//  Copyright © 2015 Soumalya Banerjee. All rights reserved.
//

#import "SBPhotoManager.h"

@implementation SBPhotoManager

- (void)initializePhotoViewerFromViewControlller:(id)fromViewController forTargetImageView:(UIImageView *)targetImageView withPosition:(CGRect)startPosition {
    
    AppDelegate *appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    if ([fromViewController isKindOfClass:[UIViewController class]]) {
        
        UIImage *backgroundImage = nil;
        UIViewController *targetViewController = (UIViewController *)fromViewController;
        
        if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)])
            UIGraphicsBeginImageContextWithOptions(appDel.window.bounds.size, NO, [UIScreen mainScreen].scale);
        else
            UIGraphicsBeginImageContext(appDel.window.bounds.size);
        
        [appDel.window.layer renderInContext:UIGraphicsGetCurrentContext()];
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        NSData * imgData = UIImagePNGRepresentation(image);
        if(imgData)
            backgroundImage = [UIImage imageWithData:imgData];
        else
            NSLog(@"error while taking screenshot");
        
        SBPhotoViewController *photoViewer = [[SBPhotoViewController alloc] initWithNibName:@"SBPhotoViewController" bundle:nil];
        photoViewer.targetImage = targetImageView.image;
        photoViewer.initialRect = startPosition;
        photoViewer.backGroundImage = backgroundImage;
        [targetViewController.navigationController pushViewController:photoViewer animated:NO];
        
    } else {
        
        
        UIAlertView *warningAlert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                               message:@"SBImageViewer must be presented over UIViewController"
                                                              delegate:nil
                                                     cancelButtonTitle:@"Ok"
                                                     otherButtonTitles:nil];
        [warningAlert show];
    }
    
}

@end
