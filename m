Return-Path: <linux-efi+bounces-2775-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61281A2E9F9
	for <lists+linux-efi@lfdr.de>; Mon, 10 Feb 2025 11:51:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F084A167911
	for <lists+linux-efi@lfdr.de>; Mon, 10 Feb 2025 10:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49E341CBA18;
	Mon, 10 Feb 2025 10:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="LcJEzTeo"
X-Original-To: linux-efi@vger.kernel.org
Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19010008.outbound.protection.outlook.com [52.103.68.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659C01CAA82;
	Mon, 10 Feb 2025 10:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739184686; cv=fail; b=ffXCkxxRV7k3vlcWSNkf3m2R1qWTmpzrTdbPVinYrHi0NU+UD4bkq8fIritW/kIbudAZpQq9VB62WNBc/WhrEghx7BIQgEyzsxV2TXY+g51YPMi581ZgCRQQ6TUVEh4SjA26gBP2tMRWPFfsW3BH0INSOa/Gtjmvd0lY3ylimW8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739184686; c=relaxed/simple;
	bh=GzcL+EbJHwSPh4x9mOAgREN63m/BCA9TCff6rnttlm8=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=DsAO+pmUGOPyQl2wCuC2+63xklcvgpX/5qy3WT2AQTMOx5ooJIyp3IQ4+Q6jHlnpIKS9vAV5BBjfqLnYqlvTUcDne4vHZ1NPGoPwRD1GLUyIw6vBmhxtJTZJC7rU25N3K+ReA76vRVBNC8sSBLM4VnIj66ItDGt/bQ6oyqAnPIg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=LcJEzTeo; arc=fail smtp.client-ip=52.103.68.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IbNpIqjkbUVHWQBnnYZPni0qksFAABo/m2CqgzQWz1Qgwt7LjRKuwaei+LI9CrRPjRtB8o2QyB26MTFaL/UA4e6fcoNaC0FoFV8yVCXvwv5xfOLr24tTUs5/JIOdYM2Vl0BbJcG6hA9I0/VPO0O+o73dprYqRJ47B8fTiPc0ze7gCD4ZXU1adPwIKeWhQSeZ4ettO/LcMtty08P04bC9u26fJIKXMQpIBW6qmIUT3EfUv37CpDW2IjXE1m73DU3DXB1zqXBI8Ho/L1duIOSaV3/PvjCzMxJ26d4vV5vree5WFsYtfLNq/1PtQvJsnAeF0jgzElIobtk4mW1V1FTkkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GzcL+EbJHwSPh4x9mOAgREN63m/BCA9TCff6rnttlm8=;
 b=DP2fQ/O1PBR4lPUh8PetIRr0f/gBGAl1+tGT/dHfg2r15ZEmwOS4ZS9TwIMwwaiKOSTTfXwrgxYwYKeIGHvjcmvFDsVc8VN99vKFwEOpNx/NeX+gr73RzAxgCfVDPv87y/ST8kXUO1cYKIDAQnajWfqwdp3liYNGqKR3BtTyVJDLdRNfNTYYzKATSLO4K7OSj8vR/+uPdrzzG+f1JacjYBt8LlfRNUpny66F2EyI8Zqv1SIQLQZ7E+JweZY2ZMQjHsr1PTrQT7hnbptIJ8GCLYNWCijTYLl0TG1YtynL3Osru4UOY+4k+ACS/ELT2Rp29/KqtOidebJ9gzEKuDnOSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GzcL+EbJHwSPh4x9mOAgREN63m/BCA9TCff6rnttlm8=;
 b=LcJEzTeo8dhS3HYQL6HP6ViIv4a5MoPsnsvCjqKgHDf5NSLKkbcqTduhsugU0UWjGZ5khBbYLKj+vIi879/FUdsGrp00RN/fvOZIEowOaPxwuzPe5p+JXDtqsa2T3Wdb4/uUjV4yf8VXvEUev8/wt6RYV0JtMcE10POYGDoFYuys0fII5AnMgtWVqFoF7VEBAv8bSzZbJWFLaZmCHNH+9hWH6RuDo/waxbeZ2LPUwaxcfTFGcxkcMFOsvajDP1ksChCgdTaszhrrwOY+0sQ82MlWIdJmKDrlgDd3MJg4khJUewOSNjazS9iAqce8rm2iME5amYdDNO23fz5xWegysQ==
Received: from PN0PR01MB9608.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:110::10)
 by PN0PR01MB6182.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:6b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Mon, 10 Feb
 2025 10:51:16 +0000
