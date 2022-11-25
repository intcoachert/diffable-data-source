# Пример работы с UITableViewDiffableDataSource

Сделал примерно на стэке MVVM. Во всех примерах реализации используются одинаковые ViewModel и ViewController - их смысла смотреть особого нет. 
Самое интересное в каталоге `DiffableDataSource/TableManagers` - именно там происходит работа с UITableViewDiffableDataSource.

## Что тут можно увидеть?
- Как работает DiffableDataSource - постарался даже ViewModel сделать, чтобы было правдоподобно, а не просто пример, оторванный от реальности
- Проблему самого простого подхода с обновлением видимой ячейки и один из способов её решения
