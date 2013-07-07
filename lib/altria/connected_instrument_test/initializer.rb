require 'rexml/document'

Build.property(:result)

Job.property(:connected_instrument_test)

Job.after_execute {
  Altria::ConnectedInstrumentTest::Result.new(self).after_execute
}

JobsController.prepend_view_path File.expand_path("../../../../app/views", __FILE__)

JobsController.before_filter only: :show do
  return "" if @resource.connected_instrument_test.empty?
  return "" if @resource.last_finished_build.nil?

  test_result_xml = @resource.last_finished_build.result
  doc = REXML::Document.new(test_result_xml)

  doc.elements.each('testsuite') {|element|
    testsuite_json = JSON.parse(format(element.attributes))

    testsuite_json.delete("name")
    testsuite_json.delete("hostname")

    @testsuite = format(testsuite_json)
  }

  @testcases = Array.new
  doc.elements.each('testsuite/testcase') {|element|
    @testcases.push(format(element.attributes))
  }

  @failures = Array.new
  doc.elements.each('testsuite/testcase/failure') {|element|
    @failures.push(element.text.to_s)
  }

  @success_rate = calc_success_rate(@testcases.size, @failures.size)
  @is_all_tests_success = @failures.empty? ? "success" : "failure"

  view_context.content_for :jobs_show, render_to_string(partial: "connected_instrument_test").html_safe
end

def format(data)
  JSON.pretty_generate(data)
end

def calc_success_rate(success, failure)
  total = success + failure
  (success.quo(total) * 100).to_i
end
