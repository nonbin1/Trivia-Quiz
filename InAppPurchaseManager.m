//
//  InAppPurchaseManager.m
//  superbowltriviaquiz
//
//  Created by Panasun on 5/23/2557 BE.
//  Copyright (c) 2557 Flutx. All rights reserved.
//

#import "InAppPurchaseManager.h"

//#define kInAppPurchaseProUpgradeProductId @"com.flutx.superbowltriviaquiz.lives2"
#define InAppLives1 @"com.flutx.superbowltriviaquiz.lives1"
#define InAppLives2 @"com.flutx.superbowltriviaquiz.lives2"
#define InAppLives3 @"com.flutx.superbowltriviaquiz.lives3"
#define InAppSkip1 @"com.flutx.superbowltriviaquiz.skip1"
#define InAppSkip2 @"com.flutx.superbowltriviaquiz.skip2"
#define InAppSkip3 @"com.flutx.superbowltriviaquiz.skip3"
#define InAppRemoveAds @"com.flutx.superbowltriviaquiz.removeads"


@interface InAppPurchaseManager ()

@end

@implementation InAppPurchaseManager

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction) buyLives1:(id)sender
{
    if([self canMakePurchases]) {
        kInAppPurchaseProUpgradeProductId = InAppLives1;
        NSLog(@"Buy id: %@", kInAppPurchaseProUpgradeProductId);
        
        [self loadStore];
        [self purchaseProUpgrade];
    }
}

- (IBAction) buyLives2:(id)sender
{
    if([self canMakePurchases]) {
        kInAppPurchaseProUpgradeProductId = InAppLives2;
        NSLog(@"Buy id: %@", kInAppPurchaseProUpgradeProductId);
        
        [self loadStore];
        [self purchaseProUpgrade];
    }
}

- (IBAction) buyLives3:(id)sender
{
    if([self canMakePurchases]) {
        kInAppPurchaseProUpgradeProductId = InAppLives3;
        NSLog(@"Buy id: %@", kInAppPurchaseProUpgradeProductId);
        
        [self loadStore];
        [self purchaseProUpgrade];
    }
}

- (IBAction) buySkip1:(id)sender
{
    if([self canMakePurchases]) {
        kInAppPurchaseProUpgradeProductId = InAppSkip1;
        NSLog(@"Buy id: %@", kInAppPurchaseProUpgradeProductId);
        
        [self loadStore];
        [self purchaseProUpgrade];
    }
}

- (IBAction) buySkip2:(id)sender
{
    if([self canMakePurchases]) {
        kInAppPurchaseProUpgradeProductId = InAppSkip2;
        NSLog(@"Buy id: %@", kInAppPurchaseProUpgradeProductId);
        
        [self loadStore];
        [self purchaseProUpgrade];
    }
}

- (IBAction) buySkip3:(id)sender
{
    if([self canMakePurchases]) {
        kInAppPurchaseProUpgradeProductId = InAppSkip3;
        NSLog(@"Buy id: %@", kInAppPurchaseProUpgradeProductId);
        
        [self loadStore];
        [self purchaseProUpgrade];
    }
}

- (IBAction) buyRemoveAds:(id)sender
{
    if([self canMakePurchases]) {
        kInAppPurchaseProUpgradeProductId = InAppRemoveAds;
        NSLog(@"Buy id: %@", kInAppPurchaseProUpgradeProductId);
        
        [self loadStore];
        [self purchaseProUpgrade];
    }
}

- (IBAction) restorePurchase:(id)sender
{
    
    kInAppPurchaseProUpgradeProductId = InAppRemoveAds;
    NSLog(@"Restore Purcase Remove Ads");
    [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
    [[SKPaymentQueue defaultQueue] restoreCompletedTransactions];
    
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"showads"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)requestProUpgradeProductData
{
    NSSet *productIdentifiers = [NSSet setWithObject:kInAppPurchaseProUpgradeProductId ];
    productsRequest = [[SKProductsRequest alloc] initWithProductIdentifiers:productIdentifiers];
    productsRequest.delegate = self;
    [productsRequest start];
    
    
    // we will release the request object in the delegate callback
}

#pragma mark -
#pragma mark SKProductsRequestDelegate methods

- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response
{
    NSLog(@"ABC");
    NSArray *products = response.products;
    proUpgradeProduct = [products count] == 1 ? [products firstObject]: nil;
    
    if (proUpgradeProduct)
    {
        NSLog(@"Product title: %@" , proUpgradeProduct.localizedTitle);
        NSLog(@"Product description: %@" , proUpgradeProduct.localizedDescription);
        NSLog(@"Product price: %@" , proUpgradeProduct.price);
        NSLog(@"Product id: %@" , proUpgradeProduct.productIdentifier);
    }
    
    for (NSString *invalidProductId in response.invalidProductIdentifiers)
    {
        NSLog(@"Invalid product id: %@" , invalidProductId);
    }
    
    // finally release the reqest we alloc/init’ed in requestProUpgradeProductData
  
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kInAppPurchaseManagerProductsFetchedNotification object:self userInfo:nil];
}

#pragma -
#pragma Public methods

