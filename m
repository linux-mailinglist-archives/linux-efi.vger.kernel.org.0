Return-Path: <linux-efi+bounces-1326-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 508E891D187
	for <lists+linux-efi@lfdr.de>; Sun, 30 Jun 2024 13:56:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 691A91C203E3
	for <lists+linux-efi@lfdr.de>; Sun, 30 Jun 2024 11:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 770EC12D74E;
	Sun, 30 Jun 2024 11:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="nbzgl84f"
X-Original-To: linux-efi@vger.kernel.org
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01olkn2073.outbound.protection.outlook.com [40.92.103.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE62639863;
	Sun, 30 Jun 2024 11:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.103.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719748607; cv=fail; b=hSNQFW01SkF9OE28d/3ZNvditvw0CAi3T/sj5SfCgw1tyduTVXpznMMf/qp/L8qR9pAym6HpULuxOzkoHCgW7bceagNT3MMxLO8T3sFk6CyNXkjWMp9dMDz52kzgl4nBX6RXu3POTV7RExc2LtnpczC+LvsP1+fai57E9QhcdkY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719748607; c=relaxed/simple;
	bh=xnAmeGnYeWrWdDFMeK7W9+RrqWqoDMct8gza1ZDjaaw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kUpZSLI1esEFYb7Cd6IeNFNJp6ReeltKkzStQaoRdnME7DdySFi/1ZbfIshvgNO20X4oDL7YMAsfvxPr+3YOdNsiGMHQzh/5e7wfXHliEOmAxbIS6vXIjoJ1XFQ3PYw5DD5hC38ok1sz4/ramk2NySHoH6BQ79VRB+/hNMzWFR0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=nbzgl84f; arc=fail smtp.client-ip=40.92.103.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f+b626oX1SqVPr0wIRhx0/HgGi0a3aRxFowRGde0/bwAX84wWvegevwxRXvzNxD/unYBLzJ7qRjnZDxr3EMn4xQKrguMKMxMfCCCa0CwZTq0hzVxLB79NWpPn8sO685YRoScZ73VRopyjG4doSKSPZO3VSUzyD0jlRJG0pnm0X/zIrAYlsWlmq++bO0sQS6LqRmLiVs103bBpRmQw4PPbOFO21UB5OUXsTx9TRXGXn3QoZXlopY9FJpCwRPF7vgIYh/lmMokgxIDmaam0YEmQ9slqKUs37bka6HBe7ClWMCYur0Petgfo+OLrY4To2xg/UBIJb9quD4jjKJXpgy65A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xnAmeGnYeWrWdDFMeK7W9+RrqWqoDMct8gza1ZDjaaw=;
 b=WDQe/TJrwweewiDV1e6WtTLdk6upTxzcpMSXehGXxor9UtAIDUV0Yg7pO0tI8U/gUYTqI3ABc9WveLqLjPuXfx5tR02M5RFpMebVS98w8/C2Q1xvfetLyaUiz2wsUjmp5wsG561zPDzGJLOGf9ZZtQ/aypasnYGjnQUbK+acKVmpSWrLh3L+otGcHelM+6TgnLvTxGYRN8t1a1rbcaH1nA2VbrSlq9ZmFAmh9OMELJTEGJk1p+VFUcq24PJ4EEf4vrwuWCURAwQoAbzJDTCoAMZmfSlcGrA6+bH12bHhombliEJj4tfP9tEuXqCs+2BvWZNw672RX8CqFrkT/iVzzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xnAmeGnYeWrWdDFMeK7W9+RrqWqoDMct8gza1ZDjaaw=;
 b=nbzgl84fteI6fuiuxSR19QhoBbFdDQCSWvWrmqTkzyV4/R1d0mHNQJ/e8kRGMDJ+9bNNmd02/enfopnejmXCZYTk0h6QMRqKTT5CRWa2IsoZSVOge4c1GUXsBmwbK4gU8rD6HE11QkOzepKfZ3DYvXXefPx4H0UbVLM5aCrfAWL3y0IAw7oOh8XOWvc8jX/Bq/I9cdl1tJPA9vQgqeT0BRo1dZ0ALmGRTuXOmmBeCpwy8w4wc6sK2BxT7XgWM8eGuG+nA44zmcvzLmIQHCKvtvJVXcK/rUwPz1peFzNI9ZOlehJ7VnsKG95lKTZpyuKWlkuV2rUx59Z8Yk3/XeADdw==
Received: from MA0P287MB0217.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:b3::9) by
 PN3P287MB1719.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:19f::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7719.28; Sun, 30 Jun 2024 11:56:40 +0000
