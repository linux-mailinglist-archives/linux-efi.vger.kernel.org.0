Return-Path: <linux-efi+bounces-2050-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 646179B55C2
	for <lists+linux-efi@lfdr.de>; Tue, 29 Oct 2024 23:26:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23A76285851
	for <lists+linux-efi@lfdr.de>; Tue, 29 Oct 2024 22:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7697D20ADDA;
	Tue, 29 Oct 2024 22:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dCpf4pqk"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64EDB208237;
	Tue, 29 Oct 2024 22:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730240791; cv=fail; b=LsLKzPp0oRR4ORfTxhlesQEtzZ9gizsmhVH7jNgsnLv0ckEL0E5bWWgwZ1ajySCSo94n7UTbgN4hPOVUOQG0ro3suMhZreQgqsbYLGxVuMRF5om0g+zh81hVVeDUZm9bAs5vCedcdATXwdFHKF59jm5LUJB394CdGF+4iYD7uJM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730240791; c=relaxed/simple;
	bh=cis3NVENys9kqb+P5AuNFAJ6zXnbUD9tqDMVwHTr2BY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jHXH4Dw448TagZFlIo1JcjgXPDATlbdq5y6cPLav2Z5A0a/jy4ztzC5/gfQi24M63rvXNU/N+7LLEQgxQaibBgX0p+GYs8Pde6rPoySWz7j7GWB3RK1UMXCsDlkDqJBPM9n+q9JJ1dd237ObYRcJ54IUNYcc0caM9LmvxumMKFQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dCpf4pqk; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730240789; x=1761776789;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=cis3NVENys9kqb+P5AuNFAJ6zXnbUD9tqDMVwHTr2BY=;
  b=dCpf4pqkNivsNsrsz0+OZTB1Tkls8eFwaynur4EkSHk78giEbz5iBMYL
   OwxexXNU81uB+Y4PWUF8p1zO0QoqOOhcRrmqrdqTux40o4Q+kePbIMPJ2
   T22QfeYLMScV+ZQFUzd3BimmWszNnwjhJXzssVPY3mfaN0Hw9SxFb/ne2
   KyJKi0KmrKbe3WWwfjoc/gSZYi3aZ5jiCj3YtLcjXcDnf0/tb5G07d+oV
   yUwpHjNVzM+hDEzt2fXkNin9lsRsIHKNLsTlYPmQt/dRVn0bKRPv8UKyN
   S2nCt7FuMBUEvEjzNGbBZ+mmQPD2RLk/Pb9tr3oyWTBY2UQMper8ebR5d
   g==;
X-CSE-ConnectionGUID: +rMlpl0OT1S2Aden22ZSKw==
X-CSE-MsgGUID: Y+6htfNZQdS/DaVNohb5lg==
X-IronPort-AV: E=McAfee;i="6700,10204,11240"; a="29363002"
X-IronPort-AV: E=Sophos;i="6.11,243,1725346800"; 
   d="scan'208";a="29363002"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 15:26:27 -0700
