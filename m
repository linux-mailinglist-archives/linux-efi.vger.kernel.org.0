Return-Path: <linux-efi+bounces-1329-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65A6E91D35D
	for <lists+linux-efi@lfdr.de>; Sun, 30 Jun 2024 21:18:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 884341C2089D
	for <lists+linux-efi@lfdr.de>; Sun, 30 Jun 2024 19:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84B826BFD4;
	Sun, 30 Jun 2024 19:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="NoPiWdgu"
X-Original-To: linux-efi@vger.kernel.org
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01olkn2086.outbound.protection.outlook.com [40.92.103.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7EE10F2;
	Sun, 30 Jun 2024 19:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.103.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719775117; cv=fail; b=KniSm6cHeBGIMP7Eq1pZD9QXF45j2UDSDbJGR4YPJnZvJ0lX6oEE3/9gOnGx4K/3DmRNNvz+Ak3LzK+lpEDu8p3j46xW+Un1eFzn6/aeoZGVcZec9ZQzBlCDWykz+/329KhsKPfaYPun+98D2z/K+s8gr9kR+e66eTIsP5Kfo9g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719775117; c=relaxed/simple;
	bh=L9gbShYmIiWJCYd2PiZDKI9+xODbO6tX9eCQ0Iaoh2U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=V7erXdU53AcFu3la8MXLEHb5lWovoEC+mYrF6rVhDG8oT+nM2ZR0H2bSjYgk4byXyjN9Cyamlx2tZbKhky0dOPHOx7yqy2esusBwdduSL9jgiig+03sn4msDWg610ySht4X0AoxoKyOr3SUs51K258vuIzXvZ8qF0dc+bQnV8jA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=NoPiWdgu; arc=fail smtp.client-ip=40.92.103.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EQPV7JPBEFmVpuvGxx/ROJx5yWTWwUZxAKR4z+e7A5bko1mChUG+9PPg08ejZQV2YMGuJMS23atbyH1xo9lWJZcGrJs2F8VhOZjX+vM1+k1TK1Q3Sf7xdl/SzmnRSQ5OsN1/SsgswLUYztXwjYwEvCU1aRTigqeSvKs7CdrtFdXi5qljCsOpERfoU1HsK0puySFU3WQWKk+ORFzt8vL0iuTWt+dzoqv1wecNbxhAAHN29hcm7PJRZvQWqg6j9UX2NWIzs6Wm52K3aoVLf6aBX2WxjX17AjNNPf3dSLQ/2fuYL0Q413JFQ9m6Ibps/dtLFGQffyFNGgnRf3zv7U4mbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L9gbShYmIiWJCYd2PiZDKI9+xODbO6tX9eCQ0Iaoh2U=;
 b=QEEoZeel67ZWAPYnhKY0Aqz+0iPhxuElCw/BV2uJ66gzDEq8AAR8T4KvqMhiCm9J5HH8sHM3McN5wYS/7YKomWJFjLI8gjNPFcL57cb5pV6iEao/a88cOuQB+wEUdd2Ev03kgKTHWenqneDmtTGXFrN9xKDS88CfARbKhUmH+odC7YQfQ+2P3TYVFpws9jELWHMDGxsFPr3uF9+iIoKjEMkBbOR4ct8rsxxqoV62RqFai9EC3wf9Hpxref1ICfLFBf+H/3tCn+znDY77i9cWm2S006kG24Luv8oPvSZgpdDJfpxT1UIuCRkHeVTRjfTHW9PKz29YUEqC5MNeU1998w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L9gbShYmIiWJCYd2PiZDKI9+xODbO6tX9eCQ0Iaoh2U=;
 b=NoPiWdguBicw1ytPedY7uNxnOSpxyEel+U3k25i/doI0/gtuMc4dxiTlDrUDPT5ecroFmoxWkyWF3hknnpPfhQ1NcIS+Mx7Z7AxD6Lojj2MiRweNYzsAMVwecxg2gKgVQJBgxlT2EyijF8TGqROR18NQxdLbMVM5aPrmJWulkK8GtZun2/JErG+alu8T3noT33eLtyAn6EuRLfBx1uu3yWZZS0cNnttka1SCP/JG8tBC57y1LFcV6twwptnYwXY46CNuOXfz4q6e3dfMfUe1ns+f+3K4BK40jwXOQVZmvIKwQLbumdpqxuvh3eWCsTTV05aP/AEuhM3V9WJRpyGYpQ==
Received: from MA0P287MB0217.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:b3::9) by
 PN0P287MB0962.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:16a::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7719.29; Sun, 30 Jun 2024 19:18:30 +0000
