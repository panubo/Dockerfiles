<?php
class ServiceDiscovery {

	/* Currently only support for etcd or an environment variable */

	public $host;
	public $port;

	private $etcd_base;

	function __construct($etcd_base = "/v2/keys/services/mysql") {

		$this->etcd_base = $etcd_base;

		/* See if values are already cached with apc */
		$this->host = apc_fetch("mysql_host");
		$this->port = apc_fetch("mysql_port");
		if ($this->host && $this->port) {
			return;
		}

		/* Check for ETCDCTL_PEERS environment variable */
		$etcd_peers = getenv("ETCDCTL_PEERS");
		if ($etcd_peers) {

			$url = explode(",", getenv("ETCDCTL_PEERS"))[0].$this->etcd_base;

			require_once 'HTTP/Request2.php';

			$request = new HTTP_Request2($url, HTTP_Request2::METHOD_GET);
			$res = $request->send();

			$content = json_decode($res->getBody());
			$this->host = explode(":", $content->node->nodes[0]->value)[0];
			$this->port = explode(":", $content->node->nodes[0]->value)[1];
			apc_add("mysql_host", $this->host, 10);
			apc_add("mysql_port", $this->port, 10);

			return;
		}

		/* Finally fall back to environment variables and defaults */
		$this->host = (getenv("MYSQL_HOST")) ? getenv("MYSQL_HOST") : "localhost";
		$this->port = (getenv("MYSQL_PORT")) ? getenv("MYSQL_PORT") : "3306";

	}

}
