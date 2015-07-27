<?php 

namespace App\Library;

use Aurora\Session;

class Auth
{

	protected $Session;

	public function __construct(Session $Session)
	{
		$this->Session = $Session;
	}


	public function createUser($username, $password, $mail = "foo@bar.com", $activated = false)
	{

	}
}