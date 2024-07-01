Return-Path: <linux-efi+bounces-1359-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E02E691E8C1
	for <lists+linux-efi@lfdr.de>; Mon,  1 Jul 2024 21:42:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E5611C215BD
	for <lists+linux-efi@lfdr.de>; Mon,  1 Jul 2024 19:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A381516F850;
	Mon,  1 Jul 2024 19:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="oLkUAGBV"
X-Original-To: linux-efi@vger.kernel.org
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01olkn2086.outbound.protection.outlook.com [40.92.103.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B60E16D9BA;
	Mon,  1 Jul 2024 19:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.103.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719862964; cv=fail; b=jFp0znKqWd2SZpLsuLPhkeNJGKUwrjpeCbT/DzE0maxkn82di0YDxzhnYoOOhXK85wRJyI94IHQw5He1qchMEcL5XN/JZMqEjTffZAiqTyl5QSc8eRZdMl9wPdRpA8bnvh6bVpN5FrvzeGZF62eV/Ykcp9lSm7+DMrFozRFDj9U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719862964; c=relaxed/simple;
	bh=RAvnN17HZpYue492q/YMWi1m6TbYF1SkRg9pEk81quI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LbpWzQuKJaBD7/2jdp/inzGam+2Oe0IWQIu3jgLZB0gWwGNmTLG6U9fay49zXTyI8X1i1flwbp1VHytKNH4uN6N4rKbpJEG6VSMcC6++HVUwfPrd1jv/kyCnYpney40saFKqyCe31fEJcAUorbufy/sUYLtCpRx9++nIhdMY+ps=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=oLkUAGBV; arc=fail smtp.client-ip=40.92.103.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hzlmUEvqbQWQv2djekGenYO3y0zNjGJekIB4LrQVDDNVkBsaB2pdFq8jSSG8szcoMzDUEgu1E5Mh3XOxzDeq15F2lizbI0Pblfng4sG9QexFQwSVwpB5bIld4lcMLSkvePnHlYJGaWiVUrvVSIuF7J7vtg3lLT+X0B++3YTLkH9keuz3i6tE0O8MGWv4nBCwRrQF4jSe+5rSWUrL6/VRiM6+i7TwaVfebd7qVXfTx925H2ULAt0kJd/1fY8l5G11uobI4nOQ7Aj/LQbNqj1jKwrk7w2ru2jrNKaQIcIUDeMVSfodZxj4EZ7bD6Ye1gMJNEAY4cZaZdf3SACt7q/TUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RAvnN17HZpYue492q/YMWi1m6TbYF1SkRg9pEk81quI=;
 b=IgJTOSHRvBn0XdHthK1d9vjq2ad1bqH7ddSOyuYCCJYvx/vm6ZwG4izuPWYx+NYHqaVAtx6RTyMhJAUPp2wJeaIZNv4Sz8bOrp27ap+biwAj2+i33Tbep1TrW6SZeCLdcK3FswJmEXc52A26uyihC+YaqI4Hcp/RLBFAJzdJ8FeXTfhiSwLIgZBL+r8MXSx7EV1CxGzETj7ckQ4FfhDrHKzwEvJb5YXU+cHWrcHVHIh1RAI25WsXDRTLVUTRsmPD//MzYvthLnJd0xBnDOYmoSU4nc83hDnxNZdrJhqKeccwRBeG9ZpiSJpMtdXTGGxSE0Ze3lNeirOVLtXsw9c68A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RAvnN17HZpYue492q/YMWi1m6TbYF1SkRg9pEk81quI=;
 b=oLkUAGBVWotrA/FbteqjAsSzsCQiw8z0btfHbsdClFfaFbWyWeLsMuK0qZby87D23q3AK3cb5pRIdLufsjkN69HY4ClrB+ROcOfLcAk54wAJ7WHEP3YLVLOfEqc3V9+EceyyqCdxD9jai45m9gMnCvbeI2P3qPgvfM0aTVbB7d2yktlSvYxXuS/ON9uTJVe6G2mqQNw3GyNz1+9jbAtdxDIcfxCTiDB3Cy7jLHuOuz/gsIgYYBrm/JPTcSjgR/RNX7sbkTC579mQzYpGyGAolQ3BG5pQHJqR7hSD6CucR5DEZfQgDNh1sYwrEwEmF9BTbxr+mjPIj1XEeOyq4MYuRQ==
Received: from MA0P287MB0217.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:b3::9) by
 PN0P287MB1990.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:1be::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7719.32; Mon, 1 Jul 2024 19:42:37 +0000
