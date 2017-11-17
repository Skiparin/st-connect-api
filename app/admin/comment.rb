# Active Admin has it's own comment model, so we need to rename it here.
ActiveAdmin.register Comment, :as => "PostComment" do
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
    f.inputs 'Comment' do
      f.input :post_id, label: "post", as: :select, collection: Post.all.each.map{|t| ["#{t.id}", t.id]}, include_blank: false
      f.input :profile_id, label: "Profile", as: :select, collection: Profile.all.each.map{|t| ["#{t.name}", t.id]}, include_blank: false
      f.input :text
      
    end
    f.semantic_errors *f.object.errors.keys
    f.actions
end

permit_params :text, :post_id, :profile_id

end
