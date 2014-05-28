//
//  CorrectViewController.m
//  superbowltriviaquiz
//
//  Created by Panasun on 5/26/2557 BE.
//  Copyright (c) 2557 Flutx. All rights reserved.
//

#import "CorrectViewController.h"
#import "TriviaController.h"

@interface CorrectViewController ()

@end

@implementation CorrectViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    userScoreCorrect.text = [NSString stringWithFormat:@"%i", [[[NSUserDefaults standardUserDefaults] objectForKey:@"score"] integerValue]];
}


- (IBAction) nextQuesttionButtonClick:(id)sender {
    
    TriviaController *tmp = [[TriviaController alloc] init];
    [tmp getNextQuestion];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    CorrectViewController *viewController = (CorrectViewController *)[storyboard instantiateViewControllerWithIdentifier:@"TriviaView"];
    [self presentViewController:viewController animated:NO completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
