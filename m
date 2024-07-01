Return-Path: <linux-efi+bounces-1345-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7531591D997
	for <lists+linux-efi@lfdr.de>; Mon,  1 Jul 2024 10:03:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1CA0B20AF3
	for <lists+linux-efi@lfdr.de>; Mon,  1 Jul 2024 08:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92AC875804;
	Mon,  1 Jul 2024 08:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="kH1bu1qW"
X-Original-To: linux-efi@vger.kernel.org
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01olkn2051.outbound.protection.outlook.com [40.92.103.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB95258AC4;
	Mon,  1 Jul 2024 08:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.103.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719820982; cv=fail; b=bmijSc/OkAlqPZm1svPRYzMP3BJIK7WtM5NQp3Ix4b5uInUOeTD4acCqf+AjGKgNuvKw5VTLC5I2YQ8aE3UIP4stkhXDSa3iQcOQiiBE+KlSV2OYpYj6nqpjUeFJTqfkbfyqyHmw9Ln1l/fCPlYbPI5VZUzOMwRnWzrwPTJIGYQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719820982; c=relaxed/simple;
	bh=AQDurnl84BixNsMz59aIORhX01ULNGEIfU+QDfPlHgQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JTf/lJj25e8I0s/J/GaZzsUVW/WVw71dfkiI4BCkM1WGBirOB5VkT54Jt//qeG+fz7pq/XxjRKpfGdbi2qJ0lUJtZbvpewtDX0AOh2pWi7Qrhi2w4vWCf5bxd/O1zj/rl1kY0fbV7bAau88rvJvITndYLq3Bd6gyWMgmBHD7ZxE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=kH1bu1qW; arc=fail smtp.client-ip=40.92.103.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gzn4KzPVv339jnuCQnlDfz1P/HjqQKk+L8JuxGCNLv8i5CoVpzoczllGkMpkCFyRVTc1fBMhNDX96mRRj62JeTEFn/+eYYRj82xjyxptjE1pAFLb9U92F44H+vbunVC+dokdtQRZP4q48AYvxGHdV8gaj40u3alXsXvhXVh93iNa/uiOLzOx4ryPvOJIgks1hcjI4u6UiLkrVAtRpBd+TWZe/MWoDMBcV9WGEAfCByrFpYMGviD8K8XlrjeIuTGUxsdpeuqbPZ1bp3bpmOy4WjTFVDKKhC4B7/OsdnsGYO4s0GUXdN+vDSqaTR+09CRorXQkxWL5erQms58xNGzr5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AQDurnl84BixNsMz59aIORhX01ULNGEIfU+QDfPlHgQ=;
 b=XGKySTLw7Ghbjw1ITINjVzSbBTNoNZ5y/DnXjGWRjFV3Cylg2TSnfoGDAsn3bk7+d2rKWHvhAa2JVFgdMKsZ8i41C1Cb3H7q7AR6PktiJ7vcdlaXsbETY3csk8TTLG5e+9CzyZs8Ov0KNXnqL0ql52wAVlho1jAjdUhTYXpkFLPZNJf0Q7av88pE+hp5K1QC+g2iFiToM26APpCJW61aRqn505ju/N5H5zCvRr/JV6LzBgNFZXntvjRhOrYwWZozpnhBUjgfE1+OcTGAUdCEGWCaPdc5lIindPUiFWa6HqQ8ehwa96mfNxDa8d9JtBt5ahT/WCFq/3ON29IdKKEYKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AQDurnl84BixNsMz59aIORhX01ULNGEIfU+QDfPlHgQ=;
 b=kH1bu1qW/lZBvcSqRHn8fvMz+qMIOVdOzXJaynDWMNQ2uaqLid7x+PyVxmTpkRMIoaqfEMRAVD9fK+E75Y0ZZ1zwU1hR/hExOX1eOdlvwTLIU7bKmYOsGLCkZezO5q30hxn1y8o8efb8QATyXeMO66A+eznb5yPrvPTvgkMmLS4fWSWaQjh6BxYECBL97vjinbRta3lrqX1jRrAqPyT/OmYQ2WJyJtdCTz02SQtfS4+z2gN0cpUvoJ8FwHZI2f5UzGVUmEFYxYTRz5OkXfFfEVsuxHVLmpVl7GPScA6sTI0NpODtre5O4XT5hmvWPG74TleEeTw/aPDa+ob+MiLTjQ==
Received: from MA0P287MB0217.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:b3::9) by
 MAZP287MB0471.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:d3::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7719.29; Mon, 1 Jul 2024 08:02:55 +0000
