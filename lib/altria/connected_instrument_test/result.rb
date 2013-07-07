module Altria
  module ConnectedInstrumentTest
    class Result
      attr_reader :job

      def initialize(job)
        @job = job
      end

      def after_execute
        read_connected_instrument_test_result
        save
      end

      def workspace_path
        job.workspace.path + "test_result"
      end

      def connected_instrument_test_result_dir_path
        job.workspace.path + "repository/#{job.connected_instrument_test}"
      end

      def read_connected_instrument_test_result
        pathnames = Pathname.glob(connected_instrument_test_result_dir_path + "*.xml")
        pathnames.each {|pathname|
          @result = pathname.read
        }
      end

      def assets_path
        job.workspace.path + "repository/test_result/assets"
      end

      def assets_relative_path
        assets_path.relative_path_from(current_build_path)
      end

      def result_html_path
        job.workspace.path + "repository/result/index.html"
      end

      def current_build_path
        workspace_path + job.current_build.id.to_s
      end

      def symlink_assets
        File.symlink(assets_relative_path, current_build_path + "assets")
      end

      def copy_result_html
        FileUtils.cp(result_html_path, current_build_path)
      end

      def save
        save_build
        #save_files
      end

      def save_files
        current_build_path.mkpath
        symlink_assets
        copy_result_html
      end

      def save_build
        job.current_build.update_properties(result: @result.to_s)
      end
    end
  end
end
