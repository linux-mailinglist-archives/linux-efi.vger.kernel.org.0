Return-Path: <linux-efi+bounces-1446-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E933B93408D
	for <lists+linux-efi@lfdr.de>; Wed, 17 Jul 2024 18:35:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 182711C2154B
	for <lists+linux-efi@lfdr.de>; Wed, 17 Jul 2024 16:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB2AB181BBA;
	Wed, 17 Jul 2024 16:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="rSOCUfMb"
X-Original-To: linux-efi@vger.kernel.org
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01olkn2056.outbound.protection.outlook.com [40.92.103.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB388181BA0;
	Wed, 17 Jul 2024 16:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.103.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721234123; cv=fail; b=XCT+O+y074Jl2XTL7KbvAKWYxgsyMqAotP8lFGe8PLS5Gxr7DezAfH0plJ4MySWpET7yN+u2FpCNcKHtqjlMMqqL+GmKy2VwNWIO9YzdkKBFRPVsAqwxaHbdXcLwb8c4P0GpSKTwWjXre4Uh5wgt/dtyu93rPb98eQF9IXTx2H0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721234123; c=relaxed/simple;
	bh=cDLm7dkQaKz8VRzED4DNgrS8w2FKSykmVuPdQhKLQR8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XmUTTOBUaAm8R6s07X9fGEeS8+FrOGqqsDbjLZBfa+1GtAkv9wh6prM1XnFlS7Br1o7mYNAhFdnpxDui146zbXHtxhzO/9NgD2ydxHyM1IzkLtxBelpfqNqZu1NdwkQiGtsd70BN8vbsB0N0W5Ad8dSs1/x56BinI0M5O34n1Ks=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=rSOCUfMb; arc=fail smtp.client-ip=40.92.103.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iTP6+farBdTee1f1qT4kyCRd3pk0Wy6e/ere759w+t/6RYchrVxazzpH08fB8DlkPfwvYHzwQF8XNziOeLeSX1ge/mytkAq7yT5aqcWoUxNvcoqDk002nVlemZ4vnHcJG25qE1jc6eds8KUySKPyO2Y9vWDBM546G1URm7U/OZ8gE2ED77CU72exVeO+Ww3thT7s4qwaxWU8avBppY54UIxdhZ1fVOVTAO1TPpGFBiUg8bAXf8CaDbUv1u7gNN+qCmb9EBQk+S6j+VSvCG6yunTxvXZAjeYlVfhZHDZBaGUtFSxQ41gZXqJ7eELuZhZode9ETcAgohTFbbvVKf1Hrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cDLm7dkQaKz8VRzED4DNgrS8w2FKSykmVuPdQhKLQR8=;
 b=NYY7QN47eBqP/5lVvdpHYaMP0Vcd7S4TPShUmQHRYTHFBonzqu2WQlgNZboLWi+1bmXtfeO7PSVbJPnYiqPFMqfaI6jULtb+zBTct5ks8takrs9/aG9yz0gIfAjy/1zY5+YIegLGtht2SU/RkKY5OcHNOPGeGFFnQCSGNP1CE6mfZcaGXJ5LJcK14zyDnsNx9k3U0/BBJdI6CXQPcjSHlirXnUNC12DEnMy4w2+LsmNtmgcRDrh4yT6QX0bHx4Zn8oaGGtNY9N2Vg4gflXma71Sisgp6TMPOubcniY1dfoHXyej2MR5lAKvPh8urQ7BTWVBpHivsj5V9O+XuDsNnyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cDLm7dkQaKz8VRzED4DNgrS8w2FKSykmVuPdQhKLQR8=;
 b=rSOCUfMbRC8QhrU0tCwiW6Q29VkikZ2bacn3cEF7XkvwvYRpB/X1fPZEwdiB2L3yvCi7mUmnoxqBSd5iwSs4/HWCE/ZN1uZtl3icfbM34Dn9tywu8C8wg6Q2gDsoKAr2O2tCm5x+169QzDQBzFfUhR+tm3T39DtR7qzBRs2HtT8mhMXdFvBBthwUK5kvJDWmipHQtGkRqKXd78ZUqcbocH86Kt6C1IHYYBrjXWmzcHXa5ckQv7Q1XK66IKLwW3bETI2toShZnZI/8qjx2lWPSq2tPWD5jgy74/DUzprnjvYFHOYxgWgDhlpNUYoeXejbDshjReferP9pbN60iBXbDQ==
Received: from MA0P287MB0217.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:b3::9) by
 MA0P287MB1355.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:f6::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7784.18; Wed, 17 Jul 2024 16:35:16 +0000
