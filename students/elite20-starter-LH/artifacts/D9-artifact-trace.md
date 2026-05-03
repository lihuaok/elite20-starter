# D9 辅导案例与可追溯验证链

## 案例基本信息

| 属性 | 内容 |
|------|------|
| **案例名称** | Python 计算器代码辅导 |
| **学习者水平** | 初学者 |
| **辅导日期** | 2026-05-01 |
| **案例编号** | CASE-001 |

---

## 一、原始代码

```python
# 原始代码 - 简单计算器
def calculate(a, b, op):
    if op == '+':
        return a + b
    elif op == '-':
        return a - b
    elif op == '*':
        return a * b
    elif op == '/':
        return a / b

print(calculate(10, 5, '+'))
print(calculate(10, 0, '/'))  # 这行会出错
```

---

## 二、辅导流程记录

### Step 1: code_reviewer - 代码评阅

**调用时间**：2026-05-01 15:00
**Token 消耗**：520
**Prompt 版本**：P3

**输入**：上述原始代码

**输出摘要**：
- 总体评分：80/100
- 优点：逻辑清晰、基础功能完整
- 问题：缺少异常处理、除法没有边界检查
- 详见：[D5-skill-invocation.md](D5-skill-invocation.md#inv-001-code_reviewer-代码评阅)

---

### Step 2: bug_finder - 调试助手

**调用时间**：2026-05-01 15:15
**Token 消耗**：310
**Prompt 版本**：P3

**输入**：上述原始代码

**发现的问题**：
1. 除数为零会导致 ZeroDivisionError
2. 没有验证操作符是否有效
3. 没有输入类型检查

**详见**：[D5-skill-invocation.md](D5-skill-invocation.md#inv-002-bug_finder-调试助手)

---

### Step 3: best_practice - 最佳实践

**调用时间**：2026-05-01 15:30
**Token 消耗**：380
**Prompt 版本**：P3

**改进建议**：
1. 使用字典映射替代 if-elif 链
2. 添加类型注解
3. 添加文档字符串
4. 使用异常处理

**详见**：[D5-skill-invocation.md](D5-skill-invocation.md#inv-003-best_practice-最佳实践)

---

### Step 4: architecture_guide - 架构指导

**调用时间**：2026-05-01 15:45
**Token 消耗**：290
**Prompt 版本**：P3

**架构建议**：
1. 考虑封装为 Calculator 类
2. 使用策略模式提高扩展性
3. 添加单元测试

**详见**：[D5-skill-invocation.md](D5-skill-invocation.md#inv-004-architecture_guide-架构指导)

---

## 三、综合辅导报告

```
【代码辅导报告】

📊 总体评分：80/100

---

✅ 优点总结：
1. 代码逻辑清晰，变量命名规范
2. 基础功能实现完整
3. 注释适当，可读性好

---

📝 逐行代码分析：
[1] def calculate(a, b, op):：定义计算器函数
[2]     if op == '+':：判断加法操作
[3]         return a + b：执行加法
...
[10] print(calculate(10, 0, '/'))：测试除法，但除数为零会出错

---

🔍 逻辑分析：
整体思路清晰，通过条件判断实现不同运算，但缺少边界条件处理。

---

🐛 调试技巧：
问题1：除数为零会抛出 ZeroDivisionError
解决：添加除数检查或 try-except

问题2：无效操作符没有处理
解决：添加操作符验证

---

💡 最佳实践建议：

[改进1：添加异常处理]
```python
def calculate(a, b, op):
    try:
        if op == '+':
            return a + b
        elif op == '-':
            return a - b
        elif op == '*':
            return a * b
        elif op == '/':
            if b == 0:
                raise ValueError("除数不能为零")
            return a / b
        else:
            raise ValueError(f"不支持的操作符: {op}")
    except Exception as e:
        return f"错误: {e}"
```

[改进2：使用字典映射]
```python
def calculate(a, b, op):
    operations = {
        '+': lambda x, y: x + y,
        '-': lambda x, y: x - y,
        '*': lambda x, y: x * y,
        '/': lambda x, y: x / y if y != 0 else ValueError("除数不能为零")
    }
    if op not in operations:
        raise ValueError(f"不支持的操作符: {op}")
    return operations[op](a, b)
```

---

🏗️ 架构设计建议：
可以考虑封装为 Calculator 类，提高可扩展性和可测试性。

---

📈 学习追踪：
本次学习重点：异常处理、函数设计、代码优化
下次学习方向：面向对象设计、单元测试、设计模式

---

💪 鼓励：
你的代码基础很好！逻辑清晰是很大的优点。继续加油，完成任务是能力答卷，超越任务是认知革命！
```

---

## 四、改进后的代码

```python
# 改进后的计算器 - 版本 2.0
from typing import Union, Callable

Number = Union[int, float]

class Calculator:
    """简单计算器类，支持基本四则运算"""
    
    def __init__(self):
        self.operations: dict[str, Callable[[Number, Number], Number]] = {
            '+': lambda x, y: x + y,
            '-': lambda x, y: x - y,
            '*': lambda x, y: x * y,
            '/': self._divide
        }
    
    def _divide(self, a: Number, b: Number) -> Number:
        """除法运算，处理除数为零的情况"""
        if b == 0:
            raise ValueError("除数不能为零")
        return a / b
    
    def calculate(self, a: Number, b: Number, op: str) -> Number:
        """
        执行计算
        
        Args:
            a: 第一个操作数
            b: 第二个操作数
            op: 操作符 (+, -, *, /)
            
        Returns:
            计算结果
            
        Raises:
            ValueError: 操作符不支持或除数为零
        """
        if op not in self.operations:
            raise ValueError(f"不支持的操作符: {op}")
        return self.operations[op](a, b)


# 使用示例
if __name__ == "__main__":
    calc = Calculator()
    print(calc.calculate(10, 5, '+'))  # 输出: 15
    print(calc.calculate(10, 2, '/'))  # 输出: 5.0
    
    try:
        print(calc.calculate(10, 0, '/'))
    except ValueError as e:
        print(f"捕获到错误: {e}")  # 输出: 捕获到错误: 除数不能为零
```

---

## 五、可追溯验证链

### 验证点 1: Prompt 迭代

| 版本 | 文件 | 验证状态 |
|------|------|----------|
| P1 | [D4-P1.md](../prompts/D4-P1.md) | ✅ 已完成 |
| P2 | [D4-P2.md](../prompts/D4-P2.md) | ✅ 已完成 |
| P3 | [D4-P3.md](../prompts/D4-P3.md) | ✅ 已完成 |

### 验证点 2: Skill 调用

| 技能 | 文件 | 验证状态 |
|------|------|----------|
| code_reviewer | [D5-skill-invocation.md](D5-skill-invocation.md#inv-001-code_reviewer-代码评阅) | ✅ 已完成 |
| bug_finder | [D5-skill-invocation.md](D5-skill-invocation.md#inv-002-bug_finder-调试助手) | ✅ 已完成 |
| best_practice | [D5-skill-invocation.md](D5-skill-invocation.md#inv-003-best_practice-最佳实践) | ✅ 已完成 |
| architecture_guide | [D5-skill-invocation.md](D5-skill-invocation.md#inv-004-architecture_guide-架构指导) | ✅ 已完成 |

### 验证点 3: 拿来主义

| 复用项 | 文件 | 验证状态 |
|--------|------|----------|
| 项目结构 | [REUSE.md](../REUSE.md) | ✅ 已说明 |
| K-S-T-A-R 框架 | [REUSE.md](../REUSE.md) | ✅ 已说明 |
| 辅导标准 | [REUSE.md](../REUSE.md) | ✅ 已说明 |

---

## 六、学习效果评估

### 学习者反馈
- ✅ 理解了异常处理的重要性
- ✅ 学会了使用字典映射替代 if-elif
- ✅ 了解了面向对象设计的基本思想
- ✅ 建立了学习信心

### 下次学习计划
1. 学习单元测试
2. 深入理解设计模式
3. 实践更多代码重构

---

## 七、总结

本案例展示了完整的 AI 编程辅导流程，从原始代码到改进后的版本，通过四个技能的协同工作，提供了全面、细致、可操作的辅导。

**核心经验**：
1. 细致的辅导比笼统的评分更有价值
2. 具体的代码示例让学习更高效
3. 正向引导能建立学习信心
4. 完整的记录让学习过程可追溯

---

**辅导完成日期**：2026-05-01
**辅导师**：elite20-starter-LH + AI
**案例状态**：✅ 完成
