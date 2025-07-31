Return-Path: <linux-efi+bounces-4500-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 802F2B17A2B
	for <lists+linux-efi@lfdr.de>; Fri,  1 Aug 2025 01:45:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3316F62533D
	for <lists+linux-efi@lfdr.de>; Thu, 31 Jul 2025 23:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C30928A3EF;
	Thu, 31 Jul 2025 23:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H2aZVeYC"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 717D228A1F9;
	Thu, 31 Jul 2025 23:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754005525; cv=fail; b=SGnuXF5TArJZUZtOFGJY/hMGU4vItrMFk/Xw0+H/+WjhVDwsveDVljosmAzp3A5gRkvTkJYFLzss9n83odnWBQK1PyXtq9XtUmevq+tLGihkABcvqmKMzriAt+UBRT6kH5PekTLjd89bsjPsnu0uq600Llsc9RVA/+kZeD8B7Gk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754005525; c=relaxed/simple;
	bh=eYWGnZmvATUBz90oGZfSzf+FaWVy8oUlG3MBs1RbuW4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Wt9wIzGKc0BsKDRD0blGFzVzmhgksJTpSCuBa41d4uYaEKqqbdTNlJLTUSR6UYBfD+9vjZxdwI3lTsjkf3m7nzRU11hdD5ZfD0zrAZ7sB75GdlBvZhC5lUjYfmgfQ4pQyCGfmsuSmXMiMg2N1XGOW+UXIxuAGSc47/+RvsDhApE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H2aZVeYC; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754005523; x=1785541523;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=eYWGnZmvATUBz90oGZfSzf+FaWVy8oUlG3MBs1RbuW4=;
  b=H2aZVeYCJV9dSxx5A8iC9Jvfiq4rmE5TqVQ1X1BRgnfTW7Ra3+5hEBGW
   iY0svkqnsqivUbUtDDngql9JNI2hZxpur0Yzy+hcpURccEDSE5QL+YSbT
   RhmR9qdIDu0hFiAzUUokfbzFyvuk4f7owk1jloUXbGI40UX/oWaN0EcvO
   hdGoRlZ89uhrMksRA39YL4ryOFQ6my7q+urF29UqfaPDenogK5Rc3K1tO
   ETSUninzqQs3/5B64GlM6bhlOO/y8YvEZLc0BKnX7BwMEUuX+JXRBF+YV
   n2S4xt/rDxCrZehWasWGRioo8rXE1Si4yuHX8A3BDYUFiEX+Dz7CEYIdU
   g==;
X-CSE-ConnectionGUID: qYSgH0xSQMyBBSNVFFe5hw==
X-CSE-MsgGUID: 44l6jaR7Sm6kQwhKqnAoag==
X-IronPort-AV: E=McAfee;i="6800,10657,11508"; a="60174329"
X-IronPort-AV: E=Sophos;i="6.17,255,1747724400"; 
   d="scan'208";a="60174329"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2025 16:45:22 -0700
