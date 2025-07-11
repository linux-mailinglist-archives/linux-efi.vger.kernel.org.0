Return-Path: <linux-efi+bounces-4279-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7F8DB010BE
	for <lists+linux-efi@lfdr.de>; Fri, 11 Jul 2025 03:22:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E0725A2A0C
	for <lists+linux-efi@lfdr.de>; Fri, 11 Jul 2025 01:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A8C32A1C9;
	Fri, 11 Jul 2025 01:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JWYW5pIj"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72EDC173;
	Fri, 11 Jul 2025 01:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752196965; cv=fail; b=MQvzVLzHtq2Vaktio3TJuh0rNqtL+2RGQKdEZa2rgZqg5BHLxvwpfxBXbAV3PEHB/6lq7BWbd71mBSOPCEOxeApEwZLdNoYsysthUMiBoKiXvxgCNHlw4gCMnL0thsA0eUa+c0FT+CBeBAPEBWO5CFRh0j9HPkHUw3xu7qOdHVA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752196965; c=relaxed/simple;
	bh=VnHYqaAgmXRI8D/PFrPzdQOs2w+7Cou2QtlY+cNH8ck=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=g84Stw7We3uJnMAA/npfZxINSzIMzXfDeyUvTPkRGxaLpPtVBUiRlQeNpoVZDv5jNthRJkktXUGHQuus3CXy4+IfX2J0mpVpTAR/2kdDz/utvDfiSqM1UQtw28fxUW4cPHEQMlOBOmmJ10Wz5v+d+OHwyZpGDnNWeIFKElKrH0M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JWYW5pIj; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752196964; x=1783732964;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=VnHYqaAgmXRI8D/PFrPzdQOs2w+7Cou2QtlY+cNH8ck=;
  b=JWYW5pIjqFj4Ycb5wm7hNMguxBdDdNZHX6p6oqoH9/wKJ8Ztbx26737+
   QQRVODpKwOOEuhaQWeLjXxkG+l6GeKj4uZ/uM/gnfp6UMOJzz2H/XEJvH
   ZDJQUIhaO9CkbRXEsXtWoQVI3dq2ERzaKL5Fu3QcOzysV1gfq/AsjVEkg
   6hc3MRIc76gv1I56moYH8SjwIBbxO1vV0is5viScaP1f3bBxyxUzs4+cX
   o5I8Oqm3i0bq305HjXSy5my2jJSwyWUoO0qJjt8/rSUOFaIMAEUty4m6Q
   Bzj4JSEikFpGKLAxBq1W2njQKjbxV42yLXcfSU9esWQOpbUAHMCKF0+rF
   g==;
X-CSE-ConnectionGUID: NQGeRT6gQ++UT3LeRR/cKg==
X-CSE-MsgGUID: j7PPH2IkSwSHslr6WU7KjQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11490"; a="57105841"
X-IronPort-AV: E=Sophos;i="6.16,302,1744095600"; 
   d="scan'208";a="57105841"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 18:22:42 -0700
