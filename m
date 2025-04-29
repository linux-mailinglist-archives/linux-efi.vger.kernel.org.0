Return-Path: <linux-efi+bounces-3493-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D4FDAA1C45
	for <lists+linux-efi@lfdr.de>; Tue, 29 Apr 2025 22:36:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC25F1BA88E0
	for <lists+linux-efi@lfdr.de>; Tue, 29 Apr 2025 20:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8940D259CA0;
	Tue, 29 Apr 2025 20:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="u3WR3hR7"
X-Original-To: linux-efi@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazolkn19012054.outbound.protection.outlook.com [52.103.20.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D0522170A;
	Tue, 29 Apr 2025 20:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.20.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745958967; cv=fail; b=VbbrdEM1+L0ZJrfSzLEWJMYl3Y6cQwOnpusn6N/GYSIkuJH41Ftsf0gHJfpDEwhrapCC/iO0ufav7n55EIoBTKs0ij4ZWsGtxBNn3YTnjiCP/YvloVwIFmiv8yTQ/3NZ8F28n5Y8ldUUYHPKK6ja0yT/EpI6pgbUs2fv/xoGCTc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745958967; c=relaxed/simple;
	bh=v4yWQUGu/yLW/7S1RCfaexBphJzXygTMPgMVobUal6k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YUrkQCPwPgWEFUIxe66n/0/p3FUUZCX9suuGF18AqaQefY0G5vTrLUo0pITfbvpTV37YZSJdsLQvJT3Ap9H7UFi4jPPnYSiz+SFwMS9Vqdz+EoZcKqa6HlH7aWho23D3DG6+UVXDSFXj0ZdealDRQmwDpUok/kyXt4cUOWJRlXw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=u3WR3hR7; arc=fail smtp.client-ip=52.103.20.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BiAlhFImtekmhaAFOGgrbTRxPvTaF2oA2+1zdFxJh+vpEPWYk9ayb5KyXuStAFn3DHRaDNzWY2Kt17+l8lig8xsFCe4R3bCE1Gqn4JVuQbAK1cu4qvk5cj+hCZPdC0Pt24LcTmHQewAYUQEfLIOGCKEdKKVnyDJaUJBh58EDoJXHjKyyQ24FxiFww7rpdVGfBrkwgPTpvpcD67x4oslk1Diu775HZACmel7SdNU2Ngp8Ybk7Nrqsv7oRrYZnt3ax6MnodhsRu3xfMGO1bthYbR7nAc5e0i1W9LllMqZw2H+l/UuxdCdeJSFvY9SWoYXLF8T/ykl1Fkdsp1d8zUKMWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NiU09rNoKHwDI3YlHs62boc7BZsmoT7YoV7mpDpM+4c=;
 b=ZgNya2HgoG3I8e9gLLRXpR2HkENDtnRf7fW2sxGx3hruHyq2lPKzp/ZiwsGeCg2SigUfBRkSqhH6eTqB0IQ5QfW4FGCRvvLAG75nIKKHajZXAInetdmQEa9U/kWxIxxB3jRA/UyHsmcNiQM2bNCFxcmY+WPco9RWnOwc2R5KA9UYve/jDd/EW9xq1dNRysS8RiOj/EcT7rAOrY7sD1WENwAHpKYC2o68VgICqVhHxONB5hIJKLug9NPfzv1R/djX5mkMYk8gG5lwe0XAzPD780oOIbi9Q3pxAmJgIhGtw6sAVL9R783VwsdDJxVx0T3FTbQ87bXSz3uCJRdfWBluQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NiU09rNoKHwDI3YlHs62boc7BZsmoT7YoV7mpDpM+4c=;
 b=u3WR3hR7mmhZZLO+SCzjzLIo8vZj4cVpxYpyZWsYbLRJHHKQO5M/v1QTczIzpVv3Cido0rsg1NM+6xTIgEtavGg0U4thrqhIm+CleAAK3uvUQ1KLkA30Hh7NCciq0BVeFBkLwNBGhGy3aKYpBznGHnkAle60qay8TfHlCDTm1aRARmq0XkmXQIdg9kJh38gv8hwhdUdyesCo1TAlI/TfgxQ8DHTAcj9a58F1Zk1QcUsY85vJwzRSv8ie3RGJHhmi8hywW9jZfl40EgmSEQTg9WU0I+nscmkKk39COn5jrEPE4slHZk2R9OrArSED3wib3FULzdgLdWrqBB+ScJL86A==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by DM6PR02MB6651.namprd02.prod.outlook.com (2603:10b6:5:21b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.18; Tue, 29 Apr
 2025 20:36:03 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%3]) with mapi id 15.20.8699.008; Tue, 29 Apr 2025
 20:36:03 +0000
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
Subject: RE: [PATCH 4/6] x86,hyperv: Clean up hv_do_hypercall()
Thread-Topic: [PATCH 4/6] x86,hyperv: Clean up hv_do_hypercall()
Thread-Index: AQHbrTI1ClyCxqrVskO/s3zyhfdzdbOuXWeQgAx8BwCAAFfBcA==
Date: Tue, 29 Apr 2025 20:36:03 +0000
Message-ID:
 <SN6PR02MB4157DF6CA5F5597A0A4F78F8D4802@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20250414111140.586315004@infradead.org>
 <20250414113754.285564821@infradead.org>
 <SN6PR02MB41576A943191D154521C23C8D4B82@SN6PR02MB4157.namprd02.prod.outlook.com>
 <20250429151808.GJ4198@noisy.programming.kicks-ass.net>
