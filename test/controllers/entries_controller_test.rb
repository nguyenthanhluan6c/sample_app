require 'test_helper'

class EntriesControllerTest < ActionController::TestCase
 def setup
    @entry = entries(:orange)
  end

  test "should redirect create when not logged in" do
    assert_no_difference 'Entry.count' do
      post :create, entry: { title: "title",body: "Lorem ipsum" }
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'Entry.count' do
      delete :destroy, id: @entry
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy for wrong entry" do
    log_in_as(users(:michael))
    entry = entries(:ants)
    assert_no_difference 'Entry.count' do
      delete :destroy, id: entry
    end
    assert_redirected_to root_url
  end
end
