class UserRoleJoins < Netzke::Basepack::Grid
  def configure(c)
    super
    c.model = "UserRoleJoin"
    c.force_fit = true
    c.header = false
    c.title = "User Roles"
    c.data_store.sorters = [{ :property => :user__username, :direction => :ASC}]
    c.columns = [
      { :name => :user__username, :text => "Username", :read_only => true},
      { :name => :name, :getter => lambda{ |rec|
                                                user = User.find_by_id(rec.user_id)
                                                user.nil? ? "" : "#{user.first_name} #{user.last_name}"
                                              },
      },
      { :name => :role__role, :text => "Role", :default_value => Role.exists? ? Role.first.id : nil},
      :created_at,
      :updated_at,
      :ends ]
  end

  def default_fields_for_forms
    [
      { :name => :user__full_name, :field_label => 'Name'},
      { :name => :role__role, :field_label => 'Role' },
      { :name => :ends }
    ]
  end

  #override with nil to remove actions
  def default_bbar
    [ :apply, :add_in_form, :search ]
  end

end
