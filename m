Return-Path: <linux-efi+bounces-4076-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F9B5AF06CE
	for <lists+linux-efi@lfdr.de>; Wed,  2 Jul 2025 01:14:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06F481887227
	for <lists+linux-efi@lfdr.de>; Tue,  1 Jul 2025 23:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E242826CE0B;
	Tue,  1 Jul 2025 23:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y4zZSpot"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3585623F28D;
	Tue,  1 Jul 2025 23:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751411656; cv=fail; b=m9loRzc175n2OoKzlUAKckzkozxljeS2jJM5/0ZF2/DbgtJ/UaTR0QkVLPGAnMjjGT5aqV4PSwRzWVpaZkeljF4QpZUHTjcr6dChGduA6T0+L96FjiwUlzvzQoUXJtrLEjw+1gVNG6I2Fnpnn5SgSt5PX+psGBxMl1s8sYPz4IU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751411656; c=relaxed/simple;
	bh=gcNZEGpfDtOvK5Zhn7iJIszmASO4v+AnFvJgzSrLxpk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cDtb3IT4dhlmPcaL6ZRu9WuSYueVpK2chi5DcsSIST26vFc9zvyfe9rrN/cenoLO0AnmoO4a7KIMUvH8kdj1zi0O+ZTd/VtU34qdDH5ep0QO5hL+KUiSMfVVAR2HkQGNHLOz2fMQjUMjz/Nhe1L/rbGLNZGD/OfGk0f/X7rUuac=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y4zZSpot; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751411655; x=1782947655;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=gcNZEGpfDtOvK5Zhn7iJIszmASO4v+AnFvJgzSrLxpk=;
  b=Y4zZSpots2sigROQy475VYK0wv/0Ra2+wDhizsraMzyl6UxS8koa7dq3
   n5pAH7vH+6nW58W6FNdgl5bbaj1WOed6rLvkQ4Z5Hr+fmBP0DsFQcneT3
   k346I8dLDnEpI8/ttb/eOX8UcQNSbPMCTxytIteOmrXVdmRzyqF/1QTiB
   XFUuSUY5vjPc+g5OgjCnCPtdB+DclI1sAu5vQR7gR64vdQ2MVUpsaJSMr
   sAL6uJYYGycjG9yGu8hRFPpJWQD/rZi93kF/eLzgiWmhLuKmDEe8BaN6t
   JSRoj3e4b71Z9KJhOxM3Kc1buB8HAxQBh3t2n+8IwkExIPW/pS5dv+i3w
   g==;
X-CSE-ConnectionGUID: memmJJUJS32UBJZvA1+j7Q==
X-CSE-MsgGUID: DGABUErPToOfKbLoJMFtYw==
X-IronPort-AV: E=McAfee;i="6800,10657,11481"; a="53784240"
X-IronPort-AV: E=Sophos;i="6.16,280,1744095600"; 
   d="scan'208";a="53784240"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2025 16:14:14 -0700
