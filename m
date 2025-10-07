Return-Path: <linux-efi+bounces-4995-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E773BC2B43
	for <lists+linux-efi@lfdr.de>; Tue, 07 Oct 2025 22:53:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1DABC4E3FFB
	for <lists+linux-efi@lfdr.de>; Tue,  7 Oct 2025 20:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2B4C23C513;
	Tue,  7 Oct 2025 20:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vph31KnX"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59DBF5464D;
	Tue,  7 Oct 2025 20:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759870396; cv=fail; b=cPBZ4jtkUCYaph+2fQEMbhde0xgHlavLyyJPGMfiGlaK5004e5o21az7tYBx/35zQwe/mF01ibs2Hfuh9CnnXQKwRI/MHxYlCKwOEyi/Z9BTZnR6dTBaltRZrvR5IppOu2WVtwbhH3FOJW7OmygpybLErMisyFp+Eo/6Gj+Uvig=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759870396; c=relaxed/simple;
	bh=p2xjPp0W4yev4VkZlYC+rMOcfUuZj9lU8azlLmQxFa4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kQZYyVu9Md05gSAH3xi7zI0UxUfjzXNdygUegwepRf0Ldp/zICyLg0hakPPtNPMoLdkwu38V7zJOqaqWrz5wLpH2LJU81aHIo5g+opIKhRnkVXg6Md05x3Z8GADW8vDghu4Uj4sk0eioSJY4zZjsQB0SXKDzs31pOWe/Jhcnplw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vph31KnX; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759870395; x=1791406395;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=p2xjPp0W4yev4VkZlYC+rMOcfUuZj9lU8azlLmQxFa4=;
  b=Vph31KnXujZdU3s7Nx4cIKB+BLYUCoY5sl3I7AoEt+oyvDp+5RiwKIXq
   2cbzwQf+0xIvSXI+bTlsdc5ff5hSWoBPKRl+w0V4jYzVFK1xzWCnzrNHs
   UAmbDGxnaN5rArK+uRvRy6bZfZairNcVl7D9PdvTAe6fypOVXzE5LsY9K
   9HT9GbeoWSmbl6jpRPukiD30RzwXcy5bsWUps82HEIm81j4VlKON+nqD6
   EEn07UikfZBogyascy/f8tibZxqfZCW/7ZUdIn183c/q9fteHJihiT+mt
   ECPyh1f52ZDBkyzu+w3axoThGdcG3xOzjjXMRsTZM0SDW/O79ib2rN+oK
   w==;
X-CSE-ConnectionGUID: Zg5422tWT/2xsfLnQVHcvA==
X-CSE-MsgGUID: 8q6rkXQ7Sk+ovaf0PZPbRQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11575"; a="72321857"
X-IronPort-AV: E=Sophos;i="6.18,321,1751266800"; 
   d="scan'208";a="72321857"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2025 13:53:13 -0700
