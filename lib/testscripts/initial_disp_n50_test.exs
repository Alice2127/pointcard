#テスト用データ投入スクリプト

alias Pointcard.Users

for _x <- 1..50 do
  %{rank_id: 1, name: "テスト"} |> Users.create_user()
end

#Enum.reduceでサフィックス作れないかな？お客様の名前が全部同じになるのはリアルじゃない...
