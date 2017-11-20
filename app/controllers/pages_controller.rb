class PagesController < ApplicationController
  before_action :markdown

  def root
    @file = "#{Rails.root}/CHANGELOG.md"
  end

  private

  def markdown
    @markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML.new(render_options = {with_toc_data: true}), {})
  end
end
