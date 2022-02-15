# frozen_string_literal: true

class Script < ApplicationRecord
  has_one_attached :doc

  after_commit :build_doc

  def build_doc
    doc.attach io: DocumentBuilder.new(text).call, filename: "testdoc"
  end
end
