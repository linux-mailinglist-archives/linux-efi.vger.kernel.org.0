Return-Path: <linux-efi+bounces-1485-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF7CA93B4F8
	for <lists+linux-efi@lfdr.de>; Wed, 24 Jul 2024 18:27:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85FAF281E3A
	for <lists+linux-efi@lfdr.de>; Wed, 24 Jul 2024 16:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6303C15B541;
	Wed, 24 Jul 2024 16:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="jQuscE/t"
X-Original-To: linux-efi@vger.kernel.org
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01olkn2096.outbound.protection.outlook.com [40.92.103.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DAEC15E5D4;
	Wed, 24 Jul 2024 16:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.103.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721838426; cv=fail; b=mlsMysJpDnajGA9FOkAMTqMQItsEzZ28V8YnKXLNaCs0xw+npYHl7XH3zGNJLdpUV4ye7m+vp8UCyDlaMC8iPal7ols2tYzTq6LIHC3t7Y9FZETFsZJg3jTSwhXPj0EHIKg+6/6d1ZcRkj9XFWD0CnNZiewYjEDKRZ97d6x0Io0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721838426; c=relaxed/simple;
	bh=+EWl5T6ES0etoGjy0RpDUJYZrgdtluPuxDFCTkl0r50=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=f1kcGFnAIAU4qafSdP1tauUtA/ZTP7PSXUl8CDVfcJJ3Qb61Np4+Bi1OAbanEisss0kR4NYUjtbjUnKshsIWARvifms/Kz6j8KD2oa/XikxvljhbpqbPi0vvS2y/gRijyJqx8m7Fc4LAvrpsE8teG0CkzMvHkYlV56wCirLC+Nk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=jQuscE/t; arc=fail smtp.client-ip=40.92.103.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sPt0FR4/Lm/z/LnZoyp2t/270HUX/pp2/ZqPn5DwrfY7Z7kEowo9Lc7Dg48FafLr0DEgxcBu5xfvn9ic8MeEvkOChhfUW7Nvv5dR4WgFS9jWV1j81HjeYjs6aBeuKmljwpytBRaiJ31dgCSPJDMTpl9vw+865ieQrPnHTgWCWMMIUVTG2xYM5y11hwkdnst75h2VebcjyeMg94B1px+6aaK9RkfYIA3ALb/Yn3M5fn+Yd0WOZ0cI8GMJ817XJLIT8Be0T6ee3jdEtMMlduvd+ik7s2Nw3VOlBWQOhbSsD6CrXF1vnotle1oYarf4/6ySlrXnp/iENIl1hW6NJxjjbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+EWl5T6ES0etoGjy0RpDUJYZrgdtluPuxDFCTkl0r50=;
 b=nXFdeaR1SUX56VOJqVufcZ2MJpQ8g5nv3EnO0zwjGi4vIu1CQe2KJ2X1Bte96FTTEjtto4jZ6IlJyW25Abl2rH3mzRYOOtPHNds/XdN7zfLf/GbyuedibYfJf1fBTAAoynoS9/uBN8e6I15j2awP7y39WB7OsoZMEEecOCOwcMRZsG5P+TgkDgf849U1EMWwZ/0uaVSQ3yau3KwclfIbbqF2S9Xyhe4LZdh4rrqg14rHtQ023yIsBdrzai7T4n8ieYaBILnwO9zL6get4y8ctKNmxKtfq425otu1wi2Cns3glc4DB/D7/ncN3Rt0zmzFtIP6l+OskH7l9TiTjzA1rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+EWl5T6ES0etoGjy0RpDUJYZrgdtluPuxDFCTkl0r50=;
 b=jQuscE/tJuO8eka4LrSkJ+s6qrMWhHVJunmHYnsrtdmWfBmyQN6lFeA4sSVSNzUdVc1Dpf5XjLWlDTOoL5XzLZmOmjNSIY1md7bpJhtBCYXcz3q1RKt1kM+vFJO+VseyJdWPPJ1fx1wt7f1v/jFpfBImU1hGqTAjibjmXQEoCYaPm74k2frmWprQvn6EM9gjbfbgbJcBdonSm1rR0o51PS2yZXTGYINDXs7guhpE8NlxrT+I6A0ofvrwXXSI/RsbERyo/TGmkLuAu2BvPSCPV0W/4WvwE4UdncLSV3FHlLEaf9SzQhlSKFzbr0nohI4Db9O28Uy3cQZHkTwU+9uwaA==
Received: from MA0P287MB0217.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:b3::9) by
 MA0P287MB0297.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:b3::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7784.20; Wed, 24 Jul 2024 16:26:59 +0000
