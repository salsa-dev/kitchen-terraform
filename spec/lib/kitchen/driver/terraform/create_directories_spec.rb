# frozen_string_literal: true

# Copyright 2016 New Context Services, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

require "kitchen/driver/terraform/create_directories"
require "support/dry/monads/either_matchers"
require "support/kitchen/driver/terraform/create_directories_context"

::RSpec.describe ::Kitchen::Driver::Terraform::CreateDirectories do
  describe ".call" do
    subject do
      described_class.call directories: [
                             "directory_1",
                             "directory_2"
                           ]
    end

    context "when the creation of directories does experience an error" do
      include_context "Kitchen::Driver::Terraform::CreateDirectories"

      it do
        is_expected.to result_in_failure.with_the_value /error/
      end
    end

    context "when the creation of directories does not experience an error" do
      include_context "Kitchen::Driver::Terraform::CreateDirectories", failure: false

      it do
        is_expected.to result_in_success.with_the_value "Created directories [\"directory_1\", \"directory_2\"]"
      end
    end
  end
end