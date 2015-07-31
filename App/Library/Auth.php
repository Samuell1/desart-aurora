<?php

namespace App\Library;

use Aurora\Session;
use Spot\Locator;
use Spot\Mapper;
use VeeeneX\Perzeus;

class Auth
{

	protected $Session;
	protected $DB;
	protected $User;
	protected $Hash;

	public function __construct(Session $Session, Mapper $Mapper)
	{

		$this->Session = $Session;
		$this->User    = $Mapper;
		$this->Hash    = new Perzeus("ZjZ4a6gNnE", "3zrz9yr5Z08gcQEJJp82Z08", "Zc0TdeSCrX", 48, 89, 107);

	}

	public function createUser($username, $password, $email, $activated = false)
	{

		$q = $this->User
			->where(["username" => $username])
			->orWhere(["email" => $email])
			->count();

		if ($q === 0) {
			$Hash = $this->Hash->createHash($password);

			$User = $this->User->build([
				"username"          => $username,
				"password"          => $Hash->hash,
				"rand"              => $Hash->rand,
				"email"             => $email,
				"account_activated" => (int) $activated
			]);

			return $this->User->save($User);
		} else {
			return false;
		}

	}

	public function login($email, $password, $remember = false)
	{

		$Hash = $this->Hash->createHash($password);

		$q = $this->User
			->where([
				"email"    => $email,
				"password" => $Hash->hash,
				"rand"     => $Hash->rand
			])
			->count();

		if ($q === 0) {
			return false; # If user is not found return false
		}
		if ($this->Session->has("auth")) {
			return false; # IF session is set return false
		}

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

		if ($this->Session->has("auth")) {
			$this->Session->remove("auth");
			return true;
		}
		return false;
	}

}
