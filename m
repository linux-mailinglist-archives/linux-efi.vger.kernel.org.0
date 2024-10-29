Return-Path: <linux-efi+bounces-2049-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 666889B5592
	for <lists+linux-efi@lfdr.de>; Tue, 29 Oct 2024 23:10:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22063283F86
	for <lists+linux-efi@lfdr.de>; Tue, 29 Oct 2024 22:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8614120A5DD;
	Tue, 29 Oct 2024 22:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HFITvZUb"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E9F4DA03;
	Tue, 29 Oct 2024 22:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730239852; cv=fail; b=O7H72WO0fso78HZ3xZbygynt6UlCIwQ5UcuwHF/mSz/MKB7QfgUiSp6KjiuHROYhw9P53SXoPggnq1CAYEXpwAPHSMG8tYgOk6Kwg8B4cONMOE6a0txga9BmwT7f5ScL6sc1SGpKcvyMPtmdAIyIfve7FgjHd91xl+IuDbf+1c0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730239852; c=relaxed/simple;
	bh=wwPoJqqc4Bfo2RPCF/4qQcO6h1nRED/D1pqrDg6JqUI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=p/w1jtbSPLVdsUnF61lG515x3hIal+ZDDjoBI3uBhjxe0V46M1z8c+F+lGQeXSmvsaoSHx1T1nnAdu0ULJ9MjVnVGgPjtR31uvu9JToEyKSw2y6pw5ZgFa8rRo56SyOuwVOQPDnekQWKnlfBwIK9aomB4Sy4Jqtifw1oNYwo2wM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HFITvZUb; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730239851; x=1761775851;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=wwPoJqqc4Bfo2RPCF/4qQcO6h1nRED/D1pqrDg6JqUI=;
  b=HFITvZUbNBFnqI63poGkoaUO9db0rkbVSuEu/OByTeF5RGKelnvAuQNp
   wNa6KvlE/dhDs1TkufOVGy7Oane09Zq8ataJEG2h5unJkcEn7QfuHxnmp
   l1wq5fG+VigHuS2EaZr8Ah7+pflCn56w397PMZE8b2AXAKQ3f5w7RuIEE
   /xJzUQDDs6vM5f8Hdsy/KwcJjI85bO9AVTSgfIFna/yxJ+pf50qAPfDeH
   vsWVhgut888Sr+38Nr95s0b5OIAGOjZt0uopQZEucjbrFL0+i9EFoOpzc
   HTfGsGBmxJCz0L6pKyo67IJRs1s81dNsPpgf44a343AKSxX8NV48+vCeK
   w==;
X-CSE-ConnectionGUID: QfmA3R48SDCVn2kLklue6Q==
X-CSE-MsgGUID: 9rF69n42TQOYoRzO0ix2fg==
X-IronPort-AV: E=McAfee;i="6700,10204,11240"; a="55316234"
X-IronPort-AV: E=Sophos;i="6.11,243,1725346800"; 
   d="scan'208";a="55316234"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 15:10:49 -0700
