//
//  TriviaController.m
//  SimpleTrivia
//
//  Created by Panasun on 5/20/2557 BE.
//  Copyright (c) 2557 Flutx. All rights reserved.
//

#import "TriviaController.h"
#import "CorrectViewController.h"
#import "LivesOutViewController.h"
#import <Social/Social.h>


#define MAXQuizQuestion 295
#define WaitMinuteForBonus 1
#define LivesIncreaseBonus 3

@interface TriviaController ()

@end


@implementation TriviaController

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
    
    /** Load Stats **/
    [self getDatabase];
    [self getStat];
    [self getBonusLives];
    [self getNextQuestion];
    [self setNotificationDaily:[self getRandomQuestion]];
    
}




- (void) getNextQuestion
{
    NSLog(@"get Next Question");
 
    
    //Reset Question
    if(quizid >= MAXQuizQuestion) quizid = 0;
    
    //NSLog(@"Print ABC: %i", [lives intValue]);
    //NSLog(@"Array : %@", [quizArray[0] objectForKey:@"quiz"]);
   
    
    userScore.text = [NSString stringWithFormat:@"%i", score];
    userLives.text = [NSString stringWithFormat:@"%i", lives-1];
    userSkip.text = [NSString stringWithFormat:@"%i", skip-1];
    
    quizQuestion.text = [NSString stringWithFormat:@"%@",[quizArray[quizid] objectForKey:@"quiz"]];
    //quizQuestion.numberOfLines = 0;
    //[quizQuestion sizeToFit];
    
    /*
    [answer1 setTitle:[quizArray[quizid] objectForKey:@"answer1"] forState:UIControlStateNormal];
    [answer2 setTitle:[quizArray[quizid] objectForKey:@"answer2"] forState:UIControlStateNormal];
    [answer3 setTitle:[quizArray[quizid] objectForKey:@"answer3"] forState:UIControlStateNormal];
    [answer4 setTitle:[quizArray[quizid] objectForKey:@"answer4"] forState:UIControlStateNormal];
    
    answer1.titleLabel.numberOfLines = 0;
    answer2.titleLabel.numberOfLines = 0;
    answer3.titleLabel.numberOfLines = 0;
    answer4.titleLabel.numberOfLines = 0;
    */
    answer1Label.text = [NSString stringWithFormat:@"%@",[quizArray[quizid] objectForKey:@"answer1"]];
    answer2Label.text = [NSString stringWithFormat:@"%@",[quizArray[quizid] objectForKey:@"answer2"]];
    answer3Label.text = [NSString stringWithFormat:@"%@",[quizArray[quizid] objectForKey:@"answer3"]];
    answer4Label.text = [NSString stringWithFormat:@"%@",[quizArray[quizid] objectForKey:@"answer4"]];

    
    answerCorrect = [NSString stringWithFormat:@"%@",[quizArray[quizid] objectForKey:@"correct"]];
    //NSLog(@"JAS: %@", answerCorrect);
    
}

- (void) checkAnswer
{
    NSURL *soundURL;
    
    if( lives <= 1 ) {
        lives = 1;
        //Load Lives Out View
        NSLog(@"Lives Out!!!!");
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        LivesOutViewController *viewController = (LivesOutViewController *)[storyboard instantiateViewControllerWithIdentifier:@"LivesOutView"];
        [self presentViewController:viewController animated:YES completion:nil];
        
        soundURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"out_of_energy" ofType:@"mp3"]];
        
    } else if([answerUser isEqualToString:answerCorrect]) {
        NSLog(@"TRUE");
        quizid = quizid + 1;
        score = score + 1;
        
        
        [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInt:score] forKey:@"score"];
        [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInt:lives] forKey:@"lives"];
        [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInt:quizid] forKey:@"quizid"];
        
        //Load Correct Answer View
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        CorrectViewController *viewController = (CorrectViewController *)[storyboard instantiateViewControllerWithIdentifier:@"CorrectView"];
        [self presentViewController:viewController animated:YES completion:nil];
        
        soundURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"true-answer" ofType:@"wav"]];
        
        //[self getNextQuestion];
    } else {
        NSLog(@"FALSE");
        lives = lives - 1;
        
        [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInt:score] forKey:@"score"];
        [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInt:lives] forKey:@"lives"];
        [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInt:quizid] forKey:@"quizid"];
        
        soundURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"false-answer" ofType:@"mp3"]];
        
        if(lives <= 2) {
            //Time Stamp
            NSDate *localDate = [NSDate date];
            NSTimeInterval thisTime = [localDate timeIntervalSince1970];
            [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInt:(int)thisTime] forKey:@"lastopentime"];
            
            [self setNotification];
        }
        
    }
    
    
    
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)soundURL, &playSoundID);
    AudioServicesPlaySystemSound(playSoundID);
    
    
    userScore.text = [NSString stringWithFormat:@"%i", score];
    userLives.text = [NSString stringWithFormat:@"%i", lives-1];
    
    
}

