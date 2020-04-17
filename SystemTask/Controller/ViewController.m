//
//  ViewController.m
//  SystemTask
//
//  Created by Nagendra Babu on 16/04/20.
//  Copyright © 2020 Apple. All rights reserved.
//

#import "ViewController.h"
#import "CountryModel.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>{
    
    BOOL searchEnabled;
    NSMutableArray *searchArray;
    UISearchBar *searchBar;

}

/// MARK: - Property outlets

@property (strong,nonatomic) UITableView *table;
@property (strong,nonatomic) UITableView *tableView;


@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    countries = [[NSMutableArray alloc]init];
    [self setupTableView];
    [self setupSearchBar];
    [self getData];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:true];
    [self setupNavigationBar];
}

- (void)setupNavigationBar{
    self.navigationItem.title = @"Countries";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor redColor]}];
}

-(void)setupTableView {
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
}

-(void)setupSearchBar{
    searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    searchBar.placeholder = @" Search...";
    [searchBar sizeToFit];
    searchBar.translucent = false;
    searchBar.backgroundImage = [UIImage imageNamed:@""];
    searchBar.delegate = self;
    self.tableView.tableHeaderView = searchBar;

}


/// MARK: - Laod data from local json file

-(void)getData{
    
    NSError *error;
    NSString *path = [[NSBundle mainBundle] pathForResource:@"cities" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSMutableArray *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    
    for (int i = 0; i<json.count; i++){
        CountryModel *model = [[CountryModel alloc]init];
        [model parseResponse:[json objectAtIndex:i]];
        [countries addObject:model];
    }
    
    NSSortDescriptor *sortByName =
    [[NSSortDescriptor alloc] initWithKey:@"name"
                                ascending:YES
                                 selector:@selector(localizedCaseInsensitiveCompare:)];
    
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortByName];
    NSArray *sortedArray = [countries sortedArrayUsingDescriptors:sortDescriptors];
        
    countries = [sortedArray mutableCopy];
    
    [self.tableView reloadData];

}


/// MARK: - Tableview Delegate and Datasource methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (searchEnabled){
        
        return searchArray.count;
        
    }else{
        
        return countries.count;
        
    }
}
 
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cellIdentifier";
    
    UITableViewCell *cell = [self.table dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        
    }
    CountryModel *countryModel;
    
    if (searchEnabled) {
        countryModel = [searchArray objectAtIndex:indexPath.row];
    }else{
        countryModel = [countries objectAtIndex:indexPath.row];
    }

    NSString *name = [NSString stringWithFormat:@"%@,   %@", countryModel.name.capitalizedString, countryModel.country];
    cell.textLabel.text = name;
    return cell;
}
 
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    CountryModel *countryModel = [countries objectAtIndex:indexPath.row];

    NSLog(@"Country = %@,   Name = %@,  _id = %d",countryModel.country,countryModel.name,countryModel._id);
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 65;
}


/// MARK: - Search functionality


- (void)filterContentForSearchText:(NSString*)searchText
{
    searchArray = [[NSMutableArray alloc] init];
   
        for(CountryModel *countryModel in countries)
        {
            NSString * name;
            name = countryModel.name;
            
            
            NSRange filterName=[[name lowercaseString] rangeOfString:[searchText lowercaseString]];
            
            if(filterName.location != NSNotFound)
                [searchArray addObject:countryModel];
        }
    
    [self.tableView reloadData];
    
    NSLog(@"Dict = %@",searchArray);
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if (searchBar.text.length == 0)
    {
        searchEnabled = NO;
        [self.tableView reloadData];
    }
    else
    {
        searchEnabled = YES;
        [self filterContentForSearchText:searchBar.text];
    }
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
    searchEnabled = YES;
    [self filterContentForSearchText:searchBar.text];
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
    [searchBar setText:@""];
    searchEnabled = NO;
    [self.tableView reloadData];
    
}

@end
