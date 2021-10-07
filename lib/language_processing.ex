defmodule LanguageProcessing do

  @doc """
    # 00. 文字列の逆順Permalink
    文字列”stressed”の文字を逆に（末尾から先頭に向かって）並べた文字列を得よ．
  """
  def question00() do
    s = "stressed"
    String.reverse(s)
    |> IO.puts()
  end

  @doc """
    # 01. 「パタトクカシーー」Permalink
    「パタトクカシーー」という文字列の1,3,5,7文字目を取り出して連結した文字列を得よ．
  """
  def question01() do
    s = "パタトクカシーー"
    String.at(s, 0) <> String.at(s, 2) <> String.at(s, 4) <> String.at(s, 6)
    |> IO.puts()

    :ok
  end

  @doc """
    # 02. 「パトカー」＋「タクシー」＝「パタトクカシーー」
    パトカー」＋「タクシー」の文字を先頭から交互に連結して文字列「パタトクカシーー」を得よ．
  """
  def question02() do
    s1 = "パトカー"
    s2 = "タクシー"
    s =
    for n <- 0..String.length(s1) - 1 do
      String.at(s1, n) <> String.at(s2, n)
    end
    Enum.join(s)
    |> IO.puts()

    :ok
  end

  @doc """
    # 03. 円周率
    “Now I need a drink, alcoholic of course, after the heavy lectures involving quantum mechanics.”
    という文を単語に分解し，各単語の（アルファベットの）文字数を先頭から出現順に並べたリストを作成せよ．
  """
  def question03() do
    s = "Now I need a drink, alcoholic of course, after the heavy lectures involving quantum mechanics."
    String.replace(s, [",", "."], "")
    |> String.split(" ")
    |> Enum.map(& String.length(&1))
    |> IO.inspect()

    :ok
  end

  @doc """
    # 04. 元素記号
    “Hi He Lied Because Boron Could Not Oxidize Fluorine. New Nations Might Also Sign Peace Security Clause.
    Arthur King Can.”という文を単語に分解し，1, 5, 6, 7, 8, 9, 15, 16, 19番目の単語は先頭の1文字，それ以外の単語は先頭の2文字を取り出し，
    取り出した文字列から単語の位置（先頭から何番目の単語か）への連想配列（辞書型もしくはマップ型）を作成せよ
  """
  def question04() do
    s = "Hi He Lied Because Boron Could Not Oxidize Fluorine. New Nations Might Also Sign Peace Security Clause. Arthur King Can."
    s = String.replace(s, ".", "")
    n = [1, 5, 6, 7, 8, 9, 15, 16, 19]
    s = String.split(s, " ") |> Enum.with_index(1)

    ans =
    for {value, index} <- s do
      if index in n do
        %{String.at(value, 0) => index}
      else
        %{String.at(value, 0) <> String.at(value, 1) => index}
      end
    end

    IO.inspect(ans)

    :ok
  end

  @doc """
    # 05. n-gram
    与えられたシーケンス（文字列やリストなど）からn-gramを作る関数を作成せよ．
    この関数を用い，”I am an NLPer”という文から単語bi-gram，文字bi-gramを得よ．
  """
  def question05() do
    s = "I am an NLPer"
    word = String.split(s, " ")
    chars = String.codepoints(s)
    IO.puts("単語")
    IO.inspect(bi_gram(word))
    IO.puts("文字")
    IO.inspect(bi_gram(chars))

    :ok
  end

  defp bi_gram(list) do
    [_ | tail_list] = list
    Enum.zip(list, tail_list)
    |> Enum.uniq()
  end

  @doc """
    # 06. 集合
    “paraparaparadise”と”paragraph”に含まれる文字bi-gramの集合を，それぞれ, XとYとして求め，
    XとYの和集合，積集合，差集合を求めよ．さらに，’se’というbi-gramがXおよびYに含まれるかどうかを調べよ．
  """
  def question06() do
    s1 = "paraparaparadise"
    s2 = "paragraph"
    s1 = String.codepoints(s1)
    s2 = String.codepoints(s2)
    x = bi_gram(s1)
    y = bi_gram(s2)

    IO.puts("xは")
    IO.inspect(x)
    IO.puts("yは")
    IO.inspect(y)

    IO.puts("和集合")
    IO.inspect(x ++ y)

    IO.puts("積集合")
    n =
    for index_x <- x, index_y <- y do
      if index_x == index_y do
        index_x
      end
    end
    n = Enum.filter(n, & &1 != nil) |> Enum.uniq()
    IO.inspect(n)

    IO.puts("差集合")
    IO.inspect(x -- y)

    IO.puts("xに'se'が含まれているか")
    IO.inspect({"s", "e"} in x)

    IO.puts("yに'se'が含まれているか")
    IO.inspect({"s", "e"} in y)

    :ok
  end

  @doc """
    # 07. テンプレートによる文生成Permalink
    引数x, y, zを受け取り「x時のyはz」という文字列を返す関数を実装せよ．さらに，x=12, y=”気温”, z=22.4として，実行結果を確認せよ．
  """
  def question07(x \\ 12, y \\ "気温", z \\ 22.4) do
    IO.puts("#{x}時のとき#{y}は#{z}")

    :ok
  end

  @doc """
    # 08. 暗号文
    与えられた文字列の各文字を，以下の仕様で変換する関数cipherを実装せよ．
      * 英小文字ならば(219 - 文字コード)の文字に置換
      * その他の文字はそのまま出力
    この関数を用い，英語のメッセージを暗号化・復号化せよ．
  """
  def question08(str \\ "the quick brown fox jumps over the lazy dog") do
    message = cipher(str)
    IO.puts("暗号化")
    IO.puts(message)
    IO.puts("復号化")
    IO.puts(cipher(message))

    :ok
  end

  defp cipher(str) do
    upcase_str = String.upcase(str) |> String.codepoints()
    str = String.codepoints(str)

    test =
    for {a, b} <- Enum.zip(str, upcase_str) do
      if a == b do
        a
      else
        [c] = to_charlist(a)
        [219 - c] |> to_string()
      end
    end

    Enum.join(test)
  end

  @doc """
    # 09. TypoglycemiaPermalink
    スペースで区切られた単語列に対して，各単語の先頭と末尾の文字は残し，それ以外の文字の順序をランダムに並び替えるプログラムを作成せよ．
    ただし，長さが４以下の単語は並び替えないこととする．適当な英語の文（例えば”I couldn’t believe that I could actually understand
    what I was reading : the phenomenal power of the human mind .”）を与え，その実行結果を確認せよ．
  """
  def question09(str \\ "I couldn't believe that I could actually understand what I was reading : the phenomenal power of the human mind .") do
    str =
    for s <- String.split(str, " ") do
      if 3 < String.length(s) do
        list = String.codepoints(s)
        [head | tail_list] = list
        [end_list | tail_list] = Enum.reverse(tail_list)
        [head] ++ Enum.shuffle(tail_list) ++ [end_list]
        |> Enum.join()
      else
        s
      end
    end
    ans = Enum.join(str, " ")

    IO.inspect(ans)

    :ok
  end

  @file_name "popular-names.txt"
  @doc """
    # 10. 行数のカウント
    行数をカウントせよ．確認にはwcコマンドを用いよ．
  """
  def question10_1() do
    a = File.read!(@file_name)
    String.split(a, "\n")
    |> Enum.filter(& &1 != "")
    |> length()
    |> IO.inspect()

    :ok
  end

  # コマンド
  # sed -e 's/\t/ /g' popular-names.txt
  def question10_2() do
    {a, _} = System.cmd("wc", [@file_name])
    [ans | _] = String.trim(a) |> String.split(" ")

    IO.puts(ans)

    :ok
  end

  @doc """
    # 11. タブをスペースに置換
    タブ1文字につきスペース1文字に置換せよ．確認にはsedコマンド，trコマンド，もしくはexpandコマンドを用いよ．
  """
  def question11_1() do
    a = File.read!(@file_name)
    String.replace(a, "\t", " ")
    |> IO.puts()

    :ok
  end

  # コマンド
  # sed -e 's/\t/ /g' popular-names.txt
  def question11_2() do
    {a, _} = System.cmd("sed", ["-e", "s/\t/ /g", @file_name])
    IO.puts(a)

    :ok
  end

  @doc """
    # 12. 1列目をcol1.txtに，2列目をcol2.txtに保存Permalink
    各行の1列目だけを抜き出したものをcol1.txtに，2列目だけを抜き出したものをcol2.txtとしてファイルに保存せよ．確認にはcutコマンドを用いよ．
  """
  def question12_1() do
    a = File.read!(@file_name) |> String.split("\n")

    a
    |>Enum.map(& String.split(&1, "\t") |> hd())
    |> Enum.filter(& &1 != [""])
    |> Enum.join("\n")
    |> filewrite("col1.txt")

    a
    |> Enum.map(& String.split(&1, "\t"))
    |> Enum.filter(& &1 != [""])
    |> Enum.map(& tl(&1) |> hd())
    |> List.insert_at(-1, "")
    |> Enum.join("\n")
    |> filewrite("col2.txt")

    :ok
  end
  # コマンド
  # cut -f 1 popular-names.txt > col1_check.txt
  # cut -f 2 popular-names.txt > col2_check.txt
  def question12_2() do
    {a1, _} = System.cmd("cut", ["-f", "1", @file_name])

    filewrite(a1, "col1_check.txt")

    {a2, _} = System.cmd("cut", ["-f", "2", @file_name])

    filewrite(a2, "col2_check.txt")

    :ok
  end

  defp filewrite(data, filename) do
    file_data = File.open!(filename, [:write])
    IO.binwrite(file_data, data)
    File.close(file_data)
  end

  @doc """
    # 13. col1.txtとcol2.txtをマージPermalink
    12で作ったcol1.txtとcol2.txtを結合し，元のファイルの1列目と2列目をタブ区切りで並べたテキストファイルを作成せよ．確認にはpasteコマンドを用いよ．
  """
  def question13_1() do
    col1 = File.read!("col1.txt") |> String.split("\n") |> Enum.filter(& &1 != "")
    col2 = File.read!("col2.txt") |> String.split("\n") |> Enum.filter(& &1 != "")

    ans =
    for {a, b} <- Enum.zip(col1, col2) do
      a <> "\t" <> b <> "\n"
    end

    IO.puts(ans)

    :ok
  end

  # コマンド
  #  paste col1_check.txt col2_check.txt
  def question13_2() do
    {a, _} = System.cmd("paste", ["col1_check.txt", "col2_check.txt"])
    IO.puts(a)

    :ok
  end

  @doc """
    # 14. 先頭からN行を出力
    自然数Nをコマンドライン引数などの手段で受け取り，入力のうち先頭のN行だけを表示せよ．確認にはheadコマンドを用いよ．
  """
  def question14_1(n \\ 5) do
    a =
      File.read!(@file_name)
      |> String.split("\n")
      |> Enum.take(n)
      |> Enum.join("\n")
    a = a <> "\n"
    IO.puts(a)

    :ok
  end

  # コマンド
  # head -n 5 popular-names.txt
  def question14_2(n \\ "5") do
    {a, _} = System.cmd("head", ["-n", to_string(n), @file_name])
    IO.puts(a)

    :ok
  end

  @doc """
    # 15. 末尾のN行を出力
    自然数Nをコマンドライン引数などの手段で受け取り，入力のうち末尾のN行だけを表示せよ．確認にはtailコマンドを用いよ．
  """
  def question15_1(n \\ 5) do
    a =
      File.read!(@file_name)
      |> String.split("\n")
      |> Enum.filter(& &1 != "")
      |> Enum.take(-n)
      |> Enum.join("\n")
    a = a <> "\n"
    IO.puts(a)

    :ok
  end

  # コマンド
  #  tail -n 5 popular-names.txt
  def question15_2(n \\ "5") do
    {a, _} = System.cmd("tail", ["-n", to_string(n), @file_name])
    IO.puts(a)

    :ok
  end

  @doc """
    # 16. ファイルをN分割する
    自然数Nをコマンドライン引数などの手段で受け取り，入力のファイルを行単位でN分割せよ．同様の処理をsplitコマンドで実現せよ．
  """

  def question16_1(n \\ 200) do
    File.mkdir_p("Write")
    a = File.read!(@file_name) |> String.split("\n") |> Enum.filter(& &1 != "")

    {l, _} = Float.ceil(length(a) / n) - 1 |> Float.ratio()

    for num <- 0..l do
      s = Enum.slice(a, num * n..num * n + n - 1) |> Enum.join("\n")
      s = s <> "\n"
      File.open!("Write/popular-names#{num}.txt", [:write])
      |> IO.binwrite(s)
    end

    :ok
  end

  # コマンド
  # split -l 200 -d popular-names.txt SP-
  def question16_2(n \\ "255") do
    {_a, a} = System.cmd("split", ["-l", to_string(n), "-d", @file_name, "SP-"])
    IO.puts(a)

    :ok
  end

  @doc """
    # 17. １列目の文字列の異なり
    1列目の文字列の種類（異なる文字列の集合）を求めよ．確認にはcut, sort, uniqコマンドを用いよ．
  """
  def question17_1() do
    File.read!(@file_name)
    |> String.split("\n")
    |> Enum.map(& String.split(&1, "\t") |> hd())
    |> Enum.filter(& &1 != "")
    |> Enum.uniq()
    |> length()
    |> IO.puts()

    :ok
  end

  #コマンド
  # cut -f 1 popular-names.txt | sort | uniq | wc -l
  def question17_2() do
    file_name = "question17_2.txt"

    {a, _} = System.cmd("cut", ["-f", "1", @file_name])
    filewrite(a, file_name)
    {a, _} = System.cmd("sort", [file_name])
    filewrite(a, file_name)
    {a, _} = System.cmd("uniq", [file_name])
    filewrite(a, file_name)
    {a, _} = System.cmd("wc", ["-l", file_name])

    String.split(a, " ") |> Enum.filter(& &1 != "") |> hd |> IO.puts()

    :ok
  end

  @doc """
    # 18. 各行を3コラム目の数値の降順にソート
    各行を3コラム目の数値の逆順で整列せよ（注意: 各行の内容は変更せずに並び替えよ）．
    確認にはsortコマンドを用いよ（この問題はコマンドで実行した時の結果と合わなくてもよい）．
  """
  def question18_1() do
    File.read!(@file_name)
    |> String.split("\n")
    |> Enum.map(& String.split(&1, "\t"))
    |> Enum.filter(& &1 != [""])
    |> Enum.sort_by(& Enum.at(&1, 2), :desc)
    |> Enum.map(& Enum.join(&1, "\t"))
    |> Enum.join("\n")
    |> IO.puts()

    :ok
  end

  # コマンド
  # sort -rnk 3 popular-names.txt
  def question18_2() do
    {a, _} = System.cmd("sort", ["-rnk", "3", @file_name])
    IO.puts(a)

    :ok
  end

  @doc """
    # 19. 各行の1コラム目の文字列の出現頻度を求め，出現頻度の高い順に並べる
    各行の1列目の文字列の出現頻度を求め，その高い順に並べて表示せよ．確認にはcut, uniq, sortコマンドを用いよ．
  """
  def question19_1() do
    a =
      File.read!(@file_name)
      |> String.split("\n")
      |> Enum.map(& String.split(&1, "\t") |> hd)
      |> Enum.filter(& &1 != "")
      |> Enum.frequencies()
      |> Enum.into([])

    a =
      for {name, num} <- a do
        [num, name]
      end
    Enum.sort_by(a, & hd(&1), :desc) |> Enum.map(& Enum.join(&1, " ")) |> Enum.join("\n") |> IO.puts()

    :ok
  end

  # コマンド
  # cut -f 1 popular-names.txt | sort | uniq -c | sort -rn
  def question19_2() do
    file_name = "question19_2.txt"

    {a, _} = System.cmd("cut", ["-f", "1", @file_name])
    filewrite(a, file_name)

    {a, _} = System.cmd("sort", [file_name])
    filewrite(a, file_name)

    {a, _} = System.cmd("uniq", ["-c", file_name])
    filewrite(a, file_name)

    {a, _} = System.cmd("sort", ["-rn", file_name])

    IO.puts(a)

    :ok
  end

  @json_file "jawiki-country.json"

  @doc """
    # 20. JSONデータの読み込み
    Wikipedia記事のJSONファイルを読み込み，「イギリス」に関する記事本文を表示せよ．問題21-29では，ここで抽出した記事本文に対して実行せよ．
  """
  def question20() do
    [text] = put_text()

    IO.puts(text)

    :ok
  end

  defp put_text() do
    File.read!(@json_file)
    |> Poison.decode!()
    |> Enum.filter(& &1["title"] == "イギリス")
    |> Enum.map(& &1["text"])
  end

  @doc """
    # 21. カテゴリ名を含む行を抽出
    記事中でカテゴリ名を宣言している行を抽出せよ．
  """
  def question21() do
    pattern = ~r/^\[\[Category:.*\]\]$/

    put_text()
    |> Enum.map(& String.split(&1, "\n") |> Enum.filter(fn t -> Regex.match?(pattern, t) end ))
    |> Enum.filter(& &1 != [])
    |> Enum.map(& Enum.join(&1, "\n"))
    |> Enum.join("\n")
    |> IO.puts()

    :ok
  end

  @doc """
    # 22. カテゴリ名の抽出
    記事のカテゴリ名を（行単位ではなく名前で）抽出せよ．
  """
  def question22() do
    text_list = put_text()

    text =
      for text <- text_list do
        String.split(text, "\n")
        |> Enum.map(& Regex.named_captures(~r/^\[\[Category:(?<category>.*?)(?|\|\*)\]\]$/, &1))
        |> Enum.filter(& &1 != nil)
        |> Enum.map(& &1["category"])
      end

    List.flatten(text)
    |> Enum.join("\n")
    |> IO.puts()

    :ok
  end

  @doc """
    # 23. セクション構造
    記事中に含まれるセクション名とそのレベル（例えば”== セクション名 ==”なら1）を表示せよ．
  """
  def question23() do
    text_list = put_text()

    text =
      for text <- text_list do
        section =
          String.split(text, "\n")
          |> Enum.map(& Regex.named_captures(~r/^(?<level1>={2,}?) (?<section>.*) (?<level2>={2,}?)$/, &1))
          |> Enum.filter(& &1 != nil)

        for s <- section do
          level = String.length(s["level1"]) - 1
          level = to_string(level)
          "#{s["section"]} : #{level}"
        end
      end

    List.flatten(text)
    |> Enum.join("\n")
    |> IO.puts()

    :ok
  end

  @doc """
    # 24. ファイル参照の抽出
    記事から参照されているメディアファイルをすべて抜き出せ．
  """
  def question24() do
    text_list = put_text()

    text =
      for text <- text_list do
        String.split(text, "\n")
        |> Enum.map(& Regex.named_captures(~r/\[\[ファイル:(?<file_name>.*?)\|/, &1))
        |> Enum.filter(& &1 != nil)
        |> Enum.map(& &1["file_name"])
      end

    List.flatten(text)
    |> Enum.join("\n")
    |> IO.puts()

    :ok
  end

  @doc """
    # 25. テンプレートの抽出
    記事中に含まれる「基礎情報」テンプレートのフィールド名と値を抽出し，辞書オブジェクトとして格納せよ．
  """
  def question25() do
    text_list =
      put_text()
      |> put_basic_information()

    test =
      for %{"filed" => filed, "value" => value} <- text_list do
        "#{filed}: #{value}"
      end

    Enum.join(test, "\n") |> IO.puts()
  end

  defp put_basic_information(text) do
    text
    |> Enum.map(& String.split(&1, "\n"))
    |> List.flatten()
    |> Enum.map(& Regex.named_captures(~r/\|(?<filed>.+?) = *(?<value>.+)/, &1))
  end

  @doc """
    # 26. 強調マークアップの除去
    25の処理時に，テンプレートの値からMediaWikiの強調マークアップ
    （弱い強調，強調，強い強調のすべて）を除去してテキストに変換せよ（参考: マークアップ早見表）．
  """
  def question26() do
    text_list =
      put_text()
      |> put_basic_information()
    text =
      for %{"filed" => filed, "value" => value} <- text_list do
        "#{filed}: #{value}"
      end
    Enum.map(text, & Regex.replace(~r/\'/, &1, ""))
    |> Enum.join("\n")
    |> IO.puts()
  end

  @doc """
    # 27. 内部リンクの除去
    26の処理に加えて，テンプレートの値からMediaWikiの内部リンクマークアップを除去し，
    テキストに変換せよ（参考: マークアップ早見表）．
  """
  def question27() do
    text_list =
      put_text()
      |> put_basic_information()

    text =
      for %{"filed" => filed, "value" => value} <- text_list do
        "#{filed}: #{value}"
      end

    Enum.map(text, & Regex.replace(~r/\'/, &1, ""))
    |> Enum.map(& remove_link(&1))
    |> Enum.join("\n")
    |> IO.puts()
  end

  defp remove_link(text) do
    String.split(text, "<br />")
    |> Enum.map(& Regex.replace(~r/\[\[(.+\||)|\]\]/, &1, ""))
    |> Enum.join("<br />")
  end

  @doc """
    # 28. MediaWikiマークアップの除去Permalink
    27の処理に加えて，テンプレートの値からMediaWikiマークアップを可能な限り除去し，国の基本情報を整形せよ．
  """
  def question28() do
    text_list =
      put_text()
      |> put_basic_information()

    text =
      for %{"filed" => filed, "value" => value} <- text_list do
        "#{filed}: #{value}"
      end

    Enum.map(text, & Regex.replace(~r/\'/, &1, ""))
    |> Enum.map(& remove_link(&1))
    |> Enum.map(& remove_markups(&1))
    |> Enum.join("\n")
    |> IO.puts()
  end

  defp remove_markups(text) do
    Regex.replace(~r/(\{\{.*\|.*\||\{\{.*\}\}|\}\}|\<br \/\>|\<ref.+)/, text, "")
  end

  @doc """
    # 29. 国旗画像のURLを取得する
    テンプレートの内容を利用し，国旗画像のURLを取得せよ．（ヒント: MediaWiki APIのimageinfoを呼び出して，ファイル参照をURLに変換すればよい）
  """
  def question29() do
    text_list =
      put_text()
      |> put_basic_information()

    text =
      for %{"filed" => filed, "value" => value} <- text_list do
        "#{filed}: #{value}"
      end

    Enum.map(text, & Regex.replace(~r/\'/, &1, ""))
    |> Enum.map(& remove_link(&1))
    |> Enum.map(& remove_markups(&1))
    |> Enum.map(& Regex.named_captures(~r/国旗画像: (?<text>.*)/, &1))
    |> Enum.filter(& &1 != nil)
    |> Enum.map(fn %{"text" => tmp} -> String.replace(tmp, " ", "_") end)
    |> Enum.join("")
    |> get_url()
    |> IO.puts()
  end

  defp get_url(file_name) do
    json_text = HTTPoison.get!("https://commons.wikimedia.org/w/api.php?action=query&titles=File:"<> file_name <> "&prop=imageinfo&iiprop=url&format=json")

    json =
    json_text.body
    |> Poison.decode!

    json["query"]["pages"]["347935"]["imageinfo"]
    |> Enum.map(fn %{"url" => url} -> url end)
    |> Enum.join("")
  end
end