Received: from MA0P287MB0217.INDP287.PROD.OUTLOOK.COM
 ([fe80::98d2:3610:b33c:435a]) by MA0P287MB0217.INDP287.PROD.OUTLOOK.COM
 ([fe80::98d2:3610:b33c:435a%4]) with mapi id 15.20.7784.017; Wed, 24 Jul 2024
 16:26:59 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Lukas Wunner <lukas@wunner.de>
CC: Ard Biesheuvel <ardb@kernel.org>, "linux-efi@vger.kernel.org"
	<linux-efi@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>, Kerem
 Karabay <kekrby@gmail.com>, Orlando Chamberlain <orlandoch.dev@gmail.com>,
	"sharpenedblade@proton.me" <sharpenedblade@proton.me>
Subject: Re: [PATCH v3 0/2] efi/x86: Call set_os() protocol on dual GPU Macs
Thread-Topic: [PATCH v3 0/2] efi/x86: Call set_os() protocol on dual GPU Macs
Thread-Index:
 AQHay8BxbD/3780MxUWT4The9rzhebHiRiV0gBjw9fOAACgFAIAJQwrwgAGLugCAAAc4MQ==
Date: Wed, 24 Jul 2024 16:26:58 +0000
Message-ID:
 <MA0P287MB021789D73CAD62C16BCF0306B8AA2@MA0P287MB0217.INDP287.PROD.OUTLOOK.COM>
References: <20240701140940.2340297-4-ardb+git@google.com>
 <MA0P287MB0217C0F7E0B9F6FE8CA47BE8B8D32@MA0P287MB0217.INDP287.PROD.OUTLOOK.COM>
 <MA0P287MB0217E3B4810704C504F13F2CB8A32@MA0P287MB0217.INDP287.PROD.OUTLOOK.COM>
 <ZpgUVjjj3naBGtfO@wunner.de>
 <MA0P287MB02178F503AA69E1F570E9753B8A92@MA0P287MB0217.INDP287.PROD.OUTLOOK.COM>
 <ZqElRH38f_XV3fKK@wunner.de>
In-Reply-To: <ZqElRH38f_XV3fKK@wunner.de>
Accept-Language: en-IN, en-US
Content-Language: en-IN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:
 [HOxyuzmniU8vTXCT0bVg12sECk7Ofbve/Gm9E4rHX/683nFJiPsAKE7FEVf/9vOBQCFXCgEZgJs=]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MA0P287MB0217:EE_|MA0P287MB0297:EE_
