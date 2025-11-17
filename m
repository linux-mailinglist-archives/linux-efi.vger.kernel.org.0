Return-Path: <linux-efi+bounces-5531-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B821C65834
	for <lists+linux-efi@lfdr.de>; Mon, 17 Nov 2025 18:33:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B37514E67A1
	for <lists+linux-efi@lfdr.de>; Mon, 17 Nov 2025 17:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE9BD2C08AC;
	Mon, 17 Nov 2025 17:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cfME//Mx"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF74290D81;
	Mon, 17 Nov 2025 17:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763400270; cv=fail; b=J4Q9ndg1BUL2SN65W5xL6AfYHgI/u4vewmwKsBAgXkMM+m9uz1iM9dJQyNZFD90LRyCOOAc/qxedYrexpMR+Y4ImPwfWjN0U/6JEI8psZ70Ewr7tI48i/59tqZ2EsNRqoprwiH4X5iD5S2epPdp9Vb7O2sMYDYe9MnBASgJyhNc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763400270; c=relaxed/simple;
	bh=NP70uhh1aIQcxb2NlUVw7r0a8i9JE4NwfXsyc9bdKfs=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tobJeRNLZpQd9lrOhwYC6frm4+/MszeVs8NXcUtYYCe8AK54SXTtLb6tIP0eGimypW4PfqRPg4iGvUB0JVO61zWjtfuJ8dTw8lNCq30et7RKP8gTGPXxxCLiWnnjqrmdgEtOC3FKJBtgAtHYE59BepWSmwBAwq6qz1u3HnLOEbg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cfME//Mx; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763400269; x=1794936269;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=NP70uhh1aIQcxb2NlUVw7r0a8i9JE4NwfXsyc9bdKfs=;
  b=cfME//MxhF5gg9wFnpOHQocI8gy72CPNrZVEfZ+D8x8XrxYCQWwM+/KC
   cICrwkAPhsz5uFsA39V9HExUu9tQh6tGUPS6SoW3JQOFuXlw63jIpRw0y
   mteIRq5gEpa3b0irNeBlIyHfEempooPkWMI/PYwkV/MHzO7iS0tGIaeBi
   GQUkubXHcX6F0QF0sharJJIVl2xLNiOGjzcCYCX9mBnwaSuSDPU5XK6iZ
   FtTSjBHdv8CBWCi7MfQX/8Bc7/NLH9s0L8oh2prpe0mCPQ5ROZ6F8f8kF
   MFtww1AVdwKZCizbwqum3aneMOPuJ2+3ZhrCtzaZe8RctSZnmvK/6B7iG
   g==;
X-CSE-ConnectionGUID: 2NmwNDbBRVKuR1K+uaTJ7A==
X-CSE-MsgGUID: efCV509yQm2MwlQY5hIvaw==
X-IronPort-AV: E=McAfee;i="6800,10657,11616"; a="90883763"
X-IronPort-AV: E=Sophos;i="6.19,312,1754982000"; 
   d="scan'208";a="90883763"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2025 09:24:28 -0800
