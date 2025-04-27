Return-Path: <linux-efi+bounces-3470-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CC72A9DEE5
	for <lists+linux-efi@lfdr.de>; Sun, 27 Apr 2025 05:59:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D30065A00BB
	for <lists+linux-efi@lfdr.de>; Sun, 27 Apr 2025 03:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD1A71FDA92;
	Sun, 27 Apr 2025 03:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="biQAIitS"
X-Original-To: linux-efi@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azolkn19010012.outbound.protection.outlook.com [52.103.10.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE0D79E1;
	Sun, 27 Apr 2025 03:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.10.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745726339; cv=fail; b=M4l14yr4oa09xCTBPHwlClqf478MeiU0tdnlhCLwv4AD5GgGTCdXXPNwXfjXUMFPEM98z9lrlr/BRy69xKaNNp3iQwEWR+KKNcKc4GzLrHrho/6BMph6yWXhbaCKRGzoYX7VPDw3pLxvz+DvlQWBYe1AahxbHNzIw2I4yk1K7Io=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745726339; c=relaxed/simple;
	bh=ZcNHnO24Ls4N8/7WKcIR2gnv2goCpjoWhc9p9X1GWnI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RE4sJymRVypuoo4fkRdpFv8+8JoB1zHaN1X/mIJm2fHuZ3s6uKcVYz30fIZaLTety+J+MQumNNqd2u4mG3Io8cuM+HRi6R2W0vlbb4f3Hv9hJa8x3LdM8qiWNZiBSmQ4kamIodciPYCuGAikVsBGOln8dEoowfvlcqfXFE74NsE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=biQAIitS; arc=fail smtp.client-ip=52.103.10.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dAcETD6r7hp/hHbJuAUpC6YgF3ZkYmgP5/g4eIZ42g7kCUhfXOgvOw3JukwKSx1qmcFEReHzB5j61lY0qUA/gV0ZuEWr7XwBpZX6Ggk9/5oCBkQ755RvpRSdXKtanAp0oMvxPn5m0N5/VgV90FPhv0x7dsDf2J6lC4Yh1cGtthGT6J+ZjYtubSF0EDsTRojKgeK3TGW3MAZcOm7Q31lLL3TTG6PnaGY3l9U0NdWVj7sQCx2zVTFwE+PkfWFzG/FyqyagEm2/G5HwhO67dUg0NY/D2Bm2Q6RoAZUfHvvwYvvOlA1OXrpHH+63sBiZH6Sc48pbYa7CNkPdiCJgh5GcsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+aDJUGQEcVjvfSeHApRe74F+3m0E7Z5ZN6H7P0GhtNI=;
 b=uiiiTMI5WnyIZ/551dYSLRZdmq045NOUtzXr0P4+66jheS83LqgJlHsqoDPtc073i8wZ/mPbe7qd/t2RgcahrtRlddkhjbsR5mpXiLdZ40kyxwmAC7bkjFyP6qOm7LxubBluAqmUnRvjkQU16Ow/94+FehvHhA7WaFv9ZOMhwZdBCL7oF2cs/XC8GVSHJ5/bWj3GvXKFtlj2kbmyA+SXfFZJZ+kxyvTCt9sDByKnRd2lSgtn/uvokse63d+AH7bUTaLOL0ihVgUDSJPNASLmjqbtIGdaQCSzR+PawJ4yQUbBATKWZpaCmV3GYdXbIHYu+Mp1uU0kzW7oEaXMzeP3+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+aDJUGQEcVjvfSeHApRe74F+3m0E7Z5ZN6H7P0GhtNI=;
 b=biQAIitS/yAcjgGP8/8mkcbzp2TJHPiiPAXma7ROAenrKlNYUlJ5r/4RLqlO9Anc7PJwimp6SOSb3iqwQWnNG/HC72UfsPw/CvsMYkfuy71nSK742Fi7MJHNiIYXoWsa9N6+RrtN3j9RYBWHGi0rxlqpSlBHoUndLs8AmvSJhaBFNwCZxXexPf2Rg9gaFTQa+fjrKL5qr0CeDtfC7xwAFWTS9vQIlszWjsresvTs/N8ycv4Cucr6CnDivY5mQOqx0YKHsb+L76yS8jkhFxlmCeENCnnR2WoVYmbZIwYNUNsof5ILJ1VQOen2EuuD/kOzb6hRuvVaafkgHS00haaH6A==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by SA0PR02MB7145.namprd02.prod.outlook.com (2603:10b6:806:e2::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.10; Sun, 27 Apr
 2025 03:58:54 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%3]) with mapi id 15.20.8699.008; Sun, 27 Apr 2025
 03:58:54 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Michael Kelley <mhklinux@outlook.com>, Peter Zijlstra
	<peterz@infradead.org>
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
Thread-Index: AQHbrTIaLjXb7HTpjEywClCcZeg3ibOudLWAgAYGqoCAAAXRAIACceLQ
Date: Sun, 27 Apr 2025 03:58:54 +0000
Message-ID:
 <SN6PR02MB4157194E753702D204C20D09D4862@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20250414111140.586315004@infradead.org>
 <20250414113754.435282530@infradead.org>
 <SN6PR02MB41575B92CD3027FE0FBFB9F3D4B82@SN6PR02MB4157.namprd02.prod.outlook.com>
 <20250425140355.GC35881@noisy.programming.kicks-ass.net>
 <SN6PR02MB41577A6B0E5898B68E2CD3C9D4842@SN6PR02MB4157.namprd02.prod.outlook.com>
