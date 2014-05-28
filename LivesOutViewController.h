//
//  LivesOutViewController.h
//  superbowltriviaquiz
//
//  Created by Panasun on 5/26/2557 BE.
//  Copyright (c) 2557 Flutx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LivesOutViewController : UIViewController
{
    
    IBOutlet UIButton *buyLivesButton;
    IBOutlet UIButton *cancelButton;
    IBOutlet UILabel *userScoreCorrect;
    IBOutlet UIButton *getLivesButton;
}

- (IBAction) getLivesButtonPressed:(id)sender;
- (IBAction) getLivesButtonReleased:(id)sender;

@end