X-CSE-ConnectionGUID: zpY/HC+LSgmw7Ce8t/E/ww==
X-CSE-MsgGUID: bgjVKbSuTCaACwD9uy0xvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,243,1725346800"; 
   d="scan'208";a="86719123"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Oct 2024 15:26:27 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 29 Oct 2024 15:26:26 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 29 Oct 2024 15:26:26 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.48) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 29 Oct 2024 15:26:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RNzmu7UNB59sgcZkv2Qo010dQb8qKbo+eZb99g03VCJtn3N3xEPZdna9OwI/fnAC0kUCYhIpSR0g8LY1dvS5BZyf67Kxvq1H4muKgZyU4EckdThtGsu6g8evSvKMUgKFVMyQygJPwKjrWgyDW7M7r1NzYiqWfuGaT4MVpbtSfU7s9DU5XmTOW/HKzsItEQYNs05rsGDkwG108VoV0zxi7Z53SlcAtp9sfyR9A32xsmSHYGoU5pu9xpTpJMG6WcZp6Kx8rrbFfjAaJC92EsNHlYjGHYc3tJV0DYYm+BRyBdAKOPO2TXYbjIItLD5/51kx07kZvAhY/xHV+Qe7f/kepA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cis3NVENys9kqb+P5AuNFAJ6zXnbUD9tqDMVwHTr2BY=;
 b=NuafWqNFOwnGOKPP/4tyUui+P6HuqbxCbOcMphnA/3g2pxPigdo8+4/afb3T3riScSnXHM8Wv2EQv4gqpkNCsW6No3FM32bUxRseF1daBSEuDyDhWdnwguiNHGULwuVjGksjz1ZyUwlGtoh7t4s2EB8LIyqhrdsLdKpQ2d4t+87R0jsiV03rF6ly0acj0ruB3vt5MWQm3b+uOcCkh4fQBc3jtYqLV/z6w/aUA9Ww2L91+OGAJa01OO/ahkz6s5TWtQN4SWkGBe/0yJtNSAJV5PU+qbqE0oDZumLxE/vrYHO480Uur/3BWYJTVG4++jbBwSJch5dLAi4g3AobiH1g7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by PH0PR11MB5903.namprd11.prod.outlook.com (2603:10b6:510:144::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.21; Tue, 29 Oct
 2024 22:26:02 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361%4]) with mapi id 15.20.8093.025; Tue, 29 Oct 2024
 22:26:02 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: "Mehta, Sohil" <sohil.mehta@intel.com>, Alexander Shishkin
	<alexander.shishkin@linux.intel.com>, Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, "Peter
 Zijlstra" <peterz@infradead.org>, Ard Biesheuvel <ardb@kernel.org>, "Paul E.
 McKenney" <paulmck@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Xiongwei Song <xiongwei.song@windriver.com>, "Li, Xin3" <xin3.li@intel.com>,
	"Mike Rapoport (IBM)" <rppt@kernel.org>, Brijesh Singh
	<brijesh.singh@amd.com>, Michael Roth <michael.roth@amd.com>, "Kirill A.
 Shutemov" <kirill.shutemov@linux.intel.com>, Alexey Kardashevskiy
	<aik@amd.com>
CC: Jonathan Corbet <corbet@lwn.net>, Ingo Molnar <mingo@kernel.org>, "Pawan
 Gupta" <pawan.kumar.gupta@linux.intel.com>, Daniel Sneddon
	<daniel.sneddon@linux.intel.com>, "Huang, Kai" <kai.huang@intel.com>,
	Sandipan Das <sandipan.das@amd.com>, Breno Leitao <leitao@debian.org>,
	"Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, Alexei Starovoitov
	<ast@kernel.org>, Hou Tao <houtao1@huawei.com>, Juergen Gross
	<jgross@suse.com>, Vegard Nossum <vegard.nossum@oracle.com>, Kees Cook
	<kees@kernel.org>, Eric Biggers <ebiggers@google.com>, Jason Gunthorpe
	<jgg@ziepe.ca>, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, "Andrew
 Morton" <akpm@linux-foundation.org>, Luis Chamberlain <mcgrof@kernel.org>,
	Yuntao Wang <ytcoode@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Christophe Leroy <christophe.leroy@csgroup.eu>, Tejun Heo <tj@kernel.org>,
	Changbin Du <changbin.du@huawei.com>, Huang Shijie
	<shijie@os.amperecomputing.com>, Geert Uytterhoeven
	<geert+renesas@glider.be>, Namhyung Kim <namhyung@kernel.org>, "Arnaldo
 Carvalho de Melo" <acme@redhat.com>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-efi@vger.kernel.org"
	<linux-efi@vger.kernel.org>
Subject: RE: [PATCH v5 05/16] x86/cpu: Defer CR pinning setup until after EFI
 initialization
Thread-Topic: [PATCH v5 05/16] x86/cpu: Defer CR pinning setup until after EFI
 initialization
Thread-Index: AQHbKVP0cuDlVV7xLE2PM0asFJfZPLKeTCEAgAACT+A=
Date: Tue, 29 Oct 2024 22:26:02 +0000
Message-ID: <SJ1PR11MB6083B9854320176B6301C530FC4B2@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20241028160917.1380714-1-alexander.shishkin@linux.intel.com>
 <20241028160917.1380714-6-alexander.shishkin@linux.intel.com>
 <a95a624b-214a-4b1f-ac16-dad5a9270bf8@intel.com>
