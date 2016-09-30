//
//  DataSource.h
//  MovieApp
//
//  Created by ilabadmin on 7/25/16.
//  Copyright (c) 2016 softikoda. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"
@interface DataSource : NSObject
{
    AppDelegate *delegate;
    NSURLConnection *connection;
    
    
}
@property(nonatomic,retain) AppDelegate *delegate;

-(NSMutableArray *) selectFromJson : (NSString *) title;
+(NSString *) baseAPIUrl;
-(NSString *) getJsonDataString : (NSString *) urlparam;

@end
