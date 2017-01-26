Given(/^I do not have an account$/) do
  # no-op?
  # User.where(email: 'james@example.com').delete_all
end

And(/^I'm on the sign up page$/) do
  visit '/users/sign_up'
end

When(/^I register as (\S+)$/) do |email|
  fill_in 'user_email', with: email
  fill_in 'user_password', with: 'hunter2'
  fill_in 'user_password_confirmation', with: 'hunter2'
  click_on 'Sign up'
end

Then(/^I should be on the home page$/) do
  # expect(page.current_path).to eq '/'
  expect(page.has_content? 'Home Page!').to eq true
end

And(/^I have a user account$/) do
  # expect(User.where(email: 'james@example.com').count).to eq 1
  expect(page).to have_content 'james@example.com'
end

When(/^try mis\-matched passwords$/) do
  fill_in 'user_email', with: 'james@example.com'
  fill_in 'user_password', with: 'hunter2'
  fill_in 'user_password_confirmation', with: 'hunterr2'
  click_on 'Sign up'
end

Then(/^I should be on the sign up page$/) do
  expect(page).to have_content 'Sign up'
end

And(/^I should see that passwords don't match$/) do
  expect(page).to have_content "Password confirmation doesn't match Password"
end

Given(/^(\S+) has an account$/) do |email|
  # step "register as #{email}"
  User.create! email: email, password: 'hunter2'
end

And(/^I should see that the email is taken$/) do
  expect(page).to have_content 'Email has already been taken'
end

And(/^there should be no new user accounts$/) do
  expect(User.count).to eq 1
end

And(/^I'm on the sign in page$/) do
  visit '/users/sign_in'
end

When(/^I sign in$/) do
  fill_in 'user_email', with: 'james@example.com'
  fill_in 'user_password', with: 'hunter2'
  click_on 'Log in'
end


When(/^I enter the wrong password$/) do
  fill_in 'user_email', with: 'james@example.com'
  fill_in 'user_password', with: 'hunter22'
  click_on 'Log in'
end

Then(/^I should not be able to log in$/) do
  expect(page).to have_content 'Log in'
end

When(/^I enter the wrong username$/) do
  fill_in 'user_email', with: 'james@example'
  fill_in 'user_password', with: 'hunter22'
  click_on 'Log in'
end