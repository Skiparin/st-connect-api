ActiveAdmin.register Profile do
menu parent: 'User'

form do |f|
    f.inputs 'Profile' do
      f.input :user_id, label: "User", as: :select, collection: User.all.each.map{|t| ["#{t.id}", t.id]}, include_blank: false
      f.input :name
      f.input :description
      f.input :image
    end
    f.semantic_errors *f.object.errors.keys
    f.actions
end

permit_params :user_id, :name, :description, :image

end
