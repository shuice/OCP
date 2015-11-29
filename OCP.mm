#import <Foundation/Foundation.h>


@interface GlobalStatus : NSObject
@property int status;
@property NSMutableString *cachedString;
@property NSMutableString *scanedString;
@end

@implementation GlobalStatus
- (instancetype)init
{
    self = [super init];
    if (self)
    {
        _status = 1;
        _cachedString = [NSMutableString string];
        _scanedString = [NSMutableString string];
    }
    return self;
}
@end

typedef NS_ENUM(int, EnumWordType)
{
    eWordTypeIdentify,
    eWordTypeNumber,
    eWordTypeString,
    eWordTypeComment,
    eWordTypeBlank,
};

#define END_OF_FILE '\03'

static BOOL ScanNext(GlobalStatus* sGlobalState, unichar c);
static BOOL ScanNext_1(GlobalStatus* sGlobalState, unichar c);
static BOOL ScanNext_4(GlobalStatus* sGlobalState, unichar c);
static BOOL ScanNext_5(GlobalStatus* sGlobalState, unichar c);
static BOOL ScanNext_6(GlobalStatus* sGlobalState, unichar c);
static BOOL ScanNext_7(GlobalStatus* sGlobalState, unichar c);
static BOOL ScanNext_8(GlobalStatus* sGlobalState, unichar c);
static BOOL ScanNext_9(GlobalStatus* sGlobalState, unichar c);
static BOOL ScanNext_10(GlobalStatus* sGlobalState, unichar c);
static BOOL ScanNext_11(GlobalStatus* sGlobalState, unichar c);
static BOOL ScanNext_12(GlobalStatus* sGlobalState, unichar c);
static BOOL ScanNext_13(GlobalStatus* sGlobalState, unichar c);
static BOOL ScanNext_14(GlobalStatus* sGlobalState, unichar c);
static BOOL ScanNext_15(GlobalStatus* sGlobalState, unichar c);

static void Output(GlobalStatus* sGlobalState, EnumWordType eWordType, BOOL pop);
static void Error(NSString *format, ...);
static void ChangeStatus(GlobalStatus* sGlobalState, int status);

static BOOL IsBlank(unichar c)
{
    if (('\r' == c) || ('\n' == c) || ('\t' == c) || (' ' == c))
    {
        return YES;
    }
    return NO;
}

static BOOL Is0_9(unichar c)
{
    if ((c >= '0') && (c <= '9'))
    {
        return YES;
    }
    return NO;
}

static BOOL Is1_9(unichar c)
{
    if ((c >= '1') && (c <= '9'))
    {
        return YES;
    }
    return NO;
}

static BOOL Isa_zA_Z(unichar c)
{
    if ((c >= 'a') && (c <= 'z'))
    {
        return YES;
    }
    if ((c >= 'A') && (c <= 'Z'))
    {
        return YES;
    }
    return NO;
}

static BOOL IsOneOf(unichar c, const char *content)
{
    if (NULL == content)
    {
        return NO;
    }
    return (NULL != strchr(content, c));
}

static BOOL IsEndOfFile(unichar c)
{
    if (END_OF_FILE == c)
    {
        return YES;
    }
    return NO;
}


BOOL ScanNext(GlobalStatus* sGlobalState, unichar c)
{
    BOOL poped = NO;
    if ((c < 0) || (c > 255))
    {
        return poped;
    }
    
    [sGlobalState.cachedString appendFormat:@"%c", c];
    [sGlobalState.scanedString appendFormat:@"%c", c];
    
    if (1 == sGlobalState.status)
    {
        poped = ScanNext_1(sGlobalState, c);
    }
    else if (4 == sGlobalState.status)
    {
        poped = ScanNext_4(sGlobalState, c);
    }
    else if (5 == sGlobalState.status)
    {
        poped = ScanNext_5(sGlobalState, c);
    }
    else if (6 == sGlobalState.status)
    {
        poped = ScanNext_6(sGlobalState, c);
    }
    else if (7 == sGlobalState.status)
    {
        poped = ScanNext_7(sGlobalState, c);
    }
    else if (8 == sGlobalState.status)
    {
        poped = ScanNext_8(sGlobalState, c);
    }
    else if (9 == sGlobalState.status)
    {
        poped = ScanNext_9(sGlobalState, c);
    }
    else if (10 == sGlobalState.status)
    {
        poped = ScanNext_10(sGlobalState, c);
    }
    else if (11 == sGlobalState.status)
    {
        poped = ScanNext_11(sGlobalState, c);
    }
    else if (12 == sGlobalState.status)
    {
        poped = ScanNext_12(sGlobalState, c);
    }
    else if (13 == sGlobalState.status)
    {
        poped = ScanNext_13(sGlobalState, c);
    }
    else if (14 == sGlobalState.status)
    {
        poped = ScanNext_14(sGlobalState, c);
    }
    else if (15 == sGlobalState.status)
    {
        poped = ScanNext_15(sGlobalState, c);
    }
    else
    {
        Error(@"Bad status:%d", sGlobalState.status);
    }
    return poped;
}



