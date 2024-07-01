Return-Path: <linux-efi+bounces-1338-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC89191D84F
	for <lists+linux-efi@lfdr.de>; Mon,  1 Jul 2024 08:53:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 758FF281598
	for <lists+linux-efi@lfdr.de>; Mon,  1 Jul 2024 06:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C06CF4EB45;
	Mon,  1 Jul 2024 06:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="t+GpeVU3"
X-Original-To: linux-efi@vger.kernel.org
Received: from IND01-MAX-obe.outbound.protection.outlook.com (mail-maxind01olkn2063.outbound.protection.outlook.com [40.92.102.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA4810A0E;
	Mon,  1 Jul 2024 06:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.102.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719816784; cv=fail; b=rpvZK1A8/FtUc1uOeKEtHvoLaATxgQr3m6x8ANsKUbp5WTfeVb8BbUVlUdO4zE2wOmvc7a5o8xhgBNjsC9FtJ22LXHK5ZzJBOJt/fQCJPKDRsZHZILee+61VlS85wshIif5LD9yx6tB+WdWCIYOUnylG7vUeI6yVv0FETGb9Sm8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719816784; c=relaxed/simple;
	bh=j4xcWmCrkdyF1Xed1xF22ukdB3zl+tceJvf0O9Z7OIA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lbokMRh6ikFIXJtPJT0auaS9XT4yM1RV2vsesLNFt7fQOvC9evezZjiBJ3ZLJAkXrXwW6cc4hVLLGWWIC4rJwfjCrwrqSBtY8S94ZnNZscOZ77L+o9yBCny9o4V7dWnmx/ZYaznbodXaK42WTMS78UhkX9PhM/BEOH+xiVWTlFQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=t+GpeVU3; arc=fail smtp.client-ip=40.92.102.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PpOjSid5ByPXncrWfO7/YS0Sb+hlLF4Mfcptw2jRHMHUWR1qsE+vk86wJIF4bvNsxPGKv9qa/IG3g2biGirdpzfMvmnp0QrbmFMRqkzz/8GE6jyI38bF0TRIHtM7AeCik4GaLREtrxNx6Sr4FnTZh11msEwRqcAn9lQDcMax0hJNMrlZVYH6M9fFMNwyQm2ndVyA0W4tj3OtppfFYynGG71YoIbURiae5XJXDGGNGEoPu9cUgGKfkwAS6CZE0UNkE0sAbmF8bXq5+1dAlNxm9OPxk+VfYG6mXb6ubn0rzgIorPtOYIVwzPHlm6aIyYubE3aupuHCdgCImCAIlJtcPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j4xcWmCrkdyF1Xed1xF22ukdB3zl+tceJvf0O9Z7OIA=;
 b=iJ7NyEb9tm3SrJu32X3yo4U5FctuV/aV2cUimZ/fM8nn0Alz3YIfObGuyBy62ByGxppmXYYfCEp2aiFMJDei6jVlIOEyx5VAc9eR6qaKORabehFQ1qUnrRvtVm3bP/aI/FbFDT8QggNGNKbsJxjoHcT9ApowHyYfFu/z4C0nxhn1b7uqwu9YR2hCmSC1se97R+Z5QePCltDEQZjK1em1vF4gpTjseJIbDr28wnVlrMkNuv2w1QNxIGs+bEPXjABssh90MFbAy2tbasUGBdTxd6sUiLlPa0D/5ZL0OYpKIOfLVRXK1dQLLqzGuyGtvxLVwaEk1AZru3NFntfDH/bYUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j4xcWmCrkdyF1Xed1xF22ukdB3zl+tceJvf0O9Z7OIA=;
 b=t+GpeVU3JUkw8e8C9xFY0/iC6Z08aTU+dmClIovsnWLxvbpTNMQe9fqFidPAiq9eakcmvX5OvYIhNQxv7nTiIyk/YLjVWx+hbJmNpYUBCKgseHkx8O7NxyyS0dbyLGI4ox91vGO8r36SjRa33gGdTM8rpex3HKoD1KlqpQO+Zils80wSFixMO8BT3aw07Fe9PPm7oHkvRR5l3MbU19bUXIX4C0gvnnJ7jrnxbF1cYnLp9Aa3H0aFVqV7IRmhQIbwX0WGp1nYOpdb9KwG374sh8ZnHgNh5WgY8fWCr+9yN5a1Fz0QphNCsag3M/JM9ec9jQ2HI0KMep8QO8xSfkDjJw==
Received: from MA0P287MB0217.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:b3::9) by
 PN2P287MB2091.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:1c4::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7719.32; Mon, 1 Jul 2024 06:52:57 +0000
Received: from MA0P287MB0217.INDP287.PROD.OUTLOOK.COM
 ([fe80::98d2:3610:b33c:435a]) by MA0P287MB0217.INDP287.PROD.OUTLOOK.COM
 ([fe80::98d2:3610:b33c:435a%7]) with mapi id 15.20.7719.029; Mon, 1 Jul 2024
 06:52:57 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Ard Biesheuvel <ardb@kernel.org>
CC: Lukas Wunner <lukas@wunner.de>, Hans de Goede <hdegoede@redhat.com>, Linux
 Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>, Kerem Karabay
	<kekrby@gmail.com>, Orlando Chamberlain <orlandoch.dev@gmail.com>
Subject: Re: [PATCH v2] efi: libstub: add support for the apple_set_os
 protocol
Thread-Topic: [PATCH v2] efi: libstub: add support for the apple_set_os
 protocol
Thread-Index: AQHayyMw+x8Tv3BlDUuYLD8zHzW0zLHhWosAgAABBwCAAANoAIAAAXYAgAAP5cw=
Date: Mon, 1 Jul 2024 06:52:57 +0000
Message-ID:
 <MA0P287MB0217E9997DD69512C71BB2BEB8D32@MA0P287MB0217.INDP287.PROD.OUTLOOK.COM>
References: <75C90B50-9AB9-4F0A-B2CD-43427354D15C@live.com>
 <ZoJAAifMqIDXdniv@wunner.de>
 <CAMj1kXH3fvS259Y1mfYcKQbM2mUYbSfuf2ZiMXfFhjq-rzn5UA@mail.gmail.com>
 <ZoJDuunseVIDua-m@wunner.de>
 <CAMj1kXFKBsAXDLxinqiszH=6hEOjbJQL-nFgBsBceta4rUCN-w@mail.gmail.com>
In-Reply-To:
 <CAMj1kXFKBsAXDLxinqiszH=6hEOjbJQL-nFgBsBceta4rUCN-w@mail.gmail.com>
Accept-Language: en-IN, en-US
Content-Language: en-IN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:
 [Yrtrti+l3fnRcB1ibG6oexqXrEW560/yscu6sXcLKyCej9wjf/Gh0e/7d4ij0UtwxOEQqzsskGM=]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MA0P287MB0217:EE_|PN2P287MB2091:EE_
x-ms-office365-filtering-correlation-id: 9a31a239-59dc-4a6c-83a3-08dc999a7093
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|8060799006|3412199025|440099028|102099032;
x-microsoft-antispam-message-info:
 4On+9rBk72m8LnQo/umLWMVjp6SC6CsMam2L02+brVBUsyx/cU819Q4uW8ymLa6Sdw1YFO0bETX7sia4oEapp/ObHkN9UGk5fPXp50X6zghCf402b5LT76+AJU9Btq0icGGcfpO+OuqcBLwHg6N/DX4oqZI+tUOlEoZaKqXSQ9mxZxxBWWXNwODnLgrfEHOZOs/7FAZyEc/ijpYAqAZV3bfCEBGeXSbjLilH10uVgUdMhBWP+NP5YxgejQhOXa+UMYMtA/hGfmIdeIPTDp4BzHt0evMF5wCcGT7grhDBnBzNHo3ZKBfvNVZxIzcak6LQnumWvfvMhmvRxmStnbeQ/4qWPLWPwdPX7rA5CvkgkwfSKLaFbsr7nhoZN3L1e9SO5CB3wjzZtR+DzEKjtXIeAjOjEZuyPFby79oFb9wQx73qjAmciWidwzc2mPkHCJGS4qgVEUqVMObbgtoAHmC1VhEKzrM0hVNRmUHc1E5D36lWdFYGyyFC+ntFM9LBBOuaayBK8hngdIu9dUvAZkL6YFGpWkoyv+7JWB9e5vuoCYNttgthmY7xDp0sINhRfH3iAG9MFReDan/4k3y+1hH3QDymQQU1RpwOGyvZlYUPiW+VdLXPgMy7papI0TTEhDmu
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TXhPeE5Xd3ZyTDg0USsxSStPU01pOG1keFdYaXdNN0hRQjNyZDR0MjV0ZWJs?=
 =?utf-8?B?Z081SllUUFpVQjBPdm1SRmc1WEhxdDV2a2E2QUFMUUM1cm9uUk1DM25uYW9W?=
 =?utf-8?B?a2V2UHIzSGYyYkdnUFdYN2lPVTZWNC9IUENNNnk3OUU3WG0wYXV4cVZrc0Fj?=
 =?utf-8?B?QWVpVWkwc3praGZIVzNNa3N4MXdUTlRIMnFYQVYwTjJjcnpjdU9adTVCUTl2?=
 =?utf-8?B?VXB1T0RMVlV3MDZNTm9oZ0RXVU10THVaaUZCS0hCVW1Ic1BoRVNqOVJRSHpF?=
 =?utf-8?B?UThrTkV2TmV1Qlk3dWdaekpOd0N6VkVDQjUzV0VnQmkxZDBqbHFUeXA1d1Fj?=
 =?utf-8?B?cjFGS1p4L21hWlBrU2UrUXVjRFZKZ2JSaFVjSUhFeTB0L0dVM2dVYzFUMUNS?=
 =?utf-8?B?MGVhRXVaQ0lDaU9iVXFJYVNiTzRkcVg0MUV4Z1BxUDZCM1loOFhlVjlqdUJz?=
 =?utf-8?B?YmIyUVJpOWNpakdDOEtWemxIK29BU3B3b0NtUzNsdG5PQnNLa2kyOWpZV2dS?=
 =?utf-8?B?aTM3SVg1a1UwNWg1UEJkNkdFVDFLakZoN0VhV1k3N01vVXNteDMrWEdJbU1t?=
 =?utf-8?B?bDE4SEVseENaZmhHb3d2TklFb3plTFBvUDZCUEp0QTNicDVaZThpdTZXVk05?=
 =?utf-8?B?UHdKT1AxQ0ttRXVLa1BIVUx1OTV0dVRxYmdIeHFENXVvZGFlRkpIMUw3T1g5?=
 =?utf-8?B?VTlSNU5sNFR3eVYzVWtVRTBkb2o0OGQ5QVJMN3dndHJNbVlLVnAwT0NuMG5S?=
 =?utf-8?B?N0dodHcwdlk4Y2NlbkVQemxwQzZxaWFaTUdoQnl4TWFIYXFvMHpCYUZLUHAw?=
 =?utf-8?B?ZTlGOWdMdjA4cThhZ2tHRnBjVUpKaXo3WERGTGJPVnN0UHhoMEFrUm9NUldh?=
 =?utf-8?B?TGMrOFJyMmJ6dHNObG1venZ0ZWJWTUZ2YUFaS3NUMjc5SkFEbmlRaHhyQXAz?=
 =?utf-8?B?cFdXK3FtM2tENVlld3FRcUlHWjVSd2ErSWRvSzZFaWJKQXRabDlFQ0tsNWtm?=
 =?utf-8?B?eU1ZQWN3UTNOQUh0R0piNVY3bDUzNDhmazhsemc3V05wWWppMzdSZFBNNXBR?=
 =?utf-8?B?clZtMThneS9CdjQ2RWkwb3JrZ2VoaWNaRnNOSExCQUlyc0dybjlhQzdTeVBB?=
 =?utf-8?B?aS93bG0zeGNJRm94SlZsK2lZa1pZVE1JbGFqNUtudzdmMnhFengvVTlxTDdT?=
 =?utf-8?B?SHl4ZjVwUWJwR2JBcXE5QmNXNlZjSlVqTkYrMFZndmZUTkdIUG9aVU9ETW5M?=
 =?utf-8?B?eWFMMCtBcEtxWHh6MEphUlM5NThMRlE3UUZTNVloeFZpbFhETWRPY0RvVGhs?=
 =?utf-8?B?dFRKMFR1aUdSemlDRTk4QXAwWjY3QlMrVkErajFhWXYvOWJLUlhMaHlvL09T?=
 =?utf-8?B?bXd5Z1pLcW4zTjJ1NVVQN3F1dVZXemhZczVjUE8wU2lTaWQxWWVQRENVQXdW?=
 =?utf-8?B?bCt1NXhtSENQanJKem16Rm1nY2JDS0djU2hWZUhMVFBLQlFiZDRiQTNmc3Rz?=
 =?utf-8?B?RVhHMXU0MG4zSFZlMk5mZ1ltekpIV0VNNVZiNGJDMGpFaGo5Wk5qNjFrMWVQ?=
 =?utf-8?B?UTVpZFNTQ3YwWlp2YlgrekNNRXNLU3kvL2JMUzJZNDAra1JGQThZaS9LOTVE?=
 =?utf-8?B?NGVNVHJ5WHE4WkdjbHVLUVM0dEZvRmRFZGNKU2dhZjQyTm1CRWZrZjFEVTJI?=
 =?utf-8?B?a2c5cWVRekhCNW9XYmFsanFMSTgxVEg1ckxFZDVqT3JDakhHMG1KTHRtTTJw?=
 =?utf-8?Q?q0iuoxThzJlfL4M0FY=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a31a239-59dc-4a6c-83a3-08dc999a7093
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2024 06:52:57.2392
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2P287MB2091

DQoNCj4gT24gMSBKdWwgMjAyNCwgYXQgMTE6MjbigK9BTSwgQXJkIEJpZXNoZXV2ZWwgPGFyZGJA
a2VybmVsLm9yZz4gd3JvdGU6DQo+IA0KPiDvu79PbiBNb24sIDEgSnVsIDIwMjQgYXQgMDc6NTAs
IEx1a2FzIFd1bm5lciA8bHVrYXNAd3VubmVyLmRlPiB3cm90ZToNCj4+IA0KPj4+IE9uIE1vbiwg
SnVsIDAxLCAyMDI0IGF0IDA3OjM4OjM4QU0gKzAyMDAsIEFyZCBCaWVzaGV1dmVsIHdyb3RlOg0K
Pj4+IEFueSB0aG91Z2h0cyBvbiB3aGV0aGVyIHRoaXMgc2hvdWxkIGRlcGVuZCBvbiBDT05GSUdf
QVBQTEVfR01VWCBvciBub3Q/DQo+PiANCj4+IEkgdGVuZCB0b3dhcmRzICpub3QqIG1ha2luZyBp
dCBkZXBlbmQgb24gQ09ORklHX0FQUExFX0dNVVg6DQo+PiANCj4+ICogVGhlIGdwdS1zd2l0Y2gg
dXRpbGl0eSBPcmxhbmRvIGxpbmtlZCB0byBkb2Vzbid0IHVzZSB0aGUgYXBwbGUtZ211eA0KPj4g
IGRyaXZlci4gIChJdCBjaGFuZ2VzIEVGSSB2YXJpYWJsZXMgdGhhdCBpbmZsdWVuY2UgdG8gd2hp
Y2ggR1BVIHRoZQ0KPj4gIEVGSSBkcml2ZXIgd2lsbCBzd2l0Y2ggb24gbmV4dCByZWJvb3QuKQ0K
Pj4gDQo+PiAqIGFwcGxlX3NldF9vcygpIGhhcyBzaWRlIGVmZmVjdHMgYmV5b25kIGV4cG9zaW5n
IHRoZSBpR1BVIChzdWNoIGFzDQo+PiAgc3dpdGNoaW5nIHRoZSBrZXlib2FyZCt0cmFja3BhZCBh
Y2Nlc3MgbWV0aG9kIHRvIFNQSSBpbnN0ZWFkIG9mIFVTQikuDQo+PiAgSWYgdGhlcmUgYXJlIGlz
c3VlcywgdGhleSB3aWxsIGJlIGhhcmRlciB0byBkZWJ1ZyBpZiB0aGVpciBvY2N1cnJlbmNlDQo+
PiAgZGVwZW5kcyBvbiBhIEtjb25maWcgb3B0aW9uLg0KPiANCj4gVW5kZXJzdG9vZC4gSSBhZ3Jl
ZSB0aGF0IGhhdmluZyBmZXdlciBwb3NzaWJsZSBjb21iaW5hdGlvbnMgaXMNCj4gc3Ryb25nbHkg
cHJlZmVycmVkLg0KPiANCj4gSG93ZXZlciwgdGhpcyBjaGFuZ2UgYWZmZWN0cyBhbGwgSW50ZWwg
TWFjcy4gSXMgdGhlIGxhdHRlciBzaWRlIGVmZmVjdA0KPiBsaWtlbHkgdG8gY2F1c2UgYW55IHJl
Z3Jlc3Npb25zIG9uIEludGVsIE1hYyB1c2VycyB0aGF0IGRvbid0IGhhdmUgdHdvDQo+IEdQVXMg
dG8gYmVnaW4gd2l0aD8NCg0KSXQgZG9lc24ndCBhZmZlY3QgVDIgTWFjcyB3aXRob3V0IGR1YWwg
R1BVLCBJJ20gbm90IHN1cmUgYWJvdXQgb3RoZXIgTWFjcywgYWx0aG91Z2ggSSBkb3VidCBpdCB3
b3VsZCBjYXVzZSBhIHJlZ3Jlc3Npb24uIEFsdGhvdWdoIG9mIHRoZSByZWFzb25zIG9mIGFkZGlu
ZyBhIHBhcmFtZXRlciB3YXMgdGhpcyBjb25jZXJuIGFzIHdlbGwu