X-CSE-ConnectionGUID: qAcfj6doRsSysof+VzWC5g==
X-CSE-MsgGUID: kPQQqPSdROW39Jwc7KexBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,312,1754982000"; 
   d="scan'208";a="221164616"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2025 09:24:28 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 17 Nov 2025 09:24:27 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 17 Nov 2025 09:24:27 -0800
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.7) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 17 Nov 2025 09:24:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j4BKDNaezMZGztVHyDwcwHDvIUIubytY1O72G8N/NtjC17lxUpPffzqXUjtYpqYFF7+VxtkqW6ciFLd9bna/AVwuJNpHhnUwTWrORjaqofCM9KEDmE4HeYq31wf9XGGk/cuA/U1a/pjMYKeD/Hndy/+MiTu69oq8qL+Mt4LGpUKmIJ6OxRU/pdWitcoCKbtHGbc3ZEsANRZjH9iWjzR3c8/l4Lns49QVJDva1eZ1EoEnmbgbdjqQEWlfmqVS7tyUIx0GOrh7eBA3C+gqPAAgSr05RypbqzCS7MRfBrRXD59rAcGUFr+w1C0sSQD2LtWYVpsxKLW+t4lNfHmqIwHkyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jFK2UNcXKnRv7AXyJavqKvkzTzU7J164TKaRAJSSqYc=;
 b=TtIDQVEtvvLuXm97XgubwlEemdXdVYQINvURkunHYtBFHdpVq04NQtGreez+ooJRGdmgzEBOdpwFROYEyVg8xcUAZ64vS0MMoN4C/1BYG6hRsXkoVpDbuvK8moUwuyoxDAB95ULaFfy7A6TIFOEKHvSH40nJowfEQT9yF/8BpxPX0pZN206OP9qUSDr7zxhewMG2dSulU8G/YKBdfmpvcvlTPR37Ijbr+1WYl4tgFW6CzeR9rpSnvaeOjaz+D2DOo7+eqstnpby5gMSwqjfvwGnSai0Me4PmKXy48/bYSkFLHagB7xZuRPghJpv/8ofr4QQvD2UdA6BPIaE4qmzjjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB7989.namprd11.prod.outlook.com (2603:10b6:510:258::13)
 by IA1PR11MB8224.namprd11.prod.outlook.com (2603:10b6:208:44f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.22; Mon, 17 Nov
 2025 17:24:22 +0000
Received: from PH8PR11MB7989.namprd11.prod.outlook.com
 ([fe80::752b:acc8:a52:38ba]) by PH8PR11MB7989.namprd11.prod.outlook.com
 ([fe80::752b:acc8:a52:38ba%7]) with mapi id 15.20.9320.013; Mon, 17 Nov 2025
 17:24:22 +0000
Message-ID: <bfce23cc-bf7f-494e-a443-baea41f33381@intel.com>
Date: Mon, 17 Nov 2025 09:24:20 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 6/8] x86/traps: Communicate a LASS violation in #GP
 message
Content-Language: en-US
To: Borislav Petkov <bp@alien8.de>
CC: <x86@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, "Thomas
 Gleixner" <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "Jonathan
 Corbet" <corbet@lwn.net>, "H . Peter Anvin" <hpa@zytor.com>, Andy Lutomirski
	<luto@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra
	<peterz@infradead.org>, Ard Biesheuvel <ardb@kernel.org>, "Kirill A .
 Shutemov" <kas@kernel.org>, Xin Li <xin@zytor.com>, David Woodhouse
	<dwmw@amazon.co.uk>, Sean Christopherson <seanjc@google.com>, Rick Edgecombe
	<rick.p.edgecombe@intel.com>, Vegard Nossum <vegard.nossum@oracle.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>, Randy Dunlap
	<rdunlap@infradead.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Kees Cook
	<kees@kernel.org>, Tony Luck <tony.luck@intel.com>, Alexander Shishkin
	<alexander.shishkin@linux.intel.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-efi@vger.kernel.org>
References: <20251113224204.50391-1-sohil.mehta@intel.com>
 <20251113224204.50391-7-sohil.mehta@intel.com>
 <20251117144840.GIaRs1yNEYjdNF0SHu@fat_crate.local>
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20251117144840.GIaRs1yNEYjdNF0SHu@fat_crate.local>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0093.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::8) To PH8PR11MB7989.namprd11.prod.outlook.com
 (2603:10b6:510:258::13)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB7989:EE_|IA1PR11MB8224:EE_