X-CSE-ConnectionGUID: Br2fdd+XTdyKeTnuYPsZGg==
X-CSE-MsgGUID: QC0ti9QOTOej2vzDacq+6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,302,1744095600"; 
   d="scan'208";a="160540746"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 18:22:41 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 10 Jul 2025 18:22:39 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Thu, 10 Jul 2025 18:22:39 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.83)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 10 Jul 2025 18:22:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XSkBenIJkBl43aNA2NWNrpI77zIMFeDB3zqao9r35OUGHSVUOTt2sRUWgyN1szR4ZqzyPRzuZkpSoM3ruyGBNPF/mL9WEIpe1bn3DAeKT/9aVdUNguAkfVdLutqSqYybfgWU8TlbAHXJvil14isiPyyuBdWLWcA8BZ0VWgpFOZUH/hYJmLiXX9DHNy0XoyDULqwsiKAEWv85ubDdCQy5wS77tWr4TjZkJgVq+dYkHU8+iDRbI9qS4uZACjRFpRPNmQkCz1RJe3LA/PI05DH4YJ8F4hnIxYveayB/kiAzFqLjOeXjWqTRp5nOlgwKGVO532LxPt1VoMUFfExsHEPlDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jvL91fnJ3Jr4fhuQ5TNhxEeDW0ctiXfSpOf50K1pBHc=;
 b=oe4k4n+vW8DuEbkSfTajHIhNN0GUh56NRz8tR4yVsRgnG/UKpqvY+XClDPUzQbgRF140JtJbj0wafNDgrwYL+Ym0S07XUsOyAoFfd66n1KmchRTh4+QlEvEi0CKrnQoHGLCetEKhurA7tjIi0s2ofyNQKQUIia9/bmgk1O55qv+XXj23+9TWbPdc3iAHvGndmp6+ZusRn5VGsJj7pVBFWUonPYYUMPCV1bz/iXyatGuqjwRCjr5vn4N3t3PQ80ZoW/sZuwiR8hRaYsk7r7jigffb8K1R9NL5rte+8UfkJTfKEspILte1CYmZdG/4bAt0MWrxEeFvEgI5UCkDyXZxow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by IA4PR11MB8992.namprd11.prod.outlook.com (2603:10b6:208:56e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.24; Fri, 11 Jul
 2025 01:22:35 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b%7]) with mapi id 15.20.8901.024; Fri, 11 Jul 2025
 01:22:35 +0000
