#encoding: utf-8
class Coupon < ActiveRecord::Base
  attr_accessible :coupon_code, :denomination, :end_date, :start_date

  has_many :reservations
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
