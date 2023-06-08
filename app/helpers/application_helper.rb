module ApplicationHelper
  def embedded_svg(filename, options = {})
    asset_path = File.join(Rails.root, 'app', 'assets', 'images', "#{filename}.svg")
    
    if File.exist?(asset_path)
      file = File.read(asset_path)
      doc = Nokogiri::HTML::DocumentFragment.parse(file)
      svg = doc.at_css("svg")
      svg["class"] = options[:class] if options[:class].present?
    else
      doc = "<!-- SVG #{filename} not found -->"
    end

    raw doc
  end

  def active_class(path)
    if request.path == path
      return 'active'
    else
      return ''
    end
  end
end
