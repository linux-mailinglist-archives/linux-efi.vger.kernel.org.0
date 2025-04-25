Return-Path: <linux-efi+bounces-3466-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B05AA9CBBB
	for <lists+linux-efi@lfdr.de>; Fri, 25 Apr 2025 16:32:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 937589A3477
	for <lists+linux-efi@lfdr.de>; Fri, 25 Apr 2025 14:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5990D22A1C5;
	Fri, 25 Apr 2025 14:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="XKfoJzDF"
X-Original-To: linux-efi@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04olkn2028.outbound.protection.outlook.com [40.92.46.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D2212153C7;
	Fri, 25 Apr 2025 14:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.46.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745591541; cv=fail; b=Lp9c/nkYs87Wl5E0XmvNjeq8/JUptJCSJsx5OvM/y/MRqDNwcQeas6/5Dq0uSagL9IEghh/BPnYUGgAl5cUqMzrhQDy4XeVhBZlHhygJ+iYulB3qTJT+22ri9tBXnoA/6Bxui1c33GQtJvQc2h89H3risSAEsmiTJTRprPiCNn8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745591541; c=relaxed/simple;
	bh=DWUmMNagc+OYGUAsyfSdRK5HmZrwTYxxQyugtr6Go7E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=k/92wQv7rlcd9nUwDFCMQok3N7P5qpb7WIYF4i6ZTds+Y9H8m2w3NQiu/r8gG3Ff+xxhMS/F4o6V+s41YrlyznNzI8htgALWM8Mug5/bM/Bqw0+Lj/soTj8tw5wJgYmn50xmDe+7oqRsV9bV+IVXk4kH+Zm0XeZVQrvHuGehF4M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=XKfoJzDF; arc=fail smtp.client-ip=40.92.46.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=shZIyUEGFZ8BgubINhUXtqA5Vp6hEskNuPt9d3Sx9S9+3N+qLD35jHICcEXXEcE3MWqNthpuJx7lOwOcvxZcCNIJ9FkDbMreCFVA+tsCGFkW2T8AfiOCMrItCxlofdUHa7+3ttVooaMHpMMJQExEHxJN8I0MO6323HTN6uWVzNb1AkFkMUoy5LGKdW0/Vo/SwydZEOA3QWCqCcEriP3VRiJTkv80nf1PLbLmD1UPgpnSo6tE8n80zdutAxiBYYoiQ0X2019BBXMdsuEGFRA9NBBRqXOhoBtTtVMujiZeHKvE80rKBi1kiw9uG8ZY/T9IWnsgoQU6dVeaWD6ZGTJAKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aqt8HRWS4H7TEb8O0tgMMKUJPss+NbpQ57GstBEYsqc=;
 b=aPL8EeDkiFd40E8tAl0OQn299CYSo6qvv761smy56UU7Ith9FPQG/w1QcIWV4TgRsZ2tRyy6gDL2jShoiCGwjKzdsKRE3CUvjPVmKFexi+Id+Y6G0OfarexzDIAFWz5ehVTpjrKLdB9jKnHODtSNIgR9m6nstF6JmuSvcItCn9sT+iMjphWI9+VSgyiNoxb1cFniNlFx+TrEsJ9iztu6P2PGWalDbpSAk26tB9EpdGQ0OSOZEYPy3ZFBpS1lrKwLqhf94U1OwnoV6mPULHYOb+BM2uAs//qbkCvzeLNnYEg0qRp1407m5wXiA0SxDDuz1wMAgwOsTfCCxY8crF/2AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aqt8HRWS4H7TEb8O0tgMMKUJPss+NbpQ57GstBEYsqc=;
 b=XKfoJzDFiRGZxwQkQ9GQdH8CN439btgc9vhvOwn9OIsC9jl2cgotmgpbHNQgoCUGaec8Z/cnppEm6i+Un6BuKG+MfHr2/Wt2tYSRpDp1otephPyGCraA8D66ewMuKJ5O1xV2436TKkjcQmaWq4NowJWrIA7ara7TzvTY44V6/qMoxLQGZIvBKeKRIRZh25FEAopkS1RJ+9Z0KJnJhG+VflQeJZ4lJOWGacuDUGQ36m17sm8+HWIyDZL/YT7TW2YG93H6rGa2QxpKl3TZvnN6+lh1Vn1JqlBo67CcDsTqpDJhGV8pHm8GZzaIZKg5MVyrvl3PRHIn6EsSlChOqLgk+g==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by BL3PR02MB8963.namprd02.prod.outlook.com (2603:10b6:208:3b7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.11; Fri, 25 Apr
 2025 14:32:14 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%3]) with mapi id 15.20.8699.008; Fri, 25 Apr 2025
 14:32:14 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Peter Zijlstra <peterz@infradead.org>
