Return-Path: <linux-efi+bounces-6017-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FB03D3A42B
	for <lists+linux-efi@lfdr.de>; Mon, 19 Jan 2026 11:06:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A50143065633
	for <lists+linux-efi@lfdr.de>; Mon, 19 Jan 2026 10:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E992634DB56;
	Mon, 19 Jan 2026 10:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GpEEGbk7"
X-Original-To: linux-efi@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011008.outbound.protection.outlook.com [52.101.52.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B6D11E32CF;
	Mon, 19 Jan 2026 10:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768816997; cv=fail; b=POcuEdfNOnGlaPIoNtsNdpJJTegzPqEIq0SCu50Ucl4oo9ZvHd5XkIfFwG49XWkeAovaZsmK+8C+GG1b6K8kf1UFk5EbXY/qa4wQTbF0/H9c+5vduF8lSK6RyUln/zE6iSnjL4pwjhf54mk78aoa0zZPb0bMlaB7Ogh74a3+1uQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768816997; c=relaxed/simple;
	bh=vANberz8ED21XySiZg6lXAglzcFmb8bJH7myL00/Hms=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aWje0mVLHgdYYnb+PbAW3ZnigiMOZCs5F6fVmvksQ5YiRV+PjHVHgW/Jf+zKLvR8CEgCeqFlTx1SX245E62TCJP3x6g2zsMDsVW656My9CA2YEUE1RYXhf+Xnms1SNnPqCFhl4GVrVrnXIZjinOZT0m6cbovFIfe6ro8uKPv10c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GpEEGbk7; arc=fail smtp.client-ip=52.101.52.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p3CeNXa875P5PVZfIPTFSvPlFIiYAVGRP7qIKbOMF50VBq/bXjRRgchRKswssq69Q1rzRk8OYIy/bAnQ7H7F1f1Hyb/QQUth/n+ijkDb0NMm09uwR4VD/fn1LQ8H37Z5vmZn293DEN3USYGps06/cwLCXd6PG4UQN0Nz3EVTHiEqnUNKoBMjgzOSErAG0aeO02l3j6mPuP0/DxsSvxhoTR4iIV3XpLVgRD1vIhDzFscUj+xbzVS7qvxPLqQK0qyPTBUQamEzEOsZ6Uv5Q3G+s3UNeXAFQgyhH/CvO/dAiy/L7x57itE73mgd+5HheO66UkEhPbll188OHHSXws2Hlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SFTKdGWFrjLyS8X5crONs5wz2+BPgW7kMXu+BJTcKJM=;
 b=hq41MtbtJiS17tSBC1Ph0P+lxankD+wdunl9T0LV9gpJHTr6UR4exBMcrJ/xMEVVDIdFcjXq+NWUYP25hyN40ZFhD1hVq3vSp/rHmwJ5qQ/Me8F5TfsHAGKkxqou179zP96+M9QE0Curv4QzaEXZJ7jLgBwyaT9heUk/g1l7juXO2Ke/aoePs06+D88RcFr526mRl+sWzd2oYxgngGNkIdCAysRZrIayOG7FWwMx3F/2qDj1n+5RrZsFgakHyxN7DClDFr2kmKvq15sFOd5s+Egfo0p1JpgYQr7U+WIOCddz66TVzbaEpavmuoXKWYjitgDN1rT1HcX4z8M7h/XixQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SFTKdGWFrjLyS8X5crONs5wz2+BPgW7kMXu+BJTcKJM=;
 b=GpEEGbk7ANKHd9QBBfgP6jdMW8KysYCBZeXGV+Y+3hLaeZ/x/+UcpizcLOKGoXefmaHOkWd/wtzwpZxFomGVUoBaiubfCmdekWeHAGI6ZnI5FX3aQcRPT475GRTeVROUIog6G+voGVGCoXCCmivH2SfGiTX/Qs/fPk0xo1QDyyg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS0PR12MB999103.namprd12.prod.outlook.com (2603:10b6:8:2fe::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.11; Mon, 19 Jan
 2026 10:03:14 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9520.011; Mon, 19 Jan 2026
 10:03:14 +0000
Message-ID: <8ae98c9c-9cea-4c31-b888-9e3fcda42d86@amd.com>
Date: Mon, 19 Jan 2026 11:03:00 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/12] Recover sysfb after DRM probe failure
To: Zack Rusin <zack.rusin@broadcom.com>,
 Thomas Zimmermann <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org, Alex Deucher
 <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
 Ard Biesheuvel <ardb@kernel.org>, Ce Sun <cesun102@amd.com>,
 Chia-I Wu <olvaffe@gmail.com>, Danilo Krummrich <dakr@kernel.org>,
 Dave Airlie <airlied@redhat.com>, Deepak Rawat <drawat.floss@gmail.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>,
 Hans de Goede <hansg@kernel.org>, Hawking Zhang <Hawking.Zhang@amd.com>,
 Helge Deller <deller@gmx.de>, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, Jani Nikula <jani.nikula@linux.intel.com>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Jocelyn Falempe <jfalempe@redhat.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Lijo Lazar <lijo.lazar@amd.com>, linux-efi@vger.kernel.org,
 linux-fbdev@vger.kernel.org, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, Lucas De Marchi <lucas.demarchi@intel.com>,
 Lyude Paul <lyude@redhat.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 "Mario Limonciello (AMD)" <superm1@kernel.org>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Maxime Ripard <mripard@kernel.org>, nouveau@lists.freedesktop.org,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Simona Vetter <simona@ffwll.ch>,
 spice-devel@lists.freedesktop.org,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, virtualization@lists.linux.dev,
 Vitaly Prosyak <vitaly.prosyak@amd.com>
References: <20251229215906.3688205-1-zack.rusin@broadcom.com>
 <c816f7ed-66e0-4773-b3d1-4769234bd30b@suse.de>
 <CABQX2QNQU4XZ1rJFqnJeMkz8WP=t9atj0BqXHbDQab7ZnAyJxg@mail.gmail.com>
 <97993761-5884-4ada-b345-9fb64819e02a@suse.de>
 <CABQX2QMn_dTh2h44LRwB7+RxGqK3Jn+QCx38xWrzpNJG5SZ9-Q@mail.gmail.com>
 <f3643c19-c250-4927-b39d-37d2494c7c84@suse.de>
 <CABQX2QM0_6DJtrahJS7x9iF_wcSZRc4dohEiPnMCtAg7Vt7JPQ@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <CABQX2QM0_6DJtrahJS7x9iF_wcSZRc4dohEiPnMCtAg7Vt7JPQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0078.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::20) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS0PR12MB999103:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ac04a43-7bcc-4274-7af4-08de5741f599
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UUErbXNjNXY5dFVJWjh6VEp0TkhMOGFhQXRSSzlEWXNhYXRCQUIyZXc3ZEZj?=
 =?utf-8?B?cENsd1N1eUFCYk5rQS95NjY4UDd2TlNOSCt3R0lMQU9wYVlIZXVLMVFGYTFK?=
 =?utf-8?B?TnBKakQ0a2tXbm5UYjgwUjJrdDdnKzZnMFVNNG1rVTlOVjhtbEdYUE5MREta?=
 =?utf-8?B?dnR5TWhIYmR5SE14UGx0Nzd3S2pMaHB6eUF4OEl4dk9pU3BIbG1meXltUkMz?=
 =?utf-8?B?SS9JOUIrRDhuejZiNSsyb2s0RG9uSmlxVUJjVDUzb1lkMnhteTEwV1k1Zndz?=
 =?utf-8?B?ajhpVjdpQzQrZHdPYkw5a1Z1MnRLb1g3MEwzRmxvTVQzcHpJZEhmOXU3dEZV?=
 =?utf-8?B?aU1LRWZFM1V1OWlMUkxoOFdrZ3RrWWNOdWMwanZEcEttckhpS28zSkVvdVJH?=
 =?utf-8?B?SnpCNUtOa2dKUFhQdCtwOE0rTTN3Q2htSjZYOThDbXVROGNZeGxCZk0wU1Vl?=
 =?utf-8?B?SEFLZVp6R2xycDh6TnVMM1plaVIxYmxUWEhnL1ltcmdST09MUVBGb25GblhH?=
 =?utf-8?B?dG1BS2hVUVFVdnp0M01lUEJ3T0JKaXFPS3JxZ2l5RGxWY256Y3pHVEw2SGtV?=
 =?utf-8?B?VWJ6RHp1a3UrZFlwdEw3dm5IT1htdThOR01EM0hqUTlIcXpTV0ZGa1pRSUZv?=
 =?utf-8?B?SENWVUk2WWJvSUxDaEJKMUwvQ0F2TVc1NStoU29xSHJMamc5ZGtPbGgvQXpn?=
 =?utf-8?B?Uk9VdzliYXNFRTk4TkFZV3d4aFFOOEZRRTFDQjBBVXBQeUdIaXpyc0FTWm5C?=
 =?utf-8?B?dG43UTFRYW90dHFGQjIwbW81MzRDOWdENVZJaks3ZkFxUXp4Smp0b015WXdY?=
 =?utf-8?B?ZkRLeFZVYUY1WGUyU2FOTERsTVdxR2VLRFIzQ2V4eWhHdFVzd1ZPSEpvbFF2?=
 =?utf-8?B?alpBdi9SdHlrcFp0Mjc4WnFKdzF1Qkp1a0pHNXplcjdlRTFMd05NZXhFOFRD?=
 =?utf-8?B?NXJtVmtVQ3VMNnpCNXdwR0Q3K2MzbURSK3ZINlhQUDJDL291anpyWXd6UHl0?=
 =?utf-8?B?QVU0LytVc1NKb2QyOEtiM2RNNUI0RFZrSjdhTzh5MDFOdjBFUWRqT2dHSWpW?=
 =?utf-8?B?Q3FCa0dhcEphd2VvbUJOOEZtcEZ1d2RjN3lZcjF1V1JMNjdJNTFmUFRzcUk0?=
 =?utf-8?B?N0dJVUpLOVhyOVJ0Tkw2TXducEJ5NWtpYW55UVBEMGdOak1tZnFmTXRzSUt6?=
 =?utf-8?B?WmFMVHBxeUtreFhBZWRZNEx1MGhWNXNuWEM0QWNON0xsSTV6UnV2bnAvWnZP?=
 =?utf-8?B?SW4za3IvUllwMFRyQ2dvaDJ2UHljdGh0Y3BOd0JNdHZqMkhiQjVBaHdxenVr?=
 =?utf-8?B?eDljSzFwZVNMUE1mZVZTM0Q0Zi84d2NLRHJVQitJMC9lc08zaHNSOTFjMlJD?=
 =?utf-8?B?a0VSbEQrcFdSMHdodnhZWUtxWDBjOWJFNldLWGN2eFd4Y0JyYytWSDVUWW81?=
 =?utf-8?B?N0ptRWpjbG1Gb0lPYzIrdUVKd1lEZjV6QmJ1K1VVdWJYSlB4cmhlbmVQQmNP?=
 =?utf-8?B?V3pVYjB0V1VmQUdkbUt6UCsvcW9tRGRrQWdjUnRzQ2xtMitKOU5yRmdGeGd0?=
 =?utf-8?B?ZWhDZFgyUllhbXBJV1dRSjZ6azE2azY5c0ZlVWl4S1lVQ0xWQS9DYmdNWHRB?=
 =?utf-8?B?aWhhbnNDeHYwMnJXL0RyVGREMkx5aHVEbGNqejZFZTdqc1BJZFU4WEdCTUR2?=
 =?utf-8?B?N29walZSMk5BZzUrRkdxcmcrRnlReEZmeUNmMzg1ZlZFMDBrMWNKWGVmOHlX?=
 =?utf-8?B?YVFHV1pra0lWTXIzU3FsTHJoMVJvVXhDNEQ3dFNncW9IKzg2ZUVyVnVlamZV?=
 =?utf-8?B?anpsVlY3NDliOFNtWWIrMk9tUXgyb0ZHZ3RkNVZlY0VaeWluNVIweHJESWxw?=
 =?utf-8?B?UU96eWZCWmpzdXMzbkh3UnltUEhtMHB1eHgrMWRBSUxrcTR6elh2QTV4N0xO?=
 =?utf-8?B?UUZJL3VsZ1F6Zk1lL0hZbDA2UkVRcUFZN2dOUlRabVVXSzlSUWNIVktWaTUz?=
 =?utf-8?B?UjIrd1FNMElnQlFRREdCbzJMMFU1bTZiVzRwUlJyZi8xelAzQUJkMjBoamdq?=
 =?utf-8?B?cVo3aXp2c09JVEcvQllwRFlHSVBYbVNWZndKclFYSk9vRjY2dkk0dkRZSjVE?=
 =?utf-8?Q?4LmY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MnZQZDdlbnFhb3lmWThNYzdlTURmWmdoYklpUHlvZTZVUURsbmpJRW5Wei80?=
 =?utf-8?B?OEQrTUxMTGliL0hMMXg1Uk1MZUN4a0Z6TGdTcWtIM0hhWVArQXRSQkNGNTNV?=
 =?utf-8?B?TW56Mit2ZExxZTlnQkNON0NibmxBaHAraW5xSjdWbzBPSGZoN016VWpUeFRM?=
 =?utf-8?B?UWR1Q29IVVl0UVVmZ0pHK2pKblo2amhoUVN4TGQ3UTFiaSttMTQ1VVBZTG53?=
 =?utf-8?B?UldEOVppZ3VDeUhNR1dlUjdOM1dQdU5BQ0h0cS9UVWRoRDNsNmFXMjNNVEJy?=
 =?utf-8?B?QzVKQVRCRE5pbmNxT3lPVnNGaDVBVmJaRXNqVEhqQ1hhRXpNMlMwQjdLbnJR?=
 =?utf-8?B?dnViMVQxV1RBSmRaUUpVTTMzdG1EVmNLQUhiQkorZFcrUk9pOExyMGFkUkxr?=
 =?utf-8?B?T0hpbEZFdTBVd08rZFNIdUtCVE92U29saUhSWE82OFEyK2d3R2ptQm04ZlNi?=
 =?utf-8?B?dGtSblJmbk9CTUtIMzhvV2c1QVZJajhDWHdVUFcxb1Q2bk5qbVZsckF5YS9R?=
 =?utf-8?B?dUJrczJLb1lZNDJUYnhBS2tNeW9aM1pBblBRUi9zOU8vVGpQT2IyOWl5ZWUy?=
 =?utf-8?B?cENoU1ErWE5XSFdzdDh6YkJBUFdmb3RaSXVENGdneVgzcFZOMTdCUVprWHFm?=
 =?utf-8?B?R3RxQk8yU29odi9VK3hORkVIK3BzVWRaeU9KL2pzNnNhK2p2Ui9tcnVvSUdX?=
 =?utf-8?B?ejRQb0dJQXQvRDAzRUlVVHlHMWtNeGJ0bFlTcERIVXRKcGxSbmxqVjQ3bnVU?=
 =?utf-8?B?NGRKanFEN0ZUZGlWK3lSSG10S3p2MzVYSVkzWDlQUmovb3JPNXo4a1hrbjBC?=
 =?utf-8?B?dTNybTVOTHNmNnduOEswaitQK2wxUWZsMmF6dE8vcEhnUjhjZnoyMGd5LzZH?=
 =?utf-8?B?L0J3U1FQaDhPS3VqcnFvbjZrRC9tRy9xV3RwYVVEbjRzY1Fod3JnNDZZaUYx?=
 =?utf-8?B?M0tBU0o4bGE5Skw4M1ZyOGxMVTZoTEdXbHI1cWFBSnpxbmx3dHVTK1FoWkFV?=
 =?utf-8?B?L1NOUmRwQktJb1U1RUlFUnRmN1JxR3YxYmRTWG9YM2xCZUNRZTJXY2RJM3Y0?=
 =?utf-8?B?TFh2S2VHcFcyUnJKUXVyak1VSUc1RmUza1Via1pLeXNsZnFGekd1dlVxNUU3?=
 =?utf-8?B?RDRvcnFiM09rNHJNbUk5Zk1aVEEvY3M4eUZhb1hhUlNKNzlFRjdqRWdVVUlW?=
 =?utf-8?B?WEdZcER0dVByRWdmUllCd01Qazl1S0cyMU13c2dqVkFIaTJ2SU40THlaRzhL?=
 =?utf-8?B?Q0ZIS3p4WU5DTlF5a0xCT3J6UmtxVTFGbzNrYXlYbEhxaHV3MENLaWlFOEZp?=
 =?utf-8?B?TUJ2VzdUL3BUaGE3czJpb1V0S0JwUjVXaWtLbWs1UDFpZWloeHBHNnlkTlpV?=
 =?utf-8?B?dGsrWGVsd2FFd2ZHQ0l4REswN2IzaHY2TFR3U010WmxraHMrdVFrQ1hzRU44?=
 =?utf-8?B?RUxHVkV6ZFlTbVRFWEdjeFUzSk0xTDFiYldFbHBEa09UU0tNZE1WMzE1Z3JK?=
 =?utf-8?B?dXVwM3N4Q3d2YWlWZkZ4VzVScDdpUGcvYkNMSjZGcGZvd0JnOTFDKys3UDkx?=
 =?utf-8?B?Q1hzWWFMckFSTWU5MzBrN21FTE0rejFFT0dLRUpEYzhvRmNBclBNQmpmV1Uw?=
 =?utf-8?B?SWQwMmY2OFI1VWlrZGNVQlFleldmeGFuRXZOQ0g2bkxsemNuZVJxcnpMMkY3?=
 =?utf-8?B?MlJWYWcxWWtWS1Y5OE42U3FtV0NPU0xZWm9ZUElQTzhQd1EvTmlNUG8zUk5m?=
 =?utf-8?B?bkhRS1IyakFiNm16VnhQeEFOVy81U3RlMCsvMXZicDV2bjJ5VDVDb1R0WldN?=
 =?utf-8?B?ekhSaDE4dU56cVk1L3htdlQzSFk5bGNpdnFZb2dwVTAxWk1KdUFnT211eHNq?=
 =?utf-8?B?a091bi9Eb1lzOWd1OUNWYm16NlFTRG9reEhBaDZvNXVVdFpvZUZmbmVzcFBJ?=
 =?utf-8?B?OEwrSTVyeXRwdjlmNkhVK2ZLTFdnZGV3QWZ4b3BKYm85Q0pkTUZCNXR6VHVy?=
 =?utf-8?B?SHo4d0V2VTdtbGNCU29ESDBEdG9ES0p5bGN6WGVQNXJYbFA2T29GdDVZUVcr?=
 =?utf-8?B?RFdWVFB1bFZhOW1sYWczYTl3d0pCMlZra0VtY0Q3Yk5YcWFXeGNPTEloZDFQ?=
 =?utf-8?B?NXhHdWNRN01HalpEanlGS1grNjcrc1VHamFuMVBscm9LOHJnd1BadGMyanZs?=
 =?utf-8?B?Y2hBUXpNU0g1c3pJbGVVQWZjTkMxTHo1a1ozWjhtK0N5TG5QTGhkc3dBNmwv?=
 =?utf-8?B?VW5GZEJ2d0NNM3VLVWFiY3V1ZlB0YS9ibHlyekR4dGNiZjc3c09OMWxMNUFs?=
 =?utf-8?Q?jaB2aGGklRkEgcx4oy?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ac04a43-7bcc-4274-7af4-08de5741f599
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 10:03:13.9919
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kwhI5gdpQX3txLeuFYgdHaHLP7sHAOxP/GZndYflLnqehrcaw4zlCL12M5CpDKoq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB999103

