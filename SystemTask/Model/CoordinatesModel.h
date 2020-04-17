//
//  CoordinatesModel.h
//  SystemTask
//
//  Created by Nagendra Babu on 17/04/20.
//  Copyright © 2020 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CoordinatesModel : NSObject

/// MARK: - Property outlets

@property (nonatomic,readwrite) double lat;
@property (nonatomic,readwrite) double log;

@end

NS_ASSUME_NONNULL_END
