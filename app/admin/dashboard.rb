ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  content title: proc{ I18n.t("active_admin.dashboard") } do
    columns do 
      column do
        panel "Search Statistics" do
          table_for SearchStatistic.limit(20).order('number_of_searches DESC') do
            column "Search Statistic" do |statistic|
              link_to statistic.id, admin_search_statistic_path(statistic)
            end
            column :search_string
            column :target
            column :number_of_searches
            # This column will only take the 5 highest key value pairs from
            # job_descriptions_using_search
            column "Job Descriptions Using Search" do |statistic|
                text_node statistic.get_max_ten_pairs
            end
          end
        end
      end
end

    # Here is an example of a simple dashboard with columns and panels.
    #
    # columns do
    #   column do
    #     panel "Recent Posts" do
    #       ul do
    #         Post.recent(5).map do |post|
    #           li link_to(post.title, admin_post_path(post))
    #         end
    #       end
    #     end
    #   end

    #   column do
    #     panel "Info" do
    #       para "Welcome to ActiveAdmin."
    #     end
    #   end
    # end
  end # content
end
