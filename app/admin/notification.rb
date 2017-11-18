ActiveAdmin.register Notification do
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


form do |f|
    f.inputs 'Notification' do
      f.input :profile_id, label: "Profile", as: :select, collection: Profile.all.each.map{|t| ["#{t.name}", t.id]}, include_blank: false
      f.input :message
      f.input :n_type
      f.input :is_read
      f.input :resource
    end
    f.semantic_errors *f.object.errors.keys
    f.actions
end

permit_params :profile_id, :message, :n_type, :is_read, :resource


end