- (void) getDatabase
{
    /** Load Database **/
    NSString *errorDesc = nil;
    NSPropertyListFormat format;
    NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                              NSUserDomainMask, YES) objectAtIndex:0];
    plistPathDatabase = [rootPath stringByAppendingPathComponent:@"Database.plist"];
    if (![[NSFileManager defaultManager] fileExistsAtPath:plistPathDatabase]) {
        plistPathDatabase = [[NSBundle mainBundle] pathForResource:@"Database" ofType:@"plist"];
    }
    
    
    
    NSData *plistXMLDatabase = [[NSFileManager defaultManager] contentsAtPath:plistPathDatabase];
    NSDictionary *tempDatabase = (NSDictionary *)[NSPropertyListSerialization
                                                  propertyListFromData:plistXMLDatabase
                                                  mutabilityOption:NSPropertyListMutableContainersAndLeaves
                                                  format:&format
                                                  errorDescription:&errorDesc];
    
    if (!tempDatabase) {
        NSLog(@"Error reading plist: %@, format: %d, %@", errorDesc, format, tempDatabase);
    }
    
    
    
    /** Load Database **/
    quizArray = [NSMutableArray arrayWithArray:[tempDatabase objectForKey:@"quizdb"]];
    //NSLog(@"Database: %@", quizArray);

}

- (void) getStat
{
    NSLog(@"Get Stat!");
    if([[[NSUserDefaults standardUserDefaults] objectForKey:@"lives"] integerValue] != nil) {
        lives = [[[NSUserDefaults standardUserDefaults] objectForKey:@"lives"] integerValue];
    } else {
        lives = 11;
        [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInt:lives] forKey:@"lives"];
    }
    
    if([[[NSUserDefaults standardUserDefaults] objectForKey:@"score"] integerValue] != nil) {
        score = [[[NSUserDefaults standardUserDefaults] objectForKey:@"score"] integerValue];
    } else {
        score = 0;
    }
    
    if([[[NSUserDefaults standardUserDefaults] objectForKey:@"quizid"] integerValue] !=nil) {
        quizid = [[[NSUserDefaults standardUserDefaults] objectForKey:@"quizid"] integerValue];
    } else {
        quizid = 0;
    }
    
    if([[[NSUserDefaults standardUserDefaults] objectForKey:@"skip"] integerValue] != nil) {
        skip = [[[NSUserDefaults standardUserDefaults] objectForKey:@"skip"] integerValue];
    } else {
        skip = 4;
        [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInt:skip] forKey:@"skipxco"];
    }
    
   
}

- (void) getBonusLives
{
    /** Bonus Lives **/
    if([[[NSUserDefaults standardUserDefaults] objectForKey:@"lastopentime"] integerValue] !=nil) {
        lastOpenTime = [[[NSUserDefaults standardUserDefaults] objectForKey:@"lastopentime"] integerValue];
    } else {
        lastOpenTime = 0;
    }
    
    NSDate *localDate = [NSDate date];
    NSTimeInterval thisTime = [localDate timeIntervalSince1970];
    NSLog(@"Time Diff: %i", (int)thisTime - lastOpenTime);
    
    if((int)thisTime - lastOpenTime >= WaitMinuteForBonus*60 && lives <= 2) {
        lives += LivesIncreaseBonus;
        [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInt:lives] forKey:@"lives"];
        [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInt:(int)thisTime] forKey:@"lastopentime"];
    }
    
    
    NSLog(@"T1970: %i", lastOpenTime);
    NSLog(@"%i", (int)thisTime);
}

