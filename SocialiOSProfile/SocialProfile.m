/*
 Copyright (C) 2012-2014 Soomla Inc.
 
 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at
 
 http://www.apache.org/licenses/LICENSE-2.0
 
 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 */

#import "SocialProfile.h"
#import "AuthController.h"
#import "SocialController.h"
#import "UserProfileUtils.h"
#import "ProfileEventHandling.h"
#import "UserProfileNotFoundException.h"
#import "UserProfileStorage.h"

#import <UIKit/UIKit.h>

// if using Unity social provider this is YES
BOOL UsingExternalProvider;

@implementation SocialProfile

+ (void)usingExternalProvider:(BOOL)isExternal {
    
    UsingExternalProvider = isExternal;
}

+ (BOOL)isUsingExternalProvider {
    return UsingExternalProvider;
}

- (void)initialize {
    [self initialize:nil];
}

- (void)initialize:(NSDictionary *)customParams {
    if (UsingExternalProvider) {
        authController = [[AuthController alloc] initWithoutLoadingProviders];
        socialController = [[SocialController alloc] initWithoutLoadingProviders];
    }
    else {
        authController = [[AuthController alloc] initWithParameters:customParams];
        socialController = [[SocialController alloc] initWithParameters:customParams];
    }
    
    [ProfileEventHandling postProfileInitialized];
}

- (void)loginWithProvider:(Provider)provider {
    [self loginWithProvider:provider andPayload:@""];
}

- (void)loginWithProvider:(Provider)provider andPayload:(NSString *)payload {
    @try {
        [authController loginWithProvider:provider andPayload:payload];
    }
    @catch (NSException *exception) {

        // TODO: implement logic like in java that will raise the exception. Currently not raised
        [socialController loginWithProvider:provider andPayload:payload];
    }
}

- (void)logoutWithProvider:(Provider)provider {
    @try {
        [authController logoutWithProvider:provider];
    }
    @catch (NSException *exception) {

        // TODO: implement logic like in java that will raise the exception. Currently not raised
        [socialController logoutWithProvider:provider];
    }
}

- (BOOL)isLoggedInWithProvider:(Provider)provider {
    @try {
        return [authController isLoggedInWithProvider:provider];
    }
    @catch (NSException *exception) {
        
        // TODO: implement logic like in java that will raise the exception. Currently not raised
        return [socialController isLoggedInWithProvider:provider];
    }

}

- (UserProfile *)getStoredUserProfileWithProvider:(Provider)provider {
    @try {
        return [authController getStoredUserProfileWithProvider:provider];
    }
    @catch (NSException *exception) {
        
        // TODO: implement logic like in java that will raise the exception. Currently not raised
        return [socialController getStoredUserProfileWithProvider:provider];
    }
}

- (NSArray *)getStoredUserProfiles {
    NSArray* providers = [UserProfileUtils availableProviders];
    NSMutableArray* userProfiles = [NSMutableArray array];
    for(NSNumber* providerNum in providers) {
        @try {
            UserProfile* userProfile = [UserProfileStorage getUserProfile:(Provider)[providerNum intValue]];
            if (userProfile) {
                [userProfiles addObject:userProfile];
            }
        }@catch (NSException *exception) {
            // Skip
        }
    }
    return userProfiles;
}

- (void)updateStatusWithProvider:(Provider)provider andStatus:(NSString *)status andPayload:(NSString *)payload  {
    [socialController updateStatusWithProvider:provider andStatus:status andPayload:payload];
}

- (void)updateStatusWithProvider:(Provider)provider andStatus:(NSString *)status {
    [self updateStatusWithProvider:provider andStatus:status andPayload:@""];
}

- (void)updateStatusWithProviderDialog:(Provider)provider andLink:(NSString *)link andPayload:(NSString *)payload  {
    [socialController updateStatusWithProviderDialog:provider andLink:link andPayload:payload];
}

- (void)updateStatusWithProviderDialog:(Provider)provider andLink:(NSString *)link {
    [self updateStatusWithProviderDialog:provider andLink:link andPayload:@""];
}

- (void)updateStoryWithProvider:(Provider)provider
                     andMessage:(NSString *)message
                        andName:(NSString *)name
                     andCaption:(NSString *)caption
                 andDescription:(NSString *)description
                        andLink:(NSString *)link
                     andPicture:(NSString *)picture
                     andPayload:(NSString *)payload{
    [socialController updateStoryWithProvider:provider andMessage:message andName:name andCaption:caption
                               andDescription:description andLink:link andPicture:picture andPayload:payload];
}

