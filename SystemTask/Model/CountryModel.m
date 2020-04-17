//
//  CountryModel.m
//  SystemTask
//
//  Created by Nagendra Babu on 17/04/20.
//  Copyright © 2020 Apple. All rights reserved.
//

#import "CountryModel.h"

@implementation CountryModel

@synthesize _id;
@synthesize name;
@synthesize country;

- (int)parseResponse:(NSDictionary *)receivedObjects
{
    _id = [receivedObjects objectForKey:@"_id"];
    name = [receivedObjects objectForKey:@"name"];
    country = [receivedObjects objectForKey:@"country"];
    return 0;
}
@end