x-ms-office365-filtering-correlation-id: fbbfe47b-77f6-4f2f-cfbf-08dcabfd70e0
x-ms-exchange-slblob-mailprops:
 WaIXnCbdHrORrPiYp+O3K2PHowtbVet0Yo6ACtfBMzoCWqAr3+a7xMBuOQkbK45t+xG2WEBwMJAQzLp7WOkS84wgwW8Sr03e8arxYnbZVk3aZ8LuIcdQxZyeUQOQMxBEH14TgXx6zYrDcAXSQmD5wypT0JIOOrts2+cRc2XyVP0J+VQMavv2UrKgcIA4730CB9Ikp7Pc331hDBHdNJQn8L/lgSwmR9R+6a7UhA0axU8RCkodmbDgeL8DqKdMYRv+RDrMcafRD5fqQWpDNgYcwWQLgBlv6imH8yUovGwQlDkX2FB5uPg0+HZHsiPn63c+NtuU3perXJKZgLIUBuxsrPclX4Z5EAM7/r34rSl2FO3WbUfYAiuj9nWdTu9zhLuDjbZydDTcuuTFVDWDjLlUvDu8OGi87qWmFPyALY1l7pV/K4aFrLMoOpWUqlH8H7oF0bcZHn5IYCDpqbjvioVUmNUMDKoablx36hXeu0yt02Xy47Y47TRt+2nqfEHotB+FVTPvmDKlipnbeIdJyZhtVnhGdclwTdLNdD0eQX8H89LYkHeENFEecm38syly+V6JotRCwcpDUCAU6upLi8C3A/EHhFyTY+lATqv5d8IN+1folOpUEZxdMsOUVrEZo++ciGt93Li7EbcyQl3zMnMb6usPRt8zeC1vCw0iEUzeVeJ7iQzNwljP2DLG80Sh/MOFsMbmKsSG3nCVgPo9hGTxHP5hRHfNeFI2WURJ7GYfaz/14O93JKWBx2z0M6czu+280vY3KLWflCM=
x-microsoft-antispam:
 BCL:0;ARA:14566002|19110799003|461199028|8060799006|56899033|1602099012|4302099013|440099028|102099032|3412199025;
