<?php 

namespace App\Library;

class Hash 
{

	/**
	 * hash($value, $salt, $cost);
	 * min. length of salt is 22
	 * min. value of cost is 4
	 *
	 * return hashed string
	 */

	function hash($val, $salt = "1a2b3c4d5e1a2b3c4d5eeb", $cost = 4)
	{
		return password_hash($val, PASSWORD_BCRYPT, ["salt" => $salt, "cost" => $cost]);
	}

	/**
	 * check_hash($value, $hashed_value)
	 *
	 * return boolean(true if string equals hash)
	 */
	function check_hash($val, $hash)
	{
		return password_verify($val, $hash);
	}

}