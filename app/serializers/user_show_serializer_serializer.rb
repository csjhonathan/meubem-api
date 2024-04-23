class UserShowSerializerSerializer < ActiveModel::Serializer
  attributes(*User.column_names.reject { |column| column == 'encrypted_password' || column == "reset_password_token" || column == "remember_created_at" || column ==  "reset_password_sent_at"} + [:account])

  has_one :account, serializer: AccountShowSerializerSerializer
end