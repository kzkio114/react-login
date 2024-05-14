class GitSessionsController < ApplicationController

  # ユーザーをGitHubの認証ページへリダイレクトするためのURLを生成するアクション
  def new
    @auth_url = github_auth_url
  end

  # GitHubからのコールバックを処理するアクション
  def create
    session_code = params[:code]
    result = exchange_code_for_token(session_code)
    if result["access_token"]
      session[:github_token] = result["access_token"]
      redirect_to root_path, notice: "GitHub login successful."
    else
      redirect_to root_path, alert: "GitHub login failed."
    end
  end

  private

  # GitHub認証用URLを生成するメソッド
  def github_auth_url
    client_id = Rails.application.credentials.github[:client_id]
    redirect_uri = "http://localhost:3000/auth/github/callback"
    scope = "user"
    "https://github.com/login/oauth/authorize?client_id=#{client_id}&redirect_uri=#{redirect_uri}&scope=#{scope}"
  end

  # GitHubからアクセストークンを取得するためのメソッド
  def exchange_code_for_token(code)
    uri = URI.parse("https://github.com/login/oauth/access_token")
    response = Net::HTTP.post_form(uri, {
      client_id: Rails.application.credentials.github[:client_id],
      client_secret: Rails.application.credentials.github[:client_secret],
      code: code,
      redirect_uri: "http://localhost:3000/auth/github/callback"
    })
    JSON.parse(response.body)
  end
end
