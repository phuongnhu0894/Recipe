//
//  RecipeTableViewCell.m
//  Recipe
//
//  Created by Phuong on 1/8/16.
//  Copyright © 2016 Appcoda. All rights reserved.
//

#import "RecipeTableViewCell.h"

@implementation RecipeTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
