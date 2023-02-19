//
//  FormTableViewCell.swift
//  Instagram
//
//  Created by Rushi Bhatt on 8/15/21.
//

import UIKit

protocol FormTableViewCellDelegate: AnyObject {
    
    func fieldTap(for cell: FormTableViewCell, didUpdate model: EditProfileCellModel)
    
}

final class FormTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "FormTableViewCell"
    
    weak var delegate: FormTableViewCellDelegate?
    private var model: EditProfileCellModel?
    
    let formFieldLabel: UILabel = {
        let lable = UILabel()
        lable.textColor = .label
        lable.numberOfLines = 1
        return lable
    }()
    
    let formField: UITextField = {
        let field = UITextField()
        field.autocorrectionType = .no
        field.autocapitalizationType = .none
        field.returnKeyType = .done
        return field
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(formFieldLabel)
        contentView.addSubview(formField)
        formField.delegate = self
        clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        formFieldLabel.frame = CGRect(x: 5, y: 0, width: contentView.width/4, height: contentView.height)
        formField.frame = CGRect(x: formFieldLabel.right + 10, y: 0, width: contentView.width - 10 - formFieldLabel.width , height: contentView.height)
    }
    
    override func prepareForReuse() {
        formField.text = nil
        formField.placeholder = nil
        formFieldLabel.text = nil
        self.model = nil
    }
    
    func configureCell(with model: EditProfileCellModel) {
        formFieldLabel.text = model.label
        formField.placeholder = model.placeHolder
        formField.text = model.value
        self.model = model
    }
}

extension FormTableViewCell: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        // Update the model with the information
        guard var model = model else { return true }
        model.value = textField.text
        delegate?.fieldTap(for: self, didUpdate: model)
        return true
    }
}
