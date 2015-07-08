//
//  DayPickerViewController.m
//  Today
//
//  Copyright (c) 2015 zachbrass. All rights reserved.
//

#import "DayPickerViewController.h"
#import "WeatherPickerViewController.h"
@interface DayPickerViewController ()
@property (nonatomic, weak) IBOutlet UIButton *todayButton;
@property (nonatomic, weak) IBOutlet UIButton *yesterdayButton;
@property (nonatomic, weak) IBOutlet UILabel *promptLabel;
- (IBAction)didSelectDayButton:(UIButton *)sender;
@end

static NSTimeInterval const DayInSeconds = 86400;

@implementation DayPickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = NSLocalizedString(@"New Entry", @"");
    
    NSDateFormatter *dayFormatter = [[NSDateFormatter alloc] init];
    dayFormatter.timeStyle = NSDateFormatterNoStyle;
    dayFormatter.dateStyle = NSDateFormatterShortStyle;
    NSString *todayTitle = [NSString stringWithFormat:NSLocalizedString(@"Today: %@", @""), [dayFormatter stringFromDate:[NSDate date]]];
    [self.todayButton setTitle:todayTitle forState:UIControlStateNormal];
    [self.todayButton setTitle:todayTitle forState:UIControlStateHighlighted];
    NSString *yesterdayTitle = [NSString stringWithFormat:NSLocalizedString(@"Yesterday: %@", @""), [dayFormatter stringFromDate:[NSDate dateWithTimeIntervalSinceNow:-DayInSeconds]]];
    [self.yesterdayButton setTitle:yesterdayTitle forState:UIControlStateNormal];
    [self.yesterdayButton setTitle:yesterdayTitle forState:UIControlStateHighlighted];
    
    self.promptLabel.text = NSLocalizedString(@"New Entry Day Prompt", @"");
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (void)viewWillDisappear:(BOOL)animated{
//    [super viewWillDisappear:animated];
//    if (self.isBeingDismissed) {
//        NSManagedObjectContext *context = [self.entry managedObjectContext];
//        [context deleteObject:self.entry];
//        NSError *error;
//        [context save:&error];
//    }
//}
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    WeatherPickerViewController * destination = (WeatherPickerViewController *)segue.destinationViewController;
    destination.entry = self.entry;
    destination.inCreationFlow = YES;
}

- (IBAction)didSelectDayButton:(UIButton *)sender {
    
    if (sender == self.todayButton) {
        self.entry.date = [NSDate date];
    } else if (sender == self.yesterdayButton) {
        self.entry.date = [NSDate dateWithTimeIntervalSinceNow:-DayInSeconds];
    }
}

@end
