Return-Path: <linux-efi+bounces-1323-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1316D91D169
	for <lists+linux-efi@lfdr.de>; Sun, 30 Jun 2024 13:25:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EE861F2127D
	for <lists+linux-efi@lfdr.de>; Sun, 30 Jun 2024 11:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD41C13AA35;
	Sun, 30 Jun 2024 11:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="jUpCF+uF"
X-Original-To: linux-efi@vger.kernel.org
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01olkn2100.outbound.protection.outlook.com [40.92.103.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86F128DC1;
	Sun, 30 Jun 2024 11:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.103.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719746712; cv=fail; b=lT404GUVQV3Pf2Vb1GaVNGfjHE6aY60YIH36763rUzY9/7nA45ox2r5hMAeStxNVQWJaF8P9MA5WifarLJorTGIL3RyfoW0alxPHNzP8eGNsLuZNHKvfRR8KjjAgKC0hnlhHYIykUZmNkrA5cUC03la+0Y1ESI002RKgx2CkjNk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719746712; c=relaxed/simple;
	bh=6Zxyc0iglSanLrLOG8nCwDt28XGVeBeH9KDd3lQIjjM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MB6C4CUUHq+MUQky4tZN7+RH0yisdtiEwc+a0gXPvMRAMDERqyJ9LT/OLu61zADxrs9wNX8QcUdEty3pwhxnvkrdEuKxMzW6eJKW4UkO9MhFqrNSJffBdBUMRRv05B+A6hy2FQ0PCrxNO4Wc9tSH8GA/n5qXtqzdLjX+tvEc5ng=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=jUpCF+uF; arc=fail smtp.client-ip=40.92.103.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QIuWmi+k4Un74b23pl7XeLW9RuJt5g/Q1RsSrzKyJPoz4We+Bm3fFeDQ8q211Vh0qbPlVfOAOtWr1Sn11H9xxTcwPuqY2OkIBuNSQCRkDM/6maD/ZwJJ/kf1D52Llmk54B6VUHE3YNDa4HAIxUyadJ0qxPjY3RQtmO8xc5DPC85ecu7+JjKDvTIAZgoSp9SBZyo0FGWJX01XszFYTCmlFBY5gYC2otJWqkZfCabAJQHc2stPgxKZPlXtUYvYffl/FNP1uZSxOC/Kg7Pb5n+AAQlyj4gK8T+lJ5+g4u1rexvwK8V+HtK6b9W6lUI/M5ZENPJxlYBvfq7BYapyfC93Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Zxyc0iglSanLrLOG8nCwDt28XGVeBeH9KDd3lQIjjM=;
 b=clGJBmM8fjb9j97vBppyPkhR1JX/eZAYQg9PuRJGa8Aka92J2fL6wMFIZRE6Ka9Iq0Q2K2/bWMNMhppAJpal7UuOzTBTTvF9qZ0kCywFF3MrTDkdeFCPMMSJkbgf8FpuP89yeIo1rfmfxkP6HaS5WC7FNnnzDbPd14UwRT7aSdqi2dCV3pqqDqQGmToB4tPrVIHJXRUJb4SO7b5SAan4Nj6A57Y5YMoGzv/8HGsGQZ+VRhE3zmXmzdxvxS7KyHAaAtLdHT9eDMq2iYbTuSqt8zs0Lk8FIi/7AHVaePdeO95zWVOAgnH+oP8WMmYXtZXWkSbkVaH+g8TMRiwzZJcluA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Zxyc0iglSanLrLOG8nCwDt28XGVeBeH9KDd3lQIjjM=;
 b=jUpCF+uF6Uxo3LGVUZcc3Jud0tG/MQaL9HtCATAu8tLg0ajDvzozMkp7VGiWsQRrh4tSyA1/HFap+rKM0YuoFH5s3bC4YvcKJFJzZyjlseqBqmANppjfekDbS6IH+wa1kXMPnp7C7y81KgvvJHaHVuiQynpc/TrUNIvionhdUyfBnzbt63Te9y86nAjoaQjSY+NxIfY0U+WN3VSpzsYcrhfR5rPOtt7nVwHcY5Jd4hQhILaEi/B595G1Slz4Do5OigrUNHSUXsB7LwCMPdV1CuInOyQT2rtfDuVwhRykfHduRL9/6ZwlCYXwWtZDs3Lirg13pTs4xZNBj7kczFKGxg==
Received: from MA0P287MB0217.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:b3::9) by
 MA0P287MB2038.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:123::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7719.29; Sun, 30 Jun 2024 11:25:04 +0000
