# Be sure to restart your server when you modify this file.
ActiveSupport.on_load(:action_controller) do
  wrap_parameters format: [:json]
end