X-CSE-ConnectionGUID: O19wxhG/SnWjCScX6MoxDA==
X-CSE-MsgGUID: 85cSO/SWT0KCuU1yAu5c5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,321,1751266800"; 
   d="scan'208";a="179513748"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2025 13:53:13 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 7 Oct 2025 13:53:12 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 7 Oct 2025 13:53:12 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.22) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 7 Oct 2025 13:53:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dkk9g02j3Gi38qQtjsPPQSbs+9Afb4dD4g04rdNdxrUyRrhDIbUN51MOgw8jXWy/81QU5VRH90C/qTSgMdOkAQH5kPe9h4TCHYKFMjreBZKITQbbCHE0WS7XovE4taBJd9aIUnwcOBkDHnzSSS/4IHlfFgnGxSUyOImzpmtcOOpy541cMQUtFQpsJxB1PQoRSh5AHHgMVEovAwVryT4djVtBD+FyH2bkEX2i8ydA5NnIGqv7DtIW8DcM22cb1Tsn8yZ8o65396x1oGLPgCeMxbQu1FFAHmZclcSBBHPreQDzHo3to6+4EymLx0hpr122NrZzL0djF+U66jtyjzfmww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/cHpe8+1eHwxsE+N2m9GatNF8omCmGRYh1tfYTlNfts=;
 b=Sv+OWukotjdZVkUtQqbMayQvtqTD4yH+bQ14I/t/myykm1ySSazVsC4RobRADIOexsfHHyOlikPpQFJO4hnqRyQWr5gTHOWltLY6KeJWlccXYmlXNsBCMf2DPhmtwzQSoBCkDwYnA6/NbfMBUEooP+AoL2wqGeH0Z+SGpur6HZgFTAqDFSH1fqdLRf9in5hPY2RA/b/4NeKXyciyG5JDhP9QX/MBPhm450w8X8vA6ZHOZQfWSxFvCUYVuGm1tcUWUT3K3SqSUhMlKw9YQs0QwbLRSIZ0nQqpsSJI6uwGmeKOJTyUXyDrt4zdGyAioPtOZmjqc5Vwu3XKobDioUEoWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7997.namprd11.prod.outlook.com (2603:10b6:8:125::14)
 by BL3PR11MB6457.namprd11.prod.outlook.com (2603:10b6:208:3bc::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Tue, 7 Oct
 2025 20:53:05 +0000
Received: from DS0PR11MB7997.namprd11.prod.outlook.com
 ([fe80::9105:2b7c:b256:7a6c]) by DS0PR11MB7997.namprd11.prod.outlook.com
 ([fe80::9105:2b7c:b256:7a6c%7]) with mapi id 15.20.9182.017; Tue, 7 Oct 2025
 20:53:05 +0000
Message-ID: <72f051a1-403e-492b-8a37-81b18a651851@intel.com>
Date: Tue, 7 Oct 2025 13:53:02 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 01/15] x86/cpu: Enumerate the LASS feature bits
Content-Language: en-US
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, "Hansen, Dave"
	<dave.hansen@intel.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>
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
	<peterz@infradead.org>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"bp@alien8.de" <bp@alien8.de>, "mingo@redhat.com" <mingo@redhat.com>,
	"geert@linux-m68k.org" <geert@linux-m68k.org>, "x86@kernel.org"
	<x86@kernel.org>
References: <20251007065119.148605-1-sohil.mehta@intel.com>
 <20251007065119.148605-2-sohil.mehta@intel.com>
 <47fb7efd89698f46a305ca446d0e4471d1f24fbb.camel@intel.com>
 <5d95d421-1413-46de-a578-c2a0e44e3aa1@intel.com>
 <ea578640-c02e-4ba9-b0b1-e9a5c9c313a9@intel.com>
 <8cc8306a5608f68d6de7ed367afb50fc382e1cf4.camel@intel.com>
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <8cc8306a5608f68d6de7ed367afb50fc382e1cf4.camel@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR11CA0101.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::42) To DS0PR11MB7997.namprd11.prod.outlook.com
 (2603:10b6:8:125::14)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7997:EE_|BL3PR11MB6457:EE_
