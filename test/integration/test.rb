require 'test_helper'

class IntegrationTest < ActionController::TestCase
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

  test 

end
