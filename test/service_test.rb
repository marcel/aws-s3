require File.dirname(__FILE__) + '/test_helper'

class ServiceTest < Test::Unit::TestCase  
  def test_bucket_list_with_empty_bucket_list
    Service.request_always_returns :body => Fixtures::Buckets.empty_bucket_list, :code => 200 do
      list = Service.buckets(:reload)
      assert_equal [], list
    end
  end

  def test_bucket_list_with_bucket_list_containing_one_bucket
    Service.request_always_returns :body => Fixtures::Buckets.bucket_list_with_one_bucket, :code => 200 do
      list = Service.buckets(:reload)
      assert_equal 1, list.size
      assert_equal 'marcel_molina', list.first.name
    end
  end

  def test_bucket_list_with_bucket_list_containing_more_than_one_bucket
    Service.request_always_returns :body => Fixtures::Buckets.bucket_list_with_more_than_one_bucket, :code => 200 do
      list = Service.buckets(:reload)
      assert_equal 2, list.size
      assert_equal %w(marcel_molina marcel_molina_jr), list.map {|bucket| bucket.name}.sort
    end
  end
end