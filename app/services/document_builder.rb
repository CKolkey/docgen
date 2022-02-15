# frozen_string_literal: true

class DocumentBuilder
  TEMPLATE = <<~TEMPLATE
    builder.CreateFile("pptx");
    #{yield}
    builder.SaveFile("pptx", "ApiChart.pptx");
    builder.CloseFile();
  TEMPLATE

  def initialize(directive)
    @directive = directive
  end

  def call
    Dir.mktmpdir do |dir|
      File.open(File.join(dir, "directive"), "w+") { |f| f.write template(File.join(dir, "presentation")) }

      status = `documentbuilder #{File.join(dir, "directive")}  2>&1`
      debugger
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
