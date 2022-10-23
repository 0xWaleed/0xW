function handleStateKey(key, value) {
  const stateHandlerName = `${key}Handler`;
  if (typeof window['stateHandler'] == "function") {
    window['stateHandler'](key, value);
  }

  if (typeof window[stateHandlerName] == "function") {
    window[stateHandlerName](value);
  }
}

(function () {
  window.addEventListener("message", function (e) {
    const state = e.data.state;
    const message = e.data.message;

    if (message !== "state") {
      return;
    }

    for (const stateKey in state) {
      handleStateKey(stateKey, state[stateKey]);
    }
  });
})();