X-CSE-ConnectionGUID: Jg+LYHWXQ0GYWT3s7eeU2A==
X-CSE-MsgGUID: IzKCNh99TgOo8dAIQJdBsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,243,1725346800"; 
   d="scan'208";a="82253562"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Oct 2024 15:10:49 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 29 Oct 2024 15:10:48 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 29 Oct 2024 15:10:48 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 29 Oct 2024 15:10:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=onAd0icPNyo7HIjdy4bvqGZYvj7LY8b1nmz+jcClcFroP2cond6dMqkFt6N50aYg6E3TpeYafghcQSDzisY2WZOIWkg5bgxyKDwdfBFWJIO7cbCt0d8bfZK3eDlW1VvXE+bkgnZdiuMPXds5h6ta8SJNN2CTkVReefYUshvp17lRG9P7RGLwPllk7+uAmmBCsxMnpyFsAtDj3bsCZFU3vtFLMXOFC6DoZ4tDNPEi8n5CFG7lh0n7wtMPhB4FTkZXJcbKvBgq2ZGLRa/sVm6+uEb0pQKvngwdL/gMQrth6uZIiYW4kaxahnyw8tkaOkM1aHxWGMLi4GefVY8H/3IeYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l+63lnkigzQUGndYoJMreP5eZH3NrV6Ccwz7qkAH9is=;
 b=iANA6rmgMflniiD6cjA5g7mxL8RU8SklOxJrXiMdyTyCkzcvqer/hlTEA+fyXAcfg5hAceqCuW6qYZk+g4Cm+MD/g3UeNOrnlygygdujW3vmhUxhpRUsqyLfmov04f605IlByssjeY3z8TM4HX0PIM9tkjGHdZi7Ke59hSJjTAevTGE7NFFrNOW9aSlVQSVIPLAUb5NsoLHuH6hmBkSM73Gq3FNsr8sysic1JiMiNC604s2dkMYYFXOHN3exVxD0GyOhMT4xlJ2rxhwoOOs0xtxnIJyIVcj6sPkmosn20HQ/C1irD0LMNKiScVxBPAKU4BfyErPttET65eJDVQWsbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by PH7PR11MB7594.namprd11.prod.outlook.com (2603:10b6:510:268::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.24; Tue, 29 Oct
 2024 22:10:44 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b%5]) with mapi id 15.20.8093.024; Tue, 29 Oct 2024
 22:10:44 +0000
Message-ID: <a95a624b-214a-4b1f-ac16-dad5a9270bf8@intel.com>
Date: Tue, 29 Oct 2024 15:10:42 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 05/16] x86/cpu: Defer CR pinning setup until after EFI
 initialization
To: Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andy Lutomirski
	<luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar
	<mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, "H. Peter Anvin"
	<hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, Ard Biesheuvel
	<ardb@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>, Josh Poimboeuf
	<jpoimboe@kernel.org>, Xiongwei Song <xiongwei.song@windriver.com>, Xin Li
	<xin3.li@intel.com>, "Mike Rapoport (IBM)" <rppt@kernel.org>, Brijesh Singh
	<brijesh.singh@amd.com>, Michael Roth <michael.roth@amd.com>, Tony Luck
	<tony.luck@intel.com>, "Kirill A. Shutemov"
	<kirill.shutemov@linux.intel.com>, Alexey Kardashevskiy <aik@amd.com>
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
	<linux-efi@vger.kernel.org>
References: <20241028160917.1380714-1-alexander.shishkin@linux.intel.com>
 <20241028160917.1380714-6-alexander.shishkin@linux.intel.com>
Content-Language: en-US
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20241028160917.1380714-6-alexander.shishkin@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0091.namprd03.prod.outlook.com
 (2603:10b6:a03:333::6) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|PH7PR11MB7594:EE_
