class ListingsControllerTest < ActionController::TestCase
  test "get index" do
    create(:link)

    get :index

    assert_response :success
    assert_not_nil assigns(:links)
  end
end
