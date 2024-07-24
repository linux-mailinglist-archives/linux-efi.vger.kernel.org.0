Return-Path: <linux-efi+bounces-1484-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C7BE93B4D5
	for <lists+linux-efi@lfdr.de>; Wed, 24 Jul 2024 18:21:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0C6D281F1E
	for <lists+linux-efi@lfdr.de>; Wed, 24 Jul 2024 16:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4E15158D9C;
	Wed, 24 Jul 2024 16:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="gJXMMGix"
X-Original-To: linux-efi@vger.kernel.org
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01olkn2104.outbound.protection.outlook.com [40.92.103.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE312595;
	Wed, 24 Jul 2024 16:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.103.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721838070; cv=fail; b=satTOoPMR/qEMpeF74hqc6IPfYzwsRb1dViak6pu+Y8KmVmVu0Wc0+4lcihTk57/mqE+8qtRj8NKS2Mf1aXPhayFYG0y/KVl0iD7L1qymNYSwmYd5sXQOWOSgL6SWDlRrDc/dU90d7t646b9j7xmLjxdHW96LnA+Cjw8yvRDcKU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721838070; c=relaxed/simple;
	bh=UKUe10i8N4PfxZy0t3H6ezcf+petBxIFuWTUSjFgbdA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TwvV3bWScKaM62Ppq4bKB5e8yffGBaiaFtFb0auBndyhSNf37aq54mYfe7VQpJqNSrwVO5fxcFmVMDMhlLOh8pDAOMZKFWplsIQDVxnMOrx0/fi/1sWt96arNndWYeNkL/12r6K6WjH4Dq6Xnfs7ANCeMB1rymSgJKHeJ0Pq1kM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=gJXMMGix; arc=fail smtp.client-ip=40.92.103.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=osR7viokOZJm0vn74KF8k1qoNAWjjm6Am/M4yhUpyKTfV8oJr0TkgKt18oWLB3/vS1k/SlifpFJh4mV9WlPOHogd221WFzwOvYHWB1ujOcb3Ki0rGPS7QCkzHXTLjDa3zqay7XgspV+PluRzOYiFdEBc5UZokymDy/5n7tbpq8Kdg+gXPkenu5V5ybNINFkC9jzRuvk9l0Jeib/XXwZlzsnMcmBPsw7qCl+T0kWF2eLTU4RwWUYApveRPHR7A4P9rRt3sWT2aW63tytKfBwXi/O/xn+VCxuix+Ioucr0T619042AX3MOCqOVtgjsVgktp3kd4wwmRG/RObhJqSAZdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S2FFw0zS9VRzT0tU9dH6tuusjl9ConvHkIf6F0vBBYo=;
 b=EFUoVWlWrPqUffiaUTj2nUuEp07/y/fgcz6HTY3aXaAK1k927rBEkq/GklfRMJ3aUxsVDUyZHRi++mi7F9mtgIGKEbOgraVugZY9JOLdtx3PRtGTlORmmP8Twxx+kM9GKjIlVIJQJD0SriIxnZYE0iqCkClCO01gTGwkaC2L68mvyQgGMgBDvR2vDaT4+80UIQvkwvmK3mm5emgYOdwaRPWoeyxjnDP3jiQyEHNCuuU5V+0tT/t6VMviuKqfOU0U0CETocewD+Bz/x0Uc2viA+YK828hb62G17xcJJOK1OGvg30Yj7M56i/dayCoo4JSEQNteXnGSRTB+8uDmNTL6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S2FFw0zS9VRzT0tU9dH6tuusjl9ConvHkIf6F0vBBYo=;
 b=gJXMMGixkdCDmQLqMQQocE1RtrM9rOjhPmKVPoxUSZx1YNDgrf6Kn9yTUZO/jSuRV5Hvht0waj6wDvZV9Sr3QJ2P/sAED6z9h1eZ7ip4hby6p36SKjX3znKMb2VpEchaVrujocmktsidc78tY5PtJtlJCic72hgZCNK+/70jtfflclFMCK4S8+5AYe5TCATGP2NnJG4sLMjwRAqrBC0Uh3AVQWn5MYO5LwkMYZlNyYRpyb8EZkvSToObrJ3YDLNu5nAXPaEAmPekWA1dGzCKyGk+0BNKCzFlInsIuwVXRfp3IyBdSB0A9rRU3jmZqSdUY5PqC8YEhnwbuNUd5vc1YQ==
Received: from MA0P287MB0217.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:b3::9) by
 MA0P287MB0297.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:b3::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7784.20; Wed, 24 Jul 2024 16:21:04 +0000
