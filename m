Return-Path: <linux-efi+bounces-3927-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD8CBAE57BA
	for <lists+linux-efi@lfdr.de>; Tue, 24 Jun 2025 01:14:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E39F445887
	for <lists+linux-efi@lfdr.de>; Mon, 23 Jun 2025 23:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4604222A4E4;
	Mon, 23 Jun 2025 23:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jr0VlHMr"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA9B1A314F;
	Mon, 23 Jun 2025 23:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750720450; cv=fail; b=jD6/y+9iWFz8mYoaIHfgw3eb9dL0b7uiCZxWnxI166p5DTrq5UwKElFZXABbsHBt29NTJaIJr6qREjItpUoDe6YTHV/Eb/vTSQ8ZSBFA5+SbbdB76ZVfgqQMj+1HHAdLrHMV8kd4XnNuPYaOI7OjgWD5Cb5Gphm6rjipe5IpsBg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750720450; c=relaxed/simple;
	bh=9MsPVzF5zAkjZB8K1/80METS9CrgMpRTSroeDXx8bqY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HQDT59/+0tt8WnehNuGyj/M2HzBWE3H0cHQtQCf1EDlYj8JpEOxUWEMjPGNPuY0e2SfMYhaq+/5VH3wRHGqJAf+USVNq5CA3Jo851QHWqcJUzNMTnWNGd0dLdzMvv8T8e4cIrY8hnjTXF20xRft6eDWasRXS+rLnLKBMKiQt8pA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jr0VlHMr; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750720449; x=1782256449;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9MsPVzF5zAkjZB8K1/80METS9CrgMpRTSroeDXx8bqY=;
  b=jr0VlHMrbZBEEyVYSUYQ+sf4t3uLqKOfACOwzYVtYQvhZlJEaRT5v84T
   BznBCdZ5LwoWtieP7VVpDliI0fLmODQkBHgKazxhdK3VwE98bKrakVR+L
   sf2uqALFw90cufixLMBnoHeSnOgUc/PMMMFDwhZluswYukRVTYQ9KuSyw
   RujXOUEx6b5nQ8KWT4xdXvviTsSQoszmin6AKxXVndD5JIIpCNnfPyQhD
   fN1nF2ObEwrS0g/lWb7l9pttWcSSgbvhKzn05mwblEsFlfF588KVN5L0P
   d8dS39HqLmVJW64bmw7c1dcj6k/1iBPHOUag1A+USQcR4aWhMJ4E8DTHX
   Q==;
X-CSE-ConnectionGUID: ixAvpp/mQvSytkjI40MZVQ==
X-CSE-MsgGUID: QZsgm5w9RzCZy7N4h5eOqw==
X-IronPort-AV: E=McAfee;i="6800,10657,11473"; a="53036126"
X-IronPort-AV: E=Sophos;i="6.16,260,1744095600"; 
   d="scan'208";a="53036126"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2025 16:13:57 -0700
