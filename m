Return-Path: <linux-efi+bounces-4072-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1203AF0345
	for <lists+linux-efi@lfdr.de>; Tue,  1 Jul 2025 21:03:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CAC01C05D71
	for <lists+linux-efi@lfdr.de>; Tue,  1 Jul 2025 19:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6528426E6FE;
	Tue,  1 Jul 2025 19:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P/lixTjA"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5123F192D83;
	Tue,  1 Jul 2025 19:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751396611; cv=fail; b=fndypN79ZJ5HGjCoKN2spoY2bY1sLR0jKbhgxEXIiKLHGvY0+tj7oB6L+J0a+djbt+Nuxs9xkVgZewY9DdjQ/Bzv3ANJLklL3tWUu2a5RKbMUwo3/71814tYP8iIBlDGzLKuYqRlqkeIXColDbAqfB9kNAiGoOtQwLV0EWJxu8o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751396611; c=relaxed/simple;
	bh=SFA/YN0+smbXjNR8cK4mXHAWO8PEN3hPiDlHfRUGHgo=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Zyq+Rek71tMtQ4J7+U0JDzUQe7hVRr7qr+JYJnwNToXPMpaqK1gFXbBvSV4wntt4gaL+4w30sGkb6VEiTMxm+8eWJuZSadK8pp67MXgd3R1T9aV4BbQOuXSqmlXl3W4VE+XdphCvqqci3FBnz0ylJ79ntfFqdm5xgfVtmgTTwaY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P/lixTjA; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751396609; x=1782932609;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=SFA/YN0+smbXjNR8cK4mXHAWO8PEN3hPiDlHfRUGHgo=;
  b=P/lixTjA9a1lf8An2uVZZ+T695x0pPxS2wwsEBw1wJiXk/36NJTUviQi
   umuoszwsgy8rNQSpczQzPoCtJc8OkWcup1zIk+nR/2CqzUCrSRoiCRIEq
   vYdjuYltSkrHU2wmFYtmIBZaAe4G0GsYdXK1+zdJajW5lsLnpUXmfBhYf
   QQpx5QXW9vZyvPYmat0B9cWp28EAjNLjOYcULWHhgeILQupyTXRPm4iyY
   PrAVJTw0X5wWTOQRpjjjEIYKJZw0YxRWEK333I/tpk3+xFl1temfu6Eqi
   qvICsLgRGXEzmPeDgNxVaTyv+DlBa5hspD9qAwGOMkvEe2skuRPoo4QL0
   Q==;
X-CSE-ConnectionGUID: vELyXqJlTWG/+gqh9SBr4w==
X-CSE-MsgGUID: IwfHAfhyRn2Uf09CNtUniw==
X-IronPort-AV: E=McAfee;i="6800,10657,11481"; a="79119646"
X-IronPort-AV: E=Sophos;i="6.16,279,1744095600"; 
   d="scan'208";a="79119646"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2025 12:03:28 -0700
