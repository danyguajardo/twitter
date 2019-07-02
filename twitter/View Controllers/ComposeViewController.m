//
//  ComposeViewController.m
//  twitter
//
//  Created by danyguajiba on 7/2/19.
//  Copyright © 2019 Emerson Malca. All rights reserved.
//

#import "ComposeViewController.h"
#import "APIManager.h"


@interface ComposeViewController ()
@property (weak, nonatomic) IBOutlet UITextView *tweetView;

@end

@implementation ComposeViewController

//- (IBAction)tweetAction:(id)sender {
//    [[APIManager shared] postStatusWithText:(self.tweetView.text) completion:^(Tweet * tweets, NSError * error) {
//        if (tweets)
//            [self dismissViewControllerAnimated:true completion:nil];
//    }];
//}
- (IBAction)closeComposerAction:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)didTap:(id)sender {
    [[APIManager shared]postStatusWithText:@"This is my tweet 😀" completion:^(Tweet *tweet, NSError *error) {
        if(error){
            NSLog(@"Error composing Tweet: %@", error.localizedDescription);
        }
        else{
            [self.delegate didTweet:tweet];
            NSLog(@"Compose Tweet Success!");
        }
    }];
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