x-microsoft-antispam-message-info:
 joIJvo4xvaXVAeIlefOFgkiamHqmLRBraLfb1jZnMuY/MCwb18Htj3inD8yqbuoqzYiZx4Bx7AR9W0ZLW0478lZp+LO6XSKTROO81etSVEbFFkSAcztdXTt3dGGWoDhzDIaCK9VDOHQQu4D7gInR2EBCKxbgRV6vLj1OdX60+nYxnbeGW8sD/IciqbAc3rbji9ri9+IJ/OfU2zefzDHCRJkrmHLhtijcQkXm6m0izFQsK3B7oZoqnNLchAFMB8etZIspoUbNnAhc3LovZQ7Z5/yLcdsXhw91Vh91Bt1iQ3W22cP21oqgW1yr55uSDgQjNmZVxJdWXAd/6DdMqPHjGefhBng9AIrpkeGResfZ8A2fba7SlNdtnGdy2ETZkExz6b98Zu8Pyl7oM9ulxYdib/9eMZPMFjnDDOgruVJZ6r4V8iNyPiLKxkdG0dQizvilTUTSuq1qmQX6y2Z4mYA1enMqXbvvsyjr5H3Ta44Y3stIFxRKybiS88uEyvehn7oJMKDNA4Zwurc+D7TUTDMMFircdGQW2NAKcgbocu/NpFKMD7DlciQ2TLCMvB1BbpPM7+drwk4AdraRv6kh0MYqfvs1P3R0H1Zt3MQOfgXRL9x5+RvLbKi/MoZP/HO0UZDUi8GDNRCHdX6RsPWl7SLYUBwpbQa0Sp9pFsuu5XZYJLI702f5H+9cFo7Txh2y9fCSM0RKxufjpzvTWtpVo8ibVbU9ujXcssESssEG1CxycDxo5V1/WkIWjtGqsGgJi4O6
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YzEvQkxjNUlFa0F0YTg4RkVCNUREY1ZET2FLUGZjaDdlUC96L25LdWRkUkdI?=
 =?utf-8?B?MXBTa0FFNmpTdkErYkVhUEpaYVFwZWlGZVdaUmJlWStKN3VMSXIwZXpKb1Zo?=
 =?utf-8?B?SytjbDQzOTRFZEdOajM4ZFRFRm92cG12dlQvTUFOMENCRUZvdVM5SjVjVXY5?=
 =?utf-8?B?MEIxWlN6czNsbjVlbHp5Rm8zazlxR3hyam1YY1B6YUhnS1lla01QTjkzUkRM?=
 =?utf-8?B?WEVodHNZalYrRHFaU2hwZ25XanBKSFd5RXNxYk83eVB5Z1pOYUEzbXhTcnRG?=
 =?utf-8?B?d0FZT1kyZFoxM3lPTG5taDc2M2ZMbTBpWjcvbVpmd1lFeGJLODJiTGc5d1JH?=
 =?utf-8?B?bDFUR0tIcjltNjFtK2dxOWtVZlVRTzNTdy94SkpJcWprVzFHTDA5bERpdnI2?=
 =?utf-8?B?WTNEVXJTS2pUS1NZVnpKY2MwUWdrRzd3cXRxVGozaUh2YTdWeElQZUZuRTVv?=
 =?utf-8?B?Q3ZPMHdteldFWENIYVk5dWJqY1QzcHIwT2Q0OWdoTTh0Y3F5RGJ0QzBieW5B?=
 =?utf-8?B?eDNTTnFtNS81NlRrSFc1bjRoQjJXQTIvRmw3empwUlh5aXgwejFYbVZsSW1I?=
 =?utf-8?B?aXJtVk5uakdEVnhYZmxVVDRKVDdVQnpIbTBXK3RjTEc5d1MxUWdzVFhQTENH?=
 =?utf-8?B?UDFrekcrSWcwaFlmaE1yVm9LaGxqTE5VRys0c29BVm84NmZYMUs4amo5dEYv?=
 =?utf-8?B?QVA3UFJwRmdST2xyZTVabnlxc1V4UG0rZ01IK0Z2ZzdUeTRNNCtqVTdqc1hQ?=
 =?utf-8?B?cTdrTUNlTVBPT0NGZGU5V1RRZnFqTmNqbmpzNURDTlFYVXJob2hSOXliN0ls?=
 =?utf-8?B?Ulg1QWM3ZzFyN0ZaNVZuZFlobnJZV3REWDM0YmxjVnVVdXFqS2IwWlNmOXBi?=
 =?utf-8?B?MGU4V2RjaWtyY2ZhOU1kQzdqd1ZmVy9SZUJnVkpCRUt1Qkh6MDBoQ1RNSXRp?=
 =?utf-8?B?Yk1PVTNvWVYzUmp3Z0tTaFIxS1NFdGxrYk9XYSt5em1IZStrRlZka3ZXVVgv?=
 =?utf-8?B?MGZqWENnYTkrSGxjMXJhZ3ZqN1AzS0tkTnVxQklrRU5aSTcyZzBRMUJjUE5Z?=
 =?utf-8?B?NE1wdWVFR2hnbUVMb0crbzdwV3RnQ0drR3BjWEYrMUNBT1dFd3lFeDRURHF4?=
 =?utf-8?B?NlBLOW1sRjBWM0lsUzJHMWZVMllDMUZHcExEOTFyamZpOHBZUEJMY2JwV1BN?=
 =?utf-8?B?bmptMklCbTczY0tMeGJBTEZhaDArMDRFM0RRRzZBd3ZpSzYxRzdrNzhpVndL?=
 =?utf-8?B?QWdOYWRtVzJDOXJEQ3IyMFFzU2svdmJRZkJiZUprcGZCdzFweXYrcHVtdXlK?=
 =?utf-8?B?emR6cUZnMEF5cHVoSzMraWhzUDlkaXB6Y0N3V1gvVmpVdzUzL3FLYWtINC9h?=
 =?utf-8?B?cHpvbkczSVd6SFFsbDdDRFRHQ1BMcVg2MUVMb3huR2piaEtkUGtIWkMzY29t?=
 =?utf-8?B?QzRuQ2NoR2p4NVBhVFBtSGh1MU9BTCtQVzc0K29RNnRDTlMxOGs1S3VIanRC?=
 =?utf-8?B?U1pOVmlCRGFaM0JqVnkzVzJjQWl3TUhaQ1hlTjlqYStHNzgzYUgvOE5JNlZC?=
 =?utf-8?B?dHpKSW5OR21hTmswS1NvNCs3YlFEclh1eVRwQW40M2xYS3M2MUhjQ0xjQWJh?=
 =?utf-8?B?VkFueFBodnM2NVMrWE5OT3NqTnVIcVB0Z3ZlVjRRNWNCZ2NsN0gzcG43ZGx0?=
 =?utf-8?B?R0NiYW9lQmRHanc0Y0thcjNhUW1kdUFNR203Y3hWeCtpYWgzOTVhUG5xUzBU?=
 =?utf-8?Q?AVGSm2fQZ5n98kI4hA=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: fbbfe47b-77f6-4f2f-cfbf-08dcabfd70e0
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2024 16:26:58.8101
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0P287MB0297

