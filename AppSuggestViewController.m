//
//  AppSuggestViewController.m
//  superbowltriviaquiz
//
//  Created by Panasun on 5/26/2557 BE.
//  Copyright (c) 2557 Flutx. All rights reserved.
//

#import "AppSuggestViewController.h"
#import "AppSuggestTableCell.h"

@interface AppSuggestViewController ()

@end

@implementation AppSuggestViewController
{
    NSArray *appList;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //tableData = [NSArray arrayWithObjects:@"Egg Benedict", @"Mushroom Risotto", @"Full Breakfast", nil];
    //thumbnails = [NSArray arrayWithObjects:@"http://ad.flutx.com/images/icons/AQUE02.png", @"http://ad.flutx.com/images/icons/AQUE02.png", @"http://ad.flutx.com/images/icons/AQUE02.png", nil];
    //appUrl = [NSArray arrayWithObjects:@"itms-apps://itunes.apple.com/us/app/scan-qr-code-barcode-reader/id411206394?mt=8&uo=4", @"http://blognone.com", @"itms-apps://itunes.apple.com/us/app/keynote/id361285480?mt=8", nil];
    
    // Prepare the link that is going to be used on the GET request
    NSURL * url = [[NSURL alloc] initWithString:@"http://ad.flutx.com/applist_iostrivia_en.php"];
    
    // Prepare the request object
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url
                                                cachePolicy:NSURLRequestReturnCacheDataElseLoad
                                            timeoutInterval:30];
    
    // Prepare the variables for the JSON response
    NSData *urlData;
    NSURLResponse *response;
    NSError *error;
    
    // Make synchronous request
    urlData = [NSURLConnection sendSynchronousRequest:urlRequest
                                    returningResponse:&response
                                                error:&error];
    
    // Construct a Array around the Data from the response
    appList = [NSJSONSerialization
                       JSONObjectWithData:urlData
                       options:0
                       error:&error];
    
    NSLog(@"Fetch DB: %@, count = %i", [appList[1] objectForKey:@"name"], [appList count]);

    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [appList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"AppSuggestTableCell";
    
    AppSuggestTableCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"AppSuggestCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    cell.appTitle.text = [appList[indexPath.row] objectForKey:@"name"];
    cell.appThumbnail.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[appList[indexPath.row] objectForKey:@"icon"] ]]];
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //[[UIApplication sharedApplication] openURL:[NSURL URLWithString:[appUrl objectAtIndex:indexPath.row]] ];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[appList[indexPath.row] objectForKey:@"link"]] ];
    
    
}
              
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