Message-ID: <a76a41bd-7c0e-494d-bf4b-ace9e2230d34@intel.com>
Date: Thu, 10 Jul 2025 18:22:32 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv9 13/16] x86/traps: Handle LASS thrown #SS
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
 <20250707080317.3791624-14-kirill.shutemov@linux.intel.com>
 <1a2f6b4a-114b-4c27-83f9-1aac46f2e7c0@intel.com>
 <j76lggwdlxv3lbs7iaqny42ay3m4qqwjnf6vqgesaykpozciaj@a2azdryhmaig>
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <j76lggwdlxv3lbs7iaqny42ay3m4qqwjnf6vqgesaykpozciaj@a2azdryhmaig>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0150.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::35) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|IA4PR11MB8992:EE_
X-MS-Office365-Filtering-Correlation-Id: 154e3129-7312-4be3-cd78-08ddc0196ab5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?a2VQV0pSUDROakpLZTkvZ0tkYzJWdG5lNXFwdVFKcUNGaWZlbEh1ei9GUWRM?=
 =?utf-8?B?aDBqc2FLdlArMFNyZUFBWWRoMkhIWUpYZzI5L1R1WlU2a0xBTkMyRXZ1TS9T?=
 =?utf-8?B?OVA2dm9GUWZuS2Y3N2NuSGVEU1JMUnhRWE9oL3Z3VFVIUTV4OGdNL3o0bGFL?=
 =?utf-8?B?NFZ2NzUzc29SUE1EWHY4Zm9FRjhObk5Jdm91NUU5N3VMbkVKV3UxcU9PNHZN?=
 =?utf-8?B?UlpWQXNER0h1M3BaZFJFd1l2a1dYcG5hV1gxSEw4am5rMGJPUzBWNmNkRjdF?=
 =?utf-8?B?OG01VkgyeG14aFUxYnNQZWJ2VW8zK3lYdmV6T2VYYlpNajRRZTd2ZHhQT3g1?=
 =?utf-8?B?UEhwbXlzQkVoWTBIYm9oY3gvWDh0bUVGVS9GdEZKMU1jNGtmZ3dybnEzUVFW?=
 =?utf-8?B?eDFiaU4vNG95WXBVbkJka09IMUtYMXRhc0tvS0Q1anp3c0tyZFlHR1F6V3NJ?=
 =?utf-8?B?dEordllmeERpVXpidUxjNS9qckdVQVc3dXQ1b0hkdm41N1BWKzlEUUY5eTIv?=
 =?utf-8?B?Ry9LTlArQjk2NUN1dUFxMHZqMWc0OXc4VFQvZGg2ZDlyWGF2ZUEwQ1FNV1lR?=
 =?utf-8?B?VUtGb2h4Mjd6VTBvZHkxaTRzRG40bzdPV3JrQmx2andQR2NIMlNmdURqT3pD?=
 =?utf-8?B?TnJkMHhHVDN6SEd3TTNmWklRZ0dmNXRneE1JOHRlQUpKVFNHM3FmclJKbUxu?=
 =?utf-8?B?aUpyM1krUTlNQXgzdFBrQUlrdnZWaDVSc2dkdTR5K2lKYStVSTQwalpaaWxs?=
 =?utf-8?B?MUIwNElHRjMvaEZyeDdac2p5MEFkY0IzTHZuQzZTRjNmUWl3N1dDRFp2aUdn?=
 =?utf-8?B?RnZUSnhiblFINWdqcFZCaERZSGxaZzRQVlY2dW9ONzlQUE5Kakc0UnVkSnYx?=
 =?utf-8?B?LzVwRS9BTGllQTRHTmFvVGc5NHV5MXRIRDUrYXZHOVRreDByazR4RVpNN3cz?=
 =?utf-8?B?UVZDaVRxb1R1Z0xNd0N4UURRNldmTnFxL0Npb0xnTytjaGliMEtCZ2U0N202?=
 =?utf-8?B?L2ZGR0ZzU3JaVzRIdXR5Q2w2bGpHOGo5cU9wSE9qbjhoVGtVc2J5WlhzQ0Rz?=
 =?utf-8?B?dm00cW5LdGFLWmtYTHF1dmRLazZlaTlOR2hJYk5DUkJ1K3BaVzlCWFl1Z3Nh?=
 =?utf-8?B?eVVFcW90MTZkM3NOUWdoMkY1U25rYVJnQlM0UlB5bVNUT3duSExQQkg4eEN6?=
 =?utf-8?B?dGZyTFVldThMR3VDNlQ2NmY2bmU3U1VZUmlUZWtJZzNkQjRDRnhHVm15U0FQ?=
 =?utf-8?B?bXZZMFVtUm4vUHZTMUVZK09wRHRKTzV5TU1vT3RaeW90K0Q1dE0vbnZrWG0z?=
 =?utf-8?B?SjZScnk0TVNFemhKK3lYd083MWwxTk1FY3lFbzNOc01YUTNFc3VYbE5HS2la?=
 =?utf-8?B?ejViS01YNVMxNGhscDRuRUdUa29ac2M3bHpyVmdTdFgraVkwcFc4Ris2REF1?=
 =?utf-8?B?VS8ycmVYTWdrZE45WmhuQjV3eFkrRHgzMWtqMzFlWlhnWGptbVdjcTdaUGRr?=
 =?utf-8?B?ZTdYZFd4dWhnTU03T1p4Q20rY0lYeTBJS3hzTTVLOXh0QjFFR2phWU42dzFk?=
 =?utf-8?B?MHFSTW0xcTVrVkdYM3BqOW0zbHVycHE3UGh1TnJOYVlYYXJjMGZyZmxEWW5G?=
 =?utf-8?B?UWEwR0VvTkNNb25qeGJaS2JBaExwU1l5V2htUzZEZVdpS1BIYklYMmMvR1hN?=
 =?utf-8?B?ZmhTbUFvWVI4Z2dXVmtUVlRnWEFvV2dBK1FhcWRhWWhjVmxIZ1UwaEFCNDlk?=
 =?utf-8?B?VmxQV25DVFlsYzd1L21TWTJiMHVEbkpybTJuNUVyM0dNckpLRDkyelZpVzFv?=
 =?utf-8?B?eWEyVmdYMStBb2srYmRFOGtETGtQNHorRzh5QnNNRUQvb0FEQXFpY1FQSnZN?=
 =?utf-8?B?dndWblFqb1FoU1RXM1hlV1l2TnpXZGh4czB2STRZcUhpeFE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RU16VkxQaXlzMEJnNjZKSlE3bElLUisrVDQySXljdU1UQkFRSE12M0ZtYUxj?=
 =?utf-8?B?ZkRBUVdRSi9HSzNOdi9rcWNOc21jRjhmL01QdXBha09ZT25UenFoMW0zL3p3?=
 =?utf-8?B?M01HVkh1UFNXemJLdWpXMWhkN2dtWHRrUTNvenZVZml0OURHekhsSlp4a3hM?=
 =?utf-8?B?K05jemdDdXFQTS9BQk1uSGNLd3EyZmllZnlKc1Q3UnVma25KVkh6VDNIeWtE?=
 =?utf-8?B?TTB4cVZqM2lFeFFLOWVHYXhWQ3VPRm9RbmNSbG8zUDR0Nmltb0czUDJwYXdT?=
 =?utf-8?B?T3ZiSjRzMDYzTVJxaFF2a0g0Y2NoYnRYUmxrcTVLMWdRcTErOXZyY2lpR29H?=
 =?utf-8?B?NDh6eVovNk9KVUpTVmIzbUdYaVZObUlZWmxsYXFVTEU2dWNKOFZHRzROT3g2?=
 =?utf-8?B?VFYzZEJvbmpFSWFneTcxeTdKSHVvenpHZVF2Kzh3Q0hFbENhNFhEbXgzc0Z4?=
 =?utf-8?B?TU1QSVIyM24zZE1xQjFoZHRacy9ZcVVvK1dQS0tkQkZQczRpTVFBYS9FVXNl?=
 =?utf-8?B?RkVmTDV3VzE4OTVwNU02Q3lMRVhSU0dQejMxOWJTUit5L3RPQ3RmQ3A5d0tZ?=
 =?utf-8?B?c0E3ekR4NWMrdGJyeGtreUcvblRERS9Wdk9lSWlkdnkzU2V0WVk1eFMxa3Rq?=
 =?utf-8?B?WHMzMG1WV0xOK1I5bXBoZVkxZStlNFZTYW5QYVZnOWRlVlRGMVE0T1piNE8v?=
 =?utf-8?B?Nm5OcU96RlkwY1hVWmEvbjJDMXhmQ2J6TThuT3owS3ByVFlaSzJwaFpENHU3?=
 =?utf-8?B?WHcwUlRvcjcxS2hDdUtjMDFSbzhkZ1BNSjhGVld3bjdjQ2xVMUhzaWVrWVhq?=
 =?utf-8?B?R1NUQ0NYVEpMU2Zvdi9ZMHg1MzlQMXpkNzRpbDc1dkJMWmdzZ2RmTHVPazc1?=
 =?utf-8?B?d0tHa2N3V3pLaUtjck5WSE9rOXo4RkRrVWU1cmE5MnlMY3B5UW83aXcvTUx3?=
 =?utf-8?B?OHFVeUpaMkFYRkhCMFhvUlVja3NzQk5vQzhMUDhWY09jZEh4WFdEVHJ6dFh2?=
 =?utf-8?B?b2RYSS94K3lWTVpNaXZycDQ5c1hoa2ZmdTVCSmJpR3AvdWxCNkN4d1MyT0l5?=
 =?utf-8?B?clBiNFBTSUtLTGJVMlAxUEJ4QUNkdkFlQzlFc0ViOWJCTC9NU25LR2lTWmpP?=
 =?utf-8?B?TDRCT3dVV1BVQTdBUHhHaHF2dlBMN1BhVFc2cTQwb285NG45V1QzU010OFl5?=
 =?utf-8?B?N3pHSUVzb3Rad1YwM0xhbHI1RU9EV0RML3FuNlNEZk5qYS8zb08vcUJVVVYy?=
 =?utf-8?B?eUhlVm52UzllaWV0bVcrTHBWVEcrODJvRTZIZHc0Z0xvelpSbjFxOStZUXFw?=
 =?utf-8?B?b2ZiMVdaZllIUjhxb0dNeXhxZGhzZHZHUm1YdWd0UmhJS01sREYxVWwvMlha?=
 =?utf-8?B?dmYwMnZ6T3FvSmlYYWEvbWZvWEhUY3FTalJGTzE3cVFuNjZpNFRnNzNkM0Fs?=
 =?utf-8?B?by84b2llbGdUaWlkcXNMUTdHTmMxZUdPMGhlZ1NnNGd5Zy9rY0xjSXY5WjA3?=
 =?utf-8?B?M0I5ZXQzMmlnZElONnpFZlZmS0dTZzhTQWVhVHNXencxRnh2em1ZZ2w0cVJN?=
 =?utf-8?B?LytUOHY1R0I1Z3QxYTRLSVhnMUtucXQvVlpMQWxXQzZKRVEzREFUWDhER3By?=
 =?utf-8?B?YjZ1T0VBVXhOTG1paW1rOS9adVZrRStMS2E3a2ZNdUVxWDhnSlR6eTlPdWxJ?=
 =?utf-8?B?WVFqSkxZOXRoWkFFdlV0TkpnanVKcUhpQ1FMenFIUm1uc0ZRQ1FXSDdYaHov?=
 =?utf-8?B?NWNuWWVnYXo5WDhPVFpMcmxyTjVmZlVkT2Jrd2RNb0lLTUt2VWs1UWFDT1Zj?=
 =?utf-8?B?MG1oK3JXczRRWk5XTlB5SXRJQ0w4M01adkhiZkxqRXF4a3RvVUxuSE54N0s5?=
 =?utf-8?B?bUxoVkg4SUZzeU10S2cvQ0NmcjhEOE1DYllOaGZ5T0t0TThSa2V0citHb3cr?=
 =?utf-8?B?QjJ3RzNjaFFWaUNVdFlqbjkvUUtJOHM4blRIRTB3a1g2bmJpY3A3NHFiblc0?=
 =?utf-8?B?WW1ZOXFjaHZ2Wm5maWdXMXpCM2RBZzZHS0hiY1VMNG40ckZGRldPYUhkR3lE?=
 =?utf-8?B?NjBZRkpQUVBjUFdRNUJ4YXM4eEQ1dzh1TVM4TVJrWUdMaGxreENpYjhaM0lo?=
 =?utf-8?Q?KjbgsZMaSZ4OdHSowG07sWjiM?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 154e3129-7312-4be3-cd78-08ddc0196ab5
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 01:22:35.4930
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 087QehAMnMsaRjtIPrB4b+6ip8nCsJlbipes7oSNz6JNw+UcdjLFuRHJ90Z116Wt3b8OlBnqljhtkirw/9BPXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB8992
X-OriginatorOrg: intel.com

