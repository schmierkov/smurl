class LinksControllerTest < ActionController::TestCase
  test "get index" do
    get :index

    assert_response :success
  end

  test "post create" do
    post :create, original_url: 'blub.de'

    assert_response :success
  end

  test "post create with empty url" do
    post :create, original_url: ''

    assert_equal root_url, response.location
  end

  test "xhr post create" do
    original_url = 'blub.de'
    xhr :post, :create, original_url: original_url

    assert_response :success

    response_json = JSON.parse(response.body)

    assert_equal "http://#{original_url}", response_json["original_url"]
    assert_match /\A(http|https):\/\/.*\/[a-zA-Z]{7}\z/, response_json["token_url"]
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
