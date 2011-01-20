require 'nokogiri'

# A nanoc filter which pre-processes a code block for a language tag.
class CodeClassifier < Nanoc3::Filter
  identifier :code_classifier
  type :text

  def run(content, params = {})
    html = Nokogiri::HTML.fragment(content)

    html.xpath("pre/code").each do |code|
      pre = code.parent

      # Set the class on the <pre>.
      append_class(pre, params[:pre_class]) if params[:pre_class]

      process_language_tag(code)
      process_caption_tag(code)
    end

    html.to_s
  end

private

  def process_language_tag(element)
    element.content = element.content.sub(/\[\s*@language\s*=\s*"([^"]+)"\s*\]/) do
      append_class(element, "language-#{$1}")
      nil
    end.strip!
  end

  def process_caption_tag(element)
    element.content = element.content.sub(/\[\s*@caption\s*=\s*"([^"]+)"\s*\]/) do
      # Wrap in a <figure>.
      figure = Nokogiri::XML::Node.new("figure", element.document)
      element.parent.add_next_sibling(figure)
      element.parent.parent = figure

      # Add a <figcaption>.
      figcaption = Nokogiri::XML::Node.new("figcaption", element.document)
      figcaption.content = $1
      element.parent.add_next_sibling(figcaption)

      nil
    end.strip!
  end

  def append_class(element, klass)
    element["class"] = ((element["class"] || "") + " " + klass).strip
  end
end
