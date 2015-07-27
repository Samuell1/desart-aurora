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
		$this->Hash    = new Hash;
	}


	public function createUser($username, $password, $email, $activated = false)
	{

		$q = $this->User->where(["username" => $username])->orWhere(["email" => $email])->count();

		if($q === 0)
		{
			$User = $this->User->build([
				"username"          => $username,
				"password"          => $this->Hash->hash($password),
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
		if($this->Session->has("auth")) return false; # IF session is set return false


		$this->Sesssion->set("auth", $email);

		return true;
	}

	public function isLoggedIn()
	{
		if($this->Session->has("auth"))
			return true;
		else
			return false;
	}

	public function logout()
	{
		if($this->Session->has("auth"))
			$this->Session->remove("auth");
		else
			return false;
	}

}