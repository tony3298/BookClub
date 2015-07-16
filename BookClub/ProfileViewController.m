//
//  ProfileViewController.m
//  BookClub
//
//  Created by Tony Dakhoul on 6/3/15.
//  Copyright (c) 2015 Tony Dakhoul. All rights reserved.
//

#import "ProfileViewController.h"
#import "AddBookViewController.h"
#import "BookViewController.h"

@interface ProfileViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *friendNameTextLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic)  NSArray *books;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.profileImageView.layer.cornerRadius = 45;
    self.profileImageView.clipsToBounds = YES;

    self.friendNameTextLabel.text = self.friend.name;

    [self loadBooksForFriend];


}

- (void)viewDidAppear:(BOOL)animated {

//    self.profileImageView.layer.cornerRadius = self.profileImageView.layer.frame.size.width / 2;
    self.profileImageView.clipsToBounds = YES;
    [self loadBooksForFriend];

}

- (void)loadBooksForFriend {

//    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:NSStringFromClass([Book class])];
//    request.predicate = [NSPredicate predicateWithFormat:@"friends CONTAINS %@", self.friend];
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"title" ascending:YES];
    self.books = [self.friend.books.allObjects sortedArrayUsingDescriptors:@[sortDescriptor]];
//    [self.books sortedArrayUsingDescriptors:@[sortDescriptor]];
//    id moc = [(id)[UIApplication sharedApplication].delegate valueForKey:@"managedObjectContext"];
//    self.books = [self.moc executeFetchRequest:request error:nil];
}

-(void)setBooks:(NSArray *)books {

    _books = books;
    [self.tableView reloadData];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.books.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BookID"];

    Book *book = self.books[indexPath.row];
    cell.textLabel.text = book.title;
    cell.detailTextLabel.text = book.author;

    return cell;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    if ([segue.identifier isEqualToString:@"AddBookSegue"]) {

        UINavigationController *nvc = segue.destinationViewController;
        AddBookViewController *addBookVC = nvc.viewControllers[0];

        addBookVC.friend = self.friend;
        addBookVC.moc = self.moc;

    } else if ([segue.identifier isEqualToString:@"BookSegue"]) {

        BookViewController *bookVC = segue.destinationViewController;
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        bookVC.book = self.books[indexPath.row];
        bookVC.moc = self.moc;
        
    }

}

-(IBAction)unwindToProfile:(UIStoryboardPopoverSegue *)segue {

    [self loadBooksForFriend];
}



@end
