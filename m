Return-Path: <linux-efi+bounces-2787-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5063A30304
	for <lists+linux-efi@lfdr.de>; Tue, 11 Feb 2025 06:45:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30FA8188B617
	for <lists+linux-efi@lfdr.de>; Tue, 11 Feb 2025 05:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15F031D514F;
	Tue, 11 Feb 2025 05:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="JKDOd/Rd"
X-Original-To: linux-efi@vger.kernel.org
Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazolkn19010013.outbound.protection.outlook.com [52.103.67.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E6012F5E;
	Tue, 11 Feb 2025 05:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739252747; cv=fail; b=AHbEcnXlQypVhXK6MVBmysZ5A3pJD4m2ZDaNX5aQs9jSgVhBKFKJEWlPU0zk5D4te+sGF21t+Gu5WMsj9JWe2LDrLwVw3qfVXsE2+h8BB4EtuIcBfi7PbhgyrsF8AlB52xpbO+SC14B8e8VgGWaaKjd5TsA2P4JAqQUYCxdA/0Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739252747; c=relaxed/simple;
	bh=w685cpyFnuQjetfbJdiu1YsRBRSnvodPTCbbb8yWZvQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=g78Buk36icnlqFRy1SC0KSQ3BOmt2rZG14dMnNCmWex/A602Bi14lqgBfs+bJqkABEGemlbLALTVSDpOsxe3z3nSP+SvwTjX4qv3SIEbxbNdPiMbaC2NNSIDRaJuR+1T+ydiTVq7d+dPCE0MrJQ10JPqtSsBdBuZDDRS5I+TLYA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=JKDOd/Rd; arc=fail smtp.client-ip=52.103.67.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PfWIPos9R3srMzW7HFmzmheT0LwWdMTMxmge+YGQ7YjrfMfVXB6qkg4o7pnrsUsfFRUaICHGBsNB3OMxj8oVXy0g6TjOXvZK0XhPWdKJSqf3ZHyd8zDoxIH/FGFj1iL+/Gi1lMjumNA8ns7IiAKRDEJ10OAHW5NuYIl62F3RZWrLfJowNJlV43ubqSNouA7XfyL4n9GIB6SWQh0B3EPZ3+tw17QcYhbHkJ+uwzUhfEyLv9V8QZ824pCpaK1mkmvj6c44p5OrYKmxMRZozZj1Ve7vW6FLiunSwasGRyl+joXkZV0J8rQ1AUlEGsN4nC5XHDrrQwT9bxt3AY2Xi+pzCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w685cpyFnuQjetfbJdiu1YsRBRSnvodPTCbbb8yWZvQ=;
 b=qjmz6s/bfTl0EvcpDfXA2VE6dZGrVs7nzX54L6XzHkB1pX3uqUfP4me6luaREVuvWWQDG3IckYkKdTtfaoWPH/VFLHIQwgzcGO07vOEtWNq13/dzrnL+KwS/CKoJHWxuKjvDkQLTd/HBp3WJ/EfWjsFgYHejn6JGnHnmMD5fAqYdKz8X9ACiz4iTE6x2cAnMJfTnT77yrQuxDfnGPwSbnwejt0pcqA8i8HLjh/tkDT0tQWiHP/JIE16Q6Yj6Ts7hrMHnm84Xvaec+VyCOp4EvWA1KaNQUlXmhpsxDp8QDwqsSeIRr4IaKqlLpNpn3N2+X0pqrw3KShSt/QL8B/u0XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w685cpyFnuQjetfbJdiu1YsRBRSnvodPTCbbb8yWZvQ=;
 b=JKDOd/RdOaA0ds8MLGV5H5BCJrgjGZjEzUAd1n39AcX1Cg87RilXJIien5943NZpf3ZEBuFh7Ytqd7YCt/v8umKnKDpJJuLErz45ZLC45rQhlHr/GqiGApT9zUtBmh+UOSLhYmoM4THqZfsOjt4I282RahUEC+u3lQ3/gGvPLRPROawQ0YZRet4CTXKkTb6tL3RXvONvwJMFE7LV2L6y4eyVjT0lJZQc/VCR8RJd89rPdIkFDIr1ELKEd40csKsTs/j/VmN3ludk5yaZnkU791ou+ZNVNJ3/LzP6FRPaSEuyaGc0K/Bkgjus4GkS0Wj/aPdxsvO4RdCoDUgNToYpVg==
Received: from PN0PR01MB9608.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:110::10)
 by PN3PPF4B900EFAD.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c04:1::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.19; Tue, 11 Feb
 2025 05:45:31 +0000
