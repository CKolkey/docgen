class Doc < ApplicationRecord
  has_one_attached :file

  def build_doc(directive)
    file.attach io: DocumentBuilder.new(directive).call, filename: 'presentation.pptx'
  end
end
