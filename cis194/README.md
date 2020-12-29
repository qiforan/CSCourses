# cis 194 note & homework

## 1. 基础

一个 List 由方括号括起，其中的元素用逗号分隔开来。

`:` 运算子可以连接一个元素到一个 List 或者字符串之中，而 `++` 运算子则是连接两个 List。

```shell script
Prelude> :t (:)
(:) :: a -> [a] -> [a]
Prelude> :t (++)
(++) :: [a] -> [a] -> [a]
```

### 1.1. List 常见函数

* `length` 返回一个 List 的长度
* `null` 检查一个 List 是否为空
* `reverse` 将一个 List 反转
* `take` 返回一个 List 的前几个元素
* `maximum` 返回一个 List 中最大的那个元素。 
* `minimun` 返回最小的。
* `sum` 返回一个 List 中所有元素的和。
* `elem` 判断一个元素是否在包含于一个 List

```shell script
Prelude> :t length
length :: Foldable t => t a -> Int
Prelude> :t null
null :: Foldable t => t a -> Bool
Prelude> :t reverse
reverse :: [a] -> [a]
Prelude> :t maximum
maximum :: (Foldable t, Ord a) => t a -> a
Prelude> :t minimun
Prelude> :t minimum
minimum :: (Foldable t, Ord a) => t a -> a
Prelude> :t sum
sum :: (Foldable t, Num a) => t a -> a
Prelude> :t elem
elem :: (Foldable t, Eq a) => a -> t a -> Bool
```

### 1.2. Range

在 List 使用 `..` 来简略表示一个有序的列表，如 `[1..10]` 表示 `1,2,3,...,10` 的列表。
你可以指定 range 的步长，如 `[1,3..10]` 表示 `1,3,5,...,9` 的列表。你甚至可以不标明 Range 的上限，使之成为无限列表。

常用函数：
* `take` 从 List 取前几个元素 
* `repeat` 接受一个参数，生成该值的无限 List 
* `replicate` 生成相同值的有限 List

```shell script
Prelude> :t take
take :: Int -> [a] -> [a]
Prelude> :t repeat
repeat :: a -> [a]
```

### 1.3. List Comprehension


类型参数 类型构造子 值构造子

在声明数据类型时，等号 = 左端的那个是类型构造子，右端的 (中间可能有 | 分隔) 都是值构造子。