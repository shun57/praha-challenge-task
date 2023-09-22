# 適切にコンポーネントを分割して1ページ作ってみよう

[課題内容](https://airtable.com/appPxhCPFYGqqN9YU/tblVlFr2q4lIqDKYc/viwX8r6DpCRp80swL/reca7aFOz5kp6cPQp?blocks=hide)

## 課題1

### アトミックデザインとは

UIデザイン設計手法の１つ。
UIは1つのページであると同時に、その構成要素(コンポーネント)の集合であるとし、
構成要素を5段階に階層分けして設計していくこと。
1つ目の階層から「原子:Atoms」->「分子:Molecules」->「有機体:organisms」->「テンプレート:templates」->「ページ:pages」と定義される。

#### Atoms
これ以上分解すると機能しなくなる最小単位のUIコンポーネントのこと。
例えば、buttonやlabel、inputなどを指し、これを組み合わせてMoleculesを作る。

#### Molecules
Atomを結合して作る要素のこと。それ１つで最小のUIコンポーネントとして機能するため再利用が可能。
例えば、フォームlabel+検索input+検索buttonを結合して、検索フォームMoleculesを構成できる。

#### Organisms
AtomやMolecules、または他のOrganismsから構成される複雑なUIコンポーネントのこと。
例えば、検索フォームMolecules+ロゴAtom+ナビゲーションMoleculesを結合して、ページヘッダーMoleculesを構成できる。

#### Templates
AtomやMolecules、Organismsを配置したページレイアウトのこと。デザインの基礎となるコンテンツ構造を明確にするページレベルのオブジェクト。テンプレートのため、具体的な中身（画像やテキスト）は挿入されない。

#### Pages
Templatesのインスタンスのこと。最終的なUIを示し、テキスト・画像が挿入された実際のコンテンツ。


#### 参考

[Brad Frost Atomic Design](https://atomicdesign.bradfrost.com/table-of-contents/)


### React 関数コンポーネントとクラスコンポーネント

#### 関数コンポーネントとクラスコンポーネントの違い

両方ともReactコンポーネントの記述方法。関数コンポーネントは標準的なJavaScript関数で、クラスコンポーネントはReact.Componentを拡張するES6のJavaScriptクラス。元々はState、Lifecycleが使えるクラスコンポーネントが推奨されていたが、現在は関数コンポーネント(React16.8以上)でも同様のことができるようになり、関数コンポーネントの使用が推奨されている。（クラスコンポーネントだと記述が冗長になるため）

#### コンポーネント例

https://codesandbox.io/embed/blissful-firefly-s8f0pk

#### 参考

[なぜクラスコンポーネントより関数コンポーネントが推奨されるのか?](https://zenn.dev/swata_dev/articles/7f8ef4333057d7)


## 課題2

### 模写

https://demo.vercel.store/

#### なぜposition: absoluteは使わない？

- 多用すると要素の配置の理解が難しくなりレイアウトの管理がしづらいため
- 要素位置が固定されるためレスポンシブデザインの際に柔軟性が制限されるため　
- テキストがある場合に表示崩れが起きやすくなる

#### 実装

- https://github.com/shun57/nextjs-tutorial/tree/develop
- https://github.com/shun57/nextjs-tutorial/pull/1


## 課題3

### Atomic Design問題点

- ルールを厳密に決めないとコンポーネントの分類にコストがかかり、明確に分類できないものも出てくる
- 作っていくうちにコンポーネントの粒度が変わる可能性があり、変更コストがかかる
- ルールを厳密にしても守られない可能性があり、そうなると密結合なコンポーネントが出来上がる
- AtomicDesign独自ディレクトリ名になるので、名が体を表していない
- 独自の実装がFatになりがち(organisms以降)


### ディレクトリ構造

```
│   ├── components
│   │   ├── layout ※page&template
│   │   │   └── [PageName]
│   │   │           ├── index.tsx
│   │   │           ├── index.test.tsx
│   │   │           └── [Component Name]/ ※特定のページのみのorganisms
│   │   ├── projects ※ページを跨いで呼び出されるorganisms
│   │   └── uiParts ※atomsとmolecules
│   │       ├── [Component Name]
│   │       │   ├── index.stories.tsx
│   │       │   ├── index.tsx
│   │       │   └── index.module.css
│   ├── page
```

## 参考

[Reactのディレクトリ構成でAtomicデザインをやめた話](https://zenn.dev/brachio_takumi/articles/2ab9ef9fbe4159)

[Atomic Designをやめてディレクトリ構造を見直した話](https://note.com/tabelog_frontend/n/n07b4077f5cf3)