CC: "x86@kernel.org" <x86@kernel.org>, "kys@microsoft.com"
	<kys@microsoft.com>, "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, "decui@microsoft.com"
	<decui@microsoft.com>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "hpa@zytor.com"
	<hpa@zytor.com>, "jpoimboe@kernel.org" <jpoimboe@kernel.org>,
	"pawan.kumar.gupta@linux.intel.com" <pawan.kumar.gupta@linux.intel.com>,
	"seanjc@google.com" <seanjc@google.com>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "ardb@kernel.org" <ardb@kernel.org>, "kees@kernel.org"
	<kees@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-efi@vger.kernel.org"
	<linux-efi@vger.kernel.org>, "samitolvanen@google.com"
	<samitolvanen@google.com>, "ojeda@kernel.org" <ojeda@kernel.org>
Subject: RE: [PATCH 5/6] x86_64,hyperv: Use direct call to hypercall-page
Thread-Topic: [PATCH 5/6] x86_64,hyperv: Use direct call to hypercall-page
Thread-Index: AQHbrTIaLjXb7HTpjEywClCcZeg3ibOudLWAgAYGqoCAAAXRAA==
Date: Fri, 25 Apr 2025 14:32:14 +0000
Message-ID:
 <SN6PR02MB41577A6B0E5898B68E2CD3C9D4842@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20250414111140.586315004@infradead.org>
 <20250414113754.435282530@infradead.org>
 <SN6PR02MB41575B92CD3027FE0FBFB9F3D4B82@SN6PR02MB4157.namprd02.prod.outlook.com>
 <20250425140355.GC35881@noisy.programming.kicks-ass.net>
In-Reply-To: <20250425140355.GC35881@noisy.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|BL3PR02MB8963:EE_
x-ms-office365-filtering-correlation-id: 1a549cd8-acab-4a6a-2c8c-08dd8405f937
x-ms-exchange-slblob-mailprops:
 70qbaZjg4mvbis83qL2U5WvEmRMBS6OgZP+L6c37Gg2KJ+VlU8+H5YNB5nzqUYJP/OAcdtncyxTHOK8iaJjfc9rtZhp3BLOUeS+lr2J9i1XXW2UZDYBl1Fzd6MDwtBHEux8hQIVXy+g8HMQan1twrlWYrPC5+13cML14CL1QT/kmIuFXO51oeVAbe/e0Mt8Aw4McYYx0/WLgJ5W6e7nHVoCLNNh9QVmsIhjTeQDI9lmTnYxNCmP5BswyadHkrAED8hVK39EqGqQGHN67XlcUwbr0Ene1Ens1+uYkjdLvA9UxtKgHOx55CeZ0wPpE6rV3xMk5rZzG++mwJFVkaQ7AYU0EwtGwzC/wm3wCsQRF0SSEHY8k2OAcxeinvqjO/cPeDNRtejXshWyVHlfpTE2yBc7XQcyvUZAHhPC1/U26QsZa38qy6C4p173qwxrkhHzcMBqFr2eoGOpI26GdehzF5xpGdn3fWVeT37oLdfp6wC/h6ULe1aoYd/iNQUHRpQ3twKKnLHlKmf4LXvJm5yEeX5C1zs0z++7J73w0fxo/a4CirFRQ++0zrpUsAxv809e613hLtuT+mkKV601ZcKLaWLGvSL4OTYulaHQmBtSwzYSavDHBBbBO4njfeWWWhMga8/mNV5Zw1qWlSmRbcZ0vG1QMlIXUP1FC8yInHEfAAsKdcfub+mlVGAiJv98C0U2/eq6frziY6NDHF/nOoYbfu//3ZhnVnjwAodXP9nsBB0wve8EmJEcOjg==
