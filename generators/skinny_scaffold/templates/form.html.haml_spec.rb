require File.dirname(__FILE__) + '<%= '/..' * controller_class_nesting_depth %>/../../spec_helper'

describe "<%= File.join(controller_class_path, controller_singular_name) %>/form.html.haml" do
  before(:each) do
<% if attributes.blank? -%>
    @<%= singular_name %> = mock_and_assign(<%= model_name %>)
<% else -%>
    @<%= singular_name %> = mock_and_assign(<%= model_name %>, :stub => {
  <%- attributes.each_with_index do |attribute, index| -%>
    <%- case attribute.type -%>
      <%- when :string, :text -%>
      :<%= attribute.name %> => "foo"<%= index < attributes.size - 1 ? "," : "" %>
      <%- when :integer, :float, :decimal -%>
      :<%= attribute.name %> => 815<%= index < attributes.size - 1 ? "," : "" %>
      <%- when :boolean -%>
      :<%= attribute.name %> => false<%= index < attributes.size - 1 ? "," : "" %>
      <%- when :date, :datetime, :time, :timestamp -%>
      :<%= attribute.name %> => 1.week.ago<%= index < attributes.size - 1 ? "," : "" %>
      <%- else -%>
      :<%= attribute.name %> => nil<%= index < attributes.size - 1 ? "," : "" %>
    <%- end -%>
  <%- end -%>
    })
<% end -%>
  end
  
  it "should use form_for to generate the proper form action and options" do
    template.should_receive(:form_for).with(@<%= singular_name %>)
    do_render
  end
  
<% if attributes.blank? -%>
  # Add specs for editing attributes here, please! Like this:
  # 
  # it_should_allow_editing :<%= singular_name %>, :foo
<% else -%>
  <%- attributes.each do |attribute| -%>
  it_should_allow_editing :<%= singular_name %>, :<%= attribute.name %>
  <%- end -%>
<% end -%>
  
  it_should_link_to_show :<%= singular_name %>
  it_should_link_to { <%= plural_name %>_path }
end