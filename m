Return-Path: <linux-efi+bounces-1349-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F50291DCE3
	for <lists+linux-efi@lfdr.de>; Mon,  1 Jul 2024 12:40:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 198B8283132
	for <lists+linux-efi@lfdr.de>; Mon,  1 Jul 2024 10:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17E6A5D477;
	Mon,  1 Jul 2024 10:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="Mh9P0cAw"
X-Original-To: linux-efi@vger.kernel.org
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01olkn2088.outbound.protection.outlook.com [40.92.103.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D5B39FD0;
	Mon,  1 Jul 2024 10:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.103.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719830421; cv=fail; b=keD4iiZy2k/qyhV2F4ZWqCXAu0PVwci8b3mfQu5BsVLbQ6g0di/Kd0mQ4P6hd04Rb4P17i/0iCUyolLtSDYi5/mUQ6uFt102N2PAz5ZBXG6AhzhIM0bvAZTVF4lMWiSHHOujpeWuKzs3lThw7PZ8p9PyomN89GqbKI7caDQOE1U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719830421; c=relaxed/simple;
	bh=N/4g83z2UD1kX/EI2d2FbEAQxEz3C+cK0KW2l6lJ/lo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=b5OjaCSjNYtOEAvSy9Rgdj7KWQiaRhRLk3Ds/mLF66cWbzYg+pFxnpniegD8OL8RMzyJ8TcRyhBCBWkbZv2ClH5IsPU4ZvTlI1uAqXzjLRqjeqDDRcJ1954GTPXxPYFso4WsC4pO0ZkdwrM9RYKRtovf42vhA1kfAwRunpxVI8o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=Mh9P0cAw; arc=fail smtp.client-ip=40.92.103.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oe25NMWevSen5zuwHsZMHWhPScGlZwH6ggq9fh4qeRYntvrB3Zevj0oUnzX9gDvhyjayGCYYEDFbL15Z2cpks6PdllXJyDkEi9JQaGrkK0hr6W3WVB6lb2ETsTHGeXz01eEK69WRuZeXed5Ng1yLJtlIF5PVf+6dEl+F01B4c/cl5tKc82yt1IgUCzeCfTIlhP7yyWMAMIMKDl7txRw6oO9IIYzrZzyurYzcfI/LRfrAbRaO9pHqTUJ148/QjeJ5nkedXRX+ghzZP0PhLdb+mN6nfvJ4YgccTuECUSTnbro0MnkSUYlHJjWoM2TJxhiUvP0o2aS33/t+Wq4mmArYXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N/4g83z2UD1kX/EI2d2FbEAQxEz3C+cK0KW2l6lJ/lo=;
 b=V4I4A4sprOLiVQ3kkOtm4SGvmeLuXasFzwjEZnon9jibB1pVvTO5Bzor/LggCwm4a8J6O1EIl1vAox8PFbl41M/zCR7PwBPB3AqJJhcbjDqa4ImSYuGv+hPuGHNL2yTxp/ZDI4qMIxb1xkRqBEdFhAabsdQ+eV0Z62/th8E37pf50lKkLtNNkhVn2LsJ2CfQy+0MX3/qgNr55eZ5Fwuv6Xu/3Gl652DpkSPTb+MRXrA348Oy9DizlnBhZGWAy12+vS51gxQB2VBGVw7UY2aaTggmS10wEkf9H/xZkjA0PluXV778Udyj6X1c9Va8e6KT3kw52UtnB1Wuc/FWY00uZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N/4g83z2UD1kX/EI2d2FbEAQxEz3C+cK0KW2l6lJ/lo=;
 b=Mh9P0cAwSt4gKfbny7ar/x/GFV7nIqYgSgoF75uRZiKKipp3506VhdIpRPCH4U9z3W/Y03J5LHqDPmTq+uyKYIvs+pFEmGgzumaEeS+RGLBFZy8qTvzvP6n3KDXaG/xC/2WkS50Yn3Uv5MlMEvVRw0wZ8haeRuWmmlY7BGNVfifkkx/RsEDXSoJJGEW0Z0P+2kjTLUFqQaal0lCTrS9FQJRv8RQ6F3IdrNfXRtXzUbhW1jT1P24kKfEWfzZgI+wzglhNv6KUZ2PRIGN3SxaoxMxnhNMy6ub8FmkKlR2u5zuuBfu+OquNhWdf4UITiqCMuJ7l/UzTbJMgqu/pFtBTDQ==
Received: from MA0P287MB0217.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:b3::9) by
 PN0P287MB0328.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:da::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7719.28; Mon, 1 Jul 2024 10:40:13 +0000