X-CSE-ConnectionGUID: jaREoA4nTrKi2W7cHVR9zQ==
X-CSE-MsgGUID: t8tqJ3r8SLul09Z/vXJL2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,255,1747724400"; 
   d="scan'208";a="167572837"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2025 16:45:21 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 31 Jul 2025 16:45:20 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Thu, 31 Jul 2025 16:45:20 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.43) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 31 Jul 2025 16:45:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YYbPxX7+qsW5m4G8zB2gBtOerKQ3cIRTdBrJlWIy5YIsDrje4PdWpaYjpKqdyVhFQ7jBBsgnCdr00S3iNO5/s3ROuEFwafTQfYlKsIYJvalYNiiTDJllyqzcNr1f0P8aI5k8RN6Eg3QU0Sud1KQqcv2D+wwIRvZPo0Mc/hL64civbMPZLMx21Az00jP3uEfN4+7bW9e9qR5zvq2QjBjfnsH/dcvfoU4uBV4R78R3Mqa0TH4BC8eofcFH6/Z8zRVGltrHN03ratwkdRKno9rMcC7AiWviGmK7MzFopz7edzDdZgHjK/1xwCjaMHLPNuysdKilMCqvaWlRfAlu49lo5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BmIGVEayR2fUH9l3KIpv3IE7Ik4ugOM8SrO22J/WmcI=;
 b=r+kboEls3B+o0faEEbaClXu24c3LGRJ1o37ad+GOxLQGALQbyylYcPsmPfbi7WA7LFG4a/TnakTjwD+zPECo3yGbVGMaV3pr9kRpYXmYwJTL7dSWzx+S/YPnbhw15GShDuSE9aDY0s8jBElWpoA4NahkB9JFFiObTJLf7Q+i99ZziZW+l63ZEVpJK8kkyDYKm45l8IgiQkx54C5ron8zQjBNSXwqUjdhlj7IRoTSVH/tlCjdvUERpWcSRBhmmIEbcnt6MIhRz0PhFFB7KrhYZSRu8QgRkRVeYV5JvprdgUH8Tja8onxqpzOFsAByO849mNBz30TjIl9oYaEnTD/Ssg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by PH7PR11MB6425.namprd11.prod.outlook.com (2603:10b6:510:1f7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Thu, 31 Jul
 2025 23:45:18 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b%7]) with mapi id 15.20.8964.026; Thu, 31 Jul 2025
 23:45:18 +0000
Message-ID: <98a7a91b-3b46-4407-82a7-5f80443b7e00@intel.com>
Date: Thu, 31 Jul 2025 16:45:15 -0700
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
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <6075af69-299f-43d2-a3c8-353a2a3b7ee7@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0208.namprd05.prod.outlook.com
 (2603:10b6:a03:330::33) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|PH7PR11MB6425:EE_
