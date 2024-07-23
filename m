Return-Path: <linux-efi+bounces-1480-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 441A393A45D
	for <lists+linux-efi@lfdr.de>; Tue, 23 Jul 2024 18:26:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98446B216DF
	for <lists+linux-efi@lfdr.de>; Tue, 23 Jul 2024 16:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C5B2157A59;
	Tue, 23 Jul 2024 16:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="YJJoHPID"
X-Original-To: linux-efi@vger.kernel.org
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01olkn2071.outbound.protection.outlook.com [40.92.103.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89EE314C5B0;
	Tue, 23 Jul 2024 16:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.103.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721751978; cv=fail; b=pwKG9sTonAW5SF5nhnqBkwt2b4N5zVdNMOE6Nn4TTt1X6xx03a71YoF2l/GluUi6XjfI5BtPXZAPr12w9y5I//r32T1ojASA5uKzV1oHgxiPIS0+gbjTxnvUItL2HBIjeglgcnBlF9CgfwE3ydOhN9oce55OmVeVpFtT7wD1NlQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721751978; c=relaxed/simple;
	bh=Urwxi+8PD6uAYEpl6EMcH62PSC3n7d0NuTw38Ohj+b4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CNrGmRTkbyk8TFzmufJjqwy2pf7ltyOlWzCeYHW8GZKiQyF8QyRwef8BeqcH92tFbxCj6kQxeDumtA6YE5ki9N62UsyrLh4/WemNInh6aTHy7ZIh7Gs69L61qz4Zi/RMyjVs/g2d0ZykMy1dCvHSt+bp10L1qRfcAz9ZoL/uarM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=YJJoHPID; arc=fail smtp.client-ip=40.92.103.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KRP2j2RbugIRa+m1nvVqyft3dzMGH2ozbLf6xo2wPXM9gREoZ46s/1Vdqo8Y/1tb/LQXQOSu2EOxibDF971Fxj/D3xUGuXiOLAqXWd4JZgU/YgdzSGcsiJcrIu4W/aHFRzQsxILNMvb9apZi1y+2CRJHGZ4tDVnVsKY9BQFtkmKBOT0vuXjzhvAOXK3g6jimWr8p+3Rwdf0+H638342rAnuaaQIK6ODBBAZ6MrnPcsbVsOy/M7fXbqsrIABi+zrNWi4ulVp1UzD9kcL556poaD28Pj9eeTB6J4YmCDN+IYYP7v1ESICsoUBBqxTBYt7XO/KEMS5futPpBOlQr4rIwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XTiOdz+lYCSmPI70SoyTvNTwtzbfqyRTrl3/TumZxsg=;
 b=nV2MZyrmC6uJNOApH7c9YQGt3474obpHreWoRRnasxsQz2VXNE8JT5/3q1xz/G+JDi2t0NioTBgxTvb3+zKgGcbGuj9dBvbMk5RgfH8Xj+hEj0P2XHvTWeQUXa3qYV5iDyCM5P45YLbFao7MwPyOZKb8EpWNLgWQTwGpMCziooFBVsCjiFWSSuYK6bpwv9NvUJK4EwAWx21PKqKKzw+Rt0h2/MKElVMYrRmR9CnYrLaH5Nv9B4i9vRW/8inqRdUqRpr9f0mSzXknbSkeYQkeYCOVpCvxcrtffWrjmCRD+wj0g/+SiBWxaillSrvh6UyaZQuDjjMvesdggWJM/WocBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XTiOdz+lYCSmPI70SoyTvNTwtzbfqyRTrl3/TumZxsg=;
 b=YJJoHPID7nc3PqmQVt+fE5gRbqVS3xoJpb8q6aS9iBBbcgy4iuVLTUCfWDXZ/fNPFiV6qEVp/2da8u2+alK9JkC+8Tn4AH185A4tejuXkPoO4oTOpQysFhKihnCcbQXAhFfn9Z/AbbQmOB52XVR21A3eFU6t5V0K564SV7JJFfXUZln7n36oOtSzkbhqeywLeDExgZDah+MRMs2hHP/l1FktV8xupJv4kMaDMe53+J2b/HkmyyNfb0nQSvvAWxrILWR9Riq4f+db1eOXP6/Apvcrd6UgWk2hUFYsfwOS9ywR1sTCoA6StYM90aNukIGkU2c36ZA5CZVoc6KIG9FEWQ==
Received: from MA0P287MB0217.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:b3::9) by
 PN3P287MB2028.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:1d2::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7784.18; Tue, 23 Jul 2024 16:26:11 +0000
