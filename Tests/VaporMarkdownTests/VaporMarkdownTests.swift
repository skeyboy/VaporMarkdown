import Foundation
import Async
import Dispatch
import Leaf
import Service
import XCTest
@testable import VaporMarkdown

final class VaporMarkdownTests: XCTestCase {
    var renderer: LeafRenderer!
    
    override func setUp() {
        
        let   services: Services = Services.init()
        
       /*
        services.register { (Container) -> (LeafTagConfig) in
            var tagConfig = LeafTagConfig.default()
            tagConfig.use( VaporMarkdown.init(), as: "markdown")
            return tagConfig
        }
        */
        
        let container = BasicContainer(config: .init(), environment: .testing, services: services, on: EmbeddedEventLoop())
        
        let viewsDir = "/" + #file.split(separator: "/").dropLast(3).joined(separator: "/").finished(with: "/Views/")
        
        var tagConfig = LeafTagConfig.default()
        tagConfig.use( VaporMarkdown.init(), as: "markdown")
        
        let config = LeafConfig(tags: tagConfig, viewsDir: viewsDir, shouldCache: false)
        self.renderer = LeafRenderer(config: config, using: container)
    }
    
    
    func testMarkdown(){
        let markdown = "#markdown(h1)"
        let data = TemplateData.dictionary(["h1":.string("# woshi")])
        
        let result = try! renderer.testRender(markdown, data)
        
        print(result)
        XCTAssertEqual("<h1>woshi</h1>\n", result)
    }
    func testComplex(){
        let readme = "/" + #file.split(separator: "/").dropLast(3).joined(separator: "/").finished(with: "/README.md")
        let value =  try! String.init(contentsOfFile: readme)
        let markdown = "#markdown(msg)"
        let data = TemplateData.dictionary(["msg":.string(value)])

        let result = try! renderer.testRender(markdown, data)
        
        print(result)


    }
}

extension TemplateRenderer {
    func testRender(_ template: String, _ context: TemplateData = .null) throws -> String {
        let view = try self.render(template: template.data(using: .utf8)!, context).wait()
        return String(data: view.data, encoding: .utf8)!
    }
}