Received: from MA0P287MB0217.INDP287.PROD.OUTLOOK.COM
 ([fe80::98d2:3610:b33c:435a]) by MA0P287MB0217.INDP287.PROD.OUTLOOK.COM
 ([fe80::98d2:3610:b33c:435a%4]) with mapi id 15.20.7784.016; Wed, 17 Jul 2024
 16:35:15 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Ard Biesheuvel <ardb+git@google.com>
CC: "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ard Biesheuvel
	<ardb@kernel.org>, Hans de Goede <hdegoede@redhat.com>, Lukas Wunner
	<lukas@wunner.de>, Kerem Karabay <kekrby@gmail.com>, Orlando Chamberlain
	<orlandoch.dev@gmail.com>, "sharpenedblade@proton.me"
	<sharpenedblade@proton.me>
Subject: Re: [PATCH v3 0/2] efi/x86: Call set_os() protocol on dual GPU Macs
Thread-Topic: [PATCH v3 0/2] efi/x86: Call set_os() protocol on dual GPU Macs
Thread-Index: AQHay8BxbD/3780MxUWT4The9rzhebHiRiV0gBjw9fM=
Date: Wed, 17 Jul 2024 16:35:15 +0000
Message-ID:
 <MA0P287MB0217E3B4810704C504F13F2CB8A32@MA0P287MB0217.INDP287.PROD.OUTLOOK.COM>
References: <20240701140940.2340297-4-ardb+git@google.com>
 <MA0P287MB0217C0F7E0B9F6FE8CA47BE8B8D32@MA0P287MB0217.INDP287.PROD.OUTLOOK.COM>
In-Reply-To:
 <MA0P287MB0217C0F7E0B9F6FE8CA47BE8B8D32@MA0P287MB0217.INDP287.PROD.OUTLOOK.COM>
Accept-Language: en-IN, en-US
Content-Language: en-IN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn: [XkhnXEVpm1SnnUhgdBViLmfAbQjeSlDm]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MA0P287MB0217:EE_|MA0P287MB1355:EE_
x-ms-office365-filtering-correlation-id: 6271af4f-5776-4048-0b73-08dca67e7030
x-microsoft-antispam:
 BCL:0;ARA:14566002|19110799003|8060799006|461199028|440099028|3412199025|102099032;
