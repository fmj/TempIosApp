//
//  ViewController.h
//  SimpleTempChecker
//
//  Created by Erik Thue on 7/25/13.
//  Copyright (c) 2013 Erik Thue. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *Temp;
@property (weak, nonatomic) IBOutlet UILabel *Humid;
- (IBAction)Refresh:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *Dato;

@end
