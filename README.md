# JSPatch-IOS
一款 基于JSPatch的iOS开源库，用于修改当前线上版本的Object-C代码

> [配套Java版轻量级服务端传送门](https://github.com/sunzsh/JSPatchServer4J)

##  集成
* 下载完整工具包，并全部导入
* 引入框架JavaScriptCore.framework
* 引入JSPatch类库

##  说明文档
* 打开 `CommonParameters.h` 文件，设置服务器路径等相关参数

* 在 `AppDelegate didFinishLaunchingWithOptions:` 中调用：

``` Objective-C
[DynamicChangeCode loadURLConnectionCompletion]
```
  
