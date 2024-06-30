Return-Path: <linux-efi+bounces-1318-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B65391D0C2
	for <lists+linux-efi@lfdr.de>; Sun, 30 Jun 2024 11:13:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A463B20F99
	for <lists+linux-efi@lfdr.de>; Sun, 30 Jun 2024 09:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B651C12CDBE;
	Sun, 30 Jun 2024 09:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="QA7+EmVQ"
X-Original-To: linux-efi@vger.kernel.org
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01olkn2083.outbound.protection.outlook.com [40.92.103.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B2A7B3FE;
	Sun, 30 Jun 2024 09:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.103.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719738821; cv=fail; b=YD+No3abSGCXYmzAgaChT3EclQ60+z7M1WT5Mw/91FcxUXATkJT7xP7X/0y6XsMZku1ACmZM1oI3Kyenj/qxsvTzpEyiS1u/BxtDQ/gVL1MC/KoNoOaDKFiAImFBkZ/WYS/r4QpDcSlgCVjfNZHhj93AtwBQyBa9joDPX2d6dCU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719738821; c=relaxed/simple;
	bh=2vhgJvnXE0OfVIl9MpiUxSGpKsrDYK1YRba7eHpEagc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=At0V9c+Za6/udOaO6m3fbHoxDQ6+5liwiTgVxcb5y/92ZzwUVSL0JxLIgRGvEEPVHH9I7D1YHQEfjvYmUJqHimqrZ4s56rv1co8BkWDxyeuPYx8zhq77vRlQ7zjzdjj5IXTDkrJgIXONNMo4AHbrr2ATpHU7sEV15pj2rvZFmBk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=QA7+EmVQ; arc=fail smtp.client-ip=40.92.103.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZcLgFWEjmeODAJ3eZgMjz14Lgk5y80FuYCU24+zDusZq/1ITeH/wKUZ80n7TsuX2i8fxH8yYM8lnmZ9Z9wxKw4QKtobN+XuCe5nkK5tvHKX07sMrTtxfGhVyq8TnbwTr+k5PySUIDMo8iAdwgCoiraTpPcwWE8yvBokTvuAYS5BapNIv735fj9XGYD4RjDlEpNMha7ahsavlEyq6axxnhwVts5ksTzkA0IzitJpP9khHGAMoRQsKEj61RLLgf0pXbh97O7jknEJ3sNZhFrmAsu//6yRpGXr+OUgsA7BDzqslWXJJXIPjR8fiX7foXruUo1UzLisDVVVt8WhssNlZOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2vhgJvnXE0OfVIl9MpiUxSGpKsrDYK1YRba7eHpEagc=;
 b=YAn1XeLidzK5mmSoXYk66tJFRTFxRCsvxGlZ/ZZ6LXYVh1Dbf59Bq0/oVlVqE0bjexXe/fRCVQjO7wq3EOukaDH6mV1lBclFpzH7ARVynh7XfFQP+jPhe1xpUSG9qd2vI3h6+ppH4IgLfOQRTN6kgejTy/geNWddB09f3YlUkWSZIZpnQ4IwnutLa5ZAXWpQQfN1bK+tPgoWzPH1UAcVPmtaoczdqY4xu6CYXxogZ7qC4qbmWol0EDHR1p6acs+5XrJ8y8fBhIWPeyxG9+w5kex8dENjtRc59F4mQ/FRoSPvC4ZMdoEpt+UzHRlQM/WVUByxv0MZZuFS25s0ccp7UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2vhgJvnXE0OfVIl9MpiUxSGpKsrDYK1YRba7eHpEagc=;
 b=QA7+EmVQ92X1hGzsm+iWQTr6fi39KtddG/8ySH070qRjklmZk5GwrVAHWeGcdAziNky98ztFtrXU4h71O9QZkjxcdY/TQFSGcnUuVRrk0QorfLXOT+6shgTC16FyoI6RcDjhuPMbfKKFuq+xbKecNzcJVAPG+FAYvFKR/1gtglWtR/rTSgLbPEjDr0/GKDhv7muag3pLzTxg9eeVDGguMolBPLl8WlV40ye+9UVsCbCRi6DhIMQFXZS+2WJ8vOEX4cvlMKObTAnUvy+chbuRRnK/R17ETleutuRxiEsFQlM18GucMw751pACUV3uM9/9E4+2e0Sb8XNaI3H/rGdoPA==
Received: from MA0P287MB0217.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:b3::9) by
 PN0P287MB1463.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:180::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7719.29; Sun, 30 Jun 2024 09:13:34 +0000
