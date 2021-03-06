# Julia 0.6 から 1.x への移植

## 整数の直後に `.^` と書かない

例えば，`2.^3` のように，整数の直後に `.^` を置く式は，意図が不明瞭なので禁止された．
`.^` の前が整数であることを明示するには，`.^` の前に空白を書く．
`.^` の前が浮動小数点数あることを明示するには，ピリオドのあとに数字を書く．

```@repl
2.^3 # エラー
2 .^3
2.0.^3
```

## 配列とスカラーの加減算は `.+`, `.-` を用いる

v0.6.4 では，
配列 `v` にスカラー `a` を加減する（ `v+a` または `v-a` ）ことができたが，
v1.x ではできなくなった．
代わりに，`v.+a` または `v.-a` とする．
あるいは，式の前に `@.` を置いて，`@. v+a` または `@. v-a` と書いてもよい．

1次元配列（ベクトル）の場合

```@repl
v = [1, 2, 3, 4]
v + 1 # エラー
v .+ 1
@. v + 1
v - 1 # エラー
v .- 1
@. v - 1
```

2次元配列（行列）の場合

```@repl
m=[ 1 2; 3 4]
m+1 # エラー
m.+1
@. m+1
m-1 # エラー
m.-1
@. m-1
```

## 配列とスカラーの加減算による更新は `.+=`, `.-=` を用いる

v0.6.4 では，
配列 `v` にスカラー `a` を加減して更新すること（ `v+a` または `v-a` ）ができたが，
v1.x ではできなくなった．
代わりに，`v.+=a` または `v.=a` とする．
あるいは，式の前に `@.` を置いて，`@. v+=a` または `@. v-=a` と書いてもよい．

1次元配列（ベクトル）の場合

```@repl
v = [1, 2, 3, 4]
v += 1 # エラー
v .+= 1
@. v += 1
v -= 1 # エラー
v .-= 1
@. v -= 1
```

2次元配列（行列）の場合

```@repl
m = [1 2; 3 4]
m += 1 # エラー
m .+= 1
@. m += 1
m -= 1 # エラー
m .-= 1
@. m -= 1
```


なお，配列 `v` にスカラー `a` を乗除して更新すること（ `v*=a` または `v/=a` ）は v1.x でも可能である．

```@repl
v = [1, 2, 3, 4]
v *= 2
v /= 2
```


## `zeros(a)` は廃止． `zero(a)` を用いる

v0.6.4 では，配列 `a` に対して `zeros(a)` というメソッドがあったが，廃止された．
v1.x では，代わりに `zero(a)`　を用いる．

このメソッドは，`a` の要素と同じ要素の型で，`a` と同じ寸法の配列を作り，
要素の値を全て `0` にする命令である．

```@repl
a = [1 2; 3 4]
zeros(a) # エラー
zero(a)
a *= 1.0
zeros(a)
```

## `ones(a)` は廃止． `one(a)`を用いる

v0.6.4 では，配列 `a` に対して `zeros(a)` というメソッドがあったが，廃止された．
v1.1 では，代わりに `zero(a)`　を用いる．

このメソッドは，`a` の要素と同じ要素の型で，`a` と同じ寸法の配列を作り，
要素の値を全て `1` にする命令である．

```@repl
a = [1 2; 3 4]
ones(a) # エラー
one(a)
a *= 1.0
one(a)
```

## `realmax(t), realmin(t)` は廃止． `floatmax(t)`, `floatmin(t)` を用いる

v0.6.4 の，型 `t` に対する関数 `realmax(a)`, `realmin` は廃止となった．
代わりに，
v0.6.4 の，型 `t` に対する関数 `floatmax(a)`, `floatmin` を用いる．

これらは各々，型 `t` で表される最大の数，最小の数を返す．


## `PyPlot` パッケージでは `o.m` の形式が推奨される

v0.6.4 では，PyPlot パッケージで `o[:s]`　の形で，
オブジェクト `o` のシンボル `s` を読むが，推奨されなくなった．
代わりに，`o.s` の形を使うことが推奨される．

