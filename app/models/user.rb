#encoding:utf-8
class User < ActiveRecord::Base
  attr_accessible :username, :phone, :password, :password_confirmation,:email, :customer_attributes, :current_password
  extend Enumerize
  enumerize :status, in: [:enable,:disable], default: :enable
  has_secure_password
  has_one :customer
  accepts_nested_attributes_for :customer
  default_scope  -> {order("created_at desc")}
  def customer
    super || build_customer
  end

  validates :username, :presence => {:message=>'请输入用户名'},
    :length => {:in => 4..20 },
    :uniqueness => { :message => '已使用' }

  validates :phone, :presence => {:message => '请输入注册电话'}
  validates :password, :presence => true ,:on => :create
  validates :password, :length => { :in => 6..20 }, :if => Proc.new {password.present?}

  validates :password_confirmation, :presence => true, :on => :create

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true,
    format: { with: VALID_EMAIL_REGEX },
    uniqueness: { case_sensitive: false }


  before_save { |user| user.email = email.try(:downcase) }

  def to_json(options={})
    options[:except] ||= [:id, :password_digest]
    super(options)
  end

  def to_s
    username
  end
end
