//
//  RecipeTableViewController.m
//  Recipe
//
//  Created by Phuong on 1/8/16.
//  Copyright © 2016 Appcoda. All rights reserved.
//

#import "RecipeTableViewController.h"
#import "DBManager.h"

@interface RecipeTableViewController ()

@property (nonatomic, strong) DBManager *dbManager;

@property (nonatomic, strong) NSArray *arrRecipe;

@end

@implementation RecipeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tblRecipe.delegate = self;
    self.tblRecipe.dataSource = self;
    
    // Initialize the dbManager property.
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"Recipe.sqlite"];
    
    // Load the data.
    [self loadData];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadData{
    // Form the query.
    NSString *query = @"select * from Food";
    
    // Get the results.
    if (self.arrRecipe != nil) {
        self.arrRecipe = nil;
    }
    self.arrRecipe = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    
    // Reload the table view.
    [self.tblRecipe reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrRecipe.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CustomTableCell" forIndexPath:indexPath];
    
    NSInteger indexOfFood = [self.dbManager.arrColumnNames indexOfObject:@"food_name"];
    NSInteger indexOfTime = [self.dbManager.arrColumnNames indexOfObject:@"prep_time"];
    NSInteger indexOfImage = [self.dbManager.arrColumnNames indexOfObject:@"image"];
    NSInteger indexOfIngredient = [self.dbManager.arrColumnNames indexOfObject:@"ingredients"];
    
    // Set the loaded data to the appropriate cell labels.
//    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", [[self.arrRecipe objectAtIndex:indexPath.row] objectAtIndex:indexOfFood], [[self.arrRecipe objectAtIndex:indexPath.row] objectAtIndex:indexOfTime]];
//    
//    cell.detailTextLabel.text = [NSString stringWithFormat:@"Age: %@", [[self.arrRecipe objectAtIndex:indexPath.row] objectAtIndex:indexOfAge]];
//    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60.0;
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