Received: from MA0P287MB0217.INDP287.PROD.OUTLOOK.COM
 ([fe80::98d2:3610:b33c:435a]) by MA0P287MB0217.INDP287.PROD.OUTLOOK.COM
 ([fe80::98d2:3610:b33c:435a%7]) with mapi id 15.20.7719.028; Sun, 30 Jun 2024
 11:56:39 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Ard Biesheuvel <ardb@kernel.org>
CC: Lukas Wunner <lukas@wunner.de>, Hans de Goede <hdegoede@redhat.com>,
	"linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>, Linux Kernel Mailing
 List <linux-kernel@vger.kernel.org>, Orlando Chamberlain
	<orlandoch.dev@gmail.com>, Kerem Karabay <kekrby@gmail.com>
Subject: Re: [PATCH] efi: libstub: add support for the apple_set_os protocol
Thread-Topic: [PATCH] efi: libstub: add support for the apple_set_os protocol
Thread-Index: AQHayqf5aNOCBZ38jE+N2QIS72Io3bHf8v+AgAA5KoCAAAepHA==
Date: Sun, 30 Jun 2024 11:56:39 +0000
Message-ID:
 <MA0P287MB021713D8583D4D53C736F3D8B8D22@MA0P287MB0217.INDP287.PROD.OUTLOOK.COM>
References: <EBE51900-DA87-4113-B389-80B9C9160F0F@live.com>
 <ZoERl1PWoc2xDGWz@wunner.de>
 <CAMj1kXFEQDir_VffzHZ0uBMjRqEReNdBZcEQs7kFhi=ipM+y9Q@mail.gmail.com>
In-Reply-To:
 <CAMj1kXFEQDir_VffzHZ0uBMjRqEReNdBZcEQs7kFhi=ipM+y9Q@mail.gmail.com>
Accept-Language: en-IN, en-US
Content-Language: en-IN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:
 [1mjdUotRstgWf6ymZTZxlMnSiyb62S2/5R9SCbL/+asiuUZWtLRJzWl4paAVJOzWirdOE6+Shf8=]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MA0P287MB0217:EE_|PN3P287MB1719:EE_
