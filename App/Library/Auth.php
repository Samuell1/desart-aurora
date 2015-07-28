<?php

namespace App\Library;

use Aurora\Session;
use Spot\Locator;
use Spot\Mapper;

class Auth
{

	protected $Session;
	protected $DB;
	protected $User;
	protected $Hash;

	public function __construct(Session $Session, Locator $DB, Mapper $Mapper)
	{

		$this->Session = $Session;
		$this->DB      = $DB;
		$this->User    = $Mapper;
		$this->Hash    = new \VeeneX\Perzeus("ZjZ4a6gNnE", "8gcQEJJp82", "Zc0TdeSCrX", 48, 89, 107);

	}


	public function createUser($username, $password, $email, $activated = false)
	{

		$q = $this->User->where(["username" => $username])->orWhere(["email" => $email])->count();

		if($q === 0)
		{
			$Hash = $this->Hash->createHash($password);

			$User = $this->User->build([
				"username"          => $username,
				"password"          => $Hash->hash,
				"rand"              => $Hash->rand,
				"email"             => $email,
				"account_activated" => (int) $activated
			]);


			return $this->User->save($User);
		}
		else
			return false;

	}

	public function login($email, $password, $remember = false)
	{

		$q = $this->User->where(["email" => $email])->orWhere(["password" => $password])->count();

		if($q === 0) 				 	return false; # If user is not found return false
		if($this->Session->has("auth")) return false; # IF session is set return false


		$this->Sesssion->set("auth", $email);

		return true;

	}

	public function forceLogin($email, $remember = false)
	{

		if ($this->Session->has("auth")) {
			return false; # IF session is set return false
		}

		$this->Sesssion->set("auth", $email);

		return true;

	}

	public function isLoggedIn()
	{
		return $this->Session->has("auth");
	}

	public function logout()
	{

		if ($this->Session->has("auth"))
			$this->Session->remove("auth");
		else
			return false;

	}

}
