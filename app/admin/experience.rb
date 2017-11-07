ActiveAdmin.register Experience do
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
    f.inputs 'Experience' do
      f.input :user_id, label: "User", as: :select, collection: User.all.each.map{|t| ["#{t.name}", t.id]}, include_blank: false
      f.input :title
      f.input :company
      f.input :location
      f.input :start_time
      f.input :end_time
      f.input :is_still_working
      f.input :description
    end
    f.semantic_errors *f.object.errors.keys
    f.actions
end

permit_params :user_id, :title, :company, :location, :start_time, :end_time, :is_still_working, :description

end