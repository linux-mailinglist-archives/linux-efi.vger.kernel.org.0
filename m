Return-Path: <linux-efi+bounces-4277-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10AFBB01058
	for <lists+linux-efi@lfdr.de>; Fri, 11 Jul 2025 02:43:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6EBF1C857A0
	for <lists+linux-efi@lfdr.de>; Fri, 11 Jul 2025 00:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BA8FC2E0;
	Fri, 11 Jul 2025 00:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CsdBWDvY"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7457BA2D;
	Fri, 11 Jul 2025 00:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752194605; cv=fail; b=td3W6a1+s9zpG9SsfNImWYiSPbP4oMIBRvzgTWA0KX2+7p928og66jJLcjBlb5PNWRnNnf18iJSY7t9QbB2WMCSCwsJV46GohX0/JpUId68vzOW5mT/F59UMnE9FLSSx/4o7UF+wZedUmiN1Kf8zuEDBQS8RACLUbyKOLKaZVUQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752194605; c=relaxed/simple;
	bh=dlQ9D49qeRnAItQqBjMnkH/L/rgxSjHMvvrIYLYdGk4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=q72rPRvsi6jRogHVD8EPTEeAs3iXqsi2M5KZf3nyiZN9OwMRsooT5RAhzi81tlLlAoWFYkgNNfb1/2YJC2LjBjkUd5s+qaNkPvzBUkEVzjrnHyqfYk19PeKgG3aC0LV6cbOd4Ajto0t4HPzX4pUYCkPCTQRL+8dYjfZobCTJ6aI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CsdBWDvY; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752194604; x=1783730604;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=dlQ9D49qeRnAItQqBjMnkH/L/rgxSjHMvvrIYLYdGk4=;
  b=CsdBWDvYr0zlGSPJPnkLWraBRBEYxtZ7+YvAqrbGAmQQFKjwrsxGhaYY
   n/3qYT25ISpHpffIyxrjC7oA+Cu7M0DDBH8y0U0iEtlpjE8YC9eoldGT5
   Fz/tY+uU97Khsg3jqsQHUBJHuZeAkZEJQeJ3tSqLWkAAd/NAwmXNXBQOy
   l/1an+IhEKdtl/xEsepIcfMe08S8AdoSY5B6iD8Zbvjd9M/zFOa2Yp+Rz
   MpK/wOppscoRhXYf86XR07gfgpspM3+0NyN7vGPFo2saOvf7JH7Wqvln6
   0a/AbToBzqKyPaHMkj6qj2HRBdUJv0OR51lBCviosFxeGhdLH7VeNAkTY
   Q==;
X-CSE-ConnectionGUID: bFJyY5dwSha2Q/Ho6c2Pcw==
X-CSE-MsgGUID: h+NNsTStRQqXrtwRESdGsQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11490"; a="54643512"
X-IronPort-AV: E=Sophos;i="6.16,302,1744095600"; 
   d="scan'208";a="54643512"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 17:43:22 -0700
X-CSE-ConnectionGUID: tV1m/FTjQiWk0PSSTJETjg==
X-CSE-MsgGUID: mTPNrELYSXa9K1ze7XCwSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,302,1744095600"; 
   d="scan'208";a="156959464"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 17:43:21 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 10 Jul 2025 17:43:20 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Thu, 10 Jul 2025 17:43:20 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.86) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 10 Jul 2025 17:43:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LCxiBYYVTUt46ZPWf9l/2zS8noZrWCW905E7MNKXw2mGHx+unRPMhMACM1PLtBzepxA7PG0mEA7lXLw4Ikx6n3j/yA/qqW0RcbtHFzMM7K8V5IZ4hjiNiI/3Wn4khUMYPLXEj0wfE7httImf2GQDOUjebjo8Cq2hEgMurZMWP55rpajSupxYB1QgjcCsaKY9BO8remPlwYdX1WjkcI4rEK2pSWiJRBlU+Pn9Ja7dXF7hJ0/tjNHZ4u4969R88is+Pju/vs6LrgNAaBBvdvuyjzgV+fpw0mvu37JvL+s6D4PPRZiU5Cc8OG1ZBxgeh0SGqNGDGdpN0jjKlmdDv24ahA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tKoaKBahif6rRkMzkEoPVZwLUIjsDvFVwcwx9olgcho=;
 b=llsdwO8qL8bqsrzrPDq39HZGKXIITVVhGvxC5Kj5GfuMDzIUkIpRvdvZvL+eWbwatOOQMCNQ8MEbFqWnVeqxtXpyBnxjnsaaWfzySTyutY/a1ukBB6vsYUT3A1wPPf2hwnHdjHo4bdK2mprWuPxHruME5B0LSojErjc2CL33vPK+DWAdBLTvD8tRy3H6sjvV/5OFrXFxCQPyRFBcpOiNU7xuBv8zfRiaEgDKo/ZRXkZTQ3J04nsApkY3t+XlX1qPhZI2wt71pDAhCcrXcirXTaeLofEFUg3XaOlRexw6vVahTixq0DAHdiSLo77NO4O7ohfUWMg0IKbLLoyzGtFXGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by SJ2PR11MB8498.namprd11.prod.outlook.com (2603:10b6:a03:56f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.25; Fri, 11 Jul
 2025 00:42:35 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b%7]) with mapi id 15.20.8901.024; Fri, 11 Jul 2025
 00:42:35 +0000
