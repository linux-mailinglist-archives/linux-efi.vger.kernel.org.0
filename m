Return-Path: <linux-efi+bounces-1927-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85F3D996028
	for <lists+linux-efi@lfdr.de>; Wed,  9 Oct 2024 08:52:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F3D12817D2
	for <lists+linux-efi@lfdr.de>; Wed,  9 Oct 2024 06:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11E02176AB5;
	Wed,  9 Oct 2024 06:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VSbzcy9s"
X-Original-To: linux-efi@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2062.outbound.protection.outlook.com [40.107.220.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5041C16B391;
	Wed,  9 Oct 2024 06:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728456714; cv=fail; b=Ad/RUB9cs3lx0OB41OlOlalNv9Cqu+PU+XRie/pB6G6bZ35oED9NHwBUqUAikja1yP2JXR7zBkWCdPvCSmvad874s432O2Rau2z4ihEvuOfqsbW5svrXAchLIDjST/g/9T3gIvdqm2k89pL2ZWZ284n7m0Px5LhM/QEQD1pWkaY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728456714; c=relaxed/simple;
	bh=0fWz5Rfguitc6HQwxipk0UYv+XWdPDif24FKQ5XbhbE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=k90OafWz6eSebV1MuZOaNlkL+4TwbmJMkw5fwPfnRo33PpMtVHMzrnH2+QkFqcEoGOCBw2K3kZr7PfnHyJTAGISzu7kysG+A8dJrn/T5SV09OgK3hKQcdfRj8HXaACFwAxC0ovK2yafwdgcwGn/9BEULZ9Q/YToVnBfkYKJuO+I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VSbzcy9s; arc=fail smtp.client-ip=40.107.220.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HDseot+ztsAbzjjRQWXvEn4//B2KaR+I752QInQ2W8rcZcV5362RVmAcUyVCK1QMUy6TY4TNzD7q5xQTGX21sokw8Nja/L5uUiLTDcLAsD2BbCe+yJ1Ti/YXFj0n1pPZX0MGSd6B+VYvuDR0YpoRYi6MY7aAMQI4CTqNtktrZpMEgYBLbTM6XFoo4F/tKr9ifTKtGt4Ze316/XGoq8Addwf1xZZWdMIv1PfZ3UMjaFWiTkZc9nRaAI8SxCxkIOsLlv8u6ytnWDsGC/vG92dqnhqPZrb8d+x49CUgKtnoP8y8HejE+joR4Ffs3KJI0NgYGBCi3/kKMmtyoXvtF0y+rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tvmYm9rxZtw88LIOhbRrJG9/u2EAQj28bfvzcG/LGZo=;
 b=GQeG+bWF07g5Ls6zy24bLbIiMZUUuMIt3CiUevFUAqkd4x9L8Y9+p5+AIMZsQeOOIXIubGHSyUUi2N4QkXjqkx0ylry0Yp/1OlEsyoPv3AkFIZrXIbXYvSdoUZJ4ttyv4YzOcmm24H+QfvBr+E6MCej/VLP8BIzQQF87nxeqxk8eX8VxvBQq9p6jRwZzuwFemgvtYtOdyqyRFjZhY+GMDViHIaPHivqr3TDe6YMP9Tqi/OiGOFqfF3NcQXkrNTzIX+/WNG3+xX3B0ZMId6WTS9Ku+w/HOt7UTUv0v7wj23KDaF425ExErICb/9iFCIsGT0+ZH4FYMJmU/5S2ItiZCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tvmYm9rxZtw88LIOhbRrJG9/u2EAQj28bfvzcG/LGZo=;
 b=VSbzcy9srEnBvTivJiIkPPOIK9LRyMDf2Y2R9KxjFSbL3VCOIA0weVn6ZJZFIKubVbYENWMiwI6b7tRX66n9cXa8nYyTnuLyQV4fFwB6L9kptNKhDNhRdQxIKe9fctJ5MvPu+8qRcEbQyxnMSVaDjeWGNywpvsDt07KiGlgWDD4QoynmfR2Fghgow6rXlAs9eLhiglhnNBJjgeyD1vwfa5ol6JF8yQ3jgY5sgsb4O/191r72synqQLXidoT88ANo91f1ysHtsL791YP3Y48ephe1oDr1RPrnjc3Aw7kxOF9JR9CkWUgiIFiM1720hN0Gzr2gn/U/IsZlYJJw+mugzA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB7579.namprd12.prod.outlook.com (2603:10b6:208:43c::14)
 by LV3PR12MB9144.namprd12.prod.outlook.com (2603:10b6:408:19d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Wed, 9 Oct
 2024 06:51:50 +0000
Received: from IA0PR12MB7579.namprd12.prod.outlook.com
 ([fe80::da98:f83b:ca75:64d5]) by IA0PR12MB7579.namprd12.prod.outlook.com
 ([fe80::da98:f83b:ca75:64d5%7]) with mapi id 15.20.8026.020; Wed, 9 Oct 2024
 06:51:50 +0000
Message-ID: <4bab6b13-6cf6-4393-b2e4-f196ed9c2795@nvidia.com>
Date: Wed, 9 Oct 2024 14:51:45 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V7] acpi/prmt: find block with specific type
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Matt Ochs <mochs@nvidia.com>, James Morse <james.morse@arm.com>,
 "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 Zhang Rui <rui.zhang@intel.com>, linux-efi@vger.kernel.org
References: <20241009064517.2678456-1-kobak@nvidia.com>
 <CAMj1kXGrS+z=Kx2uPaZPKbLFeKGEfKDQ61HOvRF7U5=akktS9w@mail.gmail.com>
Content-Language: en-US
From: Koba Ko <kobak@nvidia.com>
In-Reply-To: <CAMj1kXGrS+z=Kx2uPaZPKbLFeKGEfKDQ61HOvRF7U5=akktS9w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0150.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::35) To IA0PR12MB7579.namprd12.prod.outlook.com
 (2603:10b6:208:43c::14)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB7579:EE_|LV3PR12MB9144:EE_