Received: from MA0P287MB0217.INDP287.PROD.OUTLOOK.COM
 ([fe80::98d2:3610:b33c:435a]) by MA0P287MB0217.INDP287.PROD.OUTLOOK.COM
 ([fe80::98d2:3610:b33c:435a%7]) with mapi id 15.20.7719.028; Sun, 30 Jun 2024
 09:13:34 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Lukas Wunner <lukas@wunner.de>
CC: Ard Biesheuvel <ardb@kernel.org>, Hans de Goede <hdegoede@redhat.com>,
	"linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>, Linux Kernel Mailing
 List <linux-kernel@vger.kernel.org>, Orlando Chamberlain
	<orlandoch.dev@gmail.com>, Kerem Karabay <kekrby@gmail.com>
Subject: Re: [PATCH] efi: libstub: add support for the apple_set_os protocol
Thread-Topic: [PATCH] efi: libstub: add support for the apple_set_os protocol
Thread-Index: AQHayqf5aNOCBZ38jE+N2QIS72Io3bHf8v+AgAATQSM=
Date: Sun, 30 Jun 2024 09:13:33 +0000
Message-ID:
 <MA0P287MB021730971A804FB760463A39B8D22@MA0P287MB0217.INDP287.PROD.OUTLOOK.COM>
References: <EBE51900-DA87-4113-B389-80B9C9160F0F@live.com>
 <ZoERl1PWoc2xDGWz@wunner.de>
In-Reply-To: <ZoERl1PWoc2xDGWz@wunner.de>
Accept-Language: en-IN, en-US
Content-Language: en-IN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn: [KTM2GMpQ/a24PQOVPcjApWFUC4MZ7uUcExOB3/sAduVOE3rgFFggF3ILEBtTxywb]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MA0P287MB0217:EE_|PN0P287MB1463:EE_
x-ms-office365-filtering-correlation-id: 2df132a6-a1c0-4710-0542-08dc98e4eadc
x-microsoft-antispam:
 BCL:0;ARA:14566002|8060799006|461199028|4302099013|102099032|3412199025|440099028|1602099012;
