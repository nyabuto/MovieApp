//
//  SearchViewController.m
//  MovieApp
//
//  Created by ilabadmin on 7/21/16.
//  Copyright (c) 2016 softikoda. All rights reserved.
//

#import "SearchViewController.h"
#import "Film.h"
@interface SearchViewController ()

@end

@implementation SearchViewController

-(NSMutableArray *) masterFilmList{
    if(_masterFilmList==nil){
        _masterFilmList=[[NSMutableArray alloc] init];
    }
    return _masterFilmList;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _searchBar.text =@"star wars";
    
    [self fetchData: [@"s=" stringByAppendingString:_searchBar.text]];
    
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

#pragma mark - request data source
-(void)fetchData: (NSString *)parameters{
    
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        DataSource  *service = [[DataSource alloc] init];
        self.masterFilmList = [service selectFromJson:parameters];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            
            [self.myTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
            noResultText = NSLocalizedString(@"No results for:", "No results for:");
            noResultText = [noResultText stringByAppendingString:@" "];
            noResultText = [noResultText stringByAppendingString:self.searchBar.text];
            
            [self.myTableView reloadData];
            
        });
        
    });
    
}

- (void)downloadImageWithURL:(NSURL *)url completionBlock:(void (^)(BOOL succeeded, UIImage *image))completionBlock
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               
                               if ( !error ){
                                   UIImage *image = [[UIImage alloc] initWithData:data];
                                   completionBlock(YES,image);
                               } else{
                                   completionBlock(NO,nil);
                               }
                           }];
}



#pragma mark - Table view data source
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    // Return the number of sections.
//    return 1;
//}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if ([self.masterFilmList count] == 0) {
        return 1; // a single cell to report no data
    }
    return [self.masterFilmList count];
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"TableItem";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    
    Film *film = ((Film *) _masterFilmList[indexPath.row]);
    
    cell.textLabel.text = film.title;
    [cell.detailTextLabel setText:[[[film.type stringByAppendingString:@" ("] stringByAppendingString:film.year] stringByAppendingString:@")"]];
    
    cell.imageView.image = [UIImage imageNamed:@"newapp-icon"];
    
    // download the image asynchronously
    if (![film.poster  isEqual: @"N/A"]) {
        [self downloadImageWithURL:[NSURL URLWithString:film.poster] completionBlock:^(BOOL succeeded, UIImage *image) {
            if (succeeded) {
                // change the image in the cell
                cell.imageView.image = image;
                
            }
        }];
    }
    
    return cell;
    
}


@end