x-microsoft-antispam-message-info:
 qsMlGz7JvO4lRnP4H9o0VTN/WxeqSYj+19Ig7JIofJ3ZZI8qc7h6tbuZ3B12UUgRGlwAOZv5sYxzVf2EGFYecJkzLX+8fMNS+ovSiFPNPmbAygjZgYS9AfDv2KrDvi55rL7y1L6OqxcYr6HvXwwkmrbpG0aCFUuuMmhOoPCV91Yl6nL3oMnypCod04xTHoILayU66ScBS5rTwzZGElClfYNbLjR6FtDPgvbUrIoTwuwUwwhCwn2EhewskueVczEI9ZxYra0ADy7VL65jeMyqfW4xWPyJgCGOmzBd1vxnLKZxeWZv3/6dJ0zZomm/RJ6gz7Ah02MmFjb06EXE6NG26+J4kE94n6EvchyRfxvpV0WnDlu91jVJP+EaOJkXi6ll+T0JIgIsp2QPAqbmEGosquoTrs69+4CED6r66q9ZZCPOfLNTP1ylHVe5px5muOCGmLwKKtRZYUcoUs6f9SyQSTxNAUoc0a4hNiXy8Rbe3UB+GEVHfGDfJjTc/02y79Ew8o/3yBXPz9T4xBsW9NjJjkWcba8qt3Y2SXdFkO490Gv9KLb3GEaWh0M2rSfjWcPUx/7+0jA4Z80XE9TJUYDVRaHsJx8VYAIsNeJQhjHJp+kdpYiZfE8RkFqYZX8incnPMWhFcdrvPc1qmzy5Wffgkw==
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZTlBZitTOHFiN0c0N3pSVVhPVFYyaVhuYkswcUJUdnFBNlprR3p4aVFVSFhS?=
 =?utf-8?B?WlhRRVRaOU9oaGN0aDE5RUxVNzFFRUt1UW8yYWlYZUZQczlUMjAxT3loWDlY?=
 =?utf-8?B?TjVjaFBKNTdjdVhGSlZNbVBKRzZTaXBSWXhscVd0Z0tHcnNzNDFXbXR3bHF5?=
 =?utf-8?B?NjFYTW5icmN6Z0pLZGcvNTBFYll2M0VwZUwwRWFBNWJKekkvU2N3Nm9KUXl3?=
 =?utf-8?B?Q21ZeXllc0s1UFd4aXZoZ0psQTg5TWo1bEg2VUhKcFNFRCtzZ3VtM2pzQ3lR?=
 =?utf-8?B?dG04b3V6dTBMU0EyMGRTMFh0VzhkOWpSNFk4WG9vWjBsRjZ3Uk1vNTJWRDJq?=
 =?utf-8?B?dUJwdWd3TEoxSjJvdFYyalltS0lleDlsOHN2dlNLcFdUR2lLaHFCdlhyemp4?=
 =?utf-8?B?bUZIbVN4bC9QdDNBeVI2SEJka0plOGJISHdqeExaaS9ZdndVdVpVaUhaQUpL?=
 =?utf-8?B?RWg1aTR0WTFkTDQ5eDcxM1BBdXFhbXpHY1p1TkZxZkxoMXEzK2NpczhUVkJl?=
 =?utf-8?B?WnlCZ3gwL1d0cTB3SS94bEJGWVpzWUliZmlpaU9QTHNMUE1nT0RQVlhYSUhT?=
 =?utf-8?B?dmhoL01XOUptcFZYYUFCV0NocVhJVXNqS1RnUXM0MzRRSms2Y2QxQ2Y2YW1u?=
 =?utf-8?B?THdBamdoMWpIMjcvWjhzVElrR05UeEYwMWVkMHFLby9mSzBlcHJCbWxROTVT?=
 =?utf-8?B?Qk81SXdUL2UySTBteXlyZFBCdUpwdjF5Ni9BMVJTWlR4V2wyZlc0eEJ6NW9Z?=
 =?utf-8?B?VzlydE5kdG1WMVN2Q25FZkNoWUNKR0NhOElhQ1BydXZPdkN2dUpRYzRpTmNh?=
 =?utf-8?B?SlY5V0JHZHZ5UmEvbnRVelFkODBMUU1heHZERjFsRldybE81dkIvVXdyV0Z3?=
 =?utf-8?B?V2hTbW1XNE5kbjk0ZExWV2ZBZHhWV2VNNWl4VHdoT0liWDk0MlVlaTlpN3o4?=
 =?utf-8?B?NHFpamhzMjBYcXZrdHh2VWxlNGxFWFJNT2FNWWlSM3cyRW9VL3kvMWVvdDdJ?=
 =?utf-8?B?dk1STHFLMmVUYTcrZnJBYjBmd0tGSjBPemxOSHNJa2ovNm44NHRtamFHOUNF?=
 =?utf-8?B?WGFkWGRhbWlzcFR2NUJRZ05nWWhQOWtpQjFPQnA1eHp2SVpSbnpRSzdTcW1S?=
 =?utf-8?B?RW1qUXU2RkRjbTlxOWhjb3NKYUx3YzUyNUVYamV5a1QyOWpoOEErL2hKYk1i?=
 =?utf-8?B?UUxBcnBMaE05K3BEaGJuUDRoNXhYYXhoN0NZRi9KdXFRN3c5RG81RlFuMGRD?=
 =?utf-8?B?cWhwQm5aWldTK1BmZlhMRHhaellNRklhajQzNkFqa2dyZmVyRTlObEZ5Tjky?=
 =?utf-8?B?bkNsaFB5d1VRZkdmY2M4VmFKMWNhSll0eC90aUwxUW44cGxXWDhSU2hvRXlZ?=
 =?utf-8?B?VGxHWHpqck1LeE9iYlpIY3RoRnZNZ0drZXFTYU9FVktmOHFJbmFSL1RNajA2?=
 =?utf-8?B?WXMySHkzU0ZjQWEzQXVnNEFNNCtiRTVMSEZ0SS9UNUlIN0x2S0ZDUzlaZ1NR?=
 =?utf-8?B?bFJLaVFXRkx5bWYzLzhRbE5FQmJkZTAzQnpCdmt4a3R3UHpnQzhUMDk3TkJp?=
 =?utf-8?B?dlRDVDYreTFSR1VVMU1NT0RGWlJZRFRGNXdEdmkvSmR6OUZ2T2VLU3Z2cWJw?=
 =?utf-8?Q?MDzrqkys2Gj57eKBZXoMHBbsl7Nw5NkeNu/rlDr9qhlA=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6271af4f-5776-4048-0b73-08dca67e7030
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2024 16:35:15.7757
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0P287MB1355

