Return-Path: <linux-efi+bounces-5941-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AF7D0CF797D
	for <lists+linux-efi@lfdr.de>; Tue, 06 Jan 2026 10:45:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C74A13036595
	for <lists+linux-efi@lfdr.de>; Tue,  6 Jan 2026 09:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6578320CAA;
	Tue,  6 Jan 2026 09:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tJIHJL6d"
X-Original-To: linux-efi@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010055.outbound.protection.outlook.com [52.101.56.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6775A314B94;
	Tue,  6 Jan 2026 09:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767692413; cv=fail; b=coJBbDTtoWlAlYU5XOUjvC5f9aGmrjTM/7Otn9q4JIhSeX+JjxMP8KlL+aoZK1B6dzZxCPPuq+PnHrG+6pTkwn6vtbFsuS+Ji/Lh0s7Bw8Ryy1U14KfUTOyjyjRE5qAAFud6A/ehrTJcBb6NgweVk2B+7Tg30sl5cJPkUYsJoBs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767692413; c=relaxed/simple;
	bh=/9HEllJOH+53RKN+nLIduXsebWkLETLexKKA50NNQkg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KrgFDIQNa/wg9WdT7KpSdWBjHsZ89MqAuADt3L3oXnXobx6gSPAZ8SAkqzlj6LK0PQhFwCcMOG3NtdXUBaqInsdDkX53Ax63EYG1O0leROegUBXbpTjKerBY8qGP+fhz7QgM4NcmKj3iQZ70uwjSeAxar19zaVVrJ4w1a7Mb71U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tJIHJL6d; arc=fail smtp.client-ip=52.101.56.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XI8/0e//fttAIb7OVwZpYDN1/emb17aNbHUxYQY7UKRwGQayLixOZ2ssszRzIsuHe3FH3A6IKwFnv1vW9BwZ/eJX9EL7cM5jyIDP/GhLim9teo2c15oC2PJz1XQLEtsU8fB3iTpyJPyqd83h30vepm785iZWlnjlQYDeYSRz+XnM8SZ2a2kl9THe3lmE1W1XV3wb/CVuzCX1saqe9ioyu5IqJ7ttRrrEk/Hz6kpbbYwlnfIaJqPSABPdoT+zyR+v6agO5ylK15TX431dcAb45pntbiencQMZBx/6AasYSCbGW/l9BBlct7cT7R6VcBqV7/N9gUFFFq9edPiGrP5D+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y3X0bQgJ+7urF66T5wmVRlKo19vZNPzZgEdPyCqVva4=;
 b=HGeDtuKeI//CMLTX/KoXTjCpmV9IsnuV3cNyvmonmr5eTWNDN36gorU6objhQSkcKKZXDARkZujw2hLauvKv9hsVvGzGvhjRpLlXbH5LWBJQEoHn5YM9Dmp4v+RJ34irjWzzFYuNBYt/I8M9fdtV8bqdXP1K/t2es7Yuj1IUnGJ+XFy1TSJo6UKxWxKKY5e5g2DiFlKIQa/KIh5qoFjSfKwTxOJx8pY4nDWDPvVmqGVOGDd9R/wd5l4Igt0mRPYXOUtFdAFIxKsMrnKU+pUWagpnT0l+tybwXaWk9PmsuvV+H839kfPmRhm11S8tCQDLfE9xqhVk9aZ8r/XrS6g4ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y3X0bQgJ+7urF66T5wmVRlKo19vZNPzZgEdPyCqVva4=;
 b=tJIHJL6dEkxPkSemsBWsfjGL7Cz/HyTQEI1ESy6neDd1BWzZmklUXLCwgFeWoUlEIGsobUJF0dM3sxSZrVeKoj2QeyVs4t+ob++dQsPGcqKpTC8uJ1MpGeLtIBU/BejB3EAVSzZWDqbLAomte1sq868gjXnmXrjRmNN3oLcXA8vSjGc4o1Z/J6pqb8wtnljrRIax72oBZcAJReuMMWjjriUNdwLMNWGg2zlXslK20lAmHy8gYQHTs9Cvl/e6vvUB3O33YTrrjFpw3Q/82KhE5O4NgNJEUvFZZSv1eY3blQiMmvHKeMsJn6DU97LHlM9URERBvKxTu0KgUn5TsRd4yw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11)
 by DS0PR12MB7926.namprd12.prod.outlook.com (2603:10b6:8:14a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Tue, 6 Jan
 2026 09:39:59 +0000
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9]) by SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9%7]) with mapi id 15.20.9478.004; Tue, 6 Jan 2026
 09:39:59 +0000
