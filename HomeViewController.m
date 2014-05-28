//
//  HomeViewController.m
//  superbowltriviaquiz
//
//  Created by Panasun on 5/23/2557 BE.
//  Copyright (c) 2557 Flutx. All rights reserved.
//

#import "HomeViewController.h"
#import "TriviaController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

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
    
    TriviaController *trivia = [[TriviaController alloc] init];
    [trivia getStat];
    NSLog(@"Home");
    [trivia getBonusLives];
    
    
    /** Customize Button when Touching **/
    [playButton addTarget:self action:@selector(playButtonPressed:) forControlEvents:UIControlEventTouchDown];
    [playButton addTarget:self action:@selector(playButtonReleased:) forControlEvents:UIControlEventTouchUpInside];
    [getLivesButton addTarget:self action:@selector(getLivesButtonPressed:) forControlEvents:UIControlEventTouchDown];
    [getLivesButton addTarget:self action:@selector(getLivesButtonReleased:) forControlEvents:UIControlEventTouchUpInside];
    [removeAdsButton addTarget:self action:@selector(removeAdsButtonPressed:) forControlEvents:UIControlEventTouchDown];
    [removeAdsButton addTarget:self action:@selector(removeAdsButtonReleased:) forControlEvents:UIControlEventTouchUpInside];
    [moreGamesButton addTarget:self action:@selector(moreGamesButtonPressed:) forControlEvents:UIControlEventTouchDown];
    [moreGamesButton addTarget:self action:@selector(moreGamesButtonReleased:) forControlEvents:UIControlEventTouchUpInside];
    
    //TriviaController *tmp = [[TriviaController alloc] init];
    //[tmp getDatabase];
    //[tmp getStat];
    userScore.text = [NSString stringWithFormat:@"%i", [[[NSUserDefaults standardUserDefaults] objectForKey:@"score"] integerValue]];
    userLives.text = [NSString stringWithFormat:@"%i", [[[NSUserDefaults standardUserDefaults] objectForKey:@"lives"] integerValue] - 1];
    
    //NSLog(@"Score = %@", [tmp getLastQuestion]);
    //NSString *textMsg = [tmp getLastQuestion];
    //[self setNotification:textMsg];

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


/** Customize Button when Touching **/
- (IBAction) playButtonPressed:(id)sender {
    [playButton setImage:[UIImage imageNamed:@"play-02.png"] forState:UIControlStateNormal];
}
- (IBAction) playButtonReleased:(id)sender {
    [playButton setImage:[UIImage imageNamed:@"play-01.png"] forState:UIControlStateNormal];
}
- (IBAction) getLivesButtonPressed:(id)sender {
    [getLivesButton setImage:[UIImage imageNamed:@"life-02.png"] forState:UIControlStateNormal];
}
- (IBAction) getLivesButtonReleased:(id)sender {
    [getLivesButton setImage:[UIImage imageNamed:@"life-01.png"] forState:UIControlStateNormal];
}
- (IBAction) removeAdsButtonPressed:(id)sender {
    [removeAdsButton setImage:[UIImage imageNamed:@"remove-02.png"] forState:UIControlStateNormal];
}
- (IBAction) removeAdsButtonReleased:(id)sender {
    [removeAdsButton setImage:[UIImage imageNamed:@"remove-01.png"] forState:UIControlStateNormal];
}
- (IBAction) moreGamesButtonPressed:(id)sender {
    [moreGamesButton setImage:[UIImage imageNamed:@"moregame-02.png"] forState:UIControlStateNormal];
}
- (IBAction) moreGamesButtonReleased:(id)sender {
    [moreGamesButton setImage:[UIImage imageNamed:@"moregame-01.png"] forState:UIControlStateNormal];
}

/*
- (void) setNotification: (NSString*)textMessage
{
    NSCalendar *gregCalendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *dateComponent = [gregCalendar components:NSYearCalendarUnit  | NSWeekCalendarUnit fromDate:[NSDate date]];
    
    [dateComponent setHour:9];
    [dateComponent setMinute:30];
    
    NSDate *fireDate = [gregCalendar dateFromComponents:dateComponent];
    
    UILocalNotification *notification = [[UILocalNotification alloc]init];
    [notification setAlertBody:textMessage];
    [notification setFireDate:fireDate];
    notification.repeatInterval = NSDayCalendarUnit;
    notification.applicationIconBadgeNumber = 1;
    [notification setTimeZone:[NSTimeZone defaultTimeZone]];
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
}
*/

@end