X-MS-Office365-Filtering-Correlation-Id: e176841f-e6de-4070-b38f-08dce82eda11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MVBIWEtnWjFHeStpQzZOMGIzaFBPMEQ0bm1NSW0wQ2dCOWlxZWRHODV4UXBa?=
 =?utf-8?B?Zjh5dGt0dWU4NG5tZVgrQUxncWdiM1c2RE9LL0kxa0wxNGhUcng3bm9tMG51?=
 =?utf-8?B?VittTnFFNWNFREtGSzRYNXVKUkYxVUltN05JWlNadFNTMytuZkUwL2h3dlp3?=
 =?utf-8?B?eUcrZXdWbzlic3NRVGQxQlpHVHBkZTRsY3MwQnRiaFRDc2M4RzF5UC9lUmlp?=
 =?utf-8?B?djNrcTZ3RjFyMlFTTGZjeHlTdCtYU2ZPZ21hb1ppMktkeVNxVlAwNXAxZE4w?=
 =?utf-8?B?cUl0Y3YyVnpuRHlacE9MR1RKNTdBUzduN2V4aTBaSE9JQ3hhSkdpZ0xCNE1E?=
 =?utf-8?B?aXVzTnZobWpPNUI3cHJpQ3ZmK1JEZzEzSXdjckNxSCtoMWhkV2R6K2VPa29k?=
 =?utf-8?B?Tk5pblNuYUtsRzc5OUdma2RRdVg4K0R3dXlqTXJua1NaTkhhdTI0enBId1Zm?=
 =?utf-8?B?NkQ4bjlFS1ZBV0tHNTJVOUZOdUZ5WHN1Zk52OEdMbG1jV3c3QXFZL21EV2VS?=
 =?utf-8?B?SkVsendpaVM3QkdyYTErb05YeGE0UnJUdG1ucWpkcm1yREp1UWduZnl2QVZJ?=
 =?utf-8?B?NTVKTDhqanlLdEhRSkRZbHNSRHZSYkQ4YnZjZ2F3d3ZIMDN5c1JkeDh6NWNs?=
 =?utf-8?B?aVdodCtpZXRFeHBXYkJDTVd4MGdhdzZvNTR1UVNmOFBBTHgzSWJtaThMWmVV?=
 =?utf-8?B?ajBQbjgzZVNuSjFTbFZOUnBHSlFYdXNlTXV5TTkyOGs2V29yVlA4ODhrQlNN?=
 =?utf-8?B?KzBJMUZIVFFEVG00TXUvbHVuRWxKRXBLanhGNnEvMG5UZGFBSVl4NUw1VkNU?=
 =?utf-8?B?MStla0pWR3haUEhMNUM0Vi9QV3NnVXp3UUIrZCtFeUZxZjh5ZU9iQkxhbk1I?=
 =?utf-8?B?K3FTTkxiWll6VVg3b05nNENOUW5zeG9LV2FWVzZFZTZLaUFybWlNL1dRUG5I?=
 =?utf-8?B?NjVibEhYeU9PZm0zYmVINW11QjFIUVIvQ3pLeitlRENxajBXTEtSWTkwdW9s?=
 =?utf-8?B?Y0NYZEM4VWY0K25iUTR6M0tYM1BHUHFHQkFHclh3SkNXMXh2aVdpWXZWb1Qx?=
 =?utf-8?B?Q3lxQ012cHd6WGxWOUNkSEFHQWpic2ZuQitPRnltNzRCUHFJZmlmS0NRNW1U?=
 =?utf-8?B?SFpSbm8raDc3a0VTOVFmME9ZTmswTFltcUc2ODV4ZkxCMUlYSllRN1p6V1lp?=
 =?utf-8?B?NUtPYWZKTm5kc244dUk3TXdOYXlOYmlrU2UvaFdqanpaUkwrWWQ2eDBDQ25y?=
 =?utf-8?B?Q2xMeDloK0xndzJpYjc5N1lnSTNoMVBRMzZrOXA0LytmdHd6dm82NFN0Zm1l?=
 =?utf-8?B?TXJCb0FTd1ZtMlVQcVQ5STF3Z25tRHptZ3VtZ0NidG15bG5qMlk1ZkxmQmJL?=
 =?utf-8?B?bUhkdE9lc044NlArN0xHSVhKVXJka21qZHhBSzZPa0lBa29DNjJVVzdaSGl6?=
 =?utf-8?B?Tld6ZmluT0xlQlBWU3Y1YUVlUFdZZVdpTUdLMEtKdWRoU2krSjhid0w2OVpy?=
 =?utf-8?B?MmJBMkIwZkM5bHQ0THJ3OEFHZ1RCcngvclBONVQzaDVpOUh1amxwaXV5cUU3?=
 =?utf-8?B?M1pzVUdWamphRHNlT2EzL0dic25LeDltSmlzVC9RTGwvNitFNkU4bnZPNGhy?=
 =?utf-8?B?YUV3TXdwVW9vR2FaVE5nbTdmMXF3VXRZNDh4MDgvSVVUVHRMb1h5amNhMys5?=
 =?utf-8?B?cUswdGdMNWhKNjFvcDZzbkVPZHhKZXRVMGIwYU8xOEN3Q0duRnhCbGZnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB7579.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UElaZUVHZEV4cCtZSU5hWXpLYzFXOGU3aFRNdjlxTjhkL05MdXpjNUk2c1d5?=
 =?utf-8?B?NFY5Z0ZCVjd0ZDFvbVk3K1RZbllKdUVGak1adkxUTGhFeVBJRmFhZjJoSFdz?=
 =?utf-8?B?WGdkQzZSRnlZZlJaaURRbTlzYnV5N2IvUFRiVGRNNG9XZ0xUWTJLSVluN2h4?=
 =?utf-8?B?Z1VYM0JtWGxrRExpeXVweDE1R3VOSUlEKy9aQm5paGkwaTJtcWc0WjQ2ZVln?=
 =?utf-8?B?QWRHcWhobTFXQ2cwU2UybVN4SGp3VFFncUF3OXd5L0Nvd3BvNi8vd1hGR3Rv?=
 =?utf-8?B?enJLMkgyMHNMMDY3S0hwMXc4eDY1LzB1Y3ErZGVnWVVrN2J6a0U0YjdWaGVR?=
 =?utf-8?B?K3huK1R3TEJCWDhrcWRtNmozb281Q3lVN3JVV3N5YldnU3dudUlkQnJFcEJR?=
 =?utf-8?B?YS9USmNseDJINVVXV1oyanRHSVZGTnZLY3IwVTdNd3hnci9OMjY3T1NCTDRP?=
 =?utf-8?B?d2NwTlZyeWpFTFFCTkhSR1daSGI2YjBNQUg1Sk9xZm5rY0xMekt1dlRncVQy?=
 =?utf-8?B?T0xGd0Q2dmlzck9QdWtxSkdqaTJYazA3S0tRblVrQ2xocHNMcHdMSlVxY0pK?=
 =?utf-8?B?T1dPTlNMcHpyWUlHZUtoSUZlVFd3WVJ3YWhScVhoQ1NkRy9XTXpaQ2kwZTVq?=
 =?utf-8?B?YitJMFZ1a1lDWmpWdnNNTlN0NkFPNkVyZXFGUnlCTjVOK0hIRkZqcVFWZ25P?=
 =?utf-8?B?SXcwTUU5eXd2UnRZaWpXWGNkMXlyc1JKYWZUSGhGNllpdkpzaVRXNHlFMHFT?=
 =?utf-8?B?cGFReUxlZmtCTlhQWEZWaXJFamtXTWNtR21DNzd6T2JvaGtQTWNsUkV6Wm50?=
 =?utf-8?B?WHNUUGpXcFRlMXB3OTVlNlFicmw1N1NsSFBMeGd4Q2hQUTc0MkhQVGxNRjkx?=
 =?utf-8?B?R1ZyZTBVZjNzV1BRY2p2T21PK2N6MUs1YVVqV28xeUwzSm10YlRzdU1UUDRT?=
 =?utf-8?B?SklHNlMyQ203d2NkU1hQSEVtMnNvVWRvODluQUlkbEdLSXIvNjREaERhRTM2?=
 =?utf-8?B?ZWNodGJySFZBd0J1S3ZCWW9Yem1ueVVnQitBMnhCUDQzZnllRXBrSGs2Z1g3?=
 =?utf-8?B?S3V4bWdleXJTc0grM1pNRmF4ak1wdjNhWHh0R0UvdlAybG9MNUFEZjQ4alRK?=
 =?utf-8?B?MTlHUGp0LzNQMVExYXk5N2NMWlYxMXFmWnpxbFJ2N0NFc0MrOG1RZGhWeDZ6?=
 =?utf-8?B?ZXN6cTNQcDdkYkw1cFNxWTJzbWc5TXgwaGZNK3RjOGwva1BSOGRza1ZZMHhV?=
 =?utf-8?B?Q3ZqWkJCVXNpRG9UQWJ1eXczc1VHR01iU2VydGhKMWhzS081YlhWdXJJWDY4?=
 =?utf-8?B?TTh0S2NHOVZ6Vlp3c29CbDhVQ0psY1oyM1F0V3R6QVdvbUsxMW9IL2hoMXQx?=
 =?utf-8?B?NWFHNGFkVFZqbDEvZjQ2S0UrME43aEh1WllwczVReDRIQmNrd2pRSFBmZU9Z?=
 =?utf-8?B?S1Rlc21TcGxIayszZ1hnbDB0ckhHOElLa0lhcklsY1VLRVcvTzZqaWdxSXNl?=
 =?utf-8?B?bm1DUXVHMlhzSk96eFFiMXhaMTA0QklkVi9HeWt3MlBpSldZZTdVMnB2dkYz?=
 =?utf-8?B?cUEzZS8yVUdPbDNVZXJjZ1FOUVpoekQ4QTlwdzhaZWttcURrZ29vRjJNU292?=
 =?utf-8?B?Mm41dkd2M210WU1Ta3h3VlM3TWVLWE9KRzBkcGRMUDhxUVAwaTdNRW9iUVl4?=
 =?utf-8?B?MnZPQmVZRWdkOXNOU3Btc01PVFFDeDljUmZiUjBSd0tLODU4aU5RRmpGWEZ5?=
 =?utf-8?B?N0RSUHVmRS9FU0RrVEx0U0RpV3NtTjVndUJ5cVUxdlZKS3htSVk1Uit2V0Qy?=
 =?utf-8?B?VHUxOXBJY1dMWEdndVd1MlNDdzg5cXk1eEJVb0d3eVRFZDNxYnVDQ09zRnBh?=
 =?utf-8?B?UUZuK3gvSEFGWXZOQ21xdFpwczFGZVUwMXRmUnVVM2NOeGpOMFF2eFJZZHpj?=
 =?utf-8?B?NnlxZnhjVEV5NC9ZOVhCQzQ4RUl6VFcyK1VEZkcwcC85ZHVnZ3F2eG1FTnR2?=
 =?utf-8?B?S0tKQnhQSlRTTlZxZlRwY1lCc0IzaDVjVmZQMXdrM082aDZyMkNweExmL0dm?=
 =?utf-8?B?SFBsZDlRTmg0TUx2YjRJMWZFSEhVVys1azRab3VLcTdTVHhCRlJVNU5UOU5p?=
 =?utf-8?Q?XL3CgOvArNO1ELaQTz9qqPYXJ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e176841f-e6de-4070-b38f-08dce82eda11
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB7579.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 06:51:50.5283
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ISuuxbKkotO0Xzlv2K6nU9nbuSYTO/+oycCjDD6pfD1nVIpuJSu4R3HvrbiudX1+3P5haO7nzI3pgokkldJUVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9144


