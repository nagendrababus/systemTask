//
//  CountryModel.h
//  SystemTask
//
//  Created by Nagendra Babu on 17/04/20.
//  Copyright © 2020 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CountryModel : NSObject

/// MARK: - Property outlets

@property (nonatomic,assign) int _id;
@property (nonatomic,strong) NSString *country;
@property (nonatomic,strong) NSString *name;

- (int)parseResponse:(NSDictionary *)receivedObjects;


@end

NS_ASSUME_NONNULL_END