X-MS-Office365-Filtering-Correlation-Id: 84cae599-2461-4c3e-fb3c-08de25fe2625
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Q014eGljQlpIYmtKV0ZjaElESjIxODRTQXFNWkNHV2wyU295S0FKNnl2T2xR?=
 =?utf-8?B?N0tPRXRmZVNtNkJ6TFFBVjZ3Q2toMmVHY3UxaGVOQmcyRSs0Y1RkWVYvVVl5?=
 =?utf-8?B?U3U2cjFmMGgrb1ZkUGhXeTZMWUJmZHlLK1h5YXkyMTZBUzVFTUhhNEdxS2tG?=
 =?utf-8?B?QlVmYW94RDRJWk1CYlkveEFzbjl6VGJEcW9VWnZhamhxUGswZmF2eU56dmZw?=
 =?utf-8?B?QUdqS0RjQkdELzREd09wbGMvendwT2xvU2xkd05GWFZmN3VwWkdJdmVkNm1Z?=
 =?utf-8?B?VnpHNUorcXZtQXdzYWphY29QRG9rLzBscmQzQndRRWtBOXdQbkZXK3ZlSGVp?=
 =?utf-8?B?ZVdZczJ1M0tLenFLNStLNXFwYmptaGZsTEZhMVY4KzU3Zmc2VnZDSVhwV1Bz?=
 =?utf-8?B?dmVIWVNxaTRhSmVnMVNBSGVWNXNidFJ0YzVCbW5CeFhlSGZLTzBkUEw2YU93?=
 =?utf-8?B?QnVyckI4QzRyeWhXZC9kMWVaSHFHUDkrRXBnZEJJOWhhVHUvd2QwdWRDbjN5?=
 =?utf-8?B?TWdjQkJrdzNaL1IwNHNkUlBhZk9SUmg3dXQ3Qi82TEY2ZWsyem1lSlVPRVVi?=
 =?utf-8?B?K3VBOWY1WisvL0J5cW9aWExPOEJnOVkvNHltV09yRXNRUWxVT3YrYjFiRUhS?=
 =?utf-8?B?OFZ1ZFFrcUttZDRvZGw5UDZhOHlxKzhGaUg4T3l4U3l2RFhZQ1lIdFY4Rzlv?=
 =?utf-8?B?RUF3aU8vbU1aY2wwMUxIYjJ4bG5laFJLZHZTbk14ZlpJTlN2SHg5cnNWOUhT?=
 =?utf-8?B?cEovR0pIYjJxVlBMSXFGT3JrSDF1WDZuQjVoTGFxTkEwS2ZQNFM1N3NNVjlr?=
 =?utf-8?B?Qm5pd1FyeDhFbXA2a0w0cDZpVmpnYi82cy9xNngrTVVGcXZMZ0QwU0lYRUE4?=
 =?utf-8?B?WllKZDV0RmNXMTZlQk9FUWZLd2NyM3c1OVNkc0xIUmtFY3NndWYvTWZjWk1E?=
 =?utf-8?B?WmV0V1BFS1RiT2xINktyY1lDRGp4dVd0d2pJNVVzOTFVNWlnQU1IRVpRVi9G?=
 =?utf-8?B?dzdGejdGVGtZUHF1aUpVSjNrTHRmb3MxK3doaGRqS0Q5S0djMXlFZWZMT21S?=
 =?utf-8?B?WThDQS9UTlhFZUJ4Ry8wc3U1bVdyNC9rdVF0SjBzbTgrckJDbzRUUzVldUo4?=
 =?utf-8?B?SFRHU1JUU0Q5YUdDcDFqR2NNZWxtMEFGaTZUclB4QW1keW9CMVNjYjlNQTlm?=
 =?utf-8?B?aHpEamU2YzRzNGlZQW95a0JidFIrNnozcVVCTmxrQ0xMSTQwRFdIdnhwNWQ0?=
 =?utf-8?B?Z0FRZFV6aU9lRmVmdDJNK1lVcG5hNERPaGVDR2JlWmJScFdxNUVEMzJ0b2FM?=
 =?utf-8?B?aG0ySmxTUlZTbjdEbXIwTGhldEZKZzRacllFSjJMS0szdVBQRC80WHdQYno5?=
 =?utf-8?B?Yjl4Q0Uzb1NRWXJrVVlMU2RRYVdkL2J6RU9KTGd5ek1hTEF3STBYZXFxamFa?=
 =?utf-8?B?ZVZKT1ZYZVFGamM1RVYxRU15Q1paTVJLNnRJSVpNWDZ6L1ZDWGV2RTBBTGUy?=
 =?utf-8?B?dUNFaGZ2WHFTZ0ZxeUxSYjNEcXo3NXRGQU9ZdTZQaXBNNFZOT3lMSTlaNlJW?=
 =?utf-8?B?QkdoYmN5bUpSOGRvZXJMVFR2YWhWSXo5b1RoVWxDMGpzRG11akIydzZzd3du?=
 =?utf-8?B?N2Fma2FSM0diREhTYjNRL2N3QnNwWS82V2dhOEVHZkxLaUl5L2xIVUNnbFhX?=
 =?utf-8?B?NWFSZ0tBSWxVcWFQQVowZkpkNWo3U0dJR3BrSGhtTE81bytxL0xJajl4cWJF?=
 =?utf-8?B?bWF3Vk41a295UGt2dW9xN0pFMDduZTM3Vmt6ejVDamFtVnVTeVZ5MjkySGNl?=
 =?utf-8?B?VnRkWDNSeVZYR3VkQzRJdFNkMUhTRW5LaHo5UDl0cHl0VE1kUXlGQ3l1dXc1?=
 =?utf-8?B?RFZlQU9hc3VZRVJickVmZmRpem8zOFI4RG1UMDVvMWZVcEtNR29XK2k1ekZq?=
 =?utf-8?Q?UWAKan2rsOMddq9Jg1D1sa6U/SEbChtf?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB7989.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cjZSUURvcWRyUVVxeDdydHgyd2xQREd6Qlc4V3VDaktTQ29yNWRCU01kUzM5?=
 =?utf-8?B?b2tCTnZLS3U1ZmtqeVdtS21SOFQ5cXNJeTlLWVZNOWlWV1VUOHk1Y0M3SStI?=
 =?utf-8?B?WDJxcEV5NEZyUEYzTUZlS0R5dFV1OGZPYi9wZkt3U3V4YUNkWmo4WUx2RmFp?=
 =?utf-8?B?dytmTUpQNVk0SkRGV0MzZ2dhbE04bUtJOHQ5YkhOSW5HMDZJLytwQlg2REZB?=
 =?utf-8?B?Rk0wQkp3NVQ1Rnl4S2FKME44djIxd1k4bi9jZXN3UnlpQmJXS1VnQ3RrQ1gw?=
 =?utf-8?B?MThiZHA3aVBTdkg5WmY0Z0pLQzZGVlgvQ2FUWldqd21mVnlubjZiVXp6NG04?=
 =?utf-8?B?YWtZeGw3UE8vNVJlTG1hSEI0dUZjcHcrWVJkZFdxSEh2NlZONHFJcCtYMVFB?=
 =?utf-8?B?S29zcS8vMGRGWFBQcVI0Z1JEN3lJSlVMUDhFY2FHUlNnQ1REQ1h0SjE1aEhh?=
 =?utf-8?B?L2JSNUEydmNEMitsakU1YUZRazlja0NWQ3NJNU0zeVpOSW5IdkVINlNOUkxm?=
 =?utf-8?B?TzBPRTYyWlloQ2IvTTVwcmZkTGV2ZmJHbEJVQ1NEd09HMHJ2L2FpNW1Zdkhw?=
 =?utf-8?B?SkFCaDJSQ3JOYmRoNFMyU1hTaTNGeWJzWFRlZU80Um91Skl4Zy9DRHRJcXpn?=
 =?utf-8?B?NGFpMjM1OUxsbUUvemdiUHlSQ3B1MGNSSkR2T3JnNXowZG43WUhORTVKUGhQ?=
 =?utf-8?B?cDB0bDhpb01qZ1dJUFB1R0FXNHNNSXd2Z2pOeWV0SUM2QjUwZVk4V0RsRlZt?=
 =?utf-8?B?UXIxL2sxQkVEdEV4eG9nTXN0cUMyZHdoOVBDRExSaWpheTM5TUNYSkk5ZmRp?=
 =?utf-8?B?NTdEdHB0TmpkZU1XSGU4UlFsaWpNR3BGbHhhZEpnVmVpVjMwZEVSa0l3UlJT?=
 =?utf-8?B?eENtL2dZeExCdTRMUTFaTC9tTU4zN0dQdXhndWdyUE0rQ3lTWDNuK1FWMTEz?=
 =?utf-8?B?VGtydVpVKzNJYi9objN3dVYwdXh2R01jVFZCTjRGZk50SDlWS0pvQnp5OXAx?=
 =?utf-8?B?UW5NRmZ4ZjlXdEZ6S3VKY1NFSllWdDdMWFU0M2FTK2xzY0FMbHU3YW9wYlc1?=
 =?utf-8?B?SG0yVldBak5Za3Z5Snk5VG84OHlYcHB0WWd2QlZYdFJvSHdraHMzMmlDcC9W?=
 =?utf-8?B?cW5EKy9yL00vUVl1V0RhNDBMOG5QVk1tZGk2Mm5wQUxGNkxlRUFyM3lFU0FG?=
 =?utf-8?B?TGo1ckdNNTJISlEwSE42QUMwbjJvam1OSXgrSDdPOUlnMGtBVU94TUY4UWVN?=
 =?utf-8?B?ODZ1S1VoRGFmbG44c2RqaDJxdnRCT09jYW84TWlzYk9Na2Z4bXZod0VVcG9x?=
 =?utf-8?B?bjVSa3YxM1gyVkFrOWt0OHRURzd1QzE1a0I5aDlpeHVGUVpWOUlOUUg3anJz?=
 =?utf-8?B?c1lOYlZVdGhGQ1NyNmlhOGd4bm01eDYxL2VuVkIyVUk4a05yeWNwK05rQjBN?=
 =?utf-8?B?YVBCdDZHYjdRVi90L1N2NXZOTkQ5ekwxY2JWb1ZsaDdPQjlKYWhtd0wzaG5B?=
 =?utf-8?B?UEQyVEUxQ2hSay9yQ1NlMnBHOU5Fc01UL3g3Ylg0NjRuV0ZrSjlnMlNkbFBw?=
 =?utf-8?B?VGRwRmFhZ2ZwOFVLQTVudUp2bnptRW5aYmRIS25oSXJQbzF6ZWRZRXFmbWRK?=
 =?utf-8?B?VVdUNUZTMEVuZ01yV092NXhsOXM3eURBZlJGbGtXL2dKTko2c0pmSXd5T0tS?=
 =?utf-8?B?TjVocDNSK2xOYTZNZTlvZ20rOXU2Vk94Mjd0RG00bDFIM1BKa29waWc4bEtj?=
 =?utf-8?B?QjJOSm80eGVrc3pSTHRob3BRZElZdVdFd3E2OVBFSzYwSkpNN0RCaVFwajZL?=
 =?utf-8?B?SllYeXhGRi96UE1wOHorZWJscDdGTmZLYnJtVHhXb09mTXZZVG1ONE5nQkpx?=
 =?utf-8?B?NUM1QTMvRkU3QzVaVWZXSHFaQWlYWC9sRkE1TVE4RUN3cjM5bGhlS2IydzRo?=
 =?utf-8?B?dkpvZ0hqclp2T05QbmNFNDVlZElmeDZwWDBseDVCdEkrUWV0R3VpU2Vvb0l3?=
 =?utf-8?B?UEhleGRzaFFabjRVUmdKRGx1MGVycmlINDJEeWJQSHlYOEJudVE0MEQraldB?=
 =?utf-8?B?WDNTeElJM283ekd4Z0RLekNKLzNGSHIxZXhSMDkrZTBER0hvQ3FKWldTbDU5?=
 =?utf-8?Q?SC48resn/JL4xPFNJvwjHahWC?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 84cae599-2461-4c3e-fb3c-08de25fe2625
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB7989.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 17:24:22.6408
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iqneNj8OZGdTjfwdWmbXJqoCBY4z2H+YLpBZnvOC8XBIJ5gYw3+ljQpRb0HGQ8jUEgL/HvPzmBkCjTIftjXBxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8224
X-OriginatorOrg: intel.com

