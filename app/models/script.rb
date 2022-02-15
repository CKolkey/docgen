require "stringio"

class Script < ApplicationRecord
  has_one_attached :doc

  after_commit :build_doc

  def build_doc
    DocumentBuilder.new(text).call

    doc.attach io: StringIO.new("Hello World"), filename: "testdoc"
  end
end
