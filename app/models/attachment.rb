class Attachment < ActiveRecord::Base
  belongs_to :origin, polymorphic: true

  mount_uploader :data, AttachmentsUploader

  validates_presence_of :name, :data

  validate :attachment_size_validation

  scope :situation_true, -> {where(situation: true)}

  private

  def attachment_size_validation
    errors[:data] << "should be less than 3MB" if data.size > 3.megabytes
  end
end
