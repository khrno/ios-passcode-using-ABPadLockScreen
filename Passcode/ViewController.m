//
//  ViewController.m
//  Passcode
//
//  Created by Pablo Ortega Mesa on 10-11-15.
//  Copyright © 2015 khrno.cl. All rights reserved.
//

#import "ViewController.h"
#import "ABPadLockScreenView.h"

@interface ViewController ()

@property (nonatomic, strong) NSString *thePin;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.thePin == nil) {
        NSLog(@"thePin is nil");
    }
    else{
        NSLog(@"thePin is set");
    }
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)authButtonTapped:(id)sender {
    
    NSLog(@"button pressed");
    if (self.thePin == nil) {
        NSLog(@"thePin is nil");
        ABPadLockScreenSetupViewController *lockScreen = [[ABPadLockScreenSetupViewController alloc] initWithDelegate:self complexPin:NO];
        
        lockScreen.tapSoundEnabled = YES;
        lockScreen.errorVibrateEnabled = YES;
        lockScreen.modalPresentationStyle = UIModalPresentationFullScreen;
        lockScreen.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        
        [self presentViewController:lockScreen animated:YES completion:nil];
    }
    else{
        NSLog(@"thePin is set");
        if (!self.thePin)
        {
            [[[UIAlertView alloc] initWithTitle:@"No Pin" message:@"Please Set a pin before trying to unlock" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
            return;
        }
        
        ABPadLockScreenViewController *lockScreen = [[ABPadLockScreenViewController alloc] initWithDelegate:self complexPin:NO];
        [lockScreen setAllowedAttempts:3];
        
        lockScreen.tapSoundEnabled = YES;
        lockScreen.errorVibrateEnabled = YES;
        lockScreen.modalPresentationStyle = UIModalPresentationFullScreen;
        lockScreen.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        
        [self presentViewController:lockScreen animated:YES completion:nil];
    }

}
#pragma mark -
#pragma mark - ABLockScreenDelegate Methods
- (BOOL)padLockScreenViewController:(ABPadLockScreenViewController *)padLockScreenViewController validatePin:(NSString *)pin
{
    NSLog(@"Validating pin %@", pin);
    return [self.thePin isEqualToString:pin];
}

- (void) unlockWasSuccessfulForPadLockScreenViewController:(ABPadLockScreenViewController *)padLockScreenViewController
{
    [self dismissViewControllerAnimated:YES completion:nil];
    NSLog(@"Pin entry successfull");
}

- (void)unlockWasUnsuccessful:(NSString *)falsePin afterAttemptNumber:(NSInteger)attemptNumber padLockScreenViewController:(ABPadLockScreenViewController *)padLockScreenViewController
{
    NSLog(@"Failed attemp number %ld with pin %@", (long)attemptNumber,falsePin);
}

- (void)unlockWasCancelledForPadLockScreenViewController:(ABPadLockScreenViewController *)padLockScreenViewController
{
    [self dismissViewControllerAnimated:YES completion:nil];
    NSLog(@"Pin entry cancelled");
}


#pragma mark -
#pragma mark - ABPadLockScreenSetupViewControllerDelegate Methods
- (void)pinSet:(NSString *)pin padLockScreenSetupViewController:(ABPadLockScreenSetupViewController *)padLockScreenViewController
{
    [self dismissViewControllerAnimated:YES completion:nil];
    self.thePin = pin;
    NSLog(@"Pin set to pin %@", self.thePin);
}

@end
