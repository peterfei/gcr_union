#encoding: utf-8
class Coupon < ActiveRecord::Base
  attr_accessible :coupon_code, :denomination, :end_date, :start_date

  has_many :reservations 
  validates :denomination,presence:{message:"金额不能为空"},numericality:true
  validates :start_date, :presence => {message: '优惠开始日期不能为空'}
  validates :end_date, :presence => {message: '优惠结束日期不能为空'}
  def verfiy
    if end_date < Time.now
      {available: false, msg: "优惠码#{coupon_code}已过期"}
    elsif start_date > Time.now
      {available: false, msg: "优惠码#{coupon_code}还未生效"}
    else
      {available: true, msg: "优惠码#{coupon_code}可用,减免#{denomination}元", denomination: denomination }
    end
  end
end