X-MS-Office365-Filtering-Correlation-Id: 888f6501-64ae-4ddf-44a5-08de05e3838f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M3FpcVMvL3BzUVVKRDJuanNnaWM2MTdJU1F4N0hFeGVWMG9ZM1lOWE5HSWlq?=
 =?utf-8?B?WGJjUEQwbURhN0d3aWh4alZKTDBvd3RiNXJuRlZDeENMOGdkbS92TnM3bnNh?=
 =?utf-8?B?MDk0cmVWUEk5RTVrYkpXc21mZWxkMmQrMGlvZmpYdVNJd3o4WnNHd0VVcDFV?=
 =?utf-8?B?SWpvSGVQSmpQaThuZnU5dXZta0xva01BVUFwcEZjY1daUjR3N3g0U0pGSlBV?=
 =?utf-8?B?QURmbm1vQ3Q1S1hoZHJoVlAyQ0NzaWNZSGc1Ti9VZXFuTWdWQW9EY0llWkFk?=
 =?utf-8?B?VU1jWG5iMWkrTGEyL2lZK1BUVUxDZnpjOUs0bHhpQlJjK0NCb0l6VGJ2aVBL?=
 =?utf-8?B?NTJVRFVTaGRSdUhxT1F1VDJKcjlWS0F3MDlqR2k4WDZjRXFRQ0pLNEhVUzBV?=
 =?utf-8?B?dW05STdHcVhlSUZLVndiMER2RDlYVFRsbGVzRXFQZkU2U3c4cW1OdVloQW96?=
 =?utf-8?B?RlJUSDlvcndxcVdlcW8rL0hGSVZwaUhjNmhtL1I4dWNIMjFBcHdudGxIUXA3?=
 =?utf-8?B?N2dTWmZiNks2QThRR1ZZMkU2WDhmYUE5SmpyMmo2eEhvQWtEMGN3Z1RrUEh6?=
 =?utf-8?B?bmtSUVBxMU5VRTJDbUJTUlFMMmRFcjZMZ3RueXFBLzZTM0xDanByUFN4Snpy?=
 =?utf-8?B?V1NEZ1NjWTNnMFB0aUQrb1BCeFRvbHJsREdUL3NMQTdsUnRqaUFvQmoxeHky?=
 =?utf-8?B?ejB4YnJRWFRzMGVOdEJHb0pkOS9NN1pnVm1iMmJSSDF3UnhralR6enhsUmhi?=
 =?utf-8?B?eStnT1pOU29VTFhNeVB1VFNMTk93T094U29FUUhGbyswa3RkY091STNES1l0?=
 =?utf-8?B?SjlhVHZ5WklsWHRmTkJqRGluOEVadGdKVjBCWjlvL0lKM0c2SDh4aTU1OFJH?=
 =?utf-8?B?Q1BCTGxmNXN3WXBZRHh0cngyNFNUZzFzVFAvam9PY0tmNTRSeGp5YXp3YXY1?=
 =?utf-8?B?dmx3YzBFNzZuOG50d1ljdDVIVkpLemlhT3VVVnBJWDlrZzIzekpZbXB1RllC?=
 =?utf-8?B?RmYwRTYzZGUvTmRwSDBrNlU3Rm9wVjVTSDJwZi9rQXJWb253M3haYVl0Sk55?=
 =?utf-8?B?eEp1RUNndGNPaGtxWG5mRnhXM3pYdkxrbHFoQmg4eU5JbndobTBsU3BXK2xT?=
 =?utf-8?B?cXJuaTFVcjQ5MmhOdXVsWHdFaGlOaFJrdHdyY3ZGNDUwTi95bTcvNGhPa04r?=
 =?utf-8?B?SGtBR0wxaHRJVE8yWGdsZUN2Sktsa0xNWUxob3FTejJ4dWk3WGM1NlJyVFVV?=
 =?utf-8?B?WFFYRXowdkUrSTVIVHRuT21nOHk2UEl5WUhnOEJWT3JzNFczeVlXOWppVHJx?=
 =?utf-8?B?TFlsZ3VPT0wyYkExT1oxeWdiOWZpN0hqVjFOQUY1OHJNRWpQRUdkNTEwV3cw?=
 =?utf-8?B?SityLzh1bFYvb3JRY0c5T0lqYThCSHN5anFOeFhhZVgxTzJOMzJISm45YlFl?=
 =?utf-8?B?cHlzNnZibTM1YjN2Rzc2Lzk2VE1KcXFjWEJKMHN3TVl1UE11TnRZVzhpQ21X?=
 =?utf-8?B?Nmk3eWV1OHhTTkNkTm82S1duM2tibC9QSXN1ZFFiWWxkSDh6bFoxSUF4NmxT?=
 =?utf-8?B?N1ZhU3lQZ25WbkhCRnRGRU94NmRhRHNYVzJTTVVtTUgyb1JuSHptRisxY0JE?=
 =?utf-8?B?QjVoYnhEQXd1djBLTmFWWjJOeGpyWXEwVTJ2UXlUczM0VVFQcTlqTEw3SzJN?=
 =?utf-8?B?ZlpJOXFzdmRIVFR3SXk5djliTkFJZnlvV2ZJaEM3ZDNqT0ZmcERzM0dQaEhG?=
 =?utf-8?B?SWEvQW8wc1BKZ0gvaUlQTldGME5oOUwzVzAzMjU0TTJyOU5FUSsvTXdBQTJD?=
 =?utf-8?B?ZWVOSUw1ZnZyWWNRb3M4WnJjekVSNHNCaEd1RGNHcDJUa1dLci9wMytCZ1hi?=
 =?utf-8?B?Y3ZiMmZsOVZmR0NtWGdYcmpKM21lSnM5MXkvQlRCK1d5V1hPRy9wSUNDQUts?=
 =?utf-8?Q?rkUMgguvYaHJ14vcCCv+GZgQtiA9SeA/?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7997.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QVhYUU1FdlZ5Z3Q4cGZVaXFBbXVKUjVrdzU4RkN1d3ZKdkdBR0w2UE9KTTlj?=
 =?utf-8?B?UWp4UnpnQ2EyYjk4ZEJGMUllTXVSZGFXOHVLRm1scU5GR3hyRnpEcVFvZTR5?=
 =?utf-8?B?RmU4L3BnYmlUZ2sxWk53SGpSK1JRdlJUU0pKb0FoajhYU2cyT01KbFIvS0E1?=
 =?utf-8?B?RldHZWNxOHZjenBNVFVKTTV6MTFFVlFHR2g0VkhJZkppUE8vbDNEY0dNVlV1?=
 =?utf-8?B?R0VWT3pQeGxYM2MrLzlWSk4veVd3RkptbytxaFBDRnozOUJURVlZMU13Q3RF?=
 =?utf-8?B?bmtPZlgveS9QQ0Rvc0FCM2NHVVhmWmd0bk80YTAwN0hXZXFGRExHZmxjYTR2?=
 =?utf-8?B?WjJ6VmNtVHEwS3lRbW9zZG9PanZDeklSTml1dUFxS2N4YlVwL2NKVmg1WDYy?=
 =?utf-8?B?dkZrWkpuclpNUjZ4MURXWDdYU08rS3lVTzJIeDZJdHMzM2FSWmxVK0dDdHhZ?=
 =?utf-8?B?M0NkZkVZTGJLbDJkZWplZjBYYTUzOFhpbmh0Z0h0OTEwVktma1hBcjMrN0RZ?=
 =?utf-8?B?NGdtdUF6UjM0SmJJU2NZZ1YzMTM3c0hEeWRjZ1hBOTFpb0R4NDk3czEyZVFS?=
 =?utf-8?B?czVNcXZPQVBQUjc1bW80K2NNbDQyd0tDL05MNE41SU5hWW40VnBaSVliSFU4?=
 =?utf-8?B?K296elVYM0tCU3ZIY1ZicTJQci9TQmNvN3djdGZyZDZ6endzNDhHQmtubjJ1?=
 =?utf-8?B?ekZ5YnVNZmN2TWZlRkwwb3R0YmhwbU1GWjdheXhUTkxCWlEzcGg2VG9iZDF0?=
 =?utf-8?B?cmNPTHJWRHh0RGowSmtJbEk4QU1zOGVhWjcrdk15NGM0WlZOVXRSWnVuWk12?=
 =?utf-8?B?YlZWdDNaS21mMzMwbTNNTWNWTFJDQjc0b01xZzVvVGkxa0JDUnZGTVZlRU1u?=
 =?utf-8?B?MDY5ZTBIbFd3VlRWdkY5MjhaUWszWVRLSVdyNkZRbnMwSVZjb1hId2lxcEN1?=
 =?utf-8?B?Q3h6QXV2dVdZZmVFdU91WkpaSHZEaVlYeU1rQ1VDM1NWNWxocTJ3b01EOG5Y?=
 =?utf-8?B?dW5Ic1RHY3FQOUNYRkZtaTZHRnNCakpxYXFXS21oVFhqTC9TUUhjYy8wUitQ?=
 =?utf-8?B?UFlYUUJWbGMxT1ZuTTdGUXZCN2FJY0pDQ1N5SmRBYWl6RGpUU0ZJVlRTdnk1?=
 =?utf-8?B?TDN3UFRwdUJUdVIyREJ3dlltQXAwTlNrdmZqakpJdVNBM2ZlNVZxc09kOUk3?=
 =?utf-8?B?MmlJVFIrK3ZDRmY4S1hDRlZaUXFiTENXSkRSR2pDbVUwRDJXcU9YTUR3dzlD?=
 =?utf-8?B?YW5QdzIzVUp2bHgzNmJlTWR4aEd4OGc2YjJqSkZmU2hFUSsvSC9lSWUrTTRz?=
 =?utf-8?B?azlsSG02WjZFTTFHN3IwdXlBZVJERm9OOFJTSVNtczNVL1V2L1dDc05YUmVM?=
 =?utf-8?B?eHVrMjJEcEpKVlVScUl3ZlZuZXE4UmVaejY1dFA3N3ZaNGtlSjJpZFpON3Jv?=
 =?utf-8?B?K3NheDN3NEUzRC93cjMvM0ZXeWZJUko0RjljQkxQcFNzd1pYZGgyd3FuRDhi?=
 =?utf-8?B?RWFieDJBUVZEM0lIcUM0Slh2cUEzdVlIOHhJL1NpM0QzRWdBNnZVcnJyOW1G?=
 =?utf-8?B?QVBiOXF2bGthQlNLYkFPd2pRQ2t5YjFPSGpkcUZobTdMVG4xeS8rZW1xL2kw?=
 =?utf-8?B?ejk3TlFyR0RiK2M4OWdtTUY2QmhWcXFieXoxTWdJQmE3bnEzVjZXL3dYVWhO?=
 =?utf-8?B?cTE5cklmSzJJeUpQN1pYWnMwbFY2LzhRK2dXam1rVzRvLzRocERCSXJyeFhW?=
 =?utf-8?B?R0Nmam1BQ1JFY0RhY1l4YWErdU42NHQ2MGQ4ekNhWmJGWjZrVyttem5MMHhI?=
 =?utf-8?B?L2I3RXVwVzNBNEUxMFdBcS9aekFBMDNEVVo0U3F5TUJRWDd0TUZwWGlreWNC?=
 =?utf-8?B?bHNzYWZKSTZXWmIzeHlOdktDTEJlM0dleE41eGhRSnFoSnk2T3hpK3dldkUz?=
 =?utf-8?B?cHBONkw0UGhSUHJBMThER2s2RHJBMlFiandRSVY4VjF3M0tCYlhJV2M3UWFQ?=
 =?utf-8?B?dDYzZjErRStOaWdQeGxBWTF0eldJSm5aY2UvYURBTytFNmprbWJVMmdUSFYw?=
 =?utf-8?B?Qk5jZytnUDEzeHNlT2JROTZKYnE0RlV5WU9UOFRsMzNYeGhuM2pQdnYwSU1V?=
 =?utf-8?Q?npQedbrwI+ApaEEu1ZeXgnEUH?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 888f6501-64ae-4ddf-44a5-08de05e3838f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7997.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2025 20:53:05.7498
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hwdCv6hrAFlDj8IuRHkF6790mEWted55bKfIRbQEZzG0X0UMrJ5cucYWNaR4MfuZ6d34Kdpois1JqqdFL5JqLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6457
X-OriginatorOrg: intel.com

On 10/7/2025 1:38 PM, Edgecombe, Rick P wrote:
>> One could argue that the LASS hardware enforcement of the kernel data
>> accesses *depends* on SMAP being enabled.
> 
> The fetch part doesn't though?

That's right. The instruction fetches could have depended on SMEP but
the spec explicitly calls out that it does not.

"A supervisor-mode instruction fetch causes a LASS violation if it would
accesses a linear address of which bit 63 is 0. (Unlike paging, this
behavior of LASS applies regardless of the setting of CR4.SMEP.)"