BOOL ScanNext_1(GlobalStatus* sGlobalState, unichar c)
{
    BOOL pop = NO;
    if (IsBlank(c))
    {
        Output(sGlobalState, eWordTypeIdentify, NO);
    }
    else if (IsOneOf(c, "{};()+_*-."))
    {
        Output(sGlobalState, eWordTypeIdentify, NO);
    }
    else if (c == '/')
    {
        ChangeStatus(sGlobalState, 4);
    }
    else if (c == '&')
    {
        ChangeStatus(sGlobalState, 6);
    }
    else if (c == '\"')
    {
        ChangeStatus(sGlobalState, 9);
    }
    else if (c == '0')
    {
        ChangeStatus(sGlobalState, 11);
    }
    else if (Is1_9(c))
    {
        ChangeStatus(sGlobalState, 13);
    }
    else if (Isa_zA_Z(c) || '_' == c)
    {
        ChangeStatus(sGlobalState, 15);
    }
    else if (END_OF_FILE == c)
    {
        NSLog(@"Finish");
    }
    else if ('|' == c)
    {
        ChangeStatus(sGlobalState, 7);
    }
    else if (IsOneOf(c, "<>="))
    {
        ChangeStatus(sGlobalState, 8);
    }
    else
    {
        Error(@"%@", [NSString stringWithFormat:@"%s, %d", __FUNCTION__, __LINE__]);;
    }
    return pop;
}

BOOL ScanNext_4(GlobalStatus* sGlobalState, unichar c)
{
    BOOL pop = NO;
    if ('/' == c)
    {
        ChangeStatus(sGlobalState, 5);
    }
    else if (Is0_9(c) || Isa_zA_Z(c) || IsBlank(c) || IsEndOfFile(c))
    {
        Output(sGlobalState, eWordTypeIdentify, YES);
        pop = YES;
    }
    else
    {
        Error(@"%@", [NSString stringWithFormat:@"%s, %d", __FUNCTION__, __LINE__]);
    }
    return pop;
}

BOOL ScanNext_5(GlobalStatus* sGlobalState, unichar c)
{
    BOOL pop = NO;
    if (('\n' == c) || IsEndOfFile(c))
    {
        Output(sGlobalState, eWordTypeComment, YES);
        pop = YES;
    }
    else
    {
        ChangeStatus(sGlobalState, 5);
    }
    return pop;
}

BOOL ScanNext_6(GlobalStatus* sGlobalState, unichar c)
{
    BOOL pop = NO;
    if ('&' == c)
    {
        Output(sGlobalState, eWordTypeIdentify, NO);
    }
    else
    {
        Error(@"%@", [NSString stringWithFormat:@"%s, %d", __FUNCTION__, __LINE__]);
    }
    return pop;
}

BOOL ScanNext_7(GlobalStatus* sGlobalState, unichar c)
{
    BOOL pop = NO;
    if ('|' == c)
    {
        Output(sGlobalState, eWordTypeIdentify, NO);
    }
    else
    {
        Error(@"%@", [NSString stringWithFormat:@"%s, %d", __FUNCTION__, __LINE__]);
    }
    return pop;
}

BOOL ScanNext_8(GlobalStatus* sGlobalState, unichar c)
{
    BOOL pop = NO;
    if ('=' == c)
    {
        Output(sGlobalState, eWordTypeIdentify, NO);
    }
    else
    {
        Output(sGlobalState, eWordTypeIdentify, YES);
        pop = YES;
    }
    return pop;
}

BOOL ScanNext_9(GlobalStatus* sGlobalState, unichar c)
{
    BOOL pop = NO;
    if ('\\' == c)
    {
        ChangeStatus(sGlobalState, 10);
    }
    else if ('\"' == c)
    {
        Output(sGlobalState, eWordTypeString, NO);
    }
    else if (NO == IsEndOfFile(c))
    {
        ChangeStatus(sGlobalState, 9);
    }
    else
    {
        Error(@"%@", [NSString stringWithFormat:@"%s, %d", __FUNCTION__, __LINE__]);
    }
    return pop;
}

BOOL ScanNext_10(GlobalStatus* sGlobalState, unichar c)
{
    BOOL pop = NO;
    if (IsBlank(c))
    {
        ChangeStatus(sGlobalState, 9);
    }
    else
    {
        Error(@"%@", [NSString stringWithFormat:@"%s, %d", __FUNCTION__, __LINE__]);
    }
    return pop;
}

