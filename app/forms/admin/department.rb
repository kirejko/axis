# frozen_string_literal: true

module Forms
  module Admin
    # Department create/update
    class Department
      include ActiveModel::Model

      attr_accessor :name, :description
      attr_reader   :department

      validates :name,        presence: true, length: { in: 4..32 }
      validates :description, presence: true, length: { in: 10..255 }

      def self.model_name
        ActiveModel::Name.new(self, nil, 'Department')
      end

      def persisted?
        @department.persisted? || false
      end

      def initialize(department: nil, attributes: {})
        unless department.nil?
          @department = department
          super(department_attributes.merge(attributes))
        end

        super(attributes)
      end

      def save
        return false unless valid?

        create_department
        true
      end

      def update
        return false unless valid?

        update_department
        true
      end

      private

      def department_attributes
        {
          name:        department.name,
          description: department.description
        }
      end

      def department_permitted_params
        {
          name:        name,
          description: description
        }
      end

      def create_ad
        ActiveRecord::Base.transaction do
          @department = Department.create(department_permitted_params)
        end
      end

      def update_ad
        ActiveRecord::Base.transaction do
          @department.update_attributes(department_permitted_params)
        end
      end
    end
  end
end
