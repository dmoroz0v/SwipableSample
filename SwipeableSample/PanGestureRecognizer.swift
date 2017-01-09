//
//  PanGestureRecognizer.swift
//  SwipeableSample
//
//  Created by Морозов Денис Сергеевич on 09/01/17.
//  Copyright © 2017 DMZ. All rights reserved.
//

import Foundation
import UIKit
import UIKit.UIGestureRecognizerSubclass

final internal class PanGestureRecognizer : UIGestureRecognizer
{
	internal override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent)
	{
		super.touchesBegan(touches, with: event)

		if touches.count > 1
		{
			self.state = .failed
			return
		}

		self.state = .began
	}

	internal override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent)
	{
		super.touchesMoved(touches, with: event)

		if self.state == .failed || self.state == .recognized || self.state == .ended
		{
			return
		}

		self.state = .changed
	}

	internal override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent)
	{
		super.touchesEnded(touches, with: event)

		self.state = .ended

	}

	internal override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent)
	{
		super.touchesCancelled(touches, with: event)

		self.state = .cancelled
	}
}