DQoNCj4gT24gMjQgSnVsIDIwMjQsIGF0IDk6MzHigK9QTSwgTHVrYXMgV3VubmVyIDxsdWthc0B3
dW5uZXIuZGU+IHdyb3RlOg0KPiANCj4g77u/T24gVHVlLCBKdWwgMjMsIDIwMjQgYXQgMDQ6MjU6
MTlQTSArMDAwMCwgQWRpdHlhIEdhcmcgd3JvdGU6DQo+Pj4gT24gV2VkLCBKdWwgMTcsIDIwMjQg
YXQgMDQ6MzU6MTVQTSArMDAwMCwgQWRpdHlhIEdhcmcgd3JvdGU6DQo+Pj4gRm9yIHRoZSBNYWNz
IGhhdmluZyBhIHNpbmdsZSBHUFUsIGluIGNhc2UgYSBwZXJzb24gdXNlcyBhbiBlR1BVLA0KPj4+
IHRoZXkgc3RpbGwgbmVlZCB0aGlzIGFwcGxlLXNldC1vcyBxdWlyayBmb3IgaHlicmlkIGdyYXBo
aWNzLg0KPj4gDQo+PiBTZW5kaW5nIHRoaXMgbWVzc2FnZSBhZ2FpbiBhcyBmb3Igc29tZSByZWFz
b24gaXQgZ290IHNlbnQgb25seSB0byBMdWthczoNCj4+IA0KPj4gRnVsbCBtb2RlbCBuYW1lOiBN
YWMgbWluaSAoMjAxOCkgKE1hY21pbmk4LDEpDQo+PiANCj4+IFRoZSBkcml2ZSBsaW5rIGJlbG93
IGhhcyB0aGUgbG9nczoNCj4+IA0KPj4gaHR0cHM6Ly9kcml2ZS5nb29nbGUuY29tL2ZpbGUvZC8x
UDMtR2xrc1U2V3Bwdnp2V0MwQS1uQW9UWmg3b1BQeGsvdmlldz91c3A9ZHJpdmVfbGluaw0KPiAN
Cj4gU29tZSBvYnNlcnZhdGlvbnM6DQo+IA0KPiAqIGRtZXNnLXdpdGgtZWdwdS50eHQ6ICBJdCBz
ZWVtcyB0aGUgc3lzdGVtIHdhcyBhY3R1YWxseSBib290ZWQgKndpdGhvdXQqDQo+ICBhbiBlR1BV
LCBzbyB0aGUgZmlsZW5hbWUgYXBwZWFycyB0byBiZSBhIG1pc25vbWVyLg0KPiANCj4gKiBUaGUg
dHdvIGZpbGVzIGluIHRoZSB3aXRoX2FwcGxlX3NldF9vc19lZmkgZGlyZWN0b3J5IG9ubHkgY29u
dGFpbg0KPiAgaW5jb21wbGV0ZSBkbWVzZyBvdXRwdXQuICBCb290IHdpdGggbG9nX2J1Zl9sZW49
MTZNIHRvIHNvbHZlIHRoaXMuDQo+ICBGb3J0dW5hdGVseSB0aGUgdHJ1bmNhdGVkIGxvZyBpcyBz
dWZmaWNpZW50IHRvIHNlZSB3aGF0J3MgZ29pbmcgb24uDQo+IA0KPiAqIElmIHRoZSBhcHBsZV9z
ZXRfb3MgcHJvdG9jb2wgaXMgbm90IHVzZWQsIHRoZSBhdHRhY2hlZCBlR1BVIGlzIG5vdA0KPiAg
ZW51bWVyYXRlZCBieSB0aGUga2VybmVsIG9uIGJvb3QgYW5kIGEgcmVzY2FuIGlzIHJlcXVpcmVk
Lg0KPiAgU28gbmVpdGhlciB0aGUgaUdQVSBub3IgdGhlIGVHUFUgYXJlIHdvcmtpbmcuICBUaGUg
cmVhc29uIGlzIEJJT1MNCj4gIHNldHMgdXAgaW5jb3JyZWN0IGJyaWRnZSB3aW5kb3dzIGZvciB0
aGUgVGh1bmRlcmJvbHQgaG9zdCBjb250cm9sbGVyOg0KPiAgSXRzIHR3byBkb3duc3RyZWFtIHBv
cnRzJyA2NC1iaXQgd2luZG93cyBvdmVybGFwLiAgVGhlIDMyLWJpdCB3aW5kb3dzDQo+ICBkbyBu
b3Qgb3ZlcmxhcC4gIElmIGFwcGxlX3NldF9vcyBpcyB1c2VkLCB0aGUgZUdQVSBpcyB1c2luZyB0
aGUNCj4gIChub24tb3ZlcmxhcHBpbmcpIDMyLWJpdCB3aW5kb3cuICBJZiBhcHBsZV9zZXRfb3Mg
aXMgbm90IHVzZWQsDQo+ICB0aGUgYXR0YWNoZWQgZUdQVSBpcyB1c2luZyB0aGUgKG92ZXJsYXBw
aW5nLCBoZW5jZSBicm9rZW4pIDY0LWJpdCB3aW5kb3cuICANCj4gDQo+ICBTbyBub3Qgb25seSBp
cyBhcHBsZV9zZXRfb3MgbmVlZGVkIHRvIGtlZXAgdGhlIGlHUFUgZW5hYmxlZCwNCj4gIGJ1dCBh
bHNvIHRvIGVuc3VyZSBCSU9TIHNldHMgdXAgYnJpZGdlIHdpbmRvd3MgaW4gYSBtYW5uZXIgdGhh
dCBpcw0KPiAgb25seSBoYWxmd2F5IGJyb2tlbiBhbmQgbm90IHRvdGFsbHkgYnJva2VuLg0KPiAN
Cj4gIEJlbG93LCAwMDAwOjA2OjAxLjAgYW5kIDAwMDA6MDY6MDQuMCBhcmUgdGhlIGRvd25zdHJl
YW0gcG9ydHMgb24gdGhlDQo+ICBUaHVuZGVyYm9sdCBob3N0IGNvbnRyb2xsZXIgYW5kIDAwMDA6
MDk6MDAuMCBpcyB0aGUgdXBzdHJlYW0gcG9ydCBvZg0KPiAgdGhlIGF0dGFjaGVkIGVHUFUuDQo+
IA0KPiAgaUdQVSBlbmFibGVkLCBubyBlR1BVIGF0dGFjaGVkIChkbWVzZy50eHQpOg0KPiAgcGNp
IDAwMDA6MDY6MDEuMDogICBicmlkZ2Ugd2luZG93IFttZW0gMHg4MTkwMDAwMC0weDg4OGZmZmZm
XQ0KPiAgcGNpIDAwMDA6MDY6MDEuMDogICBicmlkZ2Ugd2luZG93IFttZW0gMHhiMTQwMDAwMC0w
eGI4M2ZmZmZmIDY0Yml0IHByZWZdDQo+ICBwY2kgMDAwMDowNjowNC4wOiAgIGJyaWRnZSB3aW5k
b3cgW21lbSAweDg4OTAwMDAwLTB4OGY4ZmZmZmZdDQo+ICBwY2kgMDAwMDowNjowNC4wOiAgIGJy
aWRnZSB3aW5kb3cgW21lbSAweGI4NDAwMDAwLTB4YmYzZmZmZmYgNjRiaXQgcHJlZl0NCj4gDQo+
ICBpR1BVIGRpc2FibGVkLCBlR1BVIGF0dGFjaGVkLCBhcHBsZV9zZXRfb3Mgbm90IHVzZWQgKGpv
dXJuYWxjdGwudHh0KToNCj4gIHBjaSAwMDAwOjA2OjAxLjA6ICAgYnJpZGdlIHdpbmRvdyBbbWVt
IDB4ODE5MDAwMDAtMHg4ODhmZmZmZl0NCj4gIHBjaSAwMDAwOjA2OjAxLjA6ICAgYnJpZGdlIHdp
bmRvdyBbbWVtIDB4YjE0MDAwMDAtMHhjNmZmZmZmZiA2NGJpdCBwcmVmXQ0KPiAgcGNpIDAwMDA6
MDY6MDQuMDogICBicmlkZ2Ugd2luZG93IFttZW0gMHg4ODkwMDAwMC0weDhmOGZmZmZmXQ0KPiAg
cGNpIDAwMDA6MDY6MDQuMDogICBicmlkZ2Ugd2luZG93IFttZW0gMHhiODQwMDAwMC0weGJmM2Zm
ZmZmIDY0Yml0IHByZWZdDQo+ICBwY2kgMDAwMDowNjowNC4wOiBicmlkZ2Ugd2luZG93IFttZW0g
MHhiODQwMDAwMC0weGJmM2ZmZmZmIDY0Yml0IHByZWZdOiBjYW4ndCBjbGFpbTsgYWRkcmVzcyBj
b25mbGljdCB3aXRoIFBDSSBCdXMgMDAwMDowOSBbbWVtIDB4YjE0MDAwMDAtMHhiZjNmZmZmZiA2
NGJpdCBwcmVmXQ0KPiANCj4gIGlHUFUgZW5hYmxlZCwgZUdQVSBhdHRhY2hlZCwgYXBwbGVfc2V0
X29zIHVzZWQgKHdvcmtpbmctam91cm5hbGN0bC50eHQpOg0KPiAgcGNpIDAwMDA6MDY6MDEuMDog
ICBicmlkZ2Ugd2luZG93IFttZW0gMHg4MTkwMDAwMC0weDg4OGZmZmZmXQ0KPiAgcGNpIDAwMDA6
MDY6MDEuMDogICBicmlkZ2Ugd2luZG93IFttZW0gMHhiMTQwMDAwMC0weGM2ZmZmZmZmIDY0Yml0
IHByZWZdDQo+ICBwY2kgMDAwMDowNjowNC4wOiAgIGJyaWRnZSB3aW5kb3cgW21lbSAweDg4OTAw
MDAwLTB4OGY4ZmZmZmZdDQo+ICBwY2kgMDAwMDowNjowNC4wOiAgIGJyaWRnZSB3aW5kb3cgW21l
bSAweGI4NDAwMDAwLTB4YmYzZmZmZmYgNjRiaXQgcHJlZl0NCj4gIHBjaSAwMDAwOjA5OjAwLjA6
ICAgYnJpZGdlIHdpbmRvdyBbbWVtIDB4ODE5MDAwMDAtMHg4MWNmZmZmZl0NCj4gDQo+ICogQXMg
dG8gaG93IHdlIGNhbiBzb2x2ZSB0aGlzIGFuZCBrZWVwIHVzaW5nIGFwcGxlX3NldF9vcyBvbmx5
IHdoZW4NCj4gIG5lY2Vzc2FyeToNCj4gDQo+ICBJIG5vdGUgdGhhdCBvbiB4ODYsIHRoZSBlZmlz
dHViIHdhbGtzIG92ZXIgYWxsIFBDSSBkZXZpY2VzIGluIHRoZSBzeXN0ZW0NCj4gIChzZWUgc2V0
dXBfZWZpX3BjaSgpIGluIGRyaXZlcnMvZmlybXdhcmUvZWZpL2xpYnN0dWIveDg2LXN0dWIuYykg
YW5kDQo+ICByZXRyaWV2ZXMgdGhlIERldmljZSBJRCBhbmQgVmVuZG9yIElELiAgV2UgY291bGQg
YWRkaXRpb25hbGx5IHJldHJpZXZlDQo+ICB0aGUgQ2xhc3MgQ29kZSBhbmQgY291bnQgdGhlIG51
bWJlciBvZiBHUFVzIGluIHRoZSBzeXN0ZW0gYnkgY2hlY2tpbmcNCj4gIHdoZXRoZXIgdGhlIENs
YXNzIENvZGUgbWF0Y2hlcyBQQ0lfQkFTRV9DTEFTU19ESVNQTEFZLiAgSWYgdGhlcmUncw0KPiAg
YXQgbGVhc3QgMiBHUFVzIGluIHRoZSBzeXN0ZW0sIGludm9rZSBhcHBsZV9zZXRfb3MuDQoNClRo
aXMgYWxzbyBsb29rcyBsaWtlIGEgZ29vZCBpZGVhLCBidXQgSSdtIG5vdCB3ZWxsIGF3YXJlIG9m
IHRoZSBwY2kgcXVpcmtzIGluIHRoZSBMaW51eCBrZXJuZWwuIFNvLCB3b3VsZCBjb25zaWRlciBp
dCBhIGJ1ZyByZXBvcnQgZm9yIHRoZSBtYWludGFpbmVycyB0byBmaXguDQo+IA0KPiAgVGhlIHF1
ZXN0aW9uIGlzIHdoZXRoZXIgdGhpcyBpcyBuZWVkZWQgb24gKmFsbCogQXBwbGUgcHJvZHVjdHMg
b3Igb25seQ0KPiAgb24gbmV3ZXIgb25lcy4gIEkgc3VzcGVjdCB0aGF0IHRoZSBlR1BVIGlzc3Vl
IG1heSBiZSBzcGVjaWZpYyB0bw0KPiAgcmVjZW50IHByb2R1Y3RzLiAgSWRlYWxseSB3ZSdkIGZp
bmQgc29tZW9uZSB3aXRoIGEgSGFzd2VsbCBvciBJdnkgQnJpZGdlDQo+ICBlcmEgTWFjIE1pbmkg
YW5kIGFuIGVHUFUgd2hvIGNvdWxkIHZlcmlmeSB3aGV0aGVyIGFwcGxlX3NldF9vcyBpcyBuZWVk
ZWQNCj4gIG9uIG9sZGVyIG1vZGVscyBhcyB3ZWxsLg0KPiANCj4gIFdlIGNvdWxkIGNvbnN0cmFp
biBhcHBsZV9zZXRfb3MgdG8gbmV3ZXIgbW9kZWxzIGJ5IGNoZWNraW5nIGZvcg0KPiAgcHJlc2Vu
Y2Ugb2YgdGhlIFQyIFBDSSBkZXZpY2UgWzEwNmI6MTgwMl0uICBBbHRlcm5hdGl2ZWx5LCB3ZSBj
b3VsZA0KPiAgdXNlIHRoZSBCSU9TIGRhdGUgKERNSV9CSU9TX0RBVEUgaW4gU01CSU9TIGRhdGEp
IHRvIGVuZm9yY2UgYQ0KPiAgY3V0LW9mZiBzdWNoIHRoYXQgb25seSBtYWNoaW5lcyB3aXRoIGEg
cmVjZW50IEJJT1MgdXNlIGFwcGxlX3NldF9vcy4NCj4gDQo+IFRoYW5rcywNCj4gDQo+IEx1a2Fz
DQo=