x-microsoft-antispam:
 BCL:0;ARA:14566002|15080799006|8062599003|8060799006|461199028|19110799003|102099032|3412199025|440099028|41001999003;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?0eMESxCWnzD7y7KXjjWV/Kq6lbZ8trIEAV2jSjoGNYcS275hIKtAR1wQjVlM?=
 =?us-ascii?Q?HbgP9SD0NHEOMv6+IDM13WZvmzG13G2ezJC42cqIWsyjeGVwM5oxIfAHCxt6?=
 =?us-ascii?Q?/SHHeV32LOrDp/10S5kehunsQtdj6qgd7slHJjeUgLmG/HaA5z32mha3/KAA?=
 =?us-ascii?Q?cyG58TL10IQVAgC8xXEJcLqTq/RNMFWJD4Q8uwKRkTH/kdks2K3+pHMqVRpN?=
 =?us-ascii?Q?z33XOuT/htpyDsOYWD2mBrwiXZtuSKUzNtZxSylbavkc79VYJzPOZxsgAZbA?=
 =?us-ascii?Q?j4NZWznCKMuv/RVzIE8Lj31p62U9AbR/WYeW+nVjREP/P+Wzbm2b1zU1AHfW?=
 =?us-ascii?Q?Sk465EXppDdHswGzFSrMv9+Sw7Ndy6H91yBtjGeAjs2fqfjOUC6Ty5oJbpQU?=
 =?us-ascii?Q?nf8t+8T8/i996TmFHRuPqT6xt04vIyCokyxAevw7sc4RmroQgRNd24BoVdoa?=
 =?us-ascii?Q?FyshdN5mnmr047WQJMQWjXbkAYk04pRRZuPRm96RaOzvkI/zbUEakBuHyyHw?=
 =?us-ascii?Q?//l4JpVag1c0Z5n5dZKfVKUUBqarvZchyFpU2e0zb216iw1qGyCys69abvwd?=
 =?us-ascii?Q?v4tmMYiXj/l9gxsUpuJEeoqLDCsKRVJSbe566EUg3HpD3xkohKrQc8pBhgTB?=
 =?us-ascii?Q?3JcICE8u1csxozOraAwV55pEUE7XBR0bUPSuWCONNPlBJNTU99fXRvseq0h9?=
 =?us-ascii?Q?1HHpiY9F7csN5XM6onm/tfE+rIo07Gvpi41Z7zQXHJ3kv22XzWkAGmUT//BL?=
 =?us-ascii?Q?Vxlpua+8YsTqvFiIKz5jzvBA2QqMcsc5b6sXJkJxjmSYBhlrB3P7BOyIk1Cm?=
 =?us-ascii?Q?f8fTkhMUf+tWimOJSSv7BboI5JTg4sJHoX6tkinWe0b/af3D1Yi2T0xKjKzT?=
 =?us-ascii?Q?+cQUjAvxbNSAd8hEM2AWnSIZOvfysmw8rM3qyy9QFtW2dOjK3n+IORug4Mx0?=
 =?us-ascii?Q?+usFk2XTDDpkfc2ItPqiSjLirBo1jqaEEQWGxnwPKNGDSa0P2pvhuus3f+zZ?=
 =?us-ascii?Q?xbWsClqEw4r/1FKZ4ugu12BNuLP+K0bBicoGvRok1V0UhRfuiQNRd+hsnsNR?=
 =?us-ascii?Q?Y/MFP1mzZi9pBTC49uRhDl2B6RWZQXbjhmWrIGbDQJrCAfsdNTDsUazCjQBD?=
 =?us-ascii?Q?3699bzBq/1Rx?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?q0Yp7GeWMhZGXTPRbEIHl1F7eKsZg0+6tW6iF7GGueNY+Y76OexcQpCjULzs?=
 =?us-ascii?Q?j1tU6QrczEbRV6aVorwUZNbiu0LlBO9hYimnaUdqVLBq+Zvex7d6c75eCtNL?=
 =?us-ascii?Q?EdiWncWolz2JMhDeppD9n65xadXu1jseye1nvvDw+EvbpPaU28szcDl4QrL0?=
 =?us-ascii?Q?rBJ773HrYFD+zb1KaBEc9uU3huU20sdR1LWNMDHRc5GDF4G9ofYW53iWQ8qN?=
 =?us-ascii?Q?0knVFgwJuybv5wztfkVO2yYvk19P34H1r8k70SV6txY5bXIGTCkLZv/hHq89?=
 =?us-ascii?Q?xuLxYi9UT4hAfuneSyvt0ZHqZ4Z3g5RBdOnp8iYWMB7Hcfym+6r6R/bJyfIX?=
 =?us-ascii?Q?jQYBmPTEi72a3LOmJGqVyH9zFZRdertUB/CwFCFhv5o+SQil31RutF+ZIpw9?=
 =?us-ascii?Q?pjuBHEmCB/XNBiXCHzQJ8bg7rvpPzo8tlp/Kbm+b8sKnmqOrKltA1bnLIXQT?=
 =?us-ascii?Q?jTWRnMl+nlBznA/yhDqqYCAgTwPdiYfcU6/eObxV32L4tR5JXelMbCuDrleh?=
 =?us-ascii?Q?83Svw/OYMk1Unc6dMCl+Gjk0fMwShsWXPFtRtXb0ImzIIkFOSUNznh6ri7vy?=
 =?us-ascii?Q?eWleAxWkx3T5bN3BXhAiFHLZechOd6fTa86Nyp8F6GZ5TAEK0AZplS6aMpRW?=
 =?us-ascii?Q?IU1XA4929To7Ce5yEhQnKxgfFNDDMtunrjVEdKp1D71//kbzv0/UXriwayLG?=
 =?us-ascii?Q?7yX/0tlJ4sv5JJvp0aCTYCSCRSd/q0J4o4kk1ICIfqBNFn2XQS9DwnY+ieV0?=
 =?us-ascii?Q?SZ32+oja2T7R6qzSDd90/8oeCdO48LkR3wRszrbV5DGQx3LVYrsEdl0qeBii?=
 =?us-ascii?Q?O5n2AXJKTC3ddNwuBKFQk1/3SVWhHdP0TkQ1R0WpfN3pcZ0KXxz8J2WjtOje?=
 =?us-ascii?Q?Z1rva5Ea6CW7F3IGFO0fJuDOaEifJ5xxa/dZYCLkD1OIUE+Tj/kHhLc+0qrd?=
 =?us-ascii?Q?9JljDMwUo38dQ+ebRW9FcB3DcczI441C4EyXTBox34jxxtthgydgvGW/UAyK?=
 =?us-ascii?Q?ol4F1eaL72NxQuFHCQoXLGKOB17ymuqtT4XQR+YFVOeJSgYOqXrlIBd5e+8W?=
 =?us-ascii?Q?vCv9KimfDb4cIEpmCYytKJnKsbtmRXh2lg8v+/JtSXddvsEhCnk7lCM/Ud3L?=
 =?us-ascii?Q?tHcL3OwJT14nE15dewHroI+oDJmv61aUnYC/oOFpTYS1lNCqd5V4VSwIC9CL?=
 =?us-ascii?Q?I79Kh1bbzh4yrh60TuHh3q/x2ZwRjpfP+vSRXKluzacTa2qxOJxWEUXfiPo?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a549cd8-acab-4a6a-2c8c-08dd8405f937
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2025 14:32:14.7115
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR02MB8963

