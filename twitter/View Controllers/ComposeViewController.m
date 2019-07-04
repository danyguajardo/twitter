//
//  ComposeViewController.m
//  twitter
//
//  Created by danyguajiba on 7/2/19.
//  Copyright © 2019 Emerson Malca. All rights reserved.
//

#import "ComposeViewController.h"
#import "APIManager.h"


@interface ComposeViewController () <UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextView *tweetView;
@property (weak, nonatomic) IBOutlet UILabel *characterCount;
@property (weak, nonatomic) IBOutlet UITextView *tweetText;
@end

@implementation ComposeViewController

- (IBAction)closeComposerAction:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.tweetView.delegate = self;

    // Do any additional setup after loading the view.
}
- (IBAction)didTap:(id)sender {
    NSString *tweetTextBox = self.tweetText.text;
    
    [[APIManager shared]postStatusWithText:tweetTextBox completion:^(Tweet *tweet, NSError *error) {
        if(error){
            NSLog(@"Error composing Tweet: %@", error.localizedDescription);
        }
        else{
            [self.delegate didTweet:tweet];
            NSLog(@"Compose Tweet Success!");
        }
        [self dismissViewControllerAnimated:true completion:nil];
        
    }];
     
     }

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    // TODO: Check the proposed new text character count
    // Allow or disallow the new text
    
    // Set the max character limit
    int characterLimit = 140;
    
    // Construct what the new text would be if we allowed the user's latest edit
    NSString *newText = [self.tweetText.text stringByReplacingCharactersInRange:range withString:text];
    
    // TODO: Update Character Count Label
    self.characterCount.text = [NSString stringWithFormat:@"%lu", newText.length];
    
    
    // The new text should be allowed? True/False
    return newText.length < characterLimit;
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
