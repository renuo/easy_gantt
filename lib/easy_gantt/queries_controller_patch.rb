module EasyGantt
  module QueriesControllerPatch

    def self.include(base)
      base.send(:include, InstanceMethods)
      base.class_eval do
        alias_method :query_class_without_gannt, :query_class
        alias_method :query_class, :query_class_with_gannt
      end
    end

    module InstanceMethods
      # Redmine return only direct sublasses but
      # Gantt query inherit from IssueQuery
      def query_class_with_gannt
        return EasyGantt::EasyGanttIssueQuery if params[:type] == 'EasyGantt::EasyGanttIssueQuery'
        query_class_without_gannt
      end
    end
  end
end


unless QueriesController.included_modules.include?(EasyGantt::QueriesControllerPatch)
  QueriesController.send(:include, EasyGantt::QueriesControllerPatch)
end
