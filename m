Return-Path: <linux-efi+bounces-4091-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F079AF62F9
	for <lists+linux-efi@lfdr.de>; Wed,  2 Jul 2025 22:05:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C2671BC7FA7
	for <lists+linux-efi@lfdr.de>; Wed,  2 Jul 2025 20:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FCC52BE64C;
	Wed,  2 Jul 2025 20:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hn8Uvo1e"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A372343B6;
	Wed,  2 Jul 2025 20:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751486728; cv=fail; b=lnCv1I/BqSQWAPLQmxXyS94x+0yAgKFJ0YqPPt0K46JDf+uMSGz1A6QpYSTnApFL6DhGflaMz0YGLg1ZIAjFLp6sXRy6uv4eIDpAfM1YnriBC2X1opHlmCNTexdqWP+GmUT3LpDxQKjewUCLVLySYp5PPieF7HVcsZNMHuYUsgU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751486728; c=relaxed/simple;
	bh=03YiNOathIkBZpVIniQ8xHupdRG1r/Z3zxMCeeDZy1g=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DqWkzTy/Kc39NghbUVvTLJe1lVI0Cl8JjoUrXGGTWM5AdGwCI4snycv3afAZB1lIMuxlX0AJpi/b5oYgLIX/B1btB9ROCpA9ckBUxI2O31RADDv5+siiejnC+2rhPXR7TKHjn1kRwVChzU4XuucBfDYAPnuF8ZaFMFCCBIZrQQ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hn8Uvo1e; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751486726; x=1783022726;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=03YiNOathIkBZpVIniQ8xHupdRG1r/Z3zxMCeeDZy1g=;
  b=hn8Uvo1e8VzSnJjhTO9V5JMyQgH3vB5dE0JO9zE1xuJYKHFMUtQ3L2FG
   BiwDcjHovP5nck6n3Q3erBnvn4CCfbSbInacAf410wT+p/1wyxg7Prj9y
   np2+xZr1Y+hqBJUY1yOSM6AeLrGWocAtRKzuOxAut9rNp1yIbPqFr0mDy
   QLOueeUWqDW/wz5eknxkSZDKqaesmj65RWBgCQbwBALMen5oybQhK+bLP
   QcWyh7S6aFzA3BudkLTPBM+GM7s2PEoWGpOpCV1iR3sl3tGyQGQ42QhW1
   7F9BNsAp16VyWiNCueT847GEuc9FbwaA3iMNtcvBKTU9rTcM9ZOrqS9ZD
   Q==;
X-CSE-ConnectionGUID: y790WIZZQVeYPBBO8m71OQ==
X-CSE-MsgGUID: 4pFEtX7gTx2kcxlMSOWi6w==
X-IronPort-AV: E=McAfee;i="6800,10657,11482"; a="53672968"
X-IronPort-AV: E=Sophos;i="6.16,282,1744095600"; 
   d="scan'208";a="53672968"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2025 13:05:26 -0700
