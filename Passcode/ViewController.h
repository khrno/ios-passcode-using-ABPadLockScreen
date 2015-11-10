//
//  ViewController.h
//  Passcode
//
//  Created by Pablo Ortega Mesa on 10-11-15.
//  Copyright © 2015 khrno.cl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ABPadLockScreenViewController.h"
#import "ABPadLockScreenSetupViewController.h"

@interface ViewController : UIViewController <ABPadLockScreenViewControllerDelegate, ABPadLockScreenViewControllerDelegate>

- (IBAction)authButtonTapped:(id)sender;

@end

