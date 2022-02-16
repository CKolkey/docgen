class Doc < ApplicationRecord
  has_one_attached :file

  def build_doc(directive)
    document = DocumentBuilder.new(directive).call
    file.attach io: document, filename: 'presentation.pptx'
  end
end
