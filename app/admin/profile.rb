ActiveAdmin.register Profile do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end

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
