Return-Path: <linux-efi+bounces-4999-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 117EFBC2E5A
	for <lists+linux-efi@lfdr.de>; Wed, 08 Oct 2025 00:52:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17D9A3C8029
	for <lists+linux-efi@lfdr.de>; Tue,  7 Oct 2025 22:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 722942494D8;
	Tue,  7 Oct 2025 22:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jzbeo/Dp"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD3C3A1D2;
	Tue,  7 Oct 2025 22:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759877531; cv=fail; b=XrB7l1FlAQgbn8jjgsXU4eGUeuNczzDSe+K0YcF6f8GJ1o90mSGwQrMbtq29TUEpfF6pZDqjjBcIahWFAOHKyRAwFx0u2ONYTIRUrZd06n+LyqQ7dnDJo77Oohx/309SWPbiiZ6tZqmtnAivP8nAxEbvp61lOhLac5N4YoC4Cps=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759877531; c=relaxed/simple;
	bh=IBW0yUxBPDpMDAmFgLkGojstBIemz3Oq7QVeEbxxQTI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jh+63Q2Ve9Es1vq1pvaQE5d7tPMbydMolRk1760eYvWJ8KgVafI+/3VElBWNSZaSyIoAbSqtNfxVGi6cCV9dmpo3wmmT3TKuNgry7bzRdtBl6xmtChQeZSs/M3miAGxCmgayze1QzgQdJQR6YiigOfIp8phrKxOUZMQyHmtxi6s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jzbeo/Dp; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759877530; x=1791413530;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=IBW0yUxBPDpMDAmFgLkGojstBIemz3Oq7QVeEbxxQTI=;
  b=Jzbeo/DpO/bLeXUDu4NnoGiyExf3zZ+eg2CMTfmZautprmh6fyvoXW9a
   m5HCMNaRiwEEWAbG70Jyf/fzmvV8+y2YX7i1P6PuPS2LTfTtKL5FU1M3M
   bGYeBeLP4b4igZEifNlelEpvX19nrShsyCB9U/OYuw4BKdzRUOjV+jEsN
   XWQMr6E+XGJnBi7tmQ/il6OXYGR0wTHgLY3937RiL5Zf8hEhttCBz2Gz6
   SNYH+OXygR8SLcaJ5BoU1SYLDTAzjhHgV6iY+M3Ewn79pxHECpMWwerZE
   fOHgMQHsvuPsY5bNeNUsfDd+MOAi2qsAk7ckR73c4pDKLLxqCdftiJ9b3
   A==;
X-CSE-ConnectionGUID: ajXf4/6cRsqbFF3RqLcMpA==
X-CSE-MsgGUID: xkCKj8L6ReKxrtDbs464nQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11575"; a="61102900"
X-IronPort-AV: E=Sophos;i="6.18,322,1751266800"; 
   d="scan'208";a="61102900"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2025 15:52:08 -0700
