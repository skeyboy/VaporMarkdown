# VaporMarkdown

vapor [leaf](https://github.com/vapor/leaf.git) 模版引擎的Markdown标签

>1 SPM引入
```
.package(url: "https://github.com/skeyboy/VaporMarkdown.git", from: "0.0.1"),
```
>2 注册标签

```
services.register { (Container) -> (LeafTagConfig) in
var tagConfig = LeafTagConfig.default()
tagConfig.use( VaporMarkdown.init(), as: "markdown")
return tagConfig
}
```
>3 使用 markdown.leaf
```
let msg = """
# 我是一个markdown
## 我是一个副标题
> 我是一个引用
"""

#markdown(msg)

```
>4 简单测试用例
```
 func testMarkdown(){
        let markdown = "#markdown(h1)"
        let data = TemplateData.dictionary(["h1":.string("# woshi")])
        
        let result = try! renderer.testRender(markdown, data)
        
        print(result)
        XCTAssertEqual("<h1>woshi</h1>\n", result)
    }
```