Received: from MA0P287MB0217.INDP287.PROD.OUTLOOK.COM
 ([fe80::98d2:3610:b33c:435a]) by MA0P287MB0217.INDP287.PROD.OUTLOOK.COM
 ([fe80::98d2:3610:b33c:435a%4]) with mapi id 15.20.7784.017; Wed, 24 Jul 2024
 16:21:03 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Lukas Wunner <lukas@wunner.de>
CC: Ard Biesheuvel <ardb@kernel.org>, "linux-efi@vger.kernel.org"
	<linux-efi@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>, Kerem
 Karabay <kekrby@gmail.com>, Orlando Chamberlain <orlandoch.dev@gmail.com>,
	"sharpenedblade@proton.me" <sharpenedblade@proton.me>
Subject: Re: [PATCH v3 0/2] efi/x86: Call set_os() protocol on dual GPU Macs
Thread-Topic: [PATCH v3 0/2] efi/x86: Call set_os() protocol on dual GPU Macs
Thread-Index:
 AQHay8BxbD/3780MxUWT4The9rzhebHiRiV0gBjw9fOAACgFAIAJQwrwgAGLugCAAAEmyQ==
Date: Wed, 24 Jul 2024 16:21:03 +0000
Message-ID:
 <MA0P287MB0217AA8547F79B36B754A7B2B8AA2@MA0P287MB0217.INDP287.PROD.OUTLOOK.COM>
References: <20240701140940.2340297-4-ardb+git@google.com>
 <MA0P287MB0217C0F7E0B9F6FE8CA47BE8B8D32@MA0P287MB0217.INDP287.PROD.OUTLOOK.COM>
 <MA0P287MB0217E3B4810704C504F13F2CB8A32@MA0P287MB0217.INDP287.PROD.OUTLOOK.COM>
 <ZpgUVjjj3naBGtfO@wunner.de>
 <MA0P287MB02178F503AA69E1F570E9753B8A92@MA0P287MB0217.INDP287.PROD.OUTLOOK.COM>
 <ZqElRH38f_XV3fKK@wunner.de>
In-Reply-To: <ZqElRH38f_XV3fKK@wunner.de>
Accept-Language: en-IN, en-US
Content-Language: en-IN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:
 [n/2J1cYApTcRayt1FbQO3IRgpuJ5DwFDtolhmQC67Zwr3bJc/i0M8ze3meMF8lMOlr3etEgUuUk=]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MA0P287MB0217:EE_|MA0P287MB0297:EE_
x-ms-office365-filtering-correlation-id: 2b9f206c-1f8f-4c9e-e62d-08dcabfc9d14
x-ms-exchange-slblob-mailprops:
 +b2+gf+2pHQwc4/WbO9sNT17XKQKY7uhRYqjOkTvtHYD/Z22Qy4L1YhH1DTC+SClo7SgrqSP+ERQHkdqiEow3ShwnBlV2LAuEnP7e1sQDlPdmHFVMss4Mb450jk+XNy2YU79p/xsUnc44RBr9AhEUtpWiE1T+5+2Y4jxvNzNWaDwVErOZ1TjI7zNS5V160v0THMxd9Fbzhi8ac3nGKUSrUfpNcvhCW4mm40MlQmql83AW9izgvVXhgGbH0WYipoSjzS4VPA4L07Zv9mn5h/q5tv4CfAYQc5kMrNnM0/+4tkIwvo9fNtWQIXpyYnTLJq8O9FpMfv4/WA54hHWb44QVIpx67BIIrihyu3F6GiZ6UxU1Yq6lDMZjgG/u58QD27b3r/KYNOJr3sUV2F3HZynOztLCxLjd+NQrmaV6RSQEiDT9XSHXaQyb4vJ6r5AeGmEaJCe4KsjzbnxVfvfuSqpc4w1w4dwnBeDcX9AQ6vszVc8F9O6f6jox1xaJZ5u3EtBv5hZxNykLtUOY1ail5BCDadiGi0PncW8Vp3tyPX2Bgdg2BBUttnaTlgJGZxktD4KH3yh3+S7TltFBpXLyyDMNcBiIZN0yHeNfHSZONXxV+xKKzLKFajLgAtSCMTwP+0Oy1DmDlSduURlwcfJgJfOaoGxgw4klSUzeZsZU+MIPZ04z8V4FgRNAP8H1GmbTz3hP/OVtCNbaD5fYpsdChoyU7uS2q/YHGvpTT0rC5ESsciadAY7nlWcXEj3vK47IVAqP1tdLZB4EJwuRe1a8Pbq5Aurwre+TCAcbJ8CVhKKauM4WtQKKBbE7P6fC/y5VnY4yblllPAXYQpGtwqAIWeSfltxju35XSjxe003WndpDWH3yGCx1m8GyA==
