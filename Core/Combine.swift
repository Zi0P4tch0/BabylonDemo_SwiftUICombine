import Combine

func just<Output>(_ value: Output) -> AnyPublisher<Output, Never> {
    Just(value).eraseToAnyPublisher()
}
