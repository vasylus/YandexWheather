//
//  WheatherModel.m
//  YandexWheather
//
//  Created by Vasyl Vasylchenko on 21.04.16.
//  Copyright © 2016 Vasyl Vasylchenko. All rights reserved.
//

#import "WheatherModel.h"

@implementation WheatherModel

- (instancetype)initWithDictionary:(NSDictionary *)dic{
    if (self = [super init]){
        self.date = dic[@"date"];
        int i = 0;
        for (NSDictionary *dayParts in dic[@"day_part"]){
            i++;
            if (i==1){
                self.temperatureTo = dayParts[@"temperature_to"][@"text"];
                self.temperatureFrom = dayParts[@"temperature_from"][@"text"];
                self.wheatherDescription = dayParts[@"weather_type"][@"text"];
            }
        }
        
    }
    return self;
}


@end
