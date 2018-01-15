require 'bcrypt'

cleartext = 'grillkorv'

hash = BCrypt::Password.create(cleartext)




# Registrering
# Ta in cleartext
# Hasha med bcrypt
# lagra hash (med salt) i DB

# Autohorization
# ta in lösenord (och anv.namn)
# hämta den lagrade hashen för användarnamnet i DB
# hasha lösenord med salten från den lagrade hashen
# jämför det hashade lösenordet med den lagrade hashen
# om det stämmer, lagra användarens id i session[:user_id]
# annars?