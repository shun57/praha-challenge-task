# Effect hookを理解する

## 課題1

### なぜclean upが必要か？

- メモリリークを防ぐため：clean upがないとコンポーネントがアンマウント(DOMから削除)されてもリソースが解放されない可能性があるため

### 第二引数による動作の違い

- 何も指定しなかった場合: 初回含めてレンダリング毎に処理が実行される

- 空の配列（[]）を指定した場合: 初回のレンダリングの際にのみ処理が実行される

## 課題2

https://codesandbox.io/s/use-effect-demo-forked-64hx9c?file=/src/some-component.js

## 課題3

https://codesandbox.io/s/use-effect-demo-forked-64hx9c?file=/src/fetch-component.js

## 課題4

1. useEffectではrace conditionが起きる可能性があります。どのように防げますか？
[答え](https://zenn.dev/takuyakikuchi/articles/a96b8d97a0450c)

1. すでにあるpropsやstateから生成されるものはstateで管理すべきでしょうか？例えば以下のコードはbetterでしょうか？
```
function Form() {
  const [firstName, setFirstName] = useState('Taylor');
  const [lastName, setLastName] = useState('Swift');

  const [fullName, setFullName] = useState('');
  useEffect(() => {
    setFullName(firstName + ' ' + lastName);
  }, [firstName, lastName]);
}
```
[答え](https://zenn.dev/fujiyama/articles/c26acc641c4e30)


1. 以下のコードではpropsから渡されたfilterでtodosをフィルタリングしています。このuseEffectは必要でしょうか？
```
function TodoList({ todos, filter }) {
  const [newTodo, setNewTodo] = useState('');
  const [visibleTodos, setVisibleTodos] = useState([]);

  useEffect(() => {
    setVisibleTodos(getFilteredTodos(todos, filter));
  }, [todos, filter]);
}
```
[答え](https://zenn.dev/fujiyama/articles/c26acc641c4e30)