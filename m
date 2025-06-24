Return-Path: <linux-efi+bounces-3929-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16EF5AE5852
	for <lists+linux-efi@lfdr.de>; Tue, 24 Jun 2025 02:11:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 985394C0C88
	for <lists+linux-efi@lfdr.de>; Tue, 24 Jun 2025 00:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73841BA49;
	Tue, 24 Jun 2025 00:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="as2KDGE8"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26182114;
	Tue, 24 Jun 2025 00:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750723873; cv=fail; b=TTDXxgxPmTlcgIsetOa3ay10YdGMxn74fcd0KGnrC4FEwMkto44QoNlDMIXXJRT6M6hgl6ydDhikMNi89W5InDuV8z6Fvya2LP1D90GtJ2HcUcYTrjPzK5h+OQcWewtIMNaRu3h7fkPSue/js1ILRjhUIEgjNO7zaz1orhybjhs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750723873; c=relaxed/simple;
	bh=EpUzO+l0x8FkcySYQvqQQugwSKbaOEX0YKGaZe77sK0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sgPV272QNs7OxsNgzstvxzwkhC8ABpg6IzkuhoFsRIMPHqQF1wXgljReP1aHInZWp7vVFkUHeq9wtg3ZKckBMyGQ3zCDz4qMRHnVRziv2RlHGV5THVGJsLrg/Au7Ev1GFj0uQQawdl93oZKPzonmlobrDNaXRb24tD6slB+6jvM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=as2KDGE8; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750723871; x=1782259871;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=EpUzO+l0x8FkcySYQvqQQugwSKbaOEX0YKGaZe77sK0=;
  b=as2KDGE8T3yp86GnUj6UuWiZXxYpfxE1b/hprMUIeR9iWAZSHcE4Hkwp
   USBngs3YBEfN9I+v08eP68R7zPSJsE0P6S4OiXhGwon7tu3v/AofuZz/C
   THDDGhW0PG9bIlDiG5odSxdRz6Uu8SYpqUzt3//j7A0+3IFEBTIRIQ+Nt
   U9ytRyN9pXpKJTjr+r+Ddzna5mBRKOEcd6vzABM7MM/XBDltEYZrrfP/P
   sD2wK9GfED5lz9zABmLsG7hjKoXQ6tjiOp/wZwt9tQuJIx5fkZePeBODy
   EpEYaeQDv62ndXg0LvrUzDi1U7Oa3PVKMI05MPcAvP5vwh7qmV49B4jsa
   A==;
X-CSE-ConnectionGUID: SsZpNWhHTJWb91KsryntDg==
X-CSE-MsgGUID: 5ZX9gqWjREqxqw1duE/LJQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11473"; a="53080604"
X-IronPort-AV: E=Sophos;i="6.16,260,1744095600"; 
   d="scan'208";a="53080604"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2025 17:11:10 -0700