Message-ID: <04f3eee0-ed12-41e3-9ccd-ac0182fed1b4@intel.com>
Date: Thu, 10 Jul 2025 17:42:33 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv9 16/16] x86: Re-enable Linear Address Masking
Content-Language: en-US
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
CC: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, "H. Peter Anvin"
	<hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, Ard Biesheuvel
	<ardb@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>, Josh Poimboeuf
	<jpoimboe@kernel.org>, Xiongwei Song <xiongwei.song@windriver.com>, Xin Li
	<xin3.li@intel.com>, "Mike Rapoport (IBM)" <rppt@kernel.org>, Brijesh Singh
	<brijesh.singh@amd.com>, Michael Roth <michael.roth@amd.com>, Tony Luck
	<tony.luck@intel.com>, Alexey Kardashevskiy <aik@amd.com>, Alexander Shishkin
	<alexander.shishkin@linux.intel.com>, Jonathan Corbet <corbet@lwn.net>, "Ingo
 Molnar" <mingo@kernel.org>, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Daniel Sneddon <daniel.sneddon@linux.intel.com>, Kai Huang
	<kai.huang@intel.com>, Sandipan Das <sandipan.das@amd.com>, Breno Leitao
	<leitao@debian.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>, "Alexei
 Starovoitov" <ast@kernel.org>, Hou Tao <houtao1@huawei.com>, Juergen Gross
	<jgross@suse.com>, Vegard Nossum <vegard.nossum@oracle.com>, Kees Cook
	<kees@kernel.org>, Eric Biggers <ebiggers@google.com>, Jason Gunthorpe
	<jgg@ziepe.ca>, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, "Andrew
 Morton" <akpm@linux-foundation.org>, Luis Chamberlain <mcgrof@kernel.org>,
	Yuntao Wang <ytcoode@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Christophe Leroy <christophe.leroy@csgroup.eu>, Tejun Heo <tj@kernel.org>,
	Changbin Du <changbin.du@huawei.com>, Huang Shijie
	<shijie@os.amperecomputing.com>, Geert Uytterhoeven
	<geert+renesas@glider.be>, Namhyung Kim <namhyung@kernel.org>, "Arnaldo
 Carvalho de Melo" <acme@redhat.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-efi@vger.kernel.org>,
	<linux-mm@kvack.org>
References: <20250707080317.3791624-1-kirill.shutemov@linux.intel.com>
 <20250707080317.3791624-17-kirill.shutemov@linux.intel.com>
 <b1408df7-abb4-4ac5-aff7-c04fda7dec7c@intel.com>
 <icjt25k4azqzkv5xlobcmlcubulohvfjakkb35dusiqe2xutq3@6jvha7chwwxd>
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <icjt25k4azqzkv5xlobcmlcubulohvfjakkb35dusiqe2xutq3@6jvha7chwwxd>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ2PR07CA0012.namprd07.prod.outlook.com
 (2603:10b6:a03:505::13) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|SJ2PR11MB8498:EE_
