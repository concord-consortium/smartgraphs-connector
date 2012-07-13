class Page < ActiveRecord::Base
  attr_accessible :name, :user, :section, :page_elements, :external_activity

  belongs_to :user
  belongs_to :section
  has_many :page_elements, :order => :position
  has_one :external_activity, :as => :template

  def add_embeddable(embeddable)
    page_elements << PageElement.create(:user => user, :embeddable => embeddable)
    #e = PageElement.create(:user => user)
    #e.embeddable = embeddable
    #e.save
    #page_elements << e
  end
end
