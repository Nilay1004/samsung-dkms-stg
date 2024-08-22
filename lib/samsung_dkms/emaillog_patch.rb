# frozen_string_literal: true

# This extension modifies the EmailLog class to encrypt the to_address field of email_logs table before saving it to the database and decrypt it upon retrieval. This ensures that email addresses are stored encrypted.



module SamsungDkms::EmailLogPatch

  def to_address
    @decrypted_to_address ||= PIIEncryption.decrypt_email(read_attribute(:to_address))
  end

  def to_address=(value)
    @decrypted_to_address = value
    encrypted_to_address = PIIEncryption.encrypt_email(value)
    write_attribute(:to_address, encrypted_to_address)
  end
end