On 7/9/2025 3:38 AM, Kirill A. Shutemov wrote:
> On Tue, Jul 08, 2025 at 10:12:28PM -0700, Sohil Mehta wrote:
>> On 7/7/2025 1:03 AM, Kirill A. Shutemov wrote:
>>
>>> +	hint = get_kernel_exc_address(regs, &exc_addr);
>>> +	if (hint != EXC_NO_HINT)
>>> +		printk(SSFSTR ", %s 0x%lx", kernel_exc_hint_help[hint], exc_addr);
>>> +
>>> +	if (hint != EXC_NON_CANONICAL)
>>> +		exc_addr = 0;
>>> +
>>> +	die_addr(SSFSTR, regs, error_code, exc_addr);
>>
>> I see a slight difference between the #GP handling and the #SS handling
>> here. For the #GP case, we seem to pass the hint string to die_addr().
>>
>> However, for the #SS, the hint is printed above and only SSFSTR gets
>> passed onto die_addr(). I am curious about the reasoning.
> 
> I hate how 'desc' size is defined in #GP handler:
> 
> 	char desc[sizeof(GPFSTR) + 50 + 2*sizeof(unsigned long) + 1] = GPFSTR;
> 
> Too much voodoo to my liking. And it will overflow if any hint string is
> going to be longer than 50.
> 
> I don't want to repeat this magic for #SS.
> 

Thanks, that makes sense.

> I would argue we need to print directly in #GP handler as I do in #SS.
> But, IMO, it is outside of the scope of this patchset.
> 



