module Altria
  module ConnectedInstrumentTest
    class Result
      attr_reader :job

      def initialize(job)
        @job = job
      end
    end
  end
end
