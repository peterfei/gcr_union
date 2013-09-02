class SelfDriving < Reservation

  extend Enumerize

  serialize :special_requirements, Array
  enumerize :special_requirements, in: %w/GPS导航 儿童座椅/, multiple: true
  enumerize :pay_mode, in: [:online, :location, :membership], default: :online
end
