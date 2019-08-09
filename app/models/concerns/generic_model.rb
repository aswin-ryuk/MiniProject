require 'active_support/concern'

module GenericModel
  extend ActiveSupport::Concern

  def add_next_position
    next_postion = self.class.name.constantize.maximum(:position)
    self.update_column(:position, (next_postion.blank? ? 0 : next_postion)+1)
  end

end
