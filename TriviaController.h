//
//  TriviaController.h
//  SimpleTrivia
//
//  Created by Panasun on 5/20/2557 BE.
//  Copyright (c) 2557 Flutx. All rights reserved.
//


#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>



@interface TriviaController : UIViewController
{
    
    IBOutlet UILabel *userScore;
    IBOutlet UILabel *userLives;
    IBOutlet UILabel *quizQuestion;
    IBOutlet UILabel *userSkip;
    IBOutlet UIButton *answer1;
    IBOutlet UIButton *answer2;
    IBOutlet UIButton *answer3;
    IBOutlet UIButton *answer4;
    IBOutlet UILabel *answer1Label;
    IBOutlet UILabel *answer2Label;
    IBOutlet UILabel *answer3Label;
    IBOutlet UILabel *answer4Label;
    
    IBOutlet UIView *nextQuestionView;
    IBOutlet UIImageView *nextQuestionIcon;
    IBOutlet UILabel *nextQuestionBg;
    IBOutlet UIView *livesOver;
    
    
    NSMutableArray *quizArray;
    
    NSString *answerCorrect;
    NSString *answerUser;
    NSString *plistPathDatabase;
    
    int quizid;
    int score;
    int lives;
    int skip;
    int lastOpenTime;
    
    SystemSoundID playSoundID;
    
}


@property(readwrite,nonatomic) int quizid, score, lives;
@property NSString *answerCorrect, *answerUser;
@property(retain, nonatomic) NSMutableArray *quizArray;

- (void) getNextQuestion;
- (void) checkAnswer;
- (void) getStat;
- (void) getDatabase;
- (void) getBonusLives;
- (NSString*) getLastQuestion;
- (NSString*) getRandomQuestion;

- (IBAction) answer1:(id) sender;
- (IBAction) answer2:(id) sender;
- (IBAction) answer3:(id) sender;
- (IBAction) answer4:(id) sender;
- (IBAction) nextQuestion:(id) sender;
- (IBAction) skipQuestion:(id) sender;
- (IBAction) postToTwitter:(id) sender;
- (IBAction) postToFacebook:(id) sender;

@end