In-Reply-To: <20250429151808.GJ4198@noisy.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|DM6PR02MB6651:EE_
x-ms-office365-filtering-correlation-id: e101ef67-ca72-4bff-229e-08dd875d75c2
x-ms-exchange-slblob-mailprops:
 AZnQBsB9XmpI8tRyoOXaSUmOkLVCBKas4A9rYUkY9CkpH1Ny2Ti6Pf4/9wvY+HrqI/7revzCB+H/2Y+m6zAb9oWlB3pNx/ADsRKvuE/VV8fFAu8/dO8GdP3d982h61jWN3iQi9Z3ldDweWaDiSJC+ZRc6cRbF1IRd/kcgaRPR9d1IIPOZsTm5sBYjNia6R5jc8meO2apdz0YVuF81aaUjkYokHfB3If/vJci9rk/AMkaq+3sPKy/X9prjyY1cJ3iA/pzJXZR8R3dFcEJqLQ966CbaJdg0EsqSu1eVvhXHC/G2KaNnWvCV+5yjsfOcew9IgHJeww/hfFer4lx+3w4OaAUKYqRZSvCWXSmQqYFy9286rv+24yhNXtg4iWvUH7pJsUH1N4JjkjCrG9eoVvCJm9nyabxfx28g88Rlys1agnX35I5OdknAehYwKz61SqP25cdt1KDVrsQVYQnbzhpkvl1OedzSHzvBdmQOJ/6vPro68R/91bXw3FATudVCunqH4DYu3ekpLOcH2udu8i6/6tAZtvSwTaeLNX+xwVzQMTZsKbbN+FkDW7ipOgAdLvIFEEEZ3ZxE/+lDf5AE3TKSqMMbaTJzetMlVxcNf5eyCb3pyECBmTc/hFdU8znK+B46VEsu4qoN74b33+NEQlAu3fSYBcsOhRWRNo3JdEolejxwd/15OXbP1PBFGioc2nSCujabElYKrUEjbeI7JmgjoyBZwtiF8lLfl8OB693idQuKA7mABX4G3V+vpSh4ef28mREmc769DE=