X-CSE-ConnectionGUID: +tLuj6V5TPijpljIfea3sA==
X-CSE-MsgGUID: N4eZqY7gQOCLf2VKTtgAMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,260,1744095600"; 
   d="scan'208";a="152041873"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2025 16:13:43 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 23 Jun 2025 16:13:36 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 23 Jun 2025 16:13:36 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.40)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 23 Jun 2025 16:13:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kl70RT/xBDd+ssgjG9ryrQU7uKHQ4c9f72QfaK3b5xNwDIAQVpSe9Qyt1B8ONFueukYelgCtzJmjatsjm+nmAQ6ByJeJpodXunMBZJxNiqpmRZ8eL/ua8XNtb2EACu4NNnKfv8crH6oP/QaQUjOAAtkbsKEhenHWP1R5r0ljVI3IVkY1BzEYNKN4wXhyCZVMToa4/YWCMaLyEm1gdO4Tsr1qXENJTKOewRtrY+8xabUiIIC7D9+RvEjudE/Chtnfyv28HPfCBJ4yM6mIGkO+sUlKFQuxBPn9azYtUtYI8d1HK/v5eH9xrN3uOxQkg+2rPCLJCr6/Jt8uu3/SPGq9Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9MsPVzF5zAkjZB8K1/80METS9CrgMpRTSroeDXx8bqY=;
 b=cPMh2/hFZEwnttD/9t1wdFZMehSHWUGxxLR6Glt8UKWSkj7vIQNxSlNhVv449Dqh9JYOYfAyM0MoFXXQroTp9tpMAj6OHELTWU2BCzvpGFqYPWQehuPfSBiIzyFkHNstXwzUObv42J6OQJFcXVS3Z8mWLsb8YSWG3AXbr8SEeVk//JrkTYLlkdc5F4HSk9R/oTOBrnGtNHhPHvdj7F1hcDgrJFdZj3pnj1edbg/1CXvuT3YC3R74idrTr2UuQ0Sd+QpZGXxFynFNbDfRZ2ixMIah46s/zbpJvquaquHxRMS/Ty4ieLzpSkO/0Z6eFVwHz7ZEW7zx6PEd3PV1FSsy1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS7PR11MB6077.namprd11.prod.outlook.com (2603:10b6:8:87::16) by
 IA1PR11MB7869.namprd11.prod.outlook.com (2603:10b6:208:3f6::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8857.28; Mon, 23 Jun 2025 23:13:34 +0000
Received: from DS7PR11MB6077.namprd11.prod.outlook.com
 ([fe80::509c:f906:cc6:2bec]) by DS7PR11MB6077.namprd11.prod.outlook.com
 ([fe80::509c:f906:cc6:2bec%5]) with mapi id 15.20.8857.026; Mon, 23 Jun 2025
 23:13:34 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: "Hansen, Dave" <dave.hansen@intel.com>, "Mehta, Sohil"
	<sohil.mehta@intel.com>, "Kirill A. Shutemov"
	<kirill.shutemov@linux.intel.com>, Dave Hansen <dave.hansen@linux.intel.com>
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
	<linux-efi@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "Yian
 Chen" <yian.chen@intel.com>, Andy Lutomirski <luto@kernel.org>, "Thomas
 Gleixner" <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "Borislav
 Petkov" <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>, "H. Peter Anvin"
	<hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, Ard Biesheuvel
	<ardb@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>, Josh Poimboeuf
	<jpoimboe@kernel.org>, Xiongwei Song <xiongwei.song@windriver.com>, "Li,
 Xin3" <xin3.li@intel.com>, "Mike Rapoport (IBM)" <rppt@kernel.org>, "Brijesh
 Singh" <brijesh.singh@amd.com>, Michael Roth <michael.roth@amd.com>, "Alexey
 Kardashevskiy" <aik@amd.com>, Alexander Shishkin
	<alexander.shishkin@linux.intel.com>
Subject: RE: [PATCHv6 01/16] x86/cpu: Enumerate the LASS feature bits
Thread-Topic: [PATCHv6 01/16] x86/cpu: Enumerate the LASS feature bits
Thread-Index: AQHb4erCSBDI66dtY0W/I0p+M+8Xt7QMWp4AgAACu4CABJQ7QIAABjoAgABr+uA=
Date: Mon, 23 Jun 2025 23:13:34 +0000
Message-ID: <DS7PR11MB607789E9CDFF5C4DC1461015FC79A@DS7PR11MB6077.namprd11.prod.outlook.com>
References: <20250620135325.3300848-1-kirill.shutemov@linux.intel.com>
 <20250620135325.3300848-2-kirill.shutemov@linux.intel.com>
 <248e272c-79ec-4c11-a3a8-dff1de2147c0@intel.com>
 <adaf2d81-75b5-4f02-99ea-03ea0f1a5a96@intel.com>
 <SJ1PR11MB6083AE2EF85FB5D2FE39D4F0FC79A@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <8f0913d7-9e77-41e0-91e2-17ca2454b296@intel.com>
In-Reply-To: <8f0913d7-9e77-41e0-91e2-17ca2454b296@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR11MB6077:EE_|IA1PR11MB7869:EE_
x-ms-office365-filtering-correlation-id: b2641d08-a2e5-4665-e7b4-08ddb2ab93c6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?MXRkZnBQbnhySTE4eUxrb24vNU5FeWYvNkIxcDg5K3pwNmZiWGhoc2ZjdnMr?=
 =?utf-8?B?T05BZlhGUGx6V2hKRFpJbGs4WTRWc09DS2Z1RzJsRjdOZzZvcDdpVHNCd3ov?=
 =?utf-8?B?Ty9IUjBBWE41L2hwV0xEVUJCK1g0d29Idy9XUjZ0ZXEvQkRkQk8rbkw0Z0ll?=
 =?utf-8?B?cXpPS3R0c0N5aFpPK1ByWlRpWDU3L0kvRE5iTjQ3aGQrMXJFUGwwNklUcE9F?=
 =?utf-8?B?Q0F5UHp5akxkMXNKc01icHQ5WWVnOVZRaitPQ0pvbUgxb0laaGRqYzkrZG1q?=
 =?utf-8?B?REV2MTE0THNGNVBIRnAybU1YOGRMN0xqU3BzVURtbFBYNDlraXJtS3lIV2Rm?=
 =?utf-8?B?dWxZWW9tSmZsdys4OGZwMnUzNVlZYThCd3NmajFZQUpQeUFTSTVMTFNLcXVr?=
 =?utf-8?B?U202UTNSdWk4NThOQVVwYm41K3BqdE12WXNvNTEwSkpzNithNmdXMUh2Rjdv?=
 =?utf-8?B?djVQaDY4MndKS1hjckdlNWRXRmVMazlnREVnNW5pdTlBa1BnR1ptMi96WUlQ?=
 =?utf-8?B?RjBHNWhPMGtXWUZGVEpVWkVUN3hlcVRoMy8vWDdWS2xvVFJaUktCTkhlbmhv?=
 =?utf-8?B?SWlpRjhWOUEyVGdlSENMczhRVm9IQ05sTXV4T0hKWmV2ZVpCU293SHQrUTFm?=
 =?utf-8?B?RVlCS2gzOWZkVzJWYTJFdnVZR21Ta2FFZktLQzBybGhuN1l1dHpFdm9zNHdS?=
 =?utf-8?B?TlpiMXdmS1ZsS00xZDNydmtuV3hMYWtYVStycG14UXBzUXdjMUdabGlHK2o4?=
 =?utf-8?B?azd4T01uN2Y4V2xqUjFlSGdnaWY5aXZrR3ZFMDk2TjEwNm5sdmFjSUpocFdK?=
 =?utf-8?B?SzZWZmIwV3cvV3NxdjMrQVFidEhPSE9SdllkdVRhemNWN3VibE1veCs4Zyth?=
 =?utf-8?B?cXFxbEg4amNGcW1sbndOVWJuWW5DSzM3ajl6Ni9MMVRtNFkrNXlCSFVBU1hW?=
 =?utf-8?B?VGxpN21GVlU5UytDK01FQnJFV0hRMlZ3R0R4L1BhSE53bWRNTlNzYWVTRW92?=
 =?utf-8?B?M3ZZWEY0eUt6bFdNanRGR0svV1R3OWRxdzZGN2xVMkgraGZjcTdEbWwyUDk5?=
 =?utf-8?B?SzFidTcxR21ZU0hBQUxzTW0ySXA3eFQ2eEVlNmlmaGxIZ0dkeUd4T0JJQkVN?=
 =?utf-8?B?SFJwM1Znb2dKbVVQdjZ1LzJmczRpaDJ4WkJPd1Bia2VjYjBlbnoybk16M25U?=
 =?utf-8?B?WGZPTjMzOENLcndma2JXZE1xeitJUTBPdG9KamIzamJXZ2tBaDQ2MnFMZmpJ?=
 =?utf-8?B?SU80VUdjRTVWdDRMekNPUVRsWUlFMFNWNHlDRXI0OFkyS0tuL1dDb1ByL3c2?=
 =?utf-8?B?bS8vOXVMcDI3Wk8ydW5tTEtrb1VweGlnd0tia2RpaUVRbUc0RUV6MkJ3WXJG?=
 =?utf-8?B?YUJNL2szaTRlVi9ObzdVYnBuTkNzTjMvdlFma1VGOUNNbC83S0NhNXE5c1R3?=
 =?utf-8?B?Z1hwdE9JSWV4QWlxdFJFd1NYUHJUSnZMcUhxZmJaU1FxZERyVXVxVmtXL0g5?=
 =?utf-8?B?K2ZlWnRXdUpLQ081SkRxeStuMFU1QU14UE4xZVNtUmVINEtBczJWWEw2WFFo?=
 =?utf-8?B?NTBnZ0h2cGtpSkpON2JNdGVUOXorY0VxU1MvNG1DaUxoaGo3RlJaZmdFMzl5?=
 =?utf-8?B?eGkvK2l0VFlLS2xGa1hrTkV1UHRZUUZOMXFZN0lYQ0I3K2dMOHZUN0NBZisy?=
 =?utf-8?B?cmljaXVkWHpDQXQ4UmNZS2dzeWIvK0d5NHNZc1diQ0NnQVZTMmJtWmdYV28y?=
 =?utf-8?B?UGdJRWtPQVBCc2JSa1R2MUlOTEt6MnJqY2JvaUZrM2t4dStzekFyem8zSWRN?=
 =?utf-8?B?ejVzbnZDRXdXcnp6TGoyRGpmV25RN2hkcHBiRkF3VTY1V3NsWFpNY05WaXZj?=
 =?utf-8?B?M083eHNZRzQwakdPNENHY0NiY1YyK0FuS2gwTTNFVVRDcXhmZTdUdWE5bXZI?=
 =?utf-8?B?eldSVjdOcGF5NEwwNVExZTdyMmVJcVlPMUtmRHN2d0VKOGtnOU1OQnJvb3Av?=
 =?utf-8?Q?TYvqUeM0rViAUKviL7Ey6+57KSc7vs=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB6077.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UDJxYlZUQUk1SHl5UEFCUUl1Q25JK2JFQWp2RkNSRUE3WTlzYkswK1RMYXAx?=
 =?utf-8?B?RW5lZ3lGWVhYQkZHUVJBTXZHNU85T3Y0V1RNNi9tbUNVU3FHaEZJV09BV2wx?=
 =?utf-8?B?QktGWmgxdHVOVUlCbnNLVGIyaEsxaDg4MG1jNFpKNzNBSDA2ejZ1d1kweVpm?=
 =?utf-8?B?UU0wZGlGTm9wZDJjL2NJMStCa3NTK3N1OW1rOE11RmhOREFGM0NXd0FTdXdj?=
 =?utf-8?B?NDliQm04WkhJWG5kWFRqM3pPaURHaHJoMURpdTFlc1hkaEdod3QrUk4xUjU5?=
 =?utf-8?B?Tm9rUTBqRHo1cDJVc0NSOENpTkxCNlRWR2cra2F1NlIwZXhaWnRiK1d3cG1S?=
 =?utf-8?B?aElIRHdaQzZORU1qM3E3V2F3VURCYkVZd3V1Tk5RUHhUVXhLQXZkL3NxbCs4?=
 =?utf-8?B?QU4vNFJOWUpGZXFFTGhWSEp4d05xSG5QeFZtd1hUU2pLVlp0ejRtSk1naUdG?=
 =?utf-8?B?VzZrc09IV2xiL1BVUmYzYStjS1JKZjNhV29HTlhKc25tSG5Jb3JoUGpCcmdI?=
 =?utf-8?B?c2ttamtZTHh3Vm9KMEQ3cGQrTm1rS3Z1bGg4aWorcTZKc2UzbXhSYnlLUi93?=
 =?utf-8?B?RlQ1ZGNiWC8yTDY2enoxVVRsdnNyNC9WTlF6ZURic215YXg0TWxrZVE3bEtF?=
 =?utf-8?B?cHcrVGRVU2lHak1DdEhVdUJvZXRQTVBTeVZxZDJNRVZ4TGVoM3NuaUNpa2tI?=
 =?utf-8?B?UUJKWDYzV3ZBL2xqRjVRSldaMmdrWWRjRERJTTMwSlpUeS9mTWh4RlRQUjZ6?=
 =?utf-8?B?V1Qya0E2STk3MUpRa0RnVXZqM096NG0wRFMwQW5pSWNmQ3BYYnBHUkp0amIv?=
 =?utf-8?B?ZzBHUWRBZXh2WUV6cUNnQ0t6eWtBb0tMQmJoQnkrM25id1NxbGo4eDZWRUtR?=
 =?utf-8?B?QjMrWm83b0FHVm55TDU2Q1hoeHRuVHdvZ1d2Rk52SHVzU1E3LzBtRFFSeWd2?=
 =?utf-8?B?OWJQdHVxMGt1V3ZKNlRQdi9rNVV3S3ZDQnRHZmt6TDRhZ3ltdGhyVU1LSDFL?=
 =?utf-8?B?R3dKV1BmU250bzhpK2p4M0lvcExtcG13enlQalc4bXl4QjdtWUFQWDFScTBK?=
 =?utf-8?B?UVRKM2NUdmNyMnQ2c2s0a0kxcnB1RzVjWFFxL2prNWpraDlaQWRESklwdk5x?=
 =?utf-8?B?TXgvZ21xSTRXbk5PdVo4TUY1QlBHNHJyYUFRNGNNM0RLU295SXo1ZlFncUll?=
 =?utf-8?B?UDlYUU9IeENObHJWY29GRC9yNEUzS0JubE05QWNEclRuTHVRd3Z0ZmxvRTBL?=
 =?utf-8?B?a3FnVjc5NUZ5ZjM5RXo4SXZ3REpDV2FyRkpVcU5TMlZ2NDFYYmJEUm5mRHRs?=
 =?utf-8?B?QW5BZzlkeWhXM1hDeGV3RWlaSnV1VHRKeCtYdXF3YndrNGFIUVNrL2VJSmNM?=
 =?utf-8?B?eWlyVFI3UFU4bDBWelhnWEhqdjJldjRXRDV0OGFQUUdmUUYvd0ZkcFJ3eExv?=
 =?utf-8?B?Y2wxZFdZak1LRzhjdjF0QXkzdGpvS0tRYnNzams1NHRpU3F1RGdqM1dRVU8y?=
 =?utf-8?B?SFkyQVFoSVhOcnVHdXhzVC9ZWFJjWmVzSHJhbkJzbDgrdHlDM0JzYmpiMnVK?=
 =?utf-8?B?M284aFhUcGNHaVpvamRKdXRldDlYZ3ZiOUJBZERvMUlhUVpxQlRMay8ySnAr?=
 =?utf-8?B?dXMzMFFDWnZOVjd6eTM3Y2ZZUWU5WTBxc2V3YzNMV2VsYjZkbnlwNER6WGtl?=
 =?utf-8?B?cW5FcGlrY2s1QXYzOXJML3YzRU9Rc0YrSnVJL01ZQ1k4RkFNdE41cU5hUmVz?=
 =?utf-8?B?SVY0VVNxOGhDL2ZvR3p2K3BDdVBYcjIxMmtQN0E5cFpLbCtIQXJlVy9zR0VH?=
 =?utf-8?B?b1Z0Zld4czdJWXhxUFk0Q1ptUXZvQS83UHl4QnQ0bVR6UTJCYVNHWnUvR2or?=
 =?utf-8?B?STdkVVJ2ZUJRNytqNE1UN1R1Z2FQZFdVenZTczZaOTlWU3g4WW1ickZOUUh0?=
 =?utf-8?B?cjhMczRjVGxXT1NLMXZWRDZPcjlUOTdMQTlPeFdSdVJZeGhPOHRaRFNpbWN5?=
 =?utf-8?B?UGxXQVJKeW91dVAvMWFnNFlRWmc0QnVYYXZyaUFoUE5ZZGx4SGViaW9lKzRr?=
 =?utf-8?B?M1NXeDh2Tm1oQllhQmlIcGExVEcvamdZZnNYcVVZbmlFdXZOTmdpenUzVzFL?=
 =?utf-8?Q?UI9YowMbRIe2NY2iCCJY+ZoLv?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB6077.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2641d08-a2e5-4665-e7b4-08ddb2ab93c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2025 23:13:34.4550
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Yb+q6Of6wCj+Nul21bROw04jmmGs06w3xG9gvOVHQGdvYrtMqViSSIX128AA0yTsY+z2e/vhnjTlBKnm0OdSpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7869
X-OriginatorOrg: intel.com

PiA+PiBMb2dpY2FsbHkgdGhlcmUgYXJlIHR3byBjb21wbGV0ZWx5IGRpZmZlcmVudCB0aGluZ3M6
DQo+ID4+DQo+ID4+ICAgICAgIDEuIFRvdWNoaW5nIHVzZXJzcGFjZQ0KPiA+PiAgICAgICAyLiBU
b3VjaGluZyB0aGUgbG93ZXIgaGFsZiBvZiB0aGUgYWRkcmVzcyBzcGFjZQ0KPiA+Pg0KPiA+PiBJ
ZiBpdCdzIG9ubHkgdXNlcnNwYWNlIGluIHRoZSBsb3dlciBoYWxmIG9mIHRoZSBhZGRyZXNzIHNw
YWNlLCB0aGVuDQo+ID4+IHRoZXJlJ3Mgbm8gY29udHJvdmVyc3kuIEJ1dCB0aGUgcHJvYmxlbSBv
YnZpb3VzbHkgb2NjdXJzIHdoZW4geW91IHdhbnQNCj4gPj4gdG8gdG91Y2gga2VybmVsIG1hcHBp
bmdzIGluIHRoZSBsb3dlciBoYWxmIG9mIHRoZSBhZGRyZXNzIHNwYWNlLg0KPiA+DQo+ID4gV2h5
IGRvZXMgdGhlIGtlcm5lbCBjcmVhdGUgdGhlIG1hcHBpbmdzIHRvIHBva2Uga2VybmVsIHRleHQN
Cj4gPiBmb3IgQUxURVJOQVRJVkUgcGF0Y2hpbmcgaW4gdGhlIGxvd2VyIGhhbGYgb2YgdGhlIGFk
ZHJlc3Mgc3BhY2U/DQo+ID4NCj4gPiBJbnN0ZWFkIG9mIHNwZWNpYWwgIndlIHJlYWxseSB0byB3
YW50IHRvIGFjY2VzcyB0aGUgbG93ZXIgYWRkcmVzc2VzIg0KPiA+IGNvZGUsIHdvdWxkbid0IGl0
IGJlIGVhc2llciB0byBtYXAgdGhlICJwb2tlIiB2aXJ0dWFsIGFkZHJlc3NlcyBpbiBub3JtYWwN
Cj4gPiBrZXJuZWwgdXBwZXItaGFsZiBzcGFjZT8NCj4NCj4gVGhlIHVwcGVyIGhhbGYgb2YgdGhl
IGFkZHJlc3Mgc3BhY2UgaXMgc2hhcmVkIGtlcm5lbCBzcGFjZSwgcmlnaHQ/IEV2ZXJ5DQo+IFBH
RCBoYXMgaWRlbnRpY2FsIGNvbnRlbnRzIGluIHRoZSB1cHBlciBoYWxmLiBTbyBpZiB3ZSBjcmVh
dGUgYSBtYXBwaW5nDQo+IHRoZXJlLGV2ZXJ5Ym9keSBnZXQgYWNjZXNzIHRvIGl0LiBFdmVyeSBt
bSBjYW4gYWNjZXNzIGl0LiBFdmVyeQ0KPiAqcHJvY2VzcyogY2FuIGFjY2VzcyBpdC4gSXQgc3Rp
bGwgaGFzIGtlcm5lbCBwZXJtaXNzaW9ucyBvZiBjb3Vyc2UsIGJ1dA0KPiBpdCdzIHN0aWxsIGEg
cGxhY2UgdGhhdCBldmVyeWJvZHkgY2FuIGdldCBhdC4NCj4NCj4gVGhlIGxvd2VyIGhhbGYgaXMg
Kk9OTFkqIGFjY2Vzc2libGUgdG8gdGhlIGxvY2FsIG1tLiBJbiB0aGlzIGNhc2UsIG9ubHkNCj4g
dGhlIHRleHQgcG9raW5nIG1tLiBJdCdzIGEgbmF0dXJhbCwgc2FmZSwgcGxhY2UgdG8gY3JlYXRl
IGEgbWFwcGluZyB0aGF0DQo+IHlvdSB3YW50IHRvIGJlIHByaXZhdGUgYW5kIG5vdCBiZSBleHBs
b2l0ZWQuDQo+DQo+IFNvLCBkb2luZyBpdCBpbiB0aGUgdXBwZXIgaGFsZiBpcyByaXNreS4NCj4N
Cj4gSWYgd2UgKndhbnRlZCosIHdlIGNvdWxkIGhhdmUgYSBub24tc2hhcmVkIFBHRCBlbnRyeSBp
biB0aGUgdG9wIGhhbGYgb2YNCj4gdGhlIGFkZHJlc3Mgc3BhY2UuIEJ1dCB3ZSdkIG5lZWQgdG8g
cmVzZXJ2ZSBpdHMgYWRkcmVzcyBzcGFjZSBhbmQgYWxsDQo+IHRoYXQgamF6ei4gSSdtIG5vdCBz
dXJlIGl0J3MgYW55IGJldHRlciB0aGFuIGp1c3QgZGlzYWJsaW5nIExBU1MNCj4gZW5mb3JjZW1l
bnQgZm9yIGEgbW9tZW50Lg0KDQpNYXliZSBpdOKAmXMgYSB0aGluZyB0byBwdXQgb24gdGhlIGxp
c3QgZm9yICJ3aGVuIHg4NiBkcm9wcyBzdXBwb3J0IGZvciAzMi1iaXQiLg0KDQpSZXNlcnZpbmcg
YSBQR0QgZW50cnkgaW4gdGhlIGtlcm5lbCBoYWxmIG9mIHRoZSBhZGRyZXNzIHNwYWNlIGZvcg0K
bG9jYWwgQ1BVIHVzZSB3b3VsZCBiZSBwcmFjdGljYWwgdGhlbi4gUGVyaGFwcyB0aGVyZSBtaWdo
dCBiZSBvdGhlcg0KdXNlcyB0b28uDQoNCi1Ub255DQo=

