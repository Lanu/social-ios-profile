//
//  TokenProvider.h
//  SocialiOSProfile
//
//  Created by Banu on 18/08/15.
//  Copyright (c) 2015 AIM Productions. All rights reserved.
//

#import "UserProfileUtils.h"

/**
 A domain object that represents the TokenProvider attributes.
 */
@interface TokenProvider : NSObject {
    
@private
    
    Provider provider;
    NSString* accessToken;
}

@property (readonly, nonatomic) Provider provider;
@property (strong, nonatomic) NSString* accessToken;

/**
 Constructor
 
 @param oProvider the provider which the TokenProvider is associated to
 @param oProfileId the profile ID for the given provider
 @param oAccessToken the access token given by the provider
 */
- (id)initWithProvider:(Provider)oProvider
           andAccessToken:(NSString *)oAccessToken;

/**
 Constructor
 
 @param dict An `NSDictionary` representation of the `TokenProvider.`
 */
- (id)initWithDictionary:(NSDictionary *)dict;

/**
 Converts the current `TokenProvider` to an `NSDictionary`.
 
 @return This instance of `TokenProvider` as an `NSDictionary`.
 */
- (NSDictionary*)toDictionary;

@end
