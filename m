Return-Path: <linux-efi+bounces-5265-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C033BC217B0
	for <lists+linux-efi@lfdr.de>; Thu, 30 Oct 2025 18:26:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4D2BF4E2E11
	for <lists+linux-efi@lfdr.de>; Thu, 30 Oct 2025 17:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27FC03683B8;
	Thu, 30 Oct 2025 17:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mpuAkvqn"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3992D3683A3;
	Thu, 30 Oct 2025 17:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761845074; cv=fail; b=QswJ1HnnBCKZzHHhUlpwv1SMWTk9F/yXK8vKzNdh8SRRezrltsQ7mIeVcewu8N4/JMpwlKPguM5h47Z27a7jkRdrXBo++SFUmAMucJVviXLxkbRP++4P1uMVlw1eQLxbZ2TuKIwmUBxHbuQTqEDXJA0uiSFgKDACoW/HW8/iiic=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761845074; c=relaxed/simple;
	bh=EmRwUsIXw5HhP0e6MaLHhdZ9Zoex4EdW8xbdAcaPpq8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IiB33NVWObAFGq/jUiM9Edz5pqZLILHv7hpa2h120Rcyb5l0Io/qr/Uozg6R3ch0AD1iGZ13isFl0IwbToIcsRM3IrkKpsxpP8tK052XBs7z2ARWepwAUBIGK3GI3+wUjjb1w6a4Jh836h4WhkLTWRtmPP2eDoTSVM2xAM2sZJw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mpuAkvqn; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761845072; x=1793381072;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=EmRwUsIXw5HhP0e6MaLHhdZ9Zoex4EdW8xbdAcaPpq8=;
  b=mpuAkvqnpPDM+XktoZAjjTRmqjumrrDEO1BpMlt8gdzqZ9rb9WKk5zFo
   IiX3AnjBtv2+P/YK9Il9hOHrw9eIU/NNCJK/A/w6ZNAOuUWoOTn4xkA1X
   V7uaMPjWjVhCjQRsdpLw5DDLfU+m/ldo4AYr+eqP13heAVG2KO7WUYQJ+
   ULpy2gg0DWbLxbQgwrcN7nwFuOxTWbOYh8lLprlnfPHABLfsResk5+iP0
   WSIBrBdSkdE5JZTmpMGOd093e9F1NE3tvUXmOso0KZnhbK8ybCTPMTH9I
   4VNPnszchGEWBG/cBYpWY3CrF9j9/ot9+H8Pw9jbdexPa04kPSgbhkzSv
   w==;
X-CSE-ConnectionGUID: +L/tRdtXRiyuwo/jDijVfA==
X-CSE-MsgGUID: IhsAnacjQFu3IkZcf5AvDQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11598"; a="75115929"
X-IronPort-AV: E=Sophos;i="6.19,267,1754982000"; 
   d="scan'208";a="75115929"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 10:24:32 -0700
