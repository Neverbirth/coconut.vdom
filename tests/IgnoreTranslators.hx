import coconut.ui.*;
import js.Browser.*;
import js.html.*;
import tink.state.State;

// With `-D coconut.vdom.ignore_translators`, the renderer leaves the nodes it inserts as they are.
@:asserts
class IgnoreTranslators {
  public function new() {}

  public function nodesAreNotMarked() {
    var c = document.createDivElement(), text = new State('eins');
    document.body.appendChild(c);
    Renderer.mount(c, '<Isolated><div>${text.value}<span>x</span></div></Isolated>');
    var div = c.firstChild;

    for (next in ['zwei', 'drei']) {
      text.set(next);
      Renderer.updateAll();
      asserts.assert(div.textContent == next + 'x');
      for (i in 0...div.childNodes.length) {
        final marked:Bool = untyped div.childNodes[i].__coconutText != null;
        asserts.assert(!marked);
      }
    }

    document.body.removeChild(c);
    return asserts.done();
  }
}
