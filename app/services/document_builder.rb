# frozen_string_literal: true

class DocumentBuilder
  def initialize(directive)
    @directive = directive
  end

  def call
    Dir.mktmpdir do |dir|
      File.open(File.join(dir, 'directive'), 'w+') { |f| f.write template(File.join(dir, 'presentation')) }

      # status = `documentbuilder #{File.join(dir, 'directive')}  2>&1`
      # raise(StandardError, status) unless status.empty?

      # File.new(File.join(dir, 'presentation.pptx'))
      nil
    end
  end

  def encoded_platform_icons
    Dir[Rails.root.join("app", "assets", "images", "*.png")].map do |file|
      encoded = Base64.strict_encode64(File.read(file))
      var_name = File.basename(file, ".*").underscore.camelize
      "#{var_name} = \"data:image/png;base64,#{encoded}\";"
    end.join("\n")
  end

  def template(filename)
    <<~TEMPLATE
      builder.CreateFile("pptx");
      #{encoded_platform_icons}
      #{@directive}
      builder.SaveFile("pptx", "#{filename}.pptx");
      builder.CloseFile();
    TEMPLATE
  end
end
