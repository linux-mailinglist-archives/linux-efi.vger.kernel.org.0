Return-Path: <linux-efi+bounces-4503-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EFB6B17C2C
	for <lists+linux-efi@lfdr.de>; Fri,  1 Aug 2025 06:44:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1F8D1C201E6
	for <lists+linux-efi@lfdr.de>; Fri,  1 Aug 2025 04:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F7601EF0B0;
	Fri,  1 Aug 2025 04:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FRe3pL8r"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69DB81F03F3;
	Fri,  1 Aug 2025 04:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754023431; cv=fail; b=iG+vrZvbQv8EesdJAwDfoulBgaLo78VrxkVoFccE/Ieklj0e8ibEfO4SzRonQBZfj62CSS4CdnYsG2/0yhUwoDPEBlMGbMIIy/XCnNqZqzBWVe/ynlj1TFeSugZXm11vMn4mxljCiHI2zlLmTB5dE1Th3Fuwt10MT2536vf3000=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754023431; c=relaxed/simple;
	bh=xiiOJsSd3alnjgnBDPTKh0YDwwJcaaDDIvBS9dEhUiY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=r1i9WKVdZhXoN3hrXb8qi4+83apIRXWUMEOuuIS3lysW/81hupAkQSFZahHjgfRya3IsaMoeGjksDjXXwacy/DkHRmEjaet0oTX3dMAWZCsog9LgzFbhFRGIVz67trZtha7dLPuvl0rT3Bq2a0LHx9TyUmbznSv2MsQqg6yL2+U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FRe3pL8r; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754023430; x=1785559430;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xiiOJsSd3alnjgnBDPTKh0YDwwJcaaDDIvBS9dEhUiY=;
  b=FRe3pL8rt0/PczK2dRhrVGB1dKWOzp0GZYLvHEvvhN5fXa81OFd7HBRl
   DoDqmfIwNMQiP6xzwORYrtanaHpYK03Qa5R/xdhRLP1QRdPMlAX8uXAPP
   m+Sze+6l6Tn5Co9z/LIm1j2eXBOJOKABg6HLt0xQ9dJ+zx77yQL7/k7aA
   qeMMRlksd/SBCzGq6Mk7i+4lr9rS5JusUQNfwxYPdQTHKvPBDAHgtseYQ
   0N/dC+yRol/NomXNu7w7UUEXk5WUArx04vzE2QE7RbEkLKTmwtiFSai70
   6aVVtv87kMjQqNp2rVAGmytsJghY/HT4Un7WafmQDBF2nbi7i27iovK5w
   g==;
X-CSE-ConnectionGUID: U+6Z9EuTS1KKEGvI8NC8OQ==
X-CSE-MsgGUID: kb6MQIZrRPmeIl8Q9FOryw==
X-IronPort-AV: E=McAfee;i="6800,10657,11508"; a="55423933"
X-IronPort-AV: E=Sophos;i="6.17,255,1747724400"; 
   d="scan'208";a="55423933"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2025 21:43:49 -0700