X-MS-Office365-Filtering-Correlation-Id: fb8f1065-4877-455c-2bb6-08dcf86688ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?U1FGblcxVlZPU21hTHZ2VzF4enhEVjZKY2lUWjJ4ZzIvTkhzcS80dHNGcmhY?=
 =?utf-8?B?OXF4eUxJaFdXQlhCVHFPSVFtQVkvaGl2OHJVNFA1cytBMjdOblNwV0gwWFlY?=
 =?utf-8?B?M3EzZlJNa29Sa1RFb2h5RnYyZUNCdjR4WFZNTk1ZVVlENzA0Yzg1dUZHeXNN?=
 =?utf-8?B?SWtQbXlXRmpMMDNHV3RPUEhWWEJXejNjSzZheU5GRS9PZDFOaUw1NWNmNGx6?=
 =?utf-8?B?U1RXdzhPekEwUTFna3JCNDgrZE93WG9Na3lyKzdTMDBlODNRa29mb2k2dXl0?=
 =?utf-8?B?Z1FuTWFvL2hKdEFKZlhLR0tXRDdidG1ReGszWXRhZ2VSM2tnMlJDaVYxMDIx?=
 =?utf-8?B?ODZZRDVuNmFiRnRnM2lGaG42ZkFRc1RkYXJLdDE1SUNXbmFsTHR5NWxRSFpM?=
 =?utf-8?B?Z2NLanV1MWg1YWl4WThoeE55Z0VRK1hsTEFITlNSMThOVXQ1cnRBblh5U0tJ?=
 =?utf-8?B?c2JnbVZoaVg5LzJaUXJoRHI4ZWFkTkVBc3drTWxuYVFGMGZnVnNrYUZ0T1ZU?=
 =?utf-8?B?OXhxa3JxZ25ERVdudVZ4cmRUOW0xeVdJTC8vcUxGV0dyaUUvQ3F6aWhDOTJE?=
 =?utf-8?B?REdHRS8zOWpONktBSkg3OXd0MWtNQzhYejhLcW5kcUFaV1dsQVkrQ2dOemU1?=
 =?utf-8?B?emRsOWJNaGV0YUx6Q1JYeHVtWlVWTlQ0djZQbGVtb3VlQzNjdGp5OXhjbkEz?=
 =?utf-8?B?RVl3b0ZyVlVCeSsrUVFpajRlTmRoM0NXUWZEdENJNzRZbEYxWTk5aWpQMGhL?=
 =?utf-8?B?L0dpYUxqVk5HWVZSVUwyd3hWSDhMTHp3WlRqNmoxUW9uLy9paVcybSt6SDJS?=
 =?utf-8?B?eFNCT0FocW4yaTVuNVpDYVZKd1VLaFFXQjRYNEtrY0s5UzFNUXR0SHg1N0kx?=
 =?utf-8?B?andENUt0WFVEdlRISzlwT0JhdmpzaW5KeFF1ZnpuOXVsbXNXNTkxYlliSk5N?=
 =?utf-8?B?ZW13cE1IWXVxMXpnMHFlOFNDMFl0OEhVcnhpUWdMeDgyU3ZFNDNCQm1jM1Zt?=
 =?utf-8?B?NXdqSDNkZ05wNFBTakRjamgzd1pVeFo4NXE2TFVKTjBHY29sdmI2THZmSmIy?=
 =?utf-8?B?S3RXOTdOcGJvRDZvOEF6R0pMRmM5dDNzNjFBeFpSZEVSZW1IcUdlVkdrRUhw?=
 =?utf-8?B?L2JHSUw1cXp4MTNKU2x5R3doMzdaT1QvNlZVRUpGTjVQL0NJSFBPbmNQTmwr?=
 =?utf-8?B?NE4zSUYwdWdUSmtQdTJZVFdqemJiOVJ4bFFzQm1ETmh2NlUrRk9LdUQ0Rllt?=
 =?utf-8?B?aHV6ejMyWlRnT2xBcXJYY0FncnQrZURTR2tuZzQ0WGRNZFZYb3h3ekI2bm5u?=
 =?utf-8?B?TlhBazRWUldXaXlQeFI2VDlxWGN6M0NMUSsxRWl4NytUWlBTeTZ1UWtDR21Q?=
 =?utf-8?B?OFhaWG02alU3NGF0ckI2MlJ5MWJ6Q3IwVTV0bWkxanNhOWJOaURNcTJyakUw?=
 =?utf-8?B?cTF1TXlvVHJEcGZTZVlKeWk4ZUlVdUlRdEs0Vll4Rk93MDRBUk4vU3Zzc3di?=
 =?utf-8?B?Lyt6WTY5WW5Qb1VoSEx0U3NOQ1UxQWxOdDdXbEU1eWhkY1o5N2ZuRVBDUXlr?=
 =?utf-8?B?dWRoMkRrcTFsWWhHeXFJWVA1QzhiY3pjdTh1SXYzL2lFVmd6YXEyL1d5U20r?=
 =?utf-8?B?NHpRaUNLZkVnVHgzOHRpWC9Zd3FNMG5pYzBzWkM2WmthYmtLakRSVzlOSlVZ?=
 =?utf-8?B?MzBVZnJ6N2dOcm9EUDBpOERQeFJOSHNXTlFSNEZSUGdER2kxMTljV3FWTHBX?=
 =?utf-8?B?QUg0M1FRUTgyTEt3V1FQK0g0djRzQTlZL2p0RFNCa3R1SGsvR3NOQUFjdklN?=
 =?utf-8?Q?+6vb6MJRv0xcnRsDr4jlu6N8fLdOz42rYmGrE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NFNOU0k1MHdaQ2xvZW5wYnU0M3g5NThNN1YyTTREMERpMGFQZzVpU3pyZmVh?=
 =?utf-8?B?eDZqakMxODFYV1lRVThlSC9ZNVNMbTR5US9aYXZLb0hBS3BIUmVPY3g3Ynl2?=
 =?utf-8?B?Z2V2VHliWkt5aEw3RHpNdCtoelV4WnltKys5RDdQTit4aFB5Rzh2TFZYckV5?=
 =?utf-8?B?Q0FLVzhGdmhWQjYrVk50eGJtblVOQTBBWUZTU081QmlpVHlGVHdNYm1NbEo2?=
 =?utf-8?B?Y1Jxb3FXUWFxR2ZJMEtEUUEzZjFQQy9qcXhCa01nVnBUdndqMkNaY3pTM1hC?=
 =?utf-8?B?enp1WXBMTUF3TVNtK1dBc1Mrcnc1TUtoU3RRV0YvVzdpMm1kaGFpZzVibXJX?=
 =?utf-8?B?Q01lU2k4dnRZUmFMd1RzRDNZRDEvTUU3QmpRaTI4V1g4SHJoQnNUcnZib2Zz?=
 =?utf-8?B?TUtIeDRLc29zdU5pM2xzVTFuZlBOLzdvTmpFenFlaWlvT1dTellzcno0SENW?=
 =?utf-8?B?d0c5K25sSE95VENTNUw3N25nNmI4RmxBNCt6b0c4TUtMRVRZOW1QTFdtUFpE?=
 =?utf-8?B?YkNvcm5hZ1Zyd2VPbDNlamhVYi9rQXNmS081MzFkVDdvdzBvUWtpekFzSFhj?=
 =?utf-8?B?U0JSNy9pa29MekJ4VmV6dGFsY2kyMTJldHNsNVphMTIzZ1pKNXlzOFBkRUN5?=
 =?utf-8?B?OVhJWjYyb05TSW5JVm05cDBzUXYvMDNxU1NQeTYwKzNibjQ2KzZYbzVVcXlC?=
 =?utf-8?B?Q1A0MUJpNytFTHR2aWpncnczRk9jdjV0a2tuWXhRd2U4aEFwUzY3L1lDYjhp?=
 =?utf-8?B?UWp6Ujg0eEpNQmRFbmtQaUoweFBSOXgzTFRMbkJ3UUh3TStIVXFkK1JmOVVC?=
 =?utf-8?B?MjRPdlA2NEltN0N1YU9HdDN0TWxVdHczaWZMMHR5R2Y0MFhVamJ3SG1Wakg2?=
 =?utf-8?B?VWQrSW54eEQvZ2dGQ2pKQnNPbm9PNlo4QVdlcWNFUm1uYW9JS29oRE9RdTQ2?=
 =?utf-8?B?bytRelBrdUswTVhuT0ppZGpmTFZaYlJ1VUpnL0lQSy9rbkZXcHdJZk1zVEt1?=
 =?utf-8?B?VGU5UGlnS1FoN0tTNXFFMTBwWkNSMXlMclE5MU5UejEydnpUTEdsMVdsb1Zt?=
 =?utf-8?B?TENoVzZvMFRIVjZKRTdiQ2J3WFlFNmJudnYwazRJTjVkNGg4SmFOOTFJWW1l?=
 =?utf-8?B?WTRVKzZjeXBHa0QyK3VWNUhwU0x0UE5lMUtRQjRZeitoR0R4d0ZFUzJWcGY2?=
 =?utf-8?B?QjRhQy9wNWw5Q0dsc0F2Zk5EclYzd1JnNVRyaE44cFRweFNtNFh5bDQ3K2tq?=
 =?utf-8?B?UWpuTzUxQVZTKzVSVlBzRzNvZVVZRVMxdEpPWis0aU5IM2VTYk5hSjA2bzJU?=
 =?utf-8?B?WnVWc0tLYnRnZTJjSHBLb3pmeVBqM3dwNEVDcm1YWXZTR3hkek9JYXlCQ2hv?=
 =?utf-8?B?eUVVcElPd1U3dFRQMjRTbURCZStEYzRqM05zN0VYVm1OUTB3Wk4rM2Vlam1N?=
 =?utf-8?B?ZTZZVWh3WkhnM2Ntbng3UnZKWWU5VDJXMmcxcGxWclVBRUFxV01kYllqekU5?=
 =?utf-8?B?OGNxc09xRm0xS2Y4T2RIYTFSL3RpWDJkRXNWUUdhNnNHZzdYT0NNZlFTL3Iv?=
 =?utf-8?B?Qk50NWYyMldEbUNIS2FnUGlIc0JGbzFvZWJwU25ScmltaXhIdmdLaGM0cStW?=
 =?utf-8?B?ZytkS3hYNDF4c1FXSnRwcTFqSnpqaTBHZkZKVktQdkppRExLM21wVXVyd0dS?=
 =?utf-8?B?aHVHWEl3UVp6Vmhkcm1XTWJZMUJKZXArYkZxQTFLd2Z6MXp6TlgwamtOTmtG?=
 =?utf-8?B?bkVDWUMrSnYzVFREclU0SG5adytjM1R5dnl5aEtXOUlHUHYzMU40MlQ0VTZp?=
 =?utf-8?B?N0tVK2xjOVZhaGdHTkRFZkRoOXVZQUpYcXRNRDJQK0pYeWFGZFMzTEx6dDlx?=
 =?utf-8?B?cTFaRkhyMVJESnAvRWxQSkJiOExmTkJLdVFBWjM0eFB4YkhnaEF4SzRyZDdF?=
 =?utf-8?B?b0cvRnFEazJlTEx1UHZpMHhzakErSVBlUlEzaDRTSmt4QkgzQ1dZMUhacTIr?=
 =?utf-8?B?RXdWNSt2SDRXYnBOS3VWNnVSajloUmxRZ2RvRjNUQlBSYzZ0UStGdXlTS00z?=
 =?utf-8?B?MDFuQ3dlbDZkS2ZPbmZRTHM5bmhCS1A4OExMY3d1WW1YMitlNkhud1pkM0xa?=
 =?utf-8?Q?r/c0z4igNQW1DvbKTEtloCGh7?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fb8f1065-4877-455c-2bb6-08dcf86688ae
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 22:10:44.4371
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1lGOaKme7ZvQ+AzpBjgPv0xy6bVDmJcjr6gERY7Se9lbepwJvJ11xgcobtYPWL9pfjwluxgI9BWKi0ucCquLVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7594
X-OriginatorOrg: intel.com

On 10/28/2024 9:07 AM, Alexander Shishkin wrote:
> In order to map the EFI runtime services, set_virtual_address_map
> needs to be called, which resides in the lower half of the address
> space. This means that LASS needs to be temporarily disabled around
> this call. This can only be done before the CR pinning is set up.
> 

...

>  
>  	/*
>  	 * This needs to follow the FPU initializtion, since EFI depends on it.
> +	 * It also needs to precede the CR pinning setup, because we need to be
> +	 * able to temporarily clear the CR4.LASS bit in order to execute the
> +	 * set_virtual_address_map call, which resides in lower addresses and
> +	 * would trip LASS if enabled.
>  	 */

It would be helpful to describe why lass_stac()/clac() doesn't work here
and instead the heavy handed CR4 toggling is needed.

>  	if (efi_enabled(EFI_RUNTIME_SERVICES))
>  		efi_enter_virtual_mode();
>  
> +	setup_cr_pinning();
> +

