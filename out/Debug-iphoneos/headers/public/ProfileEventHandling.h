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
@class TokenProvider;
// Events
#define EVENT_UP_PROFILE_INITIALIZED            @"up_profile_initialized"

#define EVENT_UP_USER_PROFILE_UPDATED           @"up_user_profile_updated"
#define EVENT_UP_TOKEN_PROVIDER_UPDATED         @"up_token_provider_updated"

#define EVENT_UP_LOGIN_STARTED                  @"up_login_started"
#define EVENT_UP_LOGIN_FINISHED                 @"up_login_finished"
#define EVENT_UP_LOGIN_FAILED                   @"up_login_failed"
#define EVENT_UP_LOGIN_CANCELLED                @"up_login_cancelled"

#define EVENT_UP_LOGOUT_STARTED                 @"up_logout_started"
#define EVENT_UP_LOGOUT_FINISHED                @"up_logout_finished"
#define EVENT_UP_LOGOUT_FAILED                  @"up_logout_failed"

#define EVENT_UP_GET_ACCESSTOKEN_STARTED        @"up_get_accesstoken_started"
#define EVENT_UP_GET_ACCESSTOKEN_FINISHED       @"up_get_accesstoken_finished"
#define EVENT_UP_GET_ACCESSTOKEN_FAILED         @"up_get_accesstoken_failed"
#define EVENT_UP_GET_ACCESSTOKEN_CANCELLED      @"up_get_accesstoken_cancelled"

// UserProfile Elements
#define DICT_ELEMENT_USER_PROFILE               @"userProfile"
#define DICT_ELEMENT_PROVIDER                   @"provider"
#define DICT_ELEMENT_FROM_START                 @"fromStart"
#define DICT_ELEMENT_PAYLOAD                    @"payload"
#define DICT_ELEMENT_HAS_MORE                   @"hasMore"
#define DICT_ELEMENT_MESSAGE                    @"message"
#define DICT_ELEMENT_ACCESSTOKEN                @"accessToken"
#define DICT_ELEMENT_TOKEN_PROVIDER             @"tokenProvider"

/**
 * This class is used to register and post all the supported profile events.
 * Use this class to invoke events on handlers when they occur.
 *
 * SOCIAL uses iOS's `NSNotificationCenter` to handle events across the SDK.
 */
@interface ProfileEventHandling : NSObject

/**
 Subscribes the provider observer to all the profile events at once, 
 the supplied selector will be called when any of the events fired
 
 @param observer the subscriber to the events
 @param selector the selector to call on the observer when events are fired
 */
+ (void)observeAllEventsWithObserver:(id)observer withSelector:(SEL)selector;

/**
Called when the service has been initializedt.
*/
+ (void)postProfileInitialized;

/**
 Called when a user profile from a provider has been retrieved
 and updated in the device's local storage. Which fires the 
 `EVENT_UP_USER_PROFILE_UPDATED` event.
 
 @param userProfile The user's profile which was updated
 */
+ (void)postUserProfileUpdated:(UserProfile *)userProfile;

/**
 Called when a token provider from a provider has been retrieved
 and updated in the device's local storage. Which fires the
 `EVENT_UP_TOKEN_PROVIDER_UPDATED` event.
 
 @param tokenProvider The token provider which was updated
 */
+ (void)postTokenProviderUpdated:(TokenProvider *)tokenProvider;

/**
 Called when the login process to a provider has started. Which fires the
 `EVENT_UP_LOGIN_STARTED` event.
 
 @param provider The provider on where the login has started
 */
+ (void)postLoginStarted:(Provider)provider withPayload:(NSString *)payload;

/**
 Called when the login process finishes successfully. Which fires the
 `EVENT_UP_LOGIN_FINISHED` event.
 
 @param userProfile The user's profile from the logged in provider
 */
+ (void)postLoginFinished:(UserProfile *)userProfile withPayload:(NSString *)payload;

/**
 Called when the login process to a provider has failed. Which fires the
 `EVENT_UP_LOGIN_FAILED` event.
 
 @param provider The provider on which the login has failed
 @param message a Description of the reason for failure
 */
+ (void)postLoginFailed:(Provider)provider withMessage:(NSString *)message withPayload:(NSString *)payload;

/**
 Called the login process to a provider has been cancelled. Which fires the
 `EVENT_UP_LOGIN_CANCELLED` event.
 
 @param provider The provider on which the login has failed
 */
+ (void)postLoginCancelled:(Provider)provider withPayload:(NSString *)payload;

/**
 Called when the logout process from a provider has started. Which fires the
 `EVENT_UP_LOGOUT_STARTED` event.
 
 @param provider The provider on which the login has started.
 */
+ (void)postLogoutStarted:(Provider)provider;

/**
 Called when the logout process from a provider has finished. Which fires the
 `EVENT_UP_LOGOUT_FINISHED` event.
 
 @param provider The provider on which the logout has finished
 */
+ (void)postLogoutFinished:(Provider)provider;

/**
 Called when the logout process from a provider has failed. Which fires the
 `EVENT_UP_LOGOUT_FAILED` event.
 
 @param provider The provider on which the logout has failed
 @param message a Description of the reason for failure
 */
+ (void)postLogoutFailed:(Provider)provider withMessage:(NSString *)message;

/**
 Called when the get access token process from a provider has started. Which fires the
 `EVENT_UP_GET_ACCESSTOKEN_STARTED` event.
 
 @param provider The provider on where the access token has started
 */
+ (void)postGetAccessTokenStarted:(Provider)provider withPayload:(NSString *)payload;

/**
 Called when the get access token finished. Which fires the
 `EVENT_UP_GET_ACCESSTOKEN_FINISHED` event.
 
 @param provider The provider on which the access token has finished
 @param accessToken the access token
 */
+ (void)postGetAccessTokenFinished:(Provider)provider withAccessToken:(NSString *)accessToken withPayload:(NSString *)payload;

/**
 Called when the get access token process from a provider has failed. Which fires the
 `EVENT_UP_GET_ACCESSTOKEN_FAILED` event.
 
 @param provider The provider on which the access token has failed
 @param message a Description of the reason for failure
 */
+ (void)postGetAccessTokenFailed:(Provider)provider withMessage:(NSString *)message withPayload:(NSString *)payload;

/**
 Called when the get access token process has been cancelled. Which fires the
 `EVENT_UP_GET_ACCESSTOKEN_CANCELLED` event.
 
 @param provider The provider on which the access token has failed
 */
+ (void)postGetAccessTokenCancelled:(Provider)provider withPayload:(NSString *)payload;
@end
