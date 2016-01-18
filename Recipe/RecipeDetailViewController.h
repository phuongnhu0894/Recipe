//
//  RecipeDetailViewController.h
//  Recipe
//
//  Created by Phuong on 1/15/16.
//  Copyright © 2016 Appcoda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecipeDetailViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *recipeImageView;
@property (weak, nonatomic) IBOutlet UILabel *prepTimeLabel;
@property (weak, nonatomic) IBOutlet UITextView *ingredientsTextView;
@property (weak, nonatomic) NSString *recipeName;
@property (weak, nonatomic) NSString *recipeTime;
@property (weak, nonatomic) NSString *recipeIngredients;
@property (weak, nonatomic) NSString *recipeImage;


@end
