class User < ActiveRecord::Base
	has_many :investments, dependent: :destroy
	validates :name,    :presence => true,		on: :login
    validates :password,:presence => true,		on: :login                    
	validates :total_amount,   :presence => true
	validates :salary,     :presence => true
    validates :type,    :presence => true
   #validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
end
