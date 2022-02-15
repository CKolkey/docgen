# frozen_string_literal: true

class DocumentBuilder
  def initialize(directive)
    @directive = directive
  end

  def call
    Dir.mktmpdir do |dir|
      File.open(File.join(dir, "directive"), "w+") { |f| f.write @directive }

      status = `documentbuilder #{File.join(dir, "directive")}  2>&1`
      debugger
    end
  end
end