Received: from MA0P287MB0217.INDP287.PROD.OUTLOOK.COM
 ([fe80::98d2:3610:b33c:435a]) by MA0P287MB0217.INDP287.PROD.OUTLOOK.COM
 ([fe80::98d2:3610:b33c:435a%7]) with mapi id 15.20.7719.029; Mon, 1 Jul 2024
 10:40:13 +0000
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
Thread-Index:
 AQHayyMw+x8Tv3BlDUuYLD8zHzW0zLHhWosAgAABBwCAAANoAIAAAXYAgAAMlICAAA3UAIAAA9mAgAAB9YCAAC8fAA==
Date: Mon, 1 Jul 2024 10:40:13 +0000
Message-ID: <423C19DA-AA94-415B-9184-5C8EA01DAC01@live.com>
References: <75C90B50-9AB9-4F0A-B2CD-43427354D15C@live.com>
 <ZoJAAifMqIDXdniv@wunner.de>
 <CAMj1kXH3fvS259Y1mfYcKQbM2mUYbSfuf2ZiMXfFhjq-rzn5UA@mail.gmail.com>
 <ZoJDuunseVIDua-m@wunner.de>
 <CAMj1kXFKBsAXDLxinqiszH=6hEOjbJQL-nFgBsBceta4rUCN-w@mail.gmail.com>
 <ZoJPgSlZJ3ZlU2zL@wunner.de>
 <CAMj1kXHR+mCR5eibj23S26-PN6yLPD1uf9+H2fEEDhNWOh6TjA@mail.gmail.com>
 <ZoJeVWMU8yg4CRLl@wunner.de>
 <CAMj1kXFRNrmyAtVaqHr+RWQ22+++u70eJ__brLjmJa0ocyc0Bw@mail.gmail.com>
In-Reply-To:
 <CAMj1kXFRNrmyAtVaqHr+RWQ22+++u70eJ__brLjmJa0ocyc0Bw@mail.gmail.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:
 [rzKbJEKZ3GrCYPZzTAN65y9nP7gT8c94cZI7VzpR96veQYZqbcXWKDDTAOEAmqtXdYmGvQO/m/4=]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MA0P287MB0217:EE_|PN0P287MB0328:EE_
x-ms-office365-filtering-correlation-id: 64b799a4-82e3-4eb9-7d1c-08dc99ba3040
x-microsoft-antispam:
 BCL:0;ARA:14566002|8060799006|461199028|102099032|3412199025|440099028|4302099013|1602099012;
