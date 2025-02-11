Return-Path: <linux-efi+bounces-2788-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF3C1A310A9
	for <lists+linux-efi@lfdr.de>; Tue, 11 Feb 2025 17:07:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CBF5188246B
	for <lists+linux-efi@lfdr.de>; Tue, 11 Feb 2025 16:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01758253B4C;
	Tue, 11 Feb 2025 16:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="T2nKK94A"
X-Original-To: linux-efi@vger.kernel.org
Received: from MA0PR01CU012.outbound.protection.outlook.com (mail-southindiaazolkn19011034.outbound.protection.outlook.com [52.103.67.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 061B21FCCE9;
	Tue, 11 Feb 2025 16:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739289919; cv=fail; b=JrITH07ExQ0Ska5z7UaQK4qvgzUbK38STneh0X+J1ZSSOMWkwYW+fNPELz0kxXAF76MwJZksfK9hV57JJf7nJhrH12ujR18MKH6XiifdmCL8cuucjn2atCY1eFqUxG+rYB4WOktR7bWR6GAtcn85eE3hanDWUzrvh6c9QHB3HIc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739289919; c=relaxed/simple;
	bh=itK31a23NheE/A4i9BoiF85sjKIM5erjGgCeYlu7HIs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Z1tcOOizNoUDeLVana/gCkew07jJxUJYLutx518P4XxWv0ITeWLpUdkpGBKhXwTJzQ6Ub7shZCaOMagVf00Y/4Utiafrbjy5px+xRHUj0Rtffod0wDV+4FZC2hwKJjAgx4urVuvJijLO+3kxRu7DbGqU9NNzFEnjOT0ynqWdY24=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=T2nKK94A; arc=fail smtp.client-ip=52.103.67.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WbepmXfEAo7c8Nlig1V012+9E+Sw89Rw/ChgDVGB82vAIpqLQ+nUHisTsMqk/5VdJE4nxqGlTqM+gQdNhGtk5ratbKKTCPJr1XTIJ0EvMmyYORvNaJuKvldjdprpCYS/ObQD8OwRXVL4yeATwzPv13taPaUoDwCkRJ97/t2NSilDryqA79bsnmYMItFJjfJUCzNluO/KsumyxlWxxqEoydyiLeCQrTMdUn4/AoT650Cd4iPaXUQd8qiEYAIwJbCIMQgWQVJDh8J0G3IkDJqmYdTjUMSyG64/8zrojU1vurtcIvHU8ysrwArb0XvuGDk9qs90MGmIlCF7hukAMl0kaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=itK31a23NheE/A4i9BoiF85sjKIM5erjGgCeYlu7HIs=;
 b=ASMhul8XzKJJOO8U8+wHdU1KaA9blY0VHJlByT4WNlL1iQxo7Q42SUEPmh9F3WoJGaZSI24BnoKQbQ6zzfaChGYr02dxb9d//HLy//NhCVBLuDJH+WmtyU8myAe73fnx3dPA0cq869Y6WJmCfB10zVHlqYZmG5I38ptxBZsyiNW1r2+MI95SojKXXqaO8GdMRwrCpMQ2EKkp2iIJn4+DXkQDlEP23n9buEPg/ZRn0jJFj7FfFEoPZ7c4G6783+35+Xxrv3es812ZMtRFbfKs44WORzFnqiQISZUKiSg9S/oL6R4xfb8jSbgFCPeQI4l7Zw8H0dDUUsIenLxigcOxpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=itK31a23NheE/A4i9BoiF85sjKIM5erjGgCeYlu7HIs=;
 b=T2nKK94AGSuh8gWKoY0PjMHMcsLVZjil6xZjjXWzYlgMZS2FyfZ6eMlbylKd2whUhRJhM75t7FexjkM+YJUnbvFGkPv59nukKtwhSW6FlJakW16Kj219f2h5zNtSvY4fUvhj42TMvC08Ajkx7IHRr2Twm6hLWFIPXzjKtFYwPzlnpDL03U1WwjFHvrjeh2qFDEW4MH58fWMMfSRhBW7Hi6yyJWZFVDNfrB0B78BAQ/EW+IlV4OoenAyzMO9Ep1rau9TzX6ntn/tUG5uygAaASMGNfFLg4wyxCIq4iMMUmemzR+c9xUwIuUFqJ1Jb2WwoQmmJnxbl4eff07VPZVKfXg==
Received: from PN0PR01MB9608.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:110::10)
 by PN0PR01MB5969.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:65::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.19; Tue, 11 Feb
 2025 16:05:12 +0000
Received: from PN0PR01MB9608.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::972:abe8:752:bbde]) by PN0PR01MB9608.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::972:abe8:752:bbde%5]) with mapi id 15.20.8422.015; Tue, 11 Feb 2025
 16:05:12 +0000
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
 AQHbWWa5RmJr6eRYF0KZY8iXtrQUd7L8/foAgAACjoCAAAg9AIAAgZCAgACTR4CAA7KhR4A/aVoAgAFRAwA=
