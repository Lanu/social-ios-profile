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

#import "UserProfileUtils.h"

@class UserProfile;
@class AuthController;
@class SocialController;

/**
 This is the main class for the SOCIAL User Profile module.  This class should be initialized once,
 after <code>Soomla.initialize()</code> is invoked.  Use this class to perform authentication and social
 actions on behalf of the user that will grant him \ her rewards in your game.
 */
@interface SocialProfile : NSObject {

    @private
    AuthController* authController;
    SocialController* socialController;
}

+ (void)usingExternalProvider:(BOOL)isExternal;
+ (BOOL)isUsingExternalProvider;

/**
 Constructor.

 Initializes the Profile module.  Call this method after <code>Soomla.initialize()</code>
 */
- (void)initialize;

/**
 Constructor.

 Initializes the Profile module.  Call this method after <code>Soomla.initialize()</code>
 @param customParams provides custom values for specific social providers
 */
- (void)initialize:(NSDictionary *)customParams;

/**
 Login to the given provider

 @param provider The provider to use
 */
- (void)loginWithProvider:(Provider)provider;


/**
 Login to the given provider .

 @param provider The provider to use
 @param payload a String to receive when the function returns.
 */
- (void)loginWithProvider:(Provider)provider andPayload:(NSString *)payload;

/**
 Logout of the given provider

 @param provider The provider to use
 */
- (void)logoutWithProvider:(Provider)provider;

/**
 Checks if the user is logged in with given provider

 @param provider The provider to use
 @return YES if the user is logged-in with the given provider, NO otherwise
 */
- (BOOL)isLoggedInWithProvider:(Provider)provider;


/**
 Fetches the acces token.
 
 @param provider The provider to use
 @param requestNew True to try get a new token, false to try get a cached token
 @param payload a String to receive when the function returns.
 */
- (void)getAccessTokenWithProvider:(Provider)provider andRequestNew:(BOOL)requestNew andPayload:(NSString *)payload;


/**
 Fetches the user's profile for the given provider from the local device storage

 @param provider The provider to use
 @return The user profile
 */
- (UserProfile *)getStoredUserProfileWithProvider:(Provider)provider;

/**
 Retrives user profiles which are stored on the device

 @return an Array of `UserProfile`s which have been stored on the device
 */
- (NSArray *)getStoredUserProfiles;

/**
 Shares the given status to the user's feed .

 @param provider The provider to use
 @param status The text to share
 @param payload a String to receive when the function returns.
 */
- (void)updateStatusWithProvider:(Provider)provider andStatus:(NSString *)status andPayload:(NSString *)payload;

/**
 Shares the given status to the user's feed .

 @param provider The provider to use
 @param status The text to share
 */
- (void)updateStatusWithProvider:(Provider)provider andStatus:(NSString *)status;

/**
 Shares the given status and link to the user's feed using the provider's
 native dialog (when available)

 @param provider the provider to use
 @param link the link to share (could be nil when not needed)
 @param payload a String to receive when the function returns.
 @exception ProviderNotFoundException if the provider is not supported
 */
- (void)updateStatusWithProviderDialog:(Provider)provider andLink:(NSString *)link andPayload:(NSString *)payload;

/**
 Shares the given status and link to the user's feed using the provider's
 native dialog (when available)

 @param provider the provider to use
 @param link the link to share (could be nil when not needed)
 @exception ProviderNotFoundException if the provider is not supported
 */
- (void)updateStatusWithProviderDialog:(Provider)provider andLink:(NSString *)link;

/**
 Shares a story to the user's feed .

 @param provider The provider to use
 @param message The main text which will appear in the story
 @param name The headline for the link which will be integrated in the
 story
 @param caption The sub-headline for the link which will be
 integrated in the story
 @param description The description for the link which will be
 integrated in the story
 @param link The link which will be integrated into the user's story
 @param picture a Link to a picture which will be featured in the link
 @param payload a String to receive when the function returns.
 */
- (void)updateStoryWithProvider:(Provider)provider
                     andMessage:(NSString *)message
                        andName:(NSString *)name
                     andCaption:(NSString *)caption
                 andDescription:(NSString *)description
                        andLink:(NSString *)link
                     andPicture:(NSString *)picture
                     andPayload:(NSString *)payload;

/**
 Shares a story to the user's feed .

 @param provider The provider to use
 @param message The main text which will appear in the story
 @param name The headline for the link which will be integrated in the
 story
 @param caption The sub-headline for the link which will be
 integrated in the story
 @param description The description for the link which will be
 integrated in the story
 @param link The link which will be integrated into the user's story
 @param picture a Link to a picture which will be featured in the link
 */
- (void)updateStoryWithProvider:(Provider)provider
                     andMessage:(NSString *)message
                        andName:(NSString *)name
                     andCaption:(NSString *)caption
                 andDescription:(NSString *)description
                        andLink:(NSString *)link
                     andPicture:(NSString *)picture;

