ActiveAdmin.register Like do
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

menu parent: 'Posts'

form do |f|
    f.inputs 'Like' do
      f.input :profile_id, label: "Profile", as: :select, collection: Profile.all.each.map{|t| ["#{t.name}", t.id]}, include_blank: false
      f.input :post_id, label: "Post", as: :select, collection: Post.all.each.map{|t| ["#{t.id}", t.id]}, include_blank: false
    end
    f.semantic_errors *f.object.errors.keys
    f.actions
end

permit_params :profile_id, :post_id

end
