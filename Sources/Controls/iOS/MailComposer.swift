//
//  MailComposer.swift
//  ZamzamKit iOS
//
//  Created by Basem Emara on 2018-10-08.
//  Copyright © 2018 Zamzam Inc. All rights reserved.
//

import MessageUI

public protocol MailComposerType {
    typealias AttachmentType = (data: Data, mimeType: String, fileName: String)
    
    func canSendMail() -> Bool
    func makeViewController(email: String, subject: String?, body: String?, attachment: AttachmentType?) -> MFMailComposeViewController?
    func makeViewController(emails: [String], subject: String?, body: String?, attachment: AttachmentType?) -> MFMailComposeViewController?
}

public extension MailComposerType {
    
    func makeViewController(email: String) -> MFMailComposeViewController? {
        return makeViewController(email: email, subject: nil, body: nil, attachment: nil)
    }
    
    func makeViewController(email: String, subject: String, body: String) -> MFMailComposeViewController? {
        return makeViewController(email: email, subject: subject, body: body, attachment: nil)
    }
}

public protocol MailComposerDelegate: class {
    func mailComposer(didFinishWith result: MFMailComposeResult)
}

open class MailComposer: NSObject, MailComposerType {
    private weak var delegate: MailComposerDelegate?
    private let tintColor: UIColor?
    
    public init(delegate: MailComposerDelegate? = nil, tintColor: UIColor? = nil) {
        self.delegate = delegate
        self.tintColor = tintColor
    }
    
    /// Returns a Boolean indicating whether the current device is able to send email.
    open func canSendMail() -> Bool {
        return MFMailComposeViewController.canSendMail()
    }
}

public extension MailComposer {
    
    /// A standard interface for managing, editing, and sending an email message.
    func makeViewController(email: String, subject: String?, body: String?, attachment: AttachmentType?) -> MFMailComposeViewController? {
        return makeViewController(emails: [email], subject: subject, body: body, attachment: attachment)
    }
    
    /// A standard interface for managing, editing, and sending an email message.
    func makeViewController(emails: [String], subject: String?, body: String?, attachment: AttachmentType?) -> MFMailComposeViewController? {
        guard canSendMail() else { return nil }
        
        return MFMailComposeViewController().with {
            $0.mailComposeDelegate = self
            
            $0.setToRecipients(emails)
            
            if let subject = subject {
                $0.setSubject(subject)
            }
            
            if let body = body {
                $0.setMessageBody(body, isHTML: true)
            }
            
            if let attachment = attachment {
                $0.addAttachmentData(
                    attachment.data,
                    mimeType: attachment.mimeType,
                    fileName: attachment.fileName
                )
            }
            
            if let tintColor = tintColor {
                $0.navigationBar.tintColor = tintColor
            }
        }
    }
}

// MARK: MFMailComposeViewControllerDelegate

extension MailComposer: MFMailComposeViewControllerDelegate {
    
    public func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss {
            self.delegate?.mailComposer(didFinishWith: result)
        }
    }
}
