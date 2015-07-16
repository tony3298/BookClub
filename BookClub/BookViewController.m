//
//  BookViewController.m
//  BookClub
//
//  Created by Tony Dakhoul on 6/4/15.
//  Copyright (c) 2015 Tony Dakhoul. All rights reserved.
//

#import "BookViewController.h"
#import "Comment.h"

@interface BookViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic)  NSArray *comments;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *authorLabel;
@property (weak, nonatomic) IBOutlet UIImageView *bookImageView;
@end

@implementation BookViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.titleLabel.text = self.book.title;
    self.authorLabel.text = self.book.author;

    [self loadComments];


}

-(void)loadComments {

//    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Comment"];
//    request.predicate = [NSPredicate predicateWithFormat:@"book CONTAINS %@", self.book];
    self.comments = self.book.comments.allObjects;
}

-(void)setComments:(NSArray *)comments {

    _comments = comments;
    [self.tableView reloadData];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.comments.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CommentID"];

    Comment *comment = self.comments[indexPath.row];
    cell.textLabel.text = comment.commentString;

    return cell;
}

- (IBAction)onAddButtonTapped:(UIBarButtonItem *)sender {

    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"New Comment" message:nil preferredStyle:UIAlertControllerStyleAlert];

    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"Comment Here";
    }];

    UIAlertAction *addAction = [UIAlertAction actionWithTitle:@"Add Comment" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){

        UITextField *commentTextField = [[alertController textFields] firstObject];

        NSString *commentString = commentTextField.text;

        Comment *comment = [NSEntityDescription insertNewObjectForEntityForName:@"Comment" inManagedObjectContext: self.moc];
        [comment setValue:commentString forKey:@"commentString"];
        [self.book addCommentsObject:comment];
        [self.moc save:nil];
        [self loadComments];
//        [self load];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
    }];
    [alertController addAction:addAction];
    [alertController addAction:cancelAction];
    [self presentViewController:alertController animated:YES completion:nil];}

@end