x-ms-office365-filtering-correlation-id: 970e11af-4584-427f-3c55-08dc98fbb3a9
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|8060799006|102099032|4302099013|3412199025|440099028|1602099012;
x-microsoft-antispam-message-info:
 oHlK/+TwPcf8hzBj1DhR4QyIpYyezqHlWSla7r5eWKybU7vUmZR0U6KagzjJTsjSSqLFGmDVqQPKarz57TRyDl3orPadtGtSOSGq3J3i5qgk3yPyx/eR3CGq81JnekvTsMSyzLZ+msDCGSRvdNIQU5fQ5fzF0E+pTOfsh7il61uQ82yms8GcmXFtAiqGhIo6ojN1kD0jyMl/P7to22seLqYf7V164D941rtVpjBGJkj2y2yugBnwmATQbHcN8qjbiNfF3deLvdbWd4aC6ACBpBDht6mpbPnG76Utmszf889ZBmUy8SomtpdIiePKToZWbaaH1riofNhQU0pBgg3VSYcD5hPuz8jPZFDfHEHSNWjtWCFiFCjGrzepuiptx3LSaCWVdY1gSpzntcQvs4V/UewdQbokse7n31g0vNZ2fW0oR5PAS3J4ebeeaKRt8t1w+Mle4YvzuuE+ronXN9txWYQZUZwoiT8dWbox+MjhkGsanbkCM/zjpLnyV3QAEuuMx+rCGvg0wJCFilcCWxIpbflTuAKOoPWmqLdFOUAGdV2lOUkb42Y1YItVayRhJHJtaLkFzNpZC8R7+9PDSjjXqV2BEqCGC4I9CN1dHkGI6zb4Phjl0HVXwCD3qg4+SOkERI0WQyYXkZoDFhzxaD7py3XsVvgsgJQGU8qBWEiQtmveyQ3PpjeNZEUohpNtzY90DlYxi6Bj9AKi/0YZxSh8fEiGLqtXBCI1e8HTfA1kg+g=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QTdnaU1IZWhZQVo3MjZJMTJFMWZKUnZKMDhUOG1KaWgrb1BCS3hwTCtOQlhr?=
 =?utf-8?B?SEE3dDRDWXBYaTJYbG5pTnBEZlphMTcrN2FaUGxsWnBnQTZERHJKVEFONGJy?=
 =?utf-8?B?cHg0QkFnM2Fka3FsWWtpYTZ4QzF1ZnZqYmN1dTR4Y2dMQUhVRS8yakI5V2Vw?=
 =?utf-8?B?QkJRNGlTdVI5cGV0QjIzb1NIZWhRL3QvRWdDY3NsR3NyQXhYelZteTJESWZ2?=
 =?utf-8?B?b3lEUDQyVThsWlRRT0thWThVWmdhajZRYmpjMzRzQXhMWlFGbXlhc2JDUlJE?=
 =?utf-8?B?M29UcGhURk8wNSt4YnZ2Z0dadzhkMHZ0eDNNOWhIQkFtTThJdS9lTTBtNmpp?=
 =?utf-8?B?Z2YwYTUzQ2xsOHJwMTRwK1FuNDZBQUZnd2dHTzhZVHFGVm1hQXRNRFB0NGVE?=
 =?utf-8?B?SUVnaFpjMURrMmZJN2hXblg2NkJhZktMSDdXc3RLWGt5ZDBMekpwZ2ZSbmdz?=
 =?utf-8?B?eTIwKzVkY3kxWmxWcHd5T1g0blgwQURZRXBsYU1tZ3FmcDJsUGxtd2gyM3BM?=
 =?utf-8?B?bHpZTVFoN2NQd1hYVGFicHdRUFZOWDhOTUNBdHB0R1V3cmdmcDI0aEV6cDN5?=
 =?utf-8?B?OVJhbWJPMG1RYlVvNlFqRkloRDlYTmFzazJGRFJyZmVaanhrdnh6N0ZhU1Y3?=
 =?utf-8?B?WmtHNU5XOXRJNGkyYWt5SlF6c04wM1VOelFhMDc1UVo2TS9TMkovY0hldnJT?=
 =?utf-8?B?Q1lrd2JkemM5bEF3YlJiOEdtQmpKTlRpM0N2VXZWTEFWS2tqZ204Ky84QzEv?=
 =?utf-8?B?QnlpZVY1R0JYWlJWRVlESzhwdjRQRmZiZFdpSEt6SU5YcmNTeEI4YTh2S2l1?=
 =?utf-8?B?bVY3MkpLdUdQdTFpNlhIZFJES2ZWS3ZrZ2xvYjNOSnVKZmlPN3hNZmpKbUlD?=
 =?utf-8?B?YXp6b0U4V25INHdBMm1DeGlUbUN5SlVDYVgvbC9Mb0k5R3JMekFuVVFDQ3p2?=
 =?utf-8?B?WGcxOTBOcHRxc1JKRjhiUkFxdmEzeDRqT1RuY2tMd3d5UkQxTnpob0IzRURK?=
 =?utf-8?B?NzNhOC9neE1pdThYMjZiRGFTVWNwUW55SU51OFlzYVppclZ6alYyaVljYjFC?=
 =?utf-8?B?ZnM0S2FFalNzeHlBZEpwZnZWVnpWZmEyU0FXZkZwZWQ4N3llSG96Ukg5clVQ?=
 =?utf-8?B?SHZpeGNGOXdxNUJwaDR1cTdMNE5VNDFxQ0N1MkY3dWhzaC9Yc1hqWFZKZkZs?=
 =?utf-8?B?ZHQ2R3hVeUVzcXNUVHJLaDJTeC9lbkRtS3dwaUROS2hjMjNSeTRPVjN6SmhU?=
 =?utf-8?B?UzM4ME12b3o1djdEeVlFM2NKZXdQckJyMmpieDJ2ZmFET3NlTEdlajlBWldJ?=
 =?utf-8?B?eFAwMmZSbS9IVlJRdFpCeWdueG9GZWRMejA5M2Y4d21iWm4ybWxDS3pCaEV3?=
 =?utf-8?B?YzNzc0ZCdHJUWmVvQmdrSUxHdFYzUU5lbTVJVEoxL2dGNWxOS1c4MlVFUXFL?=
 =?utf-8?B?dlExRzZzRG1iaWFWWFcwcjVKSFFCRHBYZTU4NVBPY0s4eEVnSnllSU9IeWU0?=
 =?utf-8?B?QkZQMHQ5MjRkZmpVVi91UU9qa2VDL3NSNXNTbFVsWVlOTXhhb1BtbFphUW1W?=
 =?utf-8?B?VzZCWnhCVllxOWJubDROUTI0OW5UWTY2RnlSZVNuTklrVVRuN21BSmY4Y2ph?=
 =?utf-8?B?OCtHSVFBa205bTgwYml5bFNYc0w4VlA2R29Jems3Ym5uT3pycmVLUiswNm5S?=
 =?utf-8?B?TEdtc2RnWCtxaXhmVHdBUXZRaTFFb2RhQ2FhbGp0akk1a1l2Sk45czhBblJw?=
 =?utf-8?Q?wLYjpq5ngXh1AaGVfA=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 970e11af-4584-427f-3c55-08dc98fbb3a9
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2024 11:56:39.8142
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3P287MB1719

