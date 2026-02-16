---
name: plain-text-output
description: "Constrains agent output to plain text only: no emojis, no bold (**/__), no italics (*/_). Prefers noun-ending style (体言止め) in Japanese. Use when generating any text, documentation, commit messages, PR descriptions, or responses so that output stays unadorned."
---

# プレーンテキスト出力

文章生成時に絵文字・太字・イタリックを使わず、日本語では体言止めを優先したプレーンテキストのみで出力する。

## 発動条件

ユーザーへの返答、ドキュメント、コミットメッセージ、PR 説明、README など、あらゆる文章を生成するときに適用する。

## 文体（体言止めの優先）

日本語で文章を書くときは、体言止めを優先して使う。文末を「〜である」「〜する」などで締めず、名詞・体言で止める書き方を基本とする。

## 禁止する表現

以下の表現は使わない。

- 絵文字（Unicode 絵文字全般）
- 太字: Markdown の `**text**` および `__text__`
- イタリック: Markdown の `*text*` および `_text_`

## 例外

以下の場合は例外として扱う。

- コードブロック内の記号・キーワード（言語仕様で `*` や `_` が出てくる場合）は変更しない。
- ファイル名・パス・コード断片をそのまま引用する場合は装飾しない（プレーンテキストのまま）。
- ユーザーが「太字で」「絵文字を使って」などと明示的に指示した場合は、ユーザー指示を優先する。
- 体言止めについても、ユーザーが「ですます調で」「である調で」など文体を指定した場合は、ユーザー指示を優先する。

## 運用

見出し（`##`）は使用可能。見出し語句そのものに太字は使わない。装飾の禁止は「見出し以外の本文中」の絵文字・太字・イタリックに適用する。
