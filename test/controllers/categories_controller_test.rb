require 'test_helper'

class CategoriesControllerTest < ActionDispatch::IntegrationTest

  def setup
    @category = Category.create(name: "sports")
    @password = "password"
    @admin_user = create_admin()
  end

  test "should get categories index" do
  end

  test "should get new" do
    sign_in(@admin_user, @password)
    get categories_path
    assert_response :success
  end

  test "should get show" do
    get category_path(@category)
    assert_response :success
  end

  test "should redirect create when admin not loged in" do
    assert_no_difference 'Category.count' do
      post(categories_path, {params: {category:{name: "sports"}}})
    end
    assert_redirected_to categories_path
  end
end