X-CSE-ConnectionGUID: w8IpBgGjROmT7weD5p3+dA==
X-CSE-MsgGUID: oGdbMAC4RaKwuAMdYGL2Pg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,255,1747724400"; 
   d="scan'208";a="168846073"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2025 21:43:48 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 31 Jul 2025 21:43:47 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Thu, 31 Jul 2025 21:43:47 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.86) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 31 Jul 2025 21:43:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J43TQikQOjm1iNy2FCvctLiuOg2dwpcMBvOyg/1gpWjVO7+hMQa4N09ISlr8u76M01P/fiWL/WN0AQsBSYHuutrM+zg/aWu0DW/aV5FJD4KqMCC8j39+1qb76LXnqHejMBAHyfg/+Se7cBl5iNoJm5zCNl7BoYCBm903dyJ5j3TKVoKNtVlAl9WpaSR8NpDToONfrOebqPw1PPlkTCW1vRCjgeQXeKqDyM2QgA6kGHDwVfUStvsMnJa2oF1nU/dsDn2VfasSUlmJcTkBbutDVfmh6Iu2lW+HwVv0OLAVBqjeK0u/gGGmQoTOFrrDdeGAek6A8hl8oTeAoGPqPZf+EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=19YNpEghXdQb/1VA//ZJ+kT9yFrIWTCVdYnEaVmZ2CU=;
 b=M4Tn092q1mP+K2X+Fvckf7Hawr8qehSb8qsDbYPcMoe/k5QoRA5UUF+fmZ0Z84z3OmyNpcrufbheIDVLHVtcXOlPCXAXlQYj/RWkovJ5o/PtN0yxyN47IEEw0Oj62XqdNSQBiQ7LcQueS1ac/ffUMGNbOIYZ7QH0DTI8P4mIU7LwgvhN8jm9ntSTKPDGcEPQV6PE4qfbmP3Gv0RaBH0LjrnlvqwdxT3byUrPCQbVUZSBNCCs36kHJfzNsBK9oDDtmjK5TQi4mzSkcRv5jsUolhxyMnzQCa9hSSWCnuYHsifupNhgETcSIGdpL/EBua+3lQ3ztbeu0TG/D/3eOyFPVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by CH2PR11MB8868.namprd11.prod.outlook.com (2603:10b6:610:284::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Fri, 1 Aug
 2025 04:43:13 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b%7]) with mapi id 15.20.8964.026; Fri, 1 Aug 2025
 04:43:12 +0000
Message-ID: <1c42680f-c962-4a75-998f-031008dd8343@intel.com>
Date: Thu, 31 Jul 2025 21:43:10 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv9 04/16] x86/cpu: Defer CR pinning setup until core
 initcall
Content-Language: en-US
To: Dave Hansen <dave.hansen@intel.com>, Thomas Gleixner <tglx@linutronix.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, Kees Cook <kees@kernel.org>
CC: Jonathan Corbet <corbet@lwn.net>, Ingo Molnar <mingo@kernel.org>, "Pawan
 Gupta" <pawan.kumar.gupta@linux.intel.com>, Daniel Sneddon
	<daniel.sneddon@linux.intel.com>, Kai Huang <kai.huang@intel.com>, "Sandipan
 Das" <sandipan.das@amd.com>, Breno Leitao <leitao@debian.org>, Rick Edgecombe
	<rick.p.edgecombe@intel.com>, Alexei Starovoitov <ast@kernel.org>, Hou Tao
	<houtao1@huawei.com>, Juergen Gross <jgross@suse.com>, Vegard Nossum
	<vegard.nossum@oracle.com>, Eric Biggers <ebiggers@google.com>, "Jason
 Gunthorpe" <jgg@ziepe.ca>, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>, Luis Chamberlain
	<mcgrof@kernel.org>, Yuntao Wang <ytcoode@gmail.com>, Rasmus Villemoes
	<linux@rasmusvillemoes.dk>, Christophe Leroy <christophe.leroy@csgroup.eu>,
	Tejun Heo <tj@kernel.org>, Changbin Du <changbin.du@huawei.com>, Huang Shijie
	<shijie@os.amperecomputing.com>, Geert Uytterhoeven
	<geert+renesas@glider.be>, Namhyung Kim <namhyung@kernel.org>, "Arnaldo
 Carvalho de Melo" <acme@redhat.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-efi@vger.kernel.org>,
	<linux-mm@kvack.org>, "Kirill A. Shutemov" <kas@kernel.org>, "Kirill A.
 Shutemov" <kirill.shutemov@linux.intel.com>, Andy Lutomirski
	<luto@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra
	<peterz@infradead.org>, Ard Biesheuvel <ardb@kernel.org>, "Paul E. McKenney"
	<paulmck@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>, Xiongwei Song
	<xiongwei.song@windriver.com>, Xin Li <xin3.li@intel.com>, "Mike Rapoport
 (IBM)" <rppt@kernel.org>, Brijesh Singh <brijesh.singh@amd.com>, Michael Roth
	<michael.roth@amd.com>, Tony Luck <tony.luck@intel.com>, Alexey Kardashevskiy
	<aik@amd.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	X86-kernel <x86@kernel.org>
