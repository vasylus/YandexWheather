//
//  CityModel.m
//  YandexWheather
//
//  Created by Vasyl Vasylchenko on 22.04.16.
//  Copyright © 2016 Vasyl Vasylchenko. All rights reserved.
//

#import "CityModel.h"

@implementation CityModel

- (instancetype)initWithDictionary:(NSDictionary *)dic{
    if (self = [super init]){
        if ([dic isKindOfClass:NSDictionary.class]&&dic[@"id"]){
        self.cityID = dic[@"id"];
        self.cityName = dic[@"text"];
        self.countryName = dic[@"country"];
        }
    }
    return self;
}

@end
