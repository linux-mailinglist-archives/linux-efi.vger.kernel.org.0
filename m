Return-Path: <linux-efi+bounces-4073-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4864AAF06B2
	for <lists+linux-efi@lfdr.de>; Wed,  2 Jul 2025 00:52:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B46A442986
	for <lists+linux-efi@lfdr.de>; Tue,  1 Jul 2025 22:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C56AD281531;
	Tue,  1 Jul 2025 22:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eQMpDtvD"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79EE28312E;
	Tue,  1 Jul 2025 22:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751410313; cv=fail; b=ejgoH/gK7cPZW4CfGhYA4BheN9aoS7OxKoNdbwKBjzgrj0Xw41+nNQ8QZ4desjOzkklqkWBcncnn6uDqlOHSxawkMKqqWGhgs4KTCRH1N7yeZz2AuoFMkZZ93vxvdxD0yDV4C+UsNVoP3pmQUPx3BEyooi9N3Yq4uH3TEZV2zXE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751410313; c=relaxed/simple;
	bh=eUpHUi3plZEEgsjUNECzwbLhqplgfTCNT0PBXpAVCVw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=P02St5zN0V96pC6jvnoOYP5mmjD4tbhC5gPBLEAXDqsHMnn/p8ela83n/vU14cQKOHTSlvpx+7OsWF+09eGSryNY/1DVzD84WWwz7+aC7+vT4y/Y0r7GVD/S5r1k082N0nMED4i9o/rwrO4Z6aRkK3wRREKGI/EtE1yW9MOvDVM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eQMpDtvD; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751410312; x=1782946312;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=eUpHUi3plZEEgsjUNECzwbLhqplgfTCNT0PBXpAVCVw=;
  b=eQMpDtvD08or3WlQt9bwTD2511Jc14/b3U0pNL03qRDYMLHbmXqv4A4e
   20/OzRHQCkZRo7ngw/LaKhDrT3/p+dXQnXFiG/JjhoQvIVxpJLqYr6Rry
   ehARAGq2DzH1V3H0LBmQ52auLCFSFq0XFPQTHOqIQUyRwM9paCKYcM2/C
   aPeZD4EGWFd0XgHsKYcZN9nsg3ckZxt56GCtd+Ozr6e/aFXQDAG+gard9
   y3OwXZA99L2esIFi6A4OYS3OMilIMkUicDNLeNa+G4cMKk2YFb9X7KVix
   DDtfSgHa6EMNoUKnHCpdju4uxdljrY6+JrstbjZJH2JxuDHXNpPnhBLJO
   Q==;
X-CSE-ConnectionGUID: ivsfnkEHT56XgGBUHGfWAA==
X-CSE-MsgGUID: HEhHcuDYRgarSFxXA7r5cQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11481"; a="52923197"
X-IronPort-AV: E=Sophos;i="6.16,280,1744095600"; 
   d="scan'208";a="52923197"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2025 15:51:50 -0700
