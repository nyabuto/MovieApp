//
//  SearchViewController.h
//  MovieApp
//
//  Created by ilabadmin on 7/21/16.
//  Copyright (c) 2016 softikoda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchViewController : UIViewController
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (strong,nonatomic) NSMutableArray *masterFilmList;


@end
