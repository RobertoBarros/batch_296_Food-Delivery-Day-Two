class SessionsView

  def ask_username
    puts "Enter username:"
    gets.chomp
  end

  def ask_password
    puts "Enter password:"
    gets.chomp
  end

  def welcome(employee)
    puts "Welcome #{employee.username}"
  end

  def wrong_credentials
    puts "Wrong credentials. Try again."
  end

end