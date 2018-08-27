class Game < ApplicationRecord
    
    has_many :frame_by_users
    has_many :users, through: :frame_by_users
    has_many :frames, through: :frame_by_users
    
    validates :players , :numericality => { :only_integer => true, :greater_than_or_equal_to => 1}
    after_save :set_players
    
    def plus_turn
        self.turn += 1
        self.save
    end
    
    def set_players
        self.players = self.users.count
    end
end
