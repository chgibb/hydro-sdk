import { StatelessWidget } from "../../runtime/flutter/widgets/statelessWidget";
import { SizedBox } from "../../runtime/flutter/widgets/sizedBox";
import { Widget } from "../../runtime/flutter/widget";
import { Key } from "../../runtime/flutter/foundation/key";
import { InheritedWidget } from "../../runtime/flutter/widgets/inheritedWidget";
import { runApp } from "../../runtime/flutter/runApp";
import { pauseInDebugger } from "../../runtime/dart/developer/debugger";
import { Type } from "../../runtime/dart/core/type";
import { BuildContext } from "../../runtime/flutter/buildContext";

class Inherited extends InheritedWidget {
    public static runtimeType = new Type(Inherited.name);
    public runtimeType = Inherited.runtimeType;
    public child: Widget;
    public message: string;
    public constructor(props: {
        message: string,
        child: Widget
    }) {
        super();
        this.child = props.child;
        this.message = props.message;

        pauseInDebugger(this);
    }

    public static of(context: BuildContext): Inherited {
        return context.ancestorInheritedElementForWidgetOfExactType(Inherited.runtimeType);
    }
}

class InnerApp extends StatelessWidget {
    public build(context: BuildContext) {
        const inherited = Inherited.of(context);
        return new SizedBox({
            key: new Key(inherited.message)
        });
    }
}

class App extends StatelessWidget {

    public build() {
        return new Inherited({
            message: "inherited message",
            child: new InnerApp()
        });
    }
}

runApp(() => new App());