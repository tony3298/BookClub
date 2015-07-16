//
//  SelectFriendsTableViewController.m
//  BookClub
//
//  Created by Tony Dakhoul on 6/3/15.
//  Copyright (c) 2015 Tony Dakhoul. All rights reserved.
//

#import "SelectFriendsTableViewController.h"
#import "Friend.h"
#import "AppDelegate.h"

@interface SelectFriendsTableViewController ()

@property (nonatomic) NSArray *friends;
@property NSArray *selectedFriends;

@end

@implementation SelectFriendsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self loadSelectedFriends];

    if (![self loadFriends]) {

        NSLog(@"Friends not loaded");

        [self retrieveFriendsFromWeb];
    }
}

-(void)setFriends:(NSArray *)friends {

    _friends = friends;
    [self.tableView reloadData];
}

-(BOOL)loadFriends {

    NSURL *plist = [[self documentDirectory] URLByAppendingPathComponent:@"friends.plist"];
    self.friends = [NSArray arrayWithContentsOfURL:plist] ?: [NSArray new];

    if (self.friends.count > 0) {
        return YES;
    }

    return NO;
}

-(void)loadSelectedFriends {

    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:NSStringFromClass([Friend class])];
    self.selectedFriends = [self.moc executeFetchRequest:request error:nil];
}

-(void)save {

    NSURL *plist = [[self documentDirectory] URLByAppendingPathComponent:@"friends.plist"];
    [self.friends writeToURL:plist atomically:YES];
}

-(NSURL *)documentDirectory {

    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] firstObject];
}

- (void)retrieveFriendsFromWeb {

//    NSURL *url = [NSURL URLWithString:@"http://s3.amazonaws.com/mobile-makers-assets/app/public/ckeditor_assets/attachments/18/friends.json"];

    NSURL *url = [NSURL URLWithString:@"https://api.myjson.com/bins/153fa"];

    NSURLRequest *request = [NSURLRequest requestWithURL:url];

    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {

        NSArray *results = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];

        self.friends = results;
        [self save];
    }];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.friends.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FriendID" forIndexPath:indexPath];

    cell.textLabel.text = self.friends[indexPath.row];

    for (Friend *friend in self.selectedFriends) {

        if ([friend.name isEqualToString:self.friends[indexPath.row]]) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }

//        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Friend"];
//        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name CONTAINS %@", [self.friends[indexPath.row] name]];
//        request.predicate = predicate;
//        NSArray *friend = [self.moc executeFetchRequest:request error:nil];
//
//        if (friend.count > 0)
    }

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    if ([tableView cellForRowAtIndexPath:indexPath].accessoryType == UITableViewCellAccessoryCheckmark) {

        [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryNone;

        NSString *name = self.friends[indexPath.row];

//        for (Friend *friend in self.selectedFriends) {
//
//            if ([friend.name isEqualToString:name]) {
//                [self.moc deleteObject:friend];
//            }
//        }
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:NSStringFromClass([Friend class])];
        request.predicate = [NSPredicate predicateWithFormat:@"name CONTAINS %@", name];
        NSArray *friendToDelete = [self.moc executeFetchRequest:request error:nil];

        Friend *friend = friendToDelete[0];
        friend.name = @"blah";
        [self.moc deleteObject:friend];

        [self.moc save:nil];
    } else {

        NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Friend" inManagedObjectContext:self.moc];

        Friend *friend = [[Friend alloc] initWithEntity:entityDescription insertIntoManagedObjectContext:self.moc];
        
        friend.name = self.friends[indexPath.row];
//        [friend setValue:friend.name forKey:@"name"];

//        [self.selectedFriends addObject:friend];

        [self loadSelectedFriends];
        [self.moc save:nil];


        [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryCheckmark;
    }
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