Received: from MA0P287MB0217.INDP287.PROD.OUTLOOK.COM
 ([fe80::98d2:3610:b33c:435a]) by MA0P287MB0217.INDP287.PROD.OUTLOOK.COM
 ([fe80::98d2:3610:b33c:435a%7]) with mapi id 15.20.7719.029; Mon, 1 Jul 2024
 08:02:55 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Ard Biesheuvel <ardb@kernel.org>
CC: Lukas Wunner <lukas@wunner.de>, Hans de Goede <hdegoede@redhat.com>, Linux
 Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>, Kerem Karabay
	<kekrby@gmail.com>, Orlando Chamberlain <orlandoch.dev@gmail.com>
Subject: Re: [PATCH v2] efi: libstub: add support for the apple_set_os
 protocol
Thread-Topic: [PATCH v2] efi: libstub: add support for the apple_set_os
 protocol
Thread-Index:
 AQHayyMw+x8Tv3BlDUuYLD8zHzW0zLHhWosAgAABBwCAAANoAIAAAXYAgAAMlICAAA3UAIAAA9mAgAAB9YCAAACgEYAAApwL
Date: Mon, 1 Jul 2024 08:02:55 +0000
Message-ID:
 <MA0P287MB0217751F3532CF80BA255DB3B8D32@MA0P287MB0217.INDP287.PROD.OUTLOOK.COM>
References: <75C90B50-9AB9-4F0A-B2CD-43427354D15C@live.com>
 <ZoJAAifMqIDXdniv@wunner.de>
 <CAMj1kXH3fvS259Y1mfYcKQbM2mUYbSfuf2ZiMXfFhjq-rzn5UA@mail.gmail.com>
 <ZoJDuunseVIDua-m@wunner.de>
 <CAMj1kXFKBsAXDLxinqiszH=6hEOjbJQL-nFgBsBceta4rUCN-w@mail.gmail.com>
 <ZoJPgSlZJ3ZlU2zL@wunner.de>
 <CAMj1kXHR+mCR5eibj23S26-PN6yLPD1uf9+H2fEEDhNWOh6TjA@mail.gmail.com>
 <ZoJeVWMU8yg4CRLl@wunner.de>
 <CAMj1kXFRNrmyAtVaqHr+RWQ22+++u70eJ__brLjmJa0ocyc0Bw@mail.gmail.com>
 <MA0P287MB0217F69CBAB2D5776D4AFA43B8D32@MA0P287MB0217.INDP287.PROD.OUTLOOK.COM>
In-Reply-To:
 <MA0P287MB0217F69CBAB2D5776D4AFA43B8D32@MA0P287MB0217.INDP287.PROD.OUTLOOK.COM>
Accept-Language: en-IN, en-US
Content-Language: en-IN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:
 [nTCP+fSnsqbO9CgpoxehzU/WAIWJvRwGMyd2eWAD+fLRU8+kvOhR/Zn85vlHK3TIF/P6xHTyGN4=]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MA0P287MB0217:EE_|MAZP287MB0471:EE_
