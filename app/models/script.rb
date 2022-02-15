require "stringio"

class Script < ApplicationRecord
  has_one_attached :doc

  after_create :build_doc

  def build_doc
    doc.attach io: StringIO.new("Hello World"), filename: "testdoc"
  end
end
