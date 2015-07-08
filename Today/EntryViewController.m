//
//  EntryViewController.m
//  Today
//
//  Copyright (c) 2015 zachbrass. All rights reserved.
//

#import "EntryViewController.h"

@interface EntryViewController () <UITextViewDelegate>
@property (nonatomic, weak) IBOutlet UIButton *moodButton;
@property (nonatomic, weak) IBOutlet UIButton *weatherButton;
@property (nonatomic, strong) IBOutletCollection(UIButton) NSArray *topButtons;
@property (nonatomic, weak) IBOutlet UITextView *entryTextView;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *textViewBottomLayoutConstraint;
@end

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
    self.textViewBottomLayoutConstraint.constant = keyboardSize.height;
    [UIView animateWithDuration:animationDuration animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void)textViewDidChange:(UITextView *)textView{
    self.entry.entryText = textView.text;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    [segue.destinationViewController setEntry:self.entry];
}


@end
