//
//  WeatherPickerViewController.m
//  Today
//
//  Copyright (c) 2015 zachbrass. All rights reserved.
//

#import "WeatherPickerViewController.h"
#import "PickerCollectionViewCell.h"
#import "MoodPickerViewController.h"
@interface WeatherPickerViewController ()
@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;
@property (nonatomic, weak) IBOutlet UILabel *selectedWeatherLabel;
@end

static NSString * const WeatherCharacterOptions = @"!\"#$%&\()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNWXf";
static NSString * const CellIdentifier = @"Cell";
static NSString * const ToWeatherPickerSegue = @"WeatherPickerToMoodPicker";

@implementation WeatherPickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = NSLocalizedString(@"Weather Picker Title", @"");
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (self.entry.weatherCharacter) {
        self.selectedWeatherLabel.text = self.entry.weatherCharacter;
    }
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    MoodPickerViewController * destination = (MoodPickerViewController *)segue.destinationViewController;
    destination.entry = self.entry;
    destination.inCreationFlow = YES;
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return WeatherCharacterOptions.length;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PickerCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    
    cell.iconLabel.text = [WeatherCharacterOptions substringWithRange:NSMakeRange(indexPath.row, 1)];
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/
- (void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath{
    self.selectedWeatherLabel.text = [WeatherCharacterOptions substringWithRange:NSMakeRange(indexPath.row, 1)];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSString *weatherCharacter = [WeatherCharacterOptions substringWithRange:NSMakeRange(indexPath.row, 1)];
    self.selectedWeatherLabel.text = weatherCharacter;
    self.entry.weatherCharacter = weatherCharacter;
    if (self.inCreationFlow) {
        [self performSegueWithIdentifier:ToWeatherPickerSegue sender:self];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}
@end