Received: from MA0P287MB0217.INDP287.PROD.OUTLOOK.COM
 ([fe80::98d2:3610:b33c:435a]) by MA0P287MB0217.INDP287.PROD.OUTLOOK.COM
 ([fe80::98d2:3610:b33c:435a%7]) with mapi id 15.20.7719.028; Sun, 30 Jun 2024
 11:25:04 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Orlando Chamberlain <orlandoch.dev@gmail.com>
CC: Lukas Wunner <lukas@wunner.de>, Ard Biesheuvel <ardb@kernel.org>, Hans de
 Goede <hdegoede@redhat.com>, "linux-efi@vger.kernel.org"
	<linux-efi@vger.kernel.org>, Linux Kernel Mailing List
	<linux-kernel@vger.kernel.org>, Kerem Karabay <kekrby@gmail.com>
Subject: Re: [PATCH] efi: libstub: add support for the apple_set_os protocol
Thread-Topic: [PATCH] efi: libstub: add support for the apple_set_os protocol
Thread-Index:
 AQHayqf5aNOCBZ38jE+N2QIS72Io3bHf8v+AgAATQSOAAA2MgIAADZDGgAAD+ACAAAWqKQ==
Date: Sun, 30 Jun 2024 11:25:04 +0000
Message-ID:
 <MA0P287MB0217C3BBB2559532E07D6827B8D22@MA0P287MB0217.INDP287.PROD.OUTLOOK.COM>
References: <EBE51900-DA87-4113-B389-80B9C9160F0F@live.com>
 <ZoERl1PWoc2xDGWz@wunner.de>
 <MA0P287MB021730971A804FB760463A39B8D22@MA0P287MB0217.INDP287.PROD.OUTLOOK.COM>
 <ZoEtG0DUJOS4ROQC@wunner.de>
 <MA0P287MB0217B3F9B9E1CFA54FAD96CEB8D22@MA0P287MB0217.INDP287.PROD.OUTLOOK.COM>
 <CADfWnbYVko8R1WHuDugEp4_HzrfHRJH8G2Fk_Orxbt1UL+E8KQ@mail.gmail.com>
In-Reply-To:
 <CADfWnbYVko8R1WHuDugEp4_HzrfHRJH8G2Fk_Orxbt1UL+E8KQ@mail.gmail.com>
Accept-Language: en-IN, en-US
Content-Language: en-IN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn: [FjplWiLE0tTcwTvEWydXpm/1xOUCjLGIQT3NlACi459xKeOHkHvL2yiTbxkeFb7+]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MA0P287MB0217:EE_|MA0P287MB2038:EE_
x-ms-office365-filtering-correlation-id: 070b3041-c5f3-4e79-07be-08dc98f749c2
x-microsoft-antispam:
 BCL:0;ARA:14566002|8060799006|461199028|4302099013|102099032|3412199025|440099028|1602099012;