X-CSE-ConnectionGUID: SkNifO7xRJeAgrfzZ9W4Ig==
X-CSE-MsgGUID: 7z1JnHC8RMCjPazzOuARDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,260,1744095600"; 
   d="scan'208";a="152057249"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2025 17:11:08 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 23 Jun 2025 17:11:07 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 23 Jun 2025 17:11:07 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.74) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 23 Jun 2025 17:11:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C8qxdXcHfLRUgz1XAl9raabqrMqIwBEvC3vL9Mm6MOTqdOsfFUx+zfGnmkbBHsgFGob1m+LkDf0MXtzAzs03+BI+Ydta21WFgyRC6hkmymMVucsz33Rw5HHzxZy7KgKy+d3k9CrOxByq0gQ+bPEZcHdsiPPHAC/4I4R67qlsB6+0YabD5/W5nPbfd6kncOQYEfIgKQJ2ewqrOSTC1Fb0gUvgpY3uigFFV4sxHd9/os7AWQKP/w7+ShbJ66r6U+dsLQf20bGy/OEn0CbNUOgAkQMxDVHAJM03t44d3Dtcejv7ZJ0eAuCA6DtXVXO09EarBewqFlewizzErxlT9K2dDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EpUzO+l0x8FkcySYQvqQQugwSKbaOEX0YKGaZe77sK0=;
 b=wVSK69WasD6i6SC6zm+tFPMDMaK20JnxZE9c+wYjH6/1nhU+6t/a94TheEtVcSrvq8Hlz7AFYafzLpl6GSOdVofmOledfreRRnbaRFS8PkCjPoEFw0pVpX34e6l5xU8UZQ/Mx/KAcfly+bvQnjdVrv0k4dqANp3h7DDN9WWYm7N3cgmy+5/t8ycgKToKZTUhIpLhlOWGTnTu6RPNd5pluWAIR/mc4sCjZO4TVdrKuRj6hzcKpQ+h0b99J87qdZOGokQf3Ty5RykFd/LrWqVUx9PtHpuU/tDuxdlUugDwIDz2rMQqMseqXyeuf5lx+ivbHxemD1sW96bTfbtqF0Ls+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by SJ0PR11MB4830.namprd11.prod.outlook.com (2603:10b6:a03:2d7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.29; Tue, 24 Jun
 2025 00:10:51 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361%5]) with mapi id 15.20.8857.026; Tue, 24 Jun 2025
 00:10:50 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: "H. Peter Anvin" <hpa@zytor.com>, "Hansen, Dave" <dave.hansen@intel.com>,
	"Mehta, Sohil" <sohil.mehta@intel.com>, "Kirill A. Shutemov"
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
 Petkov" <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>, Peter Zijlstra
	<peterz@infradead.org>, Ard Biesheuvel <ardb@kernel.org>, "Paul E. McKenney"
	<paulmck@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>, Xiongwei Song
	<xiongwei.song@windriver.com>, "Li, Xin3" <xin3.li@intel.com>, "Mike Rapoport
 (IBM)" <rppt@kernel.org>, Brijesh Singh <brijesh.singh@amd.com>, Michael Roth
	<michael.roth@amd.com>, Alexey Kardashevskiy <aik@amd.com>, "Alexander
 Shishkin" <alexander.shishkin@linux.intel.com>
Subject: RE: [PATCHv6 01/16] x86/cpu: Enumerate the LASS feature bits
Thread-Topic: [PATCHv6 01/16] x86/cpu: Enumerate the LASS feature bits
Thread-Index: AQHb4erCSBDI66dtY0W/I0p+M+8Xt7QMWp4AgAACu4CABJQ7QIAABjoAgABr+uCAAAevAIAACQLw
Date: Tue, 24 Jun 2025 00:10:50 +0000
Message-ID: <SJ1PR11MB6083EC9DE16B472CBF10E484FC78A@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20250620135325.3300848-1-kirill.shutemov@linux.intel.com>
 <20250620135325.3300848-2-kirill.shutemov@linux.intel.com>
 <248e272c-79ec-4c11-a3a8-dff1de2147c0@intel.com>
 <adaf2d81-75b5-4f02-99ea-03ea0f1a5a96@intel.com>
 <SJ1PR11MB6083AE2EF85FB5D2FE39D4F0FC79A@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <8f0913d7-9e77-41e0-91e2-17ca2454b296@intel.com>
 <DS7PR11MB607789E9CDFF5C4DC1461015FC79A@DS7PR11MB6077.namprd11.prod.outlook.com>
 <299ED4FB-6949-4E7E-82D4-94E2E9F0A0B5@zytor.com>
