//
//  CanvasViewController.m
//  Canvas
//
//  Created by Devin Bhushan on 9/17/15.
//  Copyright © 2015 Yahoo. All rights reserved.
//

#import "CanvasViewController.h"

@interface CanvasViewController ()

@property(strong, nonatomic) IBOutlet UIView *trayView;
@property CGPoint trayOriginalCenter;
@property(assign, nonatomic) CGPoint upPosition;
@property(assign, nonatomic) CGPoint downPosition;

@end

@implementation CanvasViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  self.upPosition = self.trayView.center;
  self.downPosition = CGPointMake(
      self.trayView.center.x,
      (self.trayView.center.y + (self.trayView.bounds.size.height - 30)));
}

- (IBAction)onCustomPan:(id)sender {
  UIPanGestureRecognizer *gesture = (UIPanGestureRecognizer *)sender;

  switch (gesture.state) {
  case UIGestureRecognizerStateBegan: {
    self.trayOriginalCenter = self.trayView.center;
    break;
  }
  case UIGestureRecognizerStateChanged: {
    CGPoint translatedPoint =
        [(UIPanGestureRecognizer *)sender translationInView:self.trayView];

    self.trayView.center =
        CGPointMake(self.trayOriginalCenter.x,
                    self.trayOriginalCenter.y + translatedPoint.y);
    break;
  }
  case UIGestureRecognizerStateEnded: {
    CGPoint velocity = [sender velocityInView:self.trayView];
    if (velocity.y < 0) {
      [UIView animateWithDuration:0.25
                       animations:^{
                         self.trayView.center = self.upPosition;
                       }];
      NSLog(@"Go up!");
    } else {
      [UIView animateWithDuration:0.5
                       animations:^{
                         self.trayView.center = self.downPosition;
                       }];
      NSLog(@"Go down!");
    }
    break;
  }
  default:
    NSLog(@"Unhandled case");
  }
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little
preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
