def sign_up
  visit '/'
  fill_in :name, with: "Li"
  fill_in :email, with: "Li@gmail.com"
  fill_in :password, with: "Secret"
  fill_in :password_confirmation, with: "Secret"
  click_button "Sign up"
end

#test