X-MS-Office365-Filtering-Correlation-Id: 2920c4bc-d11d-404f-ff3d-08ddc013d41c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?U1R2c3h4UjlkazNnK3V2MEpxbHIrV2twL1oxbzd2QXJUNFRIR1ZzcTNTQ21z?=
 =?utf-8?B?QlNmUVo5ZHplc1FwSFNucjhtV1NJbTROeTNkMnAvSlpjalFwS25nYndJM2Mz?=
 =?utf-8?B?TzQwejFSNlU4MklNU1JZUW04REVyUG00WTFMV0o4VEd5bnU0VlZiVndmTm5Z?=
 =?utf-8?B?STFoR3lDY0NVek8zTnVDWUF0eGZCT3pLZ2lSK3l2UjMyclhtSXJSOFBxb0hF?=
 =?utf-8?B?Y3REZnk0NktyL0dBRXlWcTJJUDViMHBRWTdscGV0V0orREp1NHljRGVWZW1p?=
 =?utf-8?B?V1RDTUFDQ1BNWWl2ejNRQ1NtYUIyM2JLcWhyM0dVQzMxVjNjbVUvS3luaTNu?=
 =?utf-8?B?THpxYnZ0ckxLYUtlTXRRTTFGaTdlZ1U5YVJDM2x6TGVNZFBJaXVORnhzeDlu?=
 =?utf-8?B?N25HTTJLejg3OUVzQ0c1cmxpV1JPZStHR3BoL00zZXFlR2lMb2VUTWk0ZzlZ?=
 =?utf-8?B?WU5QY21LSGp0UzNVMU15OVEzRWdQQnFTSUI5M3c4RUlYbnFlWlNoaVpjdVhU?=
 =?utf-8?B?aEFnVGFjRkNmdU9Qd2t4TE9FL3pHWXhTTnVVbWFrLzRoVUFrRk1SeXErSGY4?=
 =?utf-8?B?eVBXRExDem1PbmNGVGg5VTBTSFpsVGFod2lFcFlPN2lZczNWYy9hZVkwbnNC?=
 =?utf-8?B?U3NlaFNiWmIrOUdRSk1NKzJBSjVNUFVEeGhpamM2aVpFV3I1WHVTM0pKNzdK?=
 =?utf-8?B?KzdDQnVVdWhYelRWR2hBelROejRKd25uUk9NaEdWV2RXRHl6dThrdDIzU0Q4?=
 =?utf-8?B?V01zUEIyN3J0YlZZT01mYW5YMkc1V2hBOW1saUFhOVJiSVRaWFB5VnQ1TDV6?=
 =?utf-8?B?T3hZYWVNclE5KzU2WDdxNUhyZmp3K3pOZHMvSHV4VnFQeGxYb2FiQkx2OEpD?=
 =?utf-8?B?V2VRUEdGZTgrZmQxRUVndXI0bVphUHFjb3dmR3Zudm9hallzbXVLZ3BpcEdX?=
 =?utf-8?B?TGZUSHFrUjRuZXpwOHM4amJYSjZ1K3RvS241cGRTWU4vcHhTdEQrNDdPOG5O?=
 =?utf-8?B?QUlhc0RFOGFmcEdKN0NNcHVjSXJramtIb1lvVnRTWk9IbWNWWGZoWmE1T1d6?=
 =?utf-8?B?WlQ2bk9GTEJHVXRjdkVYWnQrLzFQbDdJdTR0dWJtN2lhSnNkMnlpZ0kzTWRN?=
 =?utf-8?B?T0hVTXRLWVI1WStFemttdTVPWGdSb2lNS1czZVIzckJLYUtjN2FNTXpiRWNO?=
 =?utf-8?B?ZWJKb29Wb2NvMzNjeFh2dHlDV0VrQkoxeUt5RlpGWnp5d0RTSDUzVU1xLzl4?=
 =?utf-8?B?YVg3emZaN0ptYmlaM0Jpc0pXMTMrZzhsRnc2VzBIaHdtRjdBRUJ6Z0ExYUw0?=
 =?utf-8?B?ZEZYQis0SllHQ0RwekhMaWd1bjhmTy9nUWl5blFxYTFDUUxpWnlKMFB0RXlF?=
 =?utf-8?B?bjVBdVpoSmtkT3llNDJZclRaK20wMVpsLzFuc0R6Y0lQd0VpdlFtYU16L3NU?=
 =?utf-8?B?MW82UGd2NzBBNVFaaURUckl5dVBoektjSkU0NEVwMHhJVzFVWHNBb2pvSmMz?=
 =?utf-8?B?M1BIcjA4SU11YkdZUEdUZDU5Mi9LR0lFS3lPY1JZb1dUSFEwMTFTclBVaVdK?=
 =?utf-8?B?NFBJVWNJeEFZSGZ2R1FScm5ydTJGVk9FV0dRclZ3a0NpZCt3ZzhWS21oTmlD?=
 =?utf-8?B?VTNNMGpRSjRYSGZYY3JPVUZPY3dNdXc4YnNhSzBlR3ZiNG92TWJqSFFOdFBu?=
 =?utf-8?B?ZjZRSk5BM2tuZFljdUZ0eG83V2xsSVo5bndYL1grQS8wSEpBdE9wNTR5UkRJ?=
 =?utf-8?B?UW93WkxMamp2QUw1a3I3dzFiNHpLK3hzKzUwMHZhQkc3a2tFU3hOS2JuRUdC?=
 =?utf-8?B?NFlIVXZPajZ0c0V2RWNPK1BXUVBEUG5tZEtrQ3NHVzFTQkJYZWQ1VzVUZXhS?=
 =?utf-8?B?czEwTlhCVGtEOTJ6M1NQNUxyQXQ1TmE2VWpSUnFUdU16S0FuaXM3emJKMysw?=
 =?utf-8?Q?Fv0dV3uDVxE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TnAxcDI2S2dQRERscEsrQmx3QndTMGljdVc2Y3ZBeU1FY01Kb2JPWDBsdVFR?=
 =?utf-8?B?dDFVVEVZQlJVT1V4MjhiRWNQUWRMVVo3RWxTVGI0ZzNFbllmVzFpUlFWN21K?=
 =?utf-8?B?Y2xhczBIaTc4VU5uczIzcVBuRFFrU0hrRHNPaW5GaVpyRHdYZFhWTjl2d3gy?=
 =?utf-8?B?NHcwa0dIVk5aWklLbGZRL1pjbTlTM285RysvWGt1SXBaK2lnM2FRQVB5Q2tl?=
 =?utf-8?B?S096RUNBM3hlcElhejdJL1grRGVacW01UFpIQTVLakpZTWszYmhZK0djTFYr?=
 =?utf-8?B?L2wxYzVXeGxjMEttZGtaajBGN3QwWkwrVmpoZktkbHgzb3JnZnlSczJhVDNx?=
 =?utf-8?B?N3YyMTBrTHBSemptdjRsK3RoZlI5aVZNMUFsY0RYMFNWWXdNRVQyUUpKZjlC?=
 =?utf-8?B?YjAya3R2ZDFld1g0YkJzd3NZZDZhVisvdWtNUVNKem11UDRNVlpBdnhqUm9w?=
 =?utf-8?B?WGM5TlFhbTd3VGlUMFpsNm1rS290NEFvRDNGaHZhalVRd25LOVdlS2lYUW5Q?=
 =?utf-8?B?N05iQ3BvNTMxYmJZcllyUTgvRHBQSjc5ejI0VzJkTlgwKzVxU2FRRUdxUjJH?=
 =?utf-8?B?RmVEQVVpRzRnOXFoMlRuQXJGektJQTdtZVc0NlB2QUg0c1Z3U1BjUHQyblZ6?=
 =?utf-8?B?OSsyMzhzajNLbno0TkRaZFZiS1NaUFhSQUZYcWl2OXNHb0FpZEVFZ2hwQUFN?=
 =?utf-8?B?VVRtaHVKS3FkamNtMjQrUngxQVpCVmxremF3T1kraCthdVR3YS9IdnBES3h4?=
 =?utf-8?B?VlZURHJRdXB6ODkxMVgzeXRDYXRTdmt4b1RDcmJ6bkdBZzFFN05ndjVEK3lB?=
 =?utf-8?B?L3ppbFVXa3orblZjQU91YjdoVldKR3RIY29kUnd5K01FemtIeE52VGo0S3dK?=
 =?utf-8?B?QkhmR3NhK1g5alhka0lSYVF6N2JBM2tsZ0RSTW5mVUxHNW5LUmdXZ2RtVmZh?=
 =?utf-8?B?WjUrbkdmNkdGUXd4Mk9uQmNhbHp5U2xwRk5OZ2dHUWdNd2pmZE5KME03Nm50?=
 =?utf-8?B?MEdqdFU3dWxOa3o0UUFqTys3SGkwZlE5anNUcGlqOUQ3OW4yZjFZZ0RlM3Fj?=
 =?utf-8?B?eXdkamdibWorQ1hHMXdsTHdOL0lwejBCUTJxQWdnN2R3ZVR6UnhwbThOMllt?=
 =?utf-8?B?ZTAreU1YV3JmaUtnb2l2UkFkMXVVV0dUZTM3d1R0VXNNQXFmMXRJcnlicVdC?=
 =?utf-8?B?cmhpRGtZSS85bHlQTnh0N3JNTVJWMUlmcXVYcS9HKzlXUjRLQmQxM25TMVk4?=
 =?utf-8?B?RUY3cXUwY04yclQxK2pNb3lOWTk3VnBpWEducW9hejlQYnNCRDNQSVB2SEFP?=
 =?utf-8?B?d1BiM3Y3K1NVTGNqYWQzalR2K25EWk5rZERUM2pnbkpkVisrOW1CN05LV1Z2?=
 =?utf-8?B?cEU5RWh5UitPTEYwSUE0a0lEOXZtalVmN3AyZmJwa3pzZ3pHWFlCSUtERHQw?=
 =?utf-8?B?OWpZb212eEdGWlVaOGh4VWpPU0txOXlhS3BSUUppZUhTZlNManV6T0pCM3Jp?=
 =?utf-8?B?em8zZTdRVVBZWmkvREFKL21KR2JSd2ovZUZFZVN2enpJczRXZTBDQUdBWEVu?=
 =?utf-8?B?UDgzcjM3ZlNLMU43a2c0cVllNjZJZmQwem1ZNUNUK3pKRHo5VzBBY25ITk00?=
 =?utf-8?B?SU51TTNhL0U5WlRsMlVxZnAzdFl3emhMZEpvR1hCMzVycXcxL3UyV1ZraVY5?=
 =?utf-8?B?U3ZOK3FmekJkaDZubUdSOWlpK3FmU090ZE9aUWh1RDJSZTU2ODl3elVJRHFh?=
 =?utf-8?B?b2JwTEhVcTZmZU1xRXhYTGErR2J3U0wvUVFQYmVDZjU1MXgxMGsrenZJcXNp?=
 =?utf-8?B?bGRxU0toNGhRUnEvc3Q3ajAzaEJrWFlHWE15bEpUYUsxRDBlVjlRZFdGbEYr?=
 =?utf-8?B?ZEN2cVBScTJEVkwyRnlMZFcxUkl3MVlOck4vTmlHUElNeS8wejlqc1dsc1BE?=
 =?utf-8?B?Q2Y4ZWV3NzJXRDVPTzVvMVFCQlJEWnNVZCtlVm1jTHZVNmE1Y3h5RjJoLzZa?=
 =?utf-8?B?eXZHVlhMUnZ2ZHVyVnlJWXNSMFJ4WTVkQ0ZkWWhGTWdScGJGZ1ZvOGhvdXVJ?=
 =?utf-8?B?WisveHd0akI5VStJcmlTZUl0c1hHcERTNU16TXFKT0J0WXdkeVhVS2tVdDc3?=
 =?utf-8?Q?yWhlnaQqBxwW8vvqJE0m/nbPi?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2920c4bc-d11d-404f-ff3d-08ddc013d41c
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 00:42:35.6630
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t/Jtp61fvG9zcWKCZ7R6iWjQ7ioyUktRqorwfUEh4qRVmgemnxH7Ap8zpguwOfINTmoEkESQkrVngoN6I/yV/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8498
X-OriginatorOrg: intel.com

On 7/9/2025 4:00 AM, Kirill A. Shutemov wrote:

> I've merged last two patches and updated the commit message:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/kas/linux.git/commit/?h=x86/lass
> 
> I hope it is still okay to use your Reviewed-by tag.
> 

Yes, that should be fine.