X-CSE-ConnectionGUID: MlYViQVgRHCohvVBsWnn9g==
X-CSE-MsgGUID: 9Q980OCzR969zkReirPMxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,322,1751266800"; 
   d="scan'208";a="180698318"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2025 15:52:07 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 7 Oct 2025 15:52:06 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 7 Oct 2025 15:52:06 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.2) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 7 Oct 2025 15:52:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OixWcoHukUqFhdLxK78LW+5Vk50lg20G754ON2xoI9joJAN3uqwjTfu64lCOyR6VZMmkn3HlC24SLF0fgGLFkPeF0CHzLMgXOecgKIhD7LNMsTbMKQLGGD78pKPfbfdS9HXtqIgsgNJ75cjdUnXAm6ECukgRsHIdGR5LmKQrVQvfl5pXIbPmf2ZVflA73uZVm6dAToaTPZYezMcAU1TR/ufcZO2TxMdAKk8KsxHWjunohVe1GJ2YKuyztUKv7gcGShA61fcPG4vlCKM3/4I9SINxmtk/rwTHLUeS5BQe1rW8NzursB9x2qYEqyw6BFTbc5KjIacTZJmpZaBF4LuVlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eHOjHxx3j2UI6Qp2TLh8qQUXKCRXOgJT6BSxXdOMQFk=;
 b=moBu5fEirdHkmic3se5j8orSm/cIuJ9BS/8w0oJAFiLALygb3w1a+yrK7LR7WNDwimtvibVE17JlaSFkIMaW9gvcQ0jO401wR/WKrTGpEkUvp/wKyZYHA7fHtQWxq1OS3QTKMmoymzWN1I1m2Lt9YzVmx/Hz3ld9wRLIHGQaFMQ3APi614E7KZuxXiKYMWP3adde8jGcLDj9v//QU0zFBSZHPacUolBdMolBe7IXw5aOU2sYYGfHBQtx+aZjQtkghdaHWaHGhSFM/pm3zyPiyVdQcC52xUgiUHNYgA0sNQeMfVkabrYf18OGZRBq3SIhplVsCqKGlygOgLqqEXEwRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7997.namprd11.prod.outlook.com (2603:10b6:8:125::14)
 by CH3PR11MB8495.namprd11.prod.outlook.com (2603:10b6:610:1bd::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Tue, 7 Oct
 2025 22:52:05 +0000
Received: from DS0PR11MB7997.namprd11.prod.outlook.com
 ([fe80::9105:2b7c:b256:7a6c]) by DS0PR11MB7997.namprd11.prod.outlook.com
 ([fe80::9105:2b7c:b256:7a6c%7]) with mapi id 15.20.9182.017; Tue, 7 Oct 2025
 22:52:05 +0000
Message-ID: <1f2b0ed7-67f6-410e-b05e-d87ba3ee396e@intel.com>
Date: Tue, 7 Oct 2025 15:52:02 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 08/15] x86/vsyscall: Reorganize the page fault
 emulation code
Content-Language: en-US
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>, "Hansen, Dave"
	<dave.hansen@intel.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "bp@alien8.de" <bp@alien8.de>,
	"x86@kernel.org" <x86@kernel.org>
CC: "corbet@lwn.net" <corbet@lwn.net>, "ardb@kernel.org" <ardb@kernel.org>,
	"andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
	"alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
	"luto@kernel.org" <luto@kernel.org>, "david.laight.linux@gmail.com"
	<david.laight.linux@gmail.com>, "jpoimboe@kernel.org" <jpoimboe@kernel.org>,
	"Luck, Tony" <tony.luck@intel.com>, "linux-efi@vger.kernel.org"
	<linux-efi@vger.kernel.org>, "kas@kernel.org" <kas@kernel.org>,
	"seanjc@google.com" <seanjc@google.com>, "dwmw@amazon.co.uk"
	<dwmw@amazon.co.uk>, "rdunlap@infradead.org" <rdunlap@infradead.org>,
	"vegard.nossum@oracle.com" <vegard.nossum@oracle.com>, "xin@zytor.com"
	<xin@zytor.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "kees@kernel.org" <kees@kernel.org>,
	"hpa@zytor.com" <hpa@zytor.com>, "peterz@infradead.org"
	<peterz@infradead.org>, "geert@linux-m68k.org" <geert@linux-m68k.org>
References: <20251007065119.148605-1-sohil.mehta@intel.com>
 <20251007065119.148605-9-sohil.mehta@intel.com>
 <a33d59c7add98dd9ef352ac95178821dbcd0ce0e.camel@intel.com>
 <3e3d2426-6296-4a61-beae-4e3ff5d60f2c@intel.com>
 <3c078d53409c3fbf6eac30966e8d68e097d7a6d5.camel@intel.com>
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <3c078d53409c3fbf6eac30966e8d68e097d7a6d5.camel@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR03CA0028.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::41) To DS0PR11MB7997.namprd11.prod.outlook.com
 (2603:10b6:8:125::14)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7997:EE_|CH3PR11MB8495:EE_
