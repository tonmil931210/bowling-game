class Frame < ApplicationRecord
  belongs_to :frame_by_user
  
  validates_presence_of :try1, :try2, :frame_by_user, :turn
  
  validates :try1, :numericality => { :only_integer => true, :less_than_or_equal_to => 10,  :greater_than_or_equal_to => 0 }
  validates :try2, :numericality => { :only_integer => true, :less_than_or_equal_to => 10, :greater_than_or_equal_to => 0}
  validates :try3, :numericality => { :only_integer => true, :less_than_or_equal_to => 10, :greater_than_or_equal_to => 0}, :allow_blank => true
  validates :turn, :numericality => { :only_integer => true, :greater_than => 0, :less_than_or_equal_to => 10}
  
  validates_uniqueness_of :turn, scope: [:frame_by_user_id]
  
  validate :tries_valid?
  
  before_create :set_score, :set_status
  
  def set_score
     self.score = self.try3.nil? ? self.try1 + self.try2 : self.try1 + self.try2 + self.try3 
  end
  
  def set_status
    if self.try1 == 10
      self.status = 'strike'
    elsif self.try1 + self.try2 == 10
      self.status = 'spare'
    else
      self.status = 'none'
    end  
  end
  
  def tries_valid?
    if try3.nil? && self.turn != 10
        if ((self.try1 +  self.try2 ) > 10 )
            errors.add(:base, 'Enter valid pin entries for each tries')
        end
        if ((self.try1 == 10 && self.try2 != 0) || (self.try2 == 10 && self.try1 != 0))
            errors.add(:base,'In case of strike mark other pin as 0')
        end
    elsif try3.nil? && self.turn == 10
        errors.add(:base, 'Enter valid pin entries for try3')
    elsif !try3.nil? && self.turn == 10
        if self.try1 != 10
            if ((self.try1 +  self.try2 ) > 10 )
                errors.add(:base, 'Enter valid pin entries for each tries')
            elsif ((self.try1 +  self.try2 ) < 10 )
                errors.add(:base, 'Not valid enter try3')
            end
        end
    end
  end
end
