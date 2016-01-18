//
//  RecipeDetailViewController.m
//  Recipe
//
//  Created by Phuong on 1/15/16.
//  Copyright © 2016 Appcoda. All rights reserved.
//

#import "RecipeDetailViewController.h"

@interface RecipeDetailViewController ()

@end

@implementation RecipeDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor clearColor]];
    
    self.navigationItem.title = self.recipeName;
    self.prepTimeLabel.text = self.recipeTime;
    self.recipeImageView.image = [UIImage imageWithContentsOfFile:self.recipeImage];
    self.ingredientsTextView.text = self.recipeIngredients;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