X-CSE-ConnectionGUID: 9JKeUFY0TtqC/Ck0gKaxfA==
X-CSE-MsgGUID: x6+O9RnOSzSlR8rul9D80w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,280,1744095600"; 
   d="scan'208";a="154396015"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2025 16:14:14 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 1 Jul 2025 16:14:13 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 1 Jul 2025 16:14:13 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.72) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 1 Jul 2025 16:14:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BW8LvhqCBRaw4bvulbzIWazjDKuwJU/DHShMiKok7hi8zvFZIRfM+5JGYhtONBEzgA8+36Xo4OH29pikENuBthdUHrGmF3WehsRYSlg8JnKHQqV9pvuUgQJD/05MK5/LjB++Sy3uIdDZGWYjMH4aTexkSOR/uHDkzXprmXB0swfWMiaELYtOfQn39ByYP65lW3Q7M2iqjpAMHau2LTt4ZRcOz5GJHaemGxIIwsNDEPY/5BiRVDed4aKFXEeuzA1P7vCIO0juNxMasVoeAzxZZw45+QvpYFS96dsh88WV8YCsp1hxiyfAs76JJccS/r5IUsbbtDdJW8cQIOFExgp7bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YKdEPLkq9/IrkJYhdb8MRkxLDWAPX74gcc1gU2eURRc=;
 b=Yse35Ovh4eAWn8yqgNfJSBiFQcjSy1mFFg1L1+hD6uPrgsQW/He+yK7MWOn8dTV5mXmX5je1VRLKbU/8jRQjExA/jsgGbstbeRZ2vKHmJ1QqTbQGE4vvm3J6c4L0/VqSWC38bzMOjSwsd27ILN/Uhg8fOYGPvQxVI33Hn1GNCPDEg2+SJ58Mf7BfJZBIC+44wBGO4kf9XCKHIa4Rmq7hMJYvFIYBXHGbWBl7GMlQxo3T06viibp/JHEBcH3bDK4LKDlfqif1DkeBvPGy4hiNau5SUvSoezR2vIdSXaVAMKlh2IwubLcQE0WEz5qCsNS85hPTE+7USpVczoAcRisjWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by PH7PR11MB8009.namprd11.prod.outlook.com (2603:10b6:510:248::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.19; Tue, 1 Jul
 2025 23:14:03 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b%4]) with mapi id 15.20.8880.027; Tue, 1 Jul 2025
 23:14:03 +0000
Message-ID: <af709ffa-eb11-4de5-9ae8-a179cb99750c@intel.com>
Date: Tue, 1 Jul 2025 16:13:55 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv8 17/17] x86: Re-enable Linear Address Masking
Content-Language: en-US
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Andy Lutomirski
	<luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar
	<mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, "H. Peter Anvin"
	<hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, Ard Biesheuvel
	<ardb@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>, Josh Poimboeuf
	<jpoimboe@kernel.org>, Xiongwei Song <xiongwei.song@windriver.com>, Xin Li
	<xin3.li@intel.com>, "Mike Rapoport (IBM)" <rppt@kernel.org>, Brijesh Singh
	<brijesh.singh@amd.com>, Michael Roth <michael.roth@amd.com>, Tony Luck
	<tony.luck@intel.com>, Alexey Kardashevskiy <aik@amd.com>, Alexander Shishkin
	<alexander.shishkin@linux.intel.com>
CC: Jonathan Corbet <corbet@lwn.net>, Ingo Molnar <mingo@kernel.org>, "Pawan
 Gupta" <pawan.kumar.gupta@linux.intel.com>, Daniel Sneddon
	<daniel.sneddon@linux.intel.com>, Kai Huang <kai.huang@intel.com>, "Sandipan
 Das" <sandipan.das@amd.com>, Breno Leitao <leitao@debian.org>, Rick Edgecombe
	<rick.p.edgecombe@intel.com>, Alexei Starovoitov <ast@kernel.org>, Hou Tao
	<houtao1@huawei.com>, Juergen Gross <jgross@suse.com>, Vegard Nossum
	<vegard.nossum@oracle.com>, Kees Cook <kees@kernel.org>, Eric Biggers
	<ebiggers@google.com>, Jason Gunthorpe <jgg@ziepe.ca>, "Masami Hiramatsu
 (Google)" <mhiramat@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
	Luis Chamberlain <mcgrof@kernel.org>, Yuntao Wang <ytcoode@gmail.com>,
	"Rasmus Villemoes" <linux@rasmusvillemoes.dk>, Christophe Leroy
	<christophe.leroy@csgroup.eu>, Tejun Heo <tj@kernel.org>, Changbin Du
	<changbin.du@huawei.com>, Huang Shijie <shijie@os.amperecomputing.com>,
	"Geert Uytterhoeven" <geert+renesas@glider.be>, Namhyung Kim
	<namhyung@kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-efi@vger.kernel.org>, <linux-mm@kvack.org>