Received: from MA0P287MB0217.INDP287.PROD.OUTLOOK.COM
 ([fe80::98d2:3610:b33c:435a]) by MA0P287MB0217.INDP287.PROD.OUTLOOK.COM
 ([fe80::98d2:3610:b33c:435a%7]) with mapi id 15.20.7719.029; Sun, 30 Jun 2024
 19:18:30 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Ard Biesheuvel <ardb@kernel.org>
CC: Lukas Wunner <lukas@wunner.de>, Hans de Goede <hdegoede@redhat.com>,
	"linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>, Linux Kernel Mailing
 List <linux-kernel@vger.kernel.org>, Orlando Chamberlain
	<orlandoch.dev@gmail.com>, Kerem Karabay <kekrby@gmail.com>
Subject: Re: [PATCH] efi: libstub: add support for the apple_set_os protocol
Thread-Topic: [PATCH] efi: libstub: add support for the apple_set_os protocol
Thread-Index: AQHayqf5aNOCBZ38jE+N2QIS72Io3bHf8v+AgAA5KoCAAAepHIAAEVoAgABqFQ4=
Date: Sun, 30 Jun 2024 19:18:29 +0000
Message-ID:
 <MA0P287MB0217F7E1E5324A535CBCD8A9B8D22@MA0P287MB0217.INDP287.PROD.OUTLOOK.COM>
References: <EBE51900-DA87-4113-B389-80B9C9160F0F@live.com>
 <ZoERl1PWoc2xDGWz@wunner.de>
 <CAMj1kXFEQDir_VffzHZ0uBMjRqEReNdBZcEQs7kFhi=ipM+y9Q@mail.gmail.com>
 <MA0P287MB021713D8583D4D53C736F3D8B8D22@MA0P287MB0217.INDP287.PROD.OUTLOOK.COM>
 <CAMj1kXFucVCg39zJovVv2jzSJv-Wq6RvG9tvs5B4dvNHaCBnLQ@mail.gmail.com>
In-Reply-To:
 <CAMj1kXFucVCg39zJovVv2jzSJv-Wq6RvG9tvs5B4dvNHaCBnLQ@mail.gmail.com>