Received: from PN0PR01MB9608.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::972:abe8:752:bbde]) by PN0PR01MB9608.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::972:abe8:752:bbde%5]) with mapi id 15.20.8422.015; Mon, 10 Feb 2025
 10:51:16 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Ard Biesheuvel <ardb@kernel.org>
CC: Lleyton Gray <lleyton@fyralabs.com>, Jonathan Corbet <corbet@lwn.net>,
	"Paul E. McKenney" <paulmck@kernel.org>, Andrew Morton
	<akpm@linux-foundation.org>, Thomas Huth <thuth@redhat.com>, Steven Rostedt
	<rostedt@goodmis.org>, Xiongwei Song <xiongwei.song@windriver.com>, Jeremy
 Linton <jeremy.linton@arm.com>, Ilias Apalodimas
	<ilias.apalodimas@linaro.org>, Kuppuswamy Sathyanarayanan
	<sathyanarayanan.kuppuswamy@linux.intel.com>, Jonathan Marek
	<jonathan@marek.ca>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Kees Cook <kees@kernel.org>, Borislav Petkov <bp@alien8.de>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>, Lukas Wunner
	<lukas@wunner.de>
Subject: [PATCH] x86/efistub: Add options for forcing Apple set_os protocol
Thread-Topic: [PATCH] x86/efistub: Add options for forcing Apple set_os
 protocol
Thread-Index: AQHbe6m1CeGdmUFcoUGFNQ/OO82oTw==
Date: Mon, 10 Feb 2025 10:51:15 +0000
Message-ID:
 <PN0PR01MB9608DE674948F6176CD301F8B8F22@PN0PR01MB9608.INDPRD01.PROD.OUTLOOK.COM>
Accept-Language: en-IN, en-US
Content-Language: en-IN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN0PR01MB9608:EE_|PN0PR01MB6182:EE_
x-ms-office365-filtering-correlation-id: 2d7036e9-1d84-4262-ab17-08dd49c0d7c8
x-microsoft-antispam:
 BCL:0;ARA:14566002|8060799006|8062599003|19110799003|15080799006|461199028|7092599003|6072599003|10035399004|440099028|3412199025|41001999003|102099032;
