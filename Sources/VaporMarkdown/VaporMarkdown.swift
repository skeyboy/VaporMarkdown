import TemplateKit
import SKCmark
//struct VaporMarkdown {
//    var text = "Hello, World!"
//}
final class VaporMarkdown: TagRenderer {
    func render(tag: TagContext) throws -> EventLoopFuture<TemplateData> {
        if tag.parameters.count == 0 {
            return tag.container.future(.string(""))
        }else{
            let value = tag.parameters.first?.string ?? ""
           let markdown = try!  skMarkdownToHTML(value)
            return tag.container.future(.string(markdown))

        }
    }

}
