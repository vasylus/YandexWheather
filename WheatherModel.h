//
//  WheatherModel.h
//  YandexWheather
//
//  Created by Vasyl Vasylchenko on 21.04.16.
//  Copyright © 2016 Vasyl Vasylchenko. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WheatherModel : NSObject

- (instancetype)initWithDictionary:(NSDictionary *)dic;

@property (strong, nonatomic) NSString *date;
@property (strong, nonatomic) NSString *temperatureFrom;
@property (strong, nonatomic) NSString *temperatureTo;
@property (strong, nonatomic) NSString *windSpeed;
@property (strong, nonatomic) NSString *wheatherDescription;

@end