Message-ID: <d14a9c41-9df7-438f-bb58-097644d5d93f@nvidia.com>
Date: Tue, 6 Jan 2026 09:39:48 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/17] tee: Use bus callbacks instead of driver
 callbacks
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 Jens Wiklander <jens.wiklander@linaro.org>, Jonathan Corbet
 <corbet@lwn.net>, Sumit Garg <sumit.garg@kernel.org>,
 Olivia Mackall <olivia@selenic.com>, Herbert Xu
 <herbert@gondor.apana.org.au>, =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?=
 <clement.leger@bootlin.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Ard Biesheuvel <ardb@kernel.org>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jan Kiszka <jan.kiszka@siemens.com>, Sudeep Holla <sudeep.holla@arm.com>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
 Michael Chan <michael.chan@broadcom.com>,
 Pavan Chebbi <pavan.chebbi@broadcom.com>,
 James Bottomley <James.Bottomley@HansenPartnership.com>,
 Jarkko Sakkinen <jarkko@kernel.org>, Mimi Zohar <zohar@linux.ibm.com>,
 David Howells <dhowells@redhat.com>, Paul Moore <paul@paul-moore.com>,
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
 Peter Huewe <peterhuewe@gmx.de>
Cc: op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-crypto@vger.kernel.org,
 linux-rtc@vger.kernel.org, linux-efi@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org,
 Cristian Marussi <cristian.marussi@arm.com>, arm-scmi@vger.kernel.org,
 linux-mips@vger.kernel.org, netdev@vger.kernel.org,
 linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
 linux-security-module@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <cover.1765791463.git.u.kleine-koenig@baylibre.com>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <cover.1765791463.git.u.kleine-koenig@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO6P123CA0036.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:2fe::10) To SJ2PR12MB8784.namprd12.prod.outlook.com
 (2603:10b6:a03:4d0::11)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8784:EE_|DS0PR12MB7926:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e06cf2f-d2f5-4f35-d98b-08de4d078ec4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QWZjYUpXd2VBT3g3ajlmWVA3OVFPbUFzUSttTkhxTEx1ZGJqVWRaZ3Z2b1dZ?=
 =?utf-8?B?dEhMTEtjSWE3UHBLV3lRVVl5QUJmbWN2ZmdidklpTmU3ZlJJMDk2WHZwbHQv?=
 =?utf-8?B?eGRNK0w5cDNrejdiNkVmclMrTmlPTzRIRFhaMkRhRVR2a2RTYUJ6V2xQTUR5?=
 =?utf-8?B?REd3ZWtaSytqemdPQi9OaVU5N1k5c3h6bXpNcGVySXhtZkR5TkI1RzRHWEU0?=
 =?utf-8?B?OUZab0k3Z1VBd3kvaTZ6bzFsVEpidVo3UXBoR2pjTUFjZEdjTFlwVC9pMG9U?=
 =?utf-8?B?MUdmdmMxaVhVMjV5cGZXWTk5WlhQSW12S2Zsbms2QTRLZ3picTBHNnh0RjR2?=
 =?utf-8?B?ZytZVmhzaDVabDNFRU5WT09RTE1MN0NzMEEzQ3V6UHNNWVFNbzZjYXZ2a2Vj?=
 =?utf-8?B?N1hxZE9aUnFWR1lKSHNZeEdXZXdyamdKUERzSzJEYncxMTlSektCdFV6VW85?=
 =?utf-8?B?NG5WS0ZCclBnanhHM2ptdXJIRUxRUmxkc3R3L29sZ05RUWdDME1GbWRwKzlU?=
 =?utf-8?B?aEQyclA2QVVLcURCaUxaZUp0QWZFazhoVXkycmJEZmtscHZ1NVl3MjI3RDZq?=
 =?utf-8?B?TnR2YzZpMzV2bWNTektEY2ZEUmd5RkxRZTVhVzUxVmFINi8zV2w1TnhoQWU1?=
 =?utf-8?B?U3VpL3U3d3drMkNJdmxZVk0vSmJia3lkZHpyTGFmemlXdmZDREZ6ejlKaVpu?=
 =?utf-8?B?dDVsOWdtNkUwUUEzd285TjdIVVJENVpSRHhQRnYyQ0FLOUNwZmp1eE1Mangw?=
 =?utf-8?B?d2tGbHIzeWthdEQwNHp1cXNsTEhoZ3dqMExOa2dQdUJmNmd1NUhuUUVSRDlH?=
 =?utf-8?B?aGIxQ1FyQW5MazJ1VzVtOEN4dVVmWndlL0NUYXc2VUMxL0FoeXVMb3N2U0lS?=
 =?utf-8?B?dUJWL0cyNXlHQ0VZT09ucFI5cVFLZXg0TXpMWVgxaHRBclJobW1uY2xWUnk1?=
 =?utf-8?B?ZVY2dmhZdUwxZDB1ODBKNVRQUDN1NmdYY0NkZUk2QnZLSU5FcUV5SzlZUmdm?=
 =?utf-8?B?TU5oVEdRSVNCWEdZSjRnb2xMemsrUkJLYnZWRWdLdVVQKytxVkEwMDhrcjZo?=
 =?utf-8?B?eFJvc2ltWXVuN3FVVjBrQWx0UkVGNTNZNnJQbW5CamsxUExyMUJMaWY1NkZ1?=
 =?utf-8?B?a2dFNVNVSTdxMlN5S3UrcXVsQmhTRUhybW5XWXBTVkgvek5YQm9YcHhrQ1Q5?=
 =?utf-8?B?THV2WVhWRnQ3bUI0bG1GdDVsMDZRdk9ta3pZajQ1ZnJMdGdLQmRiQStpV2Vm?=
 =?utf-8?B?WndWSlljYWRIYmJla1VELzVwZ0JrQUdMcG0xMUhobFArLzljYlh4aDI4SjBk?=
 =?utf-8?B?OEQ3ZEVYYU5abHIrWTVzd1Y4MGRha2dtZVgzS1JDVzc3M1FwM3JlTXc2Ri9M?=
 =?utf-8?B?L1RGbXNtVVNtUFgweG0xV3Bpa0VZeUpZdlo5VVpNOHhGaGh5dlRCMHBhengy?=
 =?utf-8?B?QjcwNkVvUHNtbHQ2eTR3Um5FWThPamFZdGR3SnplZnlRS1h0anNublBxUEFZ?=
 =?utf-8?B?R210UkFSei9sOHVFbTJybWJkVno1b2JZanZnTXFpN1VqS2xZZVVCWTNEZTNY?=
 =?utf-8?B?bWc0NFltZkVuRGtoY2UzQjJaNThSK2x4NE9KVGprZ2JSam5pRjNMK1IraGhY?=
 =?utf-8?B?dVgrVUcwa2x4cnNpcEF4RHl1QzNTVTlFMURPbGhHRDh4ajRGUmtuZnJSTUcr?=
 =?utf-8?B?OFZJRkFNYkZuVmxlNzF6cXE0bzRlMnYrL3RmbUY0SE9mUVc3UkZZSUc1WExj?=
 =?utf-8?B?TkV1R3BJYjBOQy9VczZuRlpGRStDbU5xaHY2ck51THp6Qkd0V0VJZXFyYWc4?=
 =?utf-8?B?dFVwcGRHQjVURVE0QXFFdjJrMXVTZkhvNlVwQnFmYzNXZ0RXZEJxb01kZWhS?=
 =?utf-8?B?UWYxQjZoTzlZNUhkZXU3ckdtUjNuMHRkRTFBdVpGSDJ4bEFNUC9uUkN2VC80?=
 =?utf-8?B?cGlvbmdZVmFFOWtRMHNpc3pBRW4wQWk3blQvSkNwQkhDcXBjRllZTnh2Nm1R?=
 =?utf-8?B?SkF0VDg0S2NSMFluTFA0NlA3Qmh2TEpkWk0rY1hoQnBIKzdPK1Fka0wzRXpC?=
 =?utf-8?Q?fHgAug?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8784.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OEFZbEJaMzZ4UjJHbWxrdGd3WVBnSVI5SmJDWk9KdVh6VFgyVXcrQU5iUkZK?=
 =?utf-8?B?V29xeTFyTUVBRGtWaUwrTUVZUFUrbFQ1VXFrUDRqZ0F4bmljSXgzVzl1TWhv?=
 =?utf-8?B?SzBRMDloWDhCZE9zMS9sV1lwVDc3R1dYMHdNZGkvRFJCYjZLbVNobkNwcGJ0?=
 =?utf-8?B?NEI1ZmJUUlBZeVprTVpKR0p2QWphRU1rbHFLTjdnZHh1Y0RkZzFOSFJBNlp5?=
 =?utf-8?B?ZnV0Qk5MVjZ5aEFQbno5NlhVNjJnU0RyTVJCYXhFU3hEc1BkVXpkd3FSbktP?=
 =?utf-8?B?OVpDblZrTS9pelR2ZVhiMXhKcmViVGZGNFdjL0VFelV5YmxXRGpUSEUxNWtS?=
 =?utf-8?B?ZXgwVUtVc0NWbXI4S0FHUVBRRng1bWJRb1ZPcDJqZUcrbTl4d2loZlpXZlEv?=
 =?utf-8?B?dUt6VDMwMXFPMWU2MGFUeHgydTY0Vk00dW5yK1QrekdaV09tbnFNWDZiMmNH?=
 =?utf-8?B?cDFmVGVzS0RJSm9odVdXTzVRUGdDeHJCTk93cFhYSzg3M1NEclVUdTUydE9D?=
 =?utf-8?B?MkFzQlJKa1ZZTTZHVHhMWnp6L0gwSGl6c2Z6bWRQaVhWRytXcXJoYVp3U0hO?=
 =?utf-8?B?OHRUcHdJTUJsVStSSjBxWEVlNENOVXo3Rng0RlpJajNvMUIvVWVMVFlaRWZ6?=
 =?utf-8?B?cE9BbGlQZTR4Q0NTbEthNDJSb0dGYkV2ZlY1THpyK21WMzRVNlVvdldqU2Ns?=
 =?utf-8?B?YVBYU2pSeWZUOTRtcTZPVzFiM2lzRmQwM0xZdE5uTUNkb2N1S1lkVGluS2w0?=
 =?utf-8?B?b25jYkFHRkhFTitCcGxoWUtwejkzQVNOS1FVMW9FZ091NWJMUHFNTHR2ZUJQ?=
 =?utf-8?B?KzR1b2VWZUVUZVZQVmNKekVNTGJDTGRlWWpuL2hRK1U1NzROdG1nQlJYYlNY?=
 =?utf-8?B?c3YxTGNaODQxNFNlck9yYjlXanJYWVNrcmFkb1d0aXZRYVBWYUJlMzZIZE5E?=
 =?utf-8?B?N2FteVMrc2FLV3VxRXB5Zjc4VHhDUmEzanFSeE1JVzVxSXA5ZWgwL2UrSHF0?=
 =?utf-8?B?bndoSUNnTitVSlhScm44aUtWMTlnS2o1WVNOQ3pya0lLb1BWS25ST0RISlhM?=
 =?utf-8?B?N2luK2l4L013SklidjBaaWdaSktxOTVLem9zQ0hMTDJrNWJjU0h1akFMNHU4?=
 =?utf-8?B?Mk5tS1c4TDdTTURPWjk2RlRvUlVrdXBNWk10NHFSalEveVVlNGtCeGhlYlBx?=
 =?utf-8?B?aFFTcERsd1czSURmZHBDZWZaWHY2WmU0bUFPY3RZdWRtV1AzYkRIdVlZcjdR?=
 =?utf-8?B?emk2OHFWWHdZUlJoNkpDYWswb1pRNldndm1MbGhNb0NOWWFkenhaWTJHRG1R?=
 =?utf-8?B?QUpZYkxDblkwMFNrc3RuVnRGT0JhZ2c0ZFpQYWw3T3pVUU5DME9lczB4NkVG?=
 =?utf-8?B?YmtPWDJtcG5RN0NsN0ZRNUxhcXY2eVZyOFBWdE1pRnFPT1VqMXc3cmY4L0Vr?=
 =?utf-8?B?VTVRVDY4SUZMOVRDM1VkQzZ4RUljQWtOak5TaVJNWERsNTBFR3hJOTdCNzYv?=
 =?utf-8?B?c2cwVmQ2L25LQWQ5em5GOSs0QVBJRlhUd3MzUndGT3F3WDliMlI3TkVzTy9R?=
 =?utf-8?B?a2s5d0FPbFVlTnF0V0gxcFdBclhoZnYrRzNOMTNMWlJwdnVoSERXY3JIZHBu?=
 =?utf-8?B?RkQreVM3ZWFKSHN2amFCWVBUL3dlQVFuU1c0ZG1FWEtrZ0pIbjJRNEF6djk4?=
 =?utf-8?B?Q21nQVB6RlBvYm5PWkFoVFlFNzROT2U4N2t4UENtS0t5OE5sMUJCSHZXY0tH?=
 =?utf-8?B?WlVJYkdyV3dGK3NEamVtSlpTZ09La2Z5eloyUG12M0Y3bXNtNVdjWmpBdlNL?=
 =?utf-8?B?ODZ5aEhVR2NTbkU0QXBIQmxJMW03VU4xZUFMY3VPc3F2SXFyNkU5K0d2RVZN?=
 =?utf-8?B?dmZoWWtqemZJSG9RMTIvOXg5c1pOUE54QlZpbkRVL0lKUW8rMm9RckczZEhX?=
 =?utf-8?B?dTc0K0o3Y2tZMVdNWkZGK25oazJnZUR4dy9GL3RRYldNeUNzSy9jU2RHeThD?=
 =?utf-8?B?M2k5R0duWkx6d1ZNLyt1Zjk1blVhbmR3SEJ5SXlCTjh5dFFjSytiZGdtQVFr?=
 =?utf-8?B?UHdVTXRta3ZMUnQrZ2xrUzZXOVJLR05WbkZtTXNRL1VSYTdsb2ovK1phNE50?=
 =?utf-8?B?R2V0WXBiY3pYbmFIMjUrTTRFL2xVOENjamU5V3ZPT1B4MkhCeUxjWi9QcXND?=
 =?utf-8?B?ZjMzWkFaN2JBQXRMcG5SY1V0b2xkTTcxUDJNak1scGtPdWdaTkRkOHJHbENR?=
 =?utf-8?B?OFpIKzgxNlpjSm1JUE9jOUc5bkRxZmMxMy9QbStHZ1hiNkxmN2dHZHhpRGVF?=
 =?utf-8?B?QU9TZzZWWEUyazM1T3BGWnFmbXlyTUhLSWRqOFc0MW1abXAvUGE5QT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e06cf2f-d2f5-4f35-d98b-08de4d078ec4
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8784.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2026 09:39:59.1352
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lCVsIq+4Z0kCrVfTzjjylao1oxMesioQXs7tCHD0JOb1Ldw8+7VrDMP2PahLb4zM5mLw9gHXW9aXTEG9HM+htg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7926