X-CSE-ConnectionGUID: /nFSkKVTSUyJeKla8kJdVw==
X-CSE-MsgGUID: exq7SGgOSsG5t53o2LCnSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,279,1744095600"; 
   d="scan'208";a="184901313"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2025 12:03:28 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 1 Jul 2025 12:03:27 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 1 Jul 2025 12:03:27 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.54) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 1 Jul 2025 12:03:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iM+Ec1DKHuOeD+BUvkyog3CFfelDFK+UZB+zyFUzLcNtHKXCS+DgiVbe/nwoX4U6Sb6qw5rXUJMH1lnNwVU1GHyZqwErEGMvYfhzH+l1ZSnls1eHUyLaTVnwN/hKX0MAhx/pTO6+RyktyPONy20jxPP6wkLlydMrOFQeK23iJCmTyAB9m2yVV0nrlU+S3TyPrmtVs3uJMqhKyzP5hdkHLMc9uJbSC9bCZV6qOzamqNdq+GZHTj8UOPBda94KYvgDLh0CK04+7YrpK7DiGSjSA+kIjl2KpQLvFU3qp5U/nuJ7IScIWYJqoGOhqoLhaqanbw7M6Rp8P8K9xyHx7CcCag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S3yvGP4jti16ARHbiiPVSRSKeprallAxIg/rHaBC4Ik=;
 b=Ceb74NwEZUCYcgBS1v9u/fh7v4VgSisNO27r65XUmPljGIMry1EAi9kMefIRxDAAluYqkDRLMrr5uwbdLAPPqI7difWuMB9MPlbVIiYFouvHiFZpCsRDL3QmPiGv4NK/idTaxwS2HfyzHjU1jT9FPnJ2Xp+NK60WJ79Y/pPyYO/ldJtCRzTR7PYlGclkRa285qCrmCiq8e3NeXwcngYAxWdBW7+P4Mg3rbBfhk7w3aywnC67Z+Uxgl+w9yAA93zJXZyllXGqynWscvsrKBGyphAtc3L3bLh9QVBjkKCw1P9SP0j1vrzVKxFE28i05JZaGSSwT0wM6NtQa3MbP2Adhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by DM3PR11MB8733.namprd11.prod.outlook.com (2603:10b6:0:40::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8857.25; Tue, 1 Jul 2025 19:03:04 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b%4]) with mapi id 15.20.8880.027; Tue, 1 Jul 2025
 19:03:03 +0000
