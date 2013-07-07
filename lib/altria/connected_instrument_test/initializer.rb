Job.property(:connected_instrument_test)

JobsController.prepend_view_path File.expand_path("../../../../app/views", __FILE__)

JobsController.before_filter only: :show do
  if @resource.connected_instrument_test
    view_context.content_for :jobs_show, render_to_string(partial: "connected_instrument_test").html_safe
  end
end
