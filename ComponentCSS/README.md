# 再利用しやすいコンポーネントのcssを考える

## 課題1

### 問題点

- 文字色とマージンがハードコードされており、柔軟に設定できない

### 修正

- marginなどレイアウトに影響するスタイル指定は行わず、親で行う
- widthなど大きさに影響する固定値の指定をできるだけ行わない
- 要素タグに影響されにくくする

```
function ReusableButton() {
  return <button className="reusable-button">click me!</button>;
}

.reusable-button {
  box-sizing: border-box;
  margin: 0;
  cursor: pointer;
  display: inline-flex;
  justify-content: center;
  align-items: center;
  border: none;
  text-decoration: none;
}

.reusable-button[disabled] {
  pointer-events: none;
  background-color: gray;
}

```

### 参考

https://qiita.com/shouchida/items/c382cf78f8ffe6fbe65b

## 課題2

### 問題点

- .AppのFlexレイアウトに依存しているため、変更や追加があった場合に「Sidemenu」「MainContent」に影響を与える可能性がある

### 修正

- 子コンポーネントは親にどんなレイアウトで使われているかのスタイルを記述すべきでない

```
.sideMenu {
  /* flex: 0 0 300px; */
  background-color: blue;
}

.mainContent {
  /* flex: auto; */
  background-color: red;
}
```

### 参考

https://qiita.com/seya/items/8814e905693f00cdade2

## 課題3

<<<<<<< HEAD
### 問題点

- 必ずul要素内に配置する必要があり、親コンポーネントに依存してしまうため、単独では使えない

## 課題4

### 問題点

- 親と子のスタイルが衝突した際に子のスタイルが優先されてしまい、意図しないcssになってしまう可能性がある
- 親コンポーネントがスタイルの決定権を持っており(classNameを渡せる)、CustomButton自体がスタイルを管理できず、一貫したスタイルを保てなくなる

### 修正

- 親コンポーネントから受け取らない

```
export function CustomButton() {
  return (
    <button className={styles.custombutton}>
      click me!
    </button>
  );
}
```

### 参考

https://blog.uhy.ooo/entry/2020-12-19/css-component-design/