In-Reply-To: <a95a624b-214a-4b1f-ac16-dad5a9270bf8@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|PH0PR11MB5903:EE_
x-ms-office365-filtering-correlation-id: 6b0bfbfb-3264-4a08-b2fa-08dcf868abfd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|921020|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?c0FUa29Eby9qS2YrcWRxaUU2Rzc3REQzbW9LVUFuT1NrUVNuck1wWEpIMGM5?=
 =?utf-8?B?c3VWekhZYXUwQWp2WVdRZUl2TngwQ2kyb0RNVmVsSHlFRXN6UTVmdXFJNjRa?=
 =?utf-8?B?UmpnRnN3VHZKZy9lK25mamVBUlQvakgyVW9sUVdkYmJIcXFaK2J5cFZ0ZHJz?=
 =?utf-8?B?UHJzZEdBQ0RBNmJ2MUFMbWUvZW1CSUNVZkI1OFIxTlVhb3BpZVhmU3ZEblp6?=
 =?utf-8?B?VTMwUjM4M202bUZzQ0hTbjJnNFN1TFZQck5wdEg0VEhVaDU3eGhtcFFkNjhI?=
 =?utf-8?B?RVlXRTRzeWI2T2lSNkJUWVFrWWpra0oybC9ZL3VlNE5KcXRobDJYSTNGSklz?=
 =?utf-8?B?b0dRTU0xUW9tWTRQLzJUWU5MQ0tXMGhibGtINjJrU3NOeSswRk0xUkRhRFox?=
 =?utf-8?B?LzNxNW4wZUlCTXQvemNVZTRFMFJKUWJnNU5rY0Y4UkYrTmcreGJsdUYrZkNk?=
 =?utf-8?B?V0c0WHpacjhiMFhIOCs1cFE0R2oyZndMejJCVitoUDQzcXJWelJKRFAvWlRa?=
 =?utf-8?B?UEZFSDlXR0tzejJxV2FtRVdpbEpuTnd1T2hxVldXdmhJdHgrQndEVHFRaE9X?=
 =?utf-8?B?NUpoQmZhd0ZnU2diVzN2eWdqUWhwNS9RS3ZoM01DK0dJOU5iTnp5NTg4NnVD?=
 =?utf-8?B?RVVkWHJBV2ZLVWhTM0FCRFcrK1Y4UVpkaUx2Y2lUeW1pelp2VUJFdnUwWkRY?=
 =?utf-8?B?bGoyc2dIdkVkOHl2cUkzdW1GNHRzWFBDVjZFMTdFN2lkSkJwUENPV1RBTlcv?=
 =?utf-8?B?TFNnem55N3hsMnpoQ1pOazh4OUZpdTRjdjhQa2JVSVZkRWpMcWdCQlFYWnZp?=
 =?utf-8?B?R2pGUm9Eb3hjRlgrbFJWK0I2NDZ4TC94UVZVNmxxcVd6Z1cxOU1qNnQ0dGtZ?=
 =?utf-8?B?dDZlaElNZWdmUmVyVUc5ZVZPelRqd3NnWW9BR1liaUV5VUdmL3d0eDlYQ3dY?=
 =?utf-8?B?Yjg4MU5ERlBmYU5ES3A5STYxT291UHpwcEozNFJDNC9yblRaZ0p6RGxhb2JN?=
 =?utf-8?B?VCtxbCtrVWhQc2VSRDVVYWNadlBYeTkxNDkxMUo0Wk1pdkJpLzBSMk9hdlRi?=
 =?utf-8?B?QkVHckVBZUhwV2lGeTVsU0NnMnlTQ0xqWjRNY3NJSXhXcWVmWkdUQkFSVEU1?=
 =?utf-8?B?QnNVNzJXUTAzOGdpcjZCOTRXRWR0N1Vtd1Z0eVA5SVRYNWFXb1E0cGVYYmxO?=
 =?utf-8?B?K3ZXYTFjQ01pRXljNjY3ZFk5UUNFR2xCR25vWVhRdHhPeWgwZUJWM05JK2ds?=
 =?utf-8?B?d28xTW54cTlUNGFqdHBtb0pNZEdValhRUHQzUDNCNTU4YUhlVW9vOXBqMnh1?=
 =?utf-8?B?YTFsZ0tFOHBZWml0OEJubnJHaFFaenVIbUZzeEErTGpBTWZBdCtRc0w0dVND?=
 =?utf-8?B?OVJieVhRWFptK0ZUUWh3bFVYTFNYUmZWa01kdjlGU29JejhjUTFmcW1rb2VP?=
 =?utf-8?B?eTBwVVp4KzRnZXdQdFhQRHhqcDR0SFRndHJZZmlpNHdFdzFkU0pNL09zdnhT?=
 =?utf-8?B?RVhzVGpxeGx6TzVzTDhaamo1MDJuaXZvanFhS3A3dmFXUmFkSk0vUmt2Y1VW?=
 =?utf-8?B?Y1FOeFRtZ0VxdVJ2SkRxMlppZExmeUZBd0NiVFdwOFNkMFZJVE1ybUdOUUpP?=
 =?utf-8?B?V2ZmNGpGN0llaTRmNXpqRkxCREQ4U3FaMzJib2k3cVZzaFpqOEVKWjdvOUtn?=
 =?utf-8?B?SkF0RHBHT1BaT0xkU3ZWT3dFU2tNdE1qaldmeVdpNkNlcjFGb1VSSWlEYzds?=
 =?utf-8?B?RjZFWXV2eXRGVnN3dGF1LzRtQzQvWStJZHZyTkRabDBraER0OE05cTBnWm9w?=
 =?utf-8?B?Tlk1dDNTNERvbkJRcjZ5cWN3U3ZORUYwWjc0d2ptRjQwVmw0UFYyNldCRDRx?=
 =?utf-8?Q?ib7eKWlrOUTVR?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a1A3V2p6anVwdVFyTm1tZld5V0dVaEl3RjhJQ2NCbnNyZTlyM0IxRC9RbGVM?=
 =?utf-8?B?OFAvdnEvUUEwYk9HNlNBVGUwT2dEMXRWUGR5ME14L2c0UTQwVTlmVUdtakNT?=
 =?utf-8?B?S3gzSzExSUZBN1kzR29qQXdnem9FUmZHV2FhbWJlL091RzFRMHQ0QzZuZ1Jl?=
 =?utf-8?B?YVpLN3ZuWHFhVjlNaW9ZZmViZzhiZVBvaEZzRmI2YzVDTUw4bUIzRkl4TXVN?=
 =?utf-8?B?ZVNUaUhEOElBQzBZOWNEOFNRVzArMWE0MGc0bFl3MklzN1BMSHFDaGMrMUNp?=
 =?utf-8?B?TjFvYTBQb05ZYXJ3c0g2KzVuSGt0OVFFeHNHUFVuYWUzMlAyeVc3Nkg1WWFQ?=
 =?utf-8?B?dmZhRkhaeGtNaEk5clZDd0ZCTnZYbDFIZVFxMEFDSjZCTHB2TEIxYXMzQTNS?=
 =?utf-8?B?QXZTZ01uRllpbEczUUlzeFJJOEswU2tQOEptcXEvQWZlQmdpK3hRT1dHd3FI?=
 =?utf-8?B?SXgrQVJsc015MG5ZTkNwZnVnN2pneDdsSXcyOXpNQUMyTjRGUUd2OU1NbXVH?=
 =?utf-8?B?RmtvRVIzemZGMjFNUGVYUG51d2l0ZVNVdHY4eFRndjRkY0R4TitMNFp6aFUy?=
 =?utf-8?B?MTNNMC80UXc3N1Fyd2c4N1crbUJabW1TQXkyMjRrOVJTa05IR3lLR3NZMDhz?=
 =?utf-8?B?c1ZSZnFERTZFQjdSOERmV3JEeXV4VUZyN3B2L3FLb01yMzhCWTBxaUtEcHdO?=
 =?utf-8?B?cUVyLzdMZ2p5aHNnUHBMU09LdjIrblVYWlZObUxYOGdjTFZGeCs2Q1Vna1hW?=
 =?utf-8?B?ekhDMFhXYmhiL05uM05vMnRTOFptazdCUUZFQkxVRFhjeW1kSVI0bWpNM0E4?=
 =?utf-8?B?MmsxVGFZM1MwdjRZQUlQNGpjeGxBREJqU3crVnF5R2tVM1JCZEU3UFk5QlJK?=
 =?utf-8?B?ajJxTjBNUlljdHArTTFJaVpRMkdRMTViWHI1SHZCNkVJS1J3U1FpR2tnMHJO?=
 =?utf-8?B?eDQwaHRrWEYwZGV3SjVzTHZrTjhQZ3ZGTW9VaTcvb0pqYStTbEVnM3dIZGRu?=
 =?utf-8?B?Z2xkdHIvamJKaXNhWkxCYy84eEtvMDlKdHRrTFdyREU4KzN3S1JJWFB6Sk9v?=
 =?utf-8?B?clRraWhYUE5uTWlKRmNSbzJ4Y05GY0dZZG9EejQ2cFlab2xJOG03WnJPdkla?=
 =?utf-8?B?TTVETG1VNmdsUWNWS0ROSUZoT3dDem8vZlN4WjRIOWlaenhQR1krWDhYaHZM?=
 =?utf-8?B?WW5RcVQrNUtCSWhFczJLY2tmY20yV2owRnVkZGU0UDF3bm1qVDd3ZVZISTZJ?=
 =?utf-8?B?a20xaVYzUGIvNkY3cXEyNWl3dTBRbXJ2end3aWhtdkhOOGp4SWhCNGU1M3Qr?=
 =?utf-8?B?S2tQUnVWbUliUTFwR0E3RUdNYm1EMTZHN1Z6dlhYNUVFb0lCUFpOUEIrMW1N?=
 =?utf-8?B?eHhNaVVtWWZXRHkyWjFCeEpHM0xLQ3FXdjc1cHBZOStsWWNxbFNpZkJEK2p1?=
 =?utf-8?B?VE1nbWZ2WSttNjF2SHhiUThueTdNTFpCWER4Si9XNStxbXZQTzMvMHRlNlhF?=
 =?utf-8?B?NlZUNThUL1VuZGoxU3k4YlBibGh0bGNMUkI3YXp2RnlGUWxPbjhCNW9TSVBC?=
 =?utf-8?B?TndwaHo3RzhwQWdmNUZaNTNwVHFmSUlobzRrSEs1MkVRWXVkKzFOcVJmc3J2?=
 =?utf-8?B?N3RLNVhUdm94amRURDdiQWdxN2h4amxkalJMd2MyRTJZQ29FRjFBeURwTHlx?=
 =?utf-8?B?Q3cwclFYRC9URnQ0UHZzcEpPT2piT3M5QnFJb3lSOEtRTld4U1F6YzVWcGZ5?=
 =?utf-8?B?WHVHNmFzRlZCYXIwdEhlRHYxOGdDMG5zTDNPY1N0VlRCNURkUFBSMEZYajha?=
 =?utf-8?B?QmNjdXdBaEhmNmVVWEk3UlNRQlJGdkZGT3drOUFSeUlhNjhLR1MxNWY4U2ZV?=
 =?utf-8?B?ZDJvTUxGblpheEg3SjZjQ0Q3emxmZjJsbnFxWlBhR3ErcFEyVEtDdUFnMktX?=
 =?utf-8?B?ckZFSC9oTUhQYjNUUTAzYm8xM1dtZ01XMzc1d1pIbVBZMTBDU2J3MCsyU05q?=
 =?utf-8?B?L1NaVmNQMkJHUzY3RkJ6Sy85QkhtZFdkYWl6ZzR2SGgyOG8rb2t3VVNYNnFP?=
 =?utf-8?B?clpmVWJ1OVh2Z1BTTnJyU0FvOUtuQVJ0cDYyZEFJTjIyWTBXWnN5YTNtaFhI?=
 =?utf-8?Q?XydBSj0SXZS4fTxURFbpFT+Se?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b0bfbfb-3264-4a08-b2fa-08dcf868abfd
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2024 22:26:02.5549
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zLN1sAajzc99gOFTuJh+3pnpy4p4KJl8zgcqbfGkGwvIqj9QX8ooO+kgP7D5twBG9zNGsou/WHPtqLNSFOuKRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5903
X-OriginatorOrg: intel.com