In-Reply-To:
 <SN6PR02MB41577A6B0E5898B68E2CD3C9D4842@SN6PR02MB4157.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|SA0PR02MB7145:EE_
x-ms-office365-filtering-correlation-id: 2ac82002-0f8c-44dc-434a-08dd853fd410
x-ms-exchange-slblob-mailprops:
 EgT5Wr3QDKyfA/kqhNtxhLoDzMvzACCoWPJDUsdTyeWzXukxEvV3mTUPttxp31gSXvJVEm3wb4a3WH3k/x9vDDr2e48mlNkzVxpAC8oyyp3kFPJfNMZWOGYJ1FQ7kkcRGSs94dpq+igIgfw08FhYXJ0jI9rxb3rGHnLqSnNqtQhUqk35BRFYJmdzY8374XMkzzdwt8LlZ/d3WtvWADtTtMQyb5NzdBaeItzoMb7Gdoqa4CEfZv2uTZWROLnyr0ExPM3WfGv8l7661Z42bKeZNfNTMX6SDYtwdlX0NwYuuzrUp80f2tfy01nKvbwTDHlfJLvskk+X/eUd8eb6LwTSbSoGTViY4Bn1wn4qy8mej3sSXpdjubViV02KggMlFeBnKoyXX1TGjYlkkhgoTrrWbby0ngNXtNfN8Cbyun234Mk2Q1/olMZkOurpZ7ikMzZkuEHB+56xxCosbs+IHdGIqDBmzWN0S4wPj7EbyXceSiD7OSaxpVFLtL8ltrYLNkS14ZrtVWgWmEqWZ4Dj6Wkz2YjKk0gVEYkMpJpV2TQy1aabXkid2LpbiU/G+l+NOYUUokLsewtKbG8XFRaif0EuaNWLPaFJ0UFiqZYMIIUo/kikZTJacVPALmgJQtEbUecSJdc3kvc8VaV4tG17XmNciE46uuJneaQEiuix3WGjLqPZJB+sixjsrsUomIYi3Wc2MY1NAGFJKEsdH3hSS1zz7klqAFI6p466hHOEClk/UCY=