- (IBAction) answer1:(id) sender
{
    answerUser = [NSString stringWithFormat:@"%@",[quizArray[quizid] objectForKey:@"answer1"]];
    [self checkAnswer];
}

- (IBAction) answer2:(id) sender
{
    answerUser = [NSString stringWithFormat:@"%@",[quizArray[quizid] objectForKey:@"answer2"]];
    [self checkAnswer];
}

- (IBAction) answer3:(id) sender
{
    answerUser = [NSString stringWithFormat:@"%@",[quizArray[quizid] objectForKey:@"answer3"]];
    [self checkAnswer];
}

- (IBAction) answer4:(id) sender
{
    answerUser = [NSString stringWithFormat:@"%@",[quizArray[quizid] objectForKey:@"answer4"]];
    [self checkAnswer];
}

- (IBAction) nextQuestion:(id)sender
{
    [self getNextQuestion];
}

- (IBAction) skipQuestion:(id)sender
{
    if(skip > 1) {
        skip = skip - 1;
        quizid = quizid + 1;
    
        [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInt:quizid] forKey:@"quizid"];
        [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInt:skip] forKey:@"skip"];
        NSLog(@"skip = %i", skip);
    
        [self getNextQuestion];
    } else {
        skip = 1;
        [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInt:skip] forKey:@"skip"];
        
        //Load InApp Store View
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        CorrectViewController *viewController = (CorrectViewController *)[storyboard instantiateViewControllerWithIdentifier:@"InAppStore"];
        [self presentViewController:viewController animated:YES completion:nil];
    }
}

- (NSString*) getLastQuestion
{
    return[quizArray[quizid] objectForKey:@"quiz"];
}

- (NSString*) getRandomQuestion
{
    int idx = arc4random()%MAXQuizQuestion;
    return[quizArray[idx] objectForKey:@"quiz"];
}

- (IBAction)postToFacebook:(id)sender {
    if([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
        SLComposeViewController *controller = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        
        [controller setInitialText:[self getLastQuestion]];
        [self presentViewController:controller animated:YES completion:Nil];
    }
}

- (IBAction)postToTwitter:(id)sender {
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
    {
        SLComposeViewController *tweetSheet = [SLComposeViewController
                                               composeViewControllerForServiceType:SLServiceTypeTwitter];
        [tweetSheet setInitialText:@"Great fun to learn iOS programming at appcoda.com!"];
        [self presentViewController:tweetSheet animated:YES completion:nil];
    }
}

- (void) setNotification
{
    NSLog(@"Prepare for send Notification in %i minutes", WaitMinuteForBonus);
    UILocalNotification *localNotif = [[UILocalNotification alloc] init];
    if (localNotif == nil) return;
    NSDate *fireTime = [[NSDate date] dateByAddingTimeInterval:(WaitMinuteForBonus)]; // adds 10 secs
    localNotif.fireDate = fireTime;
    localNotif.alertBody = @"You get free 3 Lives !";
    localNotif.alertAction = @"Play it Now!";
    localNotif.timeZone = [NSTimeZone defaultTimeZone];
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotif];

    
}


- (void) setNotificationDaily: (NSString*)textMessage
{
    NSCalendar *gregCalendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *dateComponent = [gregCalendar components:NSYearCalendarUnit  | NSWeekCalendarUnit fromDate:[NSDate date]];
    
    [dateComponent setHour:9];
    [dateComponent setMinute:35];
    
    NSDate *fireDate = [gregCalendar dateFromComponents:dateComponent];
    
    UILocalNotification *notification = [[UILocalNotification alloc]init];
    [notification setAlertBody:textMessage];
    [notification setFireDate:fireDate];
    notification.repeatInterval = NSDayCalendarUnit;
    notification.applicationIconBadgeNumber = 1;
    [notification setTimeZone:[NSTimeZone defaultTimeZone]];
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end

