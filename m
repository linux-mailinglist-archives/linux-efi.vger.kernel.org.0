Return-Path: <linux-efi+bounces-5320-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 057F3C26D95
	for <lists+linux-efi@lfdr.de>; Fri, 31 Oct 2025 20:59:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2601F1A6199C
	for <lists+linux-efi@lfdr.de>; Fri, 31 Oct 2025 19:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B6122F12C1;
	Fri, 31 Oct 2025 19:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JR+2IBEW"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4533A1F130A;
	Fri, 31 Oct 2025 19:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761940755; cv=fail; b=LLKZdFPBe3+QKaQNuLf+YqlowT38TiM9jonHmdEZqQGLNAIaZSANAV6sWb75uqJVNuYlrEXLjzXo3HEhNOmD0IaoEA/nJHziVPvp1TFkaP2rJJNunq+/n/I7bi43gti/QpjFQ9B1GVu6mfOfF21b3OcaqdOndPw43y+kAy4CsVE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761940755; c=relaxed/simple;
	bh=SvZLyMWyAxF9yE/wjExWMUi1StlWj8SCxkrVJ9Ejbbc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ni4dmpz7CEKGDAtIqc2wi3DNp057IuWWAAI6B1TZLQEi6JyCG40gHDGFr1EsyThlKEPokCtPCDjWSTXxfwlOj+b3Zo3U83zzkGahpPQQwExpancE2ybukfmeJjuSdr6Kgz1I9g3PbcvLbJGdixovC+Lijcs1LtBCsw3kF06Ft+w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JR+2IBEW; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761940753; x=1793476753;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=SvZLyMWyAxF9yE/wjExWMUi1StlWj8SCxkrVJ9Ejbbc=;
  b=JR+2IBEWPtHObvkUxx8iKinLZqGJfJj4hKwOwMXQzq8fEtBbX3thKmCj
   ihW6aG3p93q+YQVcijmUlvjD3+qtKujalD1RpHqt0NWBQR+zHptQ0oVV/
   qcq0xrIp5LffyK7XsD0ngbpXLW7qPwt9Oh2d3lQnZigN1IDXk85h8ro3W
   xIC4oFloPLvpynjCFY02gOlBN0MzHEYPY0gla+KYDXFL9AGwbH2XxLmaR
   waCy2lKTYGN2TItzZI97Crc/UWjXzoNpUYywo820BNwskM+tHcpwEyy+g
   iMrI2yR7np4KBb5sRGVTADApl9ASGAGpCldocg1nOdKsuWCfVtvXWlsn5
   w==;
X-CSE-ConnectionGUID: cLRXAP9RTb6V4c5pn1PeYQ==
X-CSE-MsgGUID: 4MGubji0T221fUilr58/Mg==
X-IronPort-AV: E=McAfee;i="6800,10657,11599"; a="74401242"
X-IronPort-AV: E=Sophos;i="6.19,270,1754982000"; 
   d="scan'208";a="74401242"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 12:59:13 -0700
