//
//  WebViewController.swift
//  PlantManager
//
//  Created by Elizaveta Shelemekh on 30.03.2023.
//

import UIKit
import WebKit

final class WebViewController: UIViewController, WKUIDelegate {
    
    // MARK: - Constants
    private let url: URL
    
    // MARK: - Subviews
    private var webView: WKWebView!
    
    // MARK: - Lifecycle
    init(url: URL) {
        self.url = url
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let myRequest = URLRequest(url: self.url)
        webView.load(myRequest)
    }
    
    // MARK: - Private Methods
    private func setupNavbar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "chevron.left"),
            style: .plain,
            target: self,
            action: #selector(goBack)
        )
        navigationItem.leftBarButtonItem?.tintColor = .label
    }
    
    @objc
    private func goBack() {
        self.navigationController?.popViewController(animated: true)
    }
}