On 1/17/26 07:02, Zack Rusin wrote:
> On Fri, Jan 16, 2026 at 2:58 AM Thomas Zimmermann <tzimmermann@suse.de> wrote:
>>
>> Hi
>>
>> Am 16.01.26 um 04:59 schrieb Zack Rusin:
>>> On Thu, Jan 15, 2026 at 6:02 AM Thomas Zimmermann <tzimmermann@suse.de> wrote:
>>>> That's really not going to work. For example, in the current series, you
>>>> invoke devm_aperture_remove_conflicting_pci_devices_done() after
>>>> drm_mode_reset(), drm_dev_register() and drm_client_setup().
>>> That's perfectly fine,
>>> devm_aperture_remove_conflicting_pci_devices_done is removing the
>>> reload behavior not doing anything.
>>>
>>> This series, essentially, just adds a "defer" statement to
>>> aperture_remove_conflicting_pci_devices that says
>>>
>>> "reload sysfb if this driver unloads".
>>>
>>> devm_aperture_remove_conflicting_pci_devices_done just cancels that defer.
>>
>> Exactly. And if that reload happens after the hardware state has been
>> changed, the result is undefined.
> 
> This is all predicated on drivers actually cleaning up after
> themselves. I don't think any amount of good will or api design is
> going to fix device specific state mismatches.
> 
>> The current recovery/reload is not reliable in any case. A number of
>> high-profile devs have also said that it doesn't work with their driver.
>> The same is true for ast. So the current approach is not going to happen.
>>
>>> There also might be the case of some crazy behavior, e.g. pci bar
>>> resize in the driver makes the vga hardware crash or something, in
>>> which case, yea, we should definitely skip this patch, at least until
>>> those drivers properly cleanup on exit.
>>
>> There's nothing crazy here. It's standard probing code.
>>
>> If you want to to move forward, my suggestion is to look at the proposal
>> with the aperture_funcs callbacks that control sysfb device access. And
>> from there, build a full prototype with one or two drivers.
> 
> I don't think that approach is going to work. I don't think there's
> anything that can be done if drivers didn't cleanup everything they've
> done that might have broken sysfb on unload. I'm going to drop it
> then, it's obviously a shame because it works fine with virtualized
> drivers and they're ones that would likely profit from this the most
> but I'm sceptical that I could do full system state set reset in a
> generalized fashion for hw drivers or that the work required would be
> worth the payoff.

Well at least for PCI devices you could try doing a function level reset to get the HW back into some usable state.

This does *not* work for AMD HW since we have HW/FW bugs, but at least for your virtualized use case it might work.

All you need then is an EFI, Vesa or int10 call to re-init the HW to the pre-driver load setup.

I know that is not the easiest thing to do, but still better than a black screen.

Regards,
Christian.

> 
> z