X-CSE-ConnectionGUID: D3JIORl8S3manhf7sr0qtg==
X-CSE-MsgGUID: PGH2RrYIQ2+kbkszS9yTVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,280,1744095600"; 
   d="scan'208";a="158459574"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2025 15:51:51 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 1 Jul 2025 15:51:50 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 1 Jul 2025 15:51:50 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.44)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 1 Jul 2025 15:51:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b462JOqteH7YLVoJ3V/LlohERDpMKnIq6TeH5TL810fTBzMaPcoWQKBJXa4KaxIkYCI8A0RWDSQ9kRlu3YnL/aPxSkBZf1LktiNhZAIBL4l2oiMJGo396l8VHHzGc+lM5LMOIvNNsXYCCuxH+fAYZ9F/ZcWDTle5zq1zXksXsaOo7Ceru23QG+sDxtT1CDyhjT7eXdLaGuJTsDpnd+AWa94trJRXgSsjLu4764KshBL02Oltp/FvM+UjPtjHfWbn5O+1+ts01MSCXMLtpY/y5igoBrvLWSEmVzSqFAf0KhaW5FJQzDv7KEEQ3lryLjAhJgWXFRPG53TUpHwDmNLTaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+41d8+jwgcGfF0zfi5ePu2xp263UMEKZ4ftpuNiYW+c=;
 b=gC2cdK5Kl9LDZAgvGA/7u2zi5FfsjS8zdgImJ3YNW/hOiUfA4FGHIEx+oqZtuRHBXiTb73kBb86koJ554SBg9/1LHUFp7TfhGgvSn4OmcVWFMgzCPGBYVVBvsmdnyPXoXHoqoRYJOKPcRjQujcgelYjIqYSYtgIU6f75c3VxPP9CDHYJ0FcbRAqnzOBKeXXO87SSdAzZogHi+EZlJxHvzF2F75EcdBymWLfWO/Hyog+xjYO6zu1rtiJu2pjYBlf14HLpbe+6XKjf6CaCP9A7NrBU4WrwuJrf4jgdabrUY2vnS5tOgGJiQsj9H9mqWjvhPJJQBM3cSv46xVjKsoKIwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by DM6PR11MB4692.namprd11.prod.outlook.com (2603:10b6:5:2aa::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.31; Tue, 1 Jul
 2025 22:51:05 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b%4]) with mapi id 15.20.8880.027; Tue, 1 Jul 2025
 22:51:05 +0000
Message-ID: <13af1f0e-f9ca-4e68-b582-f9be83453d89@intel.com>
Date: Tue, 1 Jul 2025 15:51:01 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv8 11/17] x86/cpu: Set LASS CR4 bit as pinning sensitive
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
 <20250701095849.2360685-12-kirill.shutemov@linux.intel.com>
