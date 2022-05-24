//
//  WeatherViewControllerConstraints.swift
//  Weather
//
//  Created by admin on 24.05.2022.
//

import Foundation

extension WeatherViewController {
    func setupConstraints() {
        view.addSubview(background)
        background.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        view.addSubview(locationButton)
        locationButton.snp.makeConstraints { make in
            make.left.equalTo(background).inset(15)
            make.top.equalTo(background).inset(40)
            make.width.height.equalTo(40)
        }

        view.addSubview(searchButton)
        searchButton.snp.makeConstraints { make in
            make.right.equalTo(background).inset(15)
            make.top.equalTo(background).inset(40)
            make.width.height.equalTo(40)
        }

        view.addSubview(searchTextField)
        searchTextField.snp.makeConstraints { make in
            make.top.equalTo(background).inset(40)
            make.left.equalTo(locationButton).inset(40)
            make.right.equalTo(searchButton).inset(40)
            make.height.equalTo(40)

        }

        view.addSubview(conditionImageView)
        conditionImageView.snp.makeConstraints { make in
            make.top.equalTo(searchTextField).inset(50)
            make.right.equalTo(background).inset(15)
            make.width.height.equalTo(120)
        }

        view.addSubview(temperatureSign)
        temperatureSign.snp.makeConstraints { make in
            make.top.equalTo(conditionImageView.snp_bottomMargin)
            make.right.equalTo(background).offset(-15)
        }

        view.addSubview(temperatureLabel)
        temperatureLabel.snp.makeConstraints { make in
            make.right.equalTo(temperatureSign.snp_leftMargin).offset(-15)
            make.top.equalTo(conditionImageView.snp_bottomMargin)
        }

        view.addSubview(cityLabel)
        cityLabel.snp.makeConstraints { make in
            make.top.equalTo(temperatureSign.snp_bottomMargin).offset(15)
            make.right.equalTo(background).offset(-15)
        }
    }
}