SGkgQXJkLCBMdWthcw0KDQpBbHRob3VnaCB0aGUgcGF0Y2ggaGFzIGJlZW4gdXBzdHJlYW1lZCwg
YW5kIHdvcmtzIHdlbGwgZm9yIHRoZSBNYWNzIGluY2x1ZGVkLA0Kd2UgaGF2ZSBub3RpY2VkIGFu
b3RoZXIgaXNzdWUuIEZvciB0aGUgTWFjcyBoYXZpbmcgYSBzaW5nbGUgR1BVLCBpbiBjYXNlIGEg
cGVyc29uDQp1c2VzIGFuIGVHUFUsIHRoZXkgc3RpbGwgbmVlZCB0aGlzIGFwcGxlLXNldC1vcyBx
dWlyayBmb3IgaHlicmlkIGdyYXBoaWNzLiBUaGlzIHdhcw0Kbm90IHJlcG9ydGVkIHRoYXQgdGlt
ZSBieSBhbnlvbmUgc2luY2UgcGVvcGxlIHdobyB1c2UgYW4gZUdQVSBhcmUgcXVpdGUgcmFyZS4N
Cg0KSSdtIG5vdCBzdXJlIGhvdyB0byBoYW5kbGUgdGhpcy4gSGFkIGEgZmV3IGlkZWFzIGxpa2U6
DQoNCjEuIEVuYWJsZSB0aGlzIGZvciBhbGwgVDIgTWFjcy4NCjIuIEVuYWJsZSB0aGlzIGZvciBh
bGwgTWFjcy4NCjMuIEFkZCBhIGtlcm5lbCBwYXJhbWV0ZXIuDQoNCldvdWxkIGxpa2UgeW91ciBp
ZGVhcyBhbmQgYSBwb3NzaWJsZSBmaXggZm9yIHRoZSBzYW1lLg0KDQpUaGFua3MNCkFkaXR5YQ0K
DQo+IE9uIDIgSnVsIDIwMjQsIGF0IDE6MTLigK9BTSwgQWRpdHlhIEdhcmcgPGdhcmdhZGl0eWEw
OEBsaXZlLmNvbT4gd3JvdGU6DQo+IA0KPiDvu79UZXN0ZWQtYnk6IEFkaXR5YSBHYXJnIDxnYXJn
YWRpdHlhMDhAbGl2ZS5jb20+DQo+IA0KPiBUaGFua3MgZm9yIHRoZSBzdXBwb3J0IEFyZCA6KQ0K
PiANCj4+IE9uIDEgSnVsIDIwMjQsIGF0IDc6NDDigK9QTSwgQXJkIEJpZXNoZXV2ZWwgPGFyZGIr
Z2l0QGdvb2dsZS5jb20+IHdyb3RlOg0KPj4gDQo+PiDvu79Gcm9tOiBBcmQgQmllc2hldXZlbCA8
YXJkYkBrZXJuZWwub3JnPg0KPj4gDQo+PiB2MzoNCj4+IC0gYWRkIHBhdGNoIHRvIG1ha2UgdGhl
IFNNQklPUyBwcm90b2NvbCBnbHVlIGNvZGUgY29tcGF0aWJsZSB3aXRoIG1peGVkDQo+PiBtb2Rl
IG9uIHg4Ng0KPj4gLSB1cGRhdGUgQWRpdHlhJ3MgcGF0Y2ggdG8gbGltaXQgdGhlIGVmZmVjdCB0
byBkdWFsIEdQVSBNYWNzIHRoYXQgYXJlDQo+PiBrbm93biB0byByZXF1aXJlIHRoZSBzZXRfb3Mo
KSBjYWxscyBpbiBvcmRlciBmb3IgYm90aCBHUFVzIHRvIHJlbWFpbg0KPj4gYWN0aXZlIGFmdGVy
IGJvb3QNCj4+IC0gZHJvcCBtaXhlZCBtb2RlIGhhbmRsaW5nIG9mIHNldF9vcygpIHByb3RvY29s
LCBhbmQgZGVyZWZlcmVuY2UgdGhlDQo+PiBzdHJ1Y3QgbWVtYmVycyBkaXJlY3RseQ0KPj4gDQo+
PiBDYzogQWRpdHlhIEdhcmcgPGdhcmdhZGl0eWEwOEBsaXZlLmNvbT4NCj4+IENjOiBIYW5zIGRl
IEdvZWRlIDxoZGVnb2VkZUByZWRoYXQuY29tPg0KPj4gQ2M6IEx1a2FzIFd1bm5lciA8bHVrYXNA
d3VubmVyLmRlPg0KPj4gQ2M6IEtlcmVtIEthcmFiYXkgPGtla3JieUBnbWFpbC5jb20+DQo+PiBD
YzogT3JsYW5kbyBDaGFtYmVybGFpbiA8b3JsYW5kb2NoLmRldkBnbWFpbC5jb20+DQo+PiANCj4+
IEFkaXR5YSBHYXJnICgxKToNCj4+IHg4Ni9lZmlzdHViOiBDYWxsIEFwcGxlIHNldF9vcyBwcm90
b2NvbCBvbiBkdWFsIEdQVSBJbnRlbCBNYWNzDQo+PiANCj4+IEFyZCBCaWVzaGV1dmVsICgxKToN
Cj4+IGVmaXN0dWIveDg2OiBFbmFibGUgU01CSU9TIHByb3RvY29sIGhhbmRsaW5nIGZvciB4ODYN
Cj4+IA0KPj4gZHJpdmVycy9maXJtd2FyZS9lZmkvbGlic3R1Yi9NYWtlZmlsZSAgIHwgIDIgKy0N
Cj4+IGRyaXZlcnMvZmlybXdhcmUvZWZpL2xpYnN0dWIvc21iaW9zLmMgICB8IDQyICsrKysrKysr
LS0tLQ0KPj4gZHJpdmVycy9maXJtd2FyZS9lZmkvbGlic3R1Yi94ODYtc3R1Yi5jIHwgNzIgKysr
KysrKysrKysrKysrKysrKy0NCj4+IGluY2x1ZGUvbGludXgvZWZpLmggICAgICAgICAgICAgICAg
ICAgICB8ICAxICsNCj4+IDQgZmlsZXMgY2hhbmdlZCwgOTggaW5zZXJ0aW9ucygrKSwgMTkgZGVs
ZXRpb25zKC0pDQo+PiANCj4+IC0tDQo+PiAyLjQ1LjIuODAzLmc0ZTFiMTQyNDdhLWdvb2cNCj4+
IA0K