Received: from PN0PR01MB9608.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::972:abe8:752:bbde]) by PN0PR01MB9608.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::972:abe8:752:bbde%5]) with mapi id 15.20.8422.015; Tue, 11 Feb 2025
 05:45:31 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Lukas Wunner <lukas@wunner.de>
CC: Lleyton Gray <lleyton@fyralabs.com>, Ard Biesheuvel <ardb@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>
Subject: Re: [PATCH] x86/efistub: Add options for forcing Apple set_os
 protocol
Thread-Topic: [PATCH] x86/efistub: Add options for forcing Apple set_os
 protocol
Thread-Index:
 AQHbWWa5RmJr6eRYF0KZY8iXtrQUd7L8/foAgAACjoCAAAg9AIAAgZCAgACTR4CAA7KhR4A/bD+AgAChBRg=
Date: Tue, 11 Feb 2025 05:45:30 +0000
Message-ID:
 <PN0PR01MB960815D7115B2DE62E27DCC4B8FD2@PN0PR01MB9608.INDPRD01.PROD.OUTLOOK.COM>
References: <20241228202212.89069-1-lleyton@fyralabs.com>
 <Z3EdkuCBzTGzTHK3@wunner.de>
 <CAMj1kXHWoD78QdFnEY_=Mtz02zN3rhN5+Skgv=fHG91TD8Mmvw@mail.gmail.com>
 <Z3EmoNWbkbYZ7NZO@wunner.de>
 <CAMj1kXEb9NPSwEr2brHYJtFQhnW55hoPycjcAgoPAfjU5ZFqZw@mail.gmail.com>
 <abe2274b-4341-4212-85a8-113273ce1b18@fyralabs.com>
 <PN3PR01MB7728B4C94846673A5FFACE29B80B2@PN3PR01MB7728.INDPRD01.PROD.OUTLOOK.COM>
 <Z6pc5SYaMhOfXeDz@wunner.de>
In-Reply-To: <Z6pc5SYaMhOfXeDz@wunner.de>
Accept-Language: en-IN, en-US
Content-Language: en-IN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN0PR01MB9608:EE_|PN3PPF4B900EFAD:EE_
x-ms-office365-filtering-correlation-id: 94aefaf7-46fa-4c1f-dd47-08dd4a5f4bc4
x-microsoft-antispam:
 BCL:0;ARA:14566002|19110799003|15080799006|8062599003|8060799006|461199028|8022599003|7092599003|6072599003|440099028|3412199025|102099032;
