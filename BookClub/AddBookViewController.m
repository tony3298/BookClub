//
//  AddBookViewController.m
//  BookClub
//
//  Created by Tony Dakhoul on 6/4/15.
//  Copyright (c) 2015 Tony Dakhoul. All rights reserved.
//

#import "AddBookViewController.h"

@interface AddBookViewController ()
@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UITextField *authorTextField;

@end

@implementation AddBookViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)onSaveButtonTapped:(UIBarButtonItem *)sender {

    if (![self.titleTextField.text isEqualToString:@""] && ![self.authorTextField.text isEqualToString:@""]) {

        Book *book = [[Book alloc] initWithEntity:[NSEntityDescription entityForName:@"Book" inManagedObjectContext:self.moc] insertIntoManagedObjectContext:self.moc];
        book.title = self.titleTextField.text;
        book.author = self.authorTextField.text;
        [book addFriendsObject:self.friend];
//        [book setValue:book.title forKey:@"title"];
//        [book setValue:book.author forKey:@"author"];

        [self.moc save:nil];

        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (IBAction)onCancelButtonTapped:(UIBarButtonItem *)sender {

    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
