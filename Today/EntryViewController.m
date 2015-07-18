//
//  EntryViewController.m
//  Today
//
//  Copyright (c) 2015 zachbrass. All rights reserved.
//

#import "EntryViewController.h"
#import "NSDate+StartAndEnd.h"
#import "EntryPhotoCollectionViewCell.h"
#import "MWPhotoBrowser.h"
@import Photos;
@interface EntryViewController () <UITextViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic, weak) IBOutlet UIButton *moodButton;
@property (nonatomic, weak) IBOutlet UIButton *weatherButton;
@property (nonatomic, strong) IBOutletCollection(UIButton) NSArray *topButtons;
@property (nonatomic, weak) IBOutlet UITextView *entryTextView;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *textViewBottomLayoutConstraint;
@property (nonatomic, strong) PHFetchResult *fetchResult;
@property (nonatomic, weak) IBOutlet UICollectionView *photosCollectionView;
@end

static NSString *const CellIdentifier = @"Cell";
@implementation EntryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSDateFormatter *entryDateFormatter = [[NSDateFormatter alloc] init];
    entryDateFormatter.dateStyle = NSDateFormatterMediumStyle;
    entryDateFormatter.timeStyle = NSDateFormatterNoStyle;
    self.title = [entryDateFormatter stringFromDate:self.entry.date];
    
    for (UIButton *button in self.topButtons) {
        button.tintColor = [UIColor blackColor];
        button.layer.borderWidth = 0.5;
        button.layer.borderColor = [UIColor blackColor].CGColor;
    }
    PHFetchOptions *fetchOptions = [PHFetchOptions new];
    fetchOptions.predicate = [NSPredicate predicateWithFormat:@"creationDate < %@", self.entry.date.endOfDay];
  
//    fetchOptions.predicate = [NSPredicate predicateWithFormat:@"creationDate > %@ AND creationDate < %@", self.entry.date.beginningOfDay, self.entry.date.endOfDay];
    
    self.fetchResult = [PHAsset fetchAssetsWithOptions:fetchOptions];
    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.entryTextView.text = self.entry.entryText;
    [self.moodButton setTitle:self.entry.emojiForMood forState:UIControlStateNormal];
    [self.moodButton setTitle:self.entry.emojiForMood forState:UIControlStateHighlighted];
    [self.weatherButton setTitle:self.entry.weatherCharacter forState:UIControlStateNormal];
    [self.weatherButton setTitle:self.entry.weatherCharacter forState:UIControlStateHighlighted];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillChangeFrame:)
                                                 name:UIKeyboardWillChangeFrameNotification object:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)keyboardWillChangeFrame:(NSNotification *)notification {
    NSDictionary *info = [notification userInfo];
    CGSize keyboardSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    CGFloat animationDuration = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    if (keyboardSize.height == 0) {
        self.textViewBottomLayoutConstraint.constant = CGRectGetHeight(self.photosCollectionView.frame);
    } else {
        self.textViewBottomLayoutConstraint.constant = keyboardSize.height;
    }
    [UIView animateWithDuration:animationDuration animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void)textViewDidChange:(UITextView *)textView {
    self.entry.entryText = textView.text;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.fetchResult.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    EntryPhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    [[PHImageManager defaultManager] requestImageForAsset:[self.fetchResult objectAtIndex:indexPath.row]
                                 targetSize:CGSizeMake(60.0, 60.0)
                                contentMode:PHImageContentModeAspectFill
                                    options:nil
                              resultHandler:^(UIImage *result, NSDictionary *info) {
                                  
                                  // Only update the thumbnail if the cell tag hasn't changed. Otherwise, the cell has been re-used.
                                  cell.imageView.image = result;
                                  
                              }];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSMutableArray *photos = [[NSMutableArray alloc] init];
    // Photos library
    UIScreen *screen = [UIScreen mainScreen];
    CGFloat scale = screen.scale;
    // Sizing is very rough... more thought required in a real implementation
    CGFloat imageSize = MAX(screen.bounds.size.width, screen.bounds.size.height) * 1.5;
    CGSize imageTargetSize = CGSizeMake(imageSize * scale, imageSize * scale);
    for (PHAsset *asset in self.fetchResult) {
        [photos addObject:[MWPhoto photoWithAsset:asset targetSize:imageTargetSize]];
    }
    
    MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithPhotos:photos];
    browser.displayActionButton = NO;
    browser.displayNavArrows = NO;
    browser.displaySelectionButtons = NO;
    browser.alwaysShowControls = YES;
    browser.zoomPhotosToFill = YES;
    browser.enableGrid = YES;
    browser.startOnGrid = NO;
    browser.enableSwipeToDismiss = NO;
    [browser setCurrentPhotoIndex:indexPath.row];
    
    [self.navigationController pushViewController:browser animated:YES];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    [segue.destinationViewController setEntry:self.entry];
}


@end
