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