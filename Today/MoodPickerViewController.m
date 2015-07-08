//
//  MoodPickerViewController.m
//  Today
//
//  Copyright (c) 2015 zachbrass. All rights reserved.
//

#import "MoodPickerViewController.h"
#import "PickerCollectionViewCell.h"
#import "EntryTextEditViewController.h"
@interface MoodPickerViewController ()
@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;
@property (nonatomic, weak) IBOutlet UILabel *selectedMoodLabel;
@end

static NSString * const MoodCharacterOptions = @"😞😕😐😊😄";
static NSString * const CellIdentifier = @"Cell";
static NSString * const ToEntryTextEditSegue = @"MoodPickerToEntryTextEdit";

@implementation MoodPickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSLocalizedString(@"Mood Picker Title", @"");
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (self.entry.moodIndex) {
        self.selectedMoodLabel.text = [MoodCharacterOptions substringWithRange:NSMakeRange(self.entry.moodIndex.integerValue * 2 - 2, 2)];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return MoodCharacterOptions.length / 2;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PickerCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    
    cell.iconLabel.text = [MoodCharacterOptions substringWithRange:NSMakeRange(indexPath.row * 2, 2)];
    
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    EntryTextEditViewController * destination = (EntryTextEditViewController *)segue.destinationViewController;
    destination.entry = self.entry;
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
- (void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    self.selectedMoodLabel.text = [MoodCharacterOptions substringWithRange:NSMakeRange(indexPath.row * 2, 2)];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSString *moodString = [MoodCharacterOptions substringWithRange:NSMakeRange(indexPath.row * 2, 2)];
    self.selectedMoodLabel.text = moodString;
    self.entry.moodIndex = @(indexPath.row + 1);
    if (self.inCreationFlow) {
        [self performSegueWithIdentifier:ToEntryTextEditSegue sender:self];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}
@end