References: <20250707080317.3791624-1-kirill.shutemov@linux.intel.com>
 <20250707080317.3791624-5-kirill.shutemov@linux.intel.com>
 <6075af69-299f-43d2-a3c8-353a2a3b7ee7@intel.com>
 <98a7a91b-3b46-4407-82a7-5f80443b7e00@intel.com>
 <6e768f25-3a1c-48b9-bc53-56877a556a83@intel.com>
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <6e768f25-3a1c-48b9-bc53-56877a556a83@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR02CA0044.namprd02.prod.outlook.com
 (2603:10b6:a03:54::21) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|CH2PR11MB8868:EE_
X-MS-Office365-Filtering-Correlation-Id: 761ae324-91b8-451b-b667-08ddd0b5ec2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SUlFSWhlYXhqanJBK2d2L3BnR0d4SmRWSkhsRzdpajN1aWpkK3NyS3ZweVl2?=
 =?utf-8?B?b2xoZmNILzhjdGV4cDJvUUhCbkVwYjQxSWYwaUpqck9DS3ZOeGlOaUdTbHNC?=
 =?utf-8?B?Mmt6NEV2VXA5QVVvMWRPaERzQmh2RHNXTGpFTTJzY3F5VkVmem5XL3JDRHdv?=
 =?utf-8?B?RXl3S0JHMG5Cbml1U3A0b2tqZjBXV3pqLzlrbUxnN0pRaGhmU0xTQTkyUlN6?=
 =?utf-8?B?RGVJSDVIWU0rQTNJR3R0cXpvUUpOVUtzOXBBbE9XaFVVRkx0YTBPTXhROGtK?=
 =?utf-8?B?QzNhV1BWdWNvZ3doU0ZmN2xDRVBDWVpPMHlOejZwQ1pLUDJxSk1lVDd0VndR?=
 =?utf-8?B?SUw1WUllOEwyWXo4VXQ3N1dmN0MreVVWYjRVcFBjM2pHcWZucytHLzJ3Umwy?=
 =?utf-8?B?RzFCN3JBMXBTcmlCaXlzdWYxdEFxMkRVUUZRb2tHVEtrTXlyVzhRellaU1Z6?=
 =?utf-8?B?RklPVHdKdTBvSlNvQWQvZnJrUnRaN0daVFJ1MDhxVlAxeVQ1MzQ1aW51NjFi?=
 =?utf-8?B?NEJUVWk1MzU2dENRS2djank5QVVUUE5oOVdJTlYwZ3ZLZlNlTjZJOEJ3S3h1?=
 =?utf-8?B?dE0zN3dQa1JvVHlqbzJLQjNncnVuSTUva3dsYTI0cG83Y2RYOSszZWl1Qm9p?=
 =?utf-8?B?MzI1QzdsczZldGxnaEVvQVJWMXlZZWZIc1BiTUZiRVFST0xDd2JlREltZ3JC?=
 =?utf-8?B?T2h4RkhpQXhERFNoOTdUdXpKRnVDcjh5STVJc3E5NWJlZDJMUmszTUxpL0p3?=
 =?utf-8?B?WFJnaUxRTFZaVHdObFdOdWxaRGNISVRXNFFuRVY3bnQ3d1lzbWRKNUF3cXdR?=
 =?utf-8?B?a1hjdHhEcTU4WXJJQzF4NjYvcUI2QURoWWIwVkc4L0JFeC9neHBDSDBuSytS?=
 =?utf-8?B?QkcrUmlyZ0NNVk5ieWJLUjIrU0czRldEbUsxN21pRDBwaXJTQXQweHF0aEZp?=
 =?utf-8?B?OHFNVUZDbmdjMElCR20zMG94VEUvWnQvK2V2bWxzd2dUYWdvaHR6cEkyTDBk?=
 =?utf-8?B?S1JFL0lkWGVyb2dCak1PU1hOVEVaOFZocEp2L2c2bnhrUkx4Z29HK1VqdENZ?=
 =?utf-8?B?N0FRZGl0ZWNCd1YySDhkSURZQVZXckI5TWhNK3hTQ2NRYVBkRXBBYWdscWts?=
 =?utf-8?B?VHA3NldlWDgyVzVmQ2pubVMrRHJLRjJCMXFXNzUvSG9QUFBpYVNzY1hjc3pw?=
 =?utf-8?B?dWxMMWE5TVdOTmhvTVZjQnhkdS96UnRlZGt2TGZiUEVJb21HdzJoZGx4d2lE?=
 =?utf-8?B?OWFvUFVkemkrT2FraWlnUDNPa1I5UDFRcXNXOVE3Rmp2eU1jenMyUU5pLzFi?=
 =?utf-8?B?bFRBdGFEN0ZPSldueEM4RERuRU83QjAramRPRjc5eVZPYkJlNzBGQTRxWHkr?=
 =?utf-8?B?N3F3OGdvb0Zwc3hTTU0vV2dkRkliT3pjemJrek5XeE55U1FFVUc3Zzg5a0lG?=
 =?utf-8?B?VUFmWkZNdENJOHE2bHExZGVEUll2bTRNaGc4UWZEZ1NUZlN6UWk3TlZMNktp?=
 =?utf-8?B?MUNXKzdpVS9YSzBraWxpczlHNTkxTzdOVElUS1V2blR4NWNjNDZlZXhKMVJI?=
 =?utf-8?B?ZjlPdmw0N2QyMHFEenRFdHU1UVBOcVN4M1JKT0tWay85KzFmNERKTnFNZHlN?=
 =?utf-8?B?SWVpSmxIV2NUeXpxMHBubGI4NTFSektJSUpVQ1Y5U0RxQ2tqajAxZTljMmli?=
 =?utf-8?B?a00wUDNzTEMycHp4RGZJaXY5UFBlT3doN2lOZUlpRmZWeDJURmVyTE9jbG0r?=
 =?utf-8?B?QjJqV1h3M2ZGVHovcG1hdEk2OWJSSEp3QzJISytTMWs1dEszOHRoYUxlNHZV?=
 =?utf-8?B?VXRNWit1R0haQjlPRnFTeEpTUG9HZ1JhWWpkWWd5U3RhMXU5bmpDT1Y4KzFy?=
 =?utf-8?B?U2M5Y1FPWnFjOGV5Q3dkRkMrTFhVWU5nSEwrc1dKL1NSeXNjaFZlUjZRN1dR?=
 =?utf-8?Q?bEODAwwY9ls=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NnJkVGJEOHZ4aHQ3TFdXSHpHZUJMbDArR09TTXBqckRaR3VhU0NoTnAwSHE0?=
 =?utf-8?B?MTNnSWpWZEpISHo2ejRvVG1zRzVPS1ZmQnNMb1JSZEx2SlZsaVJGZlllUEtY?=
 =?utf-8?B?aUF1eWZhZ1FNTDVYZ1BsR21pYW1hU0YycmRZTnQ4anNFQlpKMmFGN1ZacC9D?=
 =?utf-8?B?VHE3L1pieVJMM1FIQXRXYXNCS1R2alUxR1BhWnNQZ2pLdjJFcTA0blU0UGNh?=
 =?utf-8?B?ZnErcTJzenBJRTZydlJGcllxOTRLWmhUM0F1OVdGdzlGTlNBaG9NVnBFUGM2?=
 =?utf-8?B?L09oOTdLeFhHUHFLRStEYlVXU2hqOThEaXA2ZVJyVVo5SHNJdzU1YWtkN3VV?=
 =?utf-8?B?TnJxRU5QRUtheFVPbDJ2UGExazdkY1pBU01IVllKZmtvdVNOajYzeWxVT1hr?=
 =?utf-8?B?WVBGN3JhVjh4RFZOSmlkZEFXbXhEejFYUjM4clVzWWIzNXZBVnlEQjFwbmJ6?=
 =?utf-8?B?ekZ5SUovS3Z0dXFNWjd6OEdYMnRLdVNZWHlDSFc4eEp2d0JEMWZzTmlQa2E5?=
 =?utf-8?B?L0hVeXhPWGwyR09SNHJ5VCtGQjZ1Vkh5cmdnMHNxcHVzc3NlbVFRZDQxajFi?=
 =?utf-8?B?cVYwdU9PTUxHZXlibS9vdFpjTitLdjEyQ1hLM2Z1YTRwbEZFckJ1aitUZEZI?=
 =?utf-8?B?U3lCNHJ3ZTVuejlkZVlhYjdROXBPbzJnd1M5MlpRd0R0SnozNTB5R3FrTWpx?=
 =?utf-8?B?bmNWR2h6aldNaTlGekdmbnJOVkR5UzR5MTVWNThEVGdoOWVLVHdKTnY2SklF?=
 =?utf-8?B?OWJSNlptWGRoVzh1ZlFpOVVmbTIwQmgyRjZlR1hsS2lGcGZncDdFVWkrWDRQ?=
 =?utf-8?B?b1BldjQ1UWc3RGVWOHdHMkhlWWc2dEYxaWJzMGlmd1NIWWp6SDJqNm9UNm1q?=
 =?utf-8?B?Tk1Ed2VhVHBHUnY5NFRtU0xOT3lXaWowbzFDa1h1OTMzQlg5clJDTFFMN0dN?=
 =?utf-8?B?cXUycUJnMVp3dFNTajJCb2EwOFlPT0FrSWNjYS9vTDlOb2VhZ0RabmJzL05k?=
 =?utf-8?B?alJpbEFrdmUwVXFFMHNFVkMrUVA5ZkpSS0d6N2c3a0hWS0lBTkIvY1hMWGoy?=
 =?utf-8?B?U2JtOFBPSkZjU0RRZHRNSGp4TDBiSVlpZGt3aHNoS3h5ekZsQTB3ZU1mczBJ?=
 =?utf-8?B?TGl1dnJ5cG44TWdNalpUeEhZRmFSdzg3OWlNYU1QRWNuZitNYXlXTHdvd0pj?=
 =?utf-8?B?Z3RNbDVFejd1OXBFL1pzTy81VTdnQWpkUUhWL2s5U09jcmcwVXdJOENYamVX?=
 =?utf-8?B?VmlMOEd4YzV1SXIvVGtXUDVLY2ZmQVNCUlZCSC9XenhwbisvajJtRWRSS3VL?=
 =?utf-8?B?STRNZE9EazZoZFZTL3dBTGVwMFdVakpCS1hJR1dmZVRsL1BCWFdOWk1ZUUl3?=
 =?utf-8?B?dGcwR1ExU0hGVTZDUlpMNFpEUHk0eks4eFBKcllMOXBKM3oxMEFEdTRJRkxU?=
 =?utf-8?B?S2orTGdqZ0dQT3RhaWVJU3Q0N2o3b2thaEpvOEpQYlk2L1dJZGdmcE5rMkJD?=
 =?utf-8?B?K0xXTVZhMThEZGljL3lVaE5uSDJJV2tLcTkyeG9DUVpndDE3a25KQ0VpdWhl?=
 =?utf-8?B?T1UzbGVqbkFLMDFsM05EWDNTWEo2WGMyNHVKdXU3WVhxeFNMOUJUWCsyUWsr?=
 =?utf-8?B?SHFwWEl6bmlHQmpqN1JwSFY0SUkyL21RYXBkNzN2WXd6RXNwREI4SVdGUkJN?=
 =?utf-8?B?US9qd21Dck12ZkN5bWtJK2loTVBMTXZudlN2OHdzZ0FSVjNWMFovN3hXUkRW?=
 =?utf-8?B?TWFiNE5RaVlPcW5Fck02KzRIU0tqQUM5cVFUcy9UK0t4UExaVS9BVVA2SjNY?=
 =?utf-8?B?L2xveUNzZDRrNEVMOGJLazF6R3oyWmxoUXBoYjJSRmNWQnBUeC8reENzVEdV?=
 =?utf-8?B?Y0drQ1pPOWFWSTRnLzhSaFBGWGRUY3FNTFpMVFg5WkI1N3d3QVJrSk5NcjRV?=
 =?utf-8?B?OUZDY0dIdzl5Z2hQY29MYTBzZXJ2c3d5TDluSWFFMlVEVTJUQjRHa01GL0VT?=
 =?utf-8?B?aXRUejdmcXFCaEtUY2FvL1ByRzBCM3VheExQUFFHcitILzRaRjI1UmNHdk9W?=
 =?utf-8?B?T1E4RlFMZFdoNW5ycTFLaFh2bHpiU05kSFUxMXphTjAyRllVc2d0ZFprRFVu?=
 =?utf-8?Q?d/ry3TdkUu0YVQe6nmWyI43R1?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 761ae324-91b8-451b-b667-08ddd0b5ec2e
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2025 04:43:12.8716
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ojDtIZA/fVUl9dSkKB1QUucGDb/aYRAmL7gcz39xI3EoUxvoHUTKgJq/BAkgqY3FSx3cW7C+mwc4XxyK6TDUhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR11MB8868
X-OriginatorOrg: intel.com