BOOL ScanNext_11(GlobalStatus* sGlobalState, unichar c)
{
    BOOL pop = NO;
    if (IsOneOf(c, "<>=|&;()") || IsBlank(c) || IsEndOfFile(c))
    {
        Output(sGlobalState, eWordTypeNumber, YES);
        pop = YES;
    }
    else if ('.' == c)
    {
        ChangeStatus(sGlobalState, 12);
    }
    else
    {
        Error(@"%@", [NSString stringWithFormat:@"%s, %d", __FUNCTION__, __LINE__]);
    }
    return pop;
}

BOOL ScanNext_12(GlobalStatus* sGlobalState, unichar c)
{
    BOOL pop = NO;
    if (IsOneOf(c, "<>=|&;") || IsBlank(c) || IsEndOfFile(c))
    {
        Output(sGlobalState, eWordTypeNumber, YES);
        pop = YES;
    }
    else if (Is0_9(c))
    {
        ChangeStatus(sGlobalState, 14);
    }
    else
    {
        Error(@"%@", [NSString stringWithFormat:@"%s, %d", __FUNCTION__, __LINE__]);
    }
    return pop;
}

BOOL ScanNext_13(GlobalStatus* sGlobalState, unichar c)
{
    BOOL pop = NO;
    if (Is1_9(c))
    {
        ChangeStatus(sGlobalState, 13);
    }
    else if (IsOneOf(c, "<>=|&;") || IsBlank(c) || IsEndOfFile(c))
    {
        Output(sGlobalState, eWordTypeNumber, YES);
        pop = YES;
    }
    else if ('.' == c)
    {
        ChangeStatus(sGlobalState, 14);
    }
    else
    {
        Error(@"%@", [NSString stringWithFormat:@"%s, %d", __FUNCTION__, __LINE__]);
    }
    return pop;
}

BOOL ScanNext_14(GlobalStatus* sGlobalState, unichar c)
{
    BOOL pop = NO;
    if (Is0_9(c))
    {
        ChangeStatus(sGlobalState, 14);
    }
    else if (IsOneOf(c, "<>=|&;") || IsBlank(c) || IsEndOfFile(c))
    {
        Output(sGlobalState, eWordTypeNumber, YES);
        pop = YES;
    }
    else
    {
        Error(@"%@", [NSString stringWithFormat:@"%s, %d", __FUNCTION__, __LINE__]);
    }
    return pop;
}

BOOL ScanNext_15(GlobalStatus* sGlobalState, unichar c)
{
    BOOL pop = NO;
    if (IsOneOf(c, "<>=|&;.()") || IsBlank(c) || IsEndOfFile(c))
    {
        Output(sGlobalState, eWordTypeIdentify, YES);
        pop = YES;
    }
    else if (Isa_zA_Z(c) || Is0_9(c) || ('_' == c))
    {
        ChangeStatus(sGlobalState, 15);
    }
    else
    {
        Error(@"%@", [NSString stringWithFormat:@"%s, %d", __FUNCTION__, __LINE__]);
    }
    return pop;
}


static void Output(GlobalStatus* sGlobalState, EnumWordType eWordType, BOOL pop)
{
    NSString *name = pop ? [sGlobalState.cachedString substringToIndex:sGlobalState.cachedString.length-1] : sGlobalState.cachedString;
    NSLog(@"output:type:%d,content:%@", eWordType, name);
    sGlobalState.cachedString = [NSMutableString string];
    ChangeStatus(sGlobalState, 1);
}

static void ChangeStatus(GlobalStatus* sGlobalState, int status)
{
    if (status != sGlobalState.status)
    {
        //NSLog(@"[Status]:%d:%@", status, sGlobalState.scanedString);
    }
    sGlobalState.status = status;
}

void Error(NSString *format, ...)
{
    va_list argList;
    va_start(argList, format);
    [NSException raise:@"" format:format arguments:argList];
    va_end(argList);
}


NSString *sampleCode = @""
@"-NSString.subStringFromRange(range)"
@"{"
@"	if (self.length() > 0)"
@"	{"
@"		return \"0\""
@"	}"
@"	return 0.41;"
@"}";

int main(int argc, char *argv[])
{
    @autoreleasepool {
        GlobalStatus *status = [[GlobalStatus alloc] init];
        status.status = 1;
        
        @try
        {
            int length = (int)sampleCode.length;
            for (int index = 0; index < length; index ++)
            {
                unichar c = [sampleCode characterAtIndex:index];
                if (ScanNext(status, c))
                {
                    index --;
                }
            }
            ScanNext(status, END_OF_FILE);
        }
        @catch (NSException *exception)
        {
            NSLog(@"exception:%@", exception);
        }
    }
}