x-microsoft-antispam-message-info:
 =?utf-8?B?cUdZV1Q3a3RPOGdiRjhtWkYwU2NkMk9OaURHaGNBTDV0a25zWW56dnpLR0k2?=
 =?utf-8?B?aE5uUlorK1N5MlJhR2hRYmt2bFd3Y0o3WGFNbVRRUUsyc3Zmb3JDcnpxUmMv?=
 =?utf-8?B?WUQydGQ4N1Y5WDcvYmNBR2RJdU91d0ZCT0FPdFhLTmZHdGtTNk9WUHBkamM3?=
 =?utf-8?B?MGthSjIyUE9lODVZSmVhOTY3Y2NVVC9pK0FPekVMWnBaQXVsUjdUa1lENnpW?=
 =?utf-8?B?ZEU3alhuaXFRZEpJdzR1c3U2QXV2a1NpSVFXU0NIWFpXWklwS3haTmtyS0V5?=
 =?utf-8?B?NmxUTWNUdHNBMDM3RElRd3dYaHorL1NyajQ0Tk1saVVML2hlM25wMEF0d2x3?=
 =?utf-8?B?WG5UNHlRU05HQjE0ZjRVN0ZiV2lNb0NiS0J1SlpwdWtKdkR2VlI3eGFIbHhV?=
 =?utf-8?B?KzZxcURYejYxeW41Z0doZnI3ODBSaUZYczlKVU5kWEd6Nms2TVNMc2FDN2NM?=
 =?utf-8?B?OWhkVTNwTVRnWGdDdG40bnloOThIN013QVJObk1jRHVEV05vQzkyYjFlaCtB?=
 =?utf-8?B?ZmtsVkJ0MTVXODcrUVdaemV4Z3Y2YXVTU1pRTEVBZHViS2RtVkRmcFpKL2lD?=
 =?utf-8?B?NVk4SVFtSUgwaTV5U2JLQmRCbmVGenZoMUw3bW9PdXFaZ2V0Tk1rNUpnUEF1?=
 =?utf-8?B?dzI3aU55cStxekRYckNoRGh0dm1rWmU1VzduWWJsUDlsUmx4YThiUnVnYmd1?=
 =?utf-8?B?SitxbDE3SzJ2bGtuKzhieUxyUWhKUGRIVjgxa1NuWHJOVVozb3lIWWx5OGMz?=
 =?utf-8?B?by8yWW9TMnM3RmtmM0ErdmxueVpwY0xHdzk2TzZna3VUaW5Ha2dUcjNnMTEr?=
 =?utf-8?B?KzB0VUJjdUI0SjhJUkhTMy8za1loaG9laWVCaUF2RlEwRzUwWHhacmJVTVJP?=
 =?utf-8?B?NGU2bzBRU1ZRaTZKRzRCNERRMU4xWkNvNkhyaTBDYllKakhndkRYQ3ArUVBD?=
 =?utf-8?B?WVBLTHdJM0ErUXZrVklBVmo3aHpoYUlUSm1jUHFLQWZsancwZUdnTHRtWnl3?=
 =?utf-8?B?cXBtSUg2cExySzllaW5MWUxXRTExSE94S0o0MTBXUy9jSTRRSFZoYldQZlFJ?=
 =?utf-8?B?Zm92N3FmOW5NZWVNR0l2N3FVZTV3bnhjTUlsNTIrWWdVeFROdU55RFQ3RHlM?=
 =?utf-8?B?cWtRajlWWGZ3U3E2LzFtQTZaSjdweVFWZ01lTE5GcU01MUJMdEx4c0hoeTFl?=
 =?utf-8?B?Z252ZENBdkxxL2x6Y3RnMXVKc2M4MVlaYStSTkxoSis1Q2VXNTBVNmtrRkNs?=
 =?utf-8?B?LzJEd2VjTDdNUzJuV21QNWxhUGpRL0txV0FWR0ZETWsvZEZNR0RLRERlQVhq?=
 =?utf-8?B?clYyTjBDWng5YnhsUEpzV0J0VjByOWxiR2ROQTlNbHJVTHMvZWppNHFUdzEv?=
 =?utf-8?B?ZDdCbXJ1aytna2ZrNkpwSHlHQ1ZKdFVJQ0ErOTU1NXB0aDBtcUJIajAvK1pQ?=
 =?utf-8?B?T0lscEpUODZ6cjJVMStWK2tyc0Z5LzVweDR1Snh5NmRzTXdGQ3FYUGFodytF?=
 =?utf-8?B?VlV4emFPb1VmWUE0R1JQeitONUxWR0lJK1paZ1R0azJ3UlUwdWQ5UEszbjNE?=
 =?utf-8?B?cnkxZz09?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YzA3cWdINmpWR282UnR5T1Nra3UzR3czV1U3Vjg3UURxY1B2RFFQNVhSdnFV?=
 =?utf-8?B?L2dJUjZsWUY2RkRvdjRQbnBKait0QTljMnYzZTBkMDJPOE5IcHZQb0pCbm1I?=
 =?utf-8?B?TGt4OWd1d1VYQ3V2Y0hiZEN6ekZJREVnQjNyRDBWVzZERy9MZm1iRmFOOVlF?=
 =?utf-8?B?M1l1QXhxd1dXRk5iczkrQUUrK3AvOHNkTWFNWjVuUTdMVk5oWitFaUZLR2lO?=
 =?utf-8?B?MnZVQmtBcmVGWDVKZnpjbWxTVU81M3RvYlhRNGhGRGFnOTZMZ2FHZ2MrR0ZX?=
 =?utf-8?B?UVZYT1BNdEZtTHZQZklHZnowQVVCamVDV3NRNnV2YW9uWTYvTmJUTHFUb2Yw?=
 =?utf-8?B?amlUc3VXM05tZHFZMnlsbHBuOTZUckIrQUhFL3hIOE1LS1RBbU1RRGxUejcy?=
 =?utf-8?B?V01kRGd0V3dPaUJXVkxLcW9ZcmI3L3ZLMTdOMTUvNnVOT29WY3l0dzE1bHFQ?=
 =?utf-8?B?anpLRGlncVFkZStzZzF3K29QUzR2a1pRdGxwMmFWQjNIN0F4OGxSK0x4NHFM?=
 =?utf-8?B?SEZ1MlZnOHV3ay9uVFdXQW5vMzl3RlVldmdTTGcyL05iTWNRZ2ozRnBIVmRs?=
 =?utf-8?B?aHorQU1xRkpqNHZ0MGVJL1hKZnRadEs1cW94SHdLUG5SSDllMVlwRkZXOFVJ?=
 =?utf-8?B?RE5DeE1qTFNFZmNGQ2xPKzBxdkxqV2ZrekhYbFYzNXp1RVUyUzRTUW9TVWxp?=
 =?utf-8?B?M1lmVDVxa3NWYVdUUWs1WFNHUUcvRGFsTjlnaUR6K3NlQkVvSld5L3A0WDIv?=
 =?utf-8?B?ZmtybTgxOWhtdUkwZmh2ZUp4TzZEZkdPWHNHS0dhUEtoc0x2aEZaSUNXWUEx?=
 =?utf-8?B?dkxPbXQyL3lvNXhleVhwNnQ0RE82bWcyUi9ES1dVTFMzUkY5ZTlWNnpoK1Qr?=
 =?utf-8?B?b1ZmalF4c0dwWlRWbCtqUThkd0RncXJsNFlqT1lCSjBSQjRXR2g1SnBRTGZP?=
 =?utf-8?B?N1QvRkFERE1BMm1FV3NJYXVCMjM1VkczZlgzbkhpeXpVQ1NQN3Y5VGxoa3RM?=
 =?utf-8?B?K1ZXZytuNnkvTmNiRWVzMC9ieU03UUU1QmdiYUdGTGxJMFJwaUNuNk9yeTNL?=
 =?utf-8?B?Y1VXN1k5MmVXWVVIUVhncHdOSHJVQmdiM1RMRjAwQTZoU2tSQnZUY09kcEtw?=
 =?utf-8?B?REpyRERydjA1ZHhDMzlVUk5xb1BvUU9HMDBMdWh2Y3FVMXR5L3FienJMMUpC?=
 =?utf-8?B?ckY4UU4wN2s2QWMzeFhMZkJZWDZvbGdVUUZTOXpFcWQrTkdVRS92U2JYV3M2?=
 =?utf-8?B?cHRxS0Y1SlZsZCtibTN6L2t2b2xFVVJHMnEzdzAvR1dYdEZDV0RBMUl2SXpz?=
 =?utf-8?B?VTgwQSthRzhJbUEzTWJGVHNPNmdRTkVWVlplY01VZ3FRQ2dha3J1QmZlUm0x?=
 =?utf-8?B?cGZlNWRGYlZOZ1UxeDgzeGdmcGVsS0tUZ3FVdWp3d3BpekpOWlRxa2RZdTB1?=
 =?utf-8?B?VCt0WEVtQjQwNEw3YXd4NS93aE93MjJQNzlxN0NseFlvR1dsVTdZZC9lSFBO?=
 =?utf-8?B?VStwaUZtMFJWM2pwaGlrMnFjVmVkb0ZOcmpjd0tXOWk2RUxSMGFITy9pL2l6?=
 =?utf-8?B?YzRZdnZKMmlXZWU3L29PSmlSWW05WUp0MFVKc2FZMHc0TkM5UGE1dlM2Sngv?=
 =?utf-8?Q?eOLVdkdvQvDuDBRhqg9CPtje1u8ELsycb2rgcIaOpOF0=3D?=
