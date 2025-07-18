# frozen_string_literal: true

require 'zeitwerk'
require 'active_model'

loader = Zeitwerk::Loader.new
loader.push_dir("#{__dir__}/../lib/models")
loader.push_dir("#{__dir__}/../lib/models/offers")
loader.setup
