class IncomingLetter < ActiveRecord::Base
  unloadable
  include Redmine::SafeAttributes  
  
  belongs_to  :author, :class_name => 'User', :foreign_key => 'author_id'  
  belongs_to  :executor, :class_name => 'User', :foreign_key => 'executor_id'  
  has_many    :projects, :through => :associated_projects
  has_many    :associated_projects
  has_many    :comments, :as => :commented, :dependent => :destroy

  validates_presence_of :incoming_code, :author_id, :executor_id, 
    :shipping_type, :shipping_from
  validates_uniqueness_of :incoming_code

  acts_as_attachable
  
  attr_accessor :project
  
  safe_attributes :incoming_code, :outgoing_code, :signer,
    :shipping_from, :shipping_type, :shipping_on, 
    :original_required, :recipient, :executor_id, :description

  def attachments_visible?(user=User.current)
      user.allowed_to?(self.class.attachable_options[:view_permission], nil, :global => true)
  end

  def attachments_deletable?(user=User.current)
    user.allowed_to?(self.class.attachable_options[:delete_permission], nil, :global => true)
  end
       
  def editable_by?(usr)
    usr && usr.logged? && (usr.allowed_to?(:edit_incoming_letters, nil, :global => true) || (self.author == usr && usr.allowed_to?(:edit_own_incoming_letters, nil, :global => true))
    )
  end

  def destroyable_by?(usr)
    usr && usr.logged? && (usr.allowed_to?(:delete_incoming_letters, nil, :global => true) || (self.author == usr && usr.allowed_to?(:delete_own_incoming_letters, nil, :global => true))
    )
  end

#  def save_attachments(params)
#    if valid?
#      attachments = Attachment.attach_files(self, params)
#      begin
#        raise ActiveRecord::Rollback unless save
#      rescue ActiveRecord::StaleObjectError
#        attachments[:files].each(&:destroy)
#        errors.add :base, l(:notice_locking_conflict)
#        raise ActiveRecord::Rollback
#      end
#    end  
#  end  
end
