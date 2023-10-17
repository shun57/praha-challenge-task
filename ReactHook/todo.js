import React, { useState, useRef } from "https://cdn.skypack.dev/react@17.0.1";
import ReactDOM from "https://cdn.skypack.dev/react-dom@17.0.1";

const TodoBox = () => {
  const { dataList, addData, removeData, replaceData } = useData();

  const generateId = () => {
    return Math.floor(Math.random() * 90000) + 10000;
  };

  const handleNodeRemoval = (index) => {
    removeData(index);
  };

  const handleSubmit = (task) => {
    const id = String(generateId());
    const complete = "false";
    const data = [...dataList, { id, task, complete }];
    addData(data);
  };

  const handleToggleComplete = (nodeId) => {
    const data = dataList.map((item) => {
      if (item.id === nodeId) {
        return {
          ...item,
          complete: item.complete === "true" ? "false" : "true",
        };
      }
      return item;
    });
    replaceData(data);
  };

  return (
    <div className="well">
      <h1 className="vert-offset-top-0">To do:</h1>
      <TodoList
        data={dataList}
        removeNode={handleNodeRemoval}
        toggleComplete={handleToggleComplete}
      />
      <TodoForm onTaskSubmit={handleSubmit} />
    </div>
  );
};

const TodoList = ({ data, removeNode, toggleComplete }) => {
  return (
    <ul className="list-group">
      {data.map(({ id, task, complete }, index) => (
        <TodoItem
          key={id}
          nodeId={id}
          task={task}
          complete={complete}
          removeNode={removeNode}
          toggleComplete={toggleComplete}
        />
      ))}
    </ul>
  );
};

const TodoItem = ({ nodeId, task, complete, removeNode, toggleComplete }) => {
  const removeItem = () => {
    removeNode(nodeId);
  };

  const itemComplete = () => {
    toggleComplete(nodeId);
  };

  let classes = "list-group-item clearfix";
  if (complete === "true") {
    classes += " list-group-item-success";
  }

  return (
    <li className={classes}>
      {task}
      <div className="pull-right" role="group">
        <button
          type="button"
          className="btn btn-xs btn-success img-circle"
          onClick={itemComplete}
        >
          &#x2713;
        </button>
        　
        <button
          type="button"
          className="btn btn-xs btn-danger img-circle"
          onClick={removeItem}
        >
          &#xff38;
        </button>
      </div>
    </li>
  );
};

const TodoForm = ({ onTaskSubmit }) => {
  const [task, setTask] = useState("");

  const handleChange = (e) => {
    setTask(() => e.target.value);
  };

  const doSubmit = (e) => {
    e.preventDefault();
    if (!task) {
      return;
    }
    onTaskSubmit(task);
    setTask("");
  };

  return (
    <div className="commentForm vert-offset-top-2">
      <hr />
      <div className="clearfix">
        <form className="todoForm form-horizontal" onSubmit={doSubmit}>
          <div className="form-group">
            <label htmlFor="task" className="col-md-2 control-label">
              Task
            </label>
            <div className="col-md-10">
              <input
                type="text"
                id="task"
                className="form-control"
                placeholder="What do you need to do?"
                value={task}
                onChange={handleChange}
              />
            </div>
          </div>
          <div className="row">
            <div className="col-md-10 col-md-offset-2 text-right">
              <input
                type="submit"
                value="Save Item"
                className="btn btn-primary"
              />
            </div>
          </div>
        </form>
      </div>
    </div>
  );
};

function useData() {
  const initialData = [
    { id: "00001", task: "Wake up", complete: "false" },
    { id: "00002", task: "Eat breakfast", complete: "false" },
    { id: "00003", task: "Go to work", complete: "false" },
  ];
  const [dataList, setDataList] = useState(initialData);

  const addData = (newData) => {
    setDataList(newData);
  };

  const removeData = (nodeId) => {
    const newData = dataList.filter((data) => data.id !== nodeId);
    setDataList(newData);
  };

  const replaceData = (newData) => {
    setDataList(newData);
  };

  return {
    dataList,
    addData,
    removeData,
    replaceData,
  };
}

ReactDOM.render(<TodoBox />, document.getElementById("todoBox"));