x-microsoft-antispam-message-info:
 /Wn30+hVAkh2kVvi2Gi1lEJg3PbGVDJp+M4bV8jxEelbo8XkSDy+LmhQAOFo88lSsYXoWylH/nwy+6oiIXT5wDCAOubvzHgyP/EvV2EimX+WySIINQEbSznzAn95m9Xv6Fw614GLBK/6yXV9FwbEkpOrOhPLoCvxPldS3YfWWeBuOcE1DCqrANdlrPUrJXzJwIvS0RsQy35LrpRB0Xncdgvs2WON9QFEKw8EHfeDrFAH8EeKfNXlgoXeAzBzREhOvLMdiu7oAClogjfwI2+TBiQVEOn9COf3RJ+v7q+ESQsNEx5vWr4ZK58cfbabyqx9ahlfA1W8wTXcfc3dSzpsiE5q7WRubcpk7mEI9dskkWc75vIkmdU8sBYkXaIBZlSGZ6kDoVx3EmGc/TP9g08RXNoTNrfwtITor63cjh2dTpm020cfp5nTWXtyLl5nNN9C3r/z/q0rtFHowjsZqj8rhCN19xA0p76otgEnj5RpvW9WOhY4w1VfF2pDxx/KnxtATzMVND9hwf3/PEGyvS2v1/GqrTku89vW+9dXAQFvNpFFaSTkzfm0yxLOTp8HOQrvKywYeRRsTYfyQEWrxbnn+9KBb/yNUoys2MyhAk+Kp2mTnQIUIQbUyZVI+TtRm+sXrCdjo4dZlf40Zru3QRpiTPkAQ4ogYhHyY6H4mRsyLHihJTmyfURy8UmApOcXsfrbd2ZHd81pvwt+hY9dBDwC+NIWHxQtMvN7/T7IHTUYhZM=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VlJ6ZmNWemNnbEpiZnA2YkdGRyt3SXJnMkFTWG9uejFlQzNGL2FkMGNEN0ds?=
 =?utf-8?B?WGVZR1Z3cWExU0hIWkhXcUQ5YnRZdjJYTkNqcGs3SE1CaFVzYUpCNnRZYXJJ?=
 =?utf-8?B?OC9tRUpMUDJCZ01hOFh1R3N1TmkxQ1ZwKyttUlFHdUt4UW0rYS81M0ZEdFRW?=
 =?utf-8?B?UjhFaHBqZk5NWjZSSEZ5N0ZaMGhOZXdUMG01bTkxSk9ySzRCM2RYeG5HYXBI?=
 =?utf-8?B?aUtSYkV2OFVqbVZvSWVUUk5zcWNPU0tya0RhZXVsR0lFM0tqaUhpbmNscFVS?=
 =?utf-8?B?TnBWaE5YRHMySDNxQlBqM2xBWnQwVTZiYU1ib2pURkhYejVCT29hd2FTb2xO?=
 =?utf-8?B?bys0SythUVJtbW1RSG1CaFgrUFpUS3l1WFhqSEY1UFd4VjhWMlFMamJ4aDVL?=
 =?utf-8?B?eU1vSG9hWEFzOWpOL1NtazBXcnNxREJrWGR6bnhKQWptT1YvMDhUcWQySWpD?=
 =?utf-8?B?SWVEemExTWpQUGwzMi9BSjVIL3pidFAwMGw2M3oxdWZRZ3E1Y0h2N3dkbHZx?=
 =?utf-8?B?UVlIa1JLQ21WUVpNWkc2QUVNRmhUekJSMlVkbW1MVGN2Zm1CdUZrdFhrWXB6?=
 =?utf-8?B?MS9HMzFlSjNyV3VRdXhVQU1zNExmbUNZOTlMbTBJWWlpU0ZNdFM3MFdCR3NX?=
 =?utf-8?B?bUl2eEtsUy95cWphU1p3bmpHNnFtUXljUUNDMGlEQlFud3BVd3VNQjgxTUtj?=
 =?utf-8?B?MFFucDBkY1E5WUhibmFDN0JpVGQ0R3dWYkNDUWhIVWJKRW1EMk9FNktFU0JN?=
 =?utf-8?B?T0dRcGZMNGdZRDc1OHE3elhHT3pLbEtmRnoxRWVubG01b3dLQkdwNjJLTWZh?=
 =?utf-8?B?WDBvQkIyVHVvam5OLzVJQ3hXd1VoLzhWMWZwclY0aGZvU24yMzRnVGVhQi8r?=
 =?utf-8?B?NkZvK3Y1QzR3dHlhTGE0UTBVQnFVeHF1NzJuQ0FDWW9DVGJkNFdabEUrU1Jo?=
 =?utf-8?B?Tms3Z2t6emlQb0pPZVlFQ29VTUZlbENTZ3lSZFhGQVpYSkYxOXVRVXN3UFVF?=
 =?utf-8?B?TkpUNVlTWmd5WUFVSlpWVWkwb0hHUlBqWEtMTEhwbXRvemhTNjBwendvQmpN?=
 =?utf-8?B?aDhDcGNLVTI2S201NFZ5UlNJbzdtdncrQTVURjVFNEhIQVdPa0JjRUNiNm41?=
 =?utf-8?B?NzJNQnpGZGNqclg5Z2RLWjF5ajRzdlQ5UWEyWENJZE9iTjVWajNVaytSREwv?=
 =?utf-8?B?d1pBd2ZaZjJyRngraWE2ekZ4ZUVteWVzc2Jia3dGRUZWUjE2K1JvQW5SSTlk?=
 =?utf-8?B?UmJZRTJ2V1ZiYVUxRG11NXhJOW9KcExWYXJ2VFlkUWsvajEwQyt5aDdmQ1R4?=
 =?utf-8?B?YWJCVTZ2Y3JscGlJcGhuRGFDcFdwZDUzdlJSbkpkSThPbGNrRGJzM1dCNXJJ?=
 =?utf-8?B?M2FIUkJvQVJyTmdsbk5NR2dQQTNQQ3FUaWdnTnFWbzRnbENoRXVvOUxSa0k0?=
 =?utf-8?B?TkFXa0V6dnk2QWlINlFOT1prSWo4RU1Uc2hQU05FcTV2N3pPSTYrRzZtZHU4?=
 =?utf-8?B?Z1l1RlNpQlBFNVZzb214a2VWKzdzYlF4d3prTkpRQ0FpRzF2Tzl6OU5IUHEx?=
 =?utf-8?B?VktkUEN1bXNpT3NJUWNEWG1nZGlkRHBZOWFIS2UyV1RNaE1NSnVMR2lJSnp4?=
 =?utf-8?B?T2wwdXlqcWhmaUxvb2k4Y2pZM28wVi9rYmUwS0owMXpVaU5kKzh3eDRwczV0?=
 =?utf-8?B?Ny9SOG8rQjgxVEN3Mk1UczdYVDZ2TGMwUzdXT1BPc1BITDdtRE1OaVBoZjNk?=
 =?utf-8?Q?IyZrk0LbBmd+kPE0hw=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2df132a6-a1c0-4710-0542-08dc98e4eadc
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2024 09:13:33.9705
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0P287MB1463

