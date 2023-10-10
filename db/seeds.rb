# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

Schedule.create_or_find_by!(name: "Ad Hoc", cron: nil)
Schedule.create_or_find_by!(name: "Every hour", cron: '0 * * * *')
Schedule.create_or_find_by!(name: "Every 2 hours", cron: '0 */2 * * *')
Schedule.create_or_find_by!(name: "Every 6 hours", cron: '0 */6 * * *')
Schedule.create_or_find_by!(name: "Every 12 hours", cron: '0 */12 * * *')
Schedule.create_or_find_by!(name: "Every 24 hours", cron: '0 0 * * *')
Schedule.create_or_find_by!(name: "Every 48 hours", cron: '0 0 */2 * *')