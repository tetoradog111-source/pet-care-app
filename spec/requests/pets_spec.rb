require 'rails_helper'

RSpec.describe "PetsSecurity", type: :request do
  let(:user_a) { create(:user) }       # グループAのユーザー
  let(:user_b) { create(:user) }       # グループBのユーザー
  let(:group_a) { create(:group) }      # グループA
  let(:group_b) { create(:group) }      # グループB
  let(:pet_a) { create(:pet, group: group_a) } # グループAに紐づくペット

  before do
    # ユーザーとグループの紐づけ
    group_a.users << user_a
    group_b.users << user_b
  end

  describe "GET /groups/:group_id/pets/:id (詳細画面へのアクセス制限)" do
    context "1. ログインしていない（未ログイン）の場合" do
      it "アクセスが遮断され、リダイレクトされること" do
        get group_pet_path(group_a, pet_a)
        
        # 💡 実際の挙動（root_pathなど）に合わせて検証します
        expect(response).to redirect_to(root_path)
      end
    end

    context "2. ログインしているが、部外者（グループに所属していない）の場合" do
      before do
        post login_path, params: { email: user_b.email, password: 'password' }
      end

      it "グループ一覧ページ等にリダイレクトされ、アクセスが遮断されること" do
        get group_pet_path(group_a, pet_a)
        
        # 💡 root_path から groups_path に書き換えます
        expect(response).to redirect_to(groups_path) 
        
        expect(flash[:alert]).to eq("このグループの情報を閲覧する権限がありません。")
      end
    end

    context "3. ログインしており、正規のグループメンバーである場合" do
      before do
        # 💡 直接ログイン用のパスにPOSTしてユーザーAでログイン
        post login_path, params: { email: user_a.email, password: 'password' }
      end

      it "正常にアクセスでき、200 OKが返ってくること" do
        get group_pet_path(group_a, pet_a)
        expect(response).to have_http_status(:ok)
      end
    end
  end
end