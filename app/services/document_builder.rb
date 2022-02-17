# frozen_string_literal: true

class DocumentBuilder
  def initialize(directive)
    @directive = directive
  end

  def call
    Dir.mktmpdir do |dir|
      File.open(File.join(dir, 'directive'), 'w+') { |f| f.write template(File.join(dir, 'presentation')) }
      copy_images(dir)

      status = `documentbuilder #{File.join(dir, 'directive')}  2>&1`
      raise(StandardError, status) unless status.empty?

      File.new(File.join(dir, 'presentation.pptx'))
    end
  end

  def copy_images(dest)
    FileUtils.cp_r(Rails.root.join("app", "assets", "images"), dest)
  end

  def template(filename)
    <<~TEMPLATE
      builder.CreateFile("pptx");
      #{@directive}
      builder.SaveFile("pptx", "#{filename}.pptx");
      builder.CloseFile();
    TEMPLATE
  end
end