Hi Uwe,

On 15/12/2025 14:16, Uwe Kleine-König wrote:
> Hello,
> 
> the objective of this series is to make tee driver stop using callbacks
> in struct device_driver. These were superseded by bus methods in 2006
> (commit 594c8281f905 ("[PATCH] Add bus_type probe, remove, shutdown
> methods.")) but nobody cared to convert all subsystems accordingly.
> 
> Here the tee drivers are converted. The first commit is somewhat
> unrelated, but simplifies the conversion (and the drivers). It
> introduces driver registration helpers that care about setting the bus
> and owner. (The latter is missing in all drivers, so by using these
> helpers the drivers become more correct.)
> 
> v1 of this series is available at
> https://lore.kernel.org/all/cover.1765472125.git.u.kleine-koenig@baylibre.com
> 
> Changes since v1:
> 
>   - rebase to v6.19-rc1 (no conflicts)
>   - add tags received so far
>   - fix whitespace issues pointed out by Sumit Garg
>   - fix shutdown callback to shutdown and not remove
> 
> As already noted in v1's cover letter, this series should go in during a
> single merge window as there are runtime warnings when the series is
> only applied partially. Sumit Garg suggested to apply the whole series
> via Jens Wiklander's tree.
> If this is done the dependencies in this series are honored, in case the
> plan changes: Patches #4 - #17 depend on the first two.
> 
> Note this series is only build tested.
> 
> Uwe Kleine-König (17):
>    tee: Add some helpers to reduce boilerplate for tee client drivers
>    tee: Add probe, remove and shutdown bus callbacks to tee_client_driver
>    tee: Adapt documentation to cover recent additions
>    hwrng: optee - Make use of module_tee_client_driver()
>    hwrng: optee - Make use of tee bus methods
>    rtc: optee: Migrate to use tee specific driver registration function
>    rtc: optee: Make use of tee bus methods
>    efi: stmm: Make use of module_tee_client_driver()
>    efi: stmm: Make use of tee bus methods
>    firmware: arm_scmi: optee: Make use of module_tee_client_driver()
>    firmware: arm_scmi: Make use of tee bus methods
>    firmware: tee_bnxt: Make use of module_tee_client_driver()
>    firmware: tee_bnxt: Make use of tee bus methods
>    KEYS: trusted: Migrate to use tee specific driver registration
>      function
>    KEYS: trusted: Make use of tee bus methods
>    tpm/tpm_ftpm_tee: Make use of tee specific driver registration
>    tpm/tpm_ftpm_tee: Make use of tee bus methods


On the next-20260105 I am seeing the following warnings ...

  WARNING KERN Driver 'optee-rng' needs updating - please use bus_type methods
  WARNING KERN Driver 'scmi-optee' needs updating - please use bus_type methods
  WARNING KERN Driver 'tee_bnxt_fw' needs updating - please use bus_type methods

I bisected the first warning and this point to the following
commit ...

# first bad commit: [a707eda330b932bcf698be9460e54e2f389e24b7] tee: Add some helpers to reduce boilerplate for tee client drivers

I have not bisected the others, but guess they are related
to this series. Do you observe the same?

Thanks
Jon

-- 
nvpublic


