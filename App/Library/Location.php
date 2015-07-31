<?php 

namespace App\Library;

class Location
{

	protected $Loc;

	function __construct($ip = "208.80.152.201")
	{

		$this->Loc = json_decode(file_get_contents("http://ip-api.com/json/{$ip}"));

		$this->verifyLocation();

	}

	protected function verifyLocation()
	{

		if ($this->Loc->status !== "success") {
			
			throw new \Exception("fuck you bitch");

		}

	}

	public function getCountryCode()
	{

		return $this->Loc->countryCode;

	}
}