Return-Path: <linux-efi+bounces-1494-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9523293C28C
	for <lists+linux-efi@lfdr.de>; Thu, 25 Jul 2024 14:59:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B917A1C20E88
	for <lists+linux-efi@lfdr.de>; Thu, 25 Jul 2024 12:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CAF319AD7D;
	Thu, 25 Jul 2024 12:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="t7Vctf4t"
X-Original-To: linux-efi@vger.kernel.org
Received: from IND01-MAX-obe.outbound.protection.outlook.com (mail-maxind01olkn2026.outbound.protection.outlook.com [40.92.102.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3989D19AD56;
	Thu, 25 Jul 2024 12:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.102.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721912349; cv=fail; b=lY/RvZkYdeVAef6v4Q3P0fj2m0/XsgaOnDPk1eoz/5uy9bz9AB7z9DM8cjwcmDYiHaH/tQdwHKNrS4RzNvDAxCySWjg7rQPXJYpzwQ93bkcBIcZJ4Bv2upj505y5WFNz1lhZJF/2AAhp6MttvB7EP6TunumHZ1hSQFKp6IJ2EDQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721912349; c=relaxed/simple;
	bh=6KyepsanqFUstc++bUcPHtBs4Ebw3PlVVJeduZxIS6Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Aq6d54kGpmdyDQJYfC9nP0kdRKpiyR99XwNFl32Cmv2KtLcYu6rZLipgZyRl5FoPCvza9puHKleg9+uHNh2UZXgyn8QRDpLPsx6DD3ffc2+p7Gih7XaRU8e+19oll+RFb8PCZ6m1rc5vhEiMkLE9cSIKceh1p94XZWKWcAOM5kE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=t7Vctf4t; arc=fail smtp.client-ip=40.92.102.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UbTFxzXS8J5XX0w91f+w2GOG1id2B6bfZAkjRpsDUDqGkjcZLfitx5PZJ0evYgEORPJHebVk7dElTKBZ5unXGng338kK+10zHgS1wmURD+2sAJMGtqmnpaPZOtXSE55oaTVwmT9A75U1Ax9+OMpqr0g4jNFECAPv5k6J9m03YmDbpxGyjckoFwYddMHOJKjFZ+tbR6f4AALU+D/h+OU+7nfZc2FRGOUInXkYGXFeHN6wffCbvCmnBDdS/Hffrl177IURwRsCczvxxTKDXE2QSexLmEe39AdupCQeoQ06MS382kDwmHHqvuotnDgL/kgLrJGoBb7r6u524QI8A9clXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6KyepsanqFUstc++bUcPHtBs4Ebw3PlVVJeduZxIS6Q=;
 b=YaSK75nhtJdmB9leTqZtOLpmj3ofbBfOogcx44O+VdmlogcBvJd0HgdF6XNz69ZTbqqv8GQSA5v65GOUp51SxHJma5QZd4ZArGfEvM4hzvOL3ZbUZIQKVCg8ixorvk1O1AHkCXv0rSS7UiIaqfhnHIN9OpXwguWH2wgFYo0Pszq3vBku833e2bQ2ipiyfdgvelLI99C7ubBoK8AcMWjleOkegZF9gQZjMmv9ksWi2RnfoNwzy9idz8uox8qcuDd7FNWBM0pr0uXaYeG5xmTi/n58Hstzcmwf1ZDx7ieuiU7ea4dTzXvExqvmcTOeQKgg3mOT0gEmdhYfBG6fDitqZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6KyepsanqFUstc++bUcPHtBs4Ebw3PlVVJeduZxIS6Q=;
 b=t7Vctf4t2aFOSV7oYDukOQajv1UVdeQq62ivoyspJ9Sdxy2vUUC9MoqsQZCFdGvvXdfqBHrrBMnpqcU2qdMqAJx7slQnmqwpLT1acPruKA9XuIskAG4+mwMf/oxNmV+beAOmSx74PU0TDXg2uWw2YBYHhRrYGov0CjoztCVj2kK9cA7WvHxFQfYi5QDmLitob4uSxNhAujCzqHwj9VkHf5gF+HVpmm6xtB05DCAIa2722Sjx04v9WU04vDfUbordZLSfzktb3PW2hXSTjpnd8xxMiif6k0h2XZYxbcp2uNJMezb9OyOZE0tqtJw+FQ/TfCX1QbSRP25QrUFwpp0U8w==
Received: from MA0P287MB0217.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:b3::9) by
 PN2P287MB0982.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:133::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7784.28; Thu, 25 Jul 2024 12:59:03 +0000
Received: from MA0P287MB0217.INDP287.PROD.OUTLOOK.COM
 ([fe80::98d2:3610:b33c:435a]) by MA0P287MB0217.INDP287.PROD.OUTLOOK.COM
 ([fe80::98d2:3610:b33c:435a%4]) with mapi id 15.20.7784.017; Thu, 25 Jul 2024
 12:59:03 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Ard Biesheuvel <ardb@kernel.org>
CC: Lukas Wunner <lukas@wunner.de>, "linux-efi@vger.kernel.org"
	<linux-efi@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>, Kerem
 Karabay <kekrby@gmail.com>, Orlando Chamberlain <orlandoch.dev@gmail.com>,
	"sharpenedblade@proton.me" <sharpenedblade@proton.me>
Subject: Re: [PATCH v3 0/2] efi/x86: Call set_os() protocol on dual GPU Macs
Thread-Topic: [PATCH v3 0/2] efi/x86: Call set_os() protocol on dual GPU Macs
Thread-Index:
 AQHay8BxbD/3780MxUWT4The9rzhebHiRiV0gBjw9fOAACgFAIAJQwrwgAGLugCAAAc4MYAAAVwAgAFSOACAAASelA==
Date: Thu, 25 Jul 2024 12:58:57 +0000
Message-ID:
 <MA0P287MB0217EBE3FCC38F26736A82BFB8AB2@MA0P287MB0217.INDP287.PROD.OUTLOOK.COM>
References: <20240701140940.2340297-4-ardb+git@google.com>
 <MA0P287MB0217C0F7E0B9F6FE8CA47BE8B8D32@MA0P287MB0217.INDP287.PROD.OUTLOOK.COM>
 <MA0P287MB0217E3B4810704C504F13F2CB8A32@MA0P287MB0217.INDP287.PROD.OUTLOOK.COM>
 <ZpgUVjjj3naBGtfO@wunner.de>
 <MA0P287MB02178F503AA69E1F570E9753B8A92@MA0P287MB0217.INDP287.PROD.OUTLOOK.COM>
 <ZqElRH38f_XV3fKK@wunner.de>
 <MA0P287MB021789D73CAD62C16BCF0306B8AA2@MA0P287MB0217.INDP287.PROD.OUTLOOK.COM>
 <ZqEsdkVvwsq-CgeB@wunner.de>
 <CAMj1kXFRbncyRRxMKAbZDzZDFNSzm3Xq0CU918iXiPEZfkTmYA@mail.gmail.com>
In-Reply-To:
 <CAMj1kXFRbncyRRxMKAbZDzZDFNSzm3Xq0CU918iXiPEZfkTmYA@mail.gmail.com>
Accept-Language: en-IN, en-US
Content-Language: en-IN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:
 [AwE2QAZYsRnn3tlwvZVPZjdfsiFntyy8HG66Mshh/w9ZYqj9chLa3Zkr4sDLEwpLOuYfnQpNlsE=]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MA0P287MB0217:EE_|PN2P287MB0982:EE_
x-ms-office365-filtering-correlation-id: b36ffb85-8cd9-44e4-eb25-08dcaca98be6
x-microsoft-antispam:
 BCL:0;ARA:14566002|19110799003|461199028|8060799006|440099028|3412199025|102099032;
x-microsoft-antispam-message-info:
 6BokFQ2YmCON86aL3JvTLNmKmFUfL5EmACZC8VfqSfLVBNZZZPENUxjIrzC1uth0s3GD7e6aiJaahQNKEDGqTFLXeNFAhmZ+rRBh9IAx03AA+ivWuKo15w2Pn1+g3C3d4S8UkWHl7f84xEcKqOCxLR+EcY99QbfyOAPel7NACdA+Xkfdv2tQ6sxDLBrJbgxgs3TQPlWZqSAtndrp2duF4ev1hZKZVoHF14XQOUXhLqTXI+sXvyJEfAP2ivJeAyPCy7KdCUEYy9MbknABibu+EnS1QOktn96ZHjsJhkNOy27DRV4oTWQ4uvON14WJcjZrR4QvvURGdjYP6JTvx67OhBGmKe+09RblzQ/WUYYOEnZQLCxdpd+pRRfwNL6cgCgDiwPmLb9hQ9jMr5Q+rmfYjUZAXsimU736X0NPCGAdjNAmUAjHWlCaXsV2cKOcKF7v7TdkWJ1kkbxdSTDaMLRglti7bxo+eacnd+SnFTdN/rUvVg5DyEfC5nSbkxAPmo7ILdDmQUHYe4idrf419wVmMNpNOBWHIQLGAJ+7pneBJNQzofpf+Cbb9nxYqFqZYVO2y80r14DesNjZ6ZX1bK+/uIpBCsHP0B9NnuUQ8AhFLI2NW7+7gidxegA7F4ZSjigKZTO67ChW+HzO0WYDmnaWNA==
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VVB3SHBmLzBVWDV0dVZaRW5HNmdsMm1SdGlCOTBha2xTajdTMVN5VVhnSnJR?=
 =?utf-8?B?aTFRZVpxejRreWVGV3BFSmRvdlpzSEcxVm9SVTNKRHQ5U2xzREVHT3BUcjNK?=
 =?utf-8?B?V0NqSDVWWElRNXJyWWVEOVd3OVFicERJQkRkNTczOGd1ejczMk44cnkxMldl?=
 =?utf-8?B?VmwwYWdLZjZaY01SbitZaHlRU0lyZ0VTZFhlVjlONU1xVUNwWU5TSkdZbzRL?=
 =?utf-8?B?dVV4UnYxUG9UMGNBN1IyZjNnRU9Gc0pFRXpsZGpkNHlqb0FwazVpejBtMHpJ?=
 =?utf-8?B?UnozdDBDM1NxeUJTSmQyVUczbjk1ZzRmaGE1b1plcFo5Ly80ZUxkbmxab3Rv?=
 =?utf-8?B?MWhEbjRFWndiOFE2MnBhVzgwa2hOMlNIZjRjcGlzb2MwUzBwWDhzTy8yYzRX?=
 =?utf-8?B?cXRsQUhrcUdUditjN1g4T284aElXdk52NjJqMmRZNHlQb1ZLa2VpQ2xkaU13?=
 =?utf-8?B?c3BnVzNnSHFNc0puZmZ3b1RIN0xVcGQ4VmlFSHpMdHY4SVIzQm9HWm5jcVdK?=
 =?utf-8?B?ZEpGU051UUgyd3ZFWmtCTGpqclR0cVQwbHJ5V3lOR3I4YVZQV2Jha2ZKb2I0?=
 =?utf-8?B?UnNoSkQ4TFM3TndCVEs1U2dLcEhWQlFzcHBPNkxYU3llZTUrbnVNdW95Q25G?=
 =?utf-8?B?UUdoQ0lOMHJ2d2VuNFZDcmxONzhPZjdlK1podnQ4VGlqckcwRlRCRUJXUzJB?=
 =?utf-8?B?MHYzQkVvdDRScFVHTSt6dkx6QzJJekV4ci9tbTVMbU5mQk5VeWpxS2lpRTFt?=
 =?utf-8?B?aDRSNDRaU0l2V3dlUmVjdUVOQzIxM00wMlg3cVMwZUhBbmxEdXQ5V2FzaVE0?=
 =?utf-8?B?SklEbFZXSUlxd1QvbTcwTzJyQmVxNXZQU2lER0R3UmdKc1RJZVFVR0Vqa1E0?=
 =?utf-8?B?dUJ1am9KSysvQlFjZEIrcWRNUEFOaHc2MVpuMGMyQnFYZlFKMWhGVGhSQkhu?=
 =?utf-8?B?Z25hT0pFZzRvQmxLc01ZdG5maVA0dTNmRWYyMlZsbWlqNHJLTWdvZmVCTjZI?=
 =?utf-8?B?dks2aVZhWDFwNmNQeXVLUnJiMkFPb3pyV1MrRHdxREFEQ0ZNWnhKZ2gzaWFB?=
 =?utf-8?B?Zlg1QkRpRUhYb2tWdi9jbUc4TTMrZ052ZmhvUzU3ZGhBRUVtOENkeXNVK2l6?=
 =?utf-8?B?RHVkay9LRWpqVlBkQ3dVWVMwbytvNFZra3Rsb2ZzdlU4a1dGUTk0K2tteDNt?=
 =?utf-8?B?WENlVnp2WUZ3K3p4QktsRXNZeTByaGhUQmdCTW1aT2xYaHJFWUI1YjRiL0d6?=
 =?utf-8?B?enI0emVuR1RKTy9hWlNCanNTU05DNjJLLytwc1dYdlBJdE1qaS9MZy9RakIx?=
 =?utf-8?B?Sk42Nk5XVUJVYzFhM3hFMUpYL0pkZ0lHUFNMLzgxQ3kvU21icDlWSG0wTjUw?=
 =?utf-8?B?ZXBiODdHZjlnK0ZYbTRvTTRkQnB6LzI0T3JmK3M0RElqUjlpRU01RmcyWkFl?=
 =?utf-8?B?UTV1TkhreWlEd1VJcitHUVpFS1owQWNWZ1J1RlJzeGUyTytlM3MxY1VmMnhO?=
 =?utf-8?B?RWtwVlMyQWNvOXJiSHRsTjRQVi9YY21Ta3ovV1V0KzRLczdCOE1iOThhUkxm?=
 =?utf-8?B?WTZJTGs5blRZdVZTVFFUUERrYkZDdGFpUE1TelFyV2hJTUhEN1luUGhhWlBR?=
 =?utf-8?B?WFFMTnhUUTJaSkdvWTBHYVhGNTVESytkRjQ3dXQrQmJvbldMM3U1eUVvd3E3?=
 =?utf-8?B?L2VZaGpnSG00cGE1Z0ViOE11VGpWOU54eWVuS3NrMEJISG5vK3gycHlXdUpG?=
 =?utf-8?Q?GOaPfXyTGNw+Bt6UTc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-24072.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB0217.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: b36ffb85-8cd9-44e4-eb25-08dcaca98be6
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2024 12:58:57.6134
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2P287MB0982

DQoNCj4gT24gMjUgSnVsIDIwMjQsIGF0IDY6MTLigK9QTSwgQXJkIEJpZXNoZXV2ZWwgPGFyZGJA
a2VybmVsLm9yZz4gd3JvdGU6DQo+IA0KPiDvu79PbiBXZWQsIDI0IEp1bCAyMDI0IGF0IDE4OjMx
LCBMdWthcyBXdW5uZXIgPGx1a2FzQHd1bm5lci5kZT4gd3JvdGU6DQo+PiANCj4+IE9uIFdlZCwg
SnVsIDI0LCAyMDI0IGF0IDA0OjI2OjU4UE0gKzAwMDAsIEFkaXR5YSBHYXJnIHdyb3RlOg0KPj4+
Pj4gT24gMjQgSnVsIDIwMjQsIGF0IDk6MzEgUE0sIEx1a2FzIFd1bm5lciA8bHVrYXNAd3VubmVy
LmRlPiB3cm90ZToNCj4+Pj4+IEkgbm90ZSB0aGF0IG9uIHg4NiwgdGhlIGVmaXN0dWIgd2Fsa3Mg
b3ZlciBhbGwgUENJIGRldmljZXMgaW4gdGhlIHN5c3RlbQ0KPj4+Pj4gKHNlZSBzZXR1cF9lZmlf
cGNpKCkgaW4gZHJpdmVycy9maXJtd2FyZS9lZmkvbGlic3R1Yi94ODYtc3R1Yi5jKSBhbmQNCj4+
Pj4+IHJldHJpZXZlcyB0aGUgRGV2aWNlIElEIGFuZCBWZW5kb3IgSUQuICBXZSBjb3VsZCBhZGRp
dGlvbmFsbHkgcmV0cmlldmUNCj4+Pj4+IHRoZSBDbGFzcyBDb2RlIGFuZCBjb3VudCB0aGUgbnVt
YmVyIG9mIEdQVXMgaW4gdGhlIHN5c3RlbSBieSBjaGVja2luZw0KPj4+Pj4gd2hldGhlciB0aGUg
Q2xhc3MgQ29kZSBtYXRjaGVzIFBDSV9CQVNFX0NMQVNTX0RJU1BMQVkuICBJZiB0aGVyZSdzDQo+
Pj4+PiBhdCBsZWFzdCAyIEdQVXMgaW4gdGhlIHN5c3RlbSwgaW52b2tlIGFwcGxlX3NldF9vcy4N
Cj4+PiANCj4+PiBUaGlzIGFsc28gbG9va3MgbGlrZSBhIGdvb2QgaWRlYSwgYnV0IEknbSBub3Qg
d2VsbCBhd2FyZSBvZiB0aGUgcGNpDQo+Pj4gcXVpcmtzIGluIHRoZSBMaW51eCBrZXJuZWwuIFNv
LCB3b3VsZCBjb25zaWRlciBpdCBhIGJ1ZyByZXBvcnQgZm9yDQo+Pj4gdGhlIG1haW50YWluZXJz
IHRvIGZpeC4NCj4+IA0KPj4gVGhpcyBpcyBub3QgYSBQQ0kgcXVpcmsgaW4gdGhlIGtlcm5lbC4g
IFRoZSBlZmlzdHViIGlzIGEgc2VwYXJhdGUNCj4+IHByb2dyYW0uICBJJ20gc2F5aW5nIHRoYXQg
dGhlIGVmaXN0dWIgYWxyZWFkeSB3YWxrcyBvdmVyIGFsbCBQQ0kgZGV2aWNlcywNCj4+IGl0IHdv
dWxkIGJlIHRyaXZpYWwgdG8gaG9vayBpbnRvIHRoaXMgdG8gY291bnQgR1BVcywgcmVjb2duaXpl
IHRoZSBUMg0KPj4gZGV2aWNlIG9yIGRvIHNvbWV0aGluZyBlbHNlIGVudGlyZWx5Lg0KPj4gDQo+
IA0KPiBUaGFua3MgZm9yIHRoZSBhbmFseXNpcywgYW5kIGZvciB0aGUgc3VnZ2VzdGlvbnMuDQo+
IA0KPiBJIHdvdWxkbid0IG9iamVjdCB0byBjaGFuZ2VzIHRvIHRoZSBFRkkgc3R1YiB0aGF0IGlt
cGxlbWVudCBzb21ldGhpbmcNCj4gYWxvbmcgdGhlc2UgbGluZXMsIGFsdGhvdWdoIEknZCBsaWtl
IHRvIHVuZGVyc3RhbmQgYSBiaXQgYmV0dGVyIHdoYXQNCj4gdGhlIGFjdHVhbCBpc3N1ZSBpcy4N
Cj4gDQo+IElmIFBDSSByZXNvdXJjZSBhbGxvY2F0aW9uIGlzIHRoZSBjdWxwcml0IGhlcmUsIHdv
dWxkbid0IGl0IGJlIGJldHRlcg0KPiB0byBmb3JjZSBMaW51eCB0byByZWFsbG9jYXRlIHRob3Nl
IGZyb20gc2NyYXRjaD8gSUlSQyB0aGVyZSBpcyBhbHJlYWR5DQo+IGEgY29tbWFuZCBsaW5lIG9w
dGlvbiBmb3IgdGhpcy4NCg0KSSBndWVzcyB5b3UgYXJlIHRhbGtpbmcgYWJvdXQgJ3BjaT1yZWFs
bG9jJy4gQWRkaW5nIHRoaXMgZG9lc24ndCBmaXggdGhlIGlzc3VlLg==

