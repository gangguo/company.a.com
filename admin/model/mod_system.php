<?php
namespace admin\model;

use sephp\func;
use sephp\sephp;
use sephp\core\req;
use sephp\core\db;
use common\model\pub_mod_model;

class mod_system extends pub_mod_model
{

	/**
	 * 获取菜单数据
	 * @param string $type
	 * @return array
	 */
	public static function get_menus($type = 'left_menu')
	{
		$file = PATH_APP .'config/menu.xml';

		//禁止引用外部xml实体
		libxml_disable_entity_loader(true);
		$xml   = file_get_contents($file);
		$array = json_decode(json_encode(simplexml_load_string($xml, 'SimpleXMLElement', LIBXML_NOCDATA)), true);

		$data = [];

		foreach ($array['menu'] as $key => $val) {
			if ($type != 'all' && isset($val['@attributes']['display']) && $val['@attributes']['display'] == 'none') {
				continue;
			}
			if ($type != 'left_menu') {
				$data[$key] = [
					'title'  => $val['@attributes']['name'],
					'icon'   => $val['@attributes']['icon'],
					'id'     => empty($val['@attributes']['id'])?'':$val['@attributes']['id'],
					'spread' => empty($v['@attributes']['spread'])?false:$v['@attributes']['spread']
				];
				if ($type != 'all') {
					continue;
				}
			}
			if (isset($val['menu'])) {
				$m = self::get_data_menu($val['menu'], $type);
				if (empty($m)) {
					continue;
				}
				if ($type == 'all') {
					$data[$key]['menu'] = $m;
				} elseif (!empty($val['@attributes']['id'])) {
					$data[$val['@attributes']['id']] = $m;
				}
			}

		}

		return $data;

	}

	public static function get_data_menu($val, $type) {
		foreach ($val as $k => $v) {
			if ($type != 'all' && isset($v['@attributes']['display']) && $v['@attributes']['display'] == 'none') {
				continue;
			}
			$data[$k] = [
				'title' => isset($v['@attributes']['name'])?$v['@attributes']['name']:
				(isset($v['name'])?$v['name']:show_msg::error('菜单配置错误')),
				'icon' => isset($v['@attributes']['icon'])?$v['@attributes']['icon']:
				(isset($v['icon'])?$v['icon']:''),
				'href' => isset($v['@attributes']['ac'])?'?ct='.$v['@attributes']['ct'].'&ac='.$v['@attributes']['ac']:
				(isset($v['ac'])?'?ct='.$v['ct'].'&ac='.$v['ac']:''),
				'data-id' => isset($v['@attributes']['ac'])?$v['@attributes']['ct'].'_'.$v['@attributes']['ac']:
				(isset($v['ct'])?$v['ct'].'_'.$v['ac']:''),
				'spread' => isset($v['@attributes']['spread'])?$v['@attributes']['spread']:false,
			];
			$data[$k]['id'] = isset($v['@attributes']['id'])?$v['@attributes']['name']:
			(isset($v['id'])?$v['id']:$data[$k]['title']);
			if (isset($v['menu'])) {
				$data[$k]['menu'] = self::get_data_menu($v['menu'], $type);
			}
		}
		return $data;
	}

	public static function parseMenu($menus = '', $id_name = '') {
		$json_menu = '';
		foreach ($menus as $menu) {
			$top_menu_id_name = $menu['@attributes']['id'];
			if (empty($menu['menu']) || $top_menu_id_name != $id_name) {
				continue;
			}
			foreach ($menu['menu'] as $child) {

				if (isset($child['@attributes']['display']) && $child['@attributes']['display'] == 'none') {
					continue;
				}
				$json_menu[] = [
					'title'  => $child['@attributes']['name'],
					'icon'   => $child['@attributes']['icon'],
					'href'   => '?ct='.$child['@attributes']['ct'].'&ac='.$child['@attributes']['ac'],
					'spread' => empty($child['@attributes']['spread'])?false:$child['@attributes']['spread']
				];
			}
		}
		return (json_encode($json_menu));

	}

	public static function parseMenu_old() {
		$file = PATH_SEPHP.'../config/menu.xml';
		//禁止引用外部xml实体
		libxml_disable_entity_loader(true);
		$xml   = file_get_contents($file);
		$array = json_decode(json_encode(simplexml_load_string($xml, 'SimpleXMLElement', LIBXML_NOCDATA)), true);

		//print_r(($array['menu']));

		return true;

		$array = sysXml::xmlToArray(file_get_contents($file));
		$menus = array();
		foreach ($array['menus']['menu'] as $k => $v) {
			if (isset($v[0]['display']) && $v[0]['display'] == 'none') {continue;
			}

			$v[0]['url'] = '';
			if (isset($v[0]['ct']) && !empty($v[0]['ct'])) {
				$v[0]['url'] = '?ct='.$v[0]['ct'].'&ac='.$v[0]['ac'];
			}
			$menus[$k] = $v[0];
			if (isset($v['menu'])) {
				foreach ($v['menu'] as $val) {
					if (isset($val[0]['display']) && $val[0]['display'] == 'none') {continue;
					}

					$val[0]['url'] = '';
					if (isset($val[0]['ct']) && !empty($val[0]['ct'])) {
						$val[0]['url'] = '?ct='.$val[0]['ct'].'&ac='.$val[0]['ac'];
					}
					$menus[$k]['child'][] = $val[0];
				}

			}
		}
		return $menus;
	}
}
