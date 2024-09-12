import { createApp } from 'vue'

const TodoItem = {
  props: ['todo'],
  methods: {
    toggleDone() {
      this.$emit('toggle-done', this.todo)
    },
    removeTodo() {
      this.$emit('remove-todo', this.todo)
    },
  },
  template: `
    <li :class="['list-group-item', 'clearfix', { 'list-group-item-success': todo.done }]">
      {{ todo.text }}
      <div class="pull-right" role="group">
        <button type="button" class="btn btn-xs btn-success img-circle custom-button-spacing" @click="toggleDone(todo)">
          &#x2713;
        </button>

        <button type="button" class="btn btn-xs btn-danger img-circle" @click="removeTodo(todo)">
          &#xff38;
        </button>
      </div>
    </li>
  `,
}

const TodoForm = {
  data() {
    return {
      newTodo: '',
    }
  },
  methods: {
    addTodo() {
      if (this.newTodo.trim() === '') return
      this.$emit('add-todo', this.newTodo)
      this.newTodo = ''
    },
  },
  template: `
    <div class="commentForm vert-offset-top-2">
      <hr>
      <div class="clearfix">
        <form class="todoForm form-horizontal" @submit.prevent="addTodo">
          <div class="form-group">
            <label htmlFor="task" class="col-md-2 control-label">
              Task
            </label>
            <div class="col-md-10">
              <input type="text" id="task" class="form-control" placeholder="What do you need to do?" v-model="newTodo">
            </div>
          </div>
          <div class="row">
            <div class="col-md-10 col-md-offset-2 text-right">
              <input type="submit" value="Save Item" class="btn btn-primary">
            </div>
          </div>
        </form>
      </div>
    </div>
  `,
}

const app = createApp({
  components: { TodoItem, TodoForm },
  data() {
    return {
      todos: [
        { id: 0, text: 'Wake up', done: false },
        { id: 1, text: 'Eat breakfast', done: false },
        { id: 2, text: 'Go to work', done: false },
      ],
      nextId: 3,
    }
  },
  methods: {
    addTodo(newTodo) {
      this.todos.push({ id: this.nextId++, text: newTodo, done: false })
    },
    removeTodo(todo) {
      this.todos = this.todos.filter((t) => t !== todo)
    },
    toggleDone(todo) {
      todo.done = !todo.done
    },
  },
  template: `
    <div class="well">
      <h1 class="vert-offset-top-0">To do:</h1>
      <ul class="list-group">
        <todo-item
          v-for="todo in todos"
          :key="todo.id"
          :todo="todo"
          @remove-todo="removeTodo"
          @toggle-done="toggleDone"
        ></todo-item>
      </ul>
      <todo-form @add-todo="addTodo"></todo-form>
    </div>
  `,
})

app.mount('#todoBox')
