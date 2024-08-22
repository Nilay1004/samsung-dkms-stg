# frozen_string_literal: true

# This code ensures that email addresses in the skipped_email_logs table are encrypted before saving and decrypted when accessed.

module SamsungDkms::SkippedEmailLogPatch

  def to_address
    @decrypted_to_address ||= PIIEncryption.decrypt_email(read_attribute(:to_address))
  end

  def to_address=(value)
    @decrypted_to_address = value
    encrypted_to_address = PIIEncryption.encrypt_email(value)
    write_attribute(:to_address, encrypted_to_address)
  end
end