x-microsoft-antispam:
 BCL:0;ARA:14566002|8062599003|461199028|19110799003|8060799006|15080799006|3412199025|440099028|41001999003|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?ECSxiHJkSIDyzGVYPNHdeEXsuA0ApYHNnY1ractmNbgyo2UG1DcBaL+fdf4k?=
 =?us-ascii?Q?pzPT5rYSK/oct27evRkK6hYauRoRns1ap2sR73PEYMs3A/l/W7HSu9bLGwbD?=
 =?us-ascii?Q?v4x/TJs1mmyyFx7J/sUZpSGn2J1d446MM4z8u2XCj3q5aoJ0/pajODEbA7Ou?=
 =?us-ascii?Q?i8Vu+akXzgHCTqUTntylJU7VXsNWKUJPF6IsEVsJOzDsO753TZMbsqOvuJDg?=
 =?us-ascii?Q?MkIIxGf5kZkhQsOMduipvN5lYkh2o/bPye+83zVudvEU/e+yPCBRH0zTRjWo?=
 =?us-ascii?Q?7UzPSqdfAaGEsZnO7T1218lQt8WFzSQ3/po6YeROsaS4ZM6Xr5G8l4ylluWg?=
 =?us-ascii?Q?McD1vwF6C7zkdNh1ilUflzJGtHqTvkibg7+W3ekZuXAdzq/XsVq3v9CtxsBo?=
 =?us-ascii?Q?RYx35kXU8/SV8I6AHonvnki3N8HPhswyS6i7Oh4uyoy3cj9sVkIffxiKrYEz?=
 =?us-ascii?Q?BeTfX6Yjel35MYjwHUBe+AjsekFa9d4u1M2WNxwntvE/1uGnk3uxoTYoGwvI?=
 =?us-ascii?Q?lH8qZUpzw5Xw9cSnnx7bESLP4uLUIMqziaFpkuyOxdhyGHpPzrLVTDOylZTr?=
 =?us-ascii?Q?lk1leU0cbkafb8yn1M1KFwZdnV2a1v34gvDFlebMqj39MANTyVleGO7yE7pi?=
 =?us-ascii?Q?fcfq3ybgp1JNXlcP3ZqrcYEoZthbfiy9cRfd17oe9cm6bDoMq3DkC4kWpeax?=
 =?us-ascii?Q?4uA9yx0caOLIwHmDgHo7DkHcA66n55g/DWbxPZfgkx0eVIh3k4x8q0Bgxai2?=
 =?us-ascii?Q?3bny6k8afq7zH35t78BWK0yDLgfiI0A+N0hkvrI4M4m7vs8y7wSUfsibZbpj?=
 =?us-ascii?Q?dXDbgJYt+uN8N3v9/9YsBM85JlyU7G2omL9A9JCLgQaQYrEFklReXIlupfXh?=
 =?us-ascii?Q?XmGqpvUpCGvRE/gftFA1Jj7dnjUDFweD01Jw1rcf4Fns+UJmBj+Vd/M2f7/I?=
 =?us-ascii?Q?Pon9/5vjP/AJ7wOIuhlsr/lbVJJTf2KKT4uGCyJX6JfPo6mjv3PzHJOFRjAY?=
 =?us-ascii?Q?ahgBfE0fbK18axOld3JZ22PgjfMPnYp+zTbGg+TzzgzggtwnmjxawylxdooF?=
 =?us-ascii?Q?8xAlMkoG9Q62m5EVTU7DwcQkqJRQGUirIQjUjPLoZp98GTgcPdsOnVFQ1oIp?=
 =?us-ascii?Q?R7hooE/0jIAK?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?CRFPnv1pIWaDeoCcIY8BFjBUSBpQGDNDDNS/6E8U7Mj20SCnxn/pRD/wHXUv?=
 =?us-ascii?Q?2LxQS256OLjuXtbpVyq+UP4VuT0/runbE/D7uFOkU3QVU07K2DOKLIxQf1hQ?=
 =?us-ascii?Q?ZrdvjbrkXSan8YNsFanYkDAnPKBJgdt6X9d887SDnl5tQ5E3PzjbDTd9gtsd?=
 =?us-ascii?Q?8PQ/p+l4OMZxf+6/dvJ/x5ri0Qkc/TjPsrkCYzoeDcbppzzK8JPTYITJKpk2?=
 =?us-ascii?Q?yjgwF0dvoiuB6uUT5iINtZAhT6X4onxAYuToz4h93LsNZt0ZiY63yRUEDhZZ?=
 =?us-ascii?Q?4qjpcYpClLB4uwoE0nZYIN7JvWiiATAUVwHnARurJaFxJkKvvQ7ILB4MUqmI?=
 =?us-ascii?Q?vRVDxUClHEKZRJdb/xL5Jk1JSbpdbZIHmPKpjGl/MBk+szzWxzEm1mJdBa0O?=
 =?us-ascii?Q?65+T3hXTdkSv8SUOPaij11jTpJUsom4kzNVx+uePb2h5l2/U8vd+WR8cyfgo?=
 =?us-ascii?Q?/sYZ9QsQL8WQ5boOhiuebuzg6GYbJfiEMM0xV9LfNdptZ2vx0sMRpwpD7cHz?=
 =?us-ascii?Q?hNsKNPSPd4IH82jwsX47An4g8lXlVYQDQYgpDty7eUggwl0aObiyCOtBk1Pu?=
 =?us-ascii?Q?F538xfUtN0BoLpNN3obIKxawYvvLiyQHcsYqipY2Iqqatm5ZCMo+X+1KKEmL?=
 =?us-ascii?Q?lXEQ/nwzWfPfWRSxqzp12Rg0I0PGkt72xGz2I265bi/XL6N8DOXjVh7YWCyp?=
 =?us-ascii?Q?355bMY6guu3BXpBBw9ARHKON6ZlQicdkeVjN1ePbtLFIvMZ+GzUzyoVUyquA?=
 =?us-ascii?Q?fcP2035zwkRUXNS81eNSsNQQU6aqHPlWSxemdqKWY+Pb2MuT1q4+QgEGL/4q?=
 =?us-ascii?Q?HuH0+CHiyEtpfPrJpi561JSoXAJuxUw2TTywtpvhe5fOR7EcppnQbU4THvqt?=
 =?us-ascii?Q?X+oklTlhGpWPnMguqUANTZJp2msg0sIFfJl9vy+gHkawxAbIucNvdnS/0DvW?=
 =?us-ascii?Q?zHZADNTLFmp4Btv1tmmgbCIgTH9EXHflll5hP/bNaxu/y16X0y9Fzwcjm1MS?=
 =?us-ascii?Q?aew6quxNAPxZ1Ud+J1COiBifO/srPGOflBSkueqIWszr9g4uJ3KUPr2Hixgh?=
 =?us-ascii?Q?wljHPoKkSIA1/fiVst+CCKQ4l3f5UgCJanibM6p9FSjw307yB0AttxYMCh5u?=
 =?us-ascii?Q?MXm9hqNZzzfb8MTai2UE4p6XZvcp8aiB5ieGIKyy/egdtDdRWQc10kU4Rw1O?=
 =?us-ascii?Q?uS4HphBojzhGiDmQaYlVcPJeDRIdo34OhRoNo4fR2n8Fa9/KjvfRacggfyI?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e101ef67-ca72-4bff-229e-08dd875d75c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2025 20:36:03.3468
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB6651

