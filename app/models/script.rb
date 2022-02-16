# frozen_string_literal: true

class Script < ApplicationRecord
  has_one_attached :doc

  def build_doc
    doc.attach io: DocumentBuilder.new(text).call, filename: 'presentation.pptx'
  end
end