x-ms-office365-filtering-correlation-id: 8a71cfb9-51d8-4dba-9438-08dc99a436e0
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|8060799006|3412199025|440099028|102099032;
x-microsoft-antispam-message-info:
 Fh/O31LOrwR6T9nuEOmwyNfjVUih3UvP3WLDHEzCkcVZx7LpA524rwIkVCGRHRGbc5Y9eZN5IENzs2F92BP+lmDjAa+8kgYFLUD+2QnYHwCUyHkCO0XIM/otdPznrDtT9o3hFenii3uwsdjE+pmssTzbyoviV+GuL/uPPqZU6jX/jNZT6nwu6pikdz9jYz4ltBIVaXVCyYzMPPx0ioPB0qCMeyR/t46oxs9E2jM8vmu1pgmUkZK4Lz92XYfe6iAvaSBels+3LZESSLaYacIKkAMN9Gim2VWeIeACC69hWjNJePSBi4iG4ErAFaPoLJhXA2CC8iCkm8icNE+u/xL91wCBcuUrEPZ7hjVCYcZSveqpvKE4K5n3SMI/NzicAINZta+sPZ2DpHaNqko2LcSzpO+HXKUMVTEniNsXk9PSyspg1Y5SxbiaxRlHqY42U/u31ZCNeWve/v4L/3g+i5U5H9/v4152FQssvHH3IgY02wxbHVS+NV/OmTmaD8PGHmWmj6yq8uCwcSdN804xoipN7vMXpZa55kEDw1pK7ixk+YyYxl+n8Ao02AAUVhX/ivJQSxYCYCRdAe11P+rg4oLP9TDdoJafJ1H/UoILHw9A5Tw5IeOjURb6ZWuvNLMI2AAR
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cFBqSUZEek1kYS83L2tKUE5aclk3VW1LSy83YTdhOVl1MDRiTlhST0piTXd6?=
 =?utf-8?B?aW1EN1ZyRkIzWUpUUmRZN3lwam13eTE3YmppOUYvR1cwNlZVeUY0NG94aytr?=
 =?utf-8?B?anMyMlFERi9BV3hmQTNhV2FJR0VVOExPV2trRFE4SFoyNjdyaVorQTN5NU1N?=
 =?utf-8?B?ZVlqNEtOeDFZM1dHUlpKRE00d0lmNS92aVpPZkxFbGdzdDMrYXp6NmV2OHY1?=
 =?utf-8?B?Z2pqWVFHLzZRSG5QbXppYWtjRy9jQUFuZ2NtTGY4U09Td1NuZWxESWFoOGZa?=
 =?utf-8?B?ZTlpNTFUaDViek0wNk1adVV2aWNiR0tIRzdpVnNMVXJOd1UwaXQ4b3E0Vkwy?=
 =?utf-8?B?NTBlR0x0OTBLQ0RtMjJwOVQ0VjdTT242dGxYNkVpNU9BV1EvdEF1OTJMdGYv?=
 =?utf-8?B?RW9TNDNxMVI2NDV1TUZBUHlTZE9xN05xMkw5a2tzL013bGd3RTNEUG5Bb2Vk?=
 =?utf-8?B?Y2M3WGNpczV0NmVvV1p0L1pFTXJEV0J2aDhyMi9YY05qSzZ2V3lKakZpdEtn?=
 =?utf-8?B?aVBvcXR5aWRLdHlRVU1XZi8zUFhHUTN1MXpyK1M4VUx5b3p3T1pXeDBNVlQz?=
 =?utf-8?B?T1JHaWx5cCt2R3greWVzcTU4YjZPMVAzYXVQOElIOXo4ZlVDWUtzWlZwbklo?=
 =?utf-8?B?NFVUQWdXbWdzaEx6Nloxa1FUVWxzdGhNUHRmT0xoOERaVVhYcXE5d0pHVEZ2?=
 =?utf-8?B?VnlZTmdtMGNhZjJ5Z29EMVBoS2xsa0M5UTVDL2R1cGJWOXpRcU5sMDZyV2My?=
 =?utf-8?B?L3dRVkN5Z3JTdjhWVU9NQ2dPcUJLdGNoOTYvMkcyL29BS05Kd2R5bkU0Z0lQ?=
 =?utf-8?B?S0J0TEZGYkd2UEFpcHQvRjlvN3FBVURoTHRPdHpMOTNPaTlNQk9NQ2ZmY2sz?=
 =?utf-8?B?VFF6U2dmZ2p2NzlzQjZoVmJCc3NOSE52ZWlTczJ6TERBdVZLenNBVElnUGts?=
 =?utf-8?B?cWU5US8xMlVua3dKblNtaU56bXpGZ1AxWisxRFpOTmovWGtFSWs2cngxQy9H?=
 =?utf-8?B?dDFwNGxVZlNNQ3JEMGtRR0UrekZKaGJxTk44UGpJeVF3UlVuUTFlZ2lseCto?=
 =?utf-8?B?SGNhdzl4MEdWeTlOcVVXdW1JY01vN3Iwdy9xMWFlYmFuSFQxNVE5azN4VHBV?=
 =?utf-8?B?TytTWVgvZlA3QmdUdnpqTXowUUdFM0xjVEpleG1qbTUxQUE4N3QzZWRYdWll?=
 =?utf-8?B?VzdadVdZK2t4eDNpUHoyOVFORGVTTHRsdFlsbTliMlo1ZjQxQ0lrdXI0STJK?=
 =?utf-8?B?WTdTM08yTXYxa3RkZ1RlRHN2dDZtL2RIRVhkQWx2Qzl1MmxoTkpRWW9ZK1k5?=
 =?utf-8?B?blJYS0Y4YXlBQno1WmxyWk5KYmRORzlMb0tFTjg5eUFCczFCa3ZvWmwvMXhS?=
 =?utf-8?B?ZTNEa0N4WnZKeS95eW16UHR4ZTBtajQ0SnJYOTlBaUdWVFVwT3FrTDNYOGdQ?=
 =?utf-8?B?K2dkSW9MdnR5YlN6YmwzTkw2RE4vOXV5bkxkMFJnZXVTRDBTcXRJSkZIZUZD?=
 =?utf-8?B?WE9WeXZRUzBwc0FISitQRzZHaWZiSVZUNEVqc1oySi9kcjRqMUxrazRJTk95?=
 =?utf-8?B?RnkxN2xuVTYxb1dUeTROMXo0L2ZSVlN3aENsaTVHTDJ2cHlnTWQzUEdxUEVz?=
 =?utf-8?B?RVo2Lzl1akR2MUV1K3pMbHNIYW9GR1pBWEJmWGljb1paNnpZRWNQUFN1dXlp?=
 =?utf-8?B?Y1RLWXhuOFlVNko2OWovYzZYLzFhZU94OE5QMHdEL2lwQTBGeUc1TWZMczN1?=
 =?utf-8?Q?L7/KGY8INotbT9SXBI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-bafef.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB0217.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a71cfb9-51d8-4dba-9438-08dc99a436e0
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2024 08:02:55.3763
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MAZP287MB0471

