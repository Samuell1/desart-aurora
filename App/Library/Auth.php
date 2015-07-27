<?php 

namespace App\Library;

class Auth
{

	protected $Session;

	public function __construct(Session $sesion)
	{
		$this->$Session = $Session;
	}


	public function createUser($username, $password, $mail = "foo@bar.com", $activated = false)
	{
		# ...
	}

}