From: Peter Zijlstra <peterz@infradead.org> Sent: Tuesday, April 29, 2025 8=
:18 AM
>=20
> On Mon, Apr 21, 2025 at 06:27:57PM +0000, Michael Kelley wrote:
>=20
> > > @@ -483,14 +484,16 @@ static void __init ms_hyperv_init_platfo
> > >  			ms_hyperv.shared_gpa_boundary =3D
> > >  				BIT_ULL(ms_hyperv.shared_gpa_boundary_bits);
> > >
> > > -		hyperv_paravisor_present =3D !!ms_hyperv.paravisor_present;
> > > -
> > >  		pr_info("Hyper-V: Isolation Config: Group A 0x%x, Group B 0x%x\n",
> > >  			ms_hyperv.isolation_config_a, ms_hyperv.isolation_config_b);
> > >
> > >
> > >  		if (hv_get_isolation_type() =3D=3D HV_ISOLATION_TYPE_SNP) {
> > >  			static_branch_enable(&isolation_type_snp);
> > > +#if defined(CONFIG_AMD_MEM_ENCRYPT) && defined(CONFIG_HYPERV)
> > > +			if (!ms_hyperv.paravisor_present)
> > > +				static_call_update(hv_hypercall, hv_snp_hypercall);
> > > +#endif
> >
> > This #ifdef (and one below for TDX) are really ugly. They could be avoi=
ded by adding
> > stubs for hv_snp_hypercall() and hv_tdx_hypercall(), and making the hv_=
hypercall static
> > call exist even when !CONFIG_HYPERV (and for 32-bit builds). Or is ther=
e a reason to
> > not do that?
> >
> > >  		} else if (hv_get_isolation_type() =3D=3D HV_ISOLATION_TYPE_TDX) {
> > >  			static_branch_enable(&isolation_type_tdx);
> > >
> > > @@ -498,6 +501,9 @@ static void __init ms_hyperv_init_platfo
> > >  			ms_hyperv.hints &=3D ~HV_X64_APIC_ACCESS_RECOMMENDED;
> > >
> > >  			if (!ms_hyperv.paravisor_present) {
> > > +#if defined(CONFIG_INTEL_TDX_GUEST) && defined(CONFIG_HYPERV)
> > > +				static_call_update(hv_hypercall, hv_tdx_hypercall);
> > > +#endif
> > >  				/*
> > >  				 * Mark the Hyper-V TSC page feature as disabled
> > >  				 * in a TDX VM without paravisor so that the
> > >
> > >
>=20
> I've ended up with the below.. I thought it a waste to make all that
> stuff available to 32bit and !HYPERV.
>=20
>=20
> --- a/arch/x86/hyperv/ivm.c
> +++ b/arch/x86/hyperv/ivm.c
> @@ -392,6 +392,7 @@ u64 hv_snp_hypercall(u64 control, u64 pa
>  #else
>  static inline void hv_ghcb_msr_write(u64 msr, u64 value) {}
>  static inline void hv_ghcb_msr_read(u64 msr, u64 *value) {}
> +u64 hv_snp_hypercall(u64 control, u64 param1, u64 param2) {}
>  #endif /* CONFIG_AMD_MEM_ENCRYPT */
>=20
>  #ifdef CONFIG_INTEL_TDX_GUEST
> @@ -441,6 +442,7 @@ u64 hv_tdx_hypercall(u64 control, u64 pa
>  #else
>  static inline void hv_tdx_msr_write(u64 msr, u64 value) {}
>  static inline void hv_tdx_msr_read(u64 msr, u64 *value) {}
> +u64 hv_tdx_hypercall(u64 control, u64 param1, u64 param2) {}
>  #endif /* CONFIG_INTEL_TDX_GUEST */
>=20
>  #if defined(CONFIG_AMD_MEM_ENCRYPT) || defined(CONFIG_INTEL_TDX_GUEST)
> --- a/arch/x86/include/asm/mshyperv.h
> +++ b/arch/x86/include/asm/mshyperv.h
> @@ -39,6 +39,10 @@ static inline unsigned char hv_get_nmi_r
>  	return 0;
>  }
>=20
> +extern u64 hv_tdx_hypercall(u64 control, u64 param1, u64 param2);
> +extern u64 hv_snp_hypercall(u64 control, u64 param1, u64 param2);
> +extern u64 hv_std_hypercall(u64 control, u64 param1, u64 param2);
> +
>  #if IS_ENABLED(CONFIG_HYPERV)
>  extern void *hv_hypercall_pg;
>=20
> @@ -48,10 +52,6 @@ bool hv_isolation_type_snp(void);
>  bool hv_isolation_type_tdx(void);
>=20
>  #ifdef CONFIG_X86_64
> -extern u64 hv_tdx_hypercall(u64 control, u64 param1, u64 param2);
> -extern u64 hv_snp_hypercall(u64 control, u64 param1, u64 param2);
> -extern u64 hv_std_hypercall(u64 control, u64 param1, u64 param2);
> -
>  DECLARE_STATIC_CALL(hv_hypercall, hv_std_hypercall);
>  #endif
>=20
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -287,9 +287,14 @@ static void __init x86_setup_ops_for_tsc
>  #ifdef CONFIG_X86_64
>  DEFINE_STATIC_CALL(hv_hypercall, hv_std_hypercall);
>  EXPORT_STATIC_CALL_TRAMP_GPL(hv_hypercall);
> +#define hypercall_update(hc) static_call_update(hv_hypercall, hc)
>  #endif
>  #endif /* CONFIG_HYPERV */
>=20
> +#ifndef hypercall_update
> +#define hypercall_update(hc) (void)hc
> +#endif
> +
>  static uint32_t  __init ms_hyperv_platform(void)
>  {
>  	u32 eax;
> @@ -490,10 +495,8 @@ static void __init ms_hyperv_init_platfo
>=20
>  		if (hv_get_isolation_type() =3D=3D HV_ISOLATION_TYPE_SNP) {
>  			static_branch_enable(&isolation_type_snp);
> -#if defined(CONFIG_AMD_MEM_ENCRYPT) && defined(CONFIG_HYPERV)
>  			if (!ms_hyperv.paravisor_present)
> -				static_call_update(hv_hypercall, hv_snp_hypercall);
> -#endif
> +				hypercall_update(hv_snp_hypercall);
>  		} else if (hv_get_isolation_type() =3D=3D HV_ISOLATION_TYPE_TDX) {
>  			static_branch_enable(&isolation_type_tdx);
>=20
> @@ -501,9 +504,7 @@ static void __init ms_hyperv_init_platfo
>  			ms_hyperv.hints &=3D ~HV_X64_APIC_ACCESS_RECOMMENDED;
>=20
>  			if (!ms_hyperv.paravisor_present) {
> -#if defined(CONFIG_INTEL_TDX_GUEST) && defined(CONFIG_HYPERV)
> -				static_call_update(hv_hypercall, hv_tdx_hypercall);
> -#endif
> +				hypercall_update(hv_tdx_hypercall);
>  				/*
>  				 * Mark the Hyper-V TSC page feature as disabled
>  				 * in a TDX VM without paravisor so that the

Yes, that's a reasonable improvement that I can live with. This source code=
 file
is certainly not a model for avoiding ugly #ifdef's, but your new approach =
avoids
adding to the problem quite so egregiously.

Michael

