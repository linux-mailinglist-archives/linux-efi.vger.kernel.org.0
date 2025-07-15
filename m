Return-Path: <linux-efi+bounces-4348-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6B66B06209
	for <lists+linux-efi@lfdr.de>; Tue, 15 Jul 2025 16:57:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD7BC4A6CD5
	for <lists+linux-efi@lfdr.de>; Tue, 15 Jul 2025 14:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 655471E7C1B;
	Tue, 15 Jul 2025 14:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="pXY134D4"
X-Original-To: linux-efi@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12olkn2076.outbound.protection.outlook.com [40.92.22.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20FE913AD1C;
	Tue, 15 Jul 2025 14:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.22.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752591111; cv=fail; b=o+bCzxzmte1PMu9g/tDPDjfYJmCc0l2ZrCK0jIh6TVL/mRo2/2m+glBRH6v86bbl01QgNFivzEcKPJVv5Y/0i9DXlTFfME+renrNRdX/30ANQppX1/zjYMAc6bZN3XzkYQtJEgKledlXReHvWLHPY6Ya+geJ+yWu722bWQM+KaY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752591111; c=relaxed/simple;
	bh=Z1TdFbqqhCEmatBPZbTvNYOou5cR3pEdRV44lEUMc5U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Gqeo3cThTwdMhHO5EvLAfBCHL0nDdFk1hEevItsNdxvnpOHzuhLA2lMFOvHf6FlD/HvC2yQaXKda1VlEGQJvmUSLD+6RX9rdCm4ssROfmfzfWzpJW/ygVd7MZEw3W0E/om7IE92N/FwRTW66+T+GHfZWqI3FunGj2Fcb0/Nj9rY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=pXY134D4; arc=fail smtp.client-ip=40.92.22.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KXQVu9fNv6ITenwEnLBF4xkV2sGa9MSvYMg+uc3itasSGyqLZutkdYuovtTGizNgh4AHZbCQEkys7BOZA2mvJHGTkRKX3FezU/Xr+9NfuMkyEMsSR8bDEcs2ERHWTzD+TaUX+I5d8HWIe6H/aw6EvmgrNmGojFuz/EtQvKRyt0zMQJEd4fUkWD2FDcuXwv9IodGWOEF1E4Yps6Gd+mpBmnQI3YP204/D2B1WjsmKBb+vwg4XrPmrRJe1TWk9c0hHqvGcMKCQBlwxnLyxKidQVzyd6olWOoM2HWSgpdQ50qs9VeHXmnKaQdp6miXT3MX5z/39M6TeIxwXSsgja3u4wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DhTXOMZUxYyK+zR7yF1/2nwxik+1aZSskFdVDbmRTTY=;
 b=AfnyS8tSB7FrvPFeArU/w7+c69nlbEpK9ZSvRLPoPOfG9VE+H4BAHdkDJnAvrhuNxvHKoe96rzxJYG3K1I2CeLgw1cuR6404fXfMxZPs6wli+4/LWlKmD6L8LbXlhA4GsfEOhFuB+g5EKYlM6k41P9ok3ikUwzUhcnaOLLOL0RGUDMz4Xi2ukhWPVpkXNuN4teIKiRhd5hMtgqCTB58V8hCfnXYH2mVGzY7lo3Q/TdTK1CrwraDzCFNmbxKH+U6NQ4IIZKdTzVdW/mT95FiGg2J15IkYgQbId65oO9uTCkxjO1w3L4Bb5yH2Ryvj1pzD/CsLI7nxtZtnlCfeqfEKDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DhTXOMZUxYyK+zR7yF1/2nwxik+1aZSskFdVDbmRTTY=;
 b=pXY134D4p6mXblaiP0lU/sjGYtrsquwZzUXbRgRhDtLTdrnQ5IKmykP6uFFtu4HUmNuBmPh3bXgeBGnlriexGD82N6geGWnwBfKrscKwDUf7mkGz6AnYN6aSQQyufTn1kHxdGK8+0WMpswPvrnwBsXfJKCTaFd3+xWQHvXa5/h8xo8Tr+L/0skf4QET7NtBNEfUDucsBIguT0IZ7Mx1sUlFrWhDFr26utW4o/3a/x27EGA6kpuy1OoAWsw4OTqL+1LlkYsrIaoOjIeBTLppB96/wRGMTuCnDlYfqvWlTVpdDCqQnD4RpKHxmimww/8kSn2m6G8wxUjcv5OeEiUp2HA==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by PH0PR02MB8438.namprd02.prod.outlook.com (2603:10b6:510:de::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Tue, 15 Jul
 2025 14:51:44 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%4]) with mapi id 15.20.8901.018; Tue, 15 Jul 2025
 14:51:43 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Peter Zijlstra <peterz@infradead.org>, "x86@kernel.org" <x86@kernel.org>