On 11/17/2025 6:48 AM, Borislav Petkov wrote:

> Why is the first page frame special to justify a special check?
> 

Any dereference to a very low address (the first page frame) is
typically considered as a "NULL" pointer dereference.

$ git log | grep "BUG: kernel NULL pointer dereference"

    BUG: kernel NULL pointer dereference, address: 0000000000000000
    BUG: kernel NULL pointer dereference, address: 0000000000000010
    BUG: kernel NULL pointer dereference, address: 0000000000000008
    BUG: kernel NULL pointer dereference, address: 0000000000000008
    BUG: kernel NULL pointer dereference, address: 0000000000000040
    BUG: kernel NULL pointer dereference, address: 0000000000000264
    BUG: kernel NULL pointer dereference, address: 0000000000000000
    BUG: kernel NULL pointer dereference, address: 0000000000000098
    BUG: kernel NULL pointer dereference, address: 0000000000000000
    BUG: kernel NULL pointer dereference, address: 00000000000003c0

The page fault error messages have similar logic:

if (address < PAGE_SIZE && !user_mode(regs))
	pr_alert("BUG: kernel NULL pointer dereference, address: %px\n",
		(void *)address);

I believe the check is to account for arithmetic or other operations
that may have happened on the "NULL" pointer before it is dereferenced.

