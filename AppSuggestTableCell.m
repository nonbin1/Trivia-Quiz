//
//  AppSuggestTableCell.m
//  superbowltriviaquiz
//
//  Created by Panasun on 5/26/2557 BE.
//  Copyright (c) 2557 Flutx. All rights reserved.
//

#import "AppSuggestTableCell.h"

@implementation AppSuggestTableCell

@synthesize appTitle = _appTitle;
@synthesize appThumbnail = _appThumbnail;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
