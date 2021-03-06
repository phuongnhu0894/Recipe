//
//  RecipeTableViewController.m
//  Recipe
//
//  Created by Phuong on 1/14/16.
//  Copyright © 2016 Appcoda. All rights reserved.
//

#import "RecipeTableViewController.h"
#import "RecipeTableViewCell.h"
#import "RecipeDetailViewController.h"
#import "FMDatabase.h"
#import "SearchView.h"
#import "RESideMenu.h"
#import "UIViewController+RESideMenu.h"

@interface RecipeTableViewController ()

@property (strong, nonatomic) UIView *searchView;
@property (strong, nonatomic) NSArray *menu;

@end

@implementation RecipeTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Left"
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:self
                                                                            action:@selector(presentLeftMenuViewController:)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"search"]
                                                                  style:UIBarButtonItemStylePlain
                                                                 target:self
                                                                action:@selector(showSearch:)];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view setBackgroundColor:[UIColor clearColor]];
    self.navigationItem.title = @"Recipe";
    
    UIEdgeInsets inset = UIEdgeInsetsMake(5, 0, 0, 0);
    self.tableView.contentInset = inset;
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.menu = [self getAllData];
    self.searchView = [[[NSBundle mainBundle] loadNibNamed:@"SearchView"
                                                     owner:self
                                                   options:nil] objectAtIndex:0];
    self.searchView.frame = CGRectMake(0, -64, self.view.frame.size.width, 64);
    [[[UIApplication sharedApplication] keyWindow] addSubview:self.searchView];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self hideSearch];
    
    //TODO: hide search bar
}


- (IBAction)showSearch:(id)sender {
    
    [UIView animateWithDuration:0.3 animations:^{
        
        self.searchView.frame = CGRectMake(0, 0, self.view.frame.size.width, 64);
       
    }];
   
}
- (void)hideSearch {
    self.searchView.frame = CGRectMake(0, 0, self.view.frame.size.width, -64);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.menu count];
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

- (UIImage *)cellBackgroundForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger rowCount = [self tableView:[self tableView] numberOfRowsInSection:0];
    NSInteger rowIndex = indexPath.row;
    UIImage *background = nil;
    
    if (rowIndex == 0) {
        background = [UIImage imageNamed:@"cell_top"];
    } else if (rowIndex == rowCount - 1) {
        background = [UIImage imageNamed:@"cell_bottom"];
    } else {
        background = [UIImage imageNamed:@"cell_middle"];
    }
    
    return background;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellIdentifier" forIndexPath:indexPath];
//    NSDictionary *item = [self.menu objectAtIndex:indexPath.row];
//    cell.textLabel.text = [item objectForKey:@"name"];
//    cell.detailTextLabel.text = [item objectForKey:@"time"];
//    cell.imageView.image = [UIImage imageWithContentsOfFile:[item objectForKey:@"image"]];
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
    UIImage *background = [self cellBackgroundForRowAtIndexPath:indexPath];
    
    UIImageView *cellBackgroundView = [[UIImageView alloc] initWithImage:background];
    cellBackgroundView.image = background;
    cell.backgroundView = cellBackgroundView;

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  
    UIStoryboard *storyboardobj = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
      RecipeDetailViewController *recipeDetailViewController = [storyboardobj instantiateViewControllerWithIdentifier:@"RecipeDetailViewController1"];
//    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    NSDictionary *item = [self.menu objectAtIndex:indexPath.row];
    recipeDetailViewController.recipeImage = [item objectForKey:@"image"];
    recipeDetailViewController.recipeTime = [item objectForKey:@"time"];
    recipeDetailViewController.recipeIngredients = [item objectForKey:@"ingredients"];
    recipeDetailViewController.recipeName = [item objectForKey:@"name"];
    [self.navigationController pushViewController:recipeDetailViewController animated:YES];
    
    
    
    
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