Received: from MA0P287MB0217.INDP287.PROD.OUTLOOK.COM
 ([fe80::98d2:3610:b33c:435a]) by MA0P287MB0217.INDP287.PROD.OUTLOOK.COM
 ([fe80::98d2:3610:b33c:435a%7]) with mapi id 15.20.7719.029; Mon, 1 Jul 2024
 19:42:37 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Ard Biesheuvel <ardb+git@google.com>
CC: "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ard Biesheuvel
	<ardb@kernel.org>, Hans de Goede <hdegoede@redhat.com>, Lukas Wunner
	<lukas@wunner.de>, Kerem Karabay <kekrby@gmail.com>, Orlando Chamberlain
	<orlandoch.dev@gmail.com>
Subject: Re: [PATCH v3 0/2] efi/x86: Call set_os() protocol on dual GPU Macs
Thread-Topic: [PATCH v3 0/2] efi/x86: Call set_os() protocol on dual GPU Macs
Thread-Index: AQHay8BxbD/3780MxUWT4The9rzhebHiRiV0
Date: Mon, 1 Jul 2024 19:42:36 +0000
Message-ID:
 <MA0P287MB0217C0F7E0B9F6FE8CA47BE8B8D32@MA0P287MB0217.INDP287.PROD.OUTLOOK.COM>
References: <20240701140940.2340297-4-ardb+git@google.com>
In-Reply-To: <20240701140940.2340297-4-ardb+git@google.com>
Accept-Language: en-IN, en-US
Content-Language: en-IN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:
 [FzU/UOv+4LsefLbUugMVPQilqYNZruikVb0hel7gKb+kvYOuufWyoaicMO9hAzKXUkzSDRGhxbw=]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MA0P287MB0217:EE_|PN0P287MB1990:EE_