CC: "kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de"
	<bp@alien8.de>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"hpa@zytor.com" <hpa@zytor.com>, "seanjc@google.com" <seanjc@google.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "ardb@kernel.org"
	<ardb@kernel.org>, "kees@kernel.org" <kees@kernel.org>, Arnd Bergmann
	<arnd@arndb.de>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"jpoimboe@kernel.org" <jpoimboe@kernel.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
	"samitolvanen@google.com" <samitolvanen@google.com>, "ojeda@kernel.org"
	<ojeda@kernel.org>
Subject: RE: [PATCH v3 11/16] x86,hyperv: Clean up hv_do_hypercall()
Thread-Topic: [PATCH v3 11/16] x86,hyperv: Clean up hv_do_hypercall()
Thread-Index: AQHb9KxdnTH1RC3qKEKeEVwDdjJXcLQzRJxg
Date: Tue, 15 Jul 2025 14:51:43 +0000
Message-ID:
 <SN6PR02MB4157288AB40BE56A9F062223D457A@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20250714102011.758008629@infradead.org>
 <20250714103440.897136093@infradead.org>
In-Reply-To: <20250714103440.897136093@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|PH0PR02MB8438:EE_
x-ms-office365-filtering-correlation-id: 3eb3123d-96f6-4fb3-e931-08ddc3af1d62
x-ms-exchange-slblob-mailprops:
 0wLWl8rLpvudsZkRr3t+MXsz156RByMpiif48+40vx5anYdqZJQKut7CBZwXtHLKxzBy2WFH/JCh6HwZ3hhERZN7QxgVTblzB+FjhmAXE6ZHhfkt9Q+k4iLaBztaVRRPBTwuEuZW3QBslvX3r1afPqHjXpnY71dXelw5q4/Ya42TvHOBQFNKnL0GR0lzMq/g8+7fx3ezZg7HHpM8fIfnPuHx3W4evf0sdTkqxhLocPhGgo3APsye0+0EGxheCAuQlIWhHBN3QFvJ9tkjTMoiu/TeYCB1IqAsamA93mGflzAUM7x/ttBo7uYNoKjaO41h3EL/m1VC2ukOdgpSwbcVJ15pc2WF6+ScAJ2XsG6z3SxZTIsDHPPmeHNejY+SioP9beFGqRYv1oDQYU7+VbzNo08roH/HcU2Irx8TCC59CAgQVr8EW48c61JeBAsCJydtDEgdxaKF14807+qYPiNXOLF53O1cRTozxRfXdhEWFFXe7bYG0QqZZkJPdKChSDT5jPRTgssIbkg39yAXFyKOhK/xS7s+JELqXyrbb2dVikE6aTFO6CuDzs9TV3YzoaLX3ggGUZotSOfkS3Cr5MSgUFvmyB8SEOi4h8mXBGhQNGvhizSBDFIyiNrNDao9d6MqUArqvhg/VeFE7IFEDdHpXa55e+qWgd+H7nf9t6ph7JkMjhhKn80jK33Wy5oiy3KOTc7gnNiz++Yl3tdUNb2bTK4ApUL5NSOckDU7XL7CORQcB0yLBR9DjucNnli0JRWCHDgFz9HxIUE=