x-microsoft-antispam:
 BCL:0;ARA:14566002|8060799006|15080799006|8062599003|19110799003|461199028|440099028|3412199025|41001999003|102099032|1710799026;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?uO5Rhcx+AQVfqqkdWVbaHvJCYJicVS8reQEwUewGRCK09rQpMTbxBf4CDfVq?=
 =?us-ascii?Q?HcdqMAWkEUs5eNJJAfoJVJdHnPVMXdLE9Vuhq6b3WdKV6n9/tGTiy6ltOO7V?=
 =?us-ascii?Q?VkPfkj3LuaGo63mjkyTu5EGYLR7SpzgKGwka4pY3L7CL16TrKbVMy1PbcWMg?=
 =?us-ascii?Q?A2hDFh26TG3c3eOs+4E+PMFBz2qAW65mJ8i6fk9K8QNuUDuZskgr9gkZTfUP?=
 =?us-ascii?Q?SeXMuPys9VjlU/dAT4Yi+PaUHRkzXC/yJzWvyUPs2kahme7tHeXnEeSRb3CX?=
 =?us-ascii?Q?IYCcZiqR6g6qPQrzHAs4JmHnfq+JGsDxtlMur+WyP5Rq2cvpkraglEd2FqZF?=
 =?us-ascii?Q?CQW5/BJw13da1jgD7SnWeAylgbnK/bEpCmLmPTkyoy9DXqdvGVpBM69TlETL?=
 =?us-ascii?Q?IDIqJDAylYpWYcavoEgb956IOF/9R3TKyvxEP5H7Krak/DBcru4sFe6pe4l4?=
 =?us-ascii?Q?3TTnNwhB6y/83ctkvKSVl69wqXnKuTVWoRoaxIzrsv7wt8vqKfzYO68gr9Fc?=
 =?us-ascii?Q?dwp32Z3kW2taGqfVxJkEea6m8Lc+IaSBMtsCyoyyQMXv2mdK3ZsDo+ZSczxK?=
 =?us-ascii?Q?Oh1GpLn5fgzeqb2vZv5KjDxpQhYSFbLR4QQI/p+bpRHpULJY89if76KvQrMj?=
 =?us-ascii?Q?a3YHSIstP7neRR4vYhp8uktOE/1NdkhRb8q6S78vmrwpM2p8jfkqnUy+5GoI?=
 =?us-ascii?Q?PjD6V0WZu+C61UlRLl9qbmu0uAwcWy/PUQE/MuNqaIUBVZLA4tm2YLaCgePQ?=
 =?us-ascii?Q?r2K0xK1xYkMzxj30CsF1t6sTpHn6fIPevqWhhx/cYrDkhwL+Gun+LaTeGqVn?=
 =?us-ascii?Q?jhlcH8pYlpi6XC0YuDybtF6lOpqChTzFBI6aysMxV9GTa4+GCMwfVCCu8t8L?=
 =?us-ascii?Q?HaXEH+f0al/6nPkM+hwe1QJ7lP7jp9Wl5vhKablXI0FYNHKBPl9GOYx04pAW?=
 =?us-ascii?Q?v32hA5kr85PiUamhKNT38XhCHNXrYjHlNN9WNp7fBXV4m/zb69ldZh2v46y2?=
 =?us-ascii?Q?HFsfXGUwU+TsUb0l7d1mwK/ac6n7EiHRXLqHUWt0q98/SXwxl1gpC39/gyRi?=
 =?us-ascii?Q?6+FURl139FwgCKcavTs0WOogU1P401/AYb13rK1ZXYb6QI/+mjpAA6vjsHqg?=
 =?us-ascii?Q?xxzm7/lG2nEL/7zgMjjGrfQ1beomQOBGvg=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?0wrgpkJhwKpReTxPaDU2ojjqDcKZiJUHJRxs2seKmkCqLv2jKZR8bPHghWYq?=
 =?us-ascii?Q?Hh8kP96BZ5orCiO5aVubX/BJ7Q29l90B5LepNlrVXfyLykhroLqYxj0cc6fg?=
 =?us-ascii?Q?SAcp8K34RHYd0CpYizvuK/yyMWdJHd+bMwhLZaehtcMBaI0hNAbL7DDYLUAm?=
 =?us-ascii?Q?+ouyV0BPemPoNx3ICXae1B5Eys+AH6/DlfX6OMXebp0tWne7uI3WC84whLfd?=
 =?us-ascii?Q?1EGLwkFtnyknCqo68nh9eNfPXx6z05icJcAZSF1TQrz46bY2FKg+kJ4mfu7F?=
 =?us-ascii?Q?zNjQxHbgcUB6GWt3zFp+Aa/9y/df9ANKgERuypMaXxLcvZPLpnu9GlRWNMwN?=
 =?us-ascii?Q?pIYs04TtFnDl8cWYqvSzg35n0GTcO628n0cYa3yZhbkFdIYtsKUk9YSfsqY+?=
 =?us-ascii?Q?4OiUSIri08XPIrqVEMC2l/Ts0d/6Sa6EYrWOjEy5OBCAd2BdNcgyerBxZ8F/?=
 =?us-ascii?Q?brEcQoCeC3d7Q0u9MhbP+HGZFdDMg7uDFR9OSyV4a2HItsvno4XwxmoP2Udd?=
 =?us-ascii?Q?De3mBuBlON4TMXsKs99dyfclYzZtM+8CHCsuuXgMkDswZXhBT+4EyapJrgSO?=
 =?us-ascii?Q?kSnV3HoCoNRv0VlAn0Wps8flgbnWf6jrvoyehGek4LSIc6xiFMOkTcy9dqt4?=
 =?us-ascii?Q?MbGoO5yfWoj2u3K9TamGHxL5PdHj/kfl1lQU2ntPe+2MfrWEC94pogi3eGtP?=
 =?us-ascii?Q?rDv9LKCx/9JMI8YFpSPMZbRXkf7vXoaxwQLgKzEtr6zk+wm0wsWU13J+R4TB?=
 =?us-ascii?Q?/LJOth/WQUP8aKzftEkDBMXeSNVlHMN+H2OF9VoIWAWr+tr/viluiSk5c/j/?=
 =?us-ascii?Q?0gXz8RfMNbsVqZAOzt2hTUykMHZAZlxB5191RCCsrkBaD5K07nrKT3Xx1Z1+?=
 =?us-ascii?Q?FyxspqzXDGaG9zeI9OEWwlAUG4YwhtazBRr0zjNz17i4NgjnYRNRTE9LpFG5?=
 =?us-ascii?Q?UPN32Y1F1+vWTIOtvZlJlvI9xU7/JiPbep8CkRczI9FvY3TC1f8V+uwqG4Fl?=
 =?us-ascii?Q?F1gYA/zciNRwPWQrftFjfx3PgUAZM4CIF/7JFZ26Wn4xyt67Gi0ipBxjzmLv?=
 =?us-ascii?Q?oYqfz3C+2A1FVwWcufVp+DbV2XtmU+732w/LE+wVYjHGjIqa1NT2t8FcWo7L?=
 =?us-ascii?Q?KpPmFeDNEwXfv8I5xfPUVR86qxbEMcabyTv1BoyARIVfKP54poRxfbLt79Tj?=
 =?us-ascii?Q?iweaV9WajqF7LZYBekCEyWcWUkvzgyfqBpQH1cTXW1Tu4UhDzHjPUKhkOr4?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ac82002-0f8c-44dc-434a-08dd853fd410
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2025 03:58:54.3212
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR02MB7145

