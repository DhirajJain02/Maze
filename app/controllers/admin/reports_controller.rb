class Admin::ReportsController < AdminController
  require "csv"
  before_action :authenticate_user!
  before_action :authorize_admin

  def index
    @user = User.all
  end

  def export_users
    report = Post.joins(:user)
    .left_joins(:comments, :likes)
    .select(
      "(users.first_name || ' ' || users.last_name) AS full_name, " \
      "posts.description, " \
      "STRING_AGG(comments.data, ', ') AS comment_data, " \
      "COUNT(DISTINCT likes.id) AS like_count"
    )
    .group("posts.id, users.first_name, users.last_name, posts.description")

    respond_to do |format|
      format.csv { send_data generate_csv(report), filename: "all_users-#{Date.today}.csv" }
      format.xlsx do
        send_data generate_excel(report),
                  filename: "report-#{Date.today}.xlsx",
                  type: "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
      end
    end
  end

  def export_active_users
    @users = User.left_joins(:posts)
                 .group("users.id")
                 .having("COUNT(posts.id) > 10")
                 .includes(:posts, :comments, :likes)

    export_data(@users, "active_users")
  end

  def export_posts
    @posts = Post.includes(:comments, :likes)

    respond_to do |format|
      format.csv { send_data generate_posts_csv(@posts), filename: "posts-#{Date.today}.csv" }
      format.xlsx { render xlsx: "export_posts", filename: "posts-#{Date.today}.xlsx" }
    end
  end

  private

  def generate_csv(records)
    CSV.generate(headers: true) do |csv|
      csv << [ "Full Name", "Post Description", "Comments", "Like Count" ]
      records.each do |record|
        csv << [ record.full_name, record.description, record.comment_data, record.like_count ]
      end
    end
  end

  def generate_excel(records)
    package = Axlsx::Package.new
    workbook = package.workbook

    workbook.add_worksheet(name: "Report") do |sheet|
      # Add a custom header row
      sheet.add_row [ "Full Name", "Post Description", "Comments", "Like Count" ]

      # Add data rows in the same order as the header
      records.each do |record|
        sheet.add_row [ record.full_name, record.description, record.comment_data, record.like_count ]
      end
    end

    # Return the Excel file as a binary string
    package.to_stream.read
  end

  def authorize_admin
    redirect_to root_path, notice: "Not authorized to enter!!!" unless current_user.admin?
  end
end
