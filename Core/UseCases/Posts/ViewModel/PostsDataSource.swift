import Foundation

final class PostsDataSource: NSObject,
UITableViewDelegate,
UITableViewDataSource {

    let viewModels: [PostsTableViewCellViewModelType]

    init(viewModels: [PostsTableViewCellViewModelType]) {
        self.viewModels = viewModels
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }

    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PostsTableViewCell.identifier) as? PostsTableViewCell else {
            fatalError("Could not dequeue a PostsTableViewCell!")
        }
        cell.viewModel = viewModels[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewModel = viewModels[indexPath.row]
        viewModel.inputs.tapped()
    }

}
