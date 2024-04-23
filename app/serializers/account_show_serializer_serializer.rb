class AccountShowSerializerSerializer < ActiveModel::Serializer
  attributes(*Account.column_names.reject { |column| column == 'user_id' })
end