From: Michael Kelley <mhklinux@outlook.com> Sent: Friday, April 25, 2025 7:=
32 AM
>=20
> From: Peter Zijlstra <peterz@infradead.org> Sent: Friday, April 25, 2025 =
7:04 AM
> >
> > On Mon, Apr 21, 2025 at 06:28:42PM +0000, Michael Kelley wrote:
> >
> > > >  #ifdef CONFIG_X86_64
> > > > +static u64 __hv_hyperfail(u64 control, u64 param1, u64 param2)
> > > > +{
> > > > +	return U64_MAX;
> > > > +}
> > > > +
> > > > +DEFINE_STATIC_CALL(__hv_hypercall, __hv_hyperfail);
> > > > +
> > > >  u64 hv_pg_hypercall(u64 control, u64 param1, u64 param2)
> > > >  {
> > > >  	u64 hv_status;
> > > >
> > > > +	asm volatile ("call " STATIC_CALL_TRAMP_STR(__hv_hypercall)
> > > >  		      : "=3Da" (hv_status), ASM_CALL_CONSTRAINT,
> > > >  		        "+c" (control), "+d" (param1)
> > > > +		      : "r" (__r8)
> > > >  		      : "cc", "memory", "r9", "r10", "r11");
> > > >
> > > >  	return hv_status;
> > > >  }
> > > > +
> > > > +typedef u64 (*hv_hypercall_f)(u64 control, u64 param1, u64 param2)=
;
> > > > +
> > > > +static inline void hv_set_hypercall_pg(void *ptr)
> > > > +{
> > > > +	hv_hypercall_pg =3D ptr;
> > > > +
> > > > +	if (!ptr)
> > > > +		ptr =3D &__hv_hyperfail;
> > > > +	static_call_update(__hv_hypercall, (hv_hypercall_f)ptr);
> > > > +}
> >
> > ^ kept for reference, as I try and explain how static_call() works
> > below.
> >
> > > > -skip_hypercall_pg_init:
> > > > -	/*
> > > > -	 * Some versions of Hyper-V that provide IBT in guest VMs have a =
bug
> > > > -	 * in that there's no ENDBR64 instruction at the entry to the
> > > > -	 * hypercall page. Because hypercalls are invoked via an indirect=
 call
> > > > -	 * to the hypercall page, all hypercall attempts fail when IBT is
> > > > -	 * enabled, and Linux panics. For such buggy versions, disable IB=
T.
> > > > -	 *
> > > > -	 * Fixed versions of Hyper-V always provide ENDBR64 on the hyperc=
all
> > > > -	 * page, so if future Linux kernel versions enable IBT for 32-bit
> > > > -	 * builds, additional hypercall page hackery will be required her=
e
> > > > -	 * to provide an ENDBR32.
> > > > -	 */
> > > > -#ifdef CONFIG_X86_KERNEL_IBT
> > > > -	if (cpu_feature_enabled(X86_FEATURE_IBT) &&
> > > > -	    *(u32 *)hv_hypercall_pg !=3D gen_endbr()) {
> > > > -		setup_clear_cpu_cap(X86_FEATURE_IBT);
> > > > -		pr_warn("Disabling IBT because of Hyper-V bug\n");
> > > > -	}
> > > > -#endif
> > >
> > > With this patch set, it's nice to see IBT working in a Hyper-V guest!
> > > I had previously tested IBT with some hackery to the hypercall page
> > > to add the missing ENDBR64, and didn't see any problems. Same
> > > after these changes -- no complaints from IBT.
> >
> > No indirect calls left, no IBT complaints ;-)
> >
> > > > +	hv_set_hypercall_pg(hv_hypercall_pg);
> > > >
> > > > +skip_hypercall_pg_init:
> > > >  	/*
> > > >  	 * hyperv_init() is called before LAPIC is initialized: see
> > > >  	 * apic_intr_mode_init() -> x86_platform.apic_post_init() and
> > > > @@ -658,7 +658,7 @@ void hyperv_cleanup(void)
> > > >  	 * let hypercall operations fail safely rather than
> > > >  	 * panic the kernel for using invalid hypercall page
> > > >  	 */
> > > > -	hv_hypercall_pg =3D NULL;
> > > > +	hv_set_hypercall_pg(NULL);
> > >
> > > This causes a hang getting into the kdump kernel after a panic.
> > > hyperv_cleanup() is called after native_machine_crash_shutdown()
> > > has done crash_smp_send_stop() on all the other CPUs. I don't know
> > > the details of how static_call_update() works,
> >
> > Right, so let me try and explain this :-)
> >
> > So we get the compiler to emit direct calls (CALL/JMP) to symbols
> > prefixed with "__SCT__", in this case from asm, but more usually by
> > means of the static_call() macro mess.
> >
> > Meanwhile DEFINE_STATIC_CALL() ensures such a symbol actually exists.
> > This symbol is a little trampoline that redirects to the actual
> > target function given to DEFINE_STATIC_CALL() -- __hv_hyperfail() in th=
e
> > above case.
> >
> > Then objtool runs through the resulting object file and stores the
> > location of every call to these __STC__ prefixed symbols in a custom
> > section.
> >
> > This enables static_call init (boot time) to go through the section and
> > rewrite all the trampoline calls to direct calls to the target.
> > Subsequent static_call_update() calls will again rewrite the direct cal=
l
> > to point elsewhere.
> >
> > So very much how static_branch() does a NOP/JMP rewrite to toggle
> > branches, static_call() rewrites (direct) call targets.
> >
> > > but it's easy to imagine that
> > > it wouldn't work when the kernel is in such a state.
> > >
> > > The original code setting hv_hypercall_pg to NULL is just tidiness.
> > > Other CPUs are stopped and can't be making hypercalls, and this CPU
> > > shouldn't be making hypercalls either, so setting it to NULL more
> > > cleanly catches some erroneous hypercall (vs. accessing the hypercall
> > > page after Hyper-V has been told to reset it).
> >
> > So if you look at (retained above) hv_set_hypercall_pg(), when given
> > NULL, the call target is set to __hv_hyperfail(), which does an
> > unconditional U64_MAX return.
> >
> > Combined with the fact that the thing *should* not be doing hypercalls
> > anymore at this point, something is iffy.
> >
> > I can easily remove it, but it *should* be equivalent to before, where
> > it dynamicall checked for hv_hypercall_pg being NULL.
>=20
> I agree that setting the call target to __hv_hyperfail() should be good.
> But my theory is that static_call_update() is hanging when trying to
> do the rewrite, because of the state of the other CPUs. I don't think
> control is ever returning from static_call_update() when invoked
> through hyperv_cleanup(). Wouldn't static_call_update() need to park
> the other CPUs temporarily and/or flush instruction caches to make
> everything consistent?
>=20
> But that's just my theory. I'll run a few more experiments to confirm
> if control ever returns from static_call_update() in this case.
>=20

Indeed, control never returns from static_call_update(). Prior to
hyperv_cleanup() running, crash_smp_send_stop() has been called to
stop all the other CPUs, and it does not update cpu_online_mask to
reflect the other CPUs being stopped.

static_call_update() runs this call sequence:

arch_static_call_transform()
__static_call_transform()
smp_text_poke_single()
smp_text_poke_batch_finish()
smp_text_poke_sync_each_cpu()

smp_text_poke_sync_each_cpu() sends an IPI to each CPU in
cpu_online_mask, and of course the other CPUs never respond, so
it waits forever.

Michael