/**
 Shares a story to the user's feed , using the
 provider's native dialog (when available)

 @param provider The provider to use
 @param name The headline for the link which will be integrated in the
 story
 @param caption The sub-headline for the link which will be
 integrated in the story
 @param description The description for the link which will be
 integrated in the story
 @param link The link which will be integrated into the user's story
 @param picture a Link to a picture which will be featured in the link
 @param payload a String to receive when the function returns.
 */
- (void)updateStoryWithProviderDialog:(Provider)provider
                        andName:(NSString *)name
                     andCaption:(NSString *)caption
                 andDescription:(NSString *)description
                        andLink:(NSString *)link
                     andPicture:(NSString *)picture
                     andPayload:(NSString *)payload;

/**
 Shares a story to the user's feed , using the
 provider's native dialog (when available)

 @param provider The provider to use
 @param name The headline for the link which will be integrated in the
 story
 @param caption The sub-headline for the link which will be
 integrated in the story
 @param description The description for the link which will be
 integrated in the story
 @param link The link which will be integrated into the user's story
 @param picture a Link to a picture which will be featured in the link
 */
- (void)updateStoryWithProviderDialog:(Provider)provider
                              andName:(NSString *)name
                           andCaption:(NSString *)caption
                       andDescription:(NSString *)description
                              andLink:(NSString *)link
                           andPicture:(NSString *)picture;

/**
 Shares a photo to the user's feed .

 @param provider The provider to use
 @param message A text that will accompany the image
 @param filePath The desired image's location on the device
 @param payload a String to receive when the function returns.
 */
- (void)uploadImageWithProvider:(Provider)provider
                   andMessage:(NSString *)message
                   andFilePath:(NSString *)filePath
                    andPayload:(NSString *)payload;

/**
 Shares a photo using image data to the user's feed .

 @param provider The provider to use
 @param message A text that will accompany the image
 @param fielName The desired image's name
 @param imageData The desired image's data
 @param payload a String to receive when the function returns.
 */
- (void)uploadImageWithProvider:(Provider)provider
                     andMessage:(NSString *)message
               andImageFileName: (NSString *)fileName
                   andImageData:(NSData *)imageData
                     andPayload:(NSString *)payload;

/**
 Shares a photo to the user's feed .

 @param provider The provider to use
 @param message A text that will accompany the image
 @param filePath The desired image's location on the device
 */
- (void)uploadImageWithProvider:(Provider)provider
                     andMessage:(NSString *)message
                    andFilePath:(NSString *)filePath;


/**
 Fetches the user's contact list .

 @param provider The provider to use
 @param payload a String to receive when the function returns.
 */
- (void)getContactsWithProvider:(Provider)provider andPayload:(NSString *)payload;

/**
 Fetches the user's contact list .

 @param provider The provider to use
 @param fromStart Should we reset pagination or request the next page
 @param payload a String to receive when the function returns.
 */
- (void)getContactsWithProvider:(Provider)provider andFromStart: (bool)fromStart andPayload:(NSString *)payload;

/**
 Fetches the user's contact list .

 @param provider The provider to use
 */
- (void)getContactsWithProvider:(Provider)provider;

/**
Fetches the user's feed .

 @param provider The provider to use
 @param payload a String to receive when the function returns.
*/
- (void)getFeedWithProvider:(Provider)provider andFromStart:(bool)fromStart andPayload:(NSString *)payload;

/**
 Fetches the user's feed .

 @param provider The provider to use
 */
- (void)getFeedWithProvider:(Provider)provider;

/**
 Opens up a page to like for the user (external)

 @param provider The provider to like page on
 @param pageId The page to open on the provider
 */
- (void)like:(Provider)provider andPageId:(NSString *)pageId;

/**
 Utility method to open up the market application rating page
 */
- (void)openAppRatingPage;

/**
 Helper method to assist with browser-based authentication using a sepcific
 underlying authentication provider.

 @param provider The provider to handle open URL
 @param url The URL which caused the application to launch and receive a
 callback
 @param sourceApplication The bundle ID of the app that is requesting your app
 to open the URL (url).
 @param annotation A property list object supplied by the source app to
 communicate information to the receiving app.

 @return YES if the provider was able to handle the URL, NO otherwise
 */
- (BOOL)tryHandleOpenURL:(Provider)provider openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation;

/**
 Helper method to assist with browser-based authentication using some underlying
 authentication providers.

 @param url The URL which caused the application to launch and receive a
 callback
 @param sourceApplication The bundle ID of the app that is requesting your app
 to open the URL (url).
 @param annotation A property list object supplied by the source app to
 communicate information to the receiving app.

 @return YES if a provider was able to handle the URL, NO otherwise
 */
- (BOOL)tryHandleOpenURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation;

/**
 Retrieves the singleton instance of `SocialProfile`
 @return the singleton instance of `SocialProfile`
 */
+ (SocialProfile *)getInstance;

@end
