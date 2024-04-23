class TransactionShowSerializerSerializer < ActiveModel::Serializer
  attributes(*Transaction.column_names.reject { |column| column == 'account_id' })
end