On 10/9/24 14:50, Ard Biesheuvel wrote:
> External email: Use caution opening links or attachments
>
>
> On Wed, 9 Oct 2024 at 08:45, KobaK <kobak@nvidia.com> wrote:
>> From: kobak <kobak@nvidia.com>
>>
>> PRMT needs to find the correct type of block to
>> translate the PA-VA mapping for EFI runtime services.
>>
>> The issue arises because the PRMT is finding a block of
>> type EFI_CONVENTIONAL_MEMORY, which is not appropriate for
>> runtime services as described in Section 2.2.2 (Runtime
>> Services) of the UEFI Specification [1]. Since the PRM handler is
>> a type of runtime service, this causes an exception
>> when the PRM handler is called.
>>
>>      [Firmware Bug]: Unable to handle paging request in EFI runtime service
>>      WARNING: CPU: 22 PID: 4330 at drivers/firmware/efi/runtime-wrappers.c:341
>>          __efi_queue_work+0x11c/0x170
>>      Call trace:
>>
>> Find a block with specific type to fix this.
>> PRMT find a block with EFI_MEMORY_RUNTIME for PRM handler and PRM context.
>> If no suitable block is found, a warning message will be prompted
>> but the procedure continues to manage the next PRM handler.
>> However, if the PRM handler is actually called without proper allocation,
>> it would result in a failure during error handling.
>>
>> By using the correct memory types for runtime services,
>> ensure that the PRM handler and the context are
>> properly mapped in the virtual address space during runtime,
>> preventing the paging request error.
>>
>> The issue is really that only memory that has been remapped for
>> runtime by the firmware can be used by the PRM handler, and so the
>> region needs to have the EFI_MEMORY_RUNTIME attribute.
>>
>> [1] https://uefi.org/sites/default/files/resources/UEFI_Spec_2_10_Aug29.pdf
>> Fixes: cefc7ca46235 ("ACPI: PRM: implement OperationRegion handler for the PlatformRtMechanism subtype")
>> Signed-off-by: Koba Ko <kobak@nvidia.com>
>> Reviewed-by: Matthew R. Ochs <mochs@nvidia.com>
>> Reviewed-by: Zhang Rui <rui.zhang@intel.com>
> Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
>
> This needs a cc:stable too
Hi Ard, Rui
Thanks for reviewed.
>
>> ---
>> V2:
>> 1. format the changelog and add more about error handling.
>> 2. replace goto
>> V3: Warn if parts of handler are missed during va-pa translating.
>> V4: Fix the 0day
>> V5: Fix typo and pr_warn warning
>> V6: use EFI_MOMOERY_RUNTIME to find block and split goto refactor as a single
>> patch
>> V7:
>> 1. refine the codes and commit description as per comments
>> 2. drop goto refacotr
>> ---
>>
>>   drivers/acpi/prmt.c | 27 ++++++++++++++++++++++-----
>>   1 file changed, 22 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/acpi/prmt.c b/drivers/acpi/prmt.c
>> index 1cfaa5957ac4..51f5ae3d4350 100644
>> --- a/drivers/acpi/prmt.c
>> +++ b/drivers/acpi/prmt.c
>> @@ -72,17 +72,21 @@ struct prm_module_info {
>>          struct prm_handler_info handlers[] __counted_by(handler_count);
>>   };
>>
>> -static u64 efi_pa_va_lookup(u64 pa)
>> +static u64 efi_pa_va_lookup(efi_guid_t *guid, u64 pa)
>>   {
>>          efi_memory_desc_t *md;
>>          u64 pa_offset = pa & ~PAGE_MASK;
>>          u64 page = pa & PAGE_MASK;
>>
>>          for_each_efi_memory_desc(md) {
>> -               if (md->phys_addr < pa && pa < md->phys_addr + PAGE_SIZE * md->num_pages)
>> +               if ((md->attribute & EFI_MEMORY_RUNTIME) &&
>> +                   (md->phys_addr < pa && pa < md->phys_addr + PAGE_SIZE * md->num_pages)) {
>>                          return pa_offset + md->virt_addr + page - md->phys_addr;
>> +               }
>>          }
>>
>> +       pr_warn("Failed to find VA for GUID: %pUL, PA: %p", guid, pa);
>> +
>>          return 0;
>>   }
>>
>> @@ -148,9 +152,15 @@ acpi_parse_prmt(union acpi_subtable_headers *header, const unsigned long end)
>>                  th = &tm->handlers[cur_handler];
>>
>>                  guid_copy(&th->guid, (guid_t *)handler_info->handler_guid);
>> -               th->handler_addr = (void *)efi_pa_va_lookup(handler_info->handler_address);
>> -               th->static_data_buffer_addr = efi_pa_va_lookup(handler_info->static_data_buffer_address);
>> -               th->acpi_param_buffer_addr = efi_pa_va_lookup(handler_info->acpi_param_buffer_address);
>> +               th->handler_addr =
>> +                       (void *)efi_pa_va_lookup(&th->guid, handler_info->handler_address);
>> +
>> +               th->static_data_buffer_addr =
>> +                       efi_pa_va_lookup(&th->guid, handler_info->static_data_buffer_address);
>> +
>> +               th->acpi_param_buffer_addr =
>> +                       efi_pa_va_lookup(&th->guid, handler_info->acpi_param_buffer_address);
>> +
>>          } while (++cur_handler < tm->handler_count && (handler_info = get_next_handler(handler_info)));
>>
>>          return 0;
>> @@ -277,6 +287,13 @@ static acpi_status acpi_platformrt_space_handler(u32 function,
>>                  if (!handler || !module)
>>                          goto invalid_guid;
>>
>> +               if (!handler->handler_addr ||
>> +                   !handler->static_data_buffer_addr ||
>> +                   !handler->acpi_param_buffer_addr) {
>> +                       buffer->prm_status = PRM_HANDLER_ERROR;
>> +                       return AE_OK;
>> +               }
>> +
>>                  ACPI_COPY_NAMESEG(context.signature, "PRMC");
>>                  context.revision = 0x0;
>>                  context.reserved = 0x0;
>> --
>> 2.43.0
>>