References: <20250701095849.2360685-1-kirill.shutemov@linux.intel.com>
 <20250701095849.2360685-18-kirill.shutemov@linux.intel.com>
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20250701095849.2360685-18-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0126.namprd03.prod.outlook.com
 (2603:10b6:303:8c::11) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|PH7PR11MB8009:EE_
X-MS-Office365-Filtering-Correlation-Id: cc28b2c0-c973-4eca-09ec-08ddb8f4f550
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|921020|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YlpmQUJJQXBEVjBCdVBXNVpLVG5jOW9EOVY5SjN5V1BRRllTMFJPUFMyTHll?=
 =?utf-8?B?OFE2RnlDelpFNG9iTGNpVUl1QjltaXovelBZUWZPR1ZpNXgvd2tHTWp3VERD?=
 =?utf-8?B?QUV5WVgwQXc4YUtET1BaaHZudkJiQ1BKa1VMdmlkWDgyaE9vUWkxQnhHS0c2?=
 =?utf-8?B?elV5cjdBVUdETy9VMFV4V3R1eXhxN1BKZklzSWYzZFkvQmxOSTl2N1hPNFZI?=
 =?utf-8?B?Y0lGU2lockY5QVZFNytFeHhNWFlwektYSExRUkFxdVMxdXhaTkc2ZS9OaUsv?=
 =?utf-8?B?TnZJcVVHRVl2SFVHYW1pRzZ4eWZicVF5ak9qWDl5TjJUNWlUd2kzenJueHNw?=
 =?utf-8?B?WlJ5eE1SZmtoekpjWTI5VzZ0WEw2eDFPa1NRWTMrUXZselNmSG9WMHAwd01y?=
 =?utf-8?B?ZVZ2QmhKeFBFWjBaaW9BR1FvT3QwYkcyeHdEYmdwcUJkUkl5RDFPOUUvelBV?=
 =?utf-8?B?dFRRQ3BTUGVTQm5COVNUYVhOcGVoSUhRVEhLVjd3ZVB0eTNaR2FNQXpncmkv?=
 =?utf-8?B?ZmFuUDdUZnJqMW5rK3FBU0sralFBNkJTS2F1aEl6TXZrV2VXVnNML05BRFVa?=
 =?utf-8?B?NGJ3Mmh5dmFvcUJTSW5GejFGT2d1dkdjVHlCMWk4ZHBad0lib1duYlpIeUtn?=
 =?utf-8?B?aThOMzRBQ0dYL2RheFhkQU1jU2JxUWt2Z1JlMFZWS1kyYUg4MWQ3b1pIbVdy?=
 =?utf-8?B?SlNBMVRMVmk3MTdsWXVpTmZ5akVMVE45Tkw2S0xUcllrSFhzQ2FsZk53enNq?=
 =?utf-8?B?djFBT3JsV1BneFZ3dmZkZ3RqS1Z4SThPUnNoc211OXlnYkI5L01XRWgzSG16?=
 =?utf-8?B?UmpHVEZ6eXNPVFR4YURTRWVkWWlEY3RKaHgwb1FmNnZ2RVpubVNMcW40YUZV?=
 =?utf-8?B?SjRrejlVb3pra0txODJWYU5RR2dHNDJ1SmZCcEdwb3doYkh4K0JVYnVEK1Nj?=
 =?utf-8?B?MldZMHpFdFdvQXpqOWkrTzk5SmdRQmYxeUppc3Mwc3IrVlFBN0RucVFLVGUx?=
 =?utf-8?B?TmI3OXZEL0RiVURNUUZlVXFha3doY20rYkxKUklxSXRTb1lnK3RhWS9mVUJh?=
 =?utf-8?B?ZmQzWkNLbzdVbkcwek8vSURsNlhSalpsL05wYSs0dU93YXFnVU94Zkl6V1Fz?=
 =?utf-8?B?bDlROW9lRzVVenJDM2J3eHREamVITHRmZUZsRlFwQ0tyQUVlUG1nbUZkZ25S?=
 =?utf-8?B?TDF2QnZ0Sm5OWk51MzRJWmdCUzFaQXpYVEtKWEM4QWJLcUh5d1JYUGhsd3Qw?=
 =?utf-8?B?SzYvWVZHU0hmZTFxbjVBUEtId1dyazVHYnVIdWRNN1dOOUYwZDZORzNsTm9m?=
 =?utf-8?B?TnA0VVAzSTU1eFBSREIydEFydzJ0MVZ5bVI0eGVjc0RKWVlGd2pHUmVBOGd0?=
 =?utf-8?B?VnlCaTFzSTZUbU9XZG52MWltdGdlRE5HTUZDQzNvVmxrdWxxRW9XTlhxcENT?=
 =?utf-8?B?anBLSUpYeWJiUkF6dmZqQjRoM2dzSWoza2E3MElpUm0xSjVJS1VzSVFndXp5?=
 =?utf-8?B?VS90OWlIeUw5SW4zVzM3YjBSOGp3djhuY1VKelQ1Q281bDJKZ1YxaHQxUXhw?=
 =?utf-8?B?aFg2MUdUZkRtY3QvK0FDbGxYRDVqaTEzTHAyM1lTU2hlNGlZWE10Y1lCVmlO?=
 =?utf-8?B?TW42RW11QUp3Y1czM2QvL2JPTWdTZE9rV3lwSWFkSGJSclNSRWg2RGVEcitK?=
 =?utf-8?B?ODY1YnBHRzVXNEl3MEpiVFpRTmwvUVJ3Y2JMVldFOWcwblVXeXRWZW1JeEU0?=
 =?utf-8?B?VTB1T2o5TUtqbVNsd2l0QityTFhoRE90YjMxSkw1c1kzQ2ZJdmc1WWVjV3BV?=
 =?utf-8?B?MStQd2lwbDZHVFh3ZUYrWmEzemVMZDRSblVqQno1M2pkcm1RSUlaYnNpZm9a?=
 =?utf-8?B?blVIY0ZtVGtnc2VSYlJaSW8xV3lWTkNkOFpVeUp2dDJ0VHphajFhV1V1bWlT?=
 =?utf-8?Q?9pabHW3GZp4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cU1mLzRiZ1IwZkZLYnU0NEFUVjdpY0hnL3lrMjhCbjNjL2VoTFF0U0xQVTJ2?=
 =?utf-8?B?eEF6Z3R6bks1UjYwdFRrSGtaTmg0M2xiQ3pOY3MvVjkvL0VJcGZoYkpnVVJQ?=
 =?utf-8?B?bEJNZkxrcm9lKzJkZWEySE92a0RUbHBudG1yY1VtOFlWUmZ2MmkzTHVVMVhD?=
 =?utf-8?B?Z2lPVkpUUGM2SkhHVWI5cGxCN2tQQk5ITmowbXY0SDllV29kNlMrU2ZReDFH?=
 =?utf-8?B?MzBMb1VTVVNwUGFTUzJ6eDh0VEpwYTkzOWd2WGNLK0NMVWd4cit5c2cyRjRG?=
 =?utf-8?B?bTk1T25YQ085NVI2bDJ0Z2ljdlR1dXluUktOcU1DU2ZLYnJqU1dtMkZ5c3Er?=
 =?utf-8?B?ckhGeWt1Mm9pUjZqa1gybFlsSzdheGFWTUg0VmNlTW5ZemtVejh0RUNoSVBu?=
 =?utf-8?B?VFg4ZUR2bnBpSHpsSzlGd2R5WmtweXY4Q2pvckp3TlphVDk4cUxhbFNCNXBh?=
 =?utf-8?B?VzU1ZUw2clpYTVIwUk5aVmNBNzMyZmRValZCUFdIRUc4d0ZWYVRrZFhaL3NX?=
 =?utf-8?B?Y1VXVlBuU1o4T3RJQS9YdTA2ejNNc2RKWEszdWVkSjdYWklOZHNKeXRrNlpB?=
 =?utf-8?B?aWVpTS9HTjhpNG1KaG5VaDZUcERCaUY2SzhwZ2ZJb2lWZkQzNTM3ZStmUTQ5?=
 =?utf-8?B?aEU4cHo5Q2sxMWhSK2VxZDJPY3h5OU9DLzNBQ1NYVWtpOFNNR2lhUEtBbUxW?=
 =?utf-8?B?OWcyV0ZDR3VNZXV3Q1VPaENLdTQwcGZTbmZsZnJ4eFQxWlNaOE10WFNKcTho?=
 =?utf-8?B?aEExTE5KZDBrbUI2c1ArQ0xDWHprQ3BwNmFqU0twMm1Ta3AwaWJKQUo5SWNN?=
 =?utf-8?B?NHhtSkRiSjNvamxidDFhQXJPYWM2VHd5L210b3lVaEVkdUVSZmk1YVFFQ1p2?=
 =?utf-8?B?VldXWVpobStDbUljT214ak9IMzZDSWQ4Z3pacWlVRFkwUEd1WXNyWFpIWThQ?=
 =?utf-8?B?SjY2cjN2MC82U3FMeWtwMm5kOHplU3liRis0dzFFUm13TUFKcHNlT09Sd0lD?=
 =?utf-8?B?aGFsWHAxSHZ3aEZmVkppR2VvQWQxY1RwcnZ3SnBQcWtVNm1vZEQrUDlRSVpw?=
 =?utf-8?B?cFZnRUkvY0ZIZTh3U2ZmaDhuekVoWCt2Nm5WUWR1dHVFeWJBMStTbUZ4c2cw?=
 =?utf-8?B?dVA3dHV1L0V5VVlYQnJpSFV6WEhHQll3QWlVQy9Ka1BsbElHemtleE5hV1dM?=
 =?utf-8?B?bmxHSWFXMHJqbDlmTFpYNVRQZUYzZ2RnTjJSUFhFbjQ1cUhkMEo1QzhENVFx?=
 =?utf-8?B?Y3ZhZEN1UmUvYVVUUzY5TU5oM0hkenY4Y2QrQXd1YXBSNEV2S0RJeWU3NzRu?=
 =?utf-8?B?YjFZS0lBUFFkem84d2xEV3Fod0hQbXRCNExMUS9IMGVubUtydTRPeEMxU1pM?=
 =?utf-8?B?cnNtVHdzK2tNbzFCSUkzYnVQK3FMdFVtaVl0U2FQZjZYaGJrck1hUXdMUGZ2?=
 =?utf-8?B?eHE3YUJGZGI3NGdOR3M4WWpEOWllRVAvYWZ0NkxpeStzVWtLa05MMi9TdXZO?=
 =?utf-8?B?NnhUUGQ2Q2ltdEkxRFdLdUlOUVJZNUdXRGdpYW52L2JHeElmVU5KdGk1dXl2?=
 =?utf-8?B?eHVyYUN6dHV1dDFYS0dDVHRGR3IvNzJCUlF3OG5YeElWTjNtS0t3elcycXJW?=
 =?utf-8?B?YlFtZlIySzV6MXJCT2RrZDZUZXVFZjgvYW1MeUlEc2s0dFM1bzJVOW5CRFhv?=
 =?utf-8?B?T2pXOTRGR1FlU2RZQmtGUTFwWXN6Y0tkSjQ1S2tUeWNZQ1hjV2cvOGdxNnZN?=
 =?utf-8?B?ZTE0YlUrTHNKR0hzZ0FkMHFINllxcVBndEhqcHp1eEgxd3lxQVk2dkdGZW42?=
 =?utf-8?B?aDZQMjUvRXA2R0RWMmVnMTBTSGxYVCtSanZCb0hzRUZWZ0JBY2xHYW40Nko4?=
 =?utf-8?B?bmZ6WmY3MGUxS0dyQnR1WUxmV0pYb2dsYkdoVWtxOHY3bld6SUhWRW1QNnVV?=
 =?utf-8?B?NThSYnpialo3TVZjR28zZmVSbVQyZTV4TGtCNVZidnJpWkx0Y1Q1YzE3MmY3?=
 =?utf-8?B?dEdnSXIvWnNCaTIyQnlmaW9kQklERWQ0TGJBMHlmMDdTSlMwRTFqOWlxeUVj?=
 =?utf-8?B?SzRGeWYvd21ya3VqVEc3WkZXT1Z1UlpwQUFXNGxjeWY0TXpONnp3QW8xcVRV?=
 =?utf-8?Q?vu8Vaej4d/1YoIKqKSsUMr0yv?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cc28b2c0-c973-4eca-09ec-08ddb8f4f550
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 23:14:03.8165
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eE2HmMrK6pBONKlpqYvWMBuJKVhNpqdMUC247tTCeIIagHPWYgo+IMLmpKqYpQJMzbqO/yPYoksJTHGYg91lMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8009
X-OriginatorOrg: intel.com

