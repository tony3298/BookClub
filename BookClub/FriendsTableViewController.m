//
//  FriendsTableViewController.m
//  BookClub
//
//  Created by Tony Dakhoul on 6/3/15.
//  Copyright (c) 2015 Tony Dakhoul. All rights reserved.
//

#import "FriendsTableViewController.h"
#import "SelectFriendsTableViewController.h"
#import "ProfileViewController.h"
#import "AppDelegate.h"

@interface FriendsTableViewController ()

@property (nonatomic)  NSArray *friends;
@property NSManagedObjectContext *moc;

@end

@implementation FriendsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    self.moc = appDelegate.managedObjectContext;

    [self loadFriends];
}

- (void)loadFriends {

    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Friend"];
    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]];
    self.friends = [self.moc executeFetchRequest:request error:nil];
}

-(void)setFriends:(NSArray *)friends {

    _friends = friends;
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.friends.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FriendsID" forIndexPath:indexPath];

    cell.textLabel.text = [self.friends[indexPath.row] name];

    return cell;
}



#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    if ([segue.identifier isEqualToString:@"SelectFriendsSegue"]) {

        UINavigationController *nc = segue.destinationViewController;
        SelectFriendsTableViewController *selectFriendsVC = nc.viewControllers[0];

        selectFriendsVC.moc = self.moc;
    } else if ([segue.identifier isEqualToString:@"FriendProfileSegue"]) {

        ProfileViewController *profileVC = segue.destinationViewController;
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        profileVC.friend = self.friends[indexPath.row];
        profileVC.moc = self.moc;

    }
}

- (IBAction)unwindToFriendsTableViewController:(UIStoryboardSegue *)segue {

    [self loadFriends];
}


@end