x-microsoft-antispam-message-info:
 =?utf-8?B?bE5zU3F5SjFNblltRHFqSWJuQXdvM0tHZXhDSS80dFk5ZGpUNnFRVjUwYmFE?=
 =?utf-8?B?MzRwTlo1RTFYNlJORngwUDVocFppUVhxMG5NL1cxc2xCREluV012M2VJaWpH?=
 =?utf-8?B?bVRRdkI1cm8rYk9TWUJ5TlVFaUdZVVg5UlQzdkg0SGhXblJGRktXT0dkR1JQ?=
 =?utf-8?B?MVg3d0VINXE5WDVrTitRV0U0Tkpua0c4RFBHOEZvekJmaG1mMVoyQTBoNWc0?=
 =?utf-8?B?Skt1N2J1Y0pnT2xQcmlLeXd6enpNVlBiQmJTM1M4d2M5ekdQSUkrOUNha3N1?=
 =?utf-8?B?bDROTVZTTDhKR0c4WG1qVUhzNkd5dDlhNTZ2YkJzVTdJeFBCOVBrKzkrUFk5?=
 =?utf-8?B?Z2VlNS9vbDRGbzRrZ0crVldqSGtRMHljaDd5Wld0cWovMEUyeTUvYXBpVmNk?=
 =?utf-8?B?VHVyT2FyUlFZSmFDdjJjS1V2akZoK0p1c2ZGSG8zbkdGcnpUbmZGQngwZjN3?=
 =?utf-8?B?Z3NnVE9rZ2JEenRDVGpRWHFWTHFBK2xiWUw0MVNlRWppYUhUcmU2OFh6Rmtw?=
 =?utf-8?B?bWwrcHlyOTV0c2NCREl4MGd1ZFlkcGVBNUEyUERQYmR5Tmhnc3VPKzQzbkY2?=
 =?utf-8?B?ZFRyaEFWemRINnpCN1czNlNqTTNWYVJBT00ybXVWK3lyQ2l6SHpLTjN4d1pt?=
 =?utf-8?B?bUR3b05pUGJhWVJYb3plS3NEUHR1c2hnMTY1YTQwczRzOTdraXhIdWdIY052?=
 =?utf-8?B?UjJxb1A1ZENnYnphdVluOUdjekk5ZVdsUEhhczlzdWpQbUFNQ2d3ZGJISlBD?=
 =?utf-8?B?RzE2NFV5S2RqdElHWTJ0bTdUaS9YWUZLVmhKNnhPSGNxM3pqQVF5ektISnZa?=
 =?utf-8?B?TDBvSG9yZlRwWXhzN0Z0cEg2TTE3OGhudFFoNFh0N1hKbldNZitVTUpYS25m?=
 =?utf-8?B?NzgxQ0xZMys2dGdOSHJRWkk2NzBLVGIxWGFGMnl2ZFVBQjl6OHlXNnFsSkoy?=
 =?utf-8?B?aTlFY21WUSt6cjdiY0FqUGFsVktZLzEvanJJS1VlcG1qTXZMVHlTR3JiMDRX?=
 =?utf-8?B?cGVyaldvUHdJNlovSTFiZXovZFc3Y1ErTkgzSlpkUnZ3YUhOeHc2OHhmK2hB?=
 =?utf-8?B?bFJhM05DNVZINjRnZGVUclVCZHlnc1BtWmtjTFRqeG9NcEJYQXZPRkwrdEVB?=
 =?utf-8?B?OWt1ZWg5Q0h2cEFhS25jQWJFa0lpQzd0N2ZUdnJGYjhmeE5DRVRJdmIrZ0pa?=
 =?utf-8?B?TE5tRWFKZkkvbVRpa0JoMUtSRUpPc2FsZjVDMHkvbElDejRtTHUxWUFud3ph?=
 =?utf-8?B?OGg3L0M4dmRseHNKRXBDWkdoTHVrWVVMZXl5Q0lOWG1acjlvZ0FFcDF6UVZS?=
 =?utf-8?B?SXV2SFNvR3N0VW13ZEZ0c1FpdVlPc0ZYZTEwWjBMUzRsTWFCQm9OUVR3WVBV?=
 =?utf-8?B?U21EMnRwUDRBMXorQUV1RDhGcDVZSXhKbUpweVU5L1g5c1o3N1VXRXk1Q2NJ?=
 =?utf-8?B?Q2tBTnZmbHRkN2hjeXFybmNRMFRzZFZDQzVYNEN6Q0tyd21NVDFCNCt6d2lE?=
 =?utf-8?B?Mks0QkxMVUpVeExtTVl6dmhXbnU1TFRvVDBHdVJVVUxmMmQ2cjcwODBWYWZo?=
 =?utf-8?Q?oH6zyXpZNYOrGqOc1If+uqqVrU6SgLj3PeJeuMeamFV3vn?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Q2NzY0VEMTJGWUdTZkFiRTRsTkhoTjBIcU9PaktQV1dVMzBsMWk4VFJ6OVFT?=
 =?utf-8?B?biszU2hqZm01WDVuYmJzZnNyMlRpbmZLOHdFbTNNYXdiYWhpLzlqajBLU0dm?=
 =?utf-8?B?VXNCTzRHNmZ3SlBNL0pWTFBQTEFsT1JyVDdzQlYvejF2dUJHNG96RlEvNllv?=
 =?utf-8?B?UnpIcXlRK3ZlMkJ2OE1lZE1kbGVTelJVZU12UW5LOXI2QmhJRWRrQWpRMExF?=
 =?utf-8?B?TUFkcVFFVll3bXdOKzcwZ0c0bmI5SUVrRW9aSEVqanc0ZVF4TUh0Y3N5MFNY?=
 =?utf-8?B?L2hBVTJtUzhKZGovVG1nRzRQWkF2cXBhR2wvSWVVVkY3THNselUzeUZ1c3JP?=
 =?utf-8?B?TlQ4R1U3MEdKaHNnNEljcWJiUUJZQmw5WEI2c3B5NU1JOWtWR0FOMlFlb1RM?=
 =?utf-8?B?U1hhcUVlclZDL0o2a3dzZlJTQWFIMDhieGR5eWhKaE80NHkvQXNnS214RUFj?=
 =?utf-8?B?SG03VCs4NjVBWnFKRHhoNUNXRUN1ZE0xaGc0YkpMdXdwL09iQlVaRVEwNXk0?=
 =?utf-8?B?WUQ0UGJOSXEyVFROZzFtOU5VRFRGZ3JoZHJJYWc3ZTg1K3ZLQXpVWUk0QjVR?=
 =?utf-8?B?UklUME56bnJXZ3psQjZxbk1hVSt4RjNSeGtiREowdnJqUUdEZ3lETHBuT2hi?=
 =?utf-8?B?cURwS1YwVjJuTjBXRkZDU25LTTFUL3FNeml1RTIrUy9GaDVyemRtWHM5L2tn?=
 =?utf-8?B?U2UwMDArVE54a1lVOXdqTDQ4aXN2enZkeDhFMWJ0RXpJbmZmM2s3azE1N25s?=
 =?utf-8?B?UGxzTEJaQUdHRjd5MXYxaXpMZXpaL3c1N1FNTmVuY3k2ZVZxUDBrN01lam5G?=
 =?utf-8?B?RzltVWxURWZzYWQzZDFLL1g3cy9nbElZUTY3QTFuZmEwRVVGamNPbUVDUVRz?=
 =?utf-8?B?eWlmeitEYVhuK09TQ1pCNy9IaGoyc1ZIaTJmVFNxRDJLUXpGVEx4V2dHaEdV?=
 =?utf-8?B?ZjRldmVyN0FzL2FPcWY4YSs5cHkrMHZBb1QwQzF0VlAxbTdXUGx6SmFGUGww?=
 =?utf-8?B?WEFpT29OZWhUbHRDWlpuODJRVlVFbWp6RzAxVHhUR1MvaUNCMVpLc0t4cERw?=
 =?utf-8?B?eU5FVUFnZTZPSEZoUkFJR3E3SnMxUG5FUEx6ODVHRWNscWdKeUlqMUs5TTg5?=
 =?utf-8?B?ckN6alNNYXdDaTZwVmJ2bXptNEpHVGtpSm9MTTlEclk0aWlKZHcrTkdzWUR0?=
 =?utf-8?B?ZTRwRmJpNU9OWlA5c05BQTFBbEdOeHlLN2NNdEtURWNzYVVvcHNEQUlRMFdD?=
 =?utf-8?B?T0RnbHhHYWhhdEtGOEZCS2pFMjNvWlpIVXZpM1owVkNQSzc1VnNwcG1FaVZC?=
 =?utf-8?B?QW9KUmMxU0ZLMzEzelhvYUU1ZVRDRWFFRU1DQ3Qxb1VZN3NVZVovMERQYW9k?=
 =?utf-8?B?cWRWVzdUMncyaHhvU2JQVE1aYWRIN1YrL1huNFNNeTVlS1hmQXEyY083aWFk?=
 =?utf-8?B?UVk0RC80aEJOa0xqRS9vL0VMRU5xbG5TTEtVTnJZSitHdUloNnRXZGVseTNR?=
 =?utf-8?B?am9lNzRZSTNHcXR4dG9ZeEtHQjNQTG9ETXZFK1k3bm83enVIeC9QUWpnYkVi?=
 =?utf-8?B?L2tpNUZRUlE1MFVJQXl0ZEg2dDZpSFduaG5SamZjUDdGRVFmemtyY25FUE8r?=
 =?utf-8?Q?mfnveGEIkoPjEO0TCblfZ8H6I4agHis15BTUUtgJ5YEI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID:
 <3997FB430BDDA149BD66E9BBDAB2AF84@sct-15-20-7719-20-msonline-outlook-ae5c4.templateTenant>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-ae5c4.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PN0PR01MB9608.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d7036e9-1d84-4262-ab17-08dd49c0d7c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2025 10:51:15.9210
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0PR01MB6182

