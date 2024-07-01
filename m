Return-Path: <linux-efi+bounces-1344-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8112E91D97B
	for <lists+linux-efi@lfdr.de>; Mon,  1 Jul 2024 09:53:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3F9F1C21DD8
	for <lists+linux-efi@lfdr.de>; Mon,  1 Jul 2024 07:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9BA67D08D;
	Mon,  1 Jul 2024 07:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="OwFQU5DA"
X-Original-To: linux-efi@vger.kernel.org
Received: from IND01-MAX-obe.outbound.protection.outlook.com (mail-maxind01olkn2071.outbound.protection.outlook.com [40.92.102.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9562C144;
	Mon,  1 Jul 2024 07:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.102.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719820422; cv=fail; b=mN09hZ2CIVnV1BBgkrEGmM73tlmA0aT6BFaLbMdMjbb5D55IGxfwieuSyfKy858YXvYi86hQv6EOmWkH7N3SzG9N4Mg+GmdhECr4QEvs6Fq/oJIfWjQ4Uyx6jCbEhupYjQm+uxKacT1KuNslPv8Gfm9Mtq3830/HVbrUNgSH7CE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719820422; c=relaxed/simple;
	bh=5kJcnWK0CPl+Xr/VRu5P9z5pEKIdtIijoP3CzDl8xgs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ILOSAy8GHQ5VT4K2ypVr4sxP+zPsXrZMLKWd56EDYdJ8mOh4rzmgra5QTxoCCQsnJu+4z3fJelPCLQYa4wxBs50kZI2dRNp4KlhOxQLQ9wNQtxRuLVDiNUh2e9xZqmD5J5d3Deshrr4CFKdY+wA1ErAKLCdsZitGSpewWcVFa4U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=OwFQU5DA; arc=fail smtp.client-ip=40.92.102.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vp99o7VVTIXg7rIv/bL2SZRWf/aF6rojYM6dtfIpdNpz3FI8c9lyxwpVI7WT3rOLIXt2JXx/1fHWFz0spaGZRB6VbKoaxtwzqfVKtDlNlDSrnOEWb3sHqB8qxPTSEmaqT/UYTD6GaQZIBzOXeaL0J7rWz5t9yvnzbXaIZz2/LcoEcfySOiDw3ygXME/DPBXkT54lfg2uJby/ivIUn4JPeFG8MZNp+jowwd3eu8Ty5MYB2VKrLwwwqbaj+3/bZALn4BI64d6mY9CO32oisybGhfcSYpoTEWKGvsBBdh8uvFzq/Zxi494otBU26IvHEWzQwYiMp1HwycUuZcJgCe2C7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5kJcnWK0CPl+Xr/VRu5P9z5pEKIdtIijoP3CzDl8xgs=;
 b=BAIRL1KKAGoLOKJYpJgy1kafXDLi09anUShxICQzfSI0FzS1fNLgOrO3qZIkcyAvupZJhj+O+7xcdznYcf+ge5gD/nhv/hl1Yl0BRScVI8PTntyxjf6OphYk01eQJZUbKGEY01oUuiBo+43AggT1zAcexNZbN1KeFPvvWHE9/eHw94AtmmgyClcbA1EvkQ7WPTdjbEuzkc6II5P/cHaM5U7U3Wfkm20pVUHOW0/gXDEljfZgjgHQV4i+4Q4LHyQ1QfFR3aeuQH6q9Na5qarMqa0t8wOzl+yf0QemiGLNIDEzHnqjmn/x4/Wwws5hbAAfOS8D5OCvyHRsM8ekbTJCjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5kJcnWK0CPl+Xr/VRu5P9z5pEKIdtIijoP3CzDl8xgs=;
 b=OwFQU5DAcVNF8z1ZeYX/wNv72rMevFpEdvVdFVsxBMXIm3MHQwzL3kFJocg9Wqrf/E+o/QFMr2EKr8tg5hs+Kz1HdeTXXf3RVGHfricYw8PrVcZiyfPNn7eiYGpdlFqUJa2UeUfCWBS5UHRYI65OSp9v1J6+bn7s+xuqyYffRh4qgepkocTogNGRYsBTHPbPbF2M3fe1jtdOM+yOj26p5AjzNFvd75crHbO+wP/3uG550z5+uPX2OyAjXrM3wax1RCBiUVRiP7MUF9hTg0hP7EB04qjsyI/sNRBkp5taEM1iSVQhAvoj4puXpp15p9x3UkYFy32bY6ngM0dXuL2Z2w==
Received: from MA0P287MB0217.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:b3::9) by
 PN2P287MB0302.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:ef::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7719.32; Mon, 1 Jul 2024 07:53:35 +0000
Received: from MA0P287MB0217.INDP287.PROD.OUTLOOK.COM
 ([fe80::98d2:3610:b33c:435a]) by MA0P287MB0217.INDP287.PROD.OUTLOOK.COM
 ([fe80::98d2:3610:b33c:435a%7]) with mapi id 15.20.7719.029; Mon, 1 Jul 2024
 07:53:35 +0000
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
 AQHayyMw+x8Tv3BlDUuYLD8zHzW0zLHhWosAgAABBwCAAANoAIAAAXYAgAAMlICAAA3UAIAAA9mAgAAB9YCAAACgEQ==
Date: Mon, 1 Jul 2024 07:53:35 +0000
Message-ID:
 <MA0P287MB0217F69CBAB2D5776D4AFA43B8D32@MA0P287MB0217.INDP287.PROD.OUTLOOK.COM>
References: <75C90B50-9AB9-4F0A-B2CD-43427354D15C@live.com>
 <ZoJAAifMqIDXdniv@wunner.de>
 <CAMj1kXH3fvS259Y1mfYcKQbM2mUYbSfuf2ZiMXfFhjq-rzn5UA@mail.gmail.com>
 <ZoJDuunseVIDua-m@wunner.de>
 <CAMj1kXFKBsAXDLxinqiszH=6hEOjbJQL-nFgBsBceta4rUCN-w@mail.gmail.com>
 <ZoJPgSlZJ3ZlU2zL@wunner.de>
 <CAMj1kXHR+mCR5eibj23S26-PN6yLPD1uf9+H2fEEDhNWOh6TjA@mail.gmail.com>
 <ZoJeVWMU8yg4CRLl@wunner.de>
 <CAMj1kXFRNrmyAtVaqHr+RWQ22+++u70eJ__brLjmJa0ocyc0Bw@mail.gmail.com>
In-Reply-To:
 <CAMj1kXFRNrmyAtVaqHr+RWQ22+++u70eJ__brLjmJa0ocyc0Bw@mail.gmail.com>
Accept-Language: en-IN, en-US
Content-Language: en-IN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:
 [97LsZwUZa/A5PyRbG0ivr7sJSapniSbTIM9yxghp5oZwolqZ7Ezls9lzXR2A69pYsSIp7BE05Pg=]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MA0P287MB0217:EE_|PN2P287MB0302:EE_
x-ms-office365-filtering-correlation-id: e117defe-eba6-485c-e4ef-08dc99a2e917
x-microsoft-antispam:
 BCL:0;ARA:14566002|8060799006|461199028|102099032|440099028|3412199025;
x-microsoft-antispam-message-info:
 K4ndPMDOv0Zch1shJkwFMTbBEZ7gPFOjBZ2yPacXw7TyJoeZQdx7EJCNRYYR5ivtFfB7mjitE94gg4o00OwgY81Jpar8uZcQyBaCNW2jqS+M0xE2aY+V4itBWxIftT6C/HuUKcwIDdVEUIDHPKRReY1w3acypvJ1eJ6xgSBDDSC2XPOGA5BDiSPqiG6Cn0ogFvRk23LPcyd8Krgthc8MN6nOMzcyDOc+wxwv2xFX1m+vBuVNAu/im44g2uQfFlji3/aI/biYABim8aNUsrTOxSoWHUFSnF6FjLcizzQok3UhPeRA7FOZyTIrJaDV1N5GYsv3AKUvX19vs6xZ+Xjg1u87z70lo1eFE7L8LqYLlw4Jr73BlyTGoZFIuTwigLW0ybJywNVFnyD2zpHAWc2W9HVQVocs9SSzdMjxwbOvHAj8eTIcSM8xH9qmjJiCHS3eGLICMSOoigbcV4zGcZ8RMnKAc77pVOjjCSu+kwHqp9A/eBMD89edKWqNk4Zd9GTK2D7vaAOw/ob/frqeVvgaBr3rzgIIIOw7k0x9u782GgiIp/4svqR27VG8XcKUq9Nxm+0f6HnvaGc+1SxHlT1IMrPXGXvcpUOD8J4WzV5MCRzcSZrcsvEFAbEai73gb4HB
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Mk1iZDVQVU8xZWh5TklrM2RCa216aXpmeThxVWpWVy82Z3QzT0xFcG1UOGo4?=
 =?utf-8?B?Y0k1VzFjUEtMK3p1WWxSYnAyS1hXMnVSNlJFaERZbllhLzZpTDlMRis2R2V0?=
 =?utf-8?B?dUFCR2tVSk8wbW5GY1FOM2dtYnhXai9QdXJsWTRlOE1PVExwRktLVmpBWmZw?=
 =?utf-8?B?R3lCQ2ZnVFR6T1lLaEp6MUs2d1RuMndQRUFvVitucjdTdEJhVGdtT0daVVox?=
 =?utf-8?B?SkxqZHUycVFKa3VTN0FnZVJ2aWgxVkNkaGhTTlhrN3N2QTlMODc0ODlpdXlS?=
 =?utf-8?B?endidytsbW9PR1g3UGsyRmdzMVNwMm9SS1pkTWwyQ09wV0VieGJqTVdKOXNl?=
 =?utf-8?B?cU1FYUp0M25OcnBCbFBPT1NpZEs5U3kyQ0Q3c3pDdzBQSFdaS3V6WTFhSWxp?=
 =?utf-8?B?cVozbGxFLzArdHlZcHRBWE5MSkxvaXdMU0ZjQmZOdWlYTm9VQlROZ3B4ZGhZ?=
 =?utf-8?B?Mnk0aVZIcGRRVk1YYytwb1ZYUDF1elRJaDhPUnNyek8yN2txTUhRSUsxazJC?=
 =?utf-8?B?ajhRYk5NdlVMRmx0dCszWFRTSWFKWU5XbTFzRkZiZ2pCMll2UStOR2NLTkU4?=
 =?utf-8?B?RWRxUmtMQkwvZ2ZlYU1CWGxoVjVIdWc5VE91ZnpFZUJ0YlFvZlphcHozSTl3?=
 =?utf-8?B?ZVhub285YWpoN3hmQXVvb0pXd21WKzhrS0RRd2l0UzdTYzltUVhKWC9XcDF1?=
 =?utf-8?B?MnVXWlduQTUxUC9nc0NkRENWdU5MRUVmM0lZY29IaElDeWhMN2dBa2FZc3Qr?=
 =?utf-8?B?UHhQTDV5ZWZaWmxXRkt5bUFhZUZ3SHJSc2daLzA0Vmo3TUZ4U1ZoVzhVRVRp?=
 =?utf-8?B?WHFNMnhwUi94bnNBNS9uNk1VS3FNTVNieGxWdTAxVzg3dFF2YitRMXVqMnZJ?=
 =?utf-8?B?aEtXckg4V1B2SUtQZ3daSExjMThacmdmeCs1Tjd4cW9LTlhxcm8ydllBKzZY?=
 =?utf-8?B?TDkyY1B2VGd6YVJ3cExSV3VxTHNHdzJINk9JTy84VldCMCt2UDJvRUlmRGJY?=
 =?utf-8?B?UE53NFhtc21nNmpYeVgyOEhwNUNzMFJuY01Hd2hFZlV4VkJCYWEzTWwwSzJx?=
 =?utf-8?B?WFFZaXNmNTZ0WUFTbGU0bjBTTC95NjlKM2NlRnR5RGNqZU0xc2twVFRyamRP?=
 =?utf-8?B?b1BGWUl4NmFkbWo3VVE2UlBtSEZLaUtHWDhXeW0yMzNuRkdiTzRHZlJRZ0hW?=
 =?utf-8?B?d0Vhdit4UzIzdXBDYmRjMll0U3Z6Ykd3UTRUYjZDN3NSRWlQY2J5ekVTK0xM?=
 =?utf-8?B?VmVMYzM1eWt6TSswSklPN2trTGNadjZjVi9BV1lMQk5EWnp1U3Y4SEhDY0o2?=
 =?utf-8?B?NXJrRmc5MWc1cDVVQ3VzY0tXc0dyemloaUR0R01FTEF2NmVxMlEwOTQ1d1Fl?=
 =?utf-8?B?UDdBMjVkeWM5U0tmQjg2SGZDL0Z2cXBlMnJiNU40ZnIrVkQvejBsdTh5MkMr?=
 =?utf-8?B?WlpleWxiK0ZFUjNyZ2hydVljdlcyaHMvL2JmK1V2NFNLZHdCdUcraGk5cTZt?=
 =?utf-8?B?cnY1cUZqUGIybWhlUnU1dDZud1pXTDcxZTV3MWlIZUFUSFJOOEhxaG1mVWdZ?=
 =?utf-8?B?SW4vWndaU2FBRGNabEFFNzBYcFp4bktpZDJJQlN0WVV1K2ZvNTBHeC9EeXFw?=
 =?utf-8?B?bFNSZUdoZzdwUHpDMGM2VWF1b01iaW5SWUlYMVdBVFQ1UU84Mjd2Qm8rck5J?=
 =?utf-8?B?eEdsaFZ1RkMxZlFjVnNRckRybUl6eE95NTJyRmt3Tk5udEhHV2RneEViUUZD?=
 =?utf-8?Q?yFCACJegsdAxYDKR3k=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e117defe-eba6-485c-e4ef-08dc99a2e917
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2024 07:53:35.3853
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2P287MB0302

DQoNCj4gT24gMSBKdWwgMjAyNCwgYXQgMToyMeKAr1BNLCBBcmQgQmllc2hldXZlbCA8YXJkYkBr
ZXJuZWwub3JnPiB3cm90ZToNCj4gDQo+IO+7v09uIE1vbiwgMSBKdWwgMjAyNCBhdCAwOTo0NCwg
THVrYXMgV3VubmVyIDxsdWthc0B3dW5uZXIuZGU+IHdyb3RlOg0KPj4gDQo+Pj4gT24gTW9uLCBK
dWwgMDEsIDIwMjQgYXQgMDk6MzA6MzRBTSArMDIwMCwgQXJkIEJpZXNoZXV2ZWwgd3JvdGU6DQo+
Pj4gQXNzdW1pbmcgdGhhdCBJbnRlbCBNYWNzIGltcGxlbWVudCB0aGUgRUZJIFNNQklPUyBwcm90
b2NvbCwgcmV1c2luZw0KPj4+IHRoZSBleGlzdGluZyBwaWVjZXMgc2hvdWxkIGJlIHJhdGhlciBz
dHJhaWdodC1mb3J3YXJkLiBTb21ldGhpbmcgbGlrZQ0KPj4+IHRoZSBiZWxvdyBzaG91bGQgd29y
ayBpbiB0aGF0IGNhc2UgKHdoaXRlc3BhY2UgZGFtYWdlIGNvdXJ0ZXN5IG9mDQo+Pj4gZ21haWwp
DQo+Pj4gDQo+Pj4gTm90ZSB0aGF0IHRoZSBzbWJpb3MuYyAgbGlic3R1YiBzb3VyY2UgZmlsZSBu
ZWVkcyBzb21lIGNoYW5nZXMgdG8NCj4+PiBidWlsZCBjb3JyZWN0bHkgZm9yIHg4NiB3aXRoIENP
TkZJR19FRklfTUlYRUQ9eSwgYnV0IEkgY2FuIHRha2UgY2FyZQ0KPj4+IG9mIHRoYXQuDQo+PiAN
Cj4+IE9ybGFuZG8sIEFkaXR5YSwgY291bGQgeW91IHRlc3QgQXJkJ3MgcGF0Y2ggd2l0aCBDT05G
SUdfRUZJX01JWEVEPW4/DQo+PiANCj4gDQo+IFllcywgcGxlYXNlIHRlc3Qgc28gd2UgY2FuIGNo
ZWNrIHdoZXRoZXIgSW50ZWwgTWFjcyBleHBvc2UgdGhpcw0KPiBwcm90b2NvbCBpbiB0aGUgZmly
c3QgcGxhY2UuDQoNClN1cmUNCg0KPiANCj4gTm90ZSB0aGF0IHRoZSBmb2xsb3dpbmcgaHVuayBp
cyBuZWVkZWQgdG9vOg0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZmlybXdhcmUvZWZpL2xp
YnN0dWIvTWFrZWZpbGUNCj4gYi9kcml2ZXJzL2Zpcm13YXJlL2VmaS9saWJzdHViL01ha2VmaWxl
DQo+IGluZGV4IDA2ZjA0MjhhNzIzYy4uMWYzMmQ2Y2Y5OGQ2IDEwMDY0NA0KPiAtLS0gYS9kcml2
ZXJzL2Zpcm13YXJlL2VmaS9saWJzdHViL01ha2VmaWxlDQo+ICsrKyBiL2RyaXZlcnMvZmlybXdh
cmUvZWZpL2xpYnN0dWIvTWFrZWZpbGUNCj4gQEAgLTc3LDUgKzc3LDUgQEANCj4gbGliLSQoQ09O
RklHX0FSTSkgICAgICAgICAgICAgICs9IGFybTMyLXN0dWIubw0KPiBsaWItJChDT05GSUdfQVJN
NjQpICAgICAgICAgICAgKz0ga2FzbHIubyBhcm02NC5vIGFybTY0LXN0dWIubyBzbWJpb3Mubw0K
PiAtbGliLSQoQ09ORklHX1g4NikgICAgICAgICAgICAgICs9IHg4Ni1zdHViLm8NCj4gK2xpYi0k
KENPTkZJR19YODYpICAgICAgICAgICAgICArPSB4ODYtc3R1Yi5vIHNtYmlvcy5vDQo+IGxpYi0k
KENPTkZJR19YODZfNjQpICAgICAgICAgICArPSB4ODYtNWx2bC5vDQo+IGxpYi0kKENPTkZJR19S
SVNDVikgICAgICAgICAgICArPSBrYXNsci5vIHJpc2N2Lm8gcmlzY3Ytc3R1Yi5vDQo=

