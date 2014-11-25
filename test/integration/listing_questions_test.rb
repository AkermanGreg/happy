require 'test_helper'
class ListingQuestionsTest < ActionDispatch::IntegrationTest

  setup {host! 'localhost:3000'}

  test  'returns list of all questions' do 
    get '/questions'
    assert_equal 200, response.status
    refute_empty response.body
  end
end 