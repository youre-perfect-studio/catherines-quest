"""
Copyright(C) 2019 You're Perfect LLC, All Rights Reserved
Licensed under the MIT license, see LICENSE file in the
project root folder for more information.
"""
extends "res://addons/gut/test.gd"

func test_assert_true_with_true():
	assert_true(true, "true == true")
