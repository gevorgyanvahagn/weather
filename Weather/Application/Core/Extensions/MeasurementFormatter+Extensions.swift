//
//  MeasurementFormatter+Extensions.swift
//  Weather
//
//  Created by Vahagn Gevorgyan on 20.11.20.
//

import Foundation

extension MeasurementFormatter {
    
    static func temperatureConverter(_ temperature: Double, from inputUnit: UnitTemperature, to outputUnit: UnitTemperature) -> String {
        let measurementFormatter = MeasurementFormatter()
        measurementFormatter.numberFormatter.maximumFractionDigits = 0
        measurementFormatter.unitOptions = .providedUnit
        let input = Measurement(value: temperature, unit: inputUnit)
        let output = input.converted(to: outputUnit)
        return measurementFormatter.string(from: output)
    }
    
    static func temperatureFormatter(_ temperature: Double, with inputUnit: UnitTemperature) -> String {
        let measurementFormatter = MeasurementFormatter()
        measurementFormatter.numberFormatter.maximumFractionDigits = 0
        measurementFormatter.unitOptions = .providedUnit
        let input = Measurement(value: temperature, unit: inputUnit)
        return measurementFormatter.string(from: input)
    }
    
}