- (void)updateStoryWithProvider:(Provider)provider
                     andMessage:(NSString *)message
                        andName:(NSString *)name
                     andCaption:(NSString *)caption
                 andDescription:(NSString *)description
                        andLink:(NSString *)link
                     andPicture:(NSString *)picture{
    [self updateStoryWithProvider:provider andMessage:message andName:name andCaption:caption
                   andDescription:description andLink:link andPicture:picture andPayload:@""];
}

- (void)updateStoryWithProviderDialog:(Provider)provider
                                  andName:(NSString *)name
                               andCaption:(NSString *)caption
                           andDescription:(NSString *)description
                                  andLink:(NSString *)link
                               andPicture:(NSString *)picture
                           andPayload:(NSString *)payload
                                 {
    [socialController updateStoryWithProviderDialog:provider andName:name andCaption:caption
                               andDescription:description andLink:link andPicture:picture andPayload:payload];
}

- (void)updateStoryWithProviderDialog:(Provider)provider
                              andName:(NSString *)name
                           andCaption:(NSString *)caption
                       andDescription:(NSString *)description
                              andLink:(NSString *)link
                           andPicture:(NSString *)picture{
    [self updateStoryWithProviderDialog:provider andName:name andCaption:caption
                   andDescription:description andLink:link andPicture:picture andPayload:@""];
}

- (void)uploadImageWithProvider:(Provider)provider
                     andMessage:(NSString *)message
                    andFilePath:(NSString *)filePath
                     andPayload:(NSString *)payload {
    [socialController uploadImageWithProvider:provider andMessage:message andFilePath:filePath andPayload:payload];
}

- (void)uploadImageWithProvider:(Provider)provider
                     andMessage:(NSString *)message
               andImageFileName: (NSString *)fileName
                   andImageData:(NSData *)imageData
                     andPayload:(NSString *)payload {

    [socialController uploadImageWithProvider:provider andMessage:message andImageFileName:fileName andImageData:imageData andPayload:payload];
}

- (void)uploadImageWithProvider:(Provider)provider
                     andMessage:(NSString *)message
                    andFilePath:(NSString *)filePath {
    [self uploadImageWithProvider:provider andMessage:message andFilePath:filePath andPayload:@""];
}


- (void)getAccessTokenWithProvider:(Provider)provider andRequestNew:(BOOL)requestNew andPayload:(NSString *)payload{
    [socialController getAccessTokenWithProvider:provider andRequestNew:requestNew andPayload:payload];
}

- (void)getContactsWithProvider:(Provider)provider andPayload:(NSString *)payload  {
    [socialController getContactsWith:provider andFromStart:false andPayload:payload];
}

- (void)getContactsWithProvider:(Provider)provider andFromStart: (bool)fromStart andPayload:(NSString *)payload  {
    [socialController getContactsWith:provider andFromStart:fromStart andPayload:payload];
}

- (void)getContactsWithProvider:(Provider)provider  {
    [self getContactsWithProvider:provider andPayload:@""];
}

- (void)getFeedWithProvider:(Provider)provider andFromStart:(bool)fromStart andPayload:(NSString *)payload  {
    [socialController getFeedProvider:provider andFromStart:false andPayload:payload];
}

- (void)getFeedWithProvider:(Provider)provider  {
    [self getFeedWithProvider:provider andFromStart:NO andPayload:@""];
}

- (void)like:(Provider)provider andPageId:(NSString *)pageId  {
    [socialController like:provider andPageId:pageId];
}

- (void)openAppRatingPage {
    NSString* templateReviewURL = @"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=APP_ID";
    NSString* appID = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"];
    NSString* reviewURL = [templateReviewURL stringByReplacingOccurrencesOfString:@"APP_ID" withString:appID];
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:reviewURL]];
    
    [ProfileEventHandling postUserRating];
}

- (BOOL)tryHandleOpenURL:(Provider)provider openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return [socialController tryHandleOpenURL:provider openURL:url sourceApplication:sourceApplication annotation:annotation];
}

- (BOOL)tryHandleOpenURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return [socialController tryHandleOpenURL:url sourceApplication:sourceApplication annotation:annotation];
}

// private

+ (SocialProfile*)getInstance {
    static SocialProfile* _instance = nil;
    
    @synchronized( self ) {
        if( _instance == nil ) {
            _instance = [[SocialProfile alloc ] init];
        }
    }
    
    return _instance;
}

@end