Date: Tue, 11 Feb 2025 16:05:12 +0000
Message-ID: <52B0B784-2FB5-4B7D-8FB6-A7B694EDDFC3@live.com>
References: <20241228202212.89069-1-lleyton@fyralabs.com>
 <Z3EdkuCBzTGzTHK3@wunner.de>
 <CAMj1kXHWoD78QdFnEY_=Mtz02zN3rhN5+Skgv=fHG91TD8Mmvw@mail.gmail.com>
 <Z3EmoNWbkbYZ7NZO@wunner.de>
 <CAMj1kXEb9NPSwEr2brHYJtFQhnW55hoPycjcAgoPAfjU5ZFqZw@mail.gmail.com>
 <abe2274b-4341-4212-85a8-113273ce1b18@fyralabs.com>
 <PN3PR01MB7728B4C94846673A5FFACE29B80B2@PN3PR01MB7728.INDPRD01.PROD.OUTLOOK.COM>
 <Z6paeFrjdv7L3mtv@wunner.de>
In-Reply-To: <Z6paeFrjdv7L3mtv@wunner.de>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN0PR01MB9608:EE_|PN0PR01MB5969:EE_
x-ms-office365-filtering-correlation-id: 6685bf67-4dc8-4a58-7859-08dd4ab5ddbe
x-microsoft-antispam:
 BCL:0;ARA:14566002|8060799006|8062599003|19110799003|461199028|7092599003|15080799006|10035399004|3412199025|440099028|41001999003|102099032;
