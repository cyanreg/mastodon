# frozen_string_literal: true

module Paperclip
  # This transcoder is only to be used for the MediaAttachment model
  # to check when uploaded videos are actually gifv's
  class VideoTranscoder < Paperclip::Processor
    def make
      movie = FFMPEG::Movie.new(@file.path)
      actual_options = options
      passthrough_options = actual_options[:passthrough_options]
      actual_options = passthrough_options[:options] if passthrough?(movie, passthrough_options)

      attachment.instance.type = MediaAttachment.types[:gifv] unless movie.audio_codec

      Paperclip::Transcoder.make(file, actual_options, attachment)
    end

    private

    def passthrough?(movie, options)
      options
    end
  end
end
