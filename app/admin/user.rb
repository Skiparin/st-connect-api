ActiveAdmin.register User do

menu parent: 'User'
  
  index do
    selectable_column
    id_column
    column :name
    column :email
    column :last_sign_in_at
    column :created_at
    actions
  end   

  form do |f|
    f.inputs 'User' do
      f.input :name
      f.input :email
      if f.object.new_record?
        f.input :password
        f.input :password_confirmation
      end
    end
    f.semantic_errors *f.object.errors.keys
    f.actions
  end

  controller do
    def save_resource(object)
      if object.email == ''
        object.email = nil
      end
      super
    end  
  end

permit_params :name, :email, :password, :password_confirmation

end
