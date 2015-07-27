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

		if($q == 0)
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
		
	}

	public function forceLogin($email, $remember = false)
	{
		# ...
	}

	public function isLoggedIn()
	{
		# ...
	}

	public function logout()
	{
		# ...
	}

}