Received: from MA0P287MB0217.INDP287.PROD.OUTLOOK.COM
 ([fe80::98d2:3610:b33c:435a]) by MA0P287MB0217.INDP287.PROD.OUTLOOK.COM
 ([fe80::98d2:3610:b33c:435a%4]) with mapi id 15.20.7784.017; Tue, 23 Jul 2024
 16:26:11 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Lukas Wunner <lukas@wunner.de>
CC: Ard Biesheuvel <ardb@kernel.org>, "linux-efi@vger.kernel.org"
	<linux-efi@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>, Kerem
 Karabay <kekrby@gmail.com>, Orlando Chamberlain <orlandoch.dev@gmail.com>,
	"sharpenedblade@proton.me" <sharpenedblade@proton.me>
Subject: Re: [PATCH v3 0/2] efi/x86: Call set_os() protocol on dual GPU Macs
Thread-Topic: [PATCH v3 0/2] efi/x86: Call set_os() protocol on dual GPU Macs
Thread-Index: AQHay8BxbD/3780MxUWT4The9rzhebHiRiV0gBjw9fOAACgFAIAJQwrwgAAARIU=
Date: Tue, 23 Jul 2024 16:26:11 +0000
Message-ID:
 <MA0P287MB0217D36FA2989381A387FD1BB8A92@MA0P287MB0217.INDP287.PROD.OUTLOOK.COM>
References: <20240701140940.2340297-4-ardb+git@google.com>
 <MA0P287MB0217C0F7E0B9F6FE8CA47BE8B8D32@MA0P287MB0217.INDP287.PROD.OUTLOOK.COM>
 <MA0P287MB0217E3B4810704C504F13F2CB8A32@MA0P287MB0217.INDP287.PROD.OUTLOOK.COM>
 <ZpgUVjjj3naBGtfO@wunner.de>
 <MA0P287MB02178F503AA69E1F570E9753B8A92@MA0P287MB0217.INDP287.PROD.OUTLOOK.COM>
In-Reply-To:
 <MA0P287MB02178F503AA69E1F570E9753B8A92@MA0P287MB0217.INDP287.PROD.OUTLOOK.COM>
Accept-Language: en-IN, en-US
Content-Language: en-IN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn: [DPhEKsL/rswXnfph0f02CK1j9Zf3ZbnyyzWVCRk+wEPlBoETOWv4f0+YZIPhEdXA]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MA0P287MB0217:EE_|PN3P287MB2028:EE_
x-ms-office365-filtering-correlation-id: 7e715fb7-1771-408e-d0f3-08dcab342a6b
x-ms-exchange-slblob-mailprops:
 vuaKsetfIZm19wj3BccaDfPX7+VQ1E3ZTCc54qZjyRgoWcggxSHgPp3YyFbspU654/Ab2S0ChGIaFSpEyGBhg6cOvTKx//B5EKjGYJgoY/mCqXe7EQ6DWf3WYV0t/kinUO1M4tyUuX88M5UwjjBEEfKuDaSF/UHmJOoHrYt6n/bjNdqDOxQcGc5uOsuq9quUnXqUKvfUuM9+ZC7g3lJkx2yyg3LtTwjIJKKCqpY/mRQhkRb96PlXAdbJjSuEIuhcNmgDlsusrN7W9FPAMou4YWIPuuVIAR/15DBmkxQh4TnGeLaeKvfFqc5FH6IoEfF002mo6LPVwI5OahqeWPlT7rBetHzio5WAE/9dOGcrLNrVsffLQ+tMPMH+g5yl4kS55OqHvR8vo7Mxe8FSwgzM9YkYpOyqND+pRYO8/4kJRn1Juq3HMFQkf4OQ478t16zPP/5DuqaF4ixybv4hP7g3T3mmntvG0/6KUVR/ItloNxdBb0Dq8GMSzX4HOYO7xa+ro+3vNgZmbU9hzgcn5jhUPn0B6Bzp/NhEQkcaSbQDd6yVWSF829e+n38ecOK/eNB3hsbMz6V6TawUFO4qPWHZWcGFy4Q+o07E0HcjLQ+xWQ4XAftNVArmkWoYo+QZ8Y1hi/GLdBbW0Tz7N6zwbkydI1t7tr+KWGcXxLjzox6uE5ktdpzq9vfw7rdeokju1c60vxt2eym45AHj3Rzb4kn5Fuk5Np8aoHvtWbc2DCNYkAH4uU7cDX52QnVIzMLBGgaN5ikHikfbs3VMqUHKL9d7GXafzxhoUN2i72FLfJwn7yuhzJ3+5+TVl1M6EGf+rFTd
