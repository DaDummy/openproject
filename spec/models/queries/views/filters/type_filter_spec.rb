#-- copyright
# OpenProject is an open source project management software.
# Copyright (C) 2012-2024 the OpenProject GmbH
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License version 3.
#
# OpenProject is a fork of ChiliProject, which is a fork of Redmine. The copyright follows:
# Copyright (C) 2006-2013 Jean-Philippe Lang
# Copyright (C) 2010-2013 the ChiliProject Team
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
#
# See COPYRIGHT and LICENSE files for more details.
#++

require 'spec_helper'

RSpec.describe Queries::Views::Filters::TypeFilter, with_flag: { show_separate_gantt_module: true }  do
  let(:current_user) { create(:user) }

  before do
    login_as(current_user)
  end

  it_behaves_like 'basic query filter' do
    let(:class_key) { :type }
    let(:type) { :list_optional }

    describe '#allowed_values' do
      it 'includes the core views' do
        expected_core_views = [
          %w[Views::TeamPlanner Views::TeamPlanner],
          %w[Views::WorkPackagesTable Views::WorkPackagesTable]
        ]

        expect((expected_core_views - instance.allowed_values).size).to be 0
      end
    end
  end

  it_behaves_like 'list_optional query filter' do
    let(:attribute) { :type }
    let(:model) { View }
    let(:valid_values) { %w[Views::TeamPlanner Views::WorkPackagesTable] }
    let(:transformed_values) { %w[team_planner work_packages_table] }
  end
end
