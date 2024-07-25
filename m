Return-Path: <linux-efi+bounces-1493-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 917CB93C281
	for <lists+linux-efi@lfdr.de>; Thu, 25 Jul 2024 14:55:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C25E281981
	for <lists+linux-efi@lfdr.de>; Thu, 25 Jul 2024 12:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 289A219AD6C;
	Thu, 25 Jul 2024 12:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="JAbaAVt8"
X-Original-To: linux-efi@vger.kernel.org
Received: from IND01-MAX-obe.outbound.protection.outlook.com (mail-maxind01olkn2079.outbound.protection.outlook.com [40.92.102.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7179F19AD56;
	Thu, 25 Jul 2024 12:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.102.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721912113; cv=fail; b=i8NVM7nxxN4+y5UYMnWkrTfZ1MPascamdlRBOEj04XCyzi6RKmB70ee2pJqNrMFhpjT3i5/wAhJVaE1TTqvWBBariZsRWwsbF8Sv6lxVy99MAXFEjvvu439HwC+f8IMKOi9Jx8+o6tuvBQmBdHNM7f/2laDT/W87o06zx+OsSC8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721912113; c=relaxed/simple;
	bh=xnTqySvwZzQXPTjhCcWvMhxV6BwKe9qSQKd1rVH8Kkw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=b0jiGvXfMWhctno0hERjjQNgdWZ/mhdzDW9wrcgPEvgrLMI8fxQL8KIhxHTG9vNwcIyLhiWXT9rKmuDU4GyjWVpGFgg9SAE+o0jf9PtNtPa876Ncw8Kihms8UJy4FRwxUa6nQBhcMjcSPonQ2pkxnDwkecdCIxx6jDwhXHq1IJg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=JAbaAVt8; arc=fail smtp.client-ip=40.92.102.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XRE/A5DTN0boT+dtz7qnGeDhqNW+T551V/s/s1pZlyAQ7684eHIsEYQmIlgSFziQF989M1y3PYwh2/+rBnsgQL+Dw3KPI9UMjlGLiSz1wMdss3GSHtdQkiUALVB2lBU7Yrn/OdfyZbWgh5vPAHAImyHjpTsHu9+eyjE2bayptGeIqLkpxdno+qj+UvE6Q7kXKWVbZzj7UnsDm/zH37y5qQmkBRrH5mdlSopy5ufSiFTAQufX5CQ6gALmKj9o8EG0qyKVP8WKXiy+5dXGrR61/Zpzh7JqeVaadDH56fPIefJaaieJ0ttc1oKcUi8y9oVnxkT+W3Ojr6ffgjL7ZCT+wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xnTqySvwZzQXPTjhCcWvMhxV6BwKe9qSQKd1rVH8Kkw=;
 b=B915JIXR8hYXocKdQrKcfRy1h0PJuZ2hU3LgYyzs8Cn2j/YO/ZbI4mGl929poI78dueKU+GsLX9+m99X0LEIK+aTCREAxK/ukN+Y4eQhoSLouxgDXH8miQT+iTb+ri4nGvkO2Wqhth/d7HuqxIau2ncgZGJy5vW2n3LqLMDA1W31LNI2m62B1FZfRAD9gr37m4N9AW1STVIHf2qp5458dP/Q/4dZatMPW6HUIsqguG0fonZuvR8q8NifhHKVDVQRBauyf4fd0IqL1DYUMpPJI+r45kSfu6l3BPzaL4IpKZ/Ljty7LnuuJepdcPfq0cAH5G5YH2kA2JnnyINTUyHmyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xnTqySvwZzQXPTjhCcWvMhxV6BwKe9qSQKd1rVH8Kkw=;
 b=JAbaAVt8RVWH7ytA7g4SEmWN9ayx/npa2Whv0eLCDipGa/5v9d9zzlZsBjCfwX41l6D47iWyY2D/1EuXz4hCPG12dZANTKEITPTltzQISmBH9H9IcfW9aMXQKJNAvJ4jY/WUIsNADLAzkPL9cwiCkOlHgUx+LQMCD3537aJv1ljToM0+oiuvkVtGhVznFvHh1yVKOwiOKQCVzObxD07Y8QKthnwfXrYP03TxSBk9J4CQ94xASdRjldHHz1jaCGSHV3oZJMZlUaJZ/ghuMrJxD4d406tzPX2cpI0XLqxX8np8dIne8BVx/CVhVzBMNS2zFqm1hOMd59X6Ha9Fr3br8A==
Received: from MA0P287MB0217.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:b3::9) by
 MA0P287MB1573.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:f3::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7784.28; Thu, 25 Jul 2024 12:55:05 +0000
Received: from MA0P287MB0217.INDP287.PROD.OUTLOOK.COM
 ([fe80::98d2:3610:b33c:435a]) by MA0P287MB0217.INDP287.PROD.OUTLOOK.COM
 ([fe80::98d2:3610:b33c:435a%4]) with mapi id 15.20.7784.017; Thu, 25 Jul 2024
 12:55:04 +0000
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
 AQHay8BxbD/3780MxUWT4The9rzhebHiRiV0gBjw9fOAACgFAIAJQwrwgAGLugCAAAc4MYABUs+AgAAEUso=
Date: Thu, 25 Jul 2024 12:55:04 +0000
Message-ID:
 <MA0P287MB02171F5A778A16D6D3181AE6B8AB2@MA0P287MB0217.INDP287.PROD.OUTLOOK.COM>
References: <20240701140940.2340297-4-ardb+git@google.com>
 <MA0P287MB0217C0F7E0B9F6FE8CA47BE8B8D32@MA0P287MB0217.INDP287.PROD.OUTLOOK.COM>
 <MA0P287MB0217E3B4810704C504F13F2CB8A32@MA0P287MB0217.INDP287.PROD.OUTLOOK.COM>
 <ZpgUVjjj3naBGtfO@wunner.de>
 <MA0P287MB02178F503AA69E1F570E9753B8A92@MA0P287MB0217.INDP287.PROD.OUTLOOK.COM>
 <ZqElRH38f_XV3fKK@wunner.de>
 <MA0P287MB021789D73CAD62C16BCF0306B8AA2@MA0P287MB0217.INDP287.PROD.OUTLOOK.COM>
 <CAMj1kXFjQKCBd78y=n9MA+gzitotskye4uYz+dAaUBT=_r8ZsQ@mail.gmail.com>
In-Reply-To:
 <CAMj1kXFjQKCBd78y=n9MA+gzitotskye4uYz+dAaUBT=_r8ZsQ@mail.gmail.com>
Accept-Language: en-IN, en-US
Content-Language: en-IN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn: [MdnCRjAKwtjmmKd2ie+QUwM47ziFa+6JWyCBsO+7ibDugz+u7WAJJuqHuga1gB4p]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MA0P287MB0217:EE_|MA0P287MB1573:EE_
x-ms-office365-filtering-correlation-id: a5ecdf18-9bfb-493c-4904-08dcaca90118
x-ms-exchange-slblob-mailprops:
 WaIXnCbdHrORrPiYp+O3K2PHowtbVet0Yo6ACtfBMzqym/55cD4S/glMV9ENbPFpyWPMca8PCuQm8LsBQQUM2ZKs8awWsFmDKNmIS+U8SPvYIvZER5NKwX8gVtyye8Gww2CC1xcncii0NZhL2zW9QQ9Ndea/RUn9e8Qyogl9sT7d/7qYudUM6Jrqt4N42f4XUCACzieyhlMwE4vqBNN8w9T+vJF1y+9Zz/3wQfkPS7GY40u+eMG+enLMMB2JVzpHVH85wvOLHtdIv4X9wt8jWS96nMQp8dR7n++Z/T7+8TRL4ZJIrNwrzZg0U+lAk/6V3DoLJh1qRM+lg0M9xTAFCyDgdQAZtqRZw90Zy5NjofEoTZjaGLWBYtvekroZMO5zEsVo9WvGzXoF5fh30yMaeerebOu3ltxOrWbsQk5uF0pyRNDrOT10+SBVvxN/iMBgaTyWFGWaPz+gbB6CmDKkTUGygSkYOBSohy69WHUysYHu0xev7Urorq1eih2O0zmZkeH4ILFSSrUTcyXhnfBCVTn23RYUjALgC5z0KjZnxVzvUJdnJjkB3bHPUy+QiEcPKEqvnRZRbFe2pApDLaZV4HGfevqBPgDUdHEJ30L+7tLgAZxJGnTka3bcvbtqQtY9Bx4PdqfXNKIT/B8674YufgUs/NuOhFG2/0xFY7aIEiGa+OG/5YlZqPtx26o1IMGe2gpORt5srueMitsjyVl4nFwHkAqZcKflqV26H38Wr75yVb5lJ6JaV7Fftdc5Nzniwu5JXFZaATA=
x-microsoft-antispam:
 BCL:0;ARA:14566002|19110799003|8060799006|461199028|1602099012|440099028|3412199025|4302099013|102099032;
x-microsoft-antispam-message-info:
 Kt5aqnn7x+vWe52NiHmnw2xXmStKvr0Z8c65jXiodVK6pU9Lvzq673HcZp3RJBFeRU+vOg1bW2B3/2noyLsmBiX0nZCm4MW34rjjgO85exY2dcS9Imgtb2f95ZMptWr2CbaQA+ljXzPgP8gqMEYlYd4Ul/2af7sZ1dKnCyO/o52xVZ+SEHae8LqXsxh1A4QUIPIF4z6KvDVyP3ccU2/I5Qh89+DotQQ58YK9ui4QMN05sfFhn/Y+jqsyQvHU4xDhIEQvkccE1m5mcgU9xyDVS0HuK4XMXOsyNR2L08tTrU7CK8Q9c0X1cjO1Ij0hiZIDElvLsxsO1SBtEw+6h92R8Tb+UEq3GWtoMQ8Ilo3M4yErXYeAuHRjT5fGgmFf6ENpRIYnegMlT+Zsv0v0AoBjUtIjxuEz5RTCeiuBNA22JsOLl+zyyKm2XCZGADyn1lk9pWyMWscy657Mim0UCHXuH4n+KB6rxyPaBkqfvqzi/X8Tr3c6lFhlnqEmMSI6z6eM6lUVEt16VoaVKjyeq2CyE7w7wx6mlKwITRn4zZNENZNu0Muw6buC6kQ3az6fYQbHztlSfonFOMKzfzv7Xgg7PHWpxchOxSgrmXtSPwmddhQx7Ff4gixbJ9rkXzonfbJZFKSnbx9mkeOmWJMl7lAnsPkMdl9hgJyg1IvAQj0tK30Jat2LKAa/EL46ygtrDa3VannrC5dkn5aqJNLp0+fJzDTvnIVS6mt74fGvarTr91HZOnAJhM34ZuQioIoevhGV
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NVpBODFUWVpVNTBWS1VtNC96MENZcHVTZUpKVGczTW5GOTlaWFJLcjhWQ3hn?=
 =?utf-8?B?M2RzQkoza05TNGNhSkxDVmxTdW9yYzdZZDJxU1o3WWlweXE4cjQxcTJaTVo1?=
 =?utf-8?B?SFRCOHJNV3NLWG9KYm9ScWRSK2RlNTNBRWxrZUJuTXRYYktHNEJ6TUhOUVYz?=
 =?utf-8?B?ZDUwcTZTZVFEM1lYUlhZVFRLZzJSYXRYMWx1TTRvT2ZRYlhCTmNJcldWV2pz?=
 =?utf-8?B?WjhaRXd2Sm4vR1NtVVZOZCtMeTd2TkRuTW5yekMyV045bEtZNFVlNjVTSjJq?=
 =?utf-8?B?RzJ0aVd6RmptVFFyOGUxY1BnSW5lU3NWdllPZ3BjVHREUksra0pCUTdCUzFP?=
 =?utf-8?B?RnNQR2E1OHFkT1pZdkdXdDFYTjNHTjFNZHB2ZlNVN2FBZVBxYmtSRHlwZ2RP?=
 =?utf-8?B?YWtxSFNEM2JwSmJSV3o1UHkrNnVQdnNNZURpc0Fha2RNYzdMU2Zhd3dkc3N6?=
 =?utf-8?B?WFJqc1I3cWEydS8wSmh6TzBFdVJNRGN1SlF1QVFxZXRNajNZbHFtWUhORzdz?=
 =?utf-8?B?elVLNXd5TUozb2l1ZXlhZCtZbXNvN1lxKzJkTFRraU5XWjVMUS80TXJhTmpT?=
 =?utf-8?B?OWRvUTM1U09nTkMyenVhM0xnZldDMkY0QmhhZzl6U3I5R0lxYTF0eW9WY1N0?=
 =?utf-8?B?T2FYNi9KbWxnQVRxTUF3OUpBN0VrYm41QkFkTTQ4WFpYOWwyb2NIb1YycUdU?=
 =?utf-8?B?ZytlT2xUM21JTVkzTDBpTTBpbHR6VGlVVXBwM0JucGxTQVhLYW1FbHpUd1Jr?=
 =?utf-8?B?dXlTUHcxTm1mbEQrOVZSTmwwNEp3b2djUUQxbDVkbnJtekU2VnpUQ1BKaHF5?=
 =?utf-8?B?bDNXZW9FQjhxcndzY0I1UlhZR1NUZ2lyVllWY3Y5RVo3b3BqTytyMkdldTJL?=
 =?utf-8?B?WjJLNFl1MXVYTmttcGJENVhBT3JWVzVXSFpyQjE5dlpVYU83L0lRMW82ajJH?=
 =?utf-8?B?RHVvclEydTdHdHJtYlJrRXF2dTRVdUNMMkc1cjlkbnp1dmo2TS83UWdSTUY5?=
 =?utf-8?B?NW1nUXp4cjI4Q1YwTFlnSXBnZDV3aU1kVS9qMXZRU3Z5dTNNSVRnMHNLbmhU?=
 =?utf-8?B?aXUwVFl5K0Q4SFJnc0xvcnZJVDRTb2QraFJaZGdSaThMVEdDYlZGamNQeXQ4?=
 =?utf-8?B?Q1IzU1Zucjg2KzdPbWNQY2tXRHJxdnJZZEdKZmxaYlkyZ05vT3IrV3F6ankv?=
 =?utf-8?B?ODhXb0F0SkxRWElRaWNRL0tRemJ1WE50S1k1WWxVY3VFM2ozSlNsRTlsamNa?=
 =?utf-8?B?TW14ZEhMZ0hoTTRpdnF6MGF1RG9scDdRQ2kzakxLOU5ONUR3djNHZmVCSmFI?=
 =?utf-8?B?bEc4Nzl1MGwzTEtlU0FjM083L1k3Tnl3V3JSRVJSUUVQcUF2WXF3MGNtdnhk?=
 =?utf-8?B?Qjl5NVZhTzRJcDB1cUZHUFFqMHg3NkYwSTdLU1R5VWlENG9renNCQVhFQ0Qw?=
 =?utf-8?B?SlV6Yk5TUHpFWFNYd1A1ZmxlZmFQNyttQzlqZDZGdmVyTHdjVEN4YW0wYm5B?=
 =?utf-8?B?YzI1Y1NmQjZ4QmZhOTNja2JzdXNEaTR2ZnF5MnFsQ1I3NmtrS1ZPMmVhY0tu?=
 =?utf-8?B?dHgzMHhQM2UwZDVDVlJxN20ydFhUZkt5YWl2V016cDFZT0lyTnZKOFZTOTZk?=
 =?utf-8?B?Mjhiem1BYkhWRm5xMEhRVlZIdnZmSmN5Qm9yMlJMaE1yalFHVTgzWEwvcWFW?=
 =?utf-8?B?YmIzQ2ZGTmlwampkZGNkb3JBQnNQVk9PN3FVOEpxNHZCVTJ3ektoVmhqbTZz?=
 =?utf-8?Q?7Umd6rauQheIL9bx+k=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a5ecdf18-9bfb-493c-4904-08dcaca90118
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2024 12:55:04.7218
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0P287MB1573

DQoNCj4gT24gMjUgSnVsIDIwMjQsIGF0IDY6MDnigK9QTSwgQXJkIEJpZXNoZXV2ZWwgPGFyZGJA
a2VybmVsLm9yZz4gd3JvdGU6DQo+IA0KPiDvu79PbiBXZWQsIDI0IEp1bCAyMDI0IGF0IDE4OjI3
LCBBZGl0eWEgR2FyZyA8Z2FyZ2FkaXR5YTA4QGxpdmUuY29tPiB3cm90ZToNCj4+IA0KPj4gDQo+
PiANCj4+Pj4gT24gMjQgSnVsIDIwMjQsIGF0IDk6MzHigK9QTSwgTHVrYXMgV3VubmVyIDxsdWth
c0B3dW5uZXIuZGU+IHdyb3RlOg0KPj4+IA0KPj4+IO+7v09uIFR1ZSwgSnVsIDIzLCAyMDI0IGF0
IDA0OjI1OjE5UE0gKzAwMDAsIEFkaXR5YSBHYXJnIHdyb3RlOg0KPj4+Pj4gT24gV2VkLCBKdWwg
MTcsIDIwMjQgYXQgMDQ6MzU6MTVQTSArMDAwMCwgQWRpdHlhIEdhcmcgd3JvdGU6DQo+Pj4+PiBG
b3IgdGhlIE1hY3MgaGF2aW5nIGEgc2luZ2xlIEdQVSwgaW4gY2FzZSBhIHBlcnNvbiB1c2VzIGFu
IGVHUFUsDQo+Pj4+PiB0aGV5IHN0aWxsIG5lZWQgdGhpcyBhcHBsZS1zZXQtb3MgcXVpcmsgZm9y
IGh5YnJpZCBncmFwaGljcy4NCj4+Pj4gDQo+Pj4+IFNlbmRpbmcgdGhpcyBtZXNzYWdlIGFnYWlu
IGFzIGZvciBzb21lIHJlYXNvbiBpdCBnb3Qgc2VudCBvbmx5IHRvIEx1a2FzOg0KPj4+PiANCj4+
Pj4gRnVsbCBtb2RlbCBuYW1lOiBNYWMgbWluaSAoMjAxOCkgKE1hY21pbmk4LDEpDQo+Pj4+IA0K
Pj4+PiBUaGUgZHJpdmUgbGluayBiZWxvdyBoYXMgdGhlIGxvZ3M6DQo+Pj4+IA0KPj4+PiBodHRw
czovL2RyaXZlLmdvb2dsZS5jb20vZmlsZS9kLzFQMy1HbGtzVTZXcHB2enZXQzBBLW5Bb1RaaDdv
UFB4ay92aWV3P3VzcD1kcml2ZV9saW5rDQo+Pj4gDQo+Pj4gU29tZSBvYnNlcnZhdGlvbnM6DQo+
Pj4gDQo+Pj4gKiBkbWVzZy13aXRoLWVncHUudHh0OiAgSXQgc2VlbXMgdGhlIHN5c3RlbSB3YXMg
YWN0dWFsbHkgYm9vdGVkICp3aXRob3V0Kg0KPj4+IGFuIGVHUFUsIHNvIHRoZSBmaWxlbmFtZSBh
cHBlYXJzIHRvIGJlIGEgbWlzbm9tZXIuDQo+Pj4gDQo+Pj4gKiBUaGUgdHdvIGZpbGVzIGluIHRo
ZSB3aXRoX2FwcGxlX3NldF9vc19lZmkgZGlyZWN0b3J5IG9ubHkgY29udGFpbg0KPj4+IGluY29t
cGxldGUgZG1lc2cgb3V0cHV0LiAgQm9vdCB3aXRoIGxvZ19idWZfbGVuPTE2TSB0byBzb2x2ZSB0
aGlzLg0KPj4+IEZvcnR1bmF0ZWx5IHRoZSB0cnVuY2F0ZWQgbG9nIGlzIHN1ZmZpY2llbnQgdG8g
c2VlIHdoYXQncyBnb2luZyBvbi4NCj4+PiANCj4+PiAqIElmIHRoZSBhcHBsZV9zZXRfb3MgcHJv
dG9jb2wgaXMgbm90IHVzZWQsIHRoZSBhdHRhY2hlZCBlR1BVIGlzIG5vdA0KPj4+IGVudW1lcmF0
ZWQgYnkgdGhlIGtlcm5lbCBvbiBib290IGFuZCBhIHJlc2NhbiBpcyByZXF1aXJlZC4NCj4+PiBT
byBuZWl0aGVyIHRoZSBpR1BVIG5vciB0aGUgZUdQVSBhcmUgd29ya2luZy4gIFRoZSByZWFzb24g
aXMgQklPUw0KPj4+IHNldHMgdXAgaW5jb3JyZWN0IGJyaWRnZSB3aW5kb3dzIGZvciB0aGUgVGh1
bmRlcmJvbHQgaG9zdCBjb250cm9sbGVyOg0KPj4+IEl0cyB0d28gZG93bnN0cmVhbSBwb3J0cycg
NjQtYml0IHdpbmRvd3Mgb3ZlcmxhcC4gIFRoZSAzMi1iaXQgd2luZG93cw0KPj4+IGRvIG5vdCBv
dmVybGFwLiAgSWYgYXBwbGVfc2V0X29zIGlzIHVzZWQsIHRoZSBlR1BVIGlzIHVzaW5nIHRoZQ0K
Pj4+IChub24tb3ZlcmxhcHBpbmcpIDMyLWJpdCB3aW5kb3cuICBJZiBhcHBsZV9zZXRfb3MgaXMg
bm90IHVzZWQsDQo+Pj4gdGhlIGF0dGFjaGVkIGVHUFUgaXMgdXNpbmcgdGhlIChvdmVybGFwcGlu
ZywgaGVuY2UgYnJva2VuKSA2NC1iaXQgd2luZG93Lg0KPj4+IA0KPj4+IFNvIG5vdCBvbmx5IGlz
IGFwcGxlX3NldF9vcyBuZWVkZWQgdG8ga2VlcCB0aGUgaUdQVSBlbmFibGVkLA0KPj4+IGJ1dCBh
bHNvIHRvIGVuc3VyZSBCSU9TIHNldHMgdXAgYnJpZGdlIHdpbmRvd3MgaW4gYSBtYW5uZXIgdGhh
dCBpcw0KPj4+IG9ubHkgaGFsZndheSBicm9rZW4gYW5kIG5vdCB0b3RhbGx5IGJyb2tlbi4NCj4+
PiANCj4+PiBCZWxvdywgMDAwMDowNjowMS4wIGFuZCAwMDAwOjA2OjA0LjAgYXJlIHRoZSBkb3du
c3RyZWFtIHBvcnRzIG9uIHRoZQ0KPj4+IFRodW5kZXJib2x0IGhvc3QgY29udHJvbGxlciBhbmQg
MDAwMDowOTowMC4wIGlzIHRoZSB1cHN0cmVhbSBwb3J0IG9mDQo+Pj4gdGhlIGF0dGFjaGVkIGVH
UFUuDQo+Pj4gDQo+Pj4gaUdQVSBlbmFibGVkLCBubyBlR1BVIGF0dGFjaGVkIChkbWVzZy50eHQp
Og0KPj4+IHBjaSAwMDAwOjA2OjAxLjA6ICAgYnJpZGdlIHdpbmRvdyBbbWVtIDB4ODE5MDAwMDAt
MHg4ODhmZmZmZl0NCj4+PiBwY2kgMDAwMDowNjowMS4wOiAgIGJyaWRnZSB3aW5kb3cgW21lbSAw
eGIxNDAwMDAwLTB4YjgzZmZmZmYgNjRiaXQgcHJlZl0NCj4+PiBwY2kgMDAwMDowNjowNC4wOiAg
IGJyaWRnZSB3aW5kb3cgW21lbSAweDg4OTAwMDAwLTB4OGY4ZmZmZmZdDQo+Pj4gcGNpIDAwMDA6
MDY6MDQuMDogICBicmlkZ2Ugd2luZG93IFttZW0gMHhiODQwMDAwMC0weGJmM2ZmZmZmIDY0Yml0
IHByZWZdDQo+Pj4gDQo+Pj4gaUdQVSBkaXNhYmxlZCwgZUdQVSBhdHRhY2hlZCwgYXBwbGVfc2V0
X29zIG5vdCB1c2VkIChqb3VybmFsY3RsLnR4dCk6DQo+Pj4gcGNpIDAwMDA6MDY6MDEuMDogICBi
cmlkZ2Ugd2luZG93IFttZW0gMHg4MTkwMDAwMC0weDg4OGZmZmZmXQ0KPj4+IHBjaSAwMDAwOjA2
OjAxLjA6ICAgYnJpZGdlIHdpbmRvdyBbbWVtIDB4YjE0MDAwMDAtMHhjNmZmZmZmZiA2NGJpdCBw
cmVmXQ0KPj4+IHBjaSAwMDAwOjA2OjA0LjA6ICAgYnJpZGdlIHdpbmRvdyBbbWVtIDB4ODg5MDAw
MDAtMHg4ZjhmZmZmZl0NCj4+PiBwY2kgMDAwMDowNjowNC4wOiAgIGJyaWRnZSB3aW5kb3cgW21l
bSAweGI4NDAwMDAwLTB4YmYzZmZmZmYgNjRiaXQgcHJlZl0NCj4+PiBwY2kgMDAwMDowNjowNC4w
OiBicmlkZ2Ugd2luZG93IFttZW0gMHhiODQwMDAwMC0weGJmM2ZmZmZmIDY0Yml0IHByZWZdOiBj
YW4ndCBjbGFpbTsgYWRkcmVzcyBjb25mbGljdCB3aXRoIFBDSSBCdXMgMDAwMDowOSBbbWVtIDB4
YjE0MDAwMDAtMHhiZjNmZmZmZiA2NGJpdCBwcmVmXQ0KPj4+IA0KPj4+IGlHUFUgZW5hYmxlZCwg
ZUdQVSBhdHRhY2hlZCwgYXBwbGVfc2V0X29zIHVzZWQgKHdvcmtpbmctam91cm5hbGN0bC50eHQp
Og0KPj4+IHBjaSAwMDAwOjA2OjAxLjA6ICAgYnJpZGdlIHdpbmRvdyBbbWVtIDB4ODE5MDAwMDAt
MHg4ODhmZmZmZl0NCj4+PiBwY2kgMDAwMDowNjowMS4wOiAgIGJyaWRnZSB3aW5kb3cgW21lbSAw
eGIxNDAwMDAwLTB4YzZmZmZmZmYgNjRiaXQgcHJlZl0NCj4+PiBwY2kgMDAwMDowNjowNC4wOiAg
IGJyaWRnZSB3aW5kb3cgW21lbSAweDg4OTAwMDAwLTB4OGY4ZmZmZmZdDQo+Pj4gcGNpIDAwMDA6
MDY6MDQuMDogICBicmlkZ2Ugd2luZG93IFttZW0gMHhiODQwMDAwMC0weGJmM2ZmZmZmIDY0Yml0
IHByZWZdDQo+Pj4gcGNpIDAwMDA6MDk6MDAuMDogICBicmlkZ2Ugd2luZG93IFttZW0gMHg4MTkw
MDAwMC0weDgxY2ZmZmZmXQ0KPj4+IA0KPj4+ICogQXMgdG8gaG93IHdlIGNhbiBzb2x2ZSB0aGlz
IGFuZCBrZWVwIHVzaW5nIGFwcGxlX3NldF9vcyBvbmx5IHdoZW4NCj4+PiBuZWNlc3Nhcnk6DQo+
Pj4gDQo+Pj4gSSBub3RlIHRoYXQgb24geDg2LCB0aGUgZWZpc3R1YiB3YWxrcyBvdmVyIGFsbCBQ
Q0kgZGV2aWNlcyBpbiB0aGUgc3lzdGVtDQo+Pj4gKHNlZSBzZXR1cF9lZmlfcGNpKCkgaW4gZHJp
dmVycy9maXJtd2FyZS9lZmkvbGlic3R1Yi94ODYtc3R1Yi5jKSBhbmQNCj4+PiByZXRyaWV2ZXMg
dGhlIERldmljZSBJRCBhbmQgVmVuZG9yIElELiAgV2UgY291bGQgYWRkaXRpb25hbGx5IHJldHJp
ZXZlDQo+Pj4gdGhlIENsYXNzIENvZGUgYW5kIGNvdW50IHRoZSBudW1iZXIgb2YgR1BVcyBpbiB0
aGUgc3lzdGVtIGJ5IGNoZWNraW5nDQo+Pj4gd2hldGhlciB0aGUgQ2xhc3MgQ29kZSBtYXRjaGVz
IFBDSV9CQVNFX0NMQVNTX0RJU1BMQVkuICBJZiB0aGVyZSdzDQo+Pj4gYXQgbGVhc3QgMiBHUFVz
IGluIHRoZSBzeXN0ZW0sIGludm9rZSBhcHBsZV9zZXRfb3MuDQo+PiANCj4+IFRoaXMgYWxzbyBs
b29rcyBsaWtlIGEgZ29vZCBpZGVhLCBidXQgSSdtIG5vdCB3ZWxsIGF3YXJlIG9mIHRoZSBwY2kg
cXVpcmtzIGluIHRoZSBMaW51eCBrZXJuZWwuIFNvLCB3b3VsZCBjb25zaWRlciBpdCBhIGJ1ZyBy
ZXBvcnQgZm9yIHRoZSBtYWludGFpbmVycyB0byBmaXguDQo+IA0KPiBUaGF0IGlzIG5vdCBob3cg
aXQgd29ya3MuDQo+IA0KPiBUaGlzIGlzIG5vdCBhIHJlZ3Jlc3Npb24gaW4gTGludXgsIGFuZCBl
dmVuIGlmIGl0IHdhcywgaXQgaXMgbm90IHRoZQ0KPiBtYWludGFpbmVycycgam9iIHRvIGZpeCBi
dWdzLg0KPiANCj4gSWYgTGludXggaXMgbGFja2luZyBmdW5jdGlvbmFsaXR5IHRoYXQgeW91IGZp
bmQgaW1wb3J0YW50LCBwbGVhc2UNCj4gcHJvcG9zZSBhIHBhdGNoIHRoZSBpbXBsZW1lbnRzIGl0
LCBhbmQgYXJndWUgd2h5IGl0IHNob3VsZCBiZSBtZXJnZWQuDQoNCkhpIEFyZA0KDQpJIGJlbGll
dmUgTGludXggbmVlZHMgdGhlIGZ1bmN0aW9uYWxpdHkgdG8gYmUgYWJsZSB0byBwcm9wZXJseSB1
c2UgZUdQVXMgb24gTWFjcy4gU2luY2UgdGhlIGRhdGEgYXZhaWxhYmlsaXR5IG9uIHRoZXNlIE1h
Y3MgaXMgdG9vIGxvdyBhbmQgbm90IGNsZWFyLCBJIGJlbGlldmUgd2Ugc2hvdWxkIGJlIGF0bGVh
c3QgYmUgYWJsZSB0byBlbmFibGUgdGhpcyBmcm9tIHVzZXJzcGFjZSBhcyB3ZWxsLiBNYXliZSB3
ZSBjYW4gZG8gc29tZXRoaW5nIGxpa2U6DQoNCjEuIEFkZCAnZWZpPWVuYWJsZV9hcHBsZV9zZXRf
b3MnIGFuZCAnZWZpPWRpc2FibGVfYXBwbGVfc2V0X29zJyB0byBlZmktc3R1Yi1oZWxwZXIuYyAo
SSBjYW4gbWFrZSBhIHBhdGNoIGZvciB0aGUgc2FtZSkuDQoyLiBVc2UgYW4gTlZSQU0gdmFyaWFi
bGUgYXMgc3VnZ2VzdGVkIGJ5IHlvdSAoV291bGQgbmVlZCBoZWxwIGZvciB0aGlzKS4NCg0KSWYg
eW91IGZpbmQgYW55IG9mIHRoZSBvcHRpb24gb3V0IG9mIHRoZXNlIGFjY2VwdGFibGUsIEknbGwg
c3RhcnQgd29ya2luZyBvbiB0aGVtLg==