x-microsoft-antispam-message-info:
 OefR+Wt76SFfz3gsV3dLyLeXnWyR/8GFfJ7oLxSrBFxLnuWzoI7TGt8OWAlgweWVxR9w1EOdmlbR88kvRhAH3aG8hJ4ImWfdEufpERtJll10QRO2fZMAa6olts/me6tMW4Ah+SqzfXrSCIPq5WwsQlKNMKuMZfVXlID51B/ESmgYinSQEoqgH4Y3PN1Czyh3kfnl7OV12FRw3he3/0sR229dDD1zVUBbHvQFsgv4zsLC/A+306+N+wYHAe9VTr3abYSQrwC9tzfB7LHS3dLyqO1zwxAIH5Vj5XyEXvgjuxLG3mSaZz/tC8zhVQ1gOY1Zjz3wqTRBmFVz4DFfqA8SkgVZOOyjQSPcrUUwNhnfh6O01mCasNRZoqeenGz8J5m4tpTSudWpS3TM92R6FEyGai3Kko2Ap6IOs8clwapWS/xbF25Yc/30xTfl+G9QviGCTges1gK2JADqj1TauHQ9aNtfGsxqAvxaFA6k6K06DxOuVtOiA2UW/d4uB0HCBSfIAm1Fe6W9FN1t91R/5uWXgxGIFJLOFmm7YoEvRU7XTIvLBelxigrWE0tAPU1SS+WXd64WpvJozolECLB8qLw3AlZjimU0IKhYOq9CE5Z7DfRqXWLZKUJvrvRbNhQOTnOh5/mYeNOOi2iXD6119BmvQopgy7gl7HDpApIYISdU5KHO11bucTtKrzTRMQPISUo1H8HzEXhNJqQe/WlgMazGfVli7hAR5nIYQtWf+ydtvW4=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TzV0emk5WFhUWVREcENlU2F3d0gvckZERS9IS1JBQm5GVUR6LzRoREg1UDRu?=
 =?utf-8?B?aHNqNzNzN05BNHo0WFg4NGpMWjRFcHdzTkNXSTBoeGc1T0JSaitNdi9mRnBZ?=
 =?utf-8?B?VExveHdvRzJiRU5VK0NuVTc1NHNPT2svK1htODl6UTJlQkJhU3l3VmZlNnFt?=
 =?utf-8?B?NjJsZDZKSlRPbVpLOHY0MUVoKythblJXWGJWSWtyMnQ1NXgrQWtjbTdtcmJE?=
 =?utf-8?B?MldSbmpyeDM3RmM3NXhyQkNJSHhqQ1JSREVxcUR3QTEzOWpPYktNREtOdklw?=
 =?utf-8?B?aHRtYWNHNnNra3RYampxZ1dZUC9zQTZqL2w0TkNxVXRzNlZ2Vlo1MnZsNHZL?=
 =?utf-8?B?cXNKdUFHTERueUw3Rk90Y2dkdzg2My9qWE03SU12NGhneTlCR200QTdTWlEx?=
 =?utf-8?B?ZkZBUlhtR0lhVWt1QVpnRzVMNjY2RU8xTnBlbDFuVTFDeTlMa2FGOE1sRXlW?=
 =?utf-8?B?SFR1MlBrNEU2SngyY25UWVp6SXdJUlNnMGt6bCtWdi83QTZKVnQzUFFFZ3JE?=
 =?utf-8?B?Kzd2bWlIQUpua05nT05OV2NjQ05SRS8rQS82b0NJbTRPMFZtR1hRc01OL0tk?=
 =?utf-8?B?UlBJNU1OdklaRDBza3JrVDZrRlgyMUFzYmxGN3pHQzc4azY5bHlKNjRPYlNm?=
 =?utf-8?B?aHIzUG9Rc0pwem9oYldxU2RQS1BrVFNXSFVNQkhldVQwYjlMcU5tQ2k0aGUz?=
 =?utf-8?B?UFNrSkQ1eGV4YVZJTHRpS1lxblo0MDJxS3BiVWMzd1JUTC91MWIvMFVNUkpD?=
 =?utf-8?B?cTZmM2NsUGFvTmhVd3loYTAxa2dRcFJRYkFNUmgwczNlcUc4Qng3WWN5NzFV?=
 =?utf-8?B?UDd4V2kwQTZMTWNIYllXSFk2WXRObzUybXhvU1BuTUZrekw2ZEpCRFZxZmdu?=
 =?utf-8?B?eTdsYkJFb1lEcVE4UGU1cE1LTzdyN0VQZUM0L0dPRDZmZ3gvZXBNbU9NQTZa?=
 =?utf-8?B?MzRFbDFzL1BSWGRuaStQWG80Sm5zdDUzWEVyOWNzakhxaTJxVGZNSEVieUIz?=
 =?utf-8?B?NlNMRXRhMmFyekpoR00zcHNkUTk3OU4yOHN4SVRnSzBUNmNMNEFQMjIxbkht?=
 =?utf-8?B?T0I2OFp6OXlUaExremZiS2RIblZrZzlYSVVBbDdDbG5ZWlBHYzJiM29qQ3VG?=
 =?utf-8?B?QW9tT2laTE1manNKVzFHVHU2Y0IyckQ5dkJYUEFacjRKaXdyd28vL2VRLzRT?=
 =?utf-8?B?anFnU0ZSRU04VGdnTGhSMkI1WDVCOElQYncvdDAybUdsQnUra0swWHNoRHQy?=
 =?utf-8?B?WkVvYlVoNDQ4YzdndUYwNXYwSS95WnNmU1JqcFVtOTBjSzFHZW5iRzYvU1Nz?=
 =?utf-8?B?YU9RMkVGa2Jid1labTd2WWNMS3BtaHBlRzJ2eUhnSTMxSVZVcmNmSi9iTitM?=
 =?utf-8?B?d2ZVNm5XTDdGbzh2K042OTVxZnFCbXBtN2VtZU4rNndNcWRTWEQxaFZuT2gx?=
 =?utf-8?B?cmI0ZHkvSGpQRGNXdHJ4T3VWa1N2QjhhVXFtVVdLZ1l0UzNTOFI0TUpKUjA5?=
 =?utf-8?B?WGo4SVlNa3pCV01CbEIrUTU3aUwzMFpvd0hGSC92OHBBdW5BanFvTDg5dGtP?=
 =?utf-8?B?S1p6a1kvLzZWTC90N2sweUJyTjZUM0VlTWxoUmMzUWlIc0FZOFBtcFYwODd5?=
 =?utf-8?B?czBNWE0rK3gxc2E5NjQ1RzV6aEJvRlE0bVZVOGpsc2dmemJqUHpzMFdWdXdn?=
 =?utf-8?B?VDhvVlVPRkFpdXdWVlQ2MXJSQWUwdnNnRlJQL0FhV0lhSmpUQjVRTEYrZ2wz?=
 =?utf-8?Q?CirFk/Z+lYhzXNq/eLicBPXIDV16QZ6Ww1uMZ5I?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9C2B5B72662FEF4CB8D14C6C7E89121A@INDP287.PROD.OUTLOOK.COM>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 64b799a4-82e3-4eb9-7d1c-08dc99ba3040
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2024 10:40:13.2099
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0P287MB0328