X-CSE-ConnectionGUID: ffoURkGTQ0Gw1xnd8xBIvw==
X-CSE-MsgGUID: OKxjV5RlQxiXIHrFrNdojQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,270,1754982000"; 
   d="scan'208";a="186006059"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 12:59:11 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 31 Oct 2025 12:59:12 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Fri, 31 Oct 2025 12:59:12 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.42) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 31 Oct 2025 12:59:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iVghNy0AVDW4Mx3OOZbb/wsLRD1rfIdL+ZkFhYFAbr19iyY2QtoOSuaXzspo4fnWgpkJLWmi0IfzfZDZFkIaYmekDA3p8vcQC7KiTa9umGfbXiBV/JBIMqCt4Vi2hSLiV4qT4VbZH55PsOC/OB/VYLqgJom7Y4TddU7FHKOp90wAw4deojIw8e5xydLpziP6yNFSCiEl/6PJtBdZNVVu4sVf7Pa/wauQViJVLP7hFht+vyMWdrk5sgbXMYKSFbDGhvSQjFvJSTrsy5aZqDEycTnzX60a0kp/2xDlCEOLCF7zGZl/J0ZHLt7XUHkO0TX1VhZhLzgM/C7vKcfgLIfSVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=THHB1nJOaMJSRGmMpUo9WdDe4LC9/libRfdJ8ZPp+fw=;
 b=kTiSvTQvbmo8NmRCAFo8UYnl88W9f5mP8il4p2ty3QPHs0n1GOnOxMior5fydU1r9Yqzd9SQvoCcPZz+WHC5arMdEhHCDB4Q4vtUvtJiQcW54NKoRwBWQSGFi1f/9zjkCDaPeyA4cuZ75VHztbjJm5XbBK7zX/gsXMwmtDsJgbHZbXo2BK5Yreyl36LvDo6n929bck5qM87Dzq2UxNarfQ/RIJQC/ewJRjFkx/A/cRXV/KPScG5AJc12OvZsSltCCSE8T37N4oye5JdcNTPc8KFiRIvlF3wXIf5vAQwGeAQGcEUh3zfD29yC5Xwl+oQKQAFBzoTwRUz5lr3cJb4PZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB7989.namprd11.prod.outlook.com (2603:10b6:510:258::13)
 by CY5PR11MB6284.namprd11.prod.outlook.com (2603:10b6:930:20::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Fri, 31 Oct
 2025 19:59:07 +0000
Received: from PH8PR11MB7989.namprd11.prod.outlook.com
 ([fe80::752b:acc8:a52:38ba]) by PH8PR11MB7989.namprd11.prod.outlook.com
 ([fe80::752b:acc8:a52:38ba%7]) with mapi id 15.20.9275.013; Fri, 31 Oct 2025
 19:59:07 +0000
Message-ID: <76e8411b-e5ff-4c01-b63c-ef60e29388a3@intel.com>
Date: Fri, 31 Oct 2025 12:59:04 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 7/9] x86/traps: Communicate a LASS violation in #GP
 message
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
 <20251029210310.1155449-8-sohil.mehta@intel.com>
 <9a4794f5-2a1f-4048-a870-b99fb5ab8136@intel.com>
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <9a4794f5-2a1f-4048-a870-b99fb5ab8136@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0096.namprd03.prod.outlook.com
 (2603:10b6:a03:333::11) To PH8PR11MB7989.namprd11.prod.outlook.com
 (2603:10b6:510:258::13)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB7989:EE_|CY5PR11MB6284:EE_