DQoNCj4gT24gMTAgRmViIDIwMjUsIGF0IDQ6MTHigK9QTSwgQXJkIEJpZXNoZXV2ZWwgPGFyZGJA
a2VybmVsLm9yZz4gd3JvdGU6DQo+IA0KPiDvu79IaSBBZGl0eWEsDQo+IA0KPj4gT24gU3VuLCA5
IEZlYiAyMDI1IGF0IDE3OjEzLCBBZGl0eWEgR2FyZyA8Z2FyZ2FkaXR5YTA4QGxpdmUuY29tPiB3
cm90ZToNCj4+IEhpIGFsbA0KPiANCj4gUGxlYXNlIGRvbid0IHRvcCBwb3N0Lg0KPiANCj4+IEkg
bWFuYWdlZCB0byBnZXQgZmVlZGJhY2tzIHJlZ2FyZGluZyBlR1BVcyBvbiBvbGRlciBub24gVDIg
TWFjQm9va3MsIGFuZCBjYW4gY29uZmlybSB0aGF0IGFwcGxlLXNldC1vcyBpcyBuZWVkZWQgdGhl
cmUgYXMgd2VsbC4NCj4gDQo+IFRoaXMgaXMgcmF0aGVyIHZhZ3VlLiBXaGVyZSBkaWQgeW91IGdl
dCB0aGlzIGZlZWRiYWNrLCBhbmQgd2hhdA0KPiBzeXN0ZW1zIGRvZXMgaXQgY292ZXI/DQo+IA0K
PiBBbHNvLCB0aGlzIGlzIG5vdCBhYm91dCBiZWluZyBhYmxlIHRvIHN3aXRjaCB0byB0aGUgaW50
ZWdyYXRlZCBHUFUgdG8NCj4gZHJpdmUgdGhlIGJ1aWx0LWluIHBhbmVsLCBidXQgZm9yIGRyaXZp
bmcgYW4gZXh0ZXJuYWwgR1BVIGNvbm5lY3RlZCB0bw0KPiBhIGRpZmZlcmVudCBzY3JlZW4gYWx0
b2dldGhlci4gQUlVSSwgdGhpcyBoYXMgbmV2ZXIgd29ya2VkIG9uIHRoZXNlDQo+IHN5c3RlbXMs
IHJpZ2h0PyBTbyB3aHkgaXMgdGhpcyBpbXBvcnRhbnQgbm93LCBmb3IgMTAgeWVhciBvbGQNCj4g
TWFjYm9va3M/DQo+IA0KPj4gSSB3YXMgd29uZGVyaW5nIGlmIHdlIGNhbiByZWFjaCBhIGNvbmNs
dXNpb24gZm9yIHRoaXMgY2FzZSBoZXJlLg0KPiANCj4gSSdkIHByZWZlciB0byBhZGRyZXNzIHRo
aXMgaW4gYSBkaWZmZXJlbnQgd2F5OiBpbnN0ZWFkIG9mIGZpeGluZyB0aGlzDQo+IGluIHRoZSBM
aW51eCBrZXJuZWwgZm9yIHRoZSBoYW5kZnVsIG9mIHN5c3RlbXMgdGhhdCBuZWVkIHRoaXMgKGFu
ZA0KPiB0aGF0IHdpbGwgdXBncmFkZSB0byB2Ni4xNSBvciBsYXRlciB0byBnZXQgdGhpcyBmaXgp
LCB3aHkgbm90IHVzZSBhDQo+IHNlcGFyYXRlIGJvb3QtdGltZSBFRkkgYXBwIHRvIGNhbGwgdGhl
IHByb3RvY29sLiBUaGF0IHdheSwgaXQgd29ya3MNCj4gd2l0aCBleGlzdGluZyBrZXJuZWxzIHRv
bywgYW5kIG5vIGNoYW5nZXMgYXJlIG5lZWRlZCB0byBMaW51eC4NCkZhaXIgZW5vdWdoLCBsZXQn
cyBjbG9zZSB0aGlzIHRoaW5nIHRoZW4uDQoNClRoYW5rcw0KQWRpdHlhDQoNCj4gaHR0cHM6Ly9w
YXN0ZS5kZWJpYW4ubmV0LzEzNDkzMTEvDQo=