From: Peter Zijlstra <peterz@infradead.org> Sent: Friday, April 25, 2025 7:=
04 AM
>=20
> On Mon, Apr 21, 2025 at 06:28:42PM +0000, Michael Kelley wrote:
>=20
> > >  #ifdef CONFIG_X86_64
> > > +static u64 __hv_hyperfail(u64 control, u64 param1, u64 param2)
> > > +{
> > > +	return U64_MAX;
> > > +}
> > > +
> > > +DEFINE_STATIC_CALL(__hv_hypercall, __hv_hyperfail);
> > > +
> > >  u64 hv_pg_hypercall(u64 control, u64 param1, u64 param2)
> > >  {
> > >  	u64 hv_status;
> > >
> > > +	asm volatile ("call " STATIC_CALL_TRAMP_STR(__hv_hypercall)
> > >  		      : "=3Da" (hv_status), ASM_CALL_CONSTRAINT,
> > >  		        "+c" (control), "+d" (param1)
> > > +		      : "r" (__r8)
> > >  		      : "cc", "memory", "r9", "r10", "r11");
> > >
> > >  	return hv_status;
> > >  }
> > > +
> > > +typedef u64 (*hv_hypercall_f)(u64 control, u64 param1, u64 param2);
> > > +
> > > +static inline void hv_set_hypercall_pg(void *ptr)
> > > +{
> > > +	hv_hypercall_pg =3D ptr;
> > > +
> > > +	if (!ptr)
> > > +		ptr =3D &__hv_hyperfail;
> > > +	static_call_update(__hv_hypercall, (hv_hypercall_f)ptr);
> > > +}
>=20
> ^ kept for reference, as I try and explain how static_call() works
> below.
>=20
> > > -skip_hypercall_pg_init:
> > > -	/*
> > > -	 * Some versions of Hyper-V that provide IBT in guest VMs have a bu=
g
> > > -	 * in that there's no ENDBR64 instruction at the entry to the
> > > -	 * hypercall page. Because hypercalls are invoked via an indirect c=
all
> > > -	 * to the hypercall page, all hypercall attempts fail when IBT is
> > > -	 * enabled, and Linux panics. For such buggy versions, disable IBT.
> > > -	 *
> > > -	 * Fixed versions of Hyper-V always provide ENDBR64 on the hypercal=
l
> > > -	 * page, so if future Linux kernel versions enable IBT for 32-bit
> > > -	 * builds, additional hypercall page hackery will be required here
> > > -	 * to provide an ENDBR32.
> > > -	 */
> > > -#ifdef CONFIG_X86_KERNEL_IBT
> > > -	if (cpu_feature_enabled(X86_FEATURE_IBT) &&
> > > -	    *(u32 *)hv_hypercall_pg !=3D gen_endbr()) {
> > > -		setup_clear_cpu_cap(X86_FEATURE_IBT);
> > > -		pr_warn("Disabling IBT because of Hyper-V bug\n");
> > > -	}
> > > -#endif
> >
> > With this patch set, it's nice to see IBT working in a Hyper-V guest!
> > I had previously tested IBT with some hackery to the hypercall page
> > to add the missing ENDBR64, and didn't see any problems. Same
> > after these changes -- no complaints from IBT.
>=20
> No indirect calls left, no IBT complaints ;-)
>=20
> > > +	hv_set_hypercall_pg(hv_hypercall_pg);
> > >
> > > +skip_hypercall_pg_init:
> > >  	/*
> > >  	 * hyperv_init() is called before LAPIC is initialized: see
> > >  	 * apic_intr_mode_init() -> x86_platform.apic_post_init() and
> > > @@ -658,7 +658,7 @@ void hyperv_cleanup(void)
> > >  	 * let hypercall operations fail safely rather than
> > >  	 * panic the kernel for using invalid hypercall page
> > >  	 */
> > > -	hv_hypercall_pg =3D NULL;
> > > +	hv_set_hypercall_pg(NULL);
> >
> > This causes a hang getting into the kdump kernel after a panic.
> > hyperv_cleanup() is called after native_machine_crash_shutdown()
> > has done crash_smp_send_stop() on all the other CPUs. I don't know
> > the details of how static_call_update() works,
>=20
> Right, so let me try and explain this :-)
>=20
> So we get the compiler to emit direct calls (CALL/JMP) to symbols
> prefixed with "__SCT__", in this case from asm, but more usually by
> means of the static_call() macro mess.
>=20
> Meanwhile DEFINE_STATIC_CALL() ensures such a symbol actually exists.
> This symbol is a little trampoline that redirects to the actual
> target function given to DEFINE_STATIC_CALL() -- __hv_hyperfail() in the
> above case.
>=20
> Then objtool runs through the resulting object file and stores the
> location of every call to these __STC__ prefixed symbols in a custom
> section.
>=20
> This enables static_call init (boot time) to go through the section and
> rewrite all the trampoline calls to direct calls to the target.
> Subsequent static_call_update() calls will again rewrite the direct call
> to point elsewhere.
>=20
> So very much how static_branch() does a NOP/JMP rewrite to toggle
> branches, static_call() rewrites (direct) call targets.
>=20
> > but it's easy to imagine that
> > it wouldn't work when the kernel is in such a state.
> >
> > The original code setting hv_hypercall_pg to NULL is just tidiness.
> > Other CPUs are stopped and can't be making hypercalls, and this CPU
> > shouldn't be making hypercalls either, so setting it to NULL more
> > cleanly catches some erroneous hypercall (vs. accessing the hypercall
> > page after Hyper-V has been told to reset it).
>=20
> So if you look at (retained above) hv_set_hypercall_pg(), when given
> NULL, the call target is set to __hv_hyperfail(), which does an
> unconditional U64_MAX return.
>=20
> Combined with the fact that the thing *should* not be doing hypercalls
> anymore at this point, something is iffy.
>=20
> I can easily remove it, but it *should* be equivalent to before, where
> it dynamicall checked for hv_hypercall_pg being NULL.

I agree that setting the call target to __hv_hyperfail() should be good.
But my theory is that static_call_update() is hanging when trying to
do the rewrite, because of the state of the other CPUs. I don't think
control is ever returning from static_call_update() when invoked
through hyperv_cleanup(). Wouldn't static_call_update() need to park
the other CPUs temporarily and/or flush instruction caches to make
everything consistent?

But that's just my theory. I'll run a few more experiments to confirm
if control ever returns from static_call_update() in this case.

Michael

