# [FP_HCMUT](https://github.com/lucamug/FP_HCMUT/) - Demystifying Functional Programming with Flying Saucer

To start the development environment:

```shell
git clone https://github.com/lucamug/FP_HCMUT.git
cd FP_HCMUT
npm install
npm start
```

Then open http://localhost:8000/ in the browser and edit the file `src/Main.elm` to modify the Elm script

To learn about Elm, refer to the [Official Elm Guide](https://guide.elm-lang.org/).

If something is not working, try installing these dependencies globally:

```
npm install -g elm
npm install -g elm-format
npm install -g elm-watch@2.0.0-beta.3
npm install -g elm-review
```

[Parcel](https://parceljs.org/languages/elm), [Vite](https://github.com/hmsk/vite-plugin-elm), and [other systems](https://www.lindsaykwardell.com/blog/setting-up-elm-in-2022) also support Elm.

Other available commands:

* `cmd/format` - Formats all Elm files
* `cmd/reactor` Uses a web server included in the Elm binary to run a development environment. It requires manual browser refresh.
* `cmd/review` Run a static code analyzer on the Elm code