X-MS-Office365-Filtering-Correlation-Id: 176965c7-a3e6-41c7-0c39-08ddd08c4dff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NlJEaXBzTk1JSHpTSnVDU01kc2t2dHdzMjlhNXpFY2hIVThSZFhRT0cwd2VX?=
 =?utf-8?B?czlzem8ybSt0cmFST3pxM2hWK09RK1hqSnlzUk4rcHhSYmJoWmNFYVdnekI3?=
 =?utf-8?B?cGczZkdlSTdnZjRaTkg0SVlZdnhncnBibExjZkF2SnQwT2lJK0tBRERpUkdN?=
 =?utf-8?B?L2ZSTVU1U2pGRWU2MkhoTEJCSStTZzhUb0JwY3RuT0wrekFVWVNuRVhrRHpy?=
 =?utf-8?B?Vm93QzErb0I0bVpWM0xiZHo4cE53dlg1dzRUS1dpNDA0eTVPWWNXNDFJWlJw?=
 =?utf-8?B?U1RyNERpZkFHWDVncmMxQkZ3MDcybEpweDdKT1ZHNng1bnpzVzBYNkpPYmpx?=
 =?utf-8?B?SnBLTXlFTkFETkpzdWZXOCtMblZqbXo1aWxhZEJZekZwS2FCczlHbDByUGkw?=
 =?utf-8?B?NGhxR1lLeXBJaU9VYVNRYUtpNDczdytTODdlOFY0VkNNb2xuaG1sd2tRQVFv?=
 =?utf-8?B?MTc0UnJEOEpLNjdCbGU5dFp5aExzMzhZT294Q0o4RVorVzFIZkdRako0N0Fp?=
 =?utf-8?B?ZVQwelFkakEraGk5N3JyeTkzeGVJZWZzdmZlVW9tN3JPcEtTRWVjSHJieUVo?=
 =?utf-8?B?Wi9IaitmTVVSSjZFZ000WVB4YXZiSVd0QnlGYVlZdC9VQ2x6TXR0eVREUjdh?=
 =?utf-8?B?NmNTdU1nMUJyZlZsK3krMHJZVy9Qc0hndjV0eFM0VWhTY2oyZzhIUjZhMVRj?=
 =?utf-8?B?RTZ4cmpoa2txdUdPaHEzK1RPQURWWUJPRmNoNDY2SW41Y0VOejRtQmxtaTNP?=
 =?utf-8?B?cjNneVhJNGhDOHg5clZmbjFwdnM4b1JIK2JmWjNEZkdiZVBmM0JPWGNIcE5S?=
 =?utf-8?B?SFJFQ3grbUNNRzRldTA5TXlVNVpmYzYwTGNGeERURkE5RmtLQ1ZCSXVyYXE3?=
 =?utf-8?B?SFVaSnhrTHhlZVlEWEZaTHJzZHNqMnNWam1LK2tWYUtMTEIxSmlkelRaMWts?=
 =?utf-8?B?M3h4Yjk0YXZWU1hiRWhmZHh5ZnNjWERsTnRVU3N4amRGUW51TmtmTlE2elhL?=
 =?utf-8?B?bktkWTRBekZnSDkwY3JmQW5hSVJmT3VHeDI3WitLbXBhMWNlelhnZTZNTndm?=
 =?utf-8?B?S0FPOTRkYzZCc3EvWU9odjVSTUVUY0lHOTBKL3lDSGYwa1hJa2VCekUweXpr?=
 =?utf-8?B?clR2emN3VDk4bjlBcmZMTVlFdTBjREtXdndHNmhqWDdSbDNGaHNNMXMzS1ZH?=
 =?utf-8?B?Y3pSK1FVdlNGSVI2NXJtbVNjRzZBcUpkT0x5RFZ2N21qd2d3NjJQOW1OeTRR?=
 =?utf-8?B?YmhsRk9yK0Rab0E5dXlGOWIvTkNGdDRQd1kzNEZYRXg0dk8wWk9heDFOQWNi?=
 =?utf-8?B?cGZkNGFSNUhlMXdRcmVPcFNnbXhvd0hoSFVReng2OXFJUEhRZEhFQjNISURt?=
 =?utf-8?B?RzhkVS9WQUV4RFBOQXhwWm82anlvOE9obXB3Tkp1MERPL2ZLRUU3Tk9RSmQz?=
 =?utf-8?B?Zys3R2l1a1NDOVRQTTBNZjBUOXRmbFB2akgxdHA3S3k2M3JRcy9LNXdvVUNh?=
 =?utf-8?B?bnRkL2VpVjRNSWdrd0dmN0NiU3NEMXV2WStoN2lZT3dBbHloRWNWY2VHZ3lL?=
 =?utf-8?B?OWtTQTNPQ1dXc1RXZ0pzenNDNUV3YndVUHZQQzlXbTRjWWtWMS9uQTF2eUFZ?=
 =?utf-8?B?MEhMalNuanJpVlFSNW0zQzZ5MjJnRmQ4RjBhN2lVeGtZeWM4Q3hqN0JCQVdu?=
 =?utf-8?B?M0JtTGtSNFpMcVRxekMxSEVkQ2tZVHJpcTdXS05MSFlRL2FPdEhxQWJscU1p?=
 =?utf-8?B?MEc3RCt4aGFuR2I1OTkzQUxVd2t4cWw5SEhMYzA3azZ0ZkptU3hhZWFhblE1?=
 =?utf-8?B?eGxCOE94aUhIN0FhcnNkK1ZQZFVYdjcyekVTc0U3UWVNS1pDRjE1MzNPc2hF?=
 =?utf-8?B?RTdrR0p0WU9mVjQ2MjVMbUVNRVV5VTZZa2REVHN1SEttTWJ4SE1PeTZBOHdL?=
 =?utf-8?Q?YTVI0bwLw4U=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VlhJcXJBYTFSbG1VQnNXbmRXWENuNjdnbmR0Y21zdFNhODkxWFMvd2ZHNjVK?=
 =?utf-8?B?SWcvNnVKSlhKYlFYYUZuUDJ5SzVQdVhYTy9EZmQrMVNWTXU3RzN2U2JEOGZv?=
 =?utf-8?B?a1FGZUxIRVFrRTNpSFdzN0NldS9reVlFR3BNUWdsMm03Wk16Szg1aUhzcHJt?=
 =?utf-8?B?b2pSNng0b1c0VlJsWk05Si9VQnN5VE5JSkFJNWltUDBVRXByOTNOeTdXWDgv?=
 =?utf-8?B?ZFZvaDdpdm9RWjhvQ2JsazZzcjJNb1NSVlM2S3ZodVNKcGt1WGZ1WmxCUlVE?=
 =?utf-8?B?Ulg0VVJ2TXNIY1JabGZBcHdzSDJqOGZlUEwzRW95MVE4V242Z0dSdGd2bHJ0?=
 =?utf-8?B?YUN1TFlBZG9QdDJ4WWtuYTYwbkt6Rk9WUlFNSjVRTytLOFg1eEx5enRreVFJ?=
 =?utf-8?B?SHl3NjM5UERhenVZdkxkWXlTU0dWM3JnZXBHUUdVZ0tPSk5vMmpDSGp6cHBW?=
 =?utf-8?B?cjkvUFdldGhPNlR1bDBLMUtoN0NxLzNpdU40ZDNNd01zTTFDSWxtcTYydFJz?=
 =?utf-8?B?Y0M3ZFR3MWpLcDMxNmI0R0pHK1NNV1ZadCt2bk5lOHBtcmFHZHFLNHBZeUht?=
 =?utf-8?B?QlVWSGpKREs4L2UvTWRwRnJRTk9hOHBIWHBkc1F0Vmdocy9CNWR1UEdFZlo4?=
 =?utf-8?B?cFg3UFAwNWw1NFFNeWhiejZlNEQzMDNrNzA3dVhWQUxXUGZVMXhNMysyT1FT?=
 =?utf-8?B?d29YZ0RmNFlkWHNVMlJBUm5HUDVobE9pL2Vxc2xYVDYwVGRFVWdpN3NJTEpz?=
 =?utf-8?B?Zk5XSzlZU1FHdGVsL1h5NUdmNTZxTHJRUytJdzJqcUdvMVlhUkFmZUo5c3Bq?=
 =?utf-8?B?ZW1VTHR5WHppVEo3SjFvajhYK1hSaktyM3duNEVnb1F0VWZVT013TkMrclVa?=
 =?utf-8?B?RTVpc2RtdUJ0N2VzVDBPUGhJQzEwRFhVcU9reUxWVjhnYkMxRVRjYnNZaGpH?=
 =?utf-8?B?YmtMeFgycGtoS09kcXZwTnFMeHdHWndacm9aOVFwaHBjMW5QVEFuaFVObkFY?=
 =?utf-8?B?MVd6WEVyV2xhMjBNRHRIV3IyN0JVaTNjQXA5Umx3WTkwV1VxNFE5NUUyQ3Ns?=
 =?utf-8?B?dHRKUnRzYjUxTHlRNTRIQ2tadm1iLzVKY0tLUm5iN3A5TjVXZ0hqVWlDdXMr?=
 =?utf-8?B?aVQ5cUxuQUlOS2tCTUR4dU5tbTgvYnF2b0ZDRlFseVl4YkwwWjZCem94c3VO?=
 =?utf-8?B?QUtQbmkzWk04R1pYMVdpSitQY2FyRndFL0pLTEgzWWhySmZBaFhvV2JEbWUx?=
 =?utf-8?B?ZngwdkEzYStMaVNtV0JmdFE5V3ovNUZsZTlJdjdITk1XblJUazF3VHY5bFhM?=
 =?utf-8?B?T0pnODhlbXJhYlFHa2hvcytCUUx6WFlMVXl3MXpWcmF0REk3SWlMRFgvU0Zt?=
 =?utf-8?B?VWhjaHh5VVd3Nk9yVitKWWtGcjdXWkpoTzB5a3RTQkxKUDI0RjVGTXNVRlZJ?=
 =?utf-8?B?WFdnQUkwbitkd0JVR0hwVG1FOWtqblNDbktWL1plR3NXK3lzSUUwZWNEa3M0?=
 =?utf-8?B?SkJCckk2YzVId2ltZWt4ekNoY3ljSm5oTitIS3kxVUtJS3ZIRDdXZ2pOcjNh?=
 =?utf-8?B?VUNtd3dOSkVzb053ZmNCcmZZeGw1ZXlsMWN6UkNkOWVIWVRqOGZkclluNnFR?=
 =?utf-8?B?ZlFKTmZtUDFzRTIvOFcxZmYxczNSWWxjZUJvRjFBV1pHcFpTWktKSUlUMkM3?=
 =?utf-8?B?TUxDUFpyeGRQMHJmTWhuVnNrZ3BnS0VRQkVPUUFaVVVqZXRYdmpWZUpWMUtH?=
 =?utf-8?B?UWpldldpZXVJbWxFSlArcmpJSGxmNk9QVzN3OUs2SExtSk4rYUsvMEVNOU44?=
 =?utf-8?B?dURtYW1UQ0dUSGxGWURrdktETnBVK2NwU2JmUmo0RTJtU0tnUGEyVHhrcEZq?=
 =?utf-8?B?WVJNSFBkQ2lxOUZhTmVRU0pjNTl3WHdycCtlMnk0NENrQlFVSkFLNFNwbWxW?=
 =?utf-8?B?MXdkcTV2YWhCMW41dnlUVzdKNnU3Z21kRUVyWlAzeXVmZ3BZVmxHdldVZXFU?=
 =?utf-8?B?M2lzZHkxMUlHV21XOW9VUGxjTnRpSlNEVTZNN0hrZzgvOWlVS3hkQjAzS2E1?=
 =?utf-8?B?N0FKaFJBUmJXbGdxWTdGVjZrNzhKbVhxMDUzM28xRHhlSzFDTExTcnZBMjhC?=
 =?utf-8?Q?xDtZdtU4R85W7IK/Dzfu+VjFb?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 176965c7-a3e6-41c7-0c39-08ddd08c4dff
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2025 23:45:18.0426
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5QHXuaDq+zO9koqR19kbPGDfgkCNCXNB56iJz61JJfjB3H1ZwU5AnQPUlJW/fHnutuu1cG+O3lW7+VeJXV72LQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6425
X-OriginatorOrg: intel.com