Content-Language: en-US
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20250701095849.2360685-12-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0119.namprd04.prod.outlook.com
 (2603:10b6:303:83::34) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|DM6PR11MB4692:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e99abb6-5d42-4f1d-2ac9-08ddb8f1c2a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZS8vZ1JMVVJ3MGhFWndBTzJ3d2duYnlYQXlmYzNSNWhBamYzTU0xQkladERH?=
 =?utf-8?B?SkVlaUJBZVVOdGtxeWloWU9MaTRVTzZtbEZLR1ZRR0ZvMWFwOEc1TDJYQXJp?=
 =?utf-8?B?bXNkU1MzN1JNeDg2NWlRTU1vR2xqVUxFOXJIZzBDK0pqVUFpNE92eEJOOHNK?=
 =?utf-8?B?MGc1TDNNRG42bkE5RHhTVmJXSnYzc3VxMFV6aGd4RG9vOVhmbEoxanVQWVlx?=
 =?utf-8?B?WjJ2UUtEV2NIT2Z1MmVKSXJOWWliNlNPMk5SOTArTE5MYUNLS0RYQzV0NkNw?=
 =?utf-8?B?NGp6Y2NCOG81c0x6RzI4c0VicDJFR0R1OEZmeVdsalRMRkNXeUlydVAzcUo5?=
 =?utf-8?B?VEhHSDd2WnhOdVpvc1BXVkpuOFZuSjNmUUdqa3BZYWpjdkpWOW43bUc5NDgr?=
 =?utf-8?B?dUQ2YVZycVIrM3ZLOW00Z01kM083V1daN3lneFZIMGo4eE5KUHBWWnp1TTI5?=
 =?utf-8?B?TVltYkVDZ0ZTMXVXZ0U1REZad2JKdGxxUVdwc0FWcVo3MlI1U3NlTkNwYS93?=
 =?utf-8?B?L2dxT2ErZ0pleUVwdGcrbTF6Z2tIby80V0xRcnRxWDNadVU0bmRKSmk3WmE3?=
 =?utf-8?B?ZUpyelF4M3BpcU12NldGd0hTaWhnTzU5ZHc5OVNGVjBTaWZsdG5maUkxN1ly?=
 =?utf-8?B?bVp2ZDNRKzRraFk3T00va2JLNUU2NFJwWnkxWFlGdEhBQXpkY1psTzdUdThV?=
 =?utf-8?B?V1Q0NUJSQmU1L29xVEJkWlpuQnM0SWcxTXVqVnVTV25GT3h6clV2TWt1Uk90?=
 =?utf-8?B?ajdmalU2TXdyekFYQU83dnVVVW9lTDRjUXB0THdvbW1BZ1Ewb2xqNnVuTjFM?=
 =?utf-8?B?ajNNdWF1SXBDWVFlekhMQUFzQW9LR0hVWkJoVXpVRk1ZVG1pdlIyNnhVV1pz?=
 =?utf-8?B?dnQvbGNWMmdJVzkwVzVFUXU2eVFzUkl5dk52QWVRRk5aT3ZZTVJiRW1xU1Nl?=
 =?utf-8?B?NHNxVFQyUCtxRnpWUVRQRGxlUE9NVzR3S29ISFk4VGszSTBxVTV3aml4Q0dL?=
 =?utf-8?B?Q2RGRlQ5VzEzTGZRY1dFOUwwT0pOQjJrVkJnOXNUWWRsUnh0UmFNMGdnYnJ2?=
 =?utf-8?B?RitGRXFVQ21QTE1ORGxaQXMxVUlINytFWGNrc2tBSmVSdW9PSUIyZzB1YTV5?=
 =?utf-8?B?SStZamlDcHIyOGMxWEFrYzk4UDZwdFNyTjk5U2ZNSk1JelNMMDlnRHVUME4v?=
 =?utf-8?B?QmlpMFNQSjBvQitUYjNpR3NLZFViaEtVTlkya012OEFmWHZrVWlpZlErV244?=
 =?utf-8?B?MndBRE10T1d2Rk5adHZsNy8xM3FkWTlKRU5hdDZEenloZG1zbm1ZTFJuaDJ3?=
 =?utf-8?B?UGNvUEZOSzE0TExGZlc4MWNEMWpmaGsvL2dhQ3EzWUtQbFR2cXB0S1dtQ0RN?=
 =?utf-8?B?blNHdWVzdXoxdTBaakJJMFVBWndhOW1CSUxJRWFlOThVNHhEc29rTEt6b0hp?=
 =?utf-8?B?WVZXTHNtckR1UkNSTVczNHVvWDlrekxMcHRvRXp5cGtkQ25abndJVmw5QzNr?=
 =?utf-8?B?c0htRTBzWEZoQmpvdE84S25oTjFKYm1GMndOaW1KdGhJbDBoL0p3MjZuQnVh?=
 =?utf-8?B?dGVyYnVZeHhTK0NvcVhHc3FFak52cHhBa3l2TDJEa09XL05kd3BLQUc3YmU2?=
 =?utf-8?B?TnJUVFg4aEhFMnNkWE0wY2czWGF0UW9PVVExczVKdU1Iblo0eVFKL1VCZFZJ?=
 =?utf-8?B?MEV3T1pEZXM5cTZ5bHFvSnNxWFFxL0wrTkxYd0srSmxwUHRiQlJ6MmRrYzhi?=
 =?utf-8?B?R1Jncmx2ak5YQUNhWHFJZVN5Vk95MFZUVml6V1hIdDZ1bTU2VzVUWTVxc1pL?=
 =?utf-8?B?cmdTdXQyOWp1Q3pjbWVjcVN3bGR0OU1jOGlsUDR3bE1RbDl2djZuMUVxRG1M?=
 =?utf-8?B?YjFkczVNWGZnSUl5OWpCUkpvOWhXcGxOd3NwY1ZUeXgrMkN5cllsSjdDdkRG?=
 =?utf-8?B?Q0g0c2JucThUN3BDeEx5d2VrVGdWZ1BPelNBYkU1MHhjeWQxOGQyVWJVaWZr?=
 =?utf-8?B?MGdIUjZmZE1nPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VVRMWFpjNC9jVnJxZ1BSZlFQc2ZzVW9sRlptdU04NElLVi9MYmxkNE9lQjVi?=
 =?utf-8?B?alhPckczZHZBVG52cGx4Z1VuOEc5elArOWJzRXh4dlZQNUU2M3ExWUgyeS94?=
 =?utf-8?B?c2JWM0dwMEJSRWZmRHNBbjJ3dFRFOTNQNkRrWjRjUGJhMStIU0wyYkM0bzdT?=
 =?utf-8?B?NFpwdEZ5aE1TMHZ4UnpQMCs1SG1JdVdnTTExMWRiTjlqL2pLck8yWVFqQmpI?=
 =?utf-8?B?Q25WNVQzYjB1aXE5N05ta1dubWhLVGFiMFVwMnRXbjk2cmtqMjBWNXEvd0pt?=
 =?utf-8?B?anFIUERHb3hUV0tlbWU1SjRDbmlRbFYrcTRRRGhQRk1kSlhNenhwNFNBWVk2?=
 =?utf-8?B?bk1YQk9PMnUzdEVTVFdsc215a3R5amFxcjgwdFNYbmNvTHBITDFzUWFaVmdv?=
 =?utf-8?B?b0ZtcFhLbUFNY1Y0bHJ0M3lsbFRrbEMvN3MzcWJrL2c4Y0dva3FwS2MzQWdB?=
 =?utf-8?B?VTFQVTVqNHZXekN6YTlXZ0oxTzlueWphUDZJTjBPRjltcmVySTJteUoyYjln?=
 =?utf-8?B?Y1NlS0V0elg5aU1OaVdjUkRvUXVOSDlsQkdSRGtPeVNmVkVPRlRhU1RielRD?=
 =?utf-8?B?NWhUd3ZTc0V0MkxpdFRLVXRid0FoMDNsY1o4d2VTdm0rSWp3eENZY3dGeWJY?=
 =?utf-8?B?WC8rbnBGenhTOTFTZmVzTE9sVTI5b09DZlZ2RGJ0aDJBM2hWeXlXSmozSk96?=
 =?utf-8?B?RFBnUkpNdW9kWVdQbExzWmtvV3VmRW4xNStjYlB3dGZBak45NjBRcW4wUFla?=
 =?utf-8?B?eXVPdW1CdGREOHlWOVFZSnBDbVl6WmxyOHRLSWFEQ2t1NW5abm16MTdpcDJ0?=
 =?utf-8?B?bTgzeFcvQ2xtcWVsRVg2aUdrN1pvOWN0WkhIdHRwbGJGN2Z3L2FRTzdEYXN0?=
 =?utf-8?B?SDcyZEI3anJLMnp0akV1NzRlUWhONU1YbHAzUlBpaERwbXRHUkRoaklzMm90?=
 =?utf-8?B?b1VXSlZCT2V3M3g3aWRQckVCeWU2ZlI0NURnNGIzcWJGaXNKam9TRWhXcUpV?=
 =?utf-8?B?dUQwSWtBWjlDcUVNalA2QWtuZWYrQlRNWlFVaE9VdHNTdEtDMkhRd3VuRVh1?=
 =?utf-8?B?NUs3L3paR1VFMEh0dlloWG1NR1piWFQvVEZ0bm9tYU1tek5BZTRta0d2THJy?=
 =?utf-8?B?eGRrdDBkMjdjWFFTSkQ0N3JIK3pkL0V2Q1JwcmwxK3dHQm43dllDMTdQN3Jh?=
 =?utf-8?B?bnlBZTY3SHE2b1d1TkFiTUxZTzYwM0FtcDZLUWhYdU5GZW53NlgvdG5PdUhz?=
 =?utf-8?B?UjVYbVc3NmFrS0xTdFNoUGxScFRyVUJYeXpDMjFiSHVEdEtFS1ozRG9Hc3RU?=
 =?utf-8?B?WFVUS0RkWDFYWUpuRk8yMDV2V1gzanAvZUhvTUROODhlZzc3VHhpa09SaEZY?=
 =?utf-8?B?cFcxNS8rUUlYOVQvdjlWV2NqY3BIYlAweUVZRVBTZzR6UHRNaTUrRVJMS0xK?=
 =?utf-8?B?ZC9wTW5ueTlyWG9FSldIT3pUYm5qY2RmU3lVd3VoQUl3S3JCNWNnME1qaDhZ?=
 =?utf-8?B?R2NOU2JqenJCUmk1c28wN2dnL2hPWHh0WGZpUHFscGc0NWJyTW1PZ2x3MEQ4?=
 =?utf-8?B?cWx1T0dWUXAvWGgyR0MzOW9MRGVFWjJSU2dwaWx1SThtSGFYVWFwYlp4Umt1?=
 =?utf-8?B?RUFHRE5qek5xSVJMRWJlMFNTdTg0U3g4MytLcmpuTGVIaHZYNStaQzlpQVoz?=
 =?utf-8?B?MVkvM0tsTGJKNUlPUUlOUHNEaW1rYVA4dyt3Tk8rWGlEdnIwQWJkRWRsY0Z2?=
 =?utf-8?B?WlhPT3hPRm03T3ZEaXd5d0Z2TjZlWDFITXBrVGpsM0o3UXIzS2k5QVphWEh0?=
 =?utf-8?B?RmVOVDFFL240MWZoWXBhc3FlcXlPUFo4QUtDaFgxQkZRVDNURWttREJweWV5?=
 =?utf-8?B?YVIyaWhMa01lT3dVQnVRQ0VidFpENnVCeEVNN3BNTEJlMjI4Wm9KNTdoR2tx?=
 =?utf-8?B?ckJFeEpHOE4xK3dCRHU4bDRUZGxHdU1GWVdHOFM1WEpoRXZNR2s3RG54QjFL?=
 =?utf-8?B?ejR3UmtzSjF2QTEzamRFdDVyaGREcHJDUHd5VGZjOW56N2Y4RUpmdHB1Tlcr?=
 =?utf-8?B?VlJvY2dIUVdzU0R4RVdDT1JZUzVxTHVjSyt2dDZUZ1loOVdxbkcxdFZtM0Fm?=
 =?utf-8?Q?CsHsCZBa0JnHCPdKgxCxqHsRP?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e99abb6-5d42-4f1d-2ac9-08ddb8f1c2a4
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 22:51:05.0530
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nj72zgJu5JU/N6az5rk2+bTo5XAXuz7PG6bNkRu0JF19jGbkNDnFg0I9Pn9e1jlme0shG8Jwq/QWA96ZnJwMjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4692
X-OriginatorOrg: intel.com