x-microsoft-antispam-message-info:
 b9ezvkH1BhjayU7I2ykFOSzRC0hzOlKPiCjuMfI4ULshmaAuIe74AL6COV9rgqyp/c6vuSY/rnz0hQQcy0BpLFDNCjo8NGOGdYW1EPwDnIJccRjMQVGgE9rkO4GGdTE+vThVDBhbQBUdEFNdkXEvbMeM4OaZ4DuVOFnvud8q4r3+ZLGp4d2X6fWqufzCXsjgR9stB6ln5guyStkcOVoH14xGKqWs5BSlg1vYpeYzCSfm9ytujbqsBaU1aM9Ce77seTmQg+m8frxCZopQKMacN+xn6cck5zYbZJNDgiFa1PlFFau2NHXpnUQ+eX7koeFmJtvlEDBjzPW7UNr/wH6Ib1n0LyolHoKOt4HAuEZM1HMujrZXCYpzg8UpDykCr9QUUG9QRWBx0/MA01bdmWo5kfGtXnvi4mKYjvTAhcNtG0PPGUiGCSdzcUxq/qr+XOdywJwo7G9sTUCeb2/68Y9ZNp3YDZugS5UYzgD6GLjhResGeTaq5I8BUrNYlOjTAf3LBUQv3CZm6E6tOw+wdJRjMATZ/PbnLsAP262FOFjnZH5NFBwNXGpXQHCI04mNl+24D8LSyJAT6oBG5X58+swkUqCD1ats3iDKGemDt3RcYyIpyMVvuc9G+NbfwPkHXNdZImHXZYaGXs5dDZOTN/n5vNMyouxEPgaL9pskYcXeX/WHrs+yJ6zil7E8/tfcwTynE4XdS4tu2Jz3jWP7nkMBvy0RiY0vZUgRcEQ+jkW6uWM=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eENZeWw5ck81cER4MnNoWjc5a3RZWE83eS9RU2tjZU5UUms0RndGS1BrbS9T?=
 =?utf-8?B?Ni9TSSsvVm4rRUpudE1LUG1yd0JBbndkL3RLNHB3MktCUTZERjdydXlSVGZl?=
 =?utf-8?B?MjVtSnVJMk5Qdm9odW5JTkFoRGNLSDlER2J4QnhJWGpMUDFYdmdiVVhUZnNQ?=
 =?utf-8?B?RFFuQXpqakVQcDJOSEQwZU1UWXQ1Z0tKVGVqc3VpRllEODNtRDlMUDRheEpZ?=
 =?utf-8?B?TTlLby9EK0lIenh2NjNWazY3L1pVT1JSaXZTK1BVeFc5OHhlMWdUbzl1LzNF?=
 =?utf-8?B?S1lPUXFWSDlKSCsxa1pXR2ZWS3VYWVpKUnlQY1N6Z1JsKzNnempBTklQM0hN?=
 =?utf-8?B?dEgwd0V0dUg4MU1PQS82N1FlUVJiTXZDeWc3WDNaZXY0VDNzTzN5TGRYd2k1?=
 =?utf-8?B?c3l0V0RuanRLTFFrWjg5S3dQRmlQQkVRWC8rUC9GeDVYR2svUWVHV0d6Vlln?=
 =?utf-8?B?NFZSbVR4S2drK2Z4OFVuS25CUlVXUEl1SStGeGIyN0w4SHdFTUNDZTVGM0ps?=
 =?utf-8?B?QXYyWWtMYnhJNEw3NFg0eUNFNTNQYnJFYWxRUUNrdHdKQ1QvTnNWNjZMRCtR?=
 =?utf-8?B?TDhKV3E3NlFwVFhTYUVVV3VOOXlQaWJHNEdENFh1aXhSKzFrbTQ3dE5nbFlz?=
 =?utf-8?B?OEgzYktEY2dGS0JBOU5PanJncEFCcHY2N3ZyTXRFOVdyd1B1b1g5TXRwN3Vw?=
 =?utf-8?B?UDNVZlhXWUVoam42T0xFQk54UUtxci9RbjE1NVdtNkVublZnUytXcFNkQVd2?=
 =?utf-8?B?MlZVa2dSQ2ZXRHBza1UxOWJ6bEhPU2xLTzFWVWVYSExVVVFnZFBQOFBTZzc1?=
 =?utf-8?B?MGgxUzJYM0F3S1BhTXY2a0RQckFXckdZdGU5c281UHlZNzNRLzBGS1JpVU9W?=
 =?utf-8?B?d09HaGU2b2xYVzNPYUhad0VFTTVyM1BoUldiRW5kdDl1R1o2TWdaUFluS0pn?=
 =?utf-8?B?Z056aEIxbW45Uk5xUmZmMCtoMWozMmVDdWp5OVR4QUt1elBVZks0NWVlTm5H?=
 =?utf-8?B?MklYQTNjTElvd3FzNkxNY2pJNTZPTFlWQXpxOEhrTnBvWUJJb2NMaXNDN2E4?=
 =?utf-8?B?cVNaK08rRGZ3SGZCNW9qcXJnOW1HZE1IdkY2SUgwV0ZRUmJ1RGxaSVVRNWNQ?=
 =?utf-8?B?MkR4THZDQVpFNjd6RmVoTGE4QXprLzB1ZjdSamhCYXFXbEg4N0VWV242VUhk?=
 =?utf-8?B?ejNTV3FVbmZtUlJsVXVINVlUM1ZQL3UyUkQ1RDV2T3liN3BWS0tidWhTemZs?=
 =?utf-8?B?aWh2ejIzaDRocTNyYXJpRnRlTFhMaUhvWUxzWWljdGNDeXAxV2ZxZVluY1Yz?=
 =?utf-8?B?Vzd4Q2RHdzJ5ZFlCaGxwYWcyQit6V1hQc3hmYmFJUEdIRFJBOG5WMXUySTFi?=
 =?utf-8?B?Z095U201MWIyMm5zNlZiWHFUdTlsNVB2UHBlMllGUTZodTUwZ1J1cTdBY0Uy?=
 =?utf-8?B?ZDh1eVhubHRhNGh6Ym1JOUczYmI0TFpVQm1rQW5iWE1FRGtwOFQwUWVNVU1s?=
 =?utf-8?B?TnR5MUVMcmc2em16NHJVK1R3SFExZEkwcG40QXdXaXJ3ejBqM3pBTktFVFZq?=
 =?utf-8?B?aGR2NUhEb2xpMWlZVVBNUnlKSFBPNWRXRExoZlFrbW1kK2tlcEFkZVZzaDh5?=
 =?utf-8?B?MkhpclhOWVc1WmdIRkZ4cVVuaGJqejloR0xNTEZpbnVmZ2tDZ0RIUklnT0lH?=
 =?utf-8?B?U01FbUxuRHE4TXlCcXQ4YzJLNTV3Sk9vZTk1VTNrZ2NDOVhxRk5Bb3cydFlK?=
 =?utf-8?Q?FJJCU4gioUVT0YnqcQ=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 070b3041-c5f3-4e79-07be-08dc98f749c2
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2024 11:25:04.1161
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0P287MB2038

