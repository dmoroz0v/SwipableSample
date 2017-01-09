//
//  ViewController.swift
//  SwipeableSample
//
//  Created by Морозов Денис Сергеевич on 09/01/17.
//  Copyright © 2017 DMZ. All rights reserved.
//

import UIKit

enum Direction
{
	case same
	case left
	case right
}

extension CGPoint
{
	static var infinity: CGPoint
	{
		return CGPoint(x: CGFloat.infinity, y: CGFloat.infinity)
	}
}

class ViewController: UIViewController
{
	@IBOutlet var movingView: UIView!

	var prevPoint = CGPoint.infinity
	var direction = Direction.same

	override func viewDidLoad()
	{
		super.viewDidLoad()
	}

	@IBAction func pan(_ pan: UIGestureRecognizer)
	{
		let Offset: CGFloat = -260

		if pan.state == .began || pan.state == .changed || pan.state == .ended
		{
			let point = pan.location(in: self.view)

			if self.prevPoint != .infinity
			{
				var frame = self.movingView.frame
				frame.origin.x += (point.x - self.prevPoint.x)
				frame.origin.x = CGFloat.maximum(Offset, frame.origin.x)
				frame.origin.x = CGFloat.minimum(0, frame.origin.x)
				self.movingView.frame = frame
			}

			if point.x < self.prevPoint.x
			{
				self.direction = .left
			}
			else if point.x > self.prevPoint.x
			{
				self.direction = .right
			}
			else
			{
				self.direction = .same
			}

			self.prevPoint = point
		}

		if pan.state != .began && pan.state != .changed
		{
			let animations = {
				var frame = self.movingView.frame
				switch self.direction {
				case .same:
					if frame.origin.x > Offset / 2 {
						frame.origin.x = 0;
					} else {
						frame.origin.x = Offset;
					}
				case .left:
					frame.origin.x = Offset;
				case .right:
					frame.origin.x = 0;
				}
				self.movingView.frame = frame
			}

			UIView.animate(withDuration: 0.15, animations: animations)

			self.prevPoint = .infinity
			self.direction = .same
		}
	}
}

