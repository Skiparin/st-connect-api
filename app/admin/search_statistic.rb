ActiveAdmin.register SearchStatistic do
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
    f.inputs 'Search Statistic' do
      f.input :search_string
      f.input :target
      f.input :number_of_searches
      f.input :job_descriptions_using_search
    end
    f.semantic_errors *f.object.errors.keys
    f.actions
end

permit_params :search_string, :target, :number_of_searches, :job_descriptions_using_search

end