x-microsoft-antispam:
 BCL:0;ARA:14566002|19110799003|461199028|8060799006|1602099012|4302099013|440099028|102099032|3412199025;
x-microsoft-antispam-message-info:
 fB1Yr8d67R2MG+JRX2IUW1HlNgRaJ7yqRaKgo8zIIGPGGgDkJV8yt6W5pzTVVrs03ivq+yKc1EYqN/vbKyuRv1Ux6v7eW7LZ/eDOXY3som4KMZ86XZwSeq1no0q+RmgSXq5Rvz5FouJkM/0ayz2PSTxN9G2hapk76hOEpypDDSv5wZ4dBOiAIPu4kocHZ8wXjHxenUB8XOIKY0Jrf15nqZ3ijdvTGDQJzKF8pNWPJakmnmWdWSCIhOc2MtTsa1VMgkkG3jfmeYDNuGRVEWt0yEZlCOMa/mnjazBtOrjCKjb8xBUmq7al2DeSV5C2DT7mV6R9pDDuT0heq1k3T66QOOlxcVn7+rhIGUpOG4oeQlYLXBAf8ZF9u5xdPiBbz7sJ/A0gskQ2R+SNM79ebHBc+jaGFCbpQlLnYu6Z5ZK1O+g18VcmbeHIcO/hthKsEOrpQ8dim+ysDB4zJRLKEri85VEh0UbYkwDwGVgOpivxT+HpOoT2Um3ifETjCUDgIwQFy7yp1dy8zZXdClRx9O4vtOAonHpduxaSWgVTzuZE9k9lCS9q3VgcUqjFh0rvIE/kH+itXwud93NFiZ52oD1N05yy5QO3HsyzYbylMw2xUr3KwW1ugUG8jWJ6krDsWx6cU5LLABiOFJKJ9sdNpC4PvhTuIawEN2M0inuYdSS9g/5hUq1Mjt+Qns9lIbKMOeivtkZzgr1yG/HgC97Wyupbh5XQdYjPwDb4cGvQoSMZqchfjnNEr/OwuFzE8ZrwAmXH
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?a84CmuSiWrvndGE6H3hqcGX3LJZjduG0cSq2Dz1JoCi6M9lfzbUS+YwtJx?=
 =?iso-8859-1?Q?oZzLHYxBVT37BEbvCY4eURVxO7ZZevQ5unu2XHVkgoefHUq3xbQc7QirN+?=
 =?iso-8859-1?Q?a98IH0P6MehDps/fruBIZOx0HXzWJveGtr/diVF6erbK7rd/UKVz7KMuPY?=
 =?iso-8859-1?Q?oNiVkJ7m0ps/ZdmjLOtt7AT5HL1MTDn/JYFUrlvniDof7SDnM+lTdqQO1K?=
 =?iso-8859-1?Q?vjtvj5JevPmYnSw9efJoOpvwE8ut9E1m6HWCDhN/LgfH5MyKNk2qU/DOjq?=
 =?iso-8859-1?Q?1hs3fT8JUABH6a0XTUqhJAKpOw8i/bdi2WOgL9xR7eMPETpFR6JhojA2TL?=
 =?iso-8859-1?Q?2I4Ds22I/gJ9s1Ilx39CsAPKaHrqHb5gWpOv+torQy7PnvozLk3+5HIhyR?=
 =?iso-8859-1?Q?RmCppxFSLDYEMYsCDsOGscUMzqfp4kAxqsNVnfcZVniNC3tyNkywm9E4Pu?=
 =?iso-8859-1?Q?eDBGEIztMfuiZtU7ConTbm2v1y/3KFRAT75Q9IbF7APDZ6dkcxOcg/pFWn?=
 =?iso-8859-1?Q?p1k0A1GSlq8WlAIYDSaNdE6KJni2SRe07N3Eh5FRFjPOFFHVQH8EdTVFIH?=
 =?iso-8859-1?Q?LPkwB6gprsd8BXyjAKEaPNRYvyfhybIW4O8LEKBUuvEThsvfs8uqLbB0wm?=
 =?iso-8859-1?Q?qvXcFaU9X/Zpyr7n8IP7V39L2K15OPXssJ2rlYX3M7xzP00Y8McsSvSpxA?=
 =?iso-8859-1?Q?3cTeAVJEPgv1YMIWkvSw5fZEJK4MUBT8QanMHefFxolpYJY4kZYh90Bsc4?=
 =?iso-8859-1?Q?bodp9zBez0HoKuMtnCnwIq1VKBCUr04XMrkvaXcoi50WaM1dwfaXmM9j5Z?=
 =?iso-8859-1?Q?ruYxrPGj+WF1Qnuva3+llWybxEEy/E6j4WHFJuXqUK/afzC3I0aP18PCCr?=
 =?iso-8859-1?Q?2IZxNx2fJ5U7W3AjzNy3GAgTUZ5kRT7DgGrvwNO6HUEdmh95K41ygDO3Bl?=
 =?iso-8859-1?Q?mqbZFpyCxmNYxNxGpPNiRX06DOLbnRDAEPZPiwjUDsGBOXdppZuiGOYREv?=
 =?iso-8859-1?Q?2m/7dJbb4Au5Oy7EQHZ0ZE2NpJIfPBRsKZdqZ89gWwR2QVIaNYj+607DGo?=
 =?iso-8859-1?Q?wL8B3JJML4a5wVvbzfyfOhfaXUQAKLoKTom6Q70G6bZJxxJPFKKSQFqRZe?=
 =?iso-8859-1?Q?T6H+QrSjp1GoCW9moYkgcxChV8/BCJT6i1dZjcCQnda1YDKyyRHfDv9LjV?=
 =?iso-8859-1?Q?D2BpshYM51swclulJdnJqV5bzDt9Wr55YDVwXMKnIt0OOCNfT18f15lKya?=
 =?iso-8859-1?Q?m19uIirQc3duSZ/3IIb1O+2+zPRhWexCEx788J99Z4YsB7nTD58zDOsMsZ?=
 =?iso-8859-1?Q?XAn3+KjnYA4WPegd1TuY0jgMoUy/n1ymf+5jQvJQ3t4dYak=3D?=
Content-Type: text/plain; charset="iso-8859-1"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b9f206c-1f8f-4c9e-e62d-08dcabfc9d14
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2024 16:21:03.4694
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0P287MB0297

https://www.phoronix.com/forums/forum/software/general-linux-open-source/14=
79158-linux-6-11-efi-will-fake-that-it-s-booting-apple-macos-to-fix-some-du=
al-gpu-macs?p=3D1479205#post1479205=0A=
=0A=
By looking at this post, it seems to affect non T2 Macs as well.=0A=
=0A=
Also, T2 Macs report that EFI v2 is being used, although by a kernel patch,=
 we force them to use v1.  Have we can use this as a quirk for enabling app=
le-set-os?=0A=
=0A=
https://lore.kernel.org/linux-efi/20220112101413.188234-1-ardb@kernel.org/=
=0A=
=0A=
Although, the NVRAM variable idea by Ard looks better to me.=