DQoNCj4gT24gMSBKdWwgMjAyNCwgYXQgMToyMeKAr1BNLCBBcmQgQmllc2hldXZlbCA8YXJkYkBr
ZXJuZWwub3JnPiB3cm90ZToNCj4gDQo+IE9uIE1vbiwgMSBKdWwgMjAyNCBhdCAwOTo0NCwgTHVr
YXMgV3VubmVyIDxsdWthc0B3dW5uZXIuZGU+IHdyb3RlOg0KPj4gDQo+PiBPbiBNb24sIEp1bCAw
MSwgMjAyNCBhdCAwOTozMDozNEFNICswMjAwLCBBcmQgQmllc2hldXZlbCB3cm90ZToNCj4+PiBB
c3N1bWluZyB0aGF0IEludGVsIE1hY3MgaW1wbGVtZW50IHRoZSBFRkkgU01CSU9TIHByb3RvY29s
LCByZXVzaW5nDQo+Pj4gdGhlIGV4aXN0aW5nIHBpZWNlcyBzaG91bGQgYmUgcmF0aGVyIHN0cmFp
Z2h0LWZvcndhcmQuIFNvbWV0aGluZyBsaWtlDQo+Pj4gdGhlIGJlbG93IHNob3VsZCB3b3JrIGlu
IHRoYXQgY2FzZSAod2hpdGVzcGFjZSBkYW1hZ2UgY291cnRlc3kgb2YNCj4+PiBnbWFpbCkNCj4+
PiANCj4+PiBOb3RlIHRoYXQgdGhlIHNtYmlvcy5jICBsaWJzdHViIHNvdXJjZSBmaWxlIG5lZWRz
IHNvbWUgY2hhbmdlcyB0bw0KPj4+IGJ1aWxkIGNvcnJlY3RseSBmb3IgeDg2IHdpdGggQ09ORklH
X0VGSV9NSVhFRD15LCBidXQgSSBjYW4gdGFrZSBjYXJlDQo+Pj4gb2YgdGhhdC4NCj4+IA0KPj4g
T3JsYW5kbywgQWRpdHlhLCBjb3VsZCB5b3UgdGVzdCBBcmQncyBwYXRjaCB3aXRoIENPTkZJR19F
RklfTUlYRUQ9bj8NCj4+IA0KPiANCj4gWWVzLCBwbGVhc2UgdGVzdCBzbyB3ZSBjYW4gY2hlY2sg
d2hldGhlciBJbnRlbCBNYWNzIGV4cG9zZSB0aGlzDQo+IHByb3RvY29sIGluIHRoZSBmaXJzdCBw
bGFjZS4NCj4gDQo+IE5vdGUgdGhhdCB0aGUgZm9sbG93aW5nIGh1bmsgaXMgbmVlZGVkIHRvbzoN
Cj4gDQoNClRoZSBwYXRjaCB3b3JrcyBBcmQNCg0KVGVzdGVkLWJ5OiBBZGl0eWEgR2FyZyA8Z2Fy
Z2FkaXR5YTA4QGxpdmUuY29tPg0KDQpGb3IgcmVmZXJlbmNlLCBoZXJlIGlzIGtlcm5lbCBjb25m
aWd1cmF0aW9uIG9mIHRoZSBrZXJuZWwgdXNlZCB0byB0ZXN0IHRoaXM6IGh0dHBzOi8vcGFzdGVi
aW4uY29tL0dQYXhSV0M2DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2Zpcm13YXJlL2VmaS9saWJz
dHViL01ha2VmaWxlDQo+IGIvZHJpdmVycy9maXJtd2FyZS9lZmkvbGlic3R1Yi9NYWtlZmlsZQ0K
PiBpbmRleCAwNmYwNDI4YTcyM2MuLjFmMzJkNmNmOThkNiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVy
cy9maXJtd2FyZS9lZmkvbGlic3R1Yi9NYWtlZmlsZQ0KPiArKysgYi9kcml2ZXJzL2Zpcm13YXJl
L2VmaS9saWJzdHViL01ha2VmaWxlDQo+IEBAIC03Nyw1ICs3Nyw1IEBADQo+IGxpYi0kKENPTkZJ
R19BUk0pICAgICAgICAgICAgICArPSBhcm0zMi1zdHViLm8NCj4gbGliLSQoQ09ORklHX0FSTTY0
KSAgICAgICAgICAgICs9IGthc2xyLm8gYXJtNjQubyBhcm02NC1zdHViLm8gc21iaW9zLm8NCj4g
LWxpYi0kKENPTkZJR19YODYpICAgICAgICAgICAgICArPSB4ODYtc3R1Yi5vDQo+ICtsaWItJChD
T05GSUdfWDg2KSAgICAgICAgICAgICAgKz0geDg2LXN0dWIubyBzbWJpb3Mubw0KPiBsaWItJChD
T05GSUdfWDg2XzY0KSAgICAgICAgICAgKz0geDg2LTVsdmwubw0KPiBsaWItJChDT05GSUdfUklT
Q1YpICAgICAgICAgICAgKz0ga2FzbHIubyByaXNjdi5vIHJpc2N2LXN0dWIubw0KDQo=