Content-Type: text/plain; charset="utf-8"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 94aefaf7-46fa-4c1f-dd47-08dd4a5f4bc4
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2025 05:45:30.9832
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3PPF4B900EFAD

DQoNCj4gT24gMTEgRmViIDIwMjUsIGF0IDE6MznigK9BTSwgTHVrYXMgV3VubmVyIDxsdWthc0B3
dW5uZXIuZGU+IHdyb3RlOg0KPiANCj4g77u/T24gV2VkLCBKYW4gMDEsIDIwMjUgYXQgMTE6Mzk6
MTNBTSArMDAwMCwgQWRpdHlhIEdhcmcgd3JvdGU6DQo+PiBXZSBoYXZlIGhhZCBpc3N1ZXMgd2l0
aCBvdGhlciBwZW9wbGUgdW5hYmxlIHRvIHVzZSB0aGVpciBlR1BVIGlmIHRoZWlyDQo+PiBNYWMg
ZG9lc24ndCBoYXZlIHRoZSBhcHBsZSBzZXQgb3MgcXVpcmsuIFdlIHByb2JhYmx5IGNvdWxkIGRv
IGR1YWwgVkdBDQo+PiBjaGVja3Mgc3VnZ2VzdGVkIGJ5IEx1a2FzLCBidXQgd2lsbCBpdCB3b3Jr
IHdpdGggR1BVIGhvdHBsdWc/DQo+IA0KPiBBYm91dCBob3RwbHVnOiAgVGhlcmUgaXMgYSB0aW55
IHRpbWUgd2luZG93IHdoZW4gdGhlIEVGSSBzdHViIHJ1bnMNCj4gZHVyaW5nIHdoaWNoIGFuIGVH
UFUgbWF5IGJlIGhvdHBsdWdnZWQgYW5kIGluY29ycmVjdGx5IG5vdCBiZQ0KPiBkZXRlY3RlZC4g
IEkuZS4gdGhlIHF1aXJrIGlzIG5vdCBhcHBsaWVkLiAgSSBkb24ndCB0aGluayB0aGlzIGNhbg0K
PiBiZSBmaXhlZC4NCj4gDQo+IElmIGFuIGVHUFUgaXMgaG90cGx1Z2dlZCB3aGlsZSBFRkkgYm9v
dCBzZXJ2aWNlcyBhcmUgc3RpbGwgcnVubmluZywNCj4gQXBwbGUncyBFRkkgVGh1bmRlcmJvbHQg
ZHJpdmVyIHdpbGwgc2V0IHVwIGEgdHVubmVsIHRvIHRoZSBkZXZpY2UNCj4gYW5kIGl0IHdpbGwg
dGhlbiBiZSB2aXNpYmxlIHRvIHRoZSBrZXJuZWwncyBlZmkgc3R1Yi4gIEUuZy4gaWYgeW91DQo+
IGhvbGQgZG93biB0aGUgT3B0aW9uIGtleSBkdXJpbmcgYm9vdCBhbmQgYXR0YWNoIGFuIGVHUFUs
IHRoZW4NCj4gc2VsZWN0IHRoZSBvcGVyYXRpbmcgc3lzdGVtIHRvIGJvb3QsIHRoZSBlR1BVIHNo
b3VsZCBjb3JyZWN0bHkgYmUNCj4gc2VlbiBieSB0aGUgZWZpIHN0dWIgYW5kIHRoZSBxdWlyayBp
cyBhcHBsaWVkLg0KPiANCj4gSG93ZXZlciBob3RwbHVnZ2luZyBhbiBlR1BVIGF0IGV4YWN0bHkg
dGhlIG1vbWVudCB3aGVuIHRoZSBlZmkgc3R1Yg0KPiBydW5zIHJlc3VsdHMgaW4gYSByYWNlIGJl
dHdlZW4gdGhlIGVmaSBzdHViIGRvaW5nIGFsbCB0aGUgaW5pdGlhbGl6YXRpb24NCj4gYW5kIGV4
aXRpbmcgYm9vdCBzZXJ2aWNlcyBvbiB0aGUgb25lIGhhbmQsIGFuZCB0aGUgRUZJIFRodW5kZXJi
b2x0DQo+IGRyaXZlciBicmluZ2luZyB1cCB0aGUgZUdQVSBvbiB0aGUgb3RoZXIgaGFuZC4NCj4g
DQo+IEJ1dCBJTU8gdGhpcyBpcyAiZ29vZCBlbm91Z2giLg0KDQpTb21ldGhpbmcgaXMgYmV0dGVy
IHRoYW4gbm90aGluZy4NCg0KSSdsbCB0ZXN0IHlvdXIgcGF0Y2gsIGFuZCBpbW8gcmVzdHJpY3Rp
bmcgaXQgdG8gQXBwbGUgZGV2aWNlcyBzaG91bGQgYmUgYSBnb29kIGlkZWEuDQo+IA0KPiBUaGFu
a3MsDQo+IA0KPiBMdWthcw0K