SGkgTHVrYXMNCg0KPiBPbiAzMCBKdW4gMjAyNCwgYXQgMTozNOKAr1BNLCBMdWthcyBXdW5uZXIg
PGx1a2FzQHd1bm5lci5kZT4gd3JvdGU6DQo+IA0KPiDvu79PbiBTdW4sIEp1biAzMCwgMjAyNCBh
dCAwNDo0Mjo1NUFNICswMDAwLCBBZGl0eWEgR2FyZyB3cm90ZToNCj4+IENvbW1pdCAwYzE4MTg0
ZGU5OTAgYnJvdWdodCBzdXBwb3J0IGZvciBUMiBNYWNzIGluIGFwcGxlLWdtdXguIEJ1dCBpbiBv
cmRlciB0bw0KPiANCj4gUGxlYXNlIHJ1biBwYXRjaGVzIHRocm91Z2ggc2NyaXB0cy9jaGVja3Bh
dGNoLnBsIGJlZm9yZSBzdWJtaXNzaW9uLg0KPiBUaGUgc3ViamVjdCBvZiB0aGUgY29tbWl0IGlz
IG1pc3NpbmcgaGVyZSBhbmQgbGluZXMgc2hvdWxkIGJlIHdyYXBwZWQNCj4gYXQgNzIgb3IgYXQg
bGVhc3QgNzQgY2hhcnMuDQo+IA0KV2lsbCBmaXggaXQgaW4gdGhlIG5leHQgcmV2aXNpb24uDQo+
IA0KPj4gQmFzZWQgb24gdGhpcyBwYXRjaCBmb3IgR1JVQiBieSBBbmRyZWFzIEhlaWRlciA8YW5k
cmVhc0BoZWlkZXIuaW8+Og0KPj4gaHR0cHM6Ly9saXN0cy5nbnUub3JnL2FyY2hpdmUvaHRtbC9n
cnViLWRldmVsLzIwMTMtMTIvbXNnMDA0NDIuaHRtbA0KPiANCj4gUGxlYXNlIGluY2x1ZGUgaGlz
IFNpZ25lZC1vZmYtYnkgYW5kIGNjIGhpbS4NCk5vdCBzdXJlIGFib3V0IHRoaXMgc2luY2UgdGhl
IHBhdGNoIHdhcyBzZW5kIHRvIGdydWIgYW5kIG5vdCBsa21sLCBhbmQgaGlzIHdvcmsgaGFzIGJl
ZW4gdXNlZCB3aXRob3V0IGluZm9ybWluZyBoaW0gZm9yIHRoaXMgcGF0Y2ggc29sZWx5IG9uIHRo
ZSBiYXNpcyBvZiBHUEwuDQoNCkkndmUgYWx3YXlzIGJlZW4gY29uZnVzZWQgaW4gc2lnbmVkLW9m
Zi1ieSBpbiBjYXNlIG9mIGF1dGhvcnMgd2hvc2Ugd29yayBoYXMgYmVlbiB1c2VkIHdpdGhvdXQg
dGhlaXIgZXhwbGljaXQgY29uc2VudCBqdXN0IGJlY2F1c2UgdGhlIGxpY2Vuc2UgcGVybWl0cyBp
dC4NCg0KU2hvdWxkIEkgc3RpbGwgYWRkIGhpcyBzaWduZWQtb2ZmLWJ5Pw0KPiANCj4gDQo+PiAt
LS0gYS9Eb2N1bWVudGF0aW9uL2FkbWluLWd1aWRlL2tlcm5lbC1wYXJhbWV0ZXJzLnR4dA0KPj4g
KysrIGIvRG9jdW1lbnRhdGlvbi9hZG1pbi1ndWlkZS9rZXJuZWwtcGFyYW1ldGVycy50eHQNCj4+
IEBAIC0zOTksNiArMzk5LDggQEANCj4+ICAgICAgICAgICAgICAgICAgdXNlZnVsIHNvIHRoYXQg
YSBkdW1wIGNhcHR1cmUga2VybmVsIHdvbid0IGJlDQo+PiAgICAgICAgICAgICAgICAgIHNob3Qg
ZG93biBieSBOTUkNCj4+IA0KPj4gKyAgICBhcHBsZV9zZXRfb3MgICAgW0tOTF0gUmVwb3J0IHRo
YXQgbWFjT1MgaXMgYmVpbmcgYm9vdGVkIHRvIHRoZSBmaXJtd2FyZQ0KPj4gKw0KPiANCj4gV2h5
IHRoZSBrZXJuZWwgcGFyYW1ldGVyPyAgV2h5IG5vdCBkbyB0aGlzIHVuY29uZGl0aW9uYWxseT8N
CjEuIE5vdCBhbGwgTWFjcyBoYXZlIGR1YWwgR1BVLiBXZSBkb24ndCB3YW50IHRvIHVubmVjZXNz
YXJpbHkgImZvb2wiIHRoZSBmaXJtd2FyZSBpbiB0aGlua2luZyBtYWNPUyBpcyBiZWluZyBib290
ZWQuDQoyLiBhcHBsZS1nbXV4IGlzIGEgcmV2ZXJzZSBlbmdpbmVlcmVkIGRyaXZlciwgYWx0aG91
Z2ggdXBzdHJlYW1lZCwgbm90IHZlcnkgZWZmaWNpZW50IGluIHN3aXRjaGluZyBHUFVzLiBTbyBp
dCdzIGJldHRlciB0byBtYWtlIHVubG9ja2luZyB0aGUgR1BVIG9wdGlvbmFsLiArIG5vdCBldmVy
eW9uZSB3YW50cyB0aGUgaW50ZWwgR1BVLCBwZW9wbGUgYXJlIGhhcHB5IHdvcmtpbmcgd2l0aCB0
aGUgZGVkaWNhdGVkIEFNRCBHUFUgKHVzZWQgYnkgZGVmYXVsdCBpZiBhcHBsZV9zZXRfb3MgaXNu
J3QgZW5hYmxlZCkuDQo+IA0KPiANCj4+ICtzdHJ1Y3QgYXBwbGVfc2V0X29zX3Byb3RvY29sIHsN
Cj4+ICsgICAgdTY0IHZlcnNpb247DQo+PiArICAgIGVmaV9zdGF0dXNfdCAoX19lZmlhcGkgKnNl
dF9vc192ZXJzaW9uKSAoY29uc3QgY2hhciAqKTsNCj4+ICsgICAgZWZpX3N0YXR1c190IChfX2Vm
aWFwaSAqc2V0X29zX3ZlbmRvcikgKGNvbnN0IGNoYXIgKik7DQo+PiArICAgIHN0cnVjdCB7DQo+
PiArICAgICAgICB1MzIgdmVyc2lvbjsNCj4+ICsgICAgICAgIHUzMiBzZXRfb3NfdmVyc2lvbjsN
Cj4+ICsgICAgICAgIHUzMiBzZXRfb3NfdmVuZG9yOw0KPj4gKyAgICB9IG1peGVkX21vZGU7DQo+
PiArfTsNCj4gDQo+IEhvdyBhYm91dCBkZWNsYXJpbmcgdGhpcyBfX3BhY2tlZCwganVzdCB0byBi
ZSBvbiB0aGUgc2FmZSBzaWRlPw0KWW91IG1lYW4gInN0cnVjdCBfX2F0dHJpYnV0ZV9fKChfX3Bh
Y2tlZF9fKSkgYXBwbGVfc2V0X29zX3Byb3RvY29sIHsiID8NCj4gDQo+IFdoeSAibWl4ZWRfbW9k
ZSI/ICBTZWVtcyBsaWtlIGFuIG9kZCBuYW1lIGdpdmVuICJtaXhlZCBtb2RlIg0KPiBpbiBFRkkg
Y29udGV4dCB1c3VhbGx5IG1lYW5zIDY0LWJpdCBPUywgYnV0IDMyLWJpdCBFRkkuDQoNCkVGSSBm
aXJtd2FyZSBvbiBUMiBNYWNzIGRvZXNuJ3Qgc2VlbSB0byBmb2xsb3cgdGhlIHN0YW5kYXJkIEVG
SSBzcGVjcyAoZXhwZWN0ZWQgZnJvbSBBcHBsZSkuIEVhcmxpZXIgaXQgY2xhaW1lZCB0byBmb2xs
b3cgRUZJIDIuMCwgYnV0IHdlIGhhZCB0byBmb3JjZSBsaW51eCB0byB1c2UgRUZJIDEuMSBmb3Ig
aXQuIFNvIGFzIGZhciBhcyBBcHBsZSBpcyBjb25jZXJuZWQsIHlvdSdsbCBnZXQgdG8gc2VlIHN1
Y2ggc3RyYW5nZSB0aGluZ3MuDQoNCkkgZ3Vlc3MgdGhpcyBzdHJhbmdlIGJlaGF2aW91ciBpcyBi
ZWNhdXNlIHRoZSBUMiBzZWN1cml0eSBjaGlwIGhhbmRsZXMgdGhlIEVGSS4NCg0KDQpJJ2xsIHdh
aXQgZm9yIHlvdSByZXBsaWVkIGJlZm9yZSBzZW5kaW5nIGEgdjIu

