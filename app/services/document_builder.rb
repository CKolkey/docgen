# frozen_string_literal: true

class DocumentBuilder
  def initialize(directive)
    @directive = directive
  end

  def call
    Dir.mktmpdir do |dir|
      File.open(File.join(dir, 'directive'), 'w+') { |f| f.write template(File.join(dir, 'presentation')) }

      status = `documentbuilder #{File.join(dir, 'directive')}  2>&1`
      raise NotImplementedError unless status.empty?

      File.new(File.join(dir, 'presentation.pptx'))
    end
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