x-microsoft-antispam-message-info:
 =?utf-8?B?NUoyNTdhdkRUMTRUUW91OFBKNnlMK0NSemhNMlNja2VtRUthcnM2K0FqOStj?=
 =?utf-8?B?bXhVVDEzSmRLVDQ3MHBvTFl6R3NGaHdMeExaYkVteU5hRFFGWnpiSEpZV1p1?=
 =?utf-8?B?a3lRK1hVN1VpU0U0RXZWU2c2dnk3UTNKVkZ0d1BhV2VNWmthNmxCNUZVbUhV?=
 =?utf-8?B?N2MvbitRUk9sR09XckRrR0JGTVZ5cG5HV2JzN1dIbFhXNmlaQkRtbk9PZUto?=
 =?utf-8?B?VjRtMnhnenpacjdtVUpIUFF4OHJUS09RWFRTVGEwRWkvclg0bW1ReFJjaFda?=
 =?utf-8?B?aXFrMzBmNjFrYld1eXpxUVZjbHJqeW8yaWtOZGpaUkZRTU9aUDN2NTg2THNx?=
 =?utf-8?B?UTZqSlovSFZVZGhuRW44UXgzZDRrb3dPWThlcUJGTlZNQmc2aXV0emg4OGNn?=
 =?utf-8?B?L3BVSlZNMWYxZWpVcHNRZVFCbkd1MFpGNVJZQmQzYVY2NFh4NWJ0WXdMTkZi?=
 =?utf-8?B?bEtwRHdqdDZsMHdDSmx0cjRuM0syTHJOcXZyUlBMTlBiaTlFT0RRQXM3blZP?=
 =?utf-8?B?djlnUEY3eW9HUmRQdThSdWppeS9Ya253NS9RZmFzSlM3Q1RFcDBFMU9GSldQ?=
 =?utf-8?B?M2JhTmFINUpjRkRyNmRxVFpKN2E4dnJwQTFOYUNmZGFMVmZXMXI5ZTd4TU95?=
 =?utf-8?B?Q2hpOU5VcThrVG9qUnJwYmZVQ0RFbnJTZGJpUGhibDI2SlpWWnNHSWEvYTdp?=
 =?utf-8?B?dmg0TEFyOFVhVFVQTUpQcll6VkdzZlJleUlaa05zTjNRQXpaVjQ1dVBzUUdi?=
 =?utf-8?B?OGxCSE40eEdmOEVLYSs3NzFGRGE3cnpocHZ6Z00rUytFb041Uzc4V0RkSDA1?=
 =?utf-8?B?WkszUStYYy9scW5PaTJQRmlvRHFRa1JpcWhCRVlXN2xJbVcrbFZBbkhJdUUx?=
 =?utf-8?B?K2RrTkluYVVkYUl0VCtuMWlFVWtxSTJtNUFHZHUxL1RvL09sZ1FucDc5U1p5?=
 =?utf-8?B?QWFNdGZoQmpzYm9pNEx0Q2ZNVDlFZlVKZERiZ1JNMmQxVUFXUG5vS0NObzRU?=
 =?utf-8?B?QkRibFZ6TGlpRVZnTW1vNm00S3hMZGMwWXY5SzRxNXhxK1VlbE9ZMEE2d3ow?=
 =?utf-8?B?OFZWRTJiUGZzZ0NtcXcwOVBTNnppMHkzL1M3aFhqTzc2M3ZLQkJSOU4zYS9z?=
 =?utf-8?B?aDYzbHc2TkhkU21jMjJSNm9LRE5RbnFQODUycFJrbFZ0UTBoM2NkVU1LYi93?=
 =?utf-8?B?ZUlwaHlTZm40ek9TQ3UwZTZnaVRqTGVOSWlJUmNYUDlQRUIxa2NoQUp1WXdW?=
 =?utf-8?B?NWJFSVJXeWlPdXdhaGRQK0ZPVVlJTk5hUmhhTzhRNFdSOGlOMmNFTGV1cDdC?=
 =?utf-8?B?OUs5OUI2R0IvS3FGL2loZFdEamhweU1iaWlzMStkRE9ZdTlMSjJmUzZOY1lS?=
 =?utf-8?B?bmlmQjhDblN6R0draHhYS3RGZHQyWjlaMkk1aktGYzVFTlNPb1ZDRFhacEpZ?=
 =?utf-8?B?d2JSRG8vU3g3azZjd0Qzc2taaUpwZnAzdktETGF6aUJEdnc4MitqRVZ1bm5l?=
 =?utf-8?B?STBlbTh5bmlNd2tSck4vejI2WSszNW9JRXl0VmNYTm1yRWJpelNyeFRFRGtn?=
 =?utf-8?Q?/OCvK7zuVPzjGbR42gwfqvSE4=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?M0N2VVVjMkZMWWtKd201U1lORktCQ0YzQXBGRGNSRkxsUXk4dFVJeW1FdnhN?=
 =?utf-8?B?L09veGE5dFhTM3ZKUmltRnd3RVFLNWlIanJzZDhDWjNINVdaMVVDZUNRNHpB?=
 =?utf-8?B?Mkd1Z3hybnY2YkhpbytoY0lZYXE0T2NGTy9HVmtvMVNqa2VzMlIwY2FENDlN?=
 =?utf-8?B?YngvbTMrT1d2MkN5M05KMlhpRnVXSlNSd1NuQWxoMnIrUzhuVG9TcnVGaitI?=
 =?utf-8?B?V3ZwNHVLQ1RoazNhTVFvYVJ4Yk5NSjV4N0x6TWs0UmkyVjJ6QzErUnExeEl2?=
 =?utf-8?B?S2hGbDcxYmJSbVU3QzdiMmNiUjZUc1UwVGM3TmQwemtBODVrZ1Zxd2oyUGE2?=
 =?utf-8?B?VE5zU2ZaNVpYQlAzdjRQVTRNWjF1L1pubk90MGNwNnQyd2J6Q1RPUkphWEpK?=
 =?utf-8?B?Q2ZZV2lsZGFtWDZWSmlNWjRrL096QW82cEdJcHZyMEtzUGRDUHNta3cyWGRw?=
 =?utf-8?B?YWZlcUhIM3UxZFl0bm90R0pEVENiYW1WMEl2bzd0MTNzZmdtL21EcjZQdTN1?=
 =?utf-8?B?bGhSMFJGQUdFcnhXMi9KbFZjTk9ITWtZYjMxRWpxMGhSZjArZVIwRTlYVkJ0?=
 =?utf-8?B?UWo4RXlCUkc2MC8xWVVZS1RuYm04Q1BBa2cvdXhkZEI4TmlYZlR1RFJjam9y?=
 =?utf-8?B?UUxOaXlGR2tnUGtLY2tYejNDZ05rdFAzWW1JMmpCcUt4T1BONGVibmYyRFBN?=
 =?utf-8?B?QWZ0d0psNHIveVQvVnczN3FuVEVTTFMyblJUeWZ3aTBYVVNSYXVhNk1aZG9k?=
 =?utf-8?B?NU9lQ2pHM3pJVUdnbnh1d0lZSlFvMnlBQ2g3SlhqanI4M0JGdVNFeWlBbjdL?=
 =?utf-8?B?TFY0RTVLbHdmcE1OVlhLYVByZ1c4OWRXZUE4VUc5a3FmWDlZemNMOTNtZ1Ni?=
 =?utf-8?B?RzRpTTd1NkZINkR6alpKa1pRcVFLTUJlSnp6Tk1aa1hZN2FYMWl1K1NVdFVH?=
 =?utf-8?B?bmxwYkVwOUdIb1RBMmZBMzd6c0pMazNJejVVM1R4ajRtOUZQaGYrQ0pXVTJT?=
 =?utf-8?B?TENESHJrN3dkSHJRbnoxY05oSis5N09oT3gzdnFJM3ZPYW9CL0s2S2M3QkJO?=
 =?utf-8?B?SU0xU1plT0loSFV4WWMvR2JXdEFFaTUwQlBoUGo4SlRTTjNzelZpUzJQdVdH?=
 =?utf-8?B?YUYwcnZoZC9UY0dld29mbjlNOFFCZG93b0EzeTdPNmo0N0NHSDlBVUIwK1pZ?=
 =?utf-8?B?N3JiSVp3cTBuZFZYUk5ONTg1aUlYRlRBS24wWlJTSGR0WEdvNFVrWXFTS0RT?=
 =?utf-8?B?UHMrWkRkTktIeFB6RmVDR1hITHVYb0VReCtjejZUdVl4cDZDTE9pUU8relZO?=
 =?utf-8?B?Zi81b3ZHK21OMVlmU0tMTHBXVzdyVDFkSDRIeVNONTg4cmZ3UlJVWEM3SHcy?=
 =?utf-8?B?cEdTOTlsZGx2STNzWHpGMmh1dVlkMnBwTmNBekRFLzNodW1MVy9BZ2EyZ1Vn?=
 =?utf-8?B?NUVHdkExcUZ2SG91Z2VWa2FVK3l6Z0dSM3ZOTERzNXpRZHRJdGRDd2E4RWZt?=
 =?utf-8?B?N0pTRHdISytnVEZDK1ZHZWgvZHF3MGpVVlQzTXE4VEU3UXR5dGthV2xzZHNM?=
 =?utf-8?B?ZHJPcWswMkV3aWpESUg0cU5GMjBvNUp4bFRjSURxUGZZL2xKeUlEaHQwVVFW?=
 =?utf-8?B?UVM2c0NQZVkydDhMWVhlSU9QMm9LNE5UNzVWOW90REpPUTdxVWZWczROcjFN?=
 =?utf-8?B?MlRGUndOVDdaTlhFMUdTdGQ5TDJUaFVrd25jekZsQ3JlaE91NlBOSVczNkRH?=
 =?utf-8?Q?UqX0Qo+oCsvgNSuHus=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AD945B3CBCE9154C8701222A419ED4B2@INDPRD01.PROD.OUTLOOK.COM>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6685bf67-4dc8-4a58-7859-08dd4ab5ddbe
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2025 16:05:12.6109
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0PR01MB5969