Accept-Language: en-IN, en-US
Content-Language: en-IN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn: [fMHbjoqwmdAJfMvHZ+UISR5hbozeJ5slXGPGzbf7sUc+4gVEHtD+fyf5+VOyTfyK]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MA0P287MB0217:EE_|PN0P287MB0962:EE_
x-ms-office365-filtering-correlation-id: 8b5179b7-15b8-461d-d711-08dc99396cf5
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|8060799006|102099032|4302099013|3412199025|440099028|1602099012;
x-microsoft-antispam-message-info:
 oc+6RDhVqNMV23M2e2ga1OnU/Y9psGgNuNpOQ/SyoOvSom+MdqqpOcWrfGI9g0B6EoLRJOaV7yxiSzf/2EcUmZqA2se8Yr8xp58md+rLOoFwDpvAZ2xTjWeoveNKarA8feEGJnZ9ngVFw2rAXfL44gHWoHWgoLdVmUMJgPyUW0h3SGWRfoqKErj35h2uYwYFGnHvWexa9NGRJN14Jl5G97WISFhqnRKkIflbUJwqqYW4zwuad+HpIfYp+MpQUcKDBKXrz7VBQLduvSEQ6AbMPriQY3++ECo2WjHoPPgwi5f2Xr4H4K8zPkVNS/lnPAcgjdcCUdqEweVy+V5LpjaHPWhC9vGCUNT/SgY3Nt1Q6ytb14Ep3t2rdYJz7h9gamJNeOrg+ioySQG7eZoubQ4v9lYMaYfTa56fcZM/A79XHHNq2T8hqQnSgKXMk3qvdL8G/YrFkQMERxWlqNV+iT2J2aKcIOBxvpc+PpGAGWivH0RXIeNhJ3BXjPjRAGgeK2LN5B8f3wy0Vb9G4VI8CZDNa++K3xIAr/DZ8ZpxdIHeSdp5Glupu5QmwDZfBJo60jl5gZLodqMBSe1dBYTx8PRntMiAMHSI2CNZ0Db1OQzVWaaRX5REBZX0Cys4iHhl2mDoTm5nViRbzY36YNck1SftAuO7b0Jjhzl5banf+DzmBOavuHpIBR4tj5Xh8hTA1P47LW44C/jfDX+YfyuPt+opyBb+2MT0RjgqCBEdux+YOtU=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?M082cHJQMTBvTGJKZUYzMHJ6L2RRYmFBVnA2UlVOdENsZmFwZys5cytvL1Vm?=
 =?utf-8?B?eURRUVV2MHhqWUlBUDJOUDk2QjFFQkllN3FoY2M1RXltaEtWMno1a0pXeTNT?=
 =?utf-8?B?TVhaUmtaaDROaXlnQzNCYmRhaVA2emdWTFRrU2xiZmVGMEFyNGwyS1BQK2Vy?=
 =?utf-8?B?Q3p6Mm1zYnBWOGtZbVMyS09tdHVCbWZrRkRFelVwOElTSG1vMWNweDlQb2JN?=
 =?utf-8?B?L1E0b3phenJNdTFYbGJva0o4TjRrNTV5S0poTTBJMktyL0R1TzVwYXprV1dL?=
 =?utf-8?B?NXI1bmRXbGhwcHkzaElyTnM1UmZOVlQ4dS9melJZTUQ4Y3RRRytYdVBjR1Bi?=
 =?utf-8?B?SXRBT2h0UUdrTTJnWGF6NzMwREh5bklvMTVITmxGcDRvTUtyN1VaakJDa0Jk?=
 =?utf-8?B?S0xtY2libkx1M0RaQnhCNTJxVUFBalcvUXBGcXhYR2E4OFNrTjlnWHNhNFJn?=
 =?utf-8?B?ZHNnY2twbmpvaG10TmREbkF5VmhsRmxwbzJpT2lMSnlDeWpkT3JBYi9OWkJ0?=
 =?utf-8?B?ZUxDd3U1VkRFT1o2eU5TMjVuRElYcDZGT2E2R0hlSGdYb3VONmx6ZWxxcFJF?=
 =?utf-8?B?eEhBZ1l3TDNjK1JTZitNakl6RnMwN282VzRaVlpTYVA4NlhrQnhlRHRlR1R1?=
 =?utf-8?B?MGR1NS9qVEJvWDVFTmJ4T2lKSk9TTUpNeVlOS01OekpyZnZZYTBQME1nWTEv?=
 =?utf-8?B?VXptbkN0bWp2VWJiaUF2bnN0N0V3QXJKWngzRHhiWHVCME0wMnJhb3h4MDNp?=
 =?utf-8?B?Qm91QW8xY00yRkk3czdLZjJwaG5aTzBPaWFwOFFuU3JJL3dtamtNSXRCOWsw?=
 =?utf-8?B?eElCN05VVE5hTVZXVDJIdVBCandPUEpvTFZNUXNEV21aTUI2MlZmdEJ3WjJq?=
 =?utf-8?B?cEF5ZmQyMXZ4Q2dBZ1UxcnBLczVEaThBek1RWks5T1dVcjA1MDYyKzRZb3ZF?=
 =?utf-8?B?eHkvcFZGY0d3Y0JnS1pMWGdpOU4yZkNXc00wcHJ4ZkdncmExZ2h6ZUU1VW5Y?=
 =?utf-8?B?cG1HM0lUc25SdTJRRDdwa3pHaXNERGRhaTJjQk1Vb0tHcDBxUlJmcEhwL3pl?=
 =?utf-8?B?OHRMbHRlRjlyNUxBWTZtb2VtR0s0NG1zWkdTc3dmNHB2bFlRbGVDaFNMRy8r?=
 =?utf-8?B?RFoyaU5PRElXbkF3NThLMkZjQVk5R1E2aGtZenhVR0ZoeWg4WkR3QnhHNzJM?=
 =?utf-8?B?bnZyc0dOTkJBa1dzKzB1VFVqR1RIbUZHcVJiVTBwN1BmTWlpU0tqMHVRaFNx?=
 =?utf-8?B?UnRVd2FaZFE5TjkybDZlVm1XbHYrYjFMK2dqQXVOWVY5YllIZncweTBDUnVo?=
 =?utf-8?B?T1ZpdlNnNHgybHM2V0YvL2U3bUYvUFNCemlhRVNtVU5XSHEyVXh3L1J6Tnl1?=
 =?utf-8?B?R1dwTmExR1k1bThGVnY2T2d0VG5hU0hDeXhmY2U0Rnh2OEhpQlBoT2lobU45?=
 =?utf-8?B?Z1RVZGVvcE5iZWRyVTZicGtUcFUyNmRZeFprc3dPZTlpdDRBMENidVAzbHRv?=
 =?utf-8?B?UThjZlA0NXNoOCtNblZjR0dCMnJPVXRSc1dUbnQ5bXBLeFBqaVRXS2hqT005?=
 =?utf-8?B?bUVRaEl0VnFOYUFub05hcEZacm9Tc3haK3orTU9YdFdnaXFuZkhuKzB4QlJp?=
 =?utf-8?B?eEJYaUFibHdHNjFuYVdoUU9BUHMrd0pEN1BPTXJ1d2RSTHM2SjlMa0JrNy9o?=
 =?utf-8?B?TXNFeGZBd0Foa1EraDhtLzEvL3Z3SUdMcFhSUXVGbW1oS1VXTGRIZXlWU2VH?=
 =?utf-8?Q?fZw98DKG6D4XOXlQsk=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b5179b7-15b8-461d-d711-08dc99396cf5
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2024 19:18:29.9610
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0P287MB0962

