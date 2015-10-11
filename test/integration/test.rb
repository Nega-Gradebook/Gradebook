require 'test_helper'

#it doesn't seem that rake is running my integration tests, but here are a pair
#of attempts so we can at least talk about how to make them better.

class IntegrationTest < ActionDispatch::IntegrationTest
  test "login page works" do
    get '/session/new'
    assert_redirect_to session_new_path
    follow_redirect!
    assert_template "new"
    assert response.body.include?("Password")
    post login_path, session: {email: "email@email.com", password: "kaslkjsdjflkj"}
    assert_redirected_to session_new_path
    post login_path, session: {email: "fakemail@mail.com", password: "notapassword"}
    assert_redirected_to teachers_path
    follow_redirect!
    assert_select "article"
    assert_select "tr", 2
  end

  test "must log in to see show page" do
    get '/session/new'
    assert_redirect_to session_new_path
    post login_path, session: {email: "", password: ""}
    assert_redirected_to dashboards_path
    get '/session/new'
    assert_redirect_to session_new_path
    post login_path, session: {email: "billnye@scienceguy.com", password: "password"}
    assert_redirected_to teachers_path
    follow_redirect!
    assert_select "billnye@scienceguy.com"
    get edit_teacher_path
    follow_redirect!
    assert_select "profile"
  end

  test "students can change their password" do
    get '/session/new'
    assert_redirect_to session_new_path
    post login_path, session: {email: "joey@doe.com", password: "password"}
    assert_redirected_to student_path
    follow_redirect!
    assert_select "Joey Doe"
    get edit_student_path
    follow_redirect!
    assert_select "password"
  end

end
