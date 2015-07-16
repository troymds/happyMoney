
#import "HttpTool.h"
#import "AFHTTPClient.h"
#import <objc/message.h>
#import "SystemConfig.h"
#import "RemindView.h"
#import "AFHTTPRequestOperation.h"
#import "SystemConfig.h"
#import "UserItem.h"

@implementation HttpTool
+ (void)requestWithPath:(NSString *)path params:(NSDictionary *)params success:(HttpSuccessBlock)success failure:(HttpFailureBlock)failure method:(NSString *)method
{
    // 1.创建post请求
    AFHTTPClient *client = [AFHTTPClient clientWithBaseURL:[NSURL URLWithString:kUrl]];

    NSMutableDictionary *allParams = [NSMutableDictionary dictionary];
//    // 拼接传进来的参数
    if (params) {
        [allParams setDictionary:params];
    }
    NSString *time =[DateManeger getCurrentTimeStamps];
    NSString *uuid = [SystemConfig sharedInstance].uuidStr;
//    NSString *uuid = [[NSUserDefaults standardUserDefaults] objectForKey:@"uid"];

//    NSLog(@"--ssssss----%@", [SystemConfig sharedInstance].uuidStr );

    NSString *md5 = [NSString stringWithFormat:@"%@%@%@",uuid,time,@"NN4567uhv78rdfjk9ikn45yh"];
    md5 = [md5 md5Encrypt];
    NSString *ios =@"ios";
    NSString *key = @"CFBundleShortVersionString";
    // 1.从Info.plist中取出版本号
    NSString *version = [NSBundle mainBundle].infoDictionary[key];
    [allParams setObject:ios forKey:@"os"];
    [allParams setObject:time forKey:@"time"];
    [allParams setObject:uuid forKey:@"uuid"];
    [allParams setObject:md5 forKey:@"secret"];
    [allParams setObject:version forKey:@"version"];

    NSString *type = [SystemConfig sharedInstance].user.type;
    if (type) {
        [allParams setObject:type forKey:@"type"];
    }else
    {
        [allParams setObject:@"0" forKey:@"type"];
    }
//    [allParams setObject:@"0" forKey:@"type"];
    if ([SystemConfig sharedInstance].isUserLogin) {
        [allParams setObject:[SystemConfig sharedInstance].user.ID forKey:@"uid"];
    }else{
        [allParams setObject:@"0" forKey:@"uid"];
    }
    
    NSString *pathStr = [NSString stringWithFormat:@"index.php?s=/Home/Api/%@",path];
   
    NSURLRequest *request = [client requestWithMethod:method path:pathStr parameters:allParams];
    
    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        int code = [[[jsonDic objectForKey:@"response"] objectForKey:@"code"] intValue];
        success(jsonDic,code);
        NSLog(@"%@",jsonDic);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error);
    }];
    [op start];
}

+ (void)postWithPath:(NSString *)path params:(NSDictionary *)params success:(HttpSuccessBlock)success failure:(HttpFailureBlock)failure
{
    [self requestWithPath:path params:params success:success failure:failure method:@"POST"];
}

+ (void)getWithPath:(NSString *)path params:(NSDictionary *)params success:(HttpSuccessBlock)success failure:(HttpFailureBlock)failure
{

    [self requestWithPath:path params:params success:success failure:failure method:@"GET"];
}
+ (void)downloadImage:(NSString *)url place:(UIImage *)place imageView:(UIImageView *)imageView
{
    [imageView setImageWithURL:[NSURL URLWithString:url] placeholderImage:place options:SDWebImageLowPriority | SDWebImageRetryFailed];
}
@end