DQoNCj4gT24gMzAgSnVuIDIwMjQsIGF0IDQ6NTnigK9QTSwgQXJkIEJpZXNoZXV2ZWwgPGFyZGJA
a2VybmVsLm9yZz4gd3JvdGU6DQo+IA0KPiDvu79IZWxsbyBBZGl0eWEsIEx1a2FzLA0KPiANCj4+
IE9uIFN1biwgMzAgSnVuIDIwMjQgYXQgMTA6MDQsIEx1a2FzIFd1bm5lciA8bHVrYXNAd3VubmVy
LmRlPiB3cm90ZToNCj4+IA0KPj4+IE9uIFN1biwgSnVuIDMwLCAyMDI0IGF0IDA0OjQyOjU1QU0g
KzAwMDAsIEFkaXR5YSBHYXJnIHdyb3RlOg0KPj4+IENvbW1pdCAwYzE4MTg0ZGU5OTAgYnJvdWdo
dCBzdXBwb3J0IGZvciBUMiBNYWNzIGluIGFwcGxlLWdtdXguIEJ1dCBpbiBvcmRlciB0bw0KPj4g
DQo+PiBQbGVhc2UgcnVuIHBhdGNoZXMgdGhyb3VnaCBzY3JpcHRzL2NoZWNrcGF0Y2gucGwgYmVm
b3JlIHN1Ym1pc3Npb24uDQo+PiBUaGUgc3ViamVjdCBvZiB0aGUgY29tbWl0IGlzIG1pc3Npbmcg
aGVyZSBhbmQgbGluZXMgc2hvdWxkIGJlIHdyYXBwZWQNCj4+IGF0IDcyIG9yIGF0IGxlYXN0IDc0
IGNoYXJzLg0KPj4gDQo+PiANCj4+PiBCYXNlZCBvbiB0aGlzIHBhdGNoIGZvciBHUlVCIGJ5IEFu
ZHJlYXMgSGVpZGVyIDxhbmRyZWFzQGhlaWRlci5pbz46DQo+Pj4gaHR0cHM6Ly9saXN0cy5nbnUu
b3JnL2FyY2hpdmUvaHRtbC9ncnViLWRldmVsLzIwMTMtMTIvbXNnMDA0NDIuaHRtbA0KPj4gDQo+
PiBQbGVhc2UgaW5jbHVkZSBoaXMgU2lnbmVkLW9mZi1ieSBhbmQgY2MgaGltLg0KPj4gDQo+PiAN
Cj4gDQo+IE5vLiBZb3UgY2Fubm90IHNpbXBseSBhZGQgYSBzaWduZWQtb2ZmLWJ5IG9uIHNvbWVv
bmUgZWxzZSdzIGJlaGFsZiwNCj4gZXZlbiBpZiB5b3UgY2MgdGhlIHBlcnNvbi4NCj4gDQo+IEFu
ZHJlYXMgY29udHJpYnV0ZWQgY29kZSB0byBHUlVCICh3aGljaCBpcyBhIEdQTHYzIHByb2plY3Qp
LCBhbmQgaGFkDQo+IG5vIGludm9sdmVtZW50IHdoYXRzb2V2ZXIgaW4gY3JlYXRpbmcgdGhpcyBw
YXRjaC4NCj4gDQo+IEEgc2lnbmVkLW9mZi1ieSBpcyBhIHN0YXRlbWVudCBvbiB0aGUgcGFydCBv
ZiB0aGUgY29udHJpYnV0b3IgKHdoaWNoDQo+IG1heSBvciBtYXkgbm90IGJlIHRoZSBhdXRob3Ip
IHRoYXQgdGhlIGNvbnRyaWJ1dGlvbiBpbiBxdWVzdGlvbg0KPiBjb21wbGllcyB3aXRoIHRoZSBy
ZXF1aXJlbWVudHMgaW1wb3NlZCBieSB0aGUgcHJvamVjdCBpbiB0ZXJtcyBvZg0KPiBjb3B5cmln
aHQgYW5kIGxpY2Vuc2luZy4gTGludXggaXMgR1BMdjIgbm90IHYzLCBzbyB0aGlzIGNvZGUgc2hv
dWxkIGF0DQo+IGxlYXN0IGJlIGR1YWwgbGljZW5zZWQgaW4gb3JkZXIgdG8gYmUgcmV1c2VkIGRp
cmVjdGx5Lg0KPiANCj4gSSBkaWQgbm90IGxvb2sgYXQgdGhlIEdSVUIgcGF0Y2gsIGFuZCBJQU5B
TCwgYnV0IHRoaXMgY29kZSBpbnZva2VzIGFuDQo+IEFwcGxlIHByb3ZpZGVkIHByb3RvY29sICh3
aGljaCBpcyBwcm9wcmlldGFyeSkgaW4gYSBoYXJkY29kZWQgd2F5IGZvcg0KPiBpbnRlcm9wZXJh
YmlsaXR5IHB1cnBvc2VzLCBhbmQgc28gdGhlcmUgaXMgbm90IG11Y2ggdG8NCj4gY29weXJpZ2h0
L2xpY2Vuc2UgYW55d2F5LiBJIHdvdWxkIGJlIGZpbmUgd2l0aCBoYXZpbmcganVzdCB5b3VyDQo+
IHNpZ25vZmYgb24gdGhpcyBwYXRjaCwgYnV0IHlvdSBjb3VsZCBhc2sgQW5kcmVhcyBmb3IgYSBH
UEx2MiszIHZlcnNpb24NCj4gb2YgaGlzIEdSVUIgcGF0Y2ggaWYgeW91IGFyZSBub3Qgc3VyZS4N
Cj4gDQoNCkkgYmVsaWV2ZSB0aGlzIHNob3VsZCBiZSBHUEwyIGNvbXBhdGlibGUgc2luY2UgaXQn
cyBzaW1wbGUgcmV2ZXJzZSBlbmdpbmVlcmVkIEFwcGxlIHN0dWZmIGFuZCB0aGVyZSBhcmUgbWFu
eSBrZXJuZWwgZHJpdmVycyB3aXRoIGFwcGxlIHNwZWNpZmljIHN0dWZmLg0KDQo+Pj4gLS0tIGEv
RG9jdW1lbnRhdGlvbi9hZG1pbi1ndWlkZS9rZXJuZWwtcGFyYW1ldGVycy50eHQNCj4+PiArKysg
Yi9Eb2N1bWVudGF0aW9uL2FkbWluLWd1aWRlL2tlcm5lbC1wYXJhbWV0ZXJzLnR4dA0KPj4+IEBA
IC0zOTksNiArMzk5LDggQEANCj4+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICB1c2VmdWwg
c28gdGhhdCBhIGR1bXAgY2FwdHVyZSBrZXJuZWwgd29uJ3QgYmUNCj4+PiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBzaG90IGRvd24gYnkgTk1JDQo+Pj4gDQo+Pj4gKyAgICAgYXBwbGVfc2V0
X29zICAgIFtLTkxdIFJlcG9ydCB0aGF0IG1hY09TIGlzIGJlaW5nIGJvb3RlZCB0byB0aGUgZmly
bXdhcmUNCj4+PiArDQo+PiANCj4+IFdoeSB0aGUga2VybmVsIHBhcmFtZXRlcj8gIFdoeSBub3Qg
ZG8gdGhpcyB1bmNvbmRpdGlvbmFsbHk/DQo+PiANCj4+IA0KPiANCj4gQWdyZWUgdGhhdCB0aGlz
IGlzIHN1Ym9wdGltYWwuIElmIHdlIG5lZWQgYSBjb21tYW5kIGxpbmUgcGFyYW0gZm9yDQo+IHRo
aXMsIHBsZWFzZSBtYWtlIGFkZCBpdCB0byB0aGUgZWZpPSBsaXN0DQoNCkknbGwgbGVhdmUgdGhp
cyB0byB5b3UuIElmIHlvdSBhcmUgZmluZSB3aXRoIGEgcGFyYW1ldGVyLCBJJ2xsIGFkZCBpdC4g
SWYgeW91IGhhdmUgdG8gYmUgZW5mb3JjZWQgYnkgZGVmYXVsdCwgSSdtIGZpbmUgd2l0aCB0aGF0
Lg0KDQpPciwgbWF5YmUgd2UgYWRkIGFkZCBhIHBhcmFtZXRlciB0aGF0IGRpc2FibGVzIHRoaXMg
c28gdGhhdCBpbiBjYXNlIHRoaW5ncyBicmVhaywgd2UgY2FuIGF0bGVhc3QgZ2V0IGl0IGRvbmUu
DQoNCj4+PiArc3RydWN0IGFwcGxlX3NldF9vc19wcm90b2NvbCB7DQo+IA0KPiBUaGlzIHNob3Vs
ZCBiZSBhIHVuaW9uIG5vdCBhIHN0cnVjdA0KPiANCj4+PiArICAgICB1NjQgdmVyc2lvbjsNCj4g
DQo+IFRoaXMgc2hvdWxkIGJlIHVuc2lnbmVkIGxvbmcNCj4gDQo+Pj4gKyAgICAgZWZpX3N0YXR1
c190IChfX2VmaWFwaSAqc2V0X29zX3ZlcnNpb24pIChjb25zdCBjaGFyICopOw0KPj4+ICsgICAg
IGVmaV9zdGF0dXNfdCAoX19lZmlhcGkgKnNldF9vc192ZW5kb3IpIChjb25zdCBjaGFyICopOw0K
Pj4+ICsgICAgIHN0cnVjdCB7DQo+Pj4gKyAgICAgICAgICAgICB1MzIgdmVyc2lvbjsNCj4gDQo+
IC4uLiB0byBtYXRjaCB0aGUgbWl4ZWRfbW9kZSBvdmVybGF5IHdoaWNoIGlzIHUzMi4gQWx0ZXJu
YXRpdmVseSwgdGhleQ0KPiBjb3VsZCBib3RoIGJlIHU2NCBidXQgdGhlIGN1cnJlbnQgYXJyYW5n
ZW1lbnQgaXMgZGVmaW5pdGVseSBpbmNvcnJlY3QuDQo+IA0KPj4+ICsgICAgICAgICAgICAgdTMy
IHNldF9vc192ZXJzaW9uOw0KPj4+ICsgICAgICAgICAgICAgdTMyIHNldF9vc192ZW5kb3I7DQo+
Pj4gKyAgICAgfSBtaXhlZF9tb2RlOw0KPj4+ICt9Ow0KPj4gDQo+PiBIb3cgYWJvdXQgZGVjbGFy
aW5nIHRoaXMgX19wYWNrZWQsIGp1c3QgdG8gYmUgb24gdGhlIHNhZmUgc2lkZT8NCj4+IA0KPiAN
Cj4gSSBkb24ndCB0aGluayB0aGF0IGlzIG5lY2Vzc2FyeS4gSWYgdGhlIG1peGVkX21vZGUgb3Zl
cmxheSBpcyBuZXZlcg0KPiB1c2VkLCBpdCBkb2Vzbid0IHJlYWxseSBtYXR0ZXIgYW5kIHlvdSBj
YW4gdXNlIHVuc2lnbmVkIGxvbmcgdnMgdTMyLA0KPiBpbiB3aGljaCBjYXNlIGFsbCBzdHJ1Y3Qg
bWVtYmVycyBhcmUgbmF0aXZlIHdvcmQgc2l6ZSBzbyB0aGVyZSBpcyBubw0KPiBwYWRkaW5nIGlz
c3VlLg0KPiANCj4+IFdoeSAibWl4ZWRfbW9kZSI/ICBTZWVtcyBsaWtlIGFuIG9kZCBuYW1lIGdp
dmVuICJtaXhlZCBtb2RlIg0KPj4gaW4gRUZJIGNvbnRleHQgdXN1YWxseSBtZWFucyA2NC1iaXQg
T1MsIGJ1dCAzMi1iaXQgRUZJLg0KPj4gDQo+IA0KPiBUaGlzIGlzIGhvdyB0aGUgeDg2IHBsdW1i
aW5nIHdvcmtzIGZvciBtaXhlZCBtb2RlLiBFdmVyeSBFRkkgcHJvdG9jb2wNCj4gaXMgYSB1bmlv
biwgd2l0aCBhIG1peGVkX21vZGUgbWVtYmVyIGRlc2NyaWJpbmcgdGhlIDMyLWJpdCB2aWV3LiBU
aGUNCj4gYWNjZXNzb3IgbWFjcm9zIChlZmlfYnNfY2FsbCwgZWZpX3RhYmxlX2F0dHIpIGF1dG9t
YXRpY2FsbHkgZG8gdGhlDQo+IHJpZ2h0IHRoaW5nIGRlcGVuZGluZyBvbiB0aGUgYml0bmVzcyBv
ZiB0aGUgZmlybXdhcmUuDQo+IA0KPiBUaGlzIG1lYW5zLCB0aG91Z2gsIHRoYXQgZXZlbiBwcm90
b2NvbHMgdGhhdCBhcmUga25vd24gbm90IHRvIGV4aXN0IG9uDQo+IDMyLWJpdCBmaXJtd2FyZSBu
ZWVkIHRvIGJlIGltcGxlbWVudGVkIGluIHRoZSBzYW1lIHdheSwgb3IgdGhlIGNvZGUNCj4gd2ls
bCBub3QgYnVpbGQuDQo+IA0KU28gc2hvdWxkIEkga2VlcCBtaXhlZCBtb2RlIG9yIG5vdD8NCj4+
IA0KPj4+ICtzdGF0aWMgdm9pZCBhcHBsZV9zZXRfb3Modm9pZCkNCj4+PiArew0KPj4+ICsgICAg
IGVmaV9ndWlkX3QgZ3VpZCA9IEFQUExFX1NFVF9PU19QUk9UT0NPTF9HVUlEOw0KPj4gDQo+PiBN
eSByZWNvbGxlY3Rpb24gaXMgdGhhdCBpZiB5b3UgZG9uJ3QgZGVjbGFyZSB0aGlzIHN0YXRpYyBj
b25zdCwNCj4+IGdjYyBnZW5lcmF0ZXMgc3Vib3B0aW1hbCBjb2RlLiAgKEl0IGNvbnN0cnVjdHMg
dGhlIEdVSUQgb24gdGhlDQo+PiBzdGFjayBhdCBydW50aW1lIGluc3RlYWQgb2Ygc3RvcmluZyBp
dCBpbiAucm9kYXRhLikNCj4+IE1heWJlIGl0J3MgYmVjb21lIHNtYXJ0ZXIgaW4gdGhlIG1lYW50
aW1lLCBidXQgSSBkb3VidCBpdC4NCj4+IA0KPiANCj4gSSBkb24ndCByZW1lbWJlciB0aGUgZGV0
YWlscyBidXQgaXQgbG9va3MgbGlrZSB3ZSBzdG9wcGVkIGRvaW5nIHRoaXMgYQ0KPiB3aGlsZSBh
Z28uIEkgZG9uJ3QgbWluZCBrZWVwaW5nIGl0IGxpa2UgdGhpcy4NCg==

