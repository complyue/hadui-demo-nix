# demo for interactive stack project with hadui

## Quick Start

```shell
git clone https://github.com/complyue/hadui-demo
cd hadui-demo
stack build --exec hadui
```

![hadui-demo-fe](https://user-images.githubusercontent.com/15646573/67366682-88340e80-f5a6-11e9-94b7-ed6c66cf428e.png)
![hadui-demo-be](https://user-images.githubusercontent.com/15646573/67366681-88340e80-f5a6-11e9-99ea-a74e6ec54144.png)

## VSCode Integration

with `.vscode/tasks.json` defined as:

```json
{
  "version": "2.0.0",
  "presentation": {
    "reveal": "always",
    "panel": "new"
  },
  "tasks": [
    {
      "group": {
        "kind": "build",
        "isDefault": true
      },
      "label": "hadui-dev",
      "type": "shell",
      "command": "cd ${workspaceRoot}; stack build --exec hadui-dev"
    }
  ]
}
```

press `F7` to start `hadui-dev` for the project

![hadui-vscode](https://user-images.githubusercontent.com/15646573/67378020-26c96b00-f5b9-11e9-9780-302db88ff50d.png)

## Debugging with VSCode

coming sooner than later ...
