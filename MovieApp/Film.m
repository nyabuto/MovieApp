//
//  Film.m
//  MovieApp
//
//  Created by ilabadmin on 7/22/16.
//  Copyright (c) 2016 softikoda. All rights reserved.
//

#import "Film.h"

@implementation Film
@synthesize year=_year;
@synthesize title=_title;
@synthesize type=_type;
@synthesize imdbID=_imdbID;
@synthesize poster=_poster;

-(NSMutableArray *) films{
    if(!_films){
        _films=[[NSMutableArray alloc]init];
        
    }
    return _films;
}


-(instancetype) initWithAttributes: (NSDictionary *) attributes{
    self=[super init];
    if(self){
        self.title=[attributes objectForKey:kTitle];
        self.type=[attributes objectForKey:kType];
        self.poster=[attributes objectForKey:kPoster];
        self.year=[attributes objectForKey:kYear];
        self.imdbID=[attributes objectForKey:kImdbID];
        
    }
    
    return self;
}
@end