PiAgCS8qDQo+ICAJICogVGhpcyBuZWVkcyB0byBmb2xsb3cgdGhlIEZQVSBpbml0aWFsaXp0aW9u
LCBzaW5jZSBFRkkgZGVwZW5kcyBvbiBpdC4NCj4gKwkgKiBJdCBhbHNvIG5lZWRzIHRvIHByZWNl
ZGUgdGhlIENSIHBpbm5pbmcgc2V0dXAsIGJlY2F1c2Ugd2UgbmVlZCB0byBiZQ0KPiArCSAqIGFi
bGUgdG8gdGVtcG9yYXJpbHkgY2xlYXIgdGhlIENSNC5MQVNTIGJpdCBpbiBvcmRlciB0byBleGVj
dXRlIHRoZQ0KPiArCSAqIHNldF92aXJ0dWFsX2FkZHJlc3NfbWFwIGNhbGwsIHdoaWNoIHJlc2lk
ZXMgaW4gbG93ZXIgYWRkcmVzc2VzIGFuZA0KPiArCSAqIHdvdWxkIHRyaXAgTEFTUyBpZiBlbmFi
bGVkLg0KPiAgCSAqLw0KDQpXaHkgYXJlIHRoZSB0ZW1wb3JhcnkgbWFwcGluZ3MgdXNlZCB0byBw
YXRjaCBrZXJuZWwgY29kZSBpbiB0aGUgbG93ZXIgaGFsZg0Kb2YgdGhlIHZpcnR1YWwgYWRkcmVz
cyBzcGFjZT8gVGhlIGNvbW1lbnRzIGluIGZyb250IG9mIHVzZV90ZW1wb3JhcnlfbW0oKQ0Kc2F5
Og0KDQoqIFVzaW5nIGEgdGVtcG9yYXJ5IG1tIGFsbG93cyB0byBzZXQgdGVtcG9yYXJ5IG1hcHBp
bmdzIHRoYXQgYXJlIG5vdCBhY2Nlc3NpYmxlDQogKiBieSBvdGhlciBDUFVzLiBTdWNoIG1hcHBp
bmdzIGFyZSBuZWVkZWQgdG8gcGVyZm9ybSBzZW5zaXRpdmUgbWVtb3J5IHdyaXRlcw0KICogdGhh
dCBvdmVycmlkZSB0aGUga2VybmVsIG1lbW9yeSBwcm90ZWN0aW9ucyAoZS5nLiwgV15YKSwgd2l0
aG91dCBleHBvc2luZyB0aGUNCiAqIHRlbXBvcmFyeSBwYWdlLXRhYmxlIG1hcHBpbmdzIHRoYXQg
YXJlIHJlcXVpcmVkIGZvciB0aGVzZSB3cml0ZSBvcGVyYXRpb25zIHRvDQogKiBvdGhlciBDUFVz
LiBVc2luZyBhIHRlbXBvcmFyeSBtbSBhbHNvIGFsbG93cyB0byBhdm9pZCBUTEIgc2hvb3Rkb3du
cyB3aGVuIHRoZQ0KICogbWFwcGluZyBpcyB0b3JuIGRvd24uDQoNCkJ1dCBjb3VsZG4ndCB3ZSBt
YXAgaW50byB1cHBlciBoYWxmIGFuZCBkbyBzb21lL2FsbCBvZjoNCg0KMSkgVHJ1c3QgdGhhdCB0
aGVyZSBhcmVuJ3Qgc3R1cGlkIGJ1Z3MgdGhhdCBkZXJlZmVyZW5jZSByYW5kb20gcG9pbnRlcnMg
aW50byB0aGUNCnRlbXBvcmFyeSBtYXBwaW5nPw0KMikgTWFrZSBhICJ0aGlzIENQVSBvbmx5IiBt
YXBwaW5nDQozKSBBdm9pZCBwcmVlbXB0aW9uIHdoaWxlIHBhdGNoaW5nIHNvIHRoZXJlIGlzIG5v
IG5lZWQgZm9yIFRMQiBzaG9vdGRvd24NCmJ5IG90aGVyIENQVXMgd2hlbiB0aGUgdGVtcG9yYXJ5
IG1hcHBpbmcgaXMgdG9ybiBkb3duLCBqdXN0IGZsdXNoIGxvY2FsIFRMQi4NCg0KLVRvbnkNCg==