Message-ID: <080df169-0f47-40ea-b7b3-4d1a35bee151@intel.com>
Date: Tue, 1 Jul 2025 12:03:01 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv8 04/17] x86/cpu: Defer CR pinning setup until after EFI
 initialization
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
 <20250701095849.2360685-5-kirill.shutemov@linux.intel.com>
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20250701095849.2360685-5-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0351.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::26) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|DM3PR11MB8733:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ca6ffd6-3dc6-4a9c-c2d7-08ddb8d1e80a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014|7053199007|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NSs4eUVpNDZxYThyTERUb1MxR3hjOThEUm53eWcwUFk5NFcydW15Nk9odlpQ?=
 =?utf-8?B?V3ZyeHcwMEZQb0s0cnV2MHNBWFBXNmx6TE01NHNlQUhuU2Q5ZkRYNkJ4aXgy?=
 =?utf-8?B?bnZuczdEYytQRjNxM2lhT3FiMzIrb1dUUzlObzlZU1JSMVRvQ09RemJFbWhh?=
 =?utf-8?B?VWJLa0Evemt1T3JxaUc4UU03dHpSY3h2M1VqNjB3S3FQYVkyVDZ3Ykl0VWQr?=
 =?utf-8?B?b2g4Rk5LL1N6ZDF4YXB4QllYV1YwWldoSnhQQVJVTFhYQ1hhL1huRmd6SVBG?=
 =?utf-8?B?LzQwc1l6MHhqREhmK0VJQjhSMk0zUW05Z2J1azF1MEtKRlJGa3QxSnMxd2VM?=
 =?utf-8?B?cmdvVzE0NEJDcU1xeExwY294ZGw3TGV3c3AyWGJvaGhlOE1xL1p5NnFHbEVu?=
 =?utf-8?B?aGtHbitzVU14QXVIUkpsNkx2TVVWaXZZUU1OUmNuUGxrMHZDbXdYYzhDOGlW?=
 =?utf-8?B?L1g5Zmt2bGhzV1lLWGczQ2E4bU9yZ21tOFg2WkMvNjNqYTdjb2tOc3gxZ0VR?=
 =?utf-8?B?Wnd1U0NuYSsrWGhaeVhqNWZ1SUFYdkFoQlZibWxWRlZXQVB0ajBKV2taYks3?=
 =?utf-8?B?Ny9ibm5PQ1pnMlBSbjVjZmU1Nm42Zmp2QTNrY0JWL0Q1R1BKWE9DU1JkYTVJ?=
 =?utf-8?B?YkRPVGZBeEpFMXdBNDduL3BZTDlYRmNzdytjcUNLc3ZMdmwrWUlKSjZKVExz?=
 =?utf-8?B?ZHJweWMvOFEvQk9ReTlRZ0lxMWVXdXdhR0g4VWRIZmRYaHQxZmJiS3YyTDcr?=
 =?utf-8?B?MHlMbmpVbC9yY2ZyR2hJeTFKWXNPYzI4ZXBNMFd5T2ppTkZiM2hKdTBTRUpH?=
 =?utf-8?B?UkRpbXkvbmpBZ3Y5eFRPRkdSQndHQngxbUFKQzc5aHdVZkVZc3dlMmJMelVw?=
 =?utf-8?B?b0tpdHdlVlg1RVJHWXoyY1M0MVZWcGlnWmJISHhIdHVVV0ZFYjZERXpFc09j?=
 =?utf-8?B?alI4dDBNNVFRRm1ueENPYXViZWo1MkNYdjh4bk9xNlcwclZVUmdMUVcxWnMw?=
 =?utf-8?B?Sko0MXJ3UXhEaFZHRW5xNkt0dmZ5T0t6VW9XNlJaVU9FNzNacFZuWDIrOEtt?=
 =?utf-8?B?cUJsb3pqQzdMMjVsMFliNjRxcG8vb1hENXZLY3pxOStoWmFySy9wYmNnUk4x?=
 =?utf-8?B?UUdETWUrMGJVYjE3TDU0NndtdjNXUkdkcjc5TlRETUowQlJaYStPekgza2Za?=
 =?utf-8?B?RFhPYllEcGtqZWhlMzlpMVpJemJFTVl4RDk1TXJXUXUvcFV0R3V6YVB0Qjdx?=
 =?utf-8?B?alMydXdLTitxZW1DN01oVlVoTE1UdytaTWtVSEF0cVJOUlZiTGlQSWJxaTF0?=
 =?utf-8?B?b0FJZEhKbnFZZ0NGa0dsS2NjMmxEUWxwTVRiVnpMMnZYOFdjNWp5OEVFaGhV?=
 =?utf-8?B?RVZoTk9iYUJGa1VrV2N3TGxZZmtVa3hIMDZyMHNTYjlnazhPUGJtd1N6TDE4?=
 =?utf-8?B?VkVaK1pkbWtZdC95MDBSb09MK2tJMGg4ZmNQejd1SE9VWkJIWkVIOTAxUUxz?=
 =?utf-8?B?bW5GSmZZc2dyV25LL2lZY0VpVkh2RmwxN1dCV2laeDBBQksvYUpTMHRva2RT?=
 =?utf-8?B?VnN5NUF3aXJUMGQ3eFhiSjUzNXBKTEVPRE5DZExOekFzQU1UVWlaTkNuMzdk?=
 =?utf-8?B?SlorbVNyTjR1NVFkN3U0ZkVMUElkKytnMlUxTmxqeUMwZ2lnQ0tlRG1vSlVr?=
 =?utf-8?B?cTRLQkZGUlZJNjkwWitiS3dxdDU1aFJmTkN2ZkxUSGVMcy9RczAvVzhpbWFq?=
 =?utf-8?B?NGJtdWUzR1AyWFJHdWNLZjM3TGphcVN3ZnFvVmlEZC9WWWZXM1pyeTFkcUwx?=
 =?utf-8?B?bzVUbE5XY2NqSGZ6N3FTM1dMdkF2Y25kUHV5UWkvbEFnNmR6OTVmRGVGbFV4?=
 =?utf-8?B?MG5zZDhzTWJKVHdYcmpxREVTMTJucmlDM3Q1WERldUNXVDV1VHF0ZEFlK2xR?=
 =?utf-8?B?ZzF1Slp5ZVpDWHFEdUhKajBWVkdONlJ5dzFwZ1RuSHJkbGhiS3p4M3I0Qk9i?=
 =?utf-8?B?VkdNeHRiK3BnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eHJVazhKMUZNZk92cUh1UXV4YStGU2Y2akhtbDdjUENMSEpYTHAxYkd4Ulo5?=
 =?utf-8?B?WGFrQjFmbG96RGNVcjVMRXg4bDNscllhN3VtU1dCWCtuUkVnMm5pR2JodVFh?=
 =?utf-8?B?U0JIZkJMT2xuRHpDNGtSMit0UWt2ZzZjM0cwWlFSV2NCWm5qZUcxU05rNE9n?=
 =?utf-8?B?dFZlR2FhL3VWMEowRlUvT2Q0MUUxeVdXdU9TRktvSzBHK0U4L3BXa2FjQUZa?=
 =?utf-8?B?ZVhCTDdiY04zYThjMHA4SmdUM3loOGhsRlM5VjNlWmc2MHZXTkhHVlIrVHRS?=
 =?utf-8?B?Umx5N0RaQzBoQThHejBrRytZYnVjeVNpNjh3eHZONm5KakhYd3dlNGdtdEdI?=
 =?utf-8?B?OFErZUdxMmwwc05SOTRsdi81dmVnckJPTGZ2ZnhCMmRNcXQ5MWJnZ0RZSzkz?=
 =?utf-8?B?QzN6a3lmNUFUWTJhS21heDg3NWlyTGc5YW1pUEQ1VkR1eVV1QU5vemxvVXht?=
 =?utf-8?B?ejhGR1RYMytueitCTlgxSHpTZXdyQXlvRmo0SWZ0WWJhVVRNQUJ5RzZWbXJn?=
 =?utf-8?B?WEloZjU0OGl2WmNrOHBVZXAvSWE0bG9DcXVLQTVuOFZXekw2dWxXaGY0dlNk?=
 =?utf-8?B?T1hkUVc3bjJTMkRKWEdPaHFjdnFNd3ByeUVUKzRIaHpLMUxua3hoMUNYY0hJ?=
 =?utf-8?B?TFJSNTNTMjg4Ly8ybE9UQlNhemt0K3BEb1pXeURhYWZFQWFod1RtSU01WE5O?=
 =?utf-8?B?UFpPZ3hSVVZsQldRQWo3OHkyRy9iRzVHSFRWWHBjNStEVU81RGY3QVhldlhO?=
 =?utf-8?B?bzlIMTlRYktTeFI0Wm51ZG9uZlJRY21yeWJkcjYzVGM1VGZMNGIxQmtkeFdK?=
 =?utf-8?B?M2dFekpPOFcrSmR5SXlDVk12WGdpUzVhbVlDZklGOFMwS0U3ZGdZSUQrQWFm?=
 =?utf-8?B?ZG80Rm9pOFprMDF4WSs0T0h5cmVZZXNXL1V6alRMVkZyMEhGelJqNVdTVUdJ?=
 =?utf-8?B?K1pDR0F3b3RMeit0L0hiQUp1TnJjWHpRTGVuSm5rcmVFdFN4Q28wWisyekQv?=
 =?utf-8?B?UVpUcFdWaVhJTXZBbjU2dk1VWkdYbkVIRWlFUDAwak13dVE5dEd5eHRJQW0v?=
 =?utf-8?B?NVYwdUcyV1c1YWcyQ2MybitKMVo0c01FS0IvQ3JpWTdHcTgyL1Z2UU81cXhT?=
 =?utf-8?B?NnN3c3VQUDFUbmVlb25tRnFpbWFPZjZxY2ZJbzlBNkxIN0ZKUTFEZzVxMmcz?=
 =?utf-8?B?ellCdEk0ZklvVlVGR0Y5NGdOOUNXTVdIR0p5SElYQ1BBMXVSRGljZGNvb0VH?=
 =?utf-8?B?TVd1SEl1bkJtcFlzMU4rem1Nd2w0UFJlQVcxR0tDaWVGYlUrdFVyaU1jUi84?=
 =?utf-8?B?MmZBR256Wkw0TTFETnU5eDJZb3Z1Z1pjZ05Ed1c4Lyt6QnZlLzdZZ3pWaGxm?=
 =?utf-8?B?VGZiRHlUcUhjMWNiS3VvajZpTldMUkcwNDNpWFZrSTh4Z0c5UEZma3hHK0dG?=
 =?utf-8?B?ZTFBSEVBM0djOUJtYU0xVXZlS1ppNXprcEVsdXI4dGk5cm9XZEV4L2lUaHB4?=
 =?utf-8?B?c0tzWkVtc1JsRHFIcXdlZUdNWldMdzNIT1BlYXBzeTNxT2R0MUVJWk45MldO?=
 =?utf-8?B?eXdDa3RkQ0JtMXdJM1hLc2RBd1FiR01kWUZCcjUvRTM0UStxUlovdktTUk1u?=
 =?utf-8?B?eVh6QitaODJqVjBGKzVhdmR0aUo1aGZEV3FpVllpQjJYcG0yWGJSaUNpdHBC?=
 =?utf-8?B?UTg2ai93UXc4bGFHeW9BT1owZWNRaktNbElBZkd3c3Q5bDlDUzJwbFFpVlRk?=
 =?utf-8?B?UnZib0JKKzk1WUd2VVBVSWFOWGxHR0VFbUd6OVhLSERGNVNhYlltNDlTMmVy?=
 =?utf-8?B?blljb1g3U2xhYUI2dXZOL3JQd1lSM1JidFlodEM0TXBoZWR6U1JrNjkrczJq?=
 =?utf-8?B?R0RaSzJWK09sdDdwb3ludmtTN3RMRWhoUG5WVGhHZ3U4dytZQ3JiakZXVUYz?=
 =?utf-8?B?R0Q2aGMwTXRkV1gvcjNWZVJZUmkxRWpHaHExSkluOERVR1dFVXFsZEsxNTBu?=
 =?utf-8?B?UzRVdlZHckFmWjdtR3FiNnhrelhGK09zS2lKcExURzJvUlB2OENORnBlcm5s?=
 =?utf-8?B?QjczWTM1S1FpRGZqZ0tmQWNDY2dGU3Z6cWdGNDJIakFHSk94S09PM1lPQXdK?=
 =?utf-8?Q?hMcJmCoZMyfNTC2bxtR3xKiqr?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ca6ffd6-3dc6-4a9c-c2d7-08ddb8d1e80a
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 19:03:03.8437
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tn5Ct3b0VGydlGe9bhripL/iOI+MI7y5CF8RnmdUBigjU//urSHFx/esHzp4Mh4/2Q3mBqdgYYaiLKzOKBz15Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR11MB8733
X-OriginatorOrg: intel.com