DQoNCj4gT24gMzAgSnVuIDIwMjQsIGF0IDQ6MzXigK9QTSwgT3JsYW5kbyBDaGFtYmVybGFpbiA8
b3JsYW5kb2NoLmRldkBnbWFpbC5jb20+IHdyb3RlOg0KPiANCj4g77u/T24gU3VuLCAzMCBKdW4g
MjAyNCBhdCAyMDo1MCwgQWRpdHlhIEdhcmcgPGdhcmdhZGl0eWEwOEBsaXZlLmNvbT4gd3JvdGU6
DQo+PiANCj4+IA0KPj4gDQo+Pj4+IE9uIDMwIEp1biAyMDI0LCBhdCAzOjMy4oCvUE0sIEx1a2Fz
IFd1bm5lciA8bHVrYXNAd3VubmVyLmRlPiB3cm90ZToNCj4+PiANCj4+PiDvu79PbiBTdW4sIEp1
biAzMCwgMjAyNCBhdCAwOToxMzozM0FNICswMDAwLCBBZGl0eWEgR2FyZyB3cm90ZToNCj4+Pj4+
PiBPbiAzMCBKdW4gMjAyNCwgYXQgMTozNCBQTSwgTHVrYXMgV3VubmVyIDxsdWthc0B3dW5uZXIu
ZGU+IHdyb3RlOg0KPj4+Pj4gT24gU3VuLCBKdW4gMzAsIDIwMjQgYXQgMDQ6NDI6NTVBTSArMDAw
MCwgQWRpdHlhIEdhcmcgd3JvdGU6DQo+Pj4+Pj4gQmFzZWQgb24gdGhpcyBwYXRjaCBmb3IgR1JV
QiBieSBBbmRyZWFzIEhlaWRlciA8YW5kcmVhc0BoZWlkZXIuaW8+Og0KPj4+Pj4+IGh0dHBzOi8v
bGlzdHMuZ251Lm9yZy9hcmNoaXZlL2h0bWwvZ3J1Yi1kZXZlbC8yMDEzLTEyL21zZzAwNDQyLmh0
bWwNCj4+Pj4+IA0KPj4+Pj4gUGxlYXNlIGluY2x1ZGUgaGlzIFNpZ25lZC1vZmYtYnkgYW5kIGNj
IGhpbS4NCj4+Pj4gDQo+Pj4+IE5vdCBzdXJlIGFib3V0IHRoaXMgc2luY2UgdGhlIHBhdGNoIHdh
cyBzZW5kIHRvIGdydWIgYW5kIG5vdCBsa21sLA0KPj4+PiBhbmQgaGlzIHdvcmsgaGFzIGJlZW4g
dXNlZCB3aXRob3V0IGluZm9ybWluZyBoaW0gZm9yIHRoaXMgcGF0Y2ggc29sZWx5DQo+Pj4+IG9u
IHRoZSBiYXNpcyBvZiBHUEwuDQo+Pj4+IA0KPj4+PiBJJ3ZlIGFsd2F5cyBiZWVuIGNvbmZ1c2Vk
IGluIHNpZ25lZC1vZmYtYnkgaW4gY2FzZSBvZiBhdXRob3JzIHdob3NlIHdvcmsNCj4+Pj4gaGFz
IGJlZW4gdXNlZCB3aXRob3V0IHRoZWlyIGV4cGxpY2l0IGNvbnNlbnQganVzdCBiZWNhdXNlIHRo
ZSBsaWNlbnNlDQo+Pj4+IHBlcm1pdHMgaXQuDQo+Pj4+IA0KPj4+PiBTaG91bGQgSSBzdGlsbCBh
ZGQgaGlzIHNpZ25lZC1vZmYtYnk/DQo+Pj4gDQo+Pj4gSSB3b3VsZC4NCj4+PiANCj4+PiANCj4+
Pj4+PiAtLS0gYS9Eb2N1bWVudGF0aW9uL2FkbWluLWd1aWRlL2tlcm5lbC1wYXJhbWV0ZXJzLnR4
dA0KPj4+Pj4+ICsrKyBiL0RvY3VtZW50YXRpb24vYWRtaW4tZ3VpZGUva2VybmVsLXBhcmFtZXRl
cnMudHh0DQo+Pj4+Pj4gQEAgLTM5OSw2ICszOTksOCBAQA0KPj4+Pj4+ICAgICAgICAgICAgICAg
IHVzZWZ1bCBzbyB0aGF0IGEgZHVtcCBjYXB0dXJlIGtlcm5lbCB3b24ndCBiZQ0KPj4+Pj4+ICAg
ICAgICAgICAgICAgIHNob3QgZG93biBieSBOTUkNCj4+Pj4+PiANCj4+Pj4+PiArICAgIGFwcGxl
X3NldF9vcyAgICBbS05MXSBSZXBvcnQgdGhhdCBtYWNPUyBpcyBiZWluZyBib290ZWQgdG8gdGhl
IGZpcm13YXJlDQo+Pj4+Pj4gKw0KPj4+Pj4gDQo+Pj4+PiBXaHkgdGhlIGtlcm5lbCBwYXJhbWV0
ZXI/ICBXaHkgbm90IGRvIHRoaXMgdW5jb25kaXRpb25hbGx5Pw0KPj4+PiANCj4+Pj4gMS4gTm90
IGFsbCBNYWNzIGhhdmUgZHVhbCBHUFUuIFdlIGRvbid0IHdhbnQgdG8gdW5uZWNlc3NhcmlseSAi
Zm9vbCINCj4+Pj4gdGhlIGZpcm13YXJlIGluIHRoaW5raW5nIG1hY09TIGlzIGJlaW5nIGJvb3Rl
ZC4NCj4+Pj4gMi4gYXBwbGUtZ211eCBpcyBhIHJldmVyc2UgZW5naW5lZXJlZCBkcml2ZXIsIGFs
dGhvdWdoIHVwc3RyZWFtZWQsDQo+Pj4+IG5vdCB2ZXJ5IGVmZmljaWVudCBpbiBzd2l0Y2hpbmcg
R1BVcy4gU28gaXQncyBiZXR0ZXIgdG8gbWFrZSB1bmxvY2tpbmcNCj4+Pj4gdGhlIEdQVSBvcHRp
b25hbC4gKyBub3QgZXZlcnlvbmUgd2FudHMgdGhlIGludGVsIEdQVSwgcGVvcGxlIGFyZSBoYXBw
eQ0KPj4+PiB3b3JraW5nIHdpdGggdGhlIGRlZGljYXRlZCBBTUQgR1BVICh1c2VkIGJ5IGRlZmF1
bHQgaWYgYXBwbGVfc2V0X29zDQo+Pj4+IGlzbid0IGVuYWJsZWQpLg0KPj4+IA0KPj4+IFNvIG15
IG9waW5pb24gaXMgdGhhdCB0aGVzZSBhcmVuJ3QgZ29vZCBhcmd1bWVudHMuICBXZSBzaG91bGQg
YmUNCj4+PiBpZGVudGlmeWluZyBhcyBEYXJ3aW4gYnkgZGVmYXVsdCBpbiBFRkksIGp1c3QgYXMg
d2UndmUgYmVlbiBkb2luZw0KPj4+IGluIEFDUEkgc2luY2UgN2JjNWEyYmFkMGI4LiAgSWYgdGhl
cmUgYXJlIGFueSBhZHZlcnNlIGVmZmVjdHMsDQo+Pj4gd2Ugc2hvdWxkIGxvb2sgaW50byB0aGVt
LCBidXQgdXNlcnMgc2hvdWxkbid0IGJlIGZvcmNlZCB0byBzZXQNCj4+PiBhbiBvYnNjdXJlIGtl
cm5lbCBwYXJhbWV0ZXIgb25seSB0byBlbmFibGUgY2VydGFpbiBmZWF0dXJlcyBvZg0KPj4+IHRo
ZWlyIGhhcmR3YXJlLiAgSXQgaXMgZm9yIHRoaXMgcmVhc29uIHRoYXQgeW91J2xsIHVzdWFsbHkg
Z2V0DQo+Pj4gR3JlZyBLSCdzIHRyYWRlbWFyayAidGhpcyBpc24ndCB0aGUgOTBzIGFueW1vcmUi
IGNvbW1lbnQgd2hlbg0KPj4+IGFkZGluZyBuZXcga2VybmVsIHBhcmFtZXRlcnMuICBXZSBuZWVk
IHRvIGhhbmRsZSB0aGUgaGFyZHdhcmUNCj4+PiBjb3JyZWN0bHkgKmF1dG9tYXRpY2FsbHkqLg0K
Pj4+IA0KPj4gSSdtIG5vdCBpbiBhIGZhdm91ciBvZiAiZm9yY2luZyIgZHVhbCBHUFUgb24gdXNl
cnMsIGVzcGVjaWFsbHkgYmVjYXVzZSB0aGUgZmVhdHVyZXMgYXJlIHF1aXRlIHVuc3RhYmxlLiBP
biBzb21lIGRpc3Ryb3MgbGlrZSBVYnVudHUsIHNpbmNlIGtlcm5lbCA2LjgsIHVubG9ja2luZyB0
aGUgR1BVIHJlc3VsdHMgaW4gYmxhbmsgc2NyZWVuIGluc3RlYWQgb2YgaWdwdSBkdWUgdG8gYSBy
ZWdyZXNzaW9uIChub3RlIHRoYXQgdGhpcyBwYXRjaCBoYXMgbm90aGluZyB0byBkbyB3aXRoIHRo
aXMgcmVncmVzc2lvbiwgaXQncyBzb21ldGhpbmcgdGhlIHBsYXRmb3JtIGRyaXZlcnMgcGVvcGxl
IHdpbGwgbG9vayBpbnRvKS4NCj4gDQo+IElzIHRoaXMganVzdCB3aXRoIGFwcGxlLXNldC1vcyBv
ciB3YXMNCj4gaHR0cHM6Ly9naXRodWIuY29tL3QybGludXgvbGludXgtdDItcGF0Y2hlcy9ibG9i
L21haW4vMjAwOS1hcHBsZS1nbXV4LWFsbG93LXN3aXRjaGluZy10by1pZ3B1LWF0LXByb2JlLnBh
dGNoDQo+IGFuZCB0aGUga2VybmVsIHBhcmFtZXRlciBpdCBhZGRzIGJlaW5nIHVzZWQgd2hlbiB0
aGF0IGlzc3VlIGhhcHBlbmVkPw0KDQpIaSBPcmxhbmRvLCB0aGFua3MgZm9yIHJlcGx5aW5nDQoN
Ck15IGJhZCBJIHNob3VsZCBoYXZlIGNoZWNrZWQgdGhpcyBhcyB3ZWxsLiBJbmRlZWQgcmVtb3Zp
bmcgdGhlIGtlcm5lbCBwYXJhbWV0ZXIgZml4ZXMgdGhlIGJsYW5rIHNjcmVlbi4NCj4gDQo+PiAN
Cj4+IE9uIHRoZSAyMDE5IE1hY0Jvb2sgUHJvcyB0aGUgdmdhc3dpdGNocm9vIGlzIG5vdCB3b3Jr
aW5nIGFuZCBpbnB1dHMgZnJvbSBBTUQgYXJlIG5pbC4gQmFzaWNhbGx5IHlvdSBnZXQgc3R1Y2sg
dG8gdGhlIEludGVsIEdQVSBhbmQgaWYgeW91IHRyeSB0byB1c2UgdGhlIEFNRCBHUFUsIGJ1dCB0
aGUgR1BVcyByZW1haW4gb24gKGN1cnJlbnRseSBubyB3YXkgaGFzIGJlZW4gZm91bmQgdG8gc3dp
dGNoIG9mZiB0aGUgQU1EIG9uZSkNCj4gDQo+IERvIHlvdSBtZWFuIHRoYXQgc3dpdGNoaW5nIHdo
aWNoIGdwdSBpcyBjb25uZWN0ZWQgdG8gdGhlIGRpc3BsYXkgYXQNCj4gcnVudGltZSBpc24ndCB3
b3JraW5nPyBJICp0aGluayogaXMgaXMgcmVsYXRlZCB0byB0aGUgbm90LXVwc3RyZWFtDQo+IHBh
dGNoIEkgbGlua2VkIGFib3ZlPw0KPiANCj4+IA0KPj4gU28gSSBndWVzcyB3ZSBoYXZlIDIgb3B0
aW9uczoNCj4+IA0KPj4gMS4gV2FpdCB1bnRpbCBhcHBsZS1nbXV4IGJlY29tZXMgcXVpdGUgc3Rh
YmxlIGJlZm9yZSBtZXJnaW5nIHRoaXMgKGZhdCBjaGFuY2UpDQo+PiAyLiBHaXZlIG1lIHNvbWUg
YmV0dGVyIGlkZWEgdG8gaGFuZGxlIHRoaXMuDQo+PiANCg==