On 7/1/2025 2:58 AM, Kirill A. Shutemov wrote:
> From: Yian Chen <yian.chen@intel.com>
> 
> Security features such as LASS are not expected to be disabled once
> initialized. Add LASS to the CR4 pinned mask.
> 
> Signed-off-by: Yian Chen <yian.chen@intel.com>
> Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> ---
>  arch/x86/kernel/cpu/common.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 

I think this CR4 pinning change can be merged with the other CR pinning
related patch (#4). At a minimum, this should be placed close to that
patch to make logical sense.

1) Add LASS to the CR4 pinned mask
2) Defer CR pinning since it would cause XYZ issue.

Or the other way around. Anyway,

Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>

> diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
> index 9918121e0adc..1552c7510380 100644
> --- a/arch/x86/kernel/cpu/common.c
> +++ b/arch/x86/kernel/cpu/common.c
> @@ -403,7 +403,8 @@ static __always_inline void setup_umip(struct cpuinfo_x86 *c)
>  
>  /* These bits should not change their value after CPU init is finished. */
>  static const unsigned long cr4_pinned_mask = X86_CR4_SMEP | X86_CR4_SMAP | X86_CR4_UMIP |
> -					     X86_CR4_FSGSBASE | X86_CR4_CET | X86_CR4_FRED;
> +					     X86_CR4_FSGSBASE | X86_CR4_CET | X86_CR4_FRED |
> +					     X86_CR4_LASS;
>  static DEFINE_STATIC_KEY_FALSE_RO(cr_pinning);
>  static unsigned long cr4_pinned_bits __ro_after_init;
>  


