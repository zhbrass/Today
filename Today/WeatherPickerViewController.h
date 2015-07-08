//
//  WeatherPickerViewController.h
//  Today
//
//  Copyright (c) 2015 zachbrass. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Entry+Graphics.h"
@interface WeatherPickerViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic, strong) Entry *entry;
@property (nonatomic, readwrite) BOOL inCreationFlow;
@end