DQoNCj4gT24gMSBKdWwgMjAyNCwgYXQgMToyM+KAr1BNLCBBZGl0eWEgR2FyZyA8Z2FyZ2FkaXR5
YTA4QGxpdmUuY29tPiB3cm90ZToNCj4gDQo+IO+7vw0KPiANCj4+PiBPbiAxIEp1bCAyMDI0LCBh
dCAxOjIx4oCvUE0sIEFyZCBCaWVzaGV1dmVsIDxhcmRiQGtlcm5lbC5vcmc+IHdyb3RlOg0KPj4+
IA0KPj4+IO+7v09uIE1vbiwgMSBKdWwgMjAyNCBhdCAwOTo0NCwgTHVrYXMgV3VubmVyIDxsdWth
c0B3dW5uZXIuZGU+IHdyb3RlOg0KPj4+IA0KPj4+PiBPbiBNb24sIEp1bCAwMSwgMjAyNCBhdCAw
OTozMDozNEFNICswMjAwLCBBcmQgQmllc2hldXZlbCB3cm90ZToNCj4+Pj4gQXNzdW1pbmcgdGhh
dCBJbnRlbCBNYWNzIGltcGxlbWVudCB0aGUgRUZJIFNNQklPUyBwcm90b2NvbCwgcmV1c2luZw0K
Pj4+PiB0aGUgZXhpc3RpbmcgcGllY2VzIHNob3VsZCBiZSByYXRoZXIgc3RyYWlnaHQtZm9yd2Fy
ZC4gU29tZXRoaW5nIGxpa2UNCj4+Pj4gdGhlIGJlbG93IHNob3VsZCB3b3JrIGluIHRoYXQgY2Fz
ZSAod2hpdGVzcGFjZSBkYW1hZ2UgY291cnRlc3kgb2YNCj4+Pj4gZ21haWwpDQo+Pj4+IA0KPj4+
PiBOb3RlIHRoYXQgdGhlIHNtYmlvcy5jICBsaWJzdHViIHNvdXJjZSBmaWxlIG5lZWRzIHNvbWUg
Y2hhbmdlcyB0bw0KPj4+PiBidWlsZCBjb3JyZWN0bHkgZm9yIHg4NiB3aXRoIENPTkZJR19FRklf
TUlYRUQ9eSwgYnV0IEkgY2FuIHRha2UgY2FyZQ0KPj4+PiBvZiB0aGF0Lg0KPj4+IA0KPj4+IE9y
bGFuZG8sIEFkaXR5YSwgY291bGQgeW91IHRlc3QgQXJkJ3MgcGF0Y2ggd2l0aCBDT05GSUdfRUZJ
X01JWEVEPW4/DQo+Pj4gDQo+PiANCj4+IFllcywgcGxlYXNlIHRlc3Qgc28gd2UgY2FuIGNoZWNr
IHdoZXRoZXIgSW50ZWwgTWFjcyBleHBvc2UgdGhpcw0KPj4gcHJvdG9jb2wgaW4gdGhlIGZpcnN0
IHBsYWNlLg0KPiANCj4gU3VyZQ0KDQpJSVJDLCB0MiBtYWNzIGRvIG5vdCBzdXBwb3J0IFNNQklP
UywgYnV0IEknbGwgdGVzdCB0aGlzIGFueXdheXMu

