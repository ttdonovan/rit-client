module RitClient
  module RitPlate

    def self.included(controller)
      controller.send(:include, InstanceMethods)
      controller.extend(ClassMethods)
    end

    module ClassMethods
      def self.extended(base)
        # If ActionController and base is a kind of ActionController add helper methods and hide actions
        if defined?(ActionController)
          if base.kind_of?(ActionController)
            base.helper_method :rit_plate, :rit_plate!
            base.hide_action   :rit_palte, :rit_plate!
          end
        end
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
        RitClient::Plate.get(layout_name, instance_name, plate_name, nil) # FIXME: session[:preview_time]
      # rescue # RitClient::ConnectionError, RitClient::NotFoundError # FIXME: rescue specific RitClient errors
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
        RitClient::Plate.get(layout_name, instance_name, plate_name, nil) # session[:preview_time]
      end
    end
  end
end