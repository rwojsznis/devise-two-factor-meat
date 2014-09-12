require "spec_helper"

describe "Test application" do
  it "works under three different rails versions" do
    # well, never used appraisal before ;]
    visit "/"
    expect(page).to have_text("Hello #{Rails.version}")
  end
end
