module.exports = {
  config: {
    // font
    fontSize: 16,
    fontFamily: '"Ricty Diminished"',

    // color
    foregroundColor: "lightGray",
    cursorColor: "#ff0000",
    selectionColor: "rgba(255, 255, 255, 0.5)",
    borderColor: "#333",

    // hyper-statusbar
    statusbar: {
      panels: ["battery", "user", "ip", "cpu", "memory", "clock"],
    },
  },

  plugins: ["hyperpower"],
  localPlugins: ["hyper-statusbar"],
};