On 7/9/2025 10:00 AM, Dave Hansen wrote:
> On 7/7/25 01:03, Kirill A. Shutemov wrote:
>> Instead of moving setup_cr_pinning() below efi_enter_virtual_mode() in
>> arch_cpu_finalize_init(), defer it until core initcall.
> 
> What are the side effects of this move? Are there other benefits? What
> are the risks?
> 

Picking this up from Kirill.. Reevaluating this, core_initcall() seems
too late for setup_cr_pinning().

We need to have CR pinning completed, and the associated static key
enabled before AP bring up. start_secondary()->cr4_init() depends on the
cr_pinning static key to initialize CR4 for APs.

To find the optimal location for CR pinning, here are the constraints:

1) The initialization of all the CPU-specific security features such as
SMAP, SMEP, UMIP and LASS must be done.

2) Since EFI needs to toggle CR4.LASS, EFI initialization must be completed.

3) Since APs depend on the BSP for CR initialization, CR pinning should
happen before AP bringup.

4) CR pinning should happen before userspace comes up, since that's what
we are protecting against.

I shortlisted two locations, arch_cpu_finalize_init() and early_initcall().

a) start_kernel()
     arch_cpu_finalize_init()

arch_cpu_finalize_init() seems like the logical fit, since CR pinning
can be considered as the "finalizing" the security sensitive control
registers. Doing it at the conclusion of CPU initialization makes sense.


b) start_kernel()
     rest_init()
       kernel_init()
         kernel_init_freeable()
           do_pre_smp_initcalls()
             early_initcall()

We could push the pinning until early_initcall() since that happens just
before SMP bringup as well the init process being executed. But, I don't
see any benefit to doing that.

Most of the stuff between arch_cpu_finalize_init() and rest_init() seems
to be arch agnostic (except maybe ACPI). Though the likelihood of
anything touching the pinned bits is low, it would be better to have the
bits pinned and complain if someone modifies them.

I am inclined towards arch_cpu_finalize_init() but I don't have a strong
preference. Dave, is there any other aspect I should consider?


> BTW, ideally, you'd get an ack from one of the folks who put the CR
> pinning in the kernel in the first place to make sure this isn't
> breaking the mechanism in any important ways.

Kees, do you have any preference or suggestions?



