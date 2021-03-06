<?php

namespace App\Library;

use Aurora\Session;
use Spot\Locator;
use Spot\Mapper;
use VeeeneX\Perzeus;
use App\Library\Auth\Exception\UserNotFoundException;

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
				"hash"              => $Hash->hash,
				"rand"              => $Hash->rand,
				"email"             => $email,
				"active"			=> true,
				"hide_email"		=> true,
				"banned"			=> false,
				"ip"                => sprintf("%u", ip2long($ip)),
				"account_activated" => (int) $activated,
				"activation_code"   => sha1(microtime(), true),
			]);

			return $this->User->save($User);
		}

		return false;
	}

	public function login($uid, $password, $remember = false)
	{
		try {
			$User = $this->getUser($uid, true);
		} catch(UserNotFoundException $e) {
			return false;
		}


		if (!$this->Hash->validatePassword($password, $User->hash, $User->rand)) {
			return false; # If password doesnt match return false
		}

		if ($this->Session->has("auth")) {
			return false; # IF session is set return false
		}

		$this->Session->set("auth", $uid);

		return true;
	}

	public function forceLogin($email, $remember = false)
	{

		if ($this->Session->has("auth")) {
			return false; # IF session is set return false
		}

		$this->Session->set("auth", $email);

		return true;

	}

	public function isLoggedIn()
	{
		return $this->Session->has("auth");
	}

	public function logout()
	{

		if ($this->Session->has("auth")) {
			if ($this->Session->remove("auth")) {
				return true;
			}
		}
		return false;
	}

	public function getUser($uid, $force = true)
	{
		$User = $this->User
			->where(["email" => $uid])
			->orWhere(["username" => $uid])
			->orWhere(["id" => $uid])
			->first();

		if (!$User) {
			throw new UserNotFoundException("User not found");
		}

		return $User;
	}

	public function getUserMapper()
	{
		return $this->User;
	}
}
