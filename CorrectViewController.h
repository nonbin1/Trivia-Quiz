//
//  CorrectViewController.h
//  superbowltriviaquiz
//
//  Created by Panasun on 5/26/2557 BE.
//  Copyright (c) 2557 Flutx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CorrectViewController : UIViewController
{
    IBOutlet UIButton *nextQuestionButton;
    IBOutlet UILabel *userScoreCorrect;
}

- (IBAction) nextQuesttionButtonClick:(id)sender;

@end