On 7/1/2025 2:58 AM, Kirill A. Shutemov wrote:
> This reverts commit 3267cb6d3a174ff83d6287dcd5b0047bbd912452.
> 

This patch isn't truly a revert. This line can be skipped since the
additional changes going in are more than the reverted single line.

> LASS mitigates the Spectre based on LAM (SLAM) [1] and the previous
> commit made LAM depend on LASS, so we no longer need to disable LAM at
> compile time, so revert the commit that disables LAM.

Also, wording such as previous commit should be avoided since it can be
misleading. For example, in this series "the previous commit" is
enabling LASS. The commit before that adds the actual dependency between
LAM and LASS.

Other than that, the code changes look good to me.

Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>

> 
> Adjust USER_PTR_MAX if LAM enabled, allowing tag bits to be set for
> userspace pointers. The value for the constant is defined in a way to
> avoid overflow compiler warning on 32-bit config.
> 
> [1] https://download.vusec.net/papers/slam_sp24.pdf
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> ---
>  arch/x86/Kconfig             | 1 -
>  arch/x86/kernel/cpu/common.c | 5 +----
>  2 files changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 71019b3b54ea..2b48e916b754 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -2181,7 +2181,6 @@ config RANDOMIZE_MEMORY_PHYSICAL_PADDING
>  config ADDRESS_MASKING
>  	bool "Linear Address Masking support"
>  	depends on X86_64
> -	depends on COMPILE_TEST || !CPU_MITIGATIONS # wait for LASS
>  	help
>  	  Linear Address Masking (LAM) modifies the checking that is applied
>  	  to 64-bit linear addresses, allowing software to use of the
> diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
> index 97a228f917a9..6f2ae9e702bc 100644
> --- a/arch/x86/kernel/cpu/common.c
> +++ b/arch/x86/kernel/cpu/common.c
> @@ -2558,11 +2558,8 @@ void __init arch_cpu_finalize_init(void)
>  	if (IS_ENABLED(CONFIG_X86_64)) {
>  		unsigned long USER_PTR_MAX = TASK_SIZE_MAX;
>  
> -		/*
> -		 * Enable this when LAM is gated on LASS support
>  		if (cpu_feature_enabled(X86_FEATURE_LAM))
> -			USER_PTR_MAX = (1ul << 63) - PAGE_SIZE;
> -		 */
> +			USER_PTR_MAX = (-1UL >> 1) & PAGE_MASK;
>  		runtime_const_init(ptr, USER_PTR_MAX);
>  
>  		/*


