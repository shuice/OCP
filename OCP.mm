#import <Foundation/Foundation.h>

NSString *sampleCode = @""
@"-NSString.subStringFromRange(range)"
@"{"
@"	if (self.length() > 0)"
@"	{"
@"		return @\"0\""
@"	}"
@"	return @\"1\";"
@"}";


typedef NS_ENUM(NSInteger, EmumWordType) 
{
	eWordTypeIdentify,
	eWordTypeNumber,
	eWordTypeString,
	eWordTypeBlank,
};

void throwException(NSString *format, ...)
{
	va_list argList;
	va_start(argList, format);
	[NSException raise:@"" format:format arguments:argList];
	va_end(argList);
}

@interface TokenBase : NSObject
@property EmumWordType wordType;
@end

@implementation TokenBase
- (NSString *)description
{
	return [NSString stringWithFormat:@"%zd", _wordType];
}
@end

@interface IdentifyToken : TokenBase
@end
@implementation IdentifyToken
@end

@interface NumberToken : TokenBase
@end
@implementation NumberToken
@end

@interface StringToken : TokenBase
@end
@implementation StringToken
@end

@interface BlankToken : TokenBase
@end
@implementation BlankToken
@end

NSArray * lexicalAnalysis(NSString *ocpCode)
{
	char validWords[255];
	memset(validWords, 0, sizeof(validWords));
	char *pszValidWords = "1234567890abcd1234567890ABCD1234567890_()<>=|&;\"\t\r\n";
	
	
	return nil;
}

int main(int argc, char *argv[]) {
	@autoreleasepool {
		@try 
		{
			int _1 = 0;
			NSLog(@"%@", lexicalAnalysis(sampleCode));
		}
		@catch (NSException *exception) 
		{
			NSLog(@"exception:%@", exception);
		} 
	}
}