On 7/1/2025 2:58 AM, Kirill A. Shutemov wrote:
> From: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> 
> In order to map the EFI runtime services, set_virtual_address_map()
> needs to be called, which resides in the lower half of the address
> space. This means that LASS needs to be temporarily disabled around
> this call. This can only be done before the CR pinning is set up.
> 
> Move CR pinning setup behind the EFI initialization.
> 
> Wrapping efi_enter_virtual_mode() into lass_disable/enable_enforcement()

I believe this should be lass_stac()/clac() since we reverted to the
original naming.

> is not enough because AC flag gates data accesses, but not instruction
> fetch. Clearing the CR4 bit is required.
> 
> Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Suggested-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> ---
>  arch/x86/kernel/cpu/common.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
> index 4f430be285de..9918121e0adc 100644
> --- a/arch/x86/kernel/cpu/common.c
> +++ b/arch/x86/kernel/cpu/common.c
> @@ -2081,7 +2081,6 @@ static __init void identify_boot_cpu(void)
>  	enable_sep_cpu();
>  #endif
>  	cpu_detect_tlb(&boot_cpu_data);
> -	setup_cr_pinning();
>  
>  	tsx_init();
>  	tdx_init();
> @@ -2532,10 +2531,14 @@ void __init arch_cpu_finalize_init(void)
>  
>  	/*
>  	 * This needs to follow the FPU initializtion, since EFI depends on it.
> +	 *
> +	 * EFI twiddles CR4.LASS. Do it before CR pinning.
>  	 */
>  	if (efi_enabled(EFI_RUNTIME_SERVICES))
>  		efi_enter_virtual_mode();
>  
> +	setup_cr_pinning();
> +

Instead of EFI toggling CR4.LASS, why not defer the first LASS
activation itself?

i.e.

	if (efi_enabled(EFI_RUNTIME_SERVICES))
		efi_enter_virtual_mode();

	setup_lass();

	setup_cr_pinning();


This way, we can avoid the following patch (#5) altogether.

