//
//  InAppPurchaseManager.h
//  superbowltriviaquiz
//
//  Created by Panasun on 5/23/2557 BE.
//  Copyright (c) 2557 Flutx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <StoreKit/StoreKit.h>

#define kInAppPurchaseManagerProductsFetchedNotification @"kInAppPurchaseManagerProductsFetchedNotification"
#define kInAppPurchaseManagerTransactionFailedNotification @"kInAppPurchaseManagerTransactionFailedNotification"
#define kInAppPurchaseManagerTransactionSucceededNotification @"kInAppPurchaseManagerTransactionSucceededNotification"



@interface InAppPurchaseManager : UIViewController <SKProductsRequestDelegate, SKPaymentTransactionObserver>
{
    SKProduct *proUpgradeProduct;
    SKProductsRequest *productsRequest;
    IBOutlet UIButton *buyLives1;
    IBOutlet UIButton *buyLives2;
    IBOutlet UIButton *buyLives3;
    IBOutlet UIButton *buySkip1;
    IBOutlet UIButton *buySkip2;
    IBOutlet UIButton *buySkip3;
    IBOutlet UIButton *buyRemoveAds;
    NSString *kInAppPurchaseProUpgradeProductId;
}

- (IBAction) buyLives1:(id)sender;
- (IBAction) buyLives2:(id)sender;
- (IBAction) buyLives3:(id)sender;
- (IBAction) buySkip1:(id)sender;
- (IBAction) buySkip2:(id)sender;
- (IBAction) buySkip3:(id)sender;
- (IBAction) buyRemoveAds:(id)sender;
- (IBAction) restorePurchase:(id)sender;

- (void)loadStore;
- (BOOL)canMakePurchases;
- (void)purchaseProUpgrade;

@end
