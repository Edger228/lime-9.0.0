#include <system/Locale.h>
#include <string>

namespace lime {

std::string* Locale::GetSystemLocale () {

#if defined(HX_IOS) || defined(HX_MACOS)
    #ifndef OBJC_ARC
    NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];
    #endif

    NSString* localeLanguage = [[NSLocale preferredLanguages] firstObject];
    if (localeLanguage == nil) localeLanguage = @"en";

    NSString* localeRegion = nil;
    NSLocale* currentLocale = [NSLocale autoupdatingCurrentLocale];
    if (currentLocale == nil || ![currentLocale respondsToSelector:@selector(countryCode)]) {
        localeRegion = @"";
    } else {
        localeRegion = [currentLocale countryCode];
    }

    NSString* locale = localeLanguage;
    if (localeRegion != nil) {
        locale = [[localeLanguage stringByAppendingString:@"_"] stringByAppendingString:localeRegion];
    }

    std::string* result = new std::string([locale UTF8String]);

    #ifndef OBJC_ARC
    [pool drain];
    #endif

    return result;

#else

    return new std::string("en_US");
#endif

}

}
