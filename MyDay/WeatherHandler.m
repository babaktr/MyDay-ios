#import "WeatherHandler.h"
#import "NSDate+MyDay.h"

@implementation WeatherHandler

+ (NSNumber *)getWeatherDataForLocationLatitude:(float)latitude
                                      longitude:(float)longitude
{
    NSString *urlString = [NSString stringWithFormat:@"http://opendata-download-metfcst.smhi.se/api/category/pmp1.5g/version/1/geopoint/lat/%f/lon/%f/data.json", latitude, longitude];
    NSLog(@"link: %@", [NSString stringWithFormat:@"http://opendata-download-metfcst.smhi.se/api/category/pmp1.5g/version/1/geopoint/lat/%f/lon/%f/data.json", latitude, longitude]);

    NSURL *url = [NSURL URLWithString:urlString];

    NSMutableArray *downfallArray = [[NSMutableArray alloc] init];
    NSMutableArray *lowCloudsArray = [[NSMutableArray alloc] init];
    NSMutableArray *highCloudsArray = [[NSMutableArray alloc] init];

    NSData *jsonData = [NSData dataWithContentsOfURL:url];
    if(jsonData != nil) {
        NSError *error;
        NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&error];
        [[jsonArray valueForKey:@"timeseries"] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {

            NSString *weatherDate = obj[@"validTime"];

            NSString *YMD = [[weatherDate substringWithRange: NSMakeRange(0,10)] stringByAppendingString:@" "];
            NSString *HHmm = [weatherDate substringWithRange: NSMakeRange(11,5)];
            NSString *YMDHHmm = [YMD stringByAppendingString:HHmm];
            NSDate *timeForWeather = [[self dateFormatter] dateFromString: YMDHHmm];

            NSDate *date = [NSDate currentDateInSystemTimezone];
            NSComparisonResult sameHour = [[NSCalendar currentCalendar] compareDate:date
                                                                             toDate:timeForWeather
                                                                  toUnitGranularity:NSCalendarUnitHour];
            if (sameHour == NSOrderedSame) {
                [downfallArray addObject:obj[@"pcat"]];
                [lowCloudsArray addObject:obj[@"lcc"]];
                [highCloudsArray addObject:obj[@"hcc"]];
            }
        }];
    }

    NSInteger totalCloudValue = [[lowCloudsArray lastObject] integerValue]*2 + [[highCloudsArray lastObject] integerValue];

    if (!([[downfallArray firstObject] integerValue] == 0)) { //If there's any downfall
        return @([[downfallArray firstObject] integerValue]);
    } else if (totalCloudValue < 9) { //If total clouds are low: sunny
        return @(10);
    } else if (totalCloudValue < 16) { //If total clouds are medium: sunny & cloudy
        return @(15);
    }
    return @(0); //cloudy
}

+ (NSDateFormatter *)dateFormatter
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    return dateFormatter;
}

+ (UIImage *)imageForWeatherScore:(NSNumber *)score
{
    if ([score integerValue] == 0) { //cloudy
        return [UIImage imageNamed:@"weather-cloud"];
    } else if ([score integerValue] == 1) { //snow
        return [UIImage imageNamed:@"weather-snow"];
    } else if ([score integerValue] == 2 || [score integerValue] == 6 || [score integerValue] == 5) { //snow and rain / freezing rain / freezing drizzle
        return [UIImage imageNamed:@"weather-snowrain"];
    } else if ([score integerValue] == 3 || [score integerValue] == 4) { //rain / drizzle
        return [UIImage imageNamed:@"weather-rain"];
    } else if ([score integerValue] == 15) { // partly cloudy, partly sunny
        return [UIImage imageNamed:@"weather-cloudsun"];
    } else { // sun
        return [UIImage imageNamed:@"weather-sun"];
    }
}

@end
