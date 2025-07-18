
import UIKit
import SnapKit
import Then

class BookingViewController: UIViewController {

    // MARK: - Properties
    var movie: TMDBMovie? {
        didSet {
            // Update the title when a movie is set
            self.title = movie?.title ?? "Booking"
        }
    }
    private var selectedDateButton: UIButton?
    private var selectedTimeButton: UIButton?

    // MARK: - UI Components
    private let dateLabel = UILabel().then {
        $0.text = "Select Date"
        $0.textColor = .white
        $0.font = .boldSystemFont(ofSize: 20)
    }

    private let dateButtonsStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 10
        $0.distribution = .fillEqually
    }

    private let timeLabel = UILabel().then {
        $0.text = "Select Time"
        $0.textColor = .white
        $0.font = .boldSystemFont(ofSize: 20)
    }

    private let timeButtonsStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 10
        $0.distribution = .fillEqually
    }

    private let seatImageView = UIImageView().then {
        $0.image = UIImage(named: "seats") // Assuming you have a "seats.png" in your assets
        $0.backgroundColor = .darkGray
        $0.contentMode = .scaleAspectFit
    }

    private let proceedButton = UIButton(type: .system).then {
        $0.setTitle("Proceed to Payment", for: .normal)
        $0.backgroundColor = .red
        $0.setTitleColor(.white, for: .normal)
        $0.layer.cornerRadius = 8
    }

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setupUI()
        setupConstraints()
        setupButtons()
        
        // Configure navigation bar
        self.title = "Booking"
        navigationController?.navigationBar.prefersLargeTitles = false
    }

    // MARK: - UI Setup
    private func setupUI() {
        view.addSubview(dateLabel)
        view.addSubview(dateButtonsStackView)
        view.addSubview(timeLabel)
        view.addSubview(timeButtonsStackView)
        view.addSubview(seatImageView)
        view.addSubview(proceedButton)
    }

    private func setupConstraints() {
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.leading.equalToSuperview().inset(16)
        }

        dateButtonsStackView.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(50)
        }

        timeLabel.snp.makeConstraints { make in
            make.top.equalTo(dateButtonsStackView.snp.bottom).offset(20)
            make.leading.equalToSuperview().inset(16)
        }

        timeButtonsStackView.snp.makeConstraints { make in
            make.top.equalTo(timeLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(50)
        }

        seatImageView.snp.makeConstraints { make in
            make.top.equalTo(timeButtonsStackView.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalTo(proceedButton.snp.top).offset(-20)
        }

        proceedButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-20)
            make.height.equalTo(50)
        }
    }

    private func setupButtons() {
        // Add sample date buttons
        for i in 16...19 {
            let button = createStyledButton(title: "07/\(i)")
            button.addTarget(self, action: #selector(dateButtonTapped(_:)), for: .touchUpInside)
            dateButtonsStackView.addArrangedSubview(button)
        }

        // Add sample time buttons
        let times = ["12:00 PM", "3:00 PM", "6:00 PM", "9:00 PM"]
        for time in times {
            let button = createStyledButton(title: time)
            button.addTarget(self, action: #selector(timeButtonTapped(_:)), for: .touchUpInside)
            timeButtonsStackView.addArrangedSubview(button)
        }
    }
    
    private func createStyledButton(title: String) -> UIButton {
        return UIButton(type: .system).then {
            $0.setTitle(title, for: .normal)
            $0.setTitleColor(.white, for: .normal)
            $0.backgroundColor = .darkGray
            $0.layer.cornerRadius = 8
        }
    }

    // MARK: - Actions
    @objc private func dateButtonTapped(_ sender: UIButton) {
        // Deselect the previously selected button
        selectedDateButton?.backgroundColor = .darkGray
        selectedDateButton?.isSelected = false
        
        // Select the new button
        sender.backgroundColor = .red
        sender.isSelected = true
        selectedDateButton = sender
    }

    @objc private func timeButtonTapped(_ sender: UIButton) {
        // Deselect the previously selected button
        selectedTimeButton?.backgroundColor = .darkGray
        selectedTimeButton?.isSelected = false
        
        // Select the new button
        sender.backgroundColor = .red
        sender.isSelected = true
        selectedTimeButton = sender
    }
}