* `plt[:figure]` は `plt.figure` とする．
* `ax1[:plot]` は `ax1.plot` とする．

```@repl
using PyPlot
fig = plt.figure()
ax1 = fig.add_subplot(121)
ax1.plot([3, 2, 1])
ax2 = fig.add_subplot(122)
ax2.plot([2, 3, 1])
plt.close("all") #hide
```

アスペクト比（縦横の寸法の比）を等しくするのに，
`plt[:axes]()[:set_aspect]("equal")` と書いていたが，
`plt.axes().set_aspect("equal")` とする．

```@repl
using PyPlot
plt.figure() #hide

xs = -1:0.1:1
ys = xs .^ 2;
zs = xs .^ 3;
plot(xs, ys);
plot(xs, zs);
plt.axes().set_aspect("equal")
plt.close("all") #hide
```

## `linspace` は廃止． `LinSpace` を用いる

v0.6.4で等差数列を作る `linspace` 関数は，v1.x で廃止された．

関数 `LinRange` または `range` を用いる．

v0.6.4 では
* `linspace(a,b)` は，初項 `a` ，最終項 `b` ，長さ 50 の等差数列を作る．
* `linspace(a,b,n)` は，初項 `a` ，最終項 `b` ，長さ `n` の等差数列を作る．

v1.1で，上の２つに対応するのは，関数 `LinRange(a,b,n)` である．
`LinRange` は３番目の引数を省略できない．

```@repl
linspace(-1, 1) # エラー
LinRange(-1, 1) # エラー
LinRange(-1, 1, 50)
```

より柔軟に等差数列を作るには，`range` 関数を用いる．

関数 `range` は，引数として，初項を必ず指定する必要がある．
関数 `range` に，２つの数字を引数に指定すると，２つ目の引数は最終項である．
最終項目は キーワードパラメータ `stop` で指定することもできる．
さらに，キーワード引数として，数列の長さ `length` ,等差 `step` を指定できる．
`step` の既定値は `1` である．

```@repl
range(1, 10) # エラー
# 初項 1, 最終項 10, 等差 1 (指定しない)
range(1, 10, length = 10)
# 初項 1, 最終項 10, 等差 2
range(1, 10, step = 2)
collect(ans)
```

なお，
最終項 `stop` と長さ `length` が指定され，
等差 `step` が指定されない場合には `step` は計算される．
したがって，v0.6.4 の `linspace(-1,1)` に対応する，もう一つの書き方は
`range(-1,1,length=50)`　である．

```@repl
r1 = LinRange(-1, 1, 50)
r2 = range(-1, 1, length = 50)
```

両者は計算方法が異なるので，数値は微妙に異なる．

```@repl
r1 = LinRange(-1, 1, 50); nothing #hide
r2 = range(-1, 1, length = 50); nothing #hide
r1 = collect(r1)
r2 = collect(r2)
r1 .== r2 # 全て true ではない
abs.(r1 .- r2) # 残差
isapprox.(r1, r2) # 全て true となる
```

## `logspace` は廃止． `exp10.(LinRange(a,b,n))` などを用いる

v0.6.4で，$10$ のべき乗で等比数列を作る `logspace` は，v1.x で廃止された．
代わりに，`exp10.(LinRange(a,b,n))` などを用いる．

```@repl
logspace(-2, 2, 5) # エラー
exp10.(LinRange(-2, 2, 5)) # LinRange を用いる
exp10.(range(-2, stop = 2)) # range を用いる
```


## `srand(n)` は廃止． `Random.seed!(n)` を用いる

v0.6.4 では，関数 `srand(m)`　を用いて，
乱数の種をリセットしたが，v1.x では廃止された．

代わりに，`Random` パッケージを `using` してから `Random.seed!(n)` を用いる．

```@repl
srand(1234) # エラー
using Random # Random パッケージを読み込む
Random.seed!(1234)
```
