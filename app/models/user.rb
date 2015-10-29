class User < ActiveRecord::Base

  before_create :confirmation_token
    
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_many :posts
  has_many :friendships
  has_many :friends, through: :friendships, dependent: :destroy

  def display
      #self.name + ' ' + self.email
      self.email
  end  

#private
 #   def confirmation_token
  #      if self.confirm_token.blank?
   #         self.confirm_token = SecureRandom.urlsafe_base64.to_s
    #    end
    #end


end