x-microsoft-antispam:
 BCL:0;ARA:14566002|19110799003|461199028|8060799006|4302099013|1602099012|3412199025|440099028|102099032;
x-microsoft-antispam-message-info:
 yNXg7bMXPEtuF57uWmyzXyrWxgVkLPgUkFkIi52QY6VTOUd1aydlZYxJAIBsalyc3sqfrBLJMS51lqllTAm5libSU1gZA+ShIWkpvALZudBmKH9E1IC7mHiFcIGa2nIwJJYU3I05EWvAiKguMFNUn/a4ERcbyLua8LD7gnCq6ZDjEELAp/lufF1ek1UdRjwbeDjFBO39NEtgmVR0NGMBffJJ5VEDA1/jrFQQjwNv7cS4C9ppd+ymoewpJDK92ydAmKwu2g+g6SI+qnWGs2/ZGZVY7WqqqOEg69uxs8mmV8s9HE/bD3fxEGJps/Vu3lIqSXfXMBRR0Y7nQpsHQpvrew6HUT03R5Xy5VOwiaEoAuQA9dTjwfOH+Brn4Src2D8CY9xT//mXpxQ3ubwc8cfRvKokQtBlKYSZhBAZQGYBL9qOM4BFDrNlShLsyIJPA+Sg2NYHuRKfHEk8nnT2bNKl7TjGsE+OoVfZEyQeA6vseZlNv+/u6q7okKdHV3GmsPUZggkiwLQaUIqKLzt8bANf0EIPp//RFz07483871GySGvHuyfb3GOYhx8BDk3Kx2F7eq3MMHlcCXuDA18nAttB6xvLCNxzwljGprHM+43gMWcZYesCLLC1cK6TU82xxcZdORzwwprHcHUdGwEmWQOo9MqgK3GbWlSUFa9DH0v/pokFlAoGE2a4InXEORkhkgF0ibApbTL9WF6UV5q8eKRjpW1cPp13Sag2yBw8uuVWfXnRjbqvbmaZclXZ8O5U1omS
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?kMSSn/mLKuZsZgmkoxkTr62fSoudOBI4zeECHEy0FjoHW8PD5cV3WS3YEbBL?=
 =?us-ascii?Q?TWKXq2Cc02KNBBDDskThzkZs61EgLtQgVyFecZ6b24T2VFAZbZ8gkuoVev5g?=
 =?us-ascii?Q?oYFzb9WY3dHPZiNsvH3e3bK2n/Q8IAkI4lkwSaFyV0EJJcL1DHOxK18dwkbS?=
 =?us-ascii?Q?5h9hdVFvGoL+9VU0BnR88nhygtqKCijytK30Nd86TwzBcwBSZCs1DVK0OqUG?=
 =?us-ascii?Q?TTq+RuRN2n9sYN77SR/3/KAWsZTsBNFI3MgnDSRAJ5qzpV/on3kfdrRaV9oA?=
 =?us-ascii?Q?pJPRo92lgbYqgnsLlZM1+6H158vn/vsxmwMog/KKjq5b6Cp/h4i+BnSsnEtn?=
 =?us-ascii?Q?KiDg0j/6UYkwdV01f6SJfI231zgaf43CVOkRRdZ3/9mQtbwkIi7x/+yNDW9c?=
 =?us-ascii?Q?56Lc+Q1pLP7Y0CVmDlMp+5yd71CNdSUfpzO6RGhoHb9s1mPetmMrPoEfQh0p?=
 =?us-ascii?Q?UkRidzoNEcAYPqXPkZoNr45d/VZpnCoJpXdYXHWOBgnsvbgKbX7pfEsMdqNb?=
 =?us-ascii?Q?sdTt9zBegMx6pWhWAkmHTB4RF6Z0MKZc56PuCOjA0BynskXg8HU4fvSHC1c5?=
 =?us-ascii?Q?m+eZrAsXIJvw0Z9WuFvoMj5v2K97ktqxrWEk0r1Dc0ukRnv5Q6dkNffGoj3P?=
 =?us-ascii?Q?Z8/thK9fDxuBhHc1AHtrXJ2+3G/1BeLkMMWFcTSm3mPFqnanSmwWKtfTtBFA?=
 =?us-ascii?Q?IacSpUoxT3ZDI6ctR1oPFT8Q+z0RfBX3BjUNWJuA+TAzWkLh2bt3LmUMALQO?=
 =?us-ascii?Q?OdhRIXHnoJFzWW9/eI8yQ4cc0Ej4NU4k5hGNKGhtvt+9Ql/iDlQ/mlwH3w+h?=
 =?us-ascii?Q?23K5VsM8YekCG4+kqyW334KEXo353kTKImU78V8ZLQwPs/cWb+aOH4g4vB3a?=
 =?us-ascii?Q?ibGlfyOPKuOLLFwzuht314WBnqUg/RjfOLQueJD9Kqot2IyQTJhxeonJYElE?=
 =?us-ascii?Q?vBgmTI5//9lMdDIgTlKWDps54AEkxtF2bpptFvLImWxQqSkbzt6z5nWdb/Qf?=
 =?us-ascii?Q?6T3/OVFzvagmV07FBUFKH3yJ7EJVyFTk8IGpH6poAVKhrfhzdg35NiLBpOtX?=
 =?us-ascii?Q?PQvqNxx6etRnY+ybc8cXTDqj88madRwGokSB/DnOCGRsXhIqLPb0meEbIlZN?=
 =?us-ascii?Q?4jmPlLks6mnR7hmPsZWMSStuJK3ynAtDLL0jrJBsNcQfidvi1v8Tb6+e0axS?=
 =?us-ascii?Q?NZRfRhYtQexYHv0JZpB4IFzXIw3TNf/kYr6bIStPH8n+V4AWurs5IBw0mHg/?=
 =?us-ascii?Q?D6Gw6R4/jVklMCteUG51rDu8JxC89Do0Bvc/FbDCs0lbyn55+egygvaLgPi7?=
 =?us-ascii?Q?0ug=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e715fb7-1771-408e-d0f3-08dcab342a6b
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2024 16:26:11.7799
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3P287MB2028