In-Reply-To: <299ED4FB-6949-4E7E-82D4-94E2E9F0A0B5@zytor.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|SJ0PR11MB4830:EE_
x-ms-office365-filtering-correlation-id: 0598c0f0-1ae2-41a3-cb8f-08ddb2b393fc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?eXppSHRNVFp6anRIQ045bllLYzc1azBVS01xT1NRWGh1dUVsVWtYVlhpQ0p5?=
 =?utf-8?B?SXprK2gvR0w3M0g0U09OajlOcktLdmF0aU1PU3RvWmVrUCtFZFIzUUx2bjc5?=
 =?utf-8?B?akE0K1VFOTd0anBkYWhqaGRPY1d0UEdzOVpscG8zaVl1RDFieFQ1TFFXV0dl?=
 =?utf-8?B?OWJJTzFIc2oyTTA4NzlvSFhZOE5uK0lMdElpOVlCb3IwSytPQTF2clBrRk1Y?=
 =?utf-8?B?SEJyZWNvaVMrZnZaZ2Fnb1VZRWtUYzQ0RXByVHkzM1ZWWExMZG54RXlaOXBs?=
 =?utf-8?B?YzlocDRMSW96TGNxc3Y0Ri9IbzA3Q25HMzhrMTE4MWt6YmdaWUNMdSttaFN5?=
 =?utf-8?B?T1JOZmlLbk5lZ2xKSEZHV2dHU20yRjlsZ3p3RlZQbGtITHNZYXhTVm1mUWY3?=
 =?utf-8?B?MFZSTFdCWDBCUFk3QTQ5eEUxNytkSGgyODNLQ3FXMUxhaDFyMHkwQnJtZFhX?=
 =?utf-8?B?aHVpUXVtbW11ZmVUdXRsTXROZDJDNythQmRVdWNlRHV2cDZ5K2Q4OHlCWFZD?=
 =?utf-8?B?V1NYZi9vZk9RU2pTWk5yVnNobGdIdkcxdE1KL1kyUmVURENBTkpUNVdKdllp?=
 =?utf-8?B?bHNvYUcxb1VmVkRVaFRjblZlRmxkYVlwREplcmdzUkJGL3BNcDhXUDl6Rjlq?=
 =?utf-8?B?a0pFNnR4Tk93MXRlRjRnQjJjMDBiTzNCN2JoNFg3Y0dGdUUrQ3FqcU00T3cv?=
 =?utf-8?B?OEpITmtLb2pFdmo0NnhSd1BrZWV0R0pIVnJFb2VUb25FbTlZeTFxVEltQ2Ju?=
 =?utf-8?B?cnhTR1U5dkc4aHBMSDBPeHF4V056NjJxcjZTSzMvZ1V4MnlTemY3NGNmUGd3?=
 =?utf-8?B?Unl2ZGFNVFZ5dU13QnZ3T1dhTUQwQjg1ZjZUQytaYmhHQVZvWFRGdFFWekQ1?=
 =?utf-8?B?NzhqRkJmT293SW11QWFZZDJRMU1RSXozbjgwdnlDSWJkU1VzZFJFb2Z2ZFBQ?=
 =?utf-8?B?UnFWMklrRmVaY0ZYL3hwL2pQMlJjYjdPeENxMVBIMllRQUdWK0loVW1YL1J3?=
 =?utf-8?B?UFM3VTcxUWRuRVZENER2Y3NiY2RrR01qcys1TFVQNjNvb0dCRVZROWZFakgy?=
 =?utf-8?B?UktJODBwMXpjZHpKQVM1bFp1cHc2V2c0dy9kTlVQbFdPNG1zM3U0aWRKZk5W?=
 =?utf-8?B?Y2ZYQmxpam1zVmNhQlBEV2JSa1Q0cndmbEptdWNnZDJHcWN0M2tVT0JJUzFv?=
 =?utf-8?B?QngyNVI2a2J2T1phYUUwRzd6WmFObWppR3BVcDZDYzkyWGJ1bUpFOVQzNFp4?=
 =?utf-8?B?ZVZBd0RVeE9XZGRPNFA3OWxTZ0IxdGh4aTVSeFZqSUJEenZZWmEwV1ZnaGNJ?=
 =?utf-8?B?cmpuZEtLNlhmU1NlOVY0VFhSdDA5bzkzWDdWTW1Uc1plMUk2Nmg3MFFiby8v?=
 =?utf-8?B?aVlJZEkweklEbUxjUzVuRWIvVWxCam41MEVrSGdRY2IrRHZUTktUTDROWXBP?=
 =?utf-8?B?eWxxV2ZtMTlqM043TjVONmFRUDd1L2RLWS9Fd3k4VjNoeVgrMzVvQmlseElJ?=
 =?utf-8?B?aFhyN2ZjOEY1Y0FhdEZlZUFPS1V0T3NBWUVzWGREMWh3K1gwSUpDMHlva3ps?=
 =?utf-8?B?dmdYcExUU050dHdCNnRkb3Rya0FlTGhvTElYVDFlMHVrbkNFUVBQQWdiN1l1?=
 =?utf-8?B?VWF1RStZY0Z6TTJYaHV5cWNoUDE1cG00b2Y3dFdpOXpiUTBCZDIydnhqZ1VE?=
 =?utf-8?B?Qm1hSFh5bmZDZHlDekRoRGJKN3FUQnhvK0Z3bFpYTldUem5IUHJib1RDUnEv?=
 =?utf-8?B?Uk5QVUswQUdNZEc0YUo4b3pKWSttblNmVFd1am9ESHM4S0puQ1B5Tnc3Y1dP?=
 =?utf-8?B?MXBJVDBRWGt0alVDSGxOUzNjSHZpRGZlQllNcXdzRGNYM0o0ZzArOHBWbThK?=
 =?utf-8?B?V0NrVElGRWtiQ0JxeHlOWmh2M1lYOE02VldZdERoQnRsRlNYS0VlYkZBNVZ4?=
 =?utf-8?B?ZlRyNTQwNzVTbHBtOUhhSjRtek9weFc3dHNDd0w4UGx1R3A2RStEL1doQy9V?=
 =?utf-8?Q?/L5MLAVACPpymsbASIr57jXk97+TCs=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K0duTDNXWU5DeWEyT2ZsSnNBdlBOek9qNmxwNkJoTVBNd0RtYkw2ZzZoNWto?=
 =?utf-8?B?UmlGNElxUTYvVno0WjhrREhDdVhGVTVnaU13M3VmaUJHaHJ4TnhESHRUM2dW?=
 =?utf-8?B?dDZTdysyaTAxUGZSdmRmbjRiamllem55bHJMcndhZGNqdmVjKzRmaGwwTVg0?=
 =?utf-8?B?TUNJTnNkOXVacGpvZUo0MDBzWHo2djlmR201SEs4ZHdnaTVTSGVoL29EK1po?=
 =?utf-8?B?TEVEcEc5NVlLbEU2OEFQbTFHdkFtNzdqQlBaTDhDQnA3RGVpVjQzR1FoWC9y?=
 =?utf-8?B?bFUyTmtsdnFCUWZ6ZnlwUzNwbUVDWW9pWDNpZXI2dnFZdjdoY2R4dHptY3Vz?=
 =?utf-8?B?bXUvOElxTUllb2dzSE9MOWhmMGZpL3JmcXNHNTZ2cUdINlVEcFJ4d2NCTTVL?=
 =?utf-8?B?Z3IxRzdJcFJwb3pId0dveGJIeFhLb2w1NTkrUytqV1pZenhTMkhwOXhyenpk?=
 =?utf-8?B?QUdzenJvQW5xT1BTYUc1eEsxNTVKV3MzdGh2TkxQaTJTN3RtSzM3UGtSTlNk?=
 =?utf-8?B?blZYTHZ3WmpYclZKYUJKWG9TVUxOVlZ6TWtIa0xMQXlrelNiYTZiSzRmaUNt?=
 =?utf-8?B?Z0dHWERWN1RqTDFoRVl3VVJnUlEwNGhvcWxXb3Y4MitXS0NBRkJZYXlGWVVW?=
 =?utf-8?B?UlVjazJYd3k2Z2F3N1lsdTFybmgwdjFoY3FHQ1Q4TGQ1TURlZUJ3dThrcUg0?=
 =?utf-8?B?MzlyaThGMHlnZEdlYzl2SFV3S2crY3Nzd1J4NDk2TDVxVHRONGNxTGJSVG1K?=
 =?utf-8?B?V1lxN0ZQdzJCMkMrM3AxQ2tCZHFqN0NlVVpLNVRaMXlsSnZ2L2EydzN1clNk?=
 =?utf-8?B?Z3VkRnkzWFR2VUlmdmN2YjZqZFlQNVV2YXVuSCtuUE5DZGtHVVNhNjd3NFdz?=
 =?utf-8?B?M1NjaStOSDkxcy9DZlY5UDlTYm91YTIzbjJNL0hMUGNqK1Q1ajFsUzNKcklp?=
 =?utf-8?B?RnBNVGlNUFlXUGhJem9JV1FIYnFRVkRHM0FMOWJlQlN6UDNKSElhYk12WlRx?=
 =?utf-8?B?emo4clE4WFJVYzF5eE9qMWFoYmN3clE2b0VORW1oem5zcHBuV0p5ZzhoUjFt?=
 =?utf-8?B?MTdXUGZFeDc2ay9hWnpTYVpxMkRDcUJFVzJWbzhhMkpBSDhFUEYxR2tQd1Y1?=
 =?utf-8?B?aGE4MXJoQUhxWGhiTUp6N0ZjRUV2Q1FxRGpkaExvUURpR0xNVGN1WjFvSFlT?=
 =?utf-8?B?NUthUnJwZEtKTUljR1VxL05MSDg3VFpBTTEvWUVHTVc0clRQTFlzcWg2YlI0?=
 =?utf-8?B?M0xjcVNMMnpoTnpLWXlFakpneGFuS2xNOEVMd2JuR2xtcnc4ZXAwaExWcjlt?=
 =?utf-8?B?SFRjL3lPN3p4SkNDbjBram9HRjBmeEtNR3FscjBTL0o1dXlsUDNJWGdHYXlP?=
 =?utf-8?B?NHFXZjJkNkRxa0gxTnBqaEpwN3BFK2ZzZVcvK1U4Z0ZvemZvQVNlTEpjTXd4?=
 =?utf-8?B?QmJ0dERCKzNHTkZLUStpRThjV1hXem9aSjNyY1krNGNFRlh0Y1lJTXpDY0V3?=
 =?utf-8?B?aEp0Rk5LcVdkM29GdHBZWEhFRiszZmxnZnYzY0x5QkpZZkVFQ3c1VGtQaWdm?=
 =?utf-8?B?MmYxYnpWdEJLTXd5cDRpWlAvSEYybXFobm5MUWNOUXJSemV2YjZ0b0lyZldn?=
 =?utf-8?B?ZzY0WjVSekJnbjFlQkdWZUIwTzYrQS9RUEtoOTRzOUNQR0xUcGNjaXE0OG9n?=
 =?utf-8?B?TGlHd1ZSSnJCNVEvMS9EZnIycmk0NzhuY1QrcVcrdHBrUldCQnJlcjdGNDFL?=
 =?utf-8?B?MUhSVks0N0JZSGlRRU4zQ25kMlVTOU9aa0NValRVK29LOXJLSlIxSDFsOWox?=
 =?utf-8?B?em44V1ZQeDZrejVjZnJWaFo1MEdZTXVaTjJRSEJ3T1MyZ1pUZTV5MHNzZEI4?=
 =?utf-8?B?WTBBRkdTb0FUdjFsTlhlb1FYcHFpU3MyalQzZ3hPZFlpRGxxWkg1SzgwdWp2?=
 =?utf-8?B?RWF6Sjlwc0ZqbE4xdTZyZ0pIZmR3aC93Wno2bkFUcHY3eTRlM3A4cEQ3dmJR?=
 =?utf-8?B?VXJNMmRraFZiU0srbGJXMzUvQzI0aHB4TEtkWEYvV2JnbWp4VG51Q1Zpc2Rk?=
 =?utf-8?B?VHFTaXFHbmdEaktDUmV3MkN6S29KMkg3RnlyWHhHeWpDTC9rMjYvTWl0RE4y?=
 =?utf-8?Q?fLNLYWpaE7VpHXcvpKVIirrWg?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0598c0f0-1ae2-41a3-cb8f-08ddb2b393fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2025 00:10:50.7727
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bGKEfX0OoLeDQkU2mJwupZGyT4b5t0rOErC99cI6fw1Z+6myYSP5zUUKFuLweBP+DAGCRNHqx3ivreEOtPQtMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4830
X-OriginatorOrg: intel.com

PiBBcmUgd2UgYWN0dWFsbHkgZG9pbmcgcGF0Y2hpbmcgb24gbW9yZSB0aGFuIG9uZSBDUFUgYXQg
YSB0aW1lPw0KDQpXZSBjb3VsZCBjYWxsIHN0YXRpY19rZXlfZW5hYmxlKCkvc3RhdGljX2tleV9k
aXNhYmxlKCkgZm9yIGRpZmZlcmVudA0Ka2V5cyBhdCB0aGUgc2FtZSB0aW1lIGZyb20gbXVsdGlw
bGUgQ1BVcy4NCg0KRG8gd2UgYWN0dWFsbHkgZG8gdGhhdD8gUHJvYmFibHkgbm90Lg0KDQotVG9u
eQ0K

