module RitRails
  module RitPlate

    def self.included(controller)
      controller.send(:include, InstanceMethods)
      controller.extend(ClassMethods)
    end

    module ClassMethods
      def self.extended(controller)
        controller.helper_method :rit_plate, :rit_plate!
        controller.hide_action   :rit_palte, :rit_plate!
      end
    end

    module InstanceMethods
      # A safe method that attempts to render content from rit
      #
      # Arguments:
      # * layout_name: +String+
      #     The name of the rit layout
      # * instance_name: +String+
      #     The name of the rit instance (optional)
      # * plate_name: +String+
      #     The name of the rit plate
      #
      # Returns:
      #   Returns content or empty (string)
      def rit_plate(layout_name, instance_name, plate_name)
        RitRails::Plate.get(layout_name, instance_name, plate_name, nil) # FIXME: session[:preview_time]
      # rescue # RitRails::ConnectionError, RitRails::NotFoundError # FIXME: rescue specific RitRails errors
      #         ''
      end

      # A method that attempts to render content from rit and if none found will raise an error
      #
      # Arguments:
      # * layout_name: +String+
      #     The name of the rit layout
      # * instance_name: +String+
      #     The name of the rit instance (optional)
      # * plate_name: +String+
      #     The name of the rit plate
      #
      # Returns:
      #   Returns content (string) or raises error if not found
      def rit_plate!(layout_name, instance_name, plate_name)
        RitRails::Plate.get(layout_name, instance_name, plate_name, nil) # session[:preview_time]
      end
    end
  end
end