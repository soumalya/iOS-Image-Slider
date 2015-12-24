//
//  SBPhotoViewController.m
//  ImageSlider
//
//  Created by Soumalya Banerjee on 16/12/15.
//  Copyright © 2015 Soumalya Banerjee. All rights reserved.
//

#import "SBPhotoViewController.h"

static const CGFloat kMinBlackMaskAlpha = 0.1f;

@interface SBPhotoViewController () {
    UIImageView *mainImageView;
    CGRect _finalRect;
}

@end

@implementation SBPhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    

    [self setupBackGround];
    [self setUpImageViewer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupBackGround {
    
    _backGroundImageView.image = _backGroundImage;
    _backGroundImageView.contentMode = UIViewContentModeScaleAspectFill;
    _backGroundImageView.clipsToBounds = YES;
}

- (void)setUpImageViewer {
    
    mainImageView = [[UIImageView alloc] initWithFrame:_initialRect];
    mainImageView.contentMode = UIViewContentModeScaleAspectFill;
    mainImageView.image = _targetImage;
    mainImageView.clipsToBounds = YES;
    [self.view addSubview:mainImageView];
    
    __block CGRect mainImageViewFrame = [self getFullSizeFrameWithView:mainImageView];
    __block CGFloat targetY = ((mainImageView.superview.frame.size.height - mainImageViewFrame.size.height) / 2.0f);
    
    [UIView animateWithDuration:0.5f animations:^(void){
        
        _maskView.alpha = 1.0f;
        mainImageViewFrame.origin.x = 0.0f;
        mainImageViewFrame.origin.y = targetY;
        mainImageView.frame = mainImageViewFrame;
    
    } completion:^(BOOL finished){
        [self setupGesture];
        _finalRect = mainImageViewFrame;
    }];
}

- (CGRect)getFullSizeFrameWithView:(UIImageView *)targetImageView {
    
    UIImage *tempImage = targetImageView.image;
    CGSize imageFrame = tempImage.size;
    
    CGRect finalFullFrame = targetImageView.frame;
    
    if (imageFrame.width > imageFrame.height) {
        
        finalFullFrame.size.width = [UIScreen mainScreen].bounds.size.width;
        CGFloat multiplier = imageFrame.width / imageFrame.height;
        finalFullFrame.size.height = finalFullFrame.size.width / multiplier;
        
    } else if (imageFrame.height > imageFrame.width) {
        
        finalFullFrame.size.height = [UIScreen mainScreen].bounds.size.width;
        CGFloat multiplier = imageFrame.width / imageFrame.height;
        finalFullFrame.size.height = finalFullFrame.size.width / multiplier;
        
    } else {
        
        finalFullFrame.size.height = [UIScreen mainScreen].bounds.size.width;
        finalFullFrame.size.height = [UIScreen mainScreen].bounds.size.width;
    }
    
    return finalFullFrame;
}

- (void)setupGesture {
    
    mainImageView.userInteractionEnabled = YES;
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewDidPan:)];
    panGesture.minimumNumberOfTouches = 1;
    panGesture.maximumNumberOfTouches = 1;
    
    [mainImageView addGestureRecognizer:panGesture];
}

- (void)imageViewDidPan:(UIPanGestureRecognizer *)recognizer {
    
    CGPoint translation = [recognizer translationInView:self.view];
    CGRect recognizerFrame = recognizer.view.frame;
    recognizerFrame.origin.x += translation.x;
    recognizerFrame.origin.y += translation.y;
    
    CGFloat displacement = fabs((recognizerFrame.origin.y + mainImageView.frame.size.height/2) - [UIScreen mainScreen].bounds.size.height/2);

    _maskView.alpha = MAX(1 - displacement/([UIScreen mainScreen].bounds.size.height/0.9),kMinBlackMaskAlpha);
    
    recognizer.view.frame = recognizerFrame;
    
    if ([recognizer state] == UIGestureRecognizerStateEnded) {
        [self animationDidFinish:recognizerFrame.origin];
    }
    
    // Reset translation so that on next pan recognition
    // we get correct translation value
    [recognizer setTranslation:CGPointMake(0, 0) inView:self.view];
}

- (void)animationDidFinish:(CGPoint)endRect {
    
    CGFloat displacement = _finalRect.origin.y - endRect.y;
    
    if (displacement < 0) {
        displacement = -(displacement);
    }
    
    if (displacement <= 60.0f) {
        
        [UIView animateWithDuration:0.3f animations:^(void){
            
            mainImageView.frame = _finalRect;
            _maskView.alpha = 1.0f;
            
        } completion:nil];
        
    } else {
        [UIView animateWithDuration:0.3f animations:^(void){
            
            mainImageView.frame = _initialRect;
            
        } completion:^(BOOL finished){
            [self.navigationController popViewControllerAnimated:NO];
        }];
    }
    
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
