if User.all.empty?
  puts "Criando usuário padrão"
  User.create!(
    email:"jhonathan@dev.com",
    name: "Jhonathan Carvalho",
    display_name: "OJHON",
    birthdate: DateTime.parse("20/11/1999", "%d/%m/%Y"),
    password:"123123",
    password_confirmation: "123123"
  )
end

if Transaction.all.empty?
  puts "Criando transações padrão"
  for i in 1..4 do
    Transaction.create!(
      name: "Entrada #{i}",
      value: 2000,
      kind: "income",
      account_id: Account.first.id
    )
  end
end