Return-Path: <linux-efi+bounces-5318-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B28FC26930
	for <lists+linux-efi@lfdr.de>; Fri, 31 Oct 2025 19:33:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A13073AC00B
	for <lists+linux-efi@lfdr.de>; Fri, 31 Oct 2025 18:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C5901DF269;
	Fri, 31 Oct 2025 18:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c4TMZZ6X"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB0B405F7;
	Fri, 31 Oct 2025 18:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761935579; cv=fail; b=Exfpdybmqi0y+363qaPWMGbHCcVmQ/nY58hq9sw5O3H0ptxh+cRZYdkHo8ukRbLNzqbWVfccREnWTWnlup14xQ5TJSBrXSPx+RlTdsJxddSBCjLmtQFxD/nf2vThQR68+NoBj5PvGrtTRDVBZoY2//ovTbKm1M3eB/YB0oY6cig=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761935579; c=relaxed/simple;
	bh=BWCAGT6A+GbMSr+Tcuca7B8nzoQkUTlv9thtEIg+Zs4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uhg09N+W9PSOsGAtV+pKLcWlONqJs8jojD/3ZjX7emeJ5KxSmdGyKFvrXSCMINX70yHSe4B7pwZx86oeRRjgAG2B5jE87DjnmrvbM/AGbopCOZzllP+Jj1a9mX9adjUes9RUow/6bnz6Y62O5j6E3uY9bSdFyLsdJQd/eehDa54=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c4TMZZ6X; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761935579; x=1793471579;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=BWCAGT6A+GbMSr+Tcuca7B8nzoQkUTlv9thtEIg+Zs4=;
  b=c4TMZZ6X5P4hBwerFhHsyCUQ9+ZLMrHtXOR7yDk/OgfBk3zdbM1FlsKi
   OPCejhaQJGd6R+4SdkN+lFbYa6j3gwtrNO0ytWlG8GmcxZMZzQtOXD0rp
   Pi1q45S/SugE/ZCjgOlNE6Ebp2k+i+W3kZQn1iUukA8wxc65xyGvO7/Mh
   pAK0MOhCRPOwzjyhUVuO7PUhMiN9uv1wUZAl3hQy7rWA43Z9HvRAT0l0z
   Y++rvNkqLTYmd446LmUYhry6ViexgNOUswbetS64ds1VnZIuHXA1jQmdq
   0wHqyKgJx6Bb2c2CAmI7OQyeLzBqDwNGVf3VWqDXc1TYqVugOa4uTGwP/
   A==;
X-CSE-ConnectionGUID: ekNy2KsERuucRW2gVrwcGQ==
X-CSE-MsgGUID: av03vZuEReuy3LZsjIK9XA==
X-IronPort-AV: E=McAfee;i="6800,10657,11599"; a="75219316"
X-IronPort-AV: E=Sophos;i="6.19,270,1754982000"; 
   d="scan'208";a="75219316"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 11:32:58 -0700