X-CSE-ConnectionGUID: vzJV3AF+SB2YLtLeg2xhkQ==
X-CSE-MsgGUID: Vee4L2WHTjiuDtKbZWb2BQ==
X-ExtLoop1: 1
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 10:24:31 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 30 Oct 2025 10:24:29 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 30 Oct 2025 10:24:29 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.36)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 30 Oct 2025 10:24:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bmDMvts+/viUoGw7yNzpSmvdyv7VEFce8WZUQ6ozB4umgZM7Xgw1/3aZpC1vsfCPBoHRmhPHPySfJ/PAvoJGJXFRvXs34tzeL3bhhHfQZ9JudTJEoCONgMatQM1p9mkyx4kFIWdgu6frMwya+B/IbRTNOWIIUPm/O7I9bD5uz6RPzphdeS6e4C6WX+2s/n6gY4i/BebzUBgH6UHHqNwoVjsQEcP2WXDrp0fBHOxr9fqOCODIA4VjbuFRTnxctyvX8I3lpbNkqrUoekTivknYgzBWB3GZ+5N1U9Uln5GhWUG11KoM2q9yBZt69CDhd64kEwyACqFjaRYmnQzdEHlXtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BeynkhhGgcLxe0hUBvLSJq/Bv7Ev5WvjoHh7OHkhVmw=;
 b=g9mfDAh4FkEHll0MDDhVwPEkIlllmBI7zUyqEhFEDhA/T/Td/5147ECVwBjyR5e7UIBxz5oDwBe/MvQHPIYCDaV0hqBXynF+R6oriBQtAUBRFHSP4LIL0QOF2LVnAYhjvt8quHEFiFXcNMHc5RkRB1wSxeGkZHN54+lH9nMWYB4GZuVeAI9r3NdjglN2+GjDT6DD4gfh5Kk0nw9pqGy5C2L7t4xEop+ELKKJuzQD1pjg+6V4il2eMFrmD8yChnYOUegr3lRCFSvZLF+nhWoroWZKQu7GQPXWAN3+m26nSwAeT1sHL+LeB66RVXkTHNPx75Oy4zIpWRYU5dkIO93nng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7997.namprd11.prod.outlook.com (2603:10b6:8:125::14)
 by IA1PR11MB9470.namprd11.prod.outlook.com (2603:10b6:208:5af::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Thu, 30 Oct
 2025 17:24:27 +0000
Received: from DS0PR11MB7997.namprd11.prod.outlook.com
 ([fe80::9105:2b7c:b256:7a6c]) by DS0PR11MB7997.namprd11.prod.outlook.com
 ([fe80::9105:2b7c:b256:7a6c%7]) with mapi id 15.20.9275.013; Thu, 30 Oct 2025
 17:24:27 +0000
Message-ID: <e3215a62-335f-463b-98d1-de95e5859b9d@intel.com>
Date: Thu, 30 Oct 2025 10:24:24 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 9/9] x86/cpu: Enable LASS by default during CPU
 initialization
Content-Language: en-US
To: Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, "the
 arch/x86 maintainers" <x86@kernel.org>, Dave Hansen
	<dave.hansen@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>, "Ingo
 Molnar" <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
CC: Jonathan Corbet <corbet@lwn.net>, Josh Poimboeuf <jpoimboe@kernel.org>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>, Ard Biesheuvel
	<ardb@kernel.org>, "Kirill A . Shutemov" <kas@kernel.org>, Xin Li
	<xin@zytor.com>, David Woodhouse <dwmw@amazon.co.uk>, Sean Christopherson
	<seanjc@google.com>, Rick P Edgecombe <rick.p.edgecombe@intel.com>, "Vegard
 Nossum" <vegard.nossum@oracle.com>, Andrew Cooper
	<andrew.cooper3@citrix.com>, Randy Dunlap <rdunlap@infradead.org>, Geert
 Uytterhoeven <geert@linux-m68k.org>, Kees Cook <kees@kernel.org>, Tony Luck
	<tony.luck@intel.com>, Alexander Shishkin
	<alexander.shishkin@linux.intel.com>, <linux-doc@vger.kernel.org>, "Linux
 Kernel Mailing List" <linux-kernel@vger.kernel.org>,
	<linux-efi@vger.kernel.org>
