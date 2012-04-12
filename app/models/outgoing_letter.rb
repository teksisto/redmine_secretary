class OutgoingLetter < ActiveRecord::Base
  unloadable
  belongs_to  :author, :class_name => 'User', :foreign_key => 'author_id'
  has_many    :projects, :through => :associated_projects
  has_many    :associated_projects
end