x-ms-office365-filtering-correlation-id: 2f1ecdff-747f-40cf-d7f6-08dc9a05f5cc
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|8060799006|102099032|3412199025|440099028;
x-microsoft-antispam-message-info:
 Q2CUPDWWTTZlqaCSAVOsgyAyx9tu2FB8TuJShqYYn/j9NjEg17OtKNUTIQzyzAYsc1AkyAed2zlRtC19d2Q7t/UjGsC96G7jY62YuB+Ps68ebx+FcXYPF5IuRpW1j3mRfrd2ScOBIZxIYf9GhCbUIVgi8coaPwgu4g9qIim9fj4wBQs1rnq744lTexzhlKVeEM1zZfovdBtv23lndatI7UYBQnbrqA2wFmvF5xFuwpSX2bg2EO9kXaTaLR2vuJhU8PjGJt+vb9FGMfBzaYfBjgghpFGP8VbHirfhvVUpi2K96W7voZLeakTLcA0iLCXE2k6kkWCta6YPFNSMIywd444JxOzfhtOYtWnDpfqNOiYyB30vucmgIHAqQCB6oUK1+szCUex5bQop7LkC0PKSqgZacMkfcHYMRfJBF13qsqwd4DBL+G5F7iY/82FwaRRTgKhYKbVRD6TMevROqEdBuLjb/cp1DqBrwFPz/Ihe4kIclwK9dNcxQcUWUS4Wq2rpWzD9SLe1gptnX++1pJuEHkv4nRTaWit2akZVFr4LxHCCrCwPHOGhCb4zbZtpjJOgcCQN7ZV0uOOfPsZGVLcQAEJWoJAwhd38MLXaP0Ag0LokZSSQRwtJnTCR/xSUa1pD
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TUVJbTcrcWVGVHJ2Zll2Q2Fhd1hiS0c0Tmo4UjMzLy9NNXBFdXhXRit6bzVS?=
 =?utf-8?B?T1V4a1Uza2JjWktUWmJWVFRaOTRaZnBQTVBXTVZ3V2RoeExKMjhxajdaaDNE?=
 =?utf-8?B?YklKVElzS1FHVDYydWM3bmUyV1VlbEZheHg1TGVucTJEVThWUUJHTTR2ZVd4?=
 =?utf-8?B?bVQzS1BMUFRSaWJkMk1lanVCUlRYcG1RT0pBd2ZnaU5wMS82dDlheHNadlZN?=
 =?utf-8?B?d1VIaVJkdGxSampNYndYeXF6L0R1OWl0MnFxcWlSbjI4WEdGSzVqNVBEeFZU?=
 =?utf-8?B?VHRjTjFNdjhzcnUrTFVRRklTQ1hjbU5wM3p5SzlKZHZnczJneENXcFlFbWVW?=
 =?utf-8?B?ejMrNHRmajdBMStiUmRTSFc4VHk5ZTBNY1FkTEwvcUFxV25vOU5SSDViR2g3?=
 =?utf-8?B?ZVB1Wnc0UlRmQkdFc1hxTlp1K0RNSVQxYmM5UldmVFVjSDUxZm54cTFsSVc1?=
 =?utf-8?B?eDB0b2FjMkZWVkh6SC9BMFBEVFVuOUJTN3pJR2p6MmM3Snd5WEpuK3BRdTZB?=
 =?utf-8?B?TTl6UU1Xc2RZdHhMNkVXblJ2ME1ZTmZwYkxMQlRIcWRWUy9kWGJjYjJmUkFj?=
 =?utf-8?B?MytFM2FMck1BUzg1K3cwS0RPNjhURmxqN1Q2eUdaWmpEd3Y1dSs2d01LemtN?=
 =?utf-8?B?MUtJZEtDRzRLTlpKczc2eSttalJRTXFqTlhuQkFPYkpaUFkyTkRKRkFPOStW?=
 =?utf-8?B?UHFIR0FaZDYzVElQSU5uWTJJQXhPZ2hIM0hFa1RCcUFkbTNPd2d3cmFFd1No?=
 =?utf-8?B?Nmc4MkVpMWU4RFlBV1gvbGRKREZsdzN4d25Vdy9hV05xbHlKZjJBRHhxVVNx?=
 =?utf-8?B?VHJOY0pJbTBTeFBMZlgwNHM0TkozVFh4eENucTFvNXd0Y3BIWWYvbS8yT3V2?=
 =?utf-8?B?SWpoZTZhd0J0NVNVcE80RzRWbnhyYWQ3U2pXcDJ1YkJDRDhGbnNPdlJIUTBM?=
 =?utf-8?B?ZE1rWVJXc05zUjhBUVhxR00rWis5MkdYMEk0N0pMZzF3QnRVQnpzZnVIbmxS?=
 =?utf-8?B?V2FrVTNxOE56ZkI1eE13Q2JlYkhFM2Z5UU8vV3N4ZTlNZXh5bDdlWXp5OU5t?=
 =?utf-8?B?cGZabEdGb280Q2FqYmFHT0pXWGo1UXdrR1VWRENVY1JYTDhkQzduZWlPdVRw?=
 =?utf-8?B?cG0wWmJGSWttR1hXNStSengzdUZjMmkzYW5JbWRqWWRXQ1F4TmhYcDNtbVh5?=
 =?utf-8?B?WHFZRFBUYUNjN3BFc1RjUFpySTZmT0orRlMzWDRnLzRta3hneHVySEpyclNj?=
 =?utf-8?B?UEliM05vYkg5Z1JSQW9iOG1DQzYzS0p2K09DL2hXSWx2S3N5TjZNbjFuUDZR?=
 =?utf-8?B?clFJWUtaOFZhdjh0QzdqcEJpdGlFakJIeVlFc3FNNUJHRk9hOTl0WUNLUE1o?=
 =?utf-8?B?TnNQNGwwSUhid3pBQlVOelh3Nk84NnVrRVcrWVNTOThVdjNQUkdIMUtqWWVG?=
 =?utf-8?B?TWhoSnRBQUh0Vk9hdnhwVnVhdVFMS29HRTUwYWhJeG5Ca05TUXB2blNBZW05?=
 =?utf-8?B?SWZCcFBPaXhJc2YzMmNKL284UHM4bGcxbzR6STAwVXM3QnJ4Ni9Tb0lhYVY1?=
 =?utf-8?B?S24vNzRaN2FCWDBNMzVBWGdnOXRIVlRUTXFZdzFONXAvbE1LTmNXMjZKTmlX?=
 =?utf-8?B?MVdBWStaazUrRGMzNEJNLzdQTWx5ek0rZjFsUmpWbjJ0NkszUkZPSUpNMEUv?=
 =?utf-8?B?aWxseWtPMXdlODNPNkRtd3l1YTd1ZFVBcFFhNzMrdHgyZlpwL0VSdU92RHBp?=
 =?utf-8?Q?0nylTHeMc8H9O8n4fI=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f1ecdff-747f-40cf-d7f6-08dc9a05f5cc
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2024 19:42:36.8899
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0P287MB1990

