//
//  ViewController.m
//  SimpleTempChecker
//
//  Created by Erik Thue on 7/25/13.
//  Copyright (c) 2013 Erik Thue. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	[self loadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadData
{
	NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://erthtemp.azurewebsites.net/Temp/lastAsJson"]];
	
	// Perform request and get JSON back as a NSData object
	NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
	NSError *error = nil;
    id object = [NSJSONSerialization
				 JSONObjectWithData:response
				 options:0
				 error:&error];
	if(!error)
	{
		if([object isKindOfClass:[NSDictionary class]])
		{
			NSDictionary *results = object;
			NSLog(@"Trying to prase dict");
			NSLog([NSString stringWithFormat:@"%d",[results count]]);
			[_Temp setText:[[results objectForKey:@"Temperature"] stringValue]];
			[_Humid setText:[[results valueForKey:@"Humidity"] stringValue]];
			id temp = [results objectForKey:@"dato"];
			NSDate *date = [ViewController dateFromJSONString:temp];
			NSString *dateString = [NSDateFormatter localizedStringFromDate:date dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterShortStyle];
			NSLog(dateString);
			[_Dato setText:dateString];
			//[_Humid setText:[results valueForKey:@"Humidity"]];
		}
		else
		{
			[_Temp setText:@"Error occured with dict"];
		}
	}
	else
	{
		[_Temp setText:@"Error occured with parse of json"];
	}

}

+ (NSDate*) dateFromJSONString:(NSString *)dateString
{
    NSCharacterSet *charactersToRemove = [[ NSCharacterSet decimalDigitCharacterSet ] invertedSet ];
    NSString* milliseconds = [dateString stringByTrimmingCharactersInSet:charactersToRemove];
	
    if (milliseconds != nil && ![milliseconds isEqualToString:@"62135596800000"]) {
        NSTimeInterval  seconds = [milliseconds doubleValue] / 1000;
        return [NSDate dateWithTimeIntervalSince1970:seconds];
    }
    return nil;
}

- (IBAction)Refresh:(id)sender
{
	[self loadData];
}
@end