On 7/31/2025 5:01 PM, Dave Hansen wrote:
> 
> 'cr4_pinned_bits' should be set by the boot CPU. Secondary CPUs should
> also read 'cr4_pinned_bits' when setting up their own cr4's,
> unconditionally, independent of 'cr_pinning'.
> 
> The thing I think we should change is the pinning _enforcement_. The
> easiest way to do that is to remove the static_branch_likely() in
> cr4_init() and then delay flipping the static branch until just before
> userspace starts.
> 

Based on the current implementation and some git history [1], it seems
that cr_pinning is expected to catch 2 types of issues.

One is a malicious user trying to change the CR registers from
userspace. But, another scenario is a regular caller to
native_write_cr4() *mistakenly* clearing a pinned bit.

[1]:
https://lore.kernel.org/all/alpine.DEB.2.21.1906141646320.1722@nanos.tec.linutronix.de/

Could deferring enforcement lead to a scenario where we end up with
different CR4 values on different CPUs? Maybe I am misinterpreting this
and protecting against in-kernel errors is not a goal.

In general, you want to delay the CR pinning enforcement until
absolutely needed. I am curious about the motivation. I understand we
should avoid doing it at arbitrary points in the boot. But,
arch_cpu_finalize_init() and early_initcall() seem to be decent
mileposts to me.

Are you anticipating that we would need to move setup_cr_pinning() again
when another user similar to EFI shows up?
> Basically, split up the:
> 
> static void __init setup_cr_pinning(void)
> {
>     cr4_pinned_bits = this_cpu_read(cpu_tlbstate.cr4) & cr4_pinned_mask;
>     static_key_enable(&cr_pinning.key);
> }
> 
> code into its two logical pieces:
> 
>  1. Populate 'cr4_pinned_bits' from the boot CPU so the secondaries can
>     use it
>  2. Enable the static key so pinning enforcement is enabled



