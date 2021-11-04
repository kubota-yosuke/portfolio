module RoomsHelper
    def opponent_user(room)
        # 中間テーブルから相手ユーザーのデータを取得
        entry = room.entries.where.not(user_id: current_user)
        # 相手ユーザーの名前を取得
        email = entry[0].user.email
        # 名前を表示
        tag.p "#{email}", class: "dm_list__content__link__box__name"
    end
end
