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

	public function createUser($username, $password, $email, $ip, $activated = false)
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
				"ip"                => sprintf("%u", ip2long($ip)),
				"account_activated" => (int) $activated,
				"activation_code"   => sha1(microtime(), true),
			]);

			return $this->User->save($User);
		} else {
			return false;
		}

	}

	public function login($email, $password, $remember = false)
	{

		$User = $this->User->where(["email" => $email])->first();

		if(!$User)
		{
			return false;
		}

		$hash = $User->password;


		if(!$this->Hash->validatePassword($password, $hash, $User->rand))
		{
			return false; # If password doesnt match return false
		}
		if ($this->Session->has("auth")) {
			return false; # IF session is set return false
		}


		$this->Session->set("auth", $email);

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
			if($this->Session->remove("auth")) {
				return true;
			}
		}
		return false;
	}

}
