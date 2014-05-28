//
//  LivesOutViewController.m
//  superbowltriviaquiz
//
//  Created by Panasun on 5/26/2557 BE.
//  Copyright (c) 2557 Flutx. All rights reserved.
//

#import "LivesOutViewController.h"
#import "TriviaController.h"

@interface LivesOutViewController ()

@end

@implementation LivesOutViewController

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
    // Do any additional setup after loading the view.
    
    userScoreCorrect.text = [NSString stringWithFormat:@"%i", [[[NSUserDefaults standardUserDefaults] objectForKey:@"score"] integerValue]];
    
    [getLivesButton addTarget:self action:@selector(getLivesButtonPressed:) forControlEvents:UIControlEventTouchDown];
    [getLivesButton addTarget:self action:@selector(getLivesButtonReleased:) forControlEvents:UIControlEventTouchUpInside];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction) getLivesButtonPressed:(id)sender {
    [getLivesButton setImage:[UIImage imageNamed:@"get life-02.png"] forState:UIControlStateNormal];
}
- (IBAction) getLivesButtonReleased:(id)sender {
    [getLivesButton setImage:[UIImage imageNamed:@"get life-01.png"] forState:UIControlStateNormal];
}

@end