SGkgTHVrYXMNCg0KPiBPbiAxMSBGZWIgMjAyNSwgYXQgMToyOOKAr0FNLCBMdWthcyBXdW5uZXIg
PGx1a2FzQHd1bm5lci5kZT4gd3JvdGU6DQo+IA0KPiBIaSBBZGl0eWEsDQo+IA0KPiBzb3JyeSBm
b3IgdGhlIGRlbGF5IQ0KPiANCj4gT24gV2VkLCBKYW4gMDEsIDIwMjUgYXQgMTE6Mzk6MTNBTSAr
MDAwMCwgQWRpdHlhIEdhcmcgd3JvdGU6DQo+PiBXZSBoYXZlIGhhZCBpc3N1ZXMgd2l0aCBvdGhl
ciBwZW9wbGUgdW5hYmxlIHRvIHVzZSB0aGVpciBlR1BVIGlmIHRoZWlyDQo+PiBNYWMgZG9lc24n
dCBoYXZlIHRoZSBhcHBsZSBzZXQgb3MgcXVpcmsuIFdlIHByb2JhYmx5IGNvdWxkIGRvIGR1YWwg
VkdBDQo+PiBjaGVja3Mgc3VnZ2VzdGVkIGJ5IEx1a2FzLCBidXQgd2lsbCBpdCB3b3JrIHdpdGgg
R1BVIGhvdHBsdWc/DQo+IA0KPiBGV0lXLCBiZWxvdyB3b3VsZCBiZSBteSBzdWdnZXN0aW9uIGZv
ciByZXBsYWNpbmcgdGhlIERNSS1iYXNlZCBxdWlyaw0KPiB3aXRoIG9uZSB0aGF0IGlzIGJhc2Vk
IG9uIHRoZSBudW1iZXIgb2YgR1BVcy4NCj4gDQo+IEl0IHNob3VsZCBpbnZva2UgdGhlIGFwcGxl
X3NldF9vcyBwcm90b2NvbCBib3RoIG9uIGR1YWwgR1BVIGxhcHRvcHMNCj4gYXMgd2VsbCBhcyBv
bmVzIHdpdGggYW4gZUdQVSwgaGVuY2UgbXkgZXhwZWN0YXRpb24gaXMgdGhhdCBpdCBzaG91bGQN
Cj4gZml4IHRoZSBpc3N1ZSByZXBvcnRlZCBieSBMbGV5dG9uLg0KPiANCj4gVGhlIHF1aXJrIGlz
IG5vdCBhcHBsaWVkIGUuZy4gb24gc2luZ2xlIEdQVSBNYWNCb29rIEFpcnMsIGhlbmNlDQo+IHNo
b3VsZCBhdm9pZCByZWdyZXNzaW5nIHRob3NlLg0KPiANCj4gVGhlIHBhdGNoIGlzIGNvbXBpbGUt
dGVzdGVkIG9ubHkuDQo+IA0KPiBJdCBwZXJmb3JtcyBvbmUgYWRkaXRpb25hbCAxNi1iaXQgY29u
ZmlnIHNwYWNlIHJlYWQgZm9yIGV2ZXJ5IFBDSQ0KPiBkZXZpY2UgaW4gdGhlIHN5c3RlbS4gIElm
IGFueW9uZSBvYmplY3RzIHRvIHRoYXQgYW5kIHdhbnRzIGl0DQo+IGNvbnN0cmFpbmVkIHRvIEFw
cGxlIHN5c3RlbXMsIHRoYXQgY291bGQgYmUgY2hhbmdlZCBlYXNpbHkuDQo+IA0KPiBUaGFua3Ms
DQo+IA0KPiBMdWthcw0KPiANCj4gLS0gPjggLS0NCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L2Zpcm13YXJlL2VmaS9saWJzdHViL3g4Ni1zdHViLmMgYi9kcml2ZXJzL2Zpcm13YXJlL2VmaS9s
aWJzdHViL3g4Ni1zdHViLmMNCj4gaW5kZXggODYzOTEwZTllZWZjLi4zMDkyYTZlNTE2NmYgMTAw
NjQ0DQo+IC0tLSBhL2RyaXZlcnMvZmlybXdhcmUvZWZpL2xpYnN0dWIveDg2LXN0dWIuYw0KPiAr
KysgYi9kcml2ZXJzL2Zpcm13YXJlL2VmaS9saWJzdHViL3g4Ni1zdHViLmMNCj4gQEAgLTI3LDYg
KzI3LDcgQEAgY29uc3QgZWZpX3N5c3RlbV90YWJsZV90ICplZmlfc3lzdGVtX3RhYmxlOw0KPiBj
b25zdCBlZmlfZHhlX3NlcnZpY2VzX3RhYmxlX3QgKmVmaV9keGVfdGFibGU7DQo+IHN0YXRpYyBl
ZmlfbG9hZGVkX2ltYWdlX3QgKmltYWdlID0gTlVMTDsNCj4gc3RhdGljIGVmaV9tZW1vcnlfYXR0
cmlidXRlX3Byb3RvY29sX3QgKm1lbWF0dHI7DQo+ICtzdGF0aWMgdW5zaWduZWQgaW50IG5yX2dw
dXM7DQo+IA0KPiB0eXBlZGVmIHVuaW9uIHNldl9tZW1vcnlfYWNjZXB0YW5jZV9wcm90b2NvbCBz
ZXZfbWVtb3J5X2FjY2VwdGFuY2VfcHJvdG9jb2xfdDsNCj4gdW5pb24gc2V2X21lbW9yeV9hY2Nl
cHRhbmNlX3Byb3RvY29sIHsNCj4gQEAgLTM5LDYgKzQwLDIzIEBAIHVuaW9uIHNldl9tZW1vcnlf
YWNjZXB0YW5jZV9wcm90b2NvbCB7DQo+IH0gbWl4ZWRfbW9kZTsNCj4gfTsNCj4gDQo+ICtzdGF0
aWMgdm9pZCB1cGRhdGVfbnJfZ3B1cyhlZmlfcGNpX2lvX3Byb3RvY29sX3QgKnBjaSkNCj4gK3sN
Cj4gKyBlZmlfc3RhdHVzX3Qgc3RhdHVzOw0KPiArIHUxNiBjbGFzczsNCj4gKw0KPiArIHN0YXR1
cyA9IGVmaV9jYWxsX3Byb3RvKHBjaSwgcGNpLnJlYWQsIEVmaVBjaUlvV2lkdGhVaW50MTYsDQo+
ICsgUENJX0NMQVNTX0RFVklDRSwgMSwgJmNsYXNzKTsNCj4gKw0KPiArIGlmIChzdGF0dXMgIT0g
RUZJX1NVQ0NFU1MpIHsNCj4gKyBlZmlfZXJyKCJGYWlsZWQgdG8gcmVhZCBkZXZpY2UgY2xhc3Nc
biIpOw0KPiArIHJldHVybjsNCj4gKyB9DQo+ICsNCj4gKyBpZiAoY2xhc3MgPj4gOCA9PSBQQ0lf
QkFTRV9DTEFTU19ESVNQTEFZKQ0KPiArIG5yX2dwdXMrKzsNCj4gK30NCj4gKw0KPiBzdGF0aWMg
ZWZpX3N0YXR1c190DQo+IHByZXNlcnZlX3BjaV9yb21faW1hZ2UoZWZpX3BjaV9pb19wcm90b2Nv
bF90ICpwY2ksIHN0cnVjdCBwY2lfc2V0dXBfcm9tICoqX19yb20pDQo+IHsNCj4gQEAgLTE1MCw2
ICsxNjgsOCBAQCBzdGF0aWMgdm9pZCBzZXR1cF9lZmlfcGNpKHN0cnVjdCBib290X3BhcmFtcyAq
cGFyYW1zKQ0KPiBwYXJhbXMtPmhkci5zZXR1cF9kYXRhID0gKHVuc2lnbmVkIGxvbmcpcm9tOw0K
PiANCj4gZGF0YSA9IChzdHJ1Y3Qgc2V0dXBfZGF0YSAqKXJvbTsNCj4gKw0KPiArIHVwZGF0ZV9u
cl9ncHVzKHBjaSk7DQo+IH0NCj4gfQ0KPiANCj4gQEAgLTIwMywzNyArMjIzLDYgQEAgc3RhdGlj
IHZvaWQgcmV0cmlldmVfYXBwbGVfZGV2aWNlX3Byb3BlcnRpZXMoc3RydWN0IGJvb3RfcGFyYW1z
ICpib290X3BhcmFtcykNCj4gfQ0KPiB9DQo+IA0KPiAtc3RhdGljIGJvb2wgYXBwbGVfbWF0Y2hf
cHJvZHVjdF9uYW1lKHZvaWQpDQo+IC17DQo+IC0gc3RhdGljIGNvbnN0IGNoYXIgdHlwZTFfcHJv
ZHVjdF9tYXRjaGVzW11bMTVdID0gew0KPiAtICJNYWNCb29rUHJvMTEsMyIsDQo+IC0gIk1hY0Jv
b2tQcm8xMSw1IiwNCj4gLSAiTWFjQm9va1BybzEzLDMiLA0KPiAtICJNYWNCb29rUHJvMTQsMyIs
DQo+IC0gIk1hY0Jvb2tQcm8xNSwxIiwNCj4gLSAiTWFjQm9va1BybzE1LDMiLA0KPiAtICJNYWNC
b29rUHJvMTYsMSIsDQo+IC0gIk1hY0Jvb2tQcm8xNiw0IiwNCj4gLSB9Ow0KPiAtIGNvbnN0IHN0
cnVjdCBlZmlfc21iaW9zX3R5cGUxX3JlY29yZCAqcmVjb3JkOw0KPiAtIGNvbnN0IHU4ICpwcm9k
dWN0Ow0KPiAtDQo+IC0gcmVjb3JkID0gKHN0cnVjdCBlZmlfc21iaW9zX3R5cGUxX3JlY29yZCAq
KWVmaV9nZXRfc21iaW9zX3JlY29yZCgxKTsNCj4gLSBpZiAoIXJlY29yZCkNCj4gLSByZXR1cm4g
ZmFsc2U7DQo+IC0NCj4gLSBwcm9kdWN0ID0gZWZpX2dldF9zbWJpb3Nfc3RyaW5nKHJlY29yZCwg
cHJvZHVjdF9uYW1lKTsNCj4gLSBpZiAoIXByb2R1Y3QpDQo+IC0gcmV0dXJuIGZhbHNlOw0KPiAt
DQo+IC0gZm9yIChpbnQgaSA9IDA7IGkgPCBBUlJBWV9TSVpFKHR5cGUxX3Byb2R1Y3RfbWF0Y2hl
cyk7IGkrKykgew0KPiAtIGlmICghc3RyY21wKHByb2R1Y3QsIHR5cGUxX3Byb2R1Y3RfbWF0Y2hl
c1tpXSkpDQo+IC0gcmV0dXJuIHRydWU7DQo+IC0gfQ0KPiAtDQo+IC0gcmV0dXJuIGZhbHNlOw0K
PiAtfQ0KPiAtDQo+IHN0YXRpYyB2b2lkIGFwcGxlX3NldF9vcyh2b2lkKQ0KPiB7DQo+IHN0cnVj
dCB7DQo+IEBAIC0yNDMsNyArMjMyLDcgQEAgc3RhdGljIHZvaWQgYXBwbGVfc2V0X29zKHZvaWQp
DQo+IH0gKnNldF9vczsNCj4gZWZpX3N0YXR1c190IHN0YXR1czsNCj4gDQo+IC0gaWYgKCFlZmlf
aXNfNjRiaXQoKSB8fCAhYXBwbGVfbWF0Y2hfcHJvZHVjdF9uYW1lKCkpDQo+ICsgaWYgKCFlZmlf
aXNfNjRiaXQoKSB8fCBucl9ncHVzIDwgMikNCj4gcmV0dXJuOw0KPiANCj4gc3RhdHVzID0gZWZp
X2JzX2NhbGwobG9jYXRlX3Byb3RvY29sLCAmQVBQTEVfU0VUX09TX1BST1RPQ09MX0dVSUQsIE5V
TEwsDQoNClRoaXMgcGF0Y2ggZG9lcyBub3QgZW5hYmxlIHRoZSBvcyBzZXQgcHJvdG9jb2wgb24g
bXkgTWFjQm9vayBQcm8gMTYgaW5jaCAyMDE5DQoNCmpvdXJuYWxjdGwgLWs6IGh0dHBzOi8vcGFz
dGViaW4uY29tLzdldFd5MEQ1