Sending this message again because it previously got sent only to Lukas by =
mistake.

Hi,

Not sure whether it's relevant, but this user here also claims that without=
 setting the os to macOS, the external GPUs had issues.

https://www.phoronix.com/forums/forum/software/general-linux-open-source/14=
79158-linux-6-11-efi-will-fake-that-it-s-booting-apple-macos-to-fix-some-du=
al-gpu-macs?p=3D1479205#post1479205

________________________________________
From: Aditya Garg <gargaditya08@live.com>
Sent: 23 July 2024 21:55
To: Lukas Wunner
Cc: Ard Biesheuvel; linux-efi@vger.kernel.org; linux-kernel@vger.kernel.org=
; Hans de Goede; Kerem Karabay; Orlando Chamberlain; sharpenedblade@proton.=
me
Subject: Re: [PATCH v3 0/2] efi/x86: Call set_os() protocol on dual GPU Mac=
s

Sending this message again as for some reason it got sent only to Lukas:

Full model name: Mac mini (2018) (Macmini8,1)

The drive link below has the logs:

https://drive.google.com/file/d/1P3-GlksU6WppvzvWC0A-nAoTZh7oPPxk/view?usp=
=3Ddrive_link

________________________________________
From: Lukas Wunner <lukas@wunner.de>
Sent: 18 July 2024 00:28
To: Aditya Garg
Cc: Ard Biesheuvel; linux-efi@vger.kernel.org; linux-kernel@vger.kernel.org=
; Ard Biesheuvel; Hans de Goede; Kerem Karabay; Orlando Chamberlain; sharpe=
nedblade@proton.me
Subject: Re: [PATCH v3 0/2] efi/x86: Call set_os() protocol on dual GPU Mac=
s

On Wed, Jul 17, 2024 at 04:35:15PM +0000, Aditya Garg wrote:
> For the Macs having a single GPU, in case a person uses an eGPU,
> they still need this apple-set-os quirk for hybrid graphics.

I don't quite follow.  You mean the integrated graphics are
disabled by EFI firmware if an eGPU is attached?

This sounds like a bug on Apple's part:  The panel can be switched
between integrated graphics and discrete graphics, but an external
display can't be switched between eGPU and iGPU.  Is the person
affected using the latest EFI firmware update from Apple?

We need more information before we can devise a way to solve the
issue:

- Exact model name
  (I'd be surprised if this affected pre-Haswell models)
- Full dmesg output with command line option "dump_apple_properties"
  (EFI drivers provide various properties for Thunderbolt-attached
  devices and graphics cards, those could be queried to recognize
  the situation causing the issue)
- Full lspci output with and without eGPU attached

Perhaps you can open a bug at bugzilla.kernel.org and attach the
files there.

Thanks,

Lukas

