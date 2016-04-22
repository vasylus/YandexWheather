//
//  CityModel.h
//  YandexWheather
//
//  Created by Vasyl Vasylchenko on 22.04.16.
//  Copyright © 2016 Vasyl Vasylchenko. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CityModel : NSObject

- (instancetype)initWithDictionary:(NSDictionary *)dic;

@property (strong, nonatomic) NSString *cityName;
@property (strong, nonatomic) NSString *cityID;
@property (strong, nonatomic) NSString *countryName;


@end