X-MS-Office365-Filtering-Correlation-Id: 710daa08-9452-4de4-c992-08de05f422f2
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cFM3NWVXR1hhMjVBK0VZVWJrYVJNU0JHNHJ0dmVIeGlxR3hWNHpwQ1d1UkRl?=
 =?utf-8?B?YS8zMG8vRXkzcVlvanlSWkg3TWhzcjlyanZkZGVwVWdQdGVabEdKeDRHOXMw?=
 =?utf-8?B?dVM3Z3hUd1VRQjNzc3cyeFNtT1VOT0dqaHRkeWZXY2hPZERXQ1hsTUJ2SE5Q?=
 =?utf-8?B?dXhSTnVmSndzYTQ2WlVtNitWc2RqSkEvS0p1TmZtOHhCZUF1M004NU9GZWJo?=
 =?utf-8?B?ZjBzalBqYUptNDc1RmtKRzVNZCs4UVorWDdsRnNnN20rV3FZcFRxN3NpTjlL?=
 =?utf-8?B?bTV0Nnh1b3VVZ2d6Tk1sMEwrLzVjeW9sMTZCZzJUUnlJSmRGNGx3U0hlVUdR?=
 =?utf-8?B?bmVZRlROMUpNdVY4TkR4OXdjaE0xZWpkOWViWjRHMG5Qc2o3b00rRHNDbURC?=
 =?utf-8?B?QzFWbmwwbVY0aURsVzA5Z0lhNVpYZUJVMThDdHdJdGxSVVFsYUJxWW1zYWtz?=
 =?utf-8?B?dTFrN0xMeXU4eXhhZG1pQWZuR3dXbk8ybHcwa3BzYUZza0t3dUg4S2QvR3gw?=
 =?utf-8?B?emZhME1NbjB1UDR2UDdlUUJOM094RlV4amt1VGNtM2lSSEpydHZTRC9sZzlz?=
 =?utf-8?B?T0RvWGdVSWZYZ21lUzMweGN4UmxjSlA4Y2NPd3I4dEJlRXJLSVFacXFVMjBN?=
 =?utf-8?B?QWRxVVZ5eC9HSm1ueXVnbWtVNkFTMDFiakdmMXpxYkJYaDZtY2srQVJCbEpp?=
 =?utf-8?B?aFdwUUVJYkhrNytTMnNzN0RtWm9MUEExYmFHSzBpOTBEc1NHY2thUktVNjBt?=
 =?utf-8?B?am80c29MSG1MUjBTandCMHlhZnpDRndxRzhHR3UzNUhtQWlvWDhlanlRNTFO?=
 =?utf-8?B?RXZIWDBJVk5iSVhoMDdZaGZ5OWRZb2hVK2tOdldEaU80VnpSNU5xU0hGbHMy?=
 =?utf-8?B?bjFoMklKVFVjdkdmZUhFbm5TR291VHNCUGlhekcxVUkwUkhtci9aYmtVWTIv?=
 =?utf-8?B?Q3F2UUlWenowRzlLMVRsTUhuUlhKc1lVYVlCUzFvNnl6dmVrYWFlZWhRUW0y?=
 =?utf-8?B?YTdlbmxjelRDR2tmZFh1T3RTUUxMbGtJMWxDcEJNSjN2VzNVYis3Y2t3T1c1?=
 =?utf-8?B?eWFleGR6b0NTS0oyWDNxa1ZDdm4vVDNmWVc4MldWRHdBc0JMUDlwcUZHb1hp?=
 =?utf-8?B?aHlMcHRWU0I0RXRmMXVwamg4c3NYV3dyeWF1d3RoR3BCb3ZCOXdDY1NJV2Zj?=
 =?utf-8?B?MnN0a0pWQkRlZ25KWG5xbWkwaitWL05XcFZjaWo0N05DWFB5dmU4Q0VuOWFR?=
 =?utf-8?B?R1kvdXZpNjVmUWZhZnM2dWxaYnErTFNDeHJ5K1FWQjFxaGtRZlBxN1NZRUI1?=
 =?utf-8?B?aGJwZk5DSnJqemFpaEhiVmh6MW82THc3UHNoRzlaV0g3WVd5K3hKa1dtazlp?=
 =?utf-8?B?S3pOcnNLZmgvV3IyeU1vWmcxeVExcVRkbG1tRXJmT2ZXQlpuWlpaa2tKbkVE?=
 =?utf-8?B?amhDL1gwR3dqZFR6djFOa1JmY0NveVFMdnVjVkt0M1FLdzFzMENRSGxXaXV6?=
 =?utf-8?B?clQ1TFdQWHF3NnhtOXVpVzdPUG5FcVpJeklJK2p4WUpZeVZuK2Q3Z1NTRG1M?=
 =?utf-8?B?UlZBckx2U3REMDcxdlc2a1ZPWi93YXpySGZja2ZsUWpnSUQvRG5GMUFEUmFu?=
 =?utf-8?B?bHJPcjI1eDZKY1VtZFhYN2w0K3ZHMjVENVRmN044TEJBcDVhREhCanQ3RVli?=
 =?utf-8?B?REtvWmZ2UndBcHVDNWtuNkJDa3VtSmRkNU5MY3FmVGFVWjNkYVJsVitiZnRw?=
 =?utf-8?B?U3N5elMwbkx5eWdUVk13RmlsL2V3SjMwMXZpRFNUYzdCdzJCeHRBaUdRYW9S?=
 =?utf-8?B?ZFVyNUc4NjRTQ0U4bDJXUDVXNm1lTXJLQzZaa0kzb3BQKzZodWhEZjRZd3Fw?=
 =?utf-8?B?RmxGUlBwcXhGWHFrSU9CZ2xXMWQ3MkduRHNXd0YyRTNva0ZESmFqTmFRRDBJ?=
 =?utf-8?Q?2QvPj3EptIjX4I0QzJMiGCBliEDPx4yv?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7997.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WmtXd2Z3MmJ1cEdBYkFodkNOWWNWQ05NTTBGQS9zWnNGVUNZb1ZXTXliQmd5?=
 =?utf-8?B?cVJCU0dHVWFMaXFwc3RzU0tYR3RCZ3ZxVy9tQ0J1V0k2Tm0yMFl1OVkvUHI2?=
 =?utf-8?B?VVk0a1hNZ2dFS1Jzd2owNklpV3l3aUI3Y2dyRThpUWZWbXgvZ3REc1d3WWs3?=
 =?utf-8?B?UnY2L0ozSCtQSkxCVDJFbUhnSVp1Rm9MMTFHZlBycHpmMnRCalRabmhxYjY3?=
 =?utf-8?B?bEVKZUNFeGZaTnh3Q1l4WmlMUGt1NElSWVZEc3Q3aDk0Q282MGFoVXJjUVVt?=
 =?utf-8?B?ZWF3cXNwQXFrSWUxWkxld3BPWVVVR0hJUFFud0FldFB4MjdwT2NRTXNGcGtJ?=
 =?utf-8?B?L0RjMjlvNnRGeS9ZU2xFTXBWNFFaMGFMaURQMGhwQkVTNWF2ZUdtUkIrWE81?=
 =?utf-8?B?S0xxOWJMNEt1UXMya2dscXA2T1RHVm9iSktKN3didFQ0UkxyK3Q1TXhuL1RP?=
 =?utf-8?B?czVDOXBuM3EwVjdvK2wvWFYyKzdSZzV4ajFqeE5lNHh5Y0txUE94OFl6NGkz?=
 =?utf-8?B?S3B6ZklCVkQ4TWZxUEdtSzdPOTZ6MmlvS1NVcmRvUFd2anpaVVBKMWJiYVdh?=
 =?utf-8?B?c3pqK2k1ZlFXWFg0SDhqMGZHQWYrenFDTkF1L1MrMFJ5R3NzMm9Mcm13aVJ6?=
 =?utf-8?B?YWxkdEFPOFB2cHFrRHI2RWF5bnR0UU5GNUJ6L2o3eDNtRXB4c3gydUx3SkFZ?=
 =?utf-8?B?dGk5RXA2Z2Q4dU5lRHRkemwrdmc0aElXUHBBTERPTlIxWFFBQVZxSnVJS3J5?=
 =?utf-8?B?Wk9LOXc2K1pQdTFrVWlrUDZpb3BBbUxUdEpvUnZpaDl1K2k1TEMzeUZYQzA3?=
 =?utf-8?B?KzYxbE1SWS9DZG9vZXlGZUduS0VOUHRSL0N2YTlYL3cvZEcrRk9nc01od1E4?=
 =?utf-8?B?dVRRUTNqQnFQNDZlbmNkRUhlSC9aMHhFa2VpMldOVUxtRkhqRU5UeFQva1pz?=
 =?utf-8?B?ekNnTzNNckZrc0NYTUlBYlc3RUtycXVHNXA1SU9JOXk2bStybzY5M1RCQy9m?=
 =?utf-8?B?ckx6NkZrRUZzQlVCREVZdDJOa1JQUmtOMENpVHZrY0ZLYVJYNzdKdlk0SXFM?=
 =?utf-8?B?WmRQRzNSaEN2ZGpnRnFtRUt6UlpIQ2N1emVXODFjVSt5aGo5Mi9yUGQ3QlhK?=
 =?utf-8?B?d0JWTS9PNTZuYnhlQUREVmw2Tk0zS3oyMG1UN1o1NjVkcFhFa25YUXpTdklW?=
 =?utf-8?B?R0w1NUhWWVQrZmdmQnp1UzlnMkZvYlp3ZnFRRy82dEtWUThvTnpVSnBZUkor?=
 =?utf-8?B?eU92ZUtJcGpqSmwyZmVoNU10LzVKVjJuVHNVenZCM1NYUWFCQ3NoV1l0d0d1?=
 =?utf-8?B?eXlXdGFhQWdtZzRpZmdWVnF6U1dpRm51NGVvTmtQeHUzbllqc0VaTGgxUnlt?=
 =?utf-8?B?MDBuVm1kZXZtMmFDWXMvOXhBcjBIZ3Zkc2p1WHJhSWhnN2pVb3BqNGFUVUg5?=
 =?utf-8?B?Sjc3RWdvOHZTT05YWkFtQ3ZXdFFOZEVKbFhJS1V2aEdXSWVqb3hnb3NpaEdC?=
 =?utf-8?B?Rmt6OUlRTU9EcE8zeGVpc2xjQUJXR2R5eUhkdGVFeU9XdkFhcjNSTlUwRVJi?=
 =?utf-8?B?UHBadTg5OFhwMjJTU1JCenNYVU1UNTcxRzR4bUMrZm5BeDBsWmd5OHgwZTd1?=
 =?utf-8?B?MWVXVEVFUjN3ZWRaOUxZRHNiUUpXcWNnL3dVaGd2bjk0bFRzYkIySkN1dEIz?=
 =?utf-8?B?MUsrdXRzZ0hJZkR0eXhKTUtQYVF4TWlYd2ZXRDAzclk4eXF6WnAxN2pScWg2?=
 =?utf-8?B?MVZzdG80V2xkOTFSb1N2S1dWQnVwcFRpMVJQRXpZZmlSbDNPLys5S3ZxT2x1?=
 =?utf-8?B?TENoT2hYTzdXTG5YU0toNW1iUDh3NmM5RjhEcjlaRlYxdjlzQkZZYnhwb29j?=
 =?utf-8?B?L2l4WmNadUs1bWtKUXB2SGVuMHpmaUhCYnE5d29ZUGlHYzZ0T3hlOTVZM0Za?=
 =?utf-8?B?RHNHait3UmxJeGdCei9VSzBob1g0UkpuMHMyRlRHN1A4WUoveEhmYm5XR0hM?=
 =?utf-8?B?UWM5Tk1LOXlFeUVzU2k4L2VGWCswSnNMTW1zUWlYWkdFYzFQeWhKVmY3ZytI?=
 =?utf-8?B?K0hGWG5HVGtzSGxUMmlQNVRJUVRuWVJmbUlSa29icnFuWTI3MFRKWER3WWFG?=
 =?utf-8?Q?ZE2UAs90BROk+1zJK2CCyHj5L?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 710daa08-9452-4de4-c992-08de05f422f2
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7997.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2025 22:52:05.1055
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 57sXNYPTP/ZXyevZL3cxk+h4ThM1DN1gkm9ZPeenYYL6zCBeknf1K9ckCRU8126XuKyUdKDtdeWMxrNPr7WPPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8495
X-OriginatorOrg: intel.com

On 10/7/2025 12:53 PM, Edgecombe, Rick P wrote:

> But I'm looking at this applied. The following patches (which don't include that
> hunk), add another call site:
> 
> bool emulate_vsyscall_gp(struct pt_regs *regs)
> {
> 	if (!cpu_feature_enabled(X86_FEATURE_LASS))
> 		return false;
> 
> 	/* Emulate only if the RIP points to the vsyscall address */
> 	if (!is_vsyscall_vaddr(regs->ip))
> 		return false;
> 
> 	return __emulate_vsyscall(regs, regs->ip);
> }
> 
> If indeed we should add a check, it should probably go in one of the later
> patches and not this one.

We already check CS before calling emulate_vsyscall_gp().

if (user_mode(regs)) {

...
	if (emulate_vsyscall_gp(regs))
		goto exit;

...
}

	

