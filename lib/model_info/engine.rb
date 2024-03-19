require 'kaminari'
require 'csv'
module ModelInfo
  class Engine < ::Rails::Engine
    isolate_namespace ModelInfo

    initializer 'model_info', before: :load_config_initializers do |app|
      app.config.assets.precompile += %w[model_info/application.js model_info/application.css)] if app.config.assets.present?

      Rails.application.routes.append do
        mount ModelInfo::Engine, at: '/model_info'
      end

      config.paths['db/migrate'].expanded.each do |expanded_path|
        Rails.application.config.paths['db/migrate'] << expanded_path
      end
    end
  end
end