x-microsoft-antispam:
 BCL:0;ARA:14566002|15080799012|461199028|41001999006|3412199025|51005399003|40105399003|440099028|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?eOdLPpGXoWpQukVBsMs++54Azh7jSuERKHFHw3eMrHbq15Iq/AQhyckNAv4v?=
 =?us-ascii?Q?OAqW7rGULeF3dL+XGQBSNGUVrmWP4GbvvLXRNMT5jxyPZu6g5SGmvGo9Rwz6?=
 =?us-ascii?Q?Zt8de109XMfx9v2/a5Y5Vo1iomros7a9rW+DDtXFv2Su9J6bUqn4vJEceMb1?=
 =?us-ascii?Q?ofC9RVC5zwRbzrIVl1TJ7DkH2FYfKnhp6dGHMgD8flnY0cneeY07DsXJMQ03?=
 =?us-ascii?Q?gniyWxrljwN050xj4S/xeDZvWcE9FYNy+YGuos+uDJeVr91jTDrS824chql6?=
 =?us-ascii?Q?d68Xbv3VWY1Pz7dcFxlXuKwsMEeBY5aXLEAzrRgVfs/RCOKagkhn+g4SESO3?=
 =?us-ascii?Q?BLzGfzhett72YfRgOJRQsfPNjkNMjWHbZjcbxxia5jgotWC/SYgacx+5wc9I?=
 =?us-ascii?Q?WqahDgUhFQDf8ZmUlcbRXbsrnnc9SKIOk7DIEGWkJOkopH5KwcxlZX7YC598?=
 =?us-ascii?Q?CnfZiRcBmVP/ms+voFf+d5jbkiofVJwUIUa9O2WIA0YZGA4hSaL+lLKyf2Cm?=
 =?us-ascii?Q?+6tqyhMmrsxdggJEdt0TtQGDfMisBzbrsOTkf0u0yDv7dj3Fhl6z6a+8KQGl?=
 =?us-ascii?Q?2Kscx9WQX2axYbOHlK7Tp/IOSyOsSp+TRwQuIuyKT5Kz3PZFWwn4qnM8wJx2?=
 =?us-ascii?Q?wVxAWhyskiHmfHF5LWK25jAMXpKggRfRPdwjWfC1MgoPd+sjMmjDsXT607QS?=
 =?us-ascii?Q?aWF+sO8q+2rLt3/XK3K6wl9fnTLT1Ogkx8bs1fpKHRJc4m1el0k/NIfyQoFr?=
 =?us-ascii?Q?p3HkFDOxYwnDLMaFfErBtulmjkvzRvNCrZ3YU1hZCKd8VyWJQj2WdPMAjDG2?=
 =?us-ascii?Q?epR6egz+SEZpvgksYlRp/pjNgilNabrqHFzwiHBU61mi0pbc8+9vTEqxA3J5?=
 =?us-ascii?Q?zd9G1kyd9FijRwXVkVbHMxkcwKXceofT3u6rXI3rk3BP0+8cbthkBkzODaRS?=
 =?us-ascii?Q?T3cnJ/1mkBCzXunJBPOiuYDzQ9T+W5yzngstSHOD6vJDmTlUPav/N5IvHoOh?=
 =?us-ascii?Q?CapSQGn6AMaIJx2P1Pd0Q8z3fnTyla+JYElg1KfwwLdaDstogtdyW1drnjOG?=
 =?us-ascii?Q?I6fVBwXqSJcelfDHStcXSlGKsHoSaw=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?zc+tdb82RP28Twqz/a2xMJaX38duSFvK18/vvV6O3H1f1+kXCIIedxFvHz59?=
 =?us-ascii?Q?bWk3nIqY4lkCoXdspiyq0HqQPLgBIIfcUUYcaeWiASbqUYpqFTjrgeoZezos?=
 =?us-ascii?Q?IsuHMtx4mr6MWwcS67E5VUVgCfhfWjypJEANxANPlSnZfxOJTmdgKsKQ8dVe?=
 =?us-ascii?Q?PtkFqn3pSpFhub2UQ1nnl1zi4XiiGNma9Rcs5UEnkAvfRxyVhaqbe3YIkfoj?=
 =?us-ascii?Q?47wHYX3wKrOKaoJRTKdtU4m1LVOpBi0nOI+4+w/+0yWOCwv4NGR/Vc508r8I?=
 =?us-ascii?Q?hvcCMG42X92gH8ebBY64O1y6eP3RMXw/rBYLd+Homy/Z/icDVa9dLnlhD31v?=
 =?us-ascii?Q?LNVClb9rQrxyXQbdELn8245W+OLQlW9z8gneChRssijBZV2r/45g3bE3O1JI?=
 =?us-ascii?Q?qgx4mGsA4/dLlBwP73b1P2GtbveMEwlN7kLyfG+yb/6CAuaGx4uQq2FsC8M7?=
 =?us-ascii?Q?s4eMqPECoMYvKgoth6va4EeTec218OCTVip0iWXYYvw911b5dY5k/eYJTzhi?=
 =?us-ascii?Q?tbSsml/NMPuYFtUSqUhGNIJL0wtL/d4AvmnMbwV8uswLEqpgCK8DFMrnB+4/?=
 =?us-ascii?Q?7oolXM2BlvOksMs9UL2wxbfbaH4Kc+a/g4rs0lMhJgljWvklOitKCPm9+dT2?=
 =?us-ascii?Q?5jM2krX6N88P6gyNjrrF6/U/vjFzzPDcPl8ZTdg0yuqpf6dJcvWH5AfWWLBF?=
 =?us-ascii?Q?0lt0SOoTdG9x4isqBZgtZv1P1aRnMTw65bIChvHmDtc7I6nzxMu9vanC7vMA?=
 =?us-ascii?Q?QvSEY3ZEmxFsAoMrM6lj46NBCbgYv/9QVFKBIlxlnSiGAFndJv7Op1+aU72n?=
 =?us-ascii?Q?hki1SXPlpSkgwWWsq1fsGC0IJTsWEX0oS0bPfZuv7Xvt9rbrIFRNCUz6PAm9?=
 =?us-ascii?Q?lGXd1+POCFsofT+h4hR7PoUVLkjLTc7aZVmXHmpOLkceyOTYGtooXHSlFeuO?=
 =?us-ascii?Q?+W4pg5G+bhRUKySh08K/PIWEdt/5p+BV1rAVd8JQ9p2iuj+X8jL4cZtRzWOC?=
 =?us-ascii?Q?AoVwpjuSuBxX9lRR++EnMA7NqK6vVCgzeuhFq6SVDgGSsUcn8v44HU8KNTnY?=
 =?us-ascii?Q?7EL9vleEkb6BJHxMLc49vW3QxBbW/dbKEXEjMCFs29yd9wPLnDZdKs/whMW0?=
 =?us-ascii?Q?QqfJqQKE6wX0f+XkxVyoaYzOf1bPXssm66acDKGcEuB6uAFjO9JuzVNaV+ps?=
 =?us-ascii?Q?8aZpvzG4FeidvOMdbkQgf8E5iQuVYO62RYz2Q1oqXQ7N8AaxqxZwbEg0BG8?=
 =?us-ascii?Q?=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4157.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 3eb3123d-96f6-4fb3-e931-08ddc3af1d62
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2025 14:51:43.6175
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB8438

