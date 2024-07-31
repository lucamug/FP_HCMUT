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


## Videos

```
Step 01 04:32 Adds elm-ui
Step 02 03:07 Moves to Browser.element and Browser.Events.onAnimationFrameDelta
Step 03 03:10 Moves the button left and right
Step 04 01:44 Small refactoring
Step 05 03:01 Adds assets and Pause
Step 06 02:04 Adds vertical movement
Step 07 04:11 Adds aliens
Step 08 05:28 Adds buttons row and planet target
Step 09 04:15 Adds explosions
Step 19 06:39 Winning/Loosing logic - THE END
=============
Total   38:11
```