X-CSE-ConnectionGUID: A4l29CjGTJK4MEwVkM4bLA==
X-CSE-MsgGUID: K96nt0M8SbOl+Pc+XLby7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,282,1744095600"; 
   d="scan'208";a="185189885"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2025 13:05:26 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 2 Jul 2025 13:05:25 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 2 Jul 2025 13:05:25 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.70)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 2 Jul 2025 13:05:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KA982Z8qfviq/f3nNS3XnSkwd5IjPhoLU92YPRAbwZYhYcio3ee5lLVJ44cjxB8rwE0qVZQGb6AFFK8eQlo7w+oIMWHUFscHRWAmjJPpD6FVKj/Cl/gFI2OWWiRAlLYu5eJdZd3h1+/ERGL05mCC39M0jlYNS09kc7s1+OFcOo+TBFurbPPuFi9Ykw6zFmgiQevKFIURwThTqfWIHvfVIJ1pAWjTgf36maS+jHKmDv1hRZGseB2l2cqzCYdFevtyw/cF06xnvAwSXBPQfdtg83zQGp+hGiP/yP/lWXmssD0xuSp8elOWrWngA77xnk80I7w+1tw3kFGo2ofBoqfOYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dMD2GkjlH70JFMEP6I2cMbltULXWzwEtVI7lTvDtq7M=;
 b=c4C2Vqa4Ce8VTzL408kebLkiWcRvRvPkH/OtfYWaseTYJP+2GRyYQq3PmxReq2QFSc4InrFqZVz0wBdWxCLcXaXUe6eQflHOhYm0YCwp5XAU1S6e03+R1UbPMs/f2wSX2z7jK6uez3dCxbBQncGwMGmzxdbxhmKDDDYFT3RBEEsQhacEvdfnwT4Y6szQSD6492wtB+AwC6+wTacS2UIfocDB0peM0qNCVGHfu4gOpbub3sPzdK7WKCK7FH6H4ldR+0+Fb4CW4o4qzcpB+e1xRFiDIdGl/7jMfnK21N1Mi44DAYWMNhRJwlHBaaXrpzhNXRjHVBziUo3MsXQuMZ4ECw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL0PR11MB3315.namprd11.prod.outlook.com (2603:10b6:208:6c::33)
 by SJ2PR11MB8588.namprd11.prod.outlook.com (2603:10b6:a03:56c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Wed, 2 Jul
 2025 20:05:23 +0000
Received: from BL0PR11MB3315.namprd11.prod.outlook.com
 ([fe80::9c18:1e19:b200:3848]) by BL0PR11MB3315.namprd11.prod.outlook.com
 ([fe80::9c18:1e19:b200:3848%7]) with mapi id 15.20.8901.018; Wed, 2 Jul 2025
 20:05:23 +0000
Message-ID: <bbe9dfb6-88c7-4724-bafd-0524599c9369@intel.com>
Date: Wed, 2 Jul 2025 13:05:17 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv8 14/17] x86/traps: Handle LASS thrown #SS
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
References: <20250701095849.2360685-1-kirill.shutemov@linux.intel.com>
 <20250701095849.2360685-15-kirill.shutemov@linux.intel.com>
 <95dc18fd-73b0-4019-92d2-c0e6aaf22c96@intel.com>
 <mgo3qfjekobe6qflwkpey3p7tzsp3b2mrirama4w2rxyckce7g@3gce3fn5emvu>
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <mgo3qfjekobe6qflwkpey3p7tzsp3b2mrirama4w2rxyckce7g@3gce3fn5emvu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0242.namprd03.prod.outlook.com
 (2603:10b6:303:b4::7) To BL0PR11MB3315.namprd11.prod.outlook.com
 (2603:10b6:208:6c::33)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR11MB3315:EE_|SJ2PR11MB8588:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ee54f04-eb48-43e1-eb40-08ddb9a3c734
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NTRnWC9DNGlHcGp6VXR3RkFXZ29SYUkrM1JtdzFyNWxwOE0wSDZqbjNuZm5G?=
 =?utf-8?B?THZldGd0ajhyUWlzVkxjMkVabUVic0FMN3ZCUG9pSHVmb1lMclhtaFJHdW82?=
 =?utf-8?B?YnFLS2tRcTRodkdIVEYvYkdTWnlsR2FWTFNNWmxoM2VFU2J1dU1SYTJvVnht?=
 =?utf-8?B?eFVIUVByaDA1Rm1YdFZ3TU13bm5XUkErTGcrQ1AxZnVYRUxwMWt0bHcxWVhX?=
 =?utf-8?B?WVlTNUoyYTJzdGJyTVQrM3JLU0grSEoxNjhNR1Rrd3FJM1FNbG1jZitsZisz?=
 =?utf-8?B?RmxuN05ieDdydjI2ZUdHVjA2L09LVkhOKzFZY3VFNWlQVktJT1diL2NLeVNZ?=
 =?utf-8?B?d0d2ZnEvT1JyUzQxQ1A5VDFhRU95d1VjNTJOM0tvOE9HK0ttSEg5VUR1c1VQ?=
 =?utf-8?B?UFdsczVnbmtQSU51dHRrZVJNMlVIbkN5YWNJV3A4cTJOVDBkanFVN3V5ZWE4?=
 =?utf-8?B?SEtvdVU3d2I3WSthTnFoRUx1cW5sMzE0ckR4a3Q3V0N2Qm5YL3RMaFdaQ0E0?=
 =?utf-8?B?Y0ZGVWJ5TUNhbitUclI0enlNQi84UEJWWFZBM2FGL0VBd0dPNG8vM0hrbW0w?=
 =?utf-8?B?SHlnRUNobS9ScTN5NGQ5V0hQTzZ1WXl6QmNveVNJdThCZy9aSlVBVHlQaUhZ?=
 =?utf-8?B?NW90aCthRjVWNU5sTFp4bjRxajZBMTU0bkZORHNKcXk0TDNTbzk3YmR4VzVV?=
 =?utf-8?B?OHgrdEJ5M3lGUHA5cmVNa1VMMXd1d3JiVnFaci8vSFA5NnhEY0NJS2djK1ds?=
 =?utf-8?B?QnRGTzBTV2FXU2NWY0FzTWhnWkorSXpwV1pJd1VtM2kzVWxaM0M3RHhsMFNa?=
 =?utf-8?B?SHI5RzRJRVFFamVlVmtLeEE0dm9nRW44bEdEZldLVS9vRHV4VWJ3d3pzTzda?=
 =?utf-8?B?YVduMzM1bk15ODJFOE1HNGNHVitFdlQ1cUpFWVRvT1loYTd0UFB2ZjRRT2pz?=
 =?utf-8?B?SFlUd1lHb1B6U2JpMTRqTTVhOU0xbURUb29SS2d6QjdzMEtDNmsrUVVhcFZZ?=
 =?utf-8?B?bnpUS3I0VDVQZEFtcGxoN3VscW96ZTF2S3ZKbm0rNFZtbzZsQW80YlA2WnRZ?=
 =?utf-8?B?UVZiOGhkVHdHeVZNWCtKVHR4aEM3UHVJTGVNVTZsc0c0ckdyZndRYnJpUDFN?=
 =?utf-8?B?TWVXRVVNaGFIRWtPcTNWeG9BQW1TbzI0a0h0RUc0ZFdRMWVOK1o2OS9meGlD?=
 =?utf-8?B?Zk1IY1NUbEFNSVFaeERjdWxHZ0o0cXhITHpqbmhUeDV1dnVrc0t5bkxoT1FI?=
 =?utf-8?B?LzQ0RXpuWjJPQUI5ZHRiQys0dG9tWEQxbkx3dDVic3ZMY3FRTk1IeVJwZUw1?=
 =?utf-8?B?TFJWbFJ2ZGJRUkkvczlkeWRTcllLS2ZjVzB5T3Q3MGF4VEszV25sU0dVTXJv?=
 =?utf-8?B?NzFDY1VRK3Rnajh5MExhWUpXS3diODJUY0hIdFA4S3JNY3BEeHY2b2d4R014?=
 =?utf-8?B?NStFVVBYZm9hYzZwdFlxWFZRK2J0Y09XQVgvbnhNaHY5S0NRSUVlVStPakpm?=
 =?utf-8?B?VDZ4eTlaT3VIRjNmVXRRMGJKRVlGK0pvak0yT2UvVnBXNzFUL3NNbXhQcmhw?=
 =?utf-8?B?Z1FGa094RkJ3K0dlTlVhWlAvYXpIeTZhUCsxekNMS1NlK2xJMzA2UWo2dFRG?=
 =?utf-8?B?ODYvT1JHcStaMDVVNDNXc2FGSVNLMEJZN0dHLzMxbElaMEU5WFg1MlRZQ04v?=
 =?utf-8?B?Skl1a2RnanloVUJEeGZ0SU42b2NNOUtCZHlJYmY2MmI0eGxnUXhEUUhvSUxI?=
 =?utf-8?B?ZTZWOS8xd0d1Q29oZVZqSXllczZjbUh2cmlaYjg5N0NHdnVuaExZcWZMQ3hQ?=
 =?utf-8?B?Vy96cmdoM2pROHVZdHFMZ0pueXozSzlFT2JKd2lKNzhmQTRPcGtsRTB5emls?=
 =?utf-8?B?TDhPWStGL3krQ2FPL1FpQUx4VHhKR3ZuNlVpSXdhOFZ3K3lkSktWMmo2M3hi?=
 =?utf-8?Q?A7TFxmE9fPw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB3315.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SDE1eHNUTlBFdjBQV2JUNFJHaDVDZzFEempRWDdVM2Npdkc4aDJGa2NHa0RJ?=
 =?utf-8?B?SktWK0d3cHYzUEkyY09ZbkVsSHM5ZS9iaFRWejFiS1Y1SkdBMTBDemxRdis4?=
 =?utf-8?B?cm9tRjlXSGpXUi9uR3hlUmpwQ2RVTTB0cCtBdFU3cHp2Umk2cWJpQnpLSjdF?=
 =?utf-8?B?NG1JQlJaMEZnOGNudi9lOEpneUFIUlppNWNETXViN2hkWkI1cDNzWE45UlZk?=
 =?utf-8?B?UWRRWWQzUjNRcWpqb21Ia2lvYVRYL3Avc2ZjOGNnNXh1WFUva1Q1b1dlTkc1?=
 =?utf-8?B?Q3pkNFpCT1dYUEZ6cTNUM1BCRWdJVEN2cEx6ZDhIM3hobDVHTi94WDFPRnQy?=
 =?utf-8?B?SEw5bGJXdUJIWXlCZlUxcVAxTWZiYjhPY2xvYTF5MlZhdlUydm82RzhuS1pD?=
 =?utf-8?B?UC9XYzhvUmlQcm5iMGtWeXZoalZpai9LVEs5cmkwUkduOVVhNHJhMCs4bTRW?=
 =?utf-8?B?NFF3RGpsK3ovNTdYd201TE80aUF5OEhKL1JwNkd4dEtxV05oanoxNDBmVWts?=
 =?utf-8?B?Y3U2N1BkMElWNFh2SkxLRG5jQWsvZmJ3MkpoaUxiZTREVi8xdkVKOWFnQlRa?=
 =?utf-8?B?SnFkSFRvb0lDSGwxdTVDc2syVUJ2azIxYnFHRWg5WHM0YjVqRkd3dlRJYXZi?=
 =?utf-8?B?dUc4ODZPSnNCK3NSUUdSenUwdWUzbG1uSlJmWG9sSW9lT2RnR3hIc0IxTjJH?=
 =?utf-8?B?UWJUUkFhd1BvK29wNnRndFYvd3JaQyswYnY0U3diY2RSL1UrQWpkYVNKUGNE?=
 =?utf-8?B?SE5KWE5YRWFjTWpCeUlYUXMrZ0NmK2RLNmdpcHlTSXBLSDFyd0hRRTZiS1Qx?=
 =?utf-8?B?QWs1Y2FlazZhS242THdwbkhKMHM2KzhkWTcxY2VQMldvbmQzM0pmdlFGMGRu?=
 =?utf-8?B?elU4K1JiTy9OSFk2VGpJRW9RRFFxTlZHRm9YcHN3cFlScm9kenlPdy9TRkxo?=
 =?utf-8?B?WXNndDdEY1FBUlhwQTA2THFDQk5oMmRBY3k5V1Q3VWd3Y1p1QWlPQUMwY1Fr?=
 =?utf-8?B?Z1FWbTJBSkQ0Q1p2ZnlVekd0TnRNN1J1eGowOTZqdXQ4QWZaL1dpK2gydFE3?=
 =?utf-8?B?dUo2TGNlSnJDUkNvQW1leGJEZGtucDZ0QjJaR2NRanVIYVljNGQxZXZIRi94?=
 =?utf-8?B?M2MySThzclBhTksrSUJvd0JWa3o5NTErM21YZU94T0F5WXhCb3RZMmpPVlpE?=
 =?utf-8?B?MXF0VDFKSU5qV2FzQnpLblp0dWZSd1lKRzcrQmRQbFNjRkZ3SUFOSkZURWxJ?=
 =?utf-8?B?SnpNZ1locU8rR0JJQ1BTMnZWSEhmbktmbzQ1NHVFYzJjWHIwV3p3TUdwZUpD?=
 =?utf-8?B?L2lQL05xVGFqNU8vNkIyQkNmMGJQbEpKSFNEMGJSTnE5K3I5bGhuQ1F2bkZS?=
 =?utf-8?B?TnNHc0cwb0xRZUJEQ0NYRUIxaU1zQ2FCMzhxNEVhaGJrTkR4TEI2S2k1RTVi?=
 =?utf-8?B?UXZRVDVPY1I2SXJsSEh5d1ZrY3UyMTJUd3pUK0xac3NpWkYzYXlwNmx1Nzhs?=
 =?utf-8?B?UGZJT1BWTDZOWVMwcVFLS0ZWaUlMN3E0WWR2T21OQ1o0U2dHYnlWZjFiYVJr?=
 =?utf-8?B?REJnR1J2SGVyRFBzQnZFRm5OQU5xcUlYdGx5bzZyUGhYSHJiYUg0RWxZdG8v?=
 =?utf-8?B?eVJBeXhXWGZvLzJrWkNjcThXOHROWWVRb1dUVi9mOVNxa2pqWTIwRGZyZTJh?=
 =?utf-8?B?N1JmZW9ETFQxanJFYVNIdEExVUJpVmtlaWZOSHVyUldYOGhicUNmTEU0ZGp3?=
 =?utf-8?B?ekJabERYWEV0SHNSY0xobzBydW0vc2lRM0JmbDBMdjRPMlB0KzBwejBTVGpr?=
 =?utf-8?B?ZnNKbGJMUDhoWGptaUlJQXdMZCtQNVRNRkdNQTZ2RzBVYWgyOEU2ZTB6YlRm?=
 =?utf-8?B?Wm1aNGNZOUtLYTBmZXpNN0ljZm9BMk9HSWhaSUtuSWNQV1BISXgveHFyWHd2?=
 =?utf-8?B?UUJKN2VRK3Y2YW9TWWxqcC9JWm5ZNk9uRXBNSnJMK2tndVdTbWJ3SzlBenhv?=
 =?utf-8?B?cTNadzEyRkpqQUpVZEdVQk9YTHh6Sm8vdDRjK1U3cWtuZUhZVnVhUkVOb3VG?=
 =?utf-8?B?d0hMMVhSbVpQN0wrYmE3MDUzejlLMFVvalRYQ3MxeHdlRVZtV1hFcWwzcEJi?=
 =?utf-8?Q?fo8PYa8zvNaUEPCBzR558fkPa?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ee54f04-eb48-43e1-eb40-08ddb9a3c734
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB3315.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 20:05:23.0659
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2QKvcfTrQTCCKi2Rqg4KnvbWpW4gOrHET7M8tJiAXSNQCL70dwKBwOJZFQzM6rmo1kb3b22uCAupaa3Dn9wJJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8588
X-OriginatorOrg: intel.com

On 7/2/2025 6:27 AM, Kirill A. Shutemov wrote:

>>
>> Maybe I've misunderstood something:
>>
>> Is the underlying assumption here that #SS were previously only
>> generated by userspace, but now they can also be generated by the
>> kernel? And we want the kernel generated #SS to behave the same as the #GP?
> 
> It can be generated by both kernel and userspace if RSP gets corrupted.
> 
> So far, do_error_trap() did the trick, handling what has to be handled.
> LASS requires a bit more, though.
> 
Thank you for the information! The discussion in the other thread helped
clarify my confusion about the new FRED specific fixup outside the LASS
check.

IIUC, for kernel generated #SS, the prior code in do_error_trap()
would've done a few things such as notify_die() and
cond_local_irq_enable() before calling die().

The new code now directly calls die_addr(). Are we changing the behavior
for legacy kernel #SS? Also, why don't we need those calls for the new
LASS #SS?

I apologize if the questions seem too naive. I am finding the exception
handling code a bit convoluted to understand. In general, I would
suggest adding some code comments at least for the new code to help
ignorant folks like me looking at this in the future.