From: Peter Zijlstra <peterz@infradead.org> Sent: Monday, July 14, 2025 3:2=
0 AM
>=20

Nit: For the patch "Subject", the prefix should be "x86/hyperv:" for
consistency with past practice. There's definitely been some variation
over time, but "x86/hyperv:" has been the most consistently used, and
that's what I try to remind people to use.

Michael

> What used to be a simple few instructions has turned into a giant mess
> (for x86_64). Not only does it use static_branch wrong, it mixes it
> with dynamic branches for no apparent reason.
>=20
> Notably it uses static_branch through an out-of-line function call,
> which completely defeats the purpose, since instead of a simple
> JMP/NOP site, you get a CALL+RET+TEST+Jcc sequence in return, which is
> absolutely idiotic.
>=20
> Add to that a dynamic test of hyperv_paravisor_present, something
> which is set once and never changed.
>=20
> Replace all this idiocy with a single direct function call to the
> right hypercall variant.
>=20
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Tested-by: Michael Kelley <mhklinux@outlook.com>
> Reviewed-by: Michael Kelley <mhklinux@outlook.com>
> ---
>  arch/x86/hyperv/hv_init.c       |   20 +++++
>  arch/x86/hyperv/ivm.c           |   15 ++++
>  arch/x86/include/asm/mshyperv.h |  137 +++++++++++----------------------=
-------
>  arch/x86/kernel/cpu/mshyperv.c  |   19 +++--
>  4 files changed, 89 insertions(+), 102 deletions(-)
>=20
> --- a/arch/x86/hyperv/hv_init.c
> +++ b/arch/x86/hyperv/hv_init.c
> @@ -36,7 +36,27 @@
>  #include <linux/highmem.h>
>=20
>  void *hv_hypercall_pg;
> +
> +#ifdef CONFIG_X86_64
> +u64 hv_std_hypercall(u64 control, u64 param1, u64 param2)
> +{
> +	u64 hv_status;
> +
> +	if (!hv_hypercall_pg)
> +		return U64_MAX;
> +
> +	register u64 __r8 asm("r8") =3D param2;
> +	asm volatile (CALL_NOSPEC
> +		      : "=3Da" (hv_status), ASM_CALL_CONSTRAINT,
> +		        "+c" (control), "+d" (param1), "+r" (__r8)
> +		      : THUNK_TARGET(hv_hypercall_pg)
> +		      : "cc", "memory", "r9", "r10", "r11");
> +
> +	return hv_status;
> +}
> +#else
>  EXPORT_SYMBOL_GPL(hv_hypercall_pg);
> +#endif
>=20
>  union hv_ghcb * __percpu *hv_ghcb_pg;
>=20
> --- a/arch/x86/hyperv/ivm.c
> +++ b/arch/x86/hyperv/ivm.c
> @@ -377,9 +377,23 @@ int hv_snp_boot_ap(u32 cpu, unsigned lon
>  	return ret;
>  }
>=20
> +u64 hv_snp_hypercall(u64 control, u64 param1, u64 param2)
> +{
> +	u64 hv_status;
> +
> +	register u64 __r8 asm("r8") =3D param2;
> +	asm volatile("vmmcall"
> +		     : "=3Da" (hv_status), ASM_CALL_CONSTRAINT,
> +		       "+c" (control), "+d" (param1), "+r" (__r8)
> +		     : : "cc", "memory", "r9", "r10", "r11");
> +
> +	return hv_status;
> +}
> +
>  #else
>  static inline void hv_ghcb_msr_write(u64 msr, u64 value) {}
>  static inline void hv_ghcb_msr_read(u64 msr, u64 *value) {}
> +u64 hv_snp_hypercall(u64 control, u64 param1, u64 param2) { return U64_M=
AX; }
>  #endif /* CONFIG_AMD_MEM_ENCRYPT */
>=20
>  #ifdef CONFIG_INTEL_TDX_GUEST
> @@ -429,6 +443,7 @@ u64 hv_tdx_hypercall(u64 control, u64 pa
>  #else
>  static inline void hv_tdx_msr_write(u64 msr, u64 value) {}
>  static inline void hv_tdx_msr_read(u64 msr, u64 *value) {}
> +u64 hv_tdx_hypercall(u64 control, u64 param1, u64 param2) { return U64_M=
AX; }
>  #endif /* CONFIG_INTEL_TDX_GUEST */
>=20
>  #if defined(CONFIG_AMD_MEM_ENCRYPT) || defined(CONFIG_INTEL_TDX_GUEST)
> --- a/arch/x86/include/asm/mshyperv.h
> +++ b/arch/x86/include/asm/mshyperv.h
> @@ -6,6 +6,7 @@
>  #include <linux/nmi.h>
>  #include <linux/msi.h>
>  #include <linux/io.h>
> +#include <linux/static_call.h>
>  #include <asm/nospec-branch.h>
>  #include <asm/paravirt.h>
>  #include <asm/msr.h>
> @@ -39,16 +40,21 @@ static inline unsigned char hv_get_nmi_r
>  	return 0;
>  }
>=20
> -#if IS_ENABLED(CONFIG_HYPERV)
> -extern bool hyperv_paravisor_present;
> +extern u64 hv_tdx_hypercall(u64 control, u64 param1, u64 param2);
> +extern u64 hv_snp_hypercall(u64 control, u64 param1, u64 param2);
> +extern u64 hv_std_hypercall(u64 control, u64 param1, u64 param2);
>=20
> +#if IS_ENABLED(CONFIG_HYPERV)
>  extern void *hv_hypercall_pg;
>=20
>  extern union hv_ghcb * __percpu *hv_ghcb_pg;
>=20
>  bool hv_isolation_type_snp(void);
>  bool hv_isolation_type_tdx(void);
> -u64 hv_tdx_hypercall(u64 control, u64 param1, u64 param2);
> +
> +#ifdef CONFIG_X86_64
> +DECLARE_STATIC_CALL(hv_hypercall, hv_std_hypercall);
> +#endif
>=20
>  /*
>   * DEFAULT INIT GPAT and SEGMENT LIMIT value in struct VMSA
> @@ -65,37 +71,15 @@ static inline u64 hv_do_hypercall(u64 co
>  {
>  	u64 input_address =3D input ? virt_to_phys(input) : 0;
>  	u64 output_address =3D output ? virt_to_phys(output) : 0;
> -	u64 hv_status;
>=20
>  #ifdef CONFIG_X86_64
> -	if (hv_isolation_type_tdx() && !hyperv_paravisor_present)
> -		return hv_tdx_hypercall(control, input_address, output_address);
> -
> -	if (hv_isolation_type_snp() && !hyperv_paravisor_present) {
> -		__asm__ __volatile__("mov %[output_address], %%r8\n"
> -				     "vmmcall"
> -				     : "=3Da" (hv_status), ASM_CALL_CONSTRAINT,
> -				       "+c" (control), "+d" (input_address)
> -				     : [output_address] "r" (output_address)
> -				     : "cc", "memory", "r8", "r9", "r10", "r11");
> -		return hv_status;
> -	}
> -
> -	if (!hv_hypercall_pg)
> -		return U64_MAX;
> -
> -	__asm__ __volatile__("mov %[output_address], %%r8\n"
> -			     CALL_NOSPEC
> -			     : "=3Da" (hv_status), ASM_CALL_CONSTRAINT,
> -			       "+c" (control), "+d" (input_address)
> -			     : [output_address] "r" (output_address),
> -			       THUNK_TARGET(hv_hypercall_pg)
> -			     : "cc", "memory", "r8", "r9", "r10", "r11");
> +	return static_call_mod(hv_hypercall)(control, input_address, output_add=
ress);
>  #else
>  	u32 input_address_hi =3D upper_32_bits(input_address);
>  	u32 input_address_lo =3D lower_32_bits(input_address);
>  	u32 output_address_hi =3D upper_32_bits(output_address);
>  	u32 output_address_lo =3D lower_32_bits(output_address);
> +	u64 hv_status;
>=20
>  	if (!hv_hypercall_pg)
>  		return U64_MAX;
> @@ -108,8 +92,8 @@ static inline u64 hv_do_hypercall(u64 co
>  			       "D"(output_address_hi), "S"(output_address_lo),
>  			       THUNK_TARGET(hv_hypercall_pg)
>  			     : "cc", "memory");
> -#endif /* !x86_64 */
>  	return hv_status;
> +#endif /* !x86_64 */
>  }
>=20
>  /* Hypercall to the L0 hypervisor */
> @@ -121,41 +105,23 @@ static inline u64 hv_do_nested_hypercall
>  /* Fast hypercall with 8 bytes of input and no output */
>  static inline u64 _hv_do_fast_hypercall8(u64 control, u64 input1)
>  {
> -	u64 hv_status;
> -
>  #ifdef CONFIG_X86_64
> -	if (hv_isolation_type_tdx() && !hyperv_paravisor_present)
> -		return hv_tdx_hypercall(control, input1, 0);
> -
> -	if (hv_isolation_type_snp() && !hyperv_paravisor_present) {
> -		__asm__ __volatile__(
> -				"vmmcall"
> -				: "=3Da" (hv_status), ASM_CALL_CONSTRAINT,
> -				"+c" (control), "+d" (input1)
> -				:: "cc", "r8", "r9", "r10", "r11");
> -	} else {
> -		__asm__ __volatile__(CALL_NOSPEC
> -				     : "=3Da" (hv_status), ASM_CALL_CONSTRAINT,
> -				       "+c" (control), "+d" (input1)
> -				     : THUNK_TARGET(hv_hypercall_pg)
> -				     : "cc", "r8", "r9", "r10", "r11");
> -	}
> +	return static_call_mod(hv_hypercall)(control, input1, 0);
>  #else
> -	{
> -		u32 input1_hi =3D upper_32_bits(input1);
> -		u32 input1_lo =3D lower_32_bits(input1);
> -
> -		__asm__ __volatile__ (CALL_NOSPEC
> -				      : "=3DA"(hv_status),
> -					"+c"(input1_lo),
> -					ASM_CALL_CONSTRAINT
> -				      :	"A" (control),
> -					"b" (input1_hi),
> -					THUNK_TARGET(hv_hypercall_pg)
> -				      : "cc", "edi", "esi");
> -	}
> -#endif
> +	u32 input1_hi =3D upper_32_bits(input1);
> +	u32 input1_lo =3D lower_32_bits(input1);
> +	u64 hv_status;
> +
> +	__asm__ __volatile__ (CALL_NOSPEC
> +			      : "=3DA"(hv_status),
> +			      "+c"(input1_lo),
> +			      ASM_CALL_CONSTRAINT
> +			      :	"A" (control),
> +			      "b" (input1_hi),
> +			      THUNK_TARGET(hv_hypercall_pg)
> +			      : "cc", "edi", "esi");
>  	return hv_status;
> +#endif
>  }
>=20
>  static inline u64 hv_do_fast_hypercall8(u16 code, u64 input1)
> @@ -175,45 +141,24 @@ static inline u64 hv_do_fast_nested_hype
>  /* Fast hypercall with 16 bytes of input */
>  static inline u64 _hv_do_fast_hypercall16(u64 control, u64 input1, u64 i=
nput2)
>  {
> -	u64 hv_status;
> -
>  #ifdef CONFIG_X86_64
> -	if (hv_isolation_type_tdx() && !hyperv_paravisor_present)
> -		return hv_tdx_hypercall(control, input1, input2);
> -
> -	if (hv_isolation_type_snp() && !hyperv_paravisor_present) {
> -		__asm__ __volatile__("mov %[input2], %%r8\n"
> -				     "vmmcall"
> -				     : "=3Da" (hv_status), ASM_CALL_CONSTRAINT,
> -				       "+c" (control), "+d" (input1)
> -				     : [input2] "r" (input2)
> -				     : "cc", "r8", "r9", "r10", "r11");
> -	} else {
> -		__asm__ __volatile__("mov %[input2], %%r8\n"
> -				     CALL_NOSPEC
> -				     : "=3Da" (hv_status), ASM_CALL_CONSTRAINT,
> -				       "+c" (control), "+d" (input1)
> -				     : [input2] "r" (input2),
> -				       THUNK_TARGET(hv_hypercall_pg)
> -				     : "cc", "r8", "r9", "r10", "r11");
> -	}
> +	return static_call_mod(hv_hypercall)(control, input1, input2);
>  #else
> -	{
> -		u32 input1_hi =3D upper_32_bits(input1);
> -		u32 input1_lo =3D lower_32_bits(input1);
> -		u32 input2_hi =3D upper_32_bits(input2);
> -		u32 input2_lo =3D lower_32_bits(input2);
> -
> -		__asm__ __volatile__ (CALL_NOSPEC
> -				      : "=3DA"(hv_status),
> -					"+c"(input1_lo), ASM_CALL_CONSTRAINT
> -				      :	"A" (control), "b" (input1_hi),
> -					"D"(input2_hi), "S"(input2_lo),
> -					THUNK_TARGET(hv_hypercall_pg)
> -				      : "cc");
> -	}
> -#endif
> +	u32 input1_hi =3D upper_32_bits(input1);
> +	u32 input1_lo =3D lower_32_bits(input1);
> +	u32 input2_hi =3D upper_32_bits(input2);
> +	u32 input2_lo =3D lower_32_bits(input2);
> +	u64 hv_status;
> +
> +	__asm__ __volatile__ (CALL_NOSPEC
> +			      : "=3DA"(hv_status),
> +			      "+c"(input1_lo), ASM_CALL_CONSTRAINT
> +			      :	"A" (control), "b" (input1_hi),
> +			      "D"(input2_hi), "S"(input2_lo),
> +			      THUNK_TARGET(hv_hypercall_pg)
> +			      : "cc");
>  	return hv_status;
> +#endif
>  }
>=20
>  static inline u64 hv_do_fast_hypercall16(u16 code, u64 input1, u64 input=
2)
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -38,10 +38,6 @@
>  bool hv_nested;
>  struct ms_hyperv_info ms_hyperv;
>=20
> -/* Used in modules via hv_do_hypercall(): see arch/x86/include/asm/mshyp=
erv.h */
> -bool hyperv_paravisor_present __ro_after_init;
> -EXPORT_SYMBOL_GPL(hyperv_paravisor_present);
> -
>  #if IS_ENABLED(CONFIG_HYPERV)
>  static inline unsigned int hv_get_nested_msr(unsigned int reg)
>  {
> @@ -288,8 +284,18 @@ static void __init x86_setup_ops_for_tsc
>  	old_restore_sched_clock_state =3D x86_platform.restore_sched_clock_stat=
e;
>  	x86_platform.restore_sched_clock_state =3D hv_restore_sched_clock_state=
;
>  }
> +
> +#ifdef CONFIG_X86_64
> +DEFINE_STATIC_CALL(hv_hypercall, hv_std_hypercall);
> +EXPORT_STATIC_CALL_TRAMP_GPL(hv_hypercall);
> +#define hypercall_update(hc) static_call_update(hv_hypercall, hc)
> +#endif
>  #endif /* CONFIG_HYPERV */
>=20
> +#ifndef hypercall_update
> +#define hypercall_update(hc) (void)hc
> +#endif
> +
>  static uint32_t  __init ms_hyperv_platform(void)
>  {
>  	u32 eax;
> @@ -484,14 +490,14 @@ static void __init ms_hyperv_init_platfo
>  			ms_hyperv.shared_gpa_boundary =3D
>  				BIT_ULL(ms_hyperv.shared_gpa_boundary_bits);
>=20
> -		hyperv_paravisor_present =3D !!ms_hyperv.paravisor_present;
> -
>  		pr_info("Hyper-V: Isolation Config: Group A 0x%x, Group B 0x%x\n",
>  			ms_hyperv.isolation_config_a, ms_hyperv.isolation_config_b);
>=20
>=20
>  		if (hv_get_isolation_type() =3D=3D HV_ISOLATION_TYPE_SNP) {
>  			static_branch_enable(&isolation_type_snp);
> +			if (!ms_hyperv.paravisor_present)
> +				hypercall_update(hv_snp_hypercall);
>  		} else if (hv_get_isolation_type() =3D=3D HV_ISOLATION_TYPE_TDX) {
>  			static_branch_enable(&isolation_type_tdx);
>=20
> @@ -499,6 +505,7 @@ static void __init ms_hyperv_init_platfo
>  			ms_hyperv.hints &=3D ~HV_X64_APIC_ACCESS_RECOMMENDED;
>=20
>  			if (!ms_hyperv.paravisor_present) {
> +				hypercall_update(hv_tdx_hypercall);
>  				/*
>  				 * Mark the Hyper-V TSC page feature as disabled
>  				 * in a TDX VM without paravisor so that the
>=20


