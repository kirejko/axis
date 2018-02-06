# frozen_string_literal: true

# Pagination decorator to support Kaminari pagination
class PaginationDecorator < Draper::CollectionDecorator
  delegate :current_page, :total_pages, :limit_value
end