DQoNCj4gT24gMzAgSnVuIDIwMjQsIGF0IDY6MjnigK9QTSwgQXJkIEJpZXNoZXV2ZWwgPGFyZGJA
a2VybmVsLm9yZz4gd3JvdGU6DQo+IA0KPiDvu79PbiBTdW4sIDMwIEp1biAyMDI0IGF0IDEzOjU2
LCBBZGl0eWEgR2FyZyA8Z2FyZ2FkaXR5YTA4QGxpdmUuY29tPiB3cm90ZToNCj4+IA0KPj4gDQo+
PiANCj4+Pj4gT24gMzAgSnVuIDIwMjQsIGF0IDQ6NTnigK9QTSwgQXJkIEJpZXNoZXV2ZWwgPGFy
ZGJAa2VybmVsLm9yZz4gd3JvdGU6DQo+Pj4gDQo+Pj4g77u/SGVsbG8gQWRpdHlhLCBMdWthcywN
Cj4+PiANCj4+Pj4gT24gU3VuLCAzMCBKdW4gMjAyNCBhdCAxMDowNCwgTHVrYXMgV3VubmVyIDxs
dWthc0B3dW5uZXIuZGU+IHdyb3RlOg0KPj4+PiANCj4+Pj4+IE9uIFN1biwgSnVuIDMwLCAyMDI0
IGF0IDA0OjQyOjU1QU0gKzAwMDAsIEFkaXR5YSBHYXJnIHdyb3RlOg0KPj4+Pj4gQ29tbWl0IDBj
MTgxODRkZTk5MCBicm91Z2h0IHN1cHBvcnQgZm9yIFQyIE1hY3MgaW4gYXBwbGUtZ211eC4gQnV0
IGluIG9yZGVyIHRvDQo+Pj4+IA0KPj4+PiBQbGVhc2UgcnVuIHBhdGNoZXMgdGhyb3VnaCBzY3Jp
cHRzL2NoZWNrcGF0Y2gucGwgYmVmb3JlIHN1Ym1pc3Npb24uDQo+Pj4+IFRoZSBzdWJqZWN0IG9m
IHRoZSBjb21taXQgaXMgbWlzc2luZyBoZXJlIGFuZCBsaW5lcyBzaG91bGQgYmUgd3JhcHBlZA0K
Pj4+PiBhdCA3MiBvciBhdCBsZWFzdCA3NCBjaGFycy4NCj4+Pj4gDQo+Pj4+IA0KPj4+Pj4gQmFz
ZWQgb24gdGhpcyBwYXRjaCBmb3IgR1JVQiBieSBBbmRyZWFzIEhlaWRlciA8YW5kcmVhc0BoZWlk
ZXIuaW8+Og0KPj4+Pj4gaHR0cHM6Ly9saXN0cy5nbnUub3JnL2FyY2hpdmUvaHRtbC9ncnViLWRl
dmVsLzIwMTMtMTIvbXNnMDA0NDIuaHRtbA0KPj4+PiANCj4+Pj4gUGxlYXNlIGluY2x1ZGUgaGlz
IFNpZ25lZC1vZmYtYnkgYW5kIGNjIGhpbS4NCj4+Pj4gDQo+Pj4+IA0KPj4+IA0KPj4+IE5vLiBZ
b3UgY2Fubm90IHNpbXBseSBhZGQgYSBzaWduZWQtb2ZmLWJ5IG9uIHNvbWVvbmUgZWxzZSdzIGJl
aGFsZiwNCj4+PiBldmVuIGlmIHlvdSBjYyB0aGUgcGVyc29uLg0KPj4+IA0KPj4+IEFuZHJlYXMg
Y29udHJpYnV0ZWQgY29kZSB0byBHUlVCICh3aGljaCBpcyBhIEdQTHYzIHByb2plY3QpLCBhbmQg
aGFkDQo+Pj4gbm8gaW52b2x2ZW1lbnQgd2hhdHNvZXZlciBpbiBjcmVhdGluZyB0aGlzIHBhdGNo
Lg0KPj4+IA0KPj4+IEEgc2lnbmVkLW9mZi1ieSBpcyBhIHN0YXRlbWVudCBvbiB0aGUgcGFydCBv
ZiB0aGUgY29udHJpYnV0b3IgKHdoaWNoDQo+Pj4gbWF5IG9yIG1heSBub3QgYmUgdGhlIGF1dGhv
cikgdGhhdCB0aGUgY29udHJpYnV0aW9uIGluIHF1ZXN0aW9uDQo+Pj4gY29tcGxpZXMgd2l0aCB0
aGUgcmVxdWlyZW1lbnRzIGltcG9zZWQgYnkgdGhlIHByb2plY3QgaW4gdGVybXMgb2YNCj4+PiBj
b3B5cmlnaHQgYW5kIGxpY2Vuc2luZy4gTGludXggaXMgR1BMdjIgbm90IHYzLCBzbyB0aGlzIGNv
ZGUgc2hvdWxkIGF0DQo+Pj4gbGVhc3QgYmUgZHVhbCBsaWNlbnNlZCBpbiBvcmRlciB0byBiZSBy
ZXVzZWQgZGlyZWN0bHkuDQo+Pj4gDQo+Pj4gSSBkaWQgbm90IGxvb2sgYXQgdGhlIEdSVUIgcGF0
Y2gsIGFuZCBJQU5BTCwgYnV0IHRoaXMgY29kZSBpbnZva2VzIGFuDQo+Pj4gQXBwbGUgcHJvdmlk
ZWQgcHJvdG9jb2wgKHdoaWNoIGlzIHByb3ByaWV0YXJ5KSBpbiBhIGhhcmRjb2RlZCB3YXkgZm9y
DQo+Pj4gaW50ZXJvcGVyYWJpbGl0eSBwdXJwb3NlcywgYW5kIHNvIHRoZXJlIGlzIG5vdCBtdWNo
IHRvDQo+Pj4gY29weXJpZ2h0L2xpY2Vuc2UgYW55d2F5LiBJIHdvdWxkIGJlIGZpbmUgd2l0aCBo
YXZpbmcganVzdCB5b3VyDQo+Pj4gc2lnbm9mZiBvbiB0aGlzIHBhdGNoLCBidXQgeW91IGNvdWxk
IGFzayBBbmRyZWFzIGZvciBhIEdQTHYyKzMgdmVyc2lvbg0KPj4+IG9mIGhpcyBHUlVCIHBhdGNo
IGlmIHlvdSBhcmUgbm90IHN1cmUuDQo+Pj4gDQo+PiANCj4+IEkgYmVsaWV2ZSB0aGlzIHNob3Vs
ZCBiZSBHUEwyIGNvbXBhdGlibGUgc2luY2UgaXQncyBzaW1wbGUgcmV2ZXJzZSBlbmdpbmVlcmVk
IEFwcGxlIHN0dWZmIGFuZCB0aGVyZSBhcmUgbWFueSBrZXJuZWwgZHJpdmVycyB3aXRoIGFwcGxl
IHNwZWNpZmljIHN0dWZmLg0KPj4gDQo+Pj4+PiAtLS0gYS9Eb2N1bWVudGF0aW9uL2FkbWluLWd1
aWRlL2tlcm5lbC1wYXJhbWV0ZXJzLnR4dA0KPj4+Pj4gKysrIGIvRG9jdW1lbnRhdGlvbi9hZG1p
bi1ndWlkZS9rZXJuZWwtcGFyYW1ldGVycy50eHQNCj4+Pj4+IEBAIC0zOTksNiArMzk5LDggQEAN
Cj4+Pj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgdXNlZnVsIHNvIHRoYXQgYSBkdW1wIGNh
cHR1cmUga2VybmVsIHdvbid0IGJlDQo+Pj4+PiAgICAgICAgICAgICAgICAgICAgICAgICAgIHNo
b3QgZG93biBieSBOTUkNCj4+Pj4+IA0KPj4+Pj4gKyAgICAgYXBwbGVfc2V0X29zICAgIFtLTkxd
IFJlcG9ydCB0aGF0IG1hY09TIGlzIGJlaW5nIGJvb3RlZCB0byB0aGUgZmlybXdhcmUNCj4+Pj4+
ICsNCj4+Pj4gDQo+Pj4+IFdoeSB0aGUga2VybmVsIHBhcmFtZXRlcj8gIFdoeSBub3QgZG8gdGhp
cyB1bmNvbmRpdGlvbmFsbHk/DQo+Pj4+IA0KPj4+PiANCj4+PiANCj4+PiBBZ3JlZSB0aGF0IHRo
aXMgaXMgc3Vib3B0aW1hbC4gSWYgd2UgbmVlZCBhIGNvbW1hbmQgbGluZSBwYXJhbSBmb3INCj4+
PiB0aGlzLCBwbGVhc2UgbWFrZSBhZGQgaXQgdG8gdGhlIGVmaT0gbGlzdA0KPj4gDQo+PiBJJ2xs
IGxlYXZlIHRoaXMgdG8geW91LiBJZiB5b3UgYXJlIGZpbmUgd2l0aCBhIHBhcmFtZXRlciwgSSds
bCBhZGQgaXQuIElmIHlvdSBoYXZlIHRvIGJlIGVuZm9yY2VkIGJ5IGRlZmF1bHQsIEknbSBmaW5l
IHdpdGggdGhhdC4NCj4+IA0KPj4gT3IsIG1heWJlIHdlIGFkZCBhZGQgYSBwYXJhbWV0ZXIgdGhh
dCBkaXNhYmxlcyB0aGlzIHNvIHRoYXQgaW4gY2FzZSB0aGluZ3MgYnJlYWssIHdlIGNhbiBhdGxl
YXN0IGdldCBpdCBkb25lLg0KPj4gDQo+Pj4+PiArc3RydWN0IGFwcGxlX3NldF9vc19wcm90b2Nv
bCB7DQo+Pj4gDQo+Pj4gVGhpcyBzaG91bGQgYmUgYSB1bmlvbiBub3QgYSBzdHJ1Y3QNCj4+PiAN
Cj4+Pj4+ICsgICAgIHU2NCB2ZXJzaW9uOw0KPj4+IA0KPj4+IFRoaXMgc2hvdWxkIGJlIHVuc2ln
bmVkIGxvbmcNCj4+PiANCj4+Pj4+ICsgICAgIGVmaV9zdGF0dXNfdCAoX19lZmlhcGkgKnNldF9v
c192ZXJzaW9uKSAoY29uc3QgY2hhciAqKTsNCj4+Pj4+ICsgICAgIGVmaV9zdGF0dXNfdCAoX19l
ZmlhcGkgKnNldF9vc192ZW5kb3IpIChjb25zdCBjaGFyICopOw0KPj4+Pj4gKyAgICAgc3RydWN0
IHsNCj4+Pj4+ICsgICAgICAgICAgICAgdTMyIHZlcnNpb247DQo+Pj4gDQo+Pj4gLi4uIHRvIG1h
dGNoIHRoZSBtaXhlZF9tb2RlIG92ZXJsYXkgd2hpY2ggaXMgdTMyLiBBbHRlcm5hdGl2ZWx5LCB0
aGV5DQo+Pj4gY291bGQgYm90aCBiZSB1NjQgYnV0IHRoZSBjdXJyZW50IGFycmFuZ2VtZW50IGlz
IGRlZmluaXRlbHkgaW5jb3JyZWN0Lg0KPj4+IA0KPj4+Pj4gKyAgICAgICAgICAgICB1MzIgc2V0
X29zX3ZlcnNpb247DQo+Pj4+PiArICAgICAgICAgICAgIHUzMiBzZXRfb3NfdmVuZG9yOw0KPj4+
Pj4gKyAgICAgfSBtaXhlZF9tb2RlOw0KPj4+Pj4gK307DQo+Pj4+IA0KPj4+PiBIb3cgYWJvdXQg
ZGVjbGFyaW5nIHRoaXMgX19wYWNrZWQsIGp1c3QgdG8gYmUgb24gdGhlIHNhZmUgc2lkZT8NCj4+
Pj4gDQo+Pj4gDQo+Pj4gSSBkb24ndCB0aGluayB0aGF0IGlzIG5lY2Vzc2FyeS4gSWYgdGhlIG1p
eGVkX21vZGUgb3ZlcmxheSBpcyBuZXZlcg0KPj4+IHVzZWQsIGl0IGRvZXNuJ3QgcmVhbGx5IG1h
dHRlciBhbmQgeW91IGNhbiB1c2UgdW5zaWduZWQgbG9uZyB2cyB1MzIsDQo+Pj4gaW4gd2hpY2gg
Y2FzZSBhbGwgc3RydWN0IG1lbWJlcnMgYXJlIG5hdGl2ZSB3b3JkIHNpemUgc28gdGhlcmUgaXMg
bm8NCj4+PiBwYWRkaW5nIGlzc3VlLg0KPj4+IA0KPj4+PiBXaHkgIm1peGVkX21vZGUiPyAgU2Vl
bXMgbGlrZSBhbiBvZGQgbmFtZSBnaXZlbiAibWl4ZWQgbW9kZSINCj4+Pj4gaW4gRUZJIGNvbnRl
eHQgdXN1YWxseSBtZWFucyA2NC1iaXQgT1MsIGJ1dCAzMi1iaXQgRUZJLg0KPj4+PiANCj4+PiAN
Cj4+PiBUaGlzIGlzIGhvdyB0aGUgeDg2IHBsdW1iaW5nIHdvcmtzIGZvciBtaXhlZCBtb2RlLiBF
dmVyeSBFRkkgcHJvdG9jb2wNCj4+PiBpcyBhIHVuaW9uLCB3aXRoIGEgbWl4ZWRfbW9kZSBtZW1i
ZXIgZGVzY3JpYmluZyB0aGUgMzItYml0IHZpZXcuIFRoZQ0KPj4+IGFjY2Vzc29yIG1hY3JvcyAo
ZWZpX2JzX2NhbGwsIGVmaV90YWJsZV9hdHRyKSBhdXRvbWF0aWNhbGx5IGRvIHRoZQ0KPj4+IHJp
Z2h0IHRoaW5nIGRlcGVuZGluZyBvbiB0aGUgYml0bmVzcyBvZiB0aGUgZmlybXdhcmUuDQo+Pj4g
DQo+Pj4gVGhpcyBtZWFucywgdGhvdWdoLCB0aGF0IGV2ZW4gcHJvdG9jb2xzIHRoYXQgYXJlIGtu
b3duIG5vdCB0byBleGlzdCBvbg0KPj4+IDMyLWJpdCBmaXJtd2FyZSBuZWVkIHRvIGJlIGltcGxl
bWVudGVkIGluIHRoZSBzYW1lIHdheSwgb3IgdGhlIGNvZGUNCj4+PiB3aWxsIG5vdCBidWlsZC4N
Cj4+PiANCj4+IFNvIHNob3VsZCBJIGtlZXAgbWl4ZWQgbW9kZSBvciBub3Q/DQo+IA0KPiBZZXMu
IFRvIHN1bW1hcml6ZToNCj4gLSBrZWVwIHlvdXIgc2lnbm9mZiBhcy1pcw0KPiAtIGRyb3AgdGhl
IGNvbW1hbmQgbGluZSBwYXJhbSBhbmQgaGFuZGxpbmcNCj4gLSBtYWtlIHRoZSBvdXRlciBwcm90
b2NvbCBzdHJ1Y3QgYSB1bmlvbg0KPiAtIHVzZSAndW5zaWduZWQgbG9uZycgZm9yIHRoZSB2ZXJz
aW9uIGZpZWxkDQo+IC0ga2VlcCB0aGUgbWl4ZWRfbW9kZSBpbm5lciBzdHJ1Y3QNCj4gLSByZW9y
Z2FuaXplIHRoZSBjb25kaXRpb25hbCBpbiBzZXR1cF9xdWlya3MoKSBzbyB0aGF0IHRoZXJlIGFy
ZSB0d28NCj4gbmVzdGVkIGlmIGJsb2Nrcywgd2hlcmUgdGhlIG1lbWNtcCgpIGFwcGVhcnMgaW4g
dGhlIG91dGVyIGlmKCkgYW5kDQo+IGFwcGxlX3NldF9vcygpIGlzIG9ubHkgY2FsbGVkIG9uIEFw
cGxlIGhhcmR3YXJlDQoNClRoYXQncyBmb3IgdGhlIHN1bW1hcnkgQXJkLg0KDQpTZW5kaW5nIGEg
djI=