References: <20251029210310.1155449-1-sohil.mehta@intel.com>
 <20251029210310.1155449-10-sohil.mehta@intel.com>
 <789ADBB5-F7AC-4B08-B343-F23260FB8FBC@zytor.com>
 <13681100-ddc3-4ef0-bd13-744282324ff1@app.fastmail.com>
 <d1b5698e-94ab-45a2-a472-4488895d55bb@intel.com>
 <ed1a6e12-68cb-4103-946a-761260d18eab@app.fastmail.com>
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <ed1a6e12-68cb-4103-946a-761260d18eab@app.fastmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0062.namprd05.prod.outlook.com
 (2603:10b6:a03:332::7) To DS0PR11MB7997.namprd11.prod.outlook.com
 (2603:10b6:8:125::14)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7997:EE_|IA1PR11MB9470:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c4be5dc-33ba-4acb-cd5c-08de17d92d9d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K2VQTVZEZ3FJUUJVbG9GM3oxbVhscWtjUnpwc2MyYVhaQlp5djIxc1R6eDhy?=
 =?utf-8?B?NitPNHFIUmNDVkVXSUdOSjZ1bzFJdDJBUUtpY3JmZExkQTFzZEQ3ekl6T0Y1?=
 =?utf-8?B?Ullyb2hnRTdYbUx4UTltbTZZQmozZFFEbFdwQUV5NVJrWTBybkJENEkxYnlo?=
 =?utf-8?B?ck1NVHV4Y0IvSVhSaE1zdXEySFNhQ3BJcGRqbTI1ZmtJcm4zVXNCMjBjRHpQ?=
 =?utf-8?B?c0hJdlg3MTZCd0Q5cE10ZFhlRHZBV2FqTlV6Kzl5L1BxTHZRdnMxSVQ4ZGVF?=
 =?utf-8?B?QlVkSlBwZmUvM2VONHVFSmxud014RUVFTmMyaENvSkUvV0owbWI3NTNpa0JL?=
 =?utf-8?B?UmtHb0t4c2EvTE15d2Rja1NyQWQ2RGZPdjBHYldYTHNJUVFsa2hYa2xXUkpD?=
 =?utf-8?B?Qi9WSFgweVJhN3lINHo0T1pEQnhsRFdwMlhVYkdnMEkwYTZqUmVJRkFIcStP?=
 =?utf-8?B?WkFDZ2JpZGtpRVI2Sk9lNllNYlg5UTBkV2xUYW5YMkFoYldiRE9EZDdhcXlX?=
 =?utf-8?B?L20yeUM2b2QxWjRINDV1L05YLzJrYXBpU1lEemFuOVhtT241NDUzSEVjbC9a?=
 =?utf-8?B?NHF1TzNrdWhxK0RFeG1TKy9NQ2F5dGl0WVo0ZjBROUQzTmhXRnZGczFvVkl3?=
 =?utf-8?B?cDNFWS9zZHZsZGpIOUxJMTZrYmVWMytpTUJBZVg5SUI5aFp1T3BXaHJTMHVa?=
 =?utf-8?B?VVRWME5JVzVGTHJqVmRxKzRiOHF4TDhWNkNrU3R1ZDJKeGd5allQOURyRjJu?=
 =?utf-8?B?RUs3c3JUek5mZnRObXJuT3FUVFlZWnhrY2FQTlpJeVFEYlNrY3l1MVk0R0hM?=
 =?utf-8?B?NkM3WFpzdXdJNHRXbEVoMk5IVldCU1VIQ1NNakkyK04yR1FFeENUajRSNmxM?=
 =?utf-8?B?cUU2ME9vOVdUK0owM3FMZVJvM1pKdDF0WFJRMktOOHJYT3JVcjllU2RZMVpa?=
 =?utf-8?B?MlVheWVOdWl0UG9Ca2lZckpzMUExUUhETVlZd09lZS9vL3dQN2h1Q3kyZ1dl?=
 =?utf-8?B?a3had3hON1R0NmluSHB5Z3BvRUdXNXRxOG11LzRhUzNGRTdldklYV1RZRFA1?=
 =?utf-8?B?NndiVTcwYnJpZWZMeHhhWWVoSE9KemdMellNLzJkQWxHSzlLQmx0a2tVbXhI?=
 =?utf-8?B?d3lsbHpTUzNDMjhCME1uQ1hCK05PNnh4b0NGNlRsNk1idVVsZDZ4U0dGS2di?=
 =?utf-8?B?RGh1Y2ZOYXZmMk13WkozTjU2STVQL004bWFFQ0pTWGtQbDZGMDlldkgxdkRL?=
 =?utf-8?B?a21RUUlTeVd4SGpuZzR5Ky9sUmJmTk9Ka2RSckp4NlNXV2ZJZ0dlS01jTUpM?=
 =?utf-8?B?UTRTOUJKQzQ0dFZ6NXY3OXdzd0tUaWwyeVlzcEVCbGFteUNRVzB2bVNub0s5?=
 =?utf-8?B?UTJFZE1PQlBWY0JoNEVZR2lHbk5UOEVvTnJkMlpQUmtQMHp2ZmhjaTFEMFNl?=
 =?utf-8?B?citUa1UwdUZGWFptSEN6UXNNZEx4Zm0wdUpzTm1HeFJydm9hWnhTNkVaWFY1?=
 =?utf-8?B?TXlva0dWdDBrWkhZUkN2bzdQWllpV1FrQ3cvcEFldFVnTnRLZVhyL2FDSTc4?=
 =?utf-8?B?dmdNWkdZUmhWbHVFYzYvV2VKT1NPWDMyaklUUlE4WDlrR1dpTlh1YnFGZmEw?=
 =?utf-8?B?TnFJb2cvL1NFWGxoMUNiaDRkRUJENU1NUHNnUFdTd3YwWGV5Q21BRFExKytG?=
 =?utf-8?B?cSt2dWljMmU1Q0JLRjNTMjErTWJjL0NuNmtLZmc2eTN3QU9WMlp2R0tQQWlj?=
 =?utf-8?B?ZVBHQ0QxZDFhZGN1U1J3S241Mk0ycUNrVEdYNkdMN0NCVXFmSXI1b0k1b1RE?=
 =?utf-8?B?K29kS3NZaXk1UWkvL1VDaXNFd0ZXYnFqaHlEM21hY09QcWFua3JqS3N6TEVR?=
 =?utf-8?B?bFg4T2NqbWlwV3h2RGlBRE5pTHJKNDl3SVpXQ3FiNFRPNmc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7997.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S0FjUittM2ROQzduUGhiam11bUVMblBaYW16U0dBQm0zSzc4TG4weHdpb0Jz?=
 =?utf-8?B?cUdsWW5td20xWmJNUE82UnRGVkt6SVQ1M0NqUTN5VFlTd2huUlUzSDErM3dC?=
 =?utf-8?B?b1BMVzN0SjR1WnpjMG5lYXNVTEMvYW5vamJHRjd5dEQ1K2VCWWJYd1NzM08z?=
 =?utf-8?B?Q09Qc1cyR2NqckRJUzEyV2E2Q0dLb3FuQmYrUmVIRnIraWhpcjVVVnVuZjJE?=
 =?utf-8?B?MTZIRmV4TkR2NVpudGVXcHptQ0ZlQjduL0k3M1lxTkdZNDlKbWNWbEhjUmpS?=
 =?utf-8?B?NWE0Wm9wUTRSeWJFWTU4T0g4ZWN0OG9JQjdiVW1HSnRiRFBQcmlienhPYlZi?=
 =?utf-8?B?cjdxeG5ySWlaMW0ySWcvajQ2UkVCaWZxWVMrMTlPSmhEdEZocTNXSnQ0WGlO?=
 =?utf-8?B?azBkenN3MjIwWmFxYkNrSE9mSDhtcnppbG5IcWJJTEJob3AvWC9mclluNS93?=
 =?utf-8?B?OFc4SFhOMUZ0Wk9JRWgvS2ZDTGhpY0xFaFMyUEFjN3BsQmZNYkVrSEhTbE82?=
 =?utf-8?B?NnE2eUNCYVJUVDhpcm1pS1BuYTNUK09KMXdUcTEvU0NVWWhNb3F4YnlSVlEr?=
 =?utf-8?B?THkwVFpkMlZiWXJ3ZUdPQ3B3SCtKNXN5b1F3Q2VpWTd1RU5LcGFkeDV4ZVl0?=
 =?utf-8?B?U05TQTF0aE50bjJNWnRtRGN5cjdQeEFOc0hZM1NyaWk2OVRiSGdUa2xEUmNm?=
 =?utf-8?B?eVRxWFZaUlVoWS9nb21FeHJzMEt2SzBEWkJJeGorNTM1UElYWUR1QjhCYVpD?=
 =?utf-8?B?T1hqc1BZU2wzZk1WYzlMdVRSR2NXWFBsL0l3cG1ZV3gzbTcyY0wyNmsyTVZo?=
 =?utf-8?B?ZmpvcEdQZzA5WnkxYVU4OUgzUVhKVDRqRkFreXQvTGtyOGdhdGZDUnd3QWp2?=
 =?utf-8?B?SkJpTHhJWm42TEZtd3JybmsxMkl0cVdYTWtDS21tUVZycUtmS2VXSTRFK1Np?=
 =?utf-8?B?T0NQSStTWlBqQk5vbXFKdUtycEpPVzBOM0hFZ0lIcGN5UXdQakQ1cHVVV2ZH?=
 =?utf-8?B?ZTlPZkRSL3IvVGVCdlVzQXNGNkJkY3VETXJBZW1Ob21uY1FMVXErVjUrVmd0?=
 =?utf-8?B?R3U4dEpRNVZIdzNsM0l5N2twZndPZDBkeVZnckFLQmMzQVRZMjdXUUNCRmpS?=
 =?utf-8?B?SzFFOVlCREx0RmU5MkhtaXZGRVFKeGE1YTlWTk1MZWVXV2R2Uko2UnlISnF0?=
 =?utf-8?B?ZXZ1WUp0cEp4RmVhaHlUQVlFV0xBRS9DdGRtWm5pNHVGQzdjWnQ1M0o0ckdz?=
 =?utf-8?B?RlkreXczamxsbDhGamI3Wlp1ODdKUWRXM0FzakM2YXRPUEplNldRd21heWxa?=
 =?utf-8?B?a055M3FOSW90ZjlPenlwa21PeUR4MnpGWW5xQWg1M3Myelo1VldtL2dPSTRp?=
 =?utf-8?B?TVIwUmpYSnJGZHFMMEVNVmFGVlQwQkdVdHIxQllvanA5K2QxaUhtcW84b2ZX?=
 =?utf-8?B?THVoYVd0N3FjZnRZRUEwZWNoelArZSt3ZnZ3VG8xSmF3NXN1aU0wRjlxZ042?=
 =?utf-8?B?ODFHbFd6Nmw2dDhROWtkSDBTTys3UzgwNWhsOXNja0MvYjhaRTYxYjFueU02?=
 =?utf-8?B?VVR5am9sd1EreWlmNlZ3QXYyT1hoMUM3S00vdTU1OWNtaFdSYlQ2YVYyeUlq?=
 =?utf-8?B?cUhxRVZ2UjZSL0dEQ0hLem40RW12V3YxamE5WTMybGh1d2RZRld0U2hDQkZj?=
 =?utf-8?B?clZ1UzRwQzJUdlhQU3R5T1h1dkxkL0F2MUVodmVXN0RMYnpHRUVrZjdIUmVW?=
 =?utf-8?B?T2c1V3kwMnBEazhyYkFYZkx2UUIvdlBKUm9lSG42clIrd0ZWYXZZMmxyTFJQ?=
 =?utf-8?B?bjFTazdtZzN4N3ZhcDIxOEc5VXZHWEtQZHVEN2t0aEVHY3FVZWF4UzliYzFE?=
 =?utf-8?B?dFRncXQ2UkVlL0hIM3VtVVRCUGZLblJyZ0NobVBWYWY4K1lUeUlvUDdhRk1v?=
 =?utf-8?B?OHpCcmdCb0E2TmVLQzZtUVNpdXl5amVXQUZ0NW1BRWp0dWlHakZCYzJQS3RS?=
 =?utf-8?B?Q3VBTkYrdStiU0d6YnIyNHpLTjlnMkhlUkw5aitUMHA2VkdQNHYxR0ZIWVJY?=
 =?utf-8?B?alc0eERrU3FraUlzWVJneTRuVEFVMjFTMW0vRTZhUjY4VFFXb0JnR0dQd3R5?=
 =?utf-8?Q?1Q7BDG9ZA6RvATJKdb69nsxox?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c4be5dc-33ba-4acb-cd5c-08de17d92d9d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7997.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 17:24:27.5554
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LdFebbpiTOnYJCK3X3fYLIL85xBLOIgi3qmceTcbpGmA6iw9LBJudBeO8oqKbitqf0qUD1YqHHOQi7yXuhVOig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB9470
X-OriginatorOrg: intel.com

On 10/30/2025 9:53 AM, Andy Lutomirski wrote:

>> On the other hand, supporting EMULATE mode during a #GP is a bit tricky,
>> which isn't worth the effort.
> 
> I would say it's definitely worth the effort, but it probably does make sense to get the rest of the series in a mergeable condition such that it only works with vsyscall=none.

I meant the full emulation mode where the Vsyscall page is readable. It
is only available via vsyscall=emulate. No one should be using that one,
right?

I thought you and Linus agreed on removing EMULATE mode completely:
https://lore.kernel.org/all/CALCETrXHJ7837+cmahg-wjR3iRHbDJ6JtVGaoDFC4dx-L8r8OA@mail.gmail.com/

I agree that it would be worthwhile (and relatively easy) to support the
execute (XONLY) mode (that only does instruction fetches). That is what
the separate vsyscall series would do once the LASS base is in.

