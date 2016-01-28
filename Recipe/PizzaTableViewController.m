//
//  PizzaTableViewController.m
//  Recipe
//
//  Created by Phuong on 1/26/16.
//  Copyright © 2016 Appcoda. All rights reserved.
//

#import "PizzaTableViewController.h"
#import "RecipeTableViewCell.h"
#import "RecipeDetailViewController.h"
#import "FMDatabase.h"
#import "SearchView.h"
#import "RESideMenu.h"
#import "UIViewController+RESideMenu.h"

@interface PizzaTableViewController ()

@property (strong, nonatomic) NSArray *menu;

@end

@implementation PizzaTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.menu = [self getAllData];
    self.view.backgroundColor = [UIColor colorWithRed:255/255.0 green:202/255.0 blue:101/255.0 alpha:1.0];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Left"
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:self
                                                                            action:@selector(presentLeftMenuViewController:)];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (NSArray *)getAllData {
    // Getting the database path.
    NSArray  *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsPath = [paths objectAtIndex:0];
    NSString *dbPath = [docsPath stringByAppendingPathComponent:@"Recipe.sqlite"];
    
    FMDatabase *database = [FMDatabase databaseWithPath:dbPath];
    [database open];
    NSString *sqlSelectQuery = @"SELECT * FROM Food";
    NSMutableArray *menu = [[NSMutableArray alloc] init];
    
    // Query result
    FMResultSet *resultsWithNameLocation = [database executeQuery:sqlSelectQuery];
    while([resultsWithNameLocation next]) {
        
        NSString *strName = [NSString stringWithFormat:@"%@",[resultsWithNameLocation stringForColumn:@"food_name"]];
        NSString *strTime = [NSString stringWithFormat:@"%@",[resultsWithNameLocation stringForColumn:@"food_time"]];
        NSString *strImage = [NSString stringWithFormat:@"%@",[resultsWithNameLocation stringForColumn:@"food_image"]];
        NSString *strIngredients = [NSString stringWithFormat:@"%@",[resultsWithNameLocation stringForColumn:@"food_ingredients"]];
        
        // loading your data into the array, dictionaries.
        //        NSLog(@"Name = %@, Time = %@, Image = %@, Igredients= %@",strName, strTime, strImage, strIngredients);
        NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
        data[@"name"] = strName;
        data[@"time"] = strTime;
        data[@"image"] = strImage;
        data[@"ingredients"] = strIngredients;
        
        [menu addObject:data];
        
    }
    [database close];
    
    return menu;
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [self.menu count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    
    // Configure the cell...
    
    static NSString *CellIdentifier = @"CustomTableCell";
    RecipeTableViewCell *cell = (RecipeTableViewCell *)[self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"RecipeTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    NSDictionary *item = [self.menu objectAtIndex:indexPath.row];
    cell.nameLabel.text = [item objectForKey:@"name"];
    cell.prepTimeLabel.text = [item objectForKey:@"time"];
    cell.thumbnailImageView.image = [UIImage imageWithContentsOfFile:[item objectForKey:@"image"]];
    
    // Assign our own background image for the cell
    //    UIImage *background = [self cellBackgroundForRowAtIndexPath:indexPath];
    //
    //    UIImageView *cellBackgroundView = [[UIImageView alloc] initWithImage:background];
    //    cellBackgroundView.image = background;
    //    cell.backgroundView = cellBackgroundView;
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