X-CSE-ConnectionGUID: Eeo1iW85Rn+dk7bn2EDzeg==
X-CSE-MsgGUID: /ZYNikB9R9qheYnWj4QJHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,270,1754982000"; 
   d="scan'208";a="190649485"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 11:32:57 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 31 Oct 2025 11:32:56 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Fri, 31 Oct 2025 11:32:56 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.6) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 31 Oct 2025 11:32:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UE8daqnOMB+/bUp88BTwHJGf0TGS6qGhSR0c6DdcIzzzPYwQXVFb68rGKbIwJzeiVP8z4kRCaAFMjpsxI5I8cbBm5pexd1U9mNsJpSpR0hYd1EgaNfqa/OfInjWC3Sr23+Tq2sunYhEn+G21sgHFVXbrmktsqCcA5LrG7LcDjpXjy3ShjAmp/xLxs8VTN+PPTrWQbabK7l3j1gyGiuX9tunH19s3YMViTmQ8AR7pkkcKZ1pfvfPDYSMW5xtpQsAu0lis6vjkhe5FRhqMX4IRgIai+VKnKqMc88XuQNe+UsG0jUuPgi9V9i9oBDoH7WPgG80dgduP5dFrIrXgdzMlBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WQdb85brYWIh5r1vJdxMOScB9M4o1hTptfB964bXLk0=;
 b=hlIIUKVQj3/P0Ujaf7e0QaAjSeIDTWq5bQv3yJMmbDouW4QAIwXPMKuGIS8B0RVjpBCv6kBeXbUh9eVDD/KjnfCLJORW0Ta0n98qKKS04HRUuOfwFvZFJ3jCptnpHZprG5g3twGqTF2e3gxI/1rRSJ4JhhA+BP/Wb9rb+cTuH63LvoGxw9w0NX3+bDkSey5ok918sPcS5wKIbm5onaAHlw8YyW/5Eg1ok+TOru9hMYlmnOInK3upxvWcPkNMzHNZC57DWFEr6rC3W9oqxNkJEntfyqva6OSCmiA4pOKjxM9xd/cRdoF/kO27fSrcmLFmbZWwwlIfeMq89LhQt/oeuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB7989.namprd11.prod.outlook.com (2603:10b6:510:258::13)
 by SA0PR11MB4543.namprd11.prod.outlook.com (2603:10b6:806:99::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.17; Fri, 31 Oct
 2025 18:32:55 +0000
Received: from PH8PR11MB7989.namprd11.prod.outlook.com
 ([fe80::752b:acc8:a52:38ba]) by PH8PR11MB7989.namprd11.prod.outlook.com
 ([fe80::752b:acc8:a52:38ba%7]) with mapi id 15.20.9275.013; Fri, 31 Oct 2025
 18:32:55 +0000
Message-ID: <1f3070d5-17df-4fc8-9700-bb8e37a3b0a1@intel.com>
Date: Fri, 31 Oct 2025 11:32:50 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 5/9] x86/efi: Disable LASS while mapping the EFI
 runtime services
Content-Language: en-US
To: Dave Hansen <dave.hansen@intel.com>, <x86@kernel.org>, Dave Hansen
	<dave.hansen@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>, "Ingo
 Molnar" <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
CC: Jonathan Corbet <corbet@lwn.net>, "H . Peter Anvin" <hpa@zytor.com>, "Andy
 Lutomirski" <luto@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>, "Peter
 Zijlstra" <peterz@infradead.org>, Ard Biesheuvel <ardb@kernel.org>, "Kirill A
 . Shutemov" <kas@kernel.org>, Xin Li <xin@zytor.com>, David Woodhouse
	<dwmw@amazon.co.uk>, Sean Christopherson <seanjc@google.com>, Rick Edgecombe
	<rick.p.edgecombe@intel.com>, Vegard Nossum <vegard.nossum@oracle.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>, Randy Dunlap
	<rdunlap@infradead.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Kees Cook
	<kees@kernel.org>, Tony Luck <tony.luck@intel.com>, Alexander Shishkin
	<alexander.shishkin@linux.intel.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-efi@vger.kernel.org>
References: <20251029210310.1155449-1-sohil.mehta@intel.com>
 <20251029210310.1155449-6-sohil.mehta@intel.com>
 <3e9c4fdd-88a8-4597-9405-d865fb837d95@intel.com>
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <3e9c4fdd-88a8-4597-9405-d865fb837d95@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0387.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::32) To PH8PR11MB7989.namprd11.prod.outlook.com
 (2603:10b6:510:258::13)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB7989:EE_|SA0PR11MB4543:EE_
