import UIKit

class CustomCellTableViewCell: UITableViewCell {


    @IBOutlet weak var myImageView: UIImageView!

    @IBOutlet weak var myTextView: UITextView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