VGVzdGVkLWJ5OiBBZGl0eWEgR2FyZyA8Z2FyZ2FkaXR5YTA4QGxpdmUuY29tPg0KDQpUaGFua3Mg
Zm9yIHRoZSBzdXBwb3J0IEFyZCA6KQ0KDQo+IE9uIDEgSnVsIDIwMjQsIGF0IDc6NDDigK9QTSwg
QXJkIEJpZXNoZXV2ZWwgPGFyZGIrZ2l0QGdvb2dsZS5jb20+IHdyb3RlOg0KPiANCj4g77u/RnJv
bTogQXJkIEJpZXNoZXV2ZWwgPGFyZGJAa2VybmVsLm9yZz4NCj4gDQo+IHYzOg0KPiAtIGFkZCBw
YXRjaCB0byBtYWtlIHRoZSBTTUJJT1MgcHJvdG9jb2wgZ2x1ZSBjb2RlIGNvbXBhdGlibGUgd2l0
aCBtaXhlZA0KPiAgbW9kZSBvbiB4ODYNCj4gLSB1cGRhdGUgQWRpdHlhJ3MgcGF0Y2ggdG8gbGlt
aXQgdGhlIGVmZmVjdCB0byBkdWFsIEdQVSBNYWNzIHRoYXQgYXJlDQo+ICBrbm93biB0byByZXF1
aXJlIHRoZSBzZXRfb3MoKSBjYWxscyBpbiBvcmRlciBmb3IgYm90aCBHUFVzIHRvIHJlbWFpbg0K
PiAgYWN0aXZlIGFmdGVyIGJvb3QNCj4gLSBkcm9wIG1peGVkIG1vZGUgaGFuZGxpbmcgb2Ygc2V0
X29zKCkgcHJvdG9jb2wsIGFuZCBkZXJlZmVyZW5jZSB0aGUNCj4gIHN0cnVjdCBtZW1iZXJzIGRp
cmVjdGx5DQo+IA0KPiBDYzogQWRpdHlhIEdhcmcgPGdhcmdhZGl0eWEwOEBsaXZlLmNvbT4NCj4g
Q2M6IEhhbnMgZGUgR29lZGUgPGhkZWdvZWRlQHJlZGhhdC5jb20+DQo+IENjOiBMdWthcyBXdW5u
ZXIgPGx1a2FzQHd1bm5lci5kZT4NCj4gQ2M6IEtlcmVtIEthcmFiYXkgPGtla3JieUBnbWFpbC5j
b20+DQo+IENjOiBPcmxhbmRvIENoYW1iZXJsYWluIDxvcmxhbmRvY2guZGV2QGdtYWlsLmNvbT4N
Cj4gDQo+IEFkaXR5YSBHYXJnICgxKToNCj4gIHg4Ni9lZmlzdHViOiBDYWxsIEFwcGxlIHNldF9v
cyBwcm90b2NvbCBvbiBkdWFsIEdQVSBJbnRlbCBNYWNzDQo+IA0KPiBBcmQgQmllc2hldXZlbCAo
MSk6DQo+ICBlZmlzdHViL3g4NjogRW5hYmxlIFNNQklPUyBwcm90b2NvbCBoYW5kbGluZyBmb3Ig
eDg2DQo+IA0KPiBkcml2ZXJzL2Zpcm13YXJlL2VmaS9saWJzdHViL01ha2VmaWxlICAgfCAgMiAr
LQ0KPiBkcml2ZXJzL2Zpcm13YXJlL2VmaS9saWJzdHViL3NtYmlvcy5jICAgfCA0MiArKysrKysr
Ky0tLS0NCj4gZHJpdmVycy9maXJtd2FyZS9lZmkvbGlic3R1Yi94ODYtc3R1Yi5jIHwgNzIgKysr
KysrKysrKysrKysrKysrKy0NCj4gaW5jbHVkZS9saW51eC9lZmkuaCAgICAgICAgICAgICAgICAg
ICAgIHwgIDEgKw0KPiA0IGZpbGVzIGNoYW5nZWQsIDk4IGluc2VydGlvbnMoKyksIDE5IGRlbGV0
aW9ucygtKQ0KPiANCj4gLS0NCj4gMi40NS4yLjgwMy5nNGUxYjE0MjQ3YS1nb29nDQo+IA0K

