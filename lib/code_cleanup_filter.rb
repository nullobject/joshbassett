class CodeCleanupFilter < Nanoc3::Filter
  require 'nokogiri'

  identifier :code_cleanup
  type :text

  def run(content, params = {})
    doc = Nokogiri::HTML.fragment(content)
    doc.css("pre > code").each do |element|
      element.content = element.content.sub(/\s*@(language-\w+)\s*/) do
        element["class"] = $1
        element.parent["class"] = "coderay"
        nil
      end.strip
    end
    doc.to_s
  end
end