//
// call this method once on startup
//
- (void)loadStore
{
    // restarts any purchases if they were interrupted last time the app was open
    [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
    
    // get the product description (defined in early sections)
    [self requestProUpgradeProductData];
}

//
// call this before making a purchase
//
- (BOOL)canMakePurchases
{
    return [SKPaymentQueue canMakePayments];
}

//
// kick off the upgrade transaction
//
- (void)purchaseProUpgrade
{
    SKPayment *payment = [SKPayment paymentWithProductIdentifier:kInAppPurchaseProUpgradeProductId];
    [[SKPaymentQueue defaultQueue] addPayment:payment];

}

#pragma -
#pragma Purchase helpers

//
// saves a record of the transaction by storing the receipt to disk
//
- (void)recordTransaction:(SKPaymentTransaction *)transaction
{
    if ([transaction.payment.productIdentifier isEqualToString:kInAppPurchaseProUpgradeProductId])
    {
        // save the transaction receipt to disk
        [[NSUserDefaults standardUserDefaults] setValue:transaction.transactionReceipt forKey:@"proUpgradeTransactionReceipt" ];
        [[NSUserDefaults standardUserDefaults] synchronize];
        NSLog(@"Complete Transaction for %@", kInAppPurchaseProUpgradeProductId);
    }
}

//
// enable pro features
//
- (void)provideContent:(NSString *)productId
{
    if ([productId isEqualToString:kInAppPurchaseProUpgradeProductId])
    {
        // enable the pro features
        int lives = [[[NSUserDefaults standardUserDefaults] objectForKey:@"lives"] integerValue];
        int skip = [[[NSUserDefaults standardUserDefaults] objectForKey:@"skip"] integerValue];
        
        if([productId isEqualToString:InAppLives1]) {
            lives = lives + 5;
            [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInt:lives] forKey:@"lives"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            NSLog(@"Lives Increase 5");
        }
        else if([productId isEqualToString:InAppLives2]) {
            lives = lives + 20;
            [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInt:lives] forKey:@"lives"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            NSLog(@"Lives Increase 20");
        }
        else if([productId isEqualToString:InAppLives3]) {
            lives = lives + 100;
            [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInt:lives] forKey:@"lives"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            NSLog(@"Lives Increase 100");
        }
        else if([productId isEqualToString:InAppSkip1]) {
            skip = skip + 5;
            [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInt:skip] forKey:@"skip"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            NSLog(@"Skip Increase 5");
        }
        else if([productId isEqualToString:InAppSkip2]) {
            skip = skip + 20;
            [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInt:skip] forKey:@"skip"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            NSLog(@"Skip Increase 20");
        }
        else if([productId isEqualToString:InAppSkip3]) {
            skip = skip + 100;
            [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInt:skip] forKey:@"skip"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            NSLog(@"Skip Increase 100");
        }
        else if([productId isEqualToString:InAppRemoveAds]) {
            [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"showads"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            NSLog(@"Remove Ads");
        }
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle: @"Complete Transaction !"
                                                       message: @"Your purchase already successful."
                                                      delegate: self
                                             cancelButtonTitle:@"OK"
                                             otherButtonTitles:nil];
        
        [alert show];
    }
}

//
// removes the transaction from the queue and posts a notification with the transaction result
//
- (void)finishTransaction:(SKPaymentTransaction *)transaction wasSuccessful:(BOOL)wasSuccessful
{
    // remove the transaction from the payment queue.
    [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
    
    NSDictionary *userInfo = [NSDictionary dictionaryWithObjectsAndKeys:transaction, @"transaction" , nil];
    if (wasSuccessful)
    {
        // send out a notification that we’ve finished the transaction
        [[NSNotificationCenter defaultCenter] postNotificationName:kInAppPurchaseManagerTransactionSucceededNotification object:self userInfo:userInfo];
    }
    else
    {
        // send out a notification for the failed transaction
        [[NSNotificationCenter defaultCenter] postNotificationName:kInAppPurchaseManagerTransactionFailedNotification object:self userInfo:userInfo];
    }
}

//
// called when the transaction was successful
//
- (void)completeTransaction:(SKPaymentTransaction *)transaction
{
    [self recordTransaction:transaction];
    [self provideContent:transaction.payment.productIdentifier];
    [self finishTransaction:transaction wasSuccessful:YES];
}

//
// called when a transaction has been restored and and successfully completed
//
- (void)restoreTransaction:(SKPaymentTransaction *)transaction
{
    [self recordTransaction:transaction.originalTransaction];
    [self provideContent:transaction.originalTransaction.payment.productIdentifier];
    [self finishTransaction:transaction wasSuccessful:YES];
}

//
// called when a transaction has failed
//
- (void)failedTransaction:(SKPaymentTransaction *)transaction
{
    if (transaction.error.code != SKErrorPaymentCancelled)
    {
        // error!
        [self finishTransaction:transaction wasSuccessful:NO];
    }
    else
    {
        // this is fine, the user just cancelled, so don’t notify
        [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
    }
}

#pragma mark -
#pragma mark SKPaymentTransactionObserver methods

//
// called when the transaction status is updated
//
- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions
{
    for (SKPaymentTransaction *transaction in transactions)
    {
        switch (transaction.transactionState)
        {
            case SKPaymentTransactionStatePurchased:
                [self completeTransaction:transaction];
                break;
            case SKPaymentTransactionStateFailed:
                [self failedTransaction:transaction];
                break;
            case SKPaymentTransactionStateRestored:
                [self restoreTransaction:transaction];
                break;
            default:
                break;
        }
    }
}



@end
