class LinksControllerTest < ActionController::TestCase
  test "get index" do
    get :index

    assert_response :success
  end

  test "post create" do
    post :create, original_url: 'blub.de'

    assert_response :success
    assert_not_nil assigns(:link)
  end

  test "post create with empty url" do
    post :create, original_url: ''

    assert_equal root_url, response.location
  end

  test "get show" do
    link = create :link

    get :show, token: link.token

    assert_equal link.original_url, response.location
  end

  test "get show with empty token" do
    link = create :link

    get :show, token: ''

    assert_response :not_found
  end
end