X-MS-Office365-Filtering-Correlation-Id: f22cc1f5-3f82-4419-50e1-08de18b7f350
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?alQzTWovd0ovUjZXaFJqY3dkUVQ5Mi9jVjJjQnZJUlI1d3A2SENDVUhmbEZ5?=
 =?utf-8?B?cUVRRys5OHNBUFdHWFZiV0hvbDhEb204YnB5cjVQMFR5OVg5N1dqaHpCZ1hX?=
 =?utf-8?B?L1lKZ2lzbmxwUlY2cnJZclA0c1l5Sm5WNVRvZi9hRVZNM0h1czNBQjFGN1My?=
 =?utf-8?B?S0dkQ2xEWWtmYVkyekFmNGt3cWJENW1icmo0VXBYUG96eW4zb1R5V1dzYWxE?=
 =?utf-8?B?bDJNNzVPRDBwNzJvQVdNczJtL1FOT0lpWmxtcFJHN2wyTEFwTHMzY0ZuRzNt?=
 =?utf-8?B?N0dyQTBuQ1BmbDZZQnlSSmZQczlNVXRZNjlnakNtTFpjVTFWdGVWUEwreWRq?=
 =?utf-8?B?UEtYMkJsVkZKN3o3MWNqWDc1dkJFMFFBWjZUamhyZEo2S3o4d1VCRlBza21h?=
 =?utf-8?B?RGNFOFVFbzErUHZINElnaG5PR0haSUI4WURPcEpXRkZBV1YvQ3lzVXo5SVpR?=
 =?utf-8?B?UUJISjNlNEdlcDBRWVU5WE5CNy8xdG1VMkI5R2ZVU1RSNWswLzVVbkwxS1A3?=
 =?utf-8?B?OFNvYW9naEN4NkVaU0M5blBiQXJITDdKbGZPK25vZytpaENIa25kdmcvejhP?=
 =?utf-8?B?Q1FwTkZMT0hvemZydW0xSW0zbWcrY3IxZDB2VktKS3ZHWG9BTW1Ja3ZVOUdH?=
 =?utf-8?B?L003S0FITytsVWlENytmT3dJdmp4OUFiVXk2SG92Y01wWDNBSjU4ZXNZd3Ir?=
 =?utf-8?B?ZjVRZk9iSnh4MmdUdlNZaG5PZVVISHVZandpdDFLS29sL3dxWHRVVTQwUDk4?=
 =?utf-8?B?ejFhVTBtYTQyMDkyeXcybmFKRTc3R3YyNFFHZlA5R0pQTDVOMXVDZTRZdzMv?=
 =?utf-8?B?MzBnTjQxdHdrK05NRjNHOEZ1RHZBTXJ0WmZJVElCdVdtTnNVTmZBWElQbitl?=
 =?utf-8?B?Mk1MTjRzc3IxSWx6MTRGdzhNU3NHOURDck1Yam5UTWkzSVJvc3liaDJEWGE0?=
 =?utf-8?B?cnovaUZ2K3doV1Ivdmh2NkhPbDJTOWxQQ0dKcEdGdkhESGV1SVRjNm5mN2tn?=
 =?utf-8?B?clR6dldtQlAraFhPdWFQSjUweE1vRzJrMWFpMlFvMnpHajM2bFA3ZEZlWkZH?=
 =?utf-8?B?QjBoOWdLd3grZUMyUFh4RG9tQjIwMk9EbUs4VkdLTFNZRUxFOU1JV1FmMUFo?=
 =?utf-8?B?dURPY2U5MVMxYk9lcVozR2hOM1o5OFB6SHh0Y2c0R3pNOGd0OEZPNmUvK1k5?=
 =?utf-8?B?QkJNcTRjTUF0WExoUTBxL25UMWlHaGd2K1AvQVpOeFJrZDZ4TWpOald6MXJl?=
 =?utf-8?B?emNENVNVRkJWZkplSytqVlRsWWRteWFMZXZqOTBBRFZLRGQyZHFZb21zdE4x?=
 =?utf-8?B?eEdqYVE3YzN4UjRtb0djSFRZZ2l0WStna0xKdk5Jc08vYlhXU0F1aHN0TjU0?=
 =?utf-8?B?M1JBb2laWVprY2JpNU1RVm1wN3VtK3BZVXA0d2tHTGFWb3VkbjJJMWRvUVR3?=
 =?utf-8?B?K0lScmtZZGFDQUJubHU3UHhSQlArUllYZUhhMTFHK2Jpc0I4UzhzZ1dHRDlm?=
 =?utf-8?B?WjdiaE54eHlDRVVHUlZWaTdXS1RkOXdvd2lwMEdmVDluQzFGditsRitLcm5H?=
 =?utf-8?B?SUhtVFlhR290STBhRHMzMUlrVWkrYjhqMkZkUDdoTWVYOXR1VzB0SEQrTmhG?=
 =?utf-8?B?MzFDK21vaERRTU9TS2Rlb1duYlBnclBiSFhNTDhzQjNIeUtpS3ZvUXI2YzBu?=
 =?utf-8?B?cjJFS0hydW5SQjh0ajQ3ZVNsaitBTS9YN1BKcDVNV2dhZzd1VGhFa0ZmQ1dy?=
 =?utf-8?B?eDhkS3VaYmVjd1BWMHRxc1dRRVRpNm9SSFMrOXhjcXJ6RStKNnA3QzBjT1ZS?=
 =?utf-8?B?eTBDQ09SOUhMR2d1ZUp2NnRrYjB5YmhNSXZXOUxBSkdZTjRNSFZLSHJ4OHIz?=
 =?utf-8?B?SHJDRlpGS0RvVVlxMVc2elFwWXpHYXRhSTlZcTU0SnkzaHBZRW1xMlc1RG95?=
 =?utf-8?Q?iEyvXt+Uk3NgK6oIgwnfBUq9M5pn1arq?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB7989.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YXRudlpxdjZseHp6Zko4cjBrSnc1TDRqdzNYZm5iSVlaVkNtTnpGSXkxYjhq?=
 =?utf-8?B?bXJBSUpxZXNwZXhGZE5DMjBzbTFvSDNjUnJIWEJyVDVlRVEycWs1NGxsNUk2?=
 =?utf-8?B?NXFEV0tYcDYvc3ZNUmVxL2RDbVJJcGFUUUxCNmpjeTBjTklrc1NKVlRwU09u?=
 =?utf-8?B?OWlJbHNrOWMyYnJmbUpZTkMvS2RjRnlzMHEwQ3pTVFAxSlB2K2EvNUUrOEYw?=
 =?utf-8?B?Q29nNkhkd21SR2tUMFFzcGdFenNzK0htb0JTSlpjem1RaEV4Rm9wYzVKQUpK?=
 =?utf-8?B?ekdWdFNWOXZ4cDcwUWE4Sk91dC9URld1RVErc1ZQRk1XTmNNV1BwNkRFVXRB?=
 =?utf-8?B?Ymxhek9ZaTZIL2lQTGg0V2ZEaW5kVTE4Skp3QzNxRlZMeXNsZTNhSHlVSXp3?=
 =?utf-8?B?RTFLYjZ5VlhGcmdQT3QzQXROTGJaSUdZQUpDMlVlSEFzM01mTnRLb2NIVXdZ?=
 =?utf-8?B?NlpNS1Fyd1ZzNW5mVEp4aU10Y0FvN1I1L3Q3emVjTkV4a0NDTDY5VUV3OXV5?=
 =?utf-8?B?TFN2SjhJS1FJUm1aZUtxNUY1b2JHVFh6Nko3dkRzSUhnQUkvMXdyamdkbFNu?=
 =?utf-8?B?UndMajVycDFsZGlsNlA5blRKVWhQVXRBTXIvUCtEN2dna0RMM2d4Y2tnSDJk?=
 =?utf-8?B?SEs5OVQybGxaM1J6c1FXQ1psTkNEdzlQSEFBbGp5QUlwTWxDb3lUaEdLV1dY?=
 =?utf-8?B?akJscEMvM2srNXF1d0FRNUtHS1NzTjgzWUlpZUZUdzZHSmI3bDNsQllhWnhx?=
 =?utf-8?B?VjlmY2ZsWGNBa3FiQnp0d3Z4WDVkeWI4TTVHYU9tNmU4dm5qZ2JhZ3RGbk1z?=
 =?utf-8?B?cGdkR3F1ZnE3T0xwVjduTUZJT3dneFg1a3NObEduL3NHQ2lqemRWQUhZeWVG?=
 =?utf-8?B?eGxJYkJsejJqdUlWY2ZycnBKZ3EvR0xhUTRYQ2ZkSTVJS0Qrd1JsaTZJaktS?=
 =?utf-8?B?eE9DKzRZT2U2Ykx3UlVUUE1EYUxSbUUrQlRuL01GN1AzTVU1N3dVbSt1bUpK?=
 =?utf-8?B?dkhIRlVya281Tmp2MzZxZDNyb21PNUhtdmhUdDRRWm5lMG9GcVYyWjhiZHlC?=
 =?utf-8?B?MG5VbUw4TzdaUk1SNlo1S0cyZUxhRGloTjJNczZnT00rVTBwOWNkb00xYWRm?=
 =?utf-8?B?Z28zRy9xSUJBOWYrSmlRc05xZHdlNVdURFcvRWUzY0xoSnhwTWFWTjV6ZGdh?=
 =?utf-8?B?UTRVWnBiLzg2a1ZuZXoyaHFOWmhtVU5OQm9meWlLT1NRb2xUbDhXUHo1Y1Zk?=
 =?utf-8?B?NmZvRlJudnNySnJGTmRvYk9ZZTh0WHd6RkpHS29CUWMzeFBlRG81c3FCcU5O?=
 =?utf-8?B?RUJBQy9TOHJpRlZEdENKSitiS2tMa3ROeDk3TnZjSXRZMDIzaXRtT0pwdms1?=
 =?utf-8?B?aTJ4OXBKWDYrTEtRbXhqci9TNUg5anlTMVBuaHJ4eCs2dTBkd0IyS1VBOUx6?=
 =?utf-8?B?UzBpQW5vMTdrTUhOR05FQ2xHQTlXcXIwajJWTTdqdVBBOThwTm43OTJHa0lS?=
 =?utf-8?B?RHNaeHNGaElldlF0cUF1S0V6dndTYWpxTEp4M2l2dWtFdlZPU25Ha0FYY2Zp?=
 =?utf-8?B?cVFNY0tSSWpOSjlZYzhFRTBzeE1DaHNRcGo3b3UwWVc4Y1o1anViZjJCNGY3?=
 =?utf-8?B?dEsvZjRqSVFJQWFVQUc4QmlRRkUxQkxyUm5yS3NKV3RZeUxtSG0vMXptQnN6?=
 =?utf-8?B?VExnUG42Y2kyaFptSWJ6RzJEWWlmWVhZTklXNW0vZWVRdDRhTHYyR0tDYVFN?=
 =?utf-8?B?SnlOR1dZbHJBSmw1NlJZUGQrWU56eW4vWFg5Q1NPRUZaSmlCMnB6S1AwekJI?=
 =?utf-8?B?U0dDYkNMZE5LZDF3YVJvWmpQZWgxWlAreGRnZ24vb2lPZW5kTy96bHBxK1Fp?=
 =?utf-8?B?T2ttWndHY0dObzNMYXl0SW9nb20yMEQvanA2YmdzYi9zUGRJcENnRlNIbTRG?=
 =?utf-8?B?ZnQwcDhjYThSNmNFYlo4LzNsSmpzZ2JxL2pTNWxVR1RUaDNzOTlneWpVdEll?=
 =?utf-8?B?NzVVbUF4NGtjNDVsNXkycDRFMytBMWl2Y1AxbHN6NEY2cUZJOWFYQkZqRnV2?=
 =?utf-8?B?dVo5YTl5RW0wUVUrV2NhSTU3czhqeTJmQlI3VHdENFRnRHBHTVZ1N1dyNW43?=
 =?utf-8?Q?43iZ+Qtjh8I8R2mgcmIbRWspN?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f22cc1f5-3f82-4419-50e1-08de18b7f350
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB7989.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 19:59:07.5730
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KSdDZ553oT2/OSculol6ty4fnKypNjzt0HRMZ4Ms0cq+paLSq09T2iRFZcYtVp2D9Qnq36O4DlEDYV1kZ/4T/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6284
X-OriginatorOrg: intel.com

On 10/31/2025 10:16 AM, Dave Hansen wrote:
> On 10/29/25 14:03, Sohil Mehta wrote:
>> To make the transition easier, enhance the #GP Oops message to include a
>> hint about LASS violations. Also, add a special hint for kernel NULL
>> pointer dereferences to match with the existing #PF message.
> 
> Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
> 
> This also reminds me... Are there tests for this somewhere? How did you
> test all these new messages?

I have some very simple kernel modules that access invalid user memory
and generate these faults. I configure the kernel not to panic/reboot.
But, I have been running them manually.

Invalid accesses from the kernel generate:
#PF (without LASS):
  BUG: kernel NULL pointer dereference, address: 0000000000000000
  BUG: unable to handle page fault for address: 0000000000100000

#GP (with LASS):
  Oops: general protection fault, kernel NULL pointer dereference 0x0: 0000
  Oops: general protection fault, probably LASS violation for address
0x100000: 0000

For testing user SIGSEGVs, the Vsyscall tests have been sufficient to
cover all scenarios.

Were you looking for anything specific? I can clean them up and post
them if required.