X-MS-Office365-Filtering-Correlation-Id: 3191ae0c-ebe5-49b7-b5ba-08de18abe83e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dTJCSHduSWkwWTBGYmV0b2QzaUZlWW80ZTVyVGs3UXNOOGdvenJZQ0p3NUo3?=
 =?utf-8?B?UnBGbEpQUG9QVkhtc1JpV280aWVFOUNwMjV4aTU3S3FqcmJGQ1RoYXlUVDBL?=
 =?utf-8?B?VElxVWpRWGY4R0U4azdVcFRYNm96a3pKa3FoMTdRQ1g0Q3lHNFRocUFrcEl5?=
 =?utf-8?B?YkZUTHdJZHFrakNWK2VMdHZ6cEhRSkJZQ3JGVGx3V0VZb1h5OFRoV0RwRXpE?=
 =?utf-8?B?djVQeXo3YmtRbEdhaFc2N0xpTC9BTlpiMjN4dDU4OEtkaDIwWVV5OEpGdUl5?=
 =?utf-8?B?b0t5bjVaNXM3NDd1TUd3OXlrNFBpWElqZzBLSzF3WVV3Q3ZsczJrS09nSW1z?=
 =?utf-8?B?WlRxdklQTVIyV1pVbGNtVENNWlp0R2tYZktGTDE3RGxXYzVXVUFWYThTSkNV?=
 =?utf-8?B?MS9Oc0FGWkplVVQ3akNOMCs4Qlp6bDlqcFR1d2lXckIxMWNabVMyWVo1bXdy?=
 =?utf-8?B?aytmMTUvNjRBUGpXdCszTEkzbFNtRUZNTDdPQ0hORis0ODQxdnNJdU14eVJk?=
 =?utf-8?B?RzRHNEVXdGIzSU5OSTErRDdkTjhiRDZPVFpZWU5Gd1Q2WHNZWjFkeERmaVl1?=
 =?utf-8?B?aGVFN1BHQjNsTmlyWXpKSWwvOGN6UXZpK3ljZXdveFEwTnNwNnJIWS8xbk9q?=
 =?utf-8?B?RXEyUFVJeXUrQnhlTFcyMDhTZEVlWGhxbDNDR1p4UFhHYmRRcUx1K0tpZFB6?=
 =?utf-8?B?SUdyaDZIMlpFa3k1K1FFYlF3eGZ0N1BKWFlkTzFNa1g0Z3g1MnRhUFZMa2Jx?=
 =?utf-8?B?WURobjFuUzZRRmN5dkJXb0NtL3pQSHluYUwxM3dwT2pMZ2tDSE9ZQlZoUTNm?=
 =?utf-8?B?UGUxYTdvQ1R0enlLUy9McytLcDF3WFRsVWN2U01oa1lQMFhObE1iUlRIYnBn?=
 =?utf-8?B?TTJuZWZkWXBiZXBuYVNNczFOMEs4MFBUVWFzamtvaVE1REsvWEFrSkdXTmFH?=
 =?utf-8?B?Znp6SnBZeDFSRzZJc1VSL0lYV3ZIQ3lnS0tkSG5UbHppYitPNXQvMjFMbVgw?=
 =?utf-8?B?RkwxTXp5KzVKcU81c3Qzck9mVXBtRlIrQWlFckFRRGV5OU9HWklIeEswTlVK?=
 =?utf-8?B?amJkaVZGMjBlRlN5Q043M2hWRkhxdURyZG5PUXBRTHAvRkhoampnYTc4TnZM?=
 =?utf-8?B?ZTRzdUgyUmUvcUxtQVhqK2JQOUhnaU9LNTNDYTBPOXdPN3FFSW9waTlUTmZk?=
 =?utf-8?B?NVRrQnJzaXFXV0tkT3IvTW9yRHY0blRIQVlrekxYQ1FDS2dacXVOWDhMTzcr?=
 =?utf-8?B?ZmlLT2ZuYTdFS1lCTGY0U3VKVEdtNzN5M2Q1eGhQMDhhcHhuMkpxVlh5eVR5?=
 =?utf-8?B?WjdsR2d2TDk2Q01QVGRGYmJvbzdDWGllVm1LVU5zZjcrYmI4TTQ0ZW8wMDJG?=
 =?utf-8?B?cUNyUHhJRmVOMGF2dktZMWNoOTYxZmloQTc4SU9TS0FDRmVMQzVwQTdZZmZk?=
 =?utf-8?B?WU9oZSt4ck1YZWZacXhuZkFvVkJ3aWU5eXhiZ1dFVjBUVUQ4Y1JGNStoTDNW?=
 =?utf-8?B?SXRQRDByMVVUZzhOQnVFWUxuS0R5UFUrbHI2NFFuMEVPbnlTSVpDQzlNZ1JU?=
 =?utf-8?B?RVRjK3JPYjVJcE9mdnI0WVh5UzlKMFdDTEd2a2Zsb3VlMnhhck1wUm5Ta1pQ?=
 =?utf-8?B?RytGVHVTS205LytIV1VIZmh1T2htU04xZVdZTFBMTWJBbUZYUU1GakF2MjVy?=
 =?utf-8?B?cGFDS2VvVTlhRDk2TU9XUUhtRmg2Y2V1T01PZ3ZubldEOHc1elRkVlhUdXA5?=
 =?utf-8?B?WnZLL0ptVU5wdjdXZ25pTlRhYTE2N0VxaEJLUXhJSmJQWHhPQ3lDZ2hCY2pm?=
 =?utf-8?B?SDE2M3RaUm9FOHdWSVBzOXc1b2VZSlVZZ0VvQ2F1Z1MzcmZSeXo2UStwa1k2?=
 =?utf-8?B?VjJpcVpQY2lBNDdBdFZwYTRvVUxmZGVWZzVPQTdXWkk2M2xZTnJFWXJPaXRJ?=
 =?utf-8?Q?Q2szfB66JdYp3kXLinykQGXUWlLMbNDf?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB7989.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NHZkVUJjRGEySjVlc212a2VFMUNQTW1kQTJQV0d0bjczR1FXeGEvdmdoQ3p0?=
 =?utf-8?B?YkwzTVg0YmU3K2lYNUdyaEF5RTNtUFIxcmVpZnkzZUZwc3Jycm4xd1NkRFRk?=
 =?utf-8?B?S2hmOVd3Q1haWEEzS2RCdHBBS1dmTGJOVFZYV2R1T016VGQ4OTVoNUh4TVQy?=
 =?utf-8?B?ZUJpTzl2YWFrcnpMSDhzcnV6K2R6WnBTSFc0WlhaOG90ZlpsVVJmN1RzY2Rt?=
 =?utf-8?B?MDdDcTU1aklLMWtGL3BJd3lTMXFVS2szWXdFZXlDRnpjOUNFbWlxY3BuWXVP?=
 =?utf-8?B?aHJNbk9YazUvYjJKRDdrZW93c1BPaU9jVFlwb1VhcG9SdWRnK0hrZ1oxc2s2?=
 =?utf-8?B?MXByT0dKODlnSTMzSEJYQVAwRDJWVjZNTkZwMjFIOEFIaW9FVXVFcDM1OTRQ?=
 =?utf-8?B?YjFDYW1FbFFNdU1QWm9XRCtIS3g1WWZzd1Zybk4zTmg2cFp3eWd0UFYrQW9R?=
 =?utf-8?B?ZmVEOFlCSi9LZXQzcDlrdmIrT01leHRPR0hRN3lzRno4cFJzc0xRankyb3pq?=
 =?utf-8?B?NkRGNFUzNEkxaDZyNXYxcUc4VkYvQ2dZQS9nZzFUaGZXSWR2U3lPS0V4djhi?=
 =?utf-8?B?SUZTaURyS3hVNTBwZU1PTVhPQloyWlp5ZVVFUWEyb253cFdxZTFXaTRZS052?=
 =?utf-8?B?Z3FCQTBCR0c0QnNvS3BZMXQybjBLbHEzYzFNcnBPL3hKdHEyMGorM2I1UjBS?=
 =?utf-8?B?ZkdUZXhFUjh6UFJJeXpGZGlJclRaZXlYRGszbDF5NDRhU25oa0ZxeFhpNHJo?=
 =?utf-8?B?U0dCRnhiV0NEMjVDVnhLNmlOK1NWR3p2NXhvRWxwTkNhdjhOZXNTS3pTaXJH?=
 =?utf-8?B?NUZqNERCL3J0djJMZVVPOEtVTy9xQWNHKzF5THlPQjR5aWw2ZkxwTnV0elhs?=
 =?utf-8?B?SHJkNFVSMzZQVFNDeTY2TWtKVTZVV0tScHhBQjVzWUJ0bzJWcm9jMk81WVlJ?=
 =?utf-8?B?ZllKd0lNN1U4T0ZBdVhkTTJCNHlwd0IrMnpYMDJMQ3BuZnE0RHdGaHJtZWhZ?=
 =?utf-8?B?TGJjRTNFVE1sMCtnWWxkdEdRWUwrVFNoRTRDek1HWUJVVEpSY2RkWU5jSjhB?=
 =?utf-8?B?blg5c1lVSFFKUmI4OXUveURyWklldFpaNitUcWIvQjBMVzhuTS91aUQyYVdC?=
 =?utf-8?B?a0JjbFdvNEFSQmIyZVJNcWhSbkdOVWYrOWVVRnpmN3NDRS9YeUg3RExlczBa?=
 =?utf-8?B?emRITklOMVZHdkxOZm13RTFHMmFzNjh6SHo5S3NTRXY2TURhRU5oSmdaTlZW?=
 =?utf-8?B?Y2pTUkRXWWRvanlXV1pOU1BibVppYmE5YnE5ZitabjhOVmdONHpuSXRhNFNJ?=
 =?utf-8?B?aHQ1b21hZFVCanh4eDhZZHF5R2VMa2VTWXFRc0VaU29oZExSTTlZSnljVHBo?=
 =?utf-8?B?RG1LY1FORkp6UExjbkYwWFpBanRpOUQ2U1ZYcCtwQlgxcmkvOHY1ZEc2NStD?=
 =?utf-8?B?MXNENm53dHdGcXpoc3RWV0dzZUxadDZ4cW5XU3ZmRm81azJqYkl3TUxjNTg4?=
 =?utf-8?B?Umx2czV6MWh6eGVvOVJNQnBFMDhaRTBNTFJ1UlVDVFJ4RTBXbDcwdW5xRHpC?=
 =?utf-8?B?eWl1K1MvMVZLRmV5VDRJdFR6S1ZHMWpvTEpka1E5L0N3SzVUa3Z1dmI3a1BT?=
 =?utf-8?B?bVVCUHJuMGF0bDRYL2o1NHpHcWR2aDhHNlp6NE5qa2FWK0l0SUI2QzNLUVRh?=
 =?utf-8?B?UTJFaUVJWko0c0Q2Lzk0by9qUzhSNEMvMnNNa3AvKytFM0hZYktKS29Bc0Vq?=
 =?utf-8?B?TDlxcmJGb3pFM3Zxd05DRTZiRmtMNkNMOEZ5WjBKVkY1N2ZzaVdpdE1sR1Nz?=
 =?utf-8?B?Z01pUks3SExGaGZ5UHBCdW0xUElUMS9IMlNpSTU4dmZMV01Rd011RzloMEg3?=
 =?utf-8?B?VVlYdXU4YUJrb1ZqYkxsUkJFTVczWml4K1A5UDNWK0o3eC9wYks1YUpsOXo0?=
 =?utf-8?B?YmJyd1E2NEMrL01STDlnUGJQZW00d01QR3pjc0hmWG40bXpmMVRjNVNqcURG?=
 =?utf-8?B?VDVVYWkxcFhWQVFuNDFVdXBhNFNOallJOFU4K1JiRFJUeTRYdXRlcVJDd3Fh?=
 =?utf-8?B?ZzRkTTdFOUFwVG4xc0JlZTJGUGtCcmxOTUY2S3VoK2hxbm1jbFAxMjhhYzg4?=
 =?utf-8?Q?xtcysLQIGojavJELYk5wKLkg/?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3191ae0c-ebe5-49b7-b5ba-08de18abe83e
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB7989.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 18:32:54.9732
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ze7FeTOejdeBDY/ebra/oVljBHHaKF/sqyuUPqmpL12+k2rw+EwrI55RDHLKoMwnCsf9afEyS42tFBPjeWlyTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4543
X-OriginatorOrg: intel.com

On 10/31/2025 10:11 AM, Dave Hansen wrote:
> One thing that's actually missing here is an explanation on how it's OK
> to munge CR bits here. Why are preemption and interrupts not a problem?
> 

This is called pretty early on from the BSP init flow.

start_kernel()
  arch_cpu_finalize_init()
    efi_enter_virtual_mode()
      __efi_enter_virtual_mode()

I had assumed we run with interrupts disabled. But, that's not true.
Interrupts are enabled midway during start_kernel(). So,
arch_cpu_finalize_init() is called with interrupts enabled.

We write to CR bits during FPU init which happens right before EFI
enters virtual mode. So I am probably missing something obvious that
makes it okay.



