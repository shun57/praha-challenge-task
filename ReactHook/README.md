# State hooks を理解して ToDo アプリを実装しよう

## 課題1

### フックのメリット

- 関数コンポーネントで状態やライフサイクル管理ができる
- classを使わずに利用できるため、コードの冗長化を防げる
- コンポーネント間でステートフルなロジックを再利用できる
- コンポーネントから複雑な状態管理・ライフサイクルロジックを排除できる

### 使えそうな外部フック例

- [useBeforeUnload](https://github.com/streamich/react-use/blob/master/docs/useBeforeUnload.md)
ページをリロードまたは閉じようとしたときにブラウザに警告する

- [useToggle](https://github.com/streamich/react-use/blob/master/docs/useToggle.md)
ブール値の値を追跡する React 状態フック

- [use-scroll-to-bottom](https://github.com/tudorgergely/use-scroll-to-bottom)
要素が最後までスクロールされたことを検出する

#### 参考

https://github.com/streamich/react-use

https://github.com/jaredpalmer/the-platform

https://github.com/rehooks/awesome-react-hooks

https://usehooks.com/

## 課題2

https://codepen.io/philmayfield/pen/MwRgyN
↓
[リファクタリング](todo.js)

## 課題3

### Container/Presentationalパターン

ロジックとUIを分けて実装することで関心の分離を図るフロントエンドのデザインパターン
ロジックを責務とするContainerとUIを責務とするPresentationalに分けて実装する

- Container
アプリケーションロジックに関心を持ち、APIや状態管理ライブラリから取得したデータをPresentationalに渡す

- Presentational
UIに関心を持ち、データをどのように表示するかという役割を持つ。Props以外の方法でデータを受け取ることはなく、内部で状態も持たない


#### メリット
- Componentの責務が明確になり、保守性が高くなる
- 役割が明確になるのでテストがしやすくなる
- 可読性の向上

### 任意のコンポーネントを「Container」と「Presentational」に分割する

https://github.com/shun57/nextjs-tutorial/pull/4/files

#### 参考

https://zenn.dev/buyselltech/articles/9460c75b7cd8d1

https://zenn.dev/morinokami/books/learning-patterns-1/viewer/presentational-container-pattern

### 「controlled」と「uncontrolled」コンポーネント

Reactのフォーム入力のハンドリングの違い
controlledはReactが管理する、uncontrolledはReactが管理せずDOM自身が扱う。
大抵の場合はcontrolled componentの使用が推奨される。

- 参考
https://ja.legacy.reactjs.org/docs/uncontrolled-components.html

#### メリット

##### controlled
- 変化があるたびに取得できるため値の制御がしやすい
- inputごとに管理を別々にできる

##### uncontrolled
- 結果だけ取得できる
- React以外のコードに簡単に値を渡せる

#### デメリット

##### controlled
- 状態管理のコードが複雑になる可能性がある

##### uncontrolled
- 状態管理やバリデーションが難しくなる
- テストがしづらい

#### 参考

https://zenn.dev/tns_00/articles/react-controlled-and-uncontrolled

https://qiita.com/jungyeounjae/items/8945df8580bcd0a4282f

https://qiita.com/kotarella1110/items/da32add730e2b5451704

## 課題4

1. useStateは条件分岐内で呼び出せますか？

https://tyotto-good.com/react/usestate-pitfalls

2. set関数で更新した値は即座に更新されますか？

https://tyotto-good.com/react/usestate-pitfalls

3. 下記でonSubmitされた場合、コンポーネントは何回再レンダリングされますか？

```
const [apple, setApple] = React.useState(0)
    const [banana, setBanana] = React.useState(0)
    const [lemon, setLemon] = React.useState(0)
    const onSubmit = (values) => {
        setApple(values.apple)
        setBanana(values.banana)
        setLemon(values.lemon)
    }
```

https://engineering.meetsmore.com/entry/2022/12/09/200953