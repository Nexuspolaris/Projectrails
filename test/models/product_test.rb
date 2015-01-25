# encoding: utf-8
require 'test_helper'

class ProductTest < ActiveSupport::TestCase
	fixtures :products
   test "Attribut du produit ne doivent pas etre vide" do
     product = Product.new
     assert product.invalid?
     assert product.errors[:titre].any?
     assert product.errors[:description].any?
     assert product.errors[:price].any?
     assert product.errors[:image_url].any?
   end
   test "titre >2 caractères" do
         product = Product.new(:titre => "my3",
                         :description => "zzz",
                         :image_url => "zzz.jpg",
                         :price => 24)
     assert product.invalid?
     product.titre = 'MY34'
     assert product.valid?
   end
   test "prix doit etre positif" do
   	 product = Product.new(:titre => "my booook",
   	 	                   :description => "zzz",
   	 	                   :image_url => "zzz.jpg")
   	 product.price = -1
   	 assert product.invalid?
   	 assert_equal "must be greater than or equal to 0.01", product.errors[:price].join('; ')

   	 product.price = 0
   	 assert product.invalid?
   	 assert_equal "must be greater than or equal to 0.01", product.errors[:price].join('; ')

    product.price = 3
    assert product.valid?
   end
   def new_product(image_url)
   	 Product.new(:titre => 'test_url',
                 :description => 'zzz',
                 :price => 1,
                 :image_url => image_url)
   	end
    test "format image" do
    	ok = %w{ fredx.gif fred.jpg fred.png TEST.JPG tesT.JpG http://test.com/images/test.gif}
    	ko = %w{ test.doc test.gif/more test.gif.more}
    	ok.each do |name|
    		assert new_product(name).valid? , "#{name} shouldn't be invalid"
    	end
    	ko.each do |name|
    		assert new_product(name).invalid? , "#{name} shouldn't be valid"
    	end
    end
    test "titre unique" do
    	product = Product.new(:titre => products(:rubyone).titre,
    		                  :description => "yyy",
    		                  :price => 34,
    		                  :image_url => "test.jpg")
    	assert !product.save
    	assert_equal I18n.translate('activerecord.errors.messages.taken'), product.errors[:titre].join('; ')
    end
end
