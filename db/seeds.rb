if User.all.empty?
  puts "Criando usuário padrão"
  User.create!(
    email:"jhonathancarv.s@gmail.com",
    password:"123123",
    password_confirmation: "123123"
  )
end