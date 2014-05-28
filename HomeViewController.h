//
//  HomeViewController.h
//  superbowltriviaquiz
//
//  Created by Panasun on 5/23/2557 BE.
//  Copyright (c) 2557 Flutx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeViewController : UIViewController
{
    IBOutlet UIButton *playButton;
    IBOutlet UIButton *getLivesButton;
    IBOutlet UIButton *removeAdsButton;
    IBOutlet UIButton *moreGamesButton;
    IBOutlet UILabel *userScore;
    IBOutlet UILabel *userLives;
}

- (IBAction) playButtonPressed:(id)sender;
- (IBAction) playButtonReleased:(id)sender;
- (IBAction) getLivesButtonPressed:(id)sender;
- (IBAction) getLivesButtonReleased:(id)sender;
- (IBAction) removeAdsButtonPressed:(id)sender;
- (IBAction) removeAdsButtonReleased:(id)sender;
- (IBAction) moreGamesButtonPressed:(id)sender;
- (IBAction) moreGamesButtonReleased:(id)sender;


@end
