Return-Path: <linux-efi+bounces-5838-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E9590CBA1AF
	for <lists+linux-efi@lfdr.de>; Sat, 13 Dec 2025 01:17:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5A37E300F3B3
	for <lists+linux-efi@lfdr.de>; Sat, 13 Dec 2025 00:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1CF82110E;
	Sat, 13 Dec 2025 00:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bowYQAsc"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B58BC256D;
	Sat, 13 Dec 2025 00:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765585036; cv=fail; b=ONJr3iqGBNCf8uCSnTwU4+i+WtLNJ/kC7ZmPFjPNgiXYP7XVk1QmOmCoJLxhOOXqJ8tMKT+f3Ty2wQTpFJYjYGZ/h5COxUJHZ5aVtdQVbQRpVvfUfVP7D2VItRgQ0cGU1QZXENoLnUC3OPd3suT1Iw26b4EbvtmWH8EH3nWjpyk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765585036; c=relaxed/simple;
	bh=3DsV29HpStrSY4B/vZ/ikGVi137xg/2pclE7ewwgXjQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NS3Dq8zY9N7DjpDhfSEkrIgN27aQL2TnaBSEgkFqtvCVZr2o51pRN1m0hYZqSJP5YYdaFaJWuOvAXdsCz/sQXfQnc7KpCwWSXhV6J0F+9wJ+79jr/kJIlvOacgvU9gWv4R8+ClB2XVmOMWQ5gYJ3TYhyAV5KokrJETxjn0l1e84=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bowYQAsc; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765585035; x=1797121035;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3DsV29HpStrSY4B/vZ/ikGVi137xg/2pclE7ewwgXjQ=;
  b=bowYQAscDnxBg2cZcAT1rKoLFal7TOhCHJhdX0FQ42L4EWmMgnS+i22u
   0OgyCKx3M6jqrfolZgki1aJc5//CRthfxhKkIoaFdczPGC+N1uympmydv
   UcCrJ7RG76dho4KDHYbpv45wxrh136hm+/8co3BA4zwpPincdByXDB39s
   +FiwfV0hTRRS/eWEyrckuI3KBsWxkFjmzVYS4fWHOJIyqtBfIQoHLaXu8
   D5815BIjmaz44F7Ah6YAV2aPrAXpbsuLvsV7v8dcduM8P9+UGjn4EIpp+
   YSHBRaAOW7SDmqU16cXYWKrWP0MEkpBO6zRvFTXG0N3ci7QZw652VpgYS
   A==;
X-CSE-ConnectionGUID: 7208VA/6STaa5e5akjJ2AQ==
X-CSE-MsgGUID: Y+9MrcNnSwOish0awrcAew==
X-IronPort-AV: E=McAfee;i="6800,10657,11640"; a="67630737"
X-IronPort-AV: E=Sophos;i="6.21,145,1763452800"; 
   d="scan'208";a="67630737"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2025 16:17:14 -0800
X-CSE-ConnectionGUID: nq7x1uY0StK8N9y/yNnJug==
X-CSE-MsgGUID: T6bYni+vSpqFnuTH7WTV+w==
X-ExtLoop1: 1
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2025 16:17:14 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 12 Dec 2025 16:17:13 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Fri, 12 Dec 2025 16:17:13 -0800
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.22) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 12 Dec 2025 16:17:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WBuy68ztqTW72xhm744SlyogHvVpLgRaD++6Oma6dyypOhQVHzifdMC946y4FXPoDSRoC0AMyauqKMF2HHkZVShnSCKMzoYUY3cGqaxxEvYJUACtP9c/x/Qnb6eAFP86oNCsHJxnXsTsyOnXrwGckm5Ko3BoISXSJ3MsbkFizFWf8u+2OkKSWuZsmZL99R02h+tePBqNVQGPlvuEbQTwgfi+FWts2zw0grTLiKkA38lhCRzXuW46MklKdmLSEsf9H9d0Z+l0EYLVVVOevgzgN9CN2n0cMrhzxbW6AR3AAj7zf5miz+4UVk56DSumjJyWHGEHTYVpJVN+J2IErx0y7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5VcVSYWNZkVS+359KaKe5yE2RE1VkTk7pOsA+yNiodI=;
 b=ytZmJEo29x9XuR+87tZUPiiGTY8kj4kBJ5CF2tnNVQJq1n3kjuh7ztV+7nszYVsw7sk4mUBjOOhxWaba/5CxCzTAZYLQyCBTa90k3PTYVM1Xo1xZax3rQz1AcMimKOl4ld1s2MJcxoBntOi2uo9fJzqFH1aqiqttqqUK1Gt/EwQN/7HoVYJKq1eMA9qkG4nLn+JDsrocjLPNkh2MtRM+4ovb+/iMxOnZh9qy5zKzmCg1m/3kiUQHc1OuzP6/LJRoEdDf/gCVqUMhNZwa7p1kz5SVT0V5PbYC3xhM2bAxC2yxATkZdeJDcsgf14o/0D8uhiASEXDxRAk8Ix0HK3Bc4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7997.namprd11.prod.outlook.com (2603:10b6:8:125::14)
 by DS0PR11MB8133.namprd11.prod.outlook.com (2603:10b6:8:15b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.9; Sat, 13 Dec
 2025 00:17:10 +0000
Received: from DS0PR11MB7997.namprd11.prod.outlook.com
 ([fe80::9105:2b7c:b256:7a6c]) by DS0PR11MB7997.namprd11.prod.outlook.com
 ([fe80::9105:2b7c:b256:7a6c%7]) with mapi id 15.20.9412.005; Sat, 13 Dec 2025
 00:17:10 +0000
Message-ID: <ce3a4c0c-1f18-459e-aba5-9d4582e45859@intel.com>
Date: Fri, 12 Dec 2025 16:17:06 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] x86: Extend LASS support to EFI configurations
To: Ard Biesheuvel <ardb@kernel.org>
CC: <x86@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, "Thomas
 Gleixner" <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "Borislav
 Petkov" <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>, Andy Lutomirski
	<luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Kiryl Shutsemau
	<kas@kernel.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>, Andrew Cooper
	<andrew.cooper3@citrix.com>, Tony Luck <tony.luck@intel.com>, "Alexander
 Shishkin" <alexander.shishkin@linux.intel.com>,
	<linux-kernel@vger.kernel.org>, <linux-efi@vger.kernel.org>
References: <20251204072143.3636863-1-sohil.mehta@intel.com>
 <CAMj1kXFicnmVUeoRsMNbBgDN20fCN+R01H9shcgOJMD2Nzn8Cg@mail.gmail.com>
 <5fb937b4-5459-4894-a107-945bfb50a701@intel.com>
 <CAMj1kXECOBQczcNeqmhfgttz_0545B3m7OgLAk4WE_hOkUbohg@mail.gmail.com>
Content-Language: en-US
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <CAMj1kXECOBQczcNeqmhfgttz_0545B3m7OgLAk4WE_hOkUbohg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0263.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::28) To DS0PR11MB7997.namprd11.prod.outlook.com
 (2603:10b6:8:125::14)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7997:EE_|DS0PR11MB8133:EE_
X-MS-Office365-Filtering-Correlation-Id: 0eafac20-50de-47aa-8b8e-08de39dcf568
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K1cvR2FuQ1krdEk2c25zT2RNaWtvVWpwODNYcmJXV04zamdtRW85SEJxWHZR?=
 =?utf-8?B?TXV0RWx1QnRza2FRbjlMcXdzeFFPeERpUWpMSGNPRC8zM1ZLMDVMMGQzb3Vy?=
 =?utf-8?B?ZjQ4ZVA3aTZkVkczZWQ5VjdZMHFqRGRPM1M3aFV6T0xMbnVScUdRK3pHK1BG?=
 =?utf-8?B?ZlFHUnJrKy9WVkw3SjNNVWpOYXBLY0htV2k5TlZnS3VCNGQ1VE5vVmdEbzNO?=
 =?utf-8?B?bHpucGZtU0hoUENra2RIRFJTOHlkVWVVL0ZzbGp1bWJLNG05bCtBWDlLT1pT?=
 =?utf-8?B?b0J2dlJpNlNNNkl3M1E2MGMwOUo5b25rL2FsNS9OK24yQzU4aHJ2RE1QMkxW?=
 =?utf-8?B?NnJzQUE5RXM2QmswMzBZMk5uU0JzQVJid2p2L2VDTThNVSt1UUphckZ3N2kz?=
 =?utf-8?B?dzYzdTM0Z0ZEKzFTLysvd0YzZU03WSt0K0Rsek5QOFJpdlIyMFR0dkt0RWpV?=
 =?utf-8?B?S0pvMGxOUGZPSWt1K1NMc1l2WFZQQUVWMS9OSVNXTmNDWkMyRGtrd1FDaXYw?=
 =?utf-8?B?UGovTHprUU9sc2RHUi9MSTRoblliREN0ZFM2VEhaVmFPcXlqQ2NFUEdGUksw?=
 =?utf-8?B?OFJKSnY4bnJISzJZWUlrem5PeEpXaFJRZGxzbks5RWFqKzIzTXFNSFZuNXJT?=
 =?utf-8?B?djBVM2ZuQXdZYWc2K2llY3ZvK2MzbWF4QTdMYWwrT2NmUWxvYnhpUVNPLy9L?=
 =?utf-8?B?SEliTnlTZVlmS1pIa1hIN1BiM051d21Tc3oyaytNWW91L2hwTzh6Q0UvUzNH?=
 =?utf-8?B?Q1NtV09nREZUNzlyQ0tGRGlOblA5MmxBVC9zaTVYRzBKME5EeWw5TXJoclNt?=
 =?utf-8?B?WlZNUjc1eVFtREZTVFArb3dMclRIRHg0WDFqMUp6R2RlYnZsZzBWRWliT1Jk?=
 =?utf-8?B?MHdvMFZ5eG8veHcxd3pwSXpDK0pBNFRzZmF5NG5BQzV5QnpOd3ZucURIa1FQ?=
 =?utf-8?B?Tk5mR0w0ZXYydWlIdFgzYlpmM00vNk9VcjUwWWgvT0Zmem1DK0g4QzRDYkpk?=
 =?utf-8?B?MTBCWUZqbURLZURsL1ZpWVEzTlVFdW9raGhoZjhUTEMzM3l5VmxtaVVtQ0M3?=
 =?utf-8?B?bGhsdERoWWtGTnZlamZDbERab0JiWVVOQzRoeEx5R0dIMXFnVHNLZkVuNW1w?=
 =?utf-8?B?d0ZtajEyd2xnK1R0cmFhNnVTTkE4QUdjYlFpZGJ6Z09PWjdycWJjdVJPTFBy?=
 =?utf-8?B?aXo2ejhsc2VvaGh2VDlIdlJlRTkwODNuWWdINm5MWUJJZmN1RzZxMStmQ2xZ?=
 =?utf-8?B?eXdDdDRrY2Y0K2hyb0R0WnJTN1ZPUXJQUmF4SmF0L0xoS2V3R2Z4MzVjR1Jq?=
 =?utf-8?B?V1RPcHlkWXlXRVJ6c09kQmJia0YxVDQ3WXQzdUlwcnZvMFRLKzR6eTdrOGRU?=
 =?utf-8?B?SkNubjNNMUFQWWN3dDB4NjFXWWRoaDUxQU8rbitXUTI5d3JhVGRDOGRsSitQ?=
 =?utf-8?B?WWJjMkVEZ095NnVEYTZlN2lxcTMyMktrSXdmQ2NKbUliOVF0VmlzY2JVWGxa?=
 =?utf-8?B?SVFLN1d5TE90R2Jtc1JLRXBsdTd3azdpeG9FTlJwSzh4MFlmY3lmL0I2c3ZF?=
 =?utf-8?B?eEhESHJMb0k4SlR1Y0UyRjFHa0x3Q1FISGdNQ0ZhdTJVT0pQTGVWWVNlbUJi?=
 =?utf-8?B?elIvNW9TbE1HK3N6VUpmZFU2VVoyc0h1L1htQ0J6SCtKMXVyWlp5ZkRUUjBy?=
 =?utf-8?B?U3ZoZmIxVWF1VjlrNFFVY2YvRDY0S2hhWXZKMDBDb2lrWC93NFo0V29ISjRV?=
 =?utf-8?B?bFFJS0xkMDRTc3BuYytBNUVrY25sN3h6L0tqTEsxUmVOOGUyL1pZbC93TEpR?=
 =?utf-8?B?RDJPN1RxZC92MThLYzVrOC94Qmw4SmRQTmhjc1hueTkzb3dQbHp6NWNpeHZP?=
 =?utf-8?B?Tm1OQVJzckx1QThGdXdjYzJ4ZVVGYk5uZTllZUV2bFl5L2Z6aC9Lb3pWNktG?=
 =?utf-8?Q?SrFW+sT5IfcWvSRy7Xzp2zlew8XuRMbh?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7997.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TFNOSDh3ZERkY3NSOVJtanVrbkxVZjV4NGxPRiswVDNXTHZaaHNPY0RPWHdi?=
 =?utf-8?B?NGZ0NWkwd3ZvdERZbVJoT0FBd0FnSkVNeHoxUWY4TjNjaW5YdXRjTFFydWRj?=
 =?utf-8?B?VmFhbEFWZzBXV25vMWQzRnN5NTg4NTF3cXp2UC96aHVwakxGOXVmVHR0STl0?=
 =?utf-8?B?cnhzV3lRUDFZcUFLbVkzZFdPTXpzT1AzWmo4Nml5aHpXczRtQ3kxODhIbnJh?=
 =?utf-8?B?ZE4weWVlVEh2cDNBNHBxWjQ2NC82aVFLK0ZkU1p6K2VOS091VjR5eWhsamJo?=
 =?utf-8?B?dnA3ZkRyVURNV0VJdXFoYUxPTWpBMkdOa3ZQN2VxVEhoSGErbDk2VmVPVzR2?=
 =?utf-8?B?R1R6K1dvd00yaGJIeDBTbmp6TWcxUFdPZTBjS2g4aTkvdXdrejdlZDkwQStI?=
 =?utf-8?B?WnN1TmQxZlRJdnIwYmVsQzV3VjRKMjJtMk5IbU81ZHNNSnNEU2xnVkNRWjlu?=
 =?utf-8?B?bEcxcEFXMFVGQzB5MjF6NGlnelJHSjJxUlpzclFKdlZaL3JwUVl1N3AxWEJz?=
 =?utf-8?B?NDFQWEZJRUVRVzJuaDExeUZXYmJuYUk5RjlvMUZwL3I5T2NCMlAxTWRRN2hS?=
 =?utf-8?B?ZGZUNW45YWdoOEVjaGpHZjZhbkJDaytwZ0V2K2I3WjU3NGc5dkJjSEN1NmZv?=
 =?utf-8?B?bTIyWkhZTzlCODhDL0MvVUJrN3dadHNsNlNEZzYwZzBibWhSTzljWDIvR0dW?=
 =?utf-8?B?amh3dWRyc2F3c3hLeHVxMmRsbTd1eWRHQmVaOGNKUXh0azNQR3JyMXRvQ2F4?=
 =?utf-8?B?Q2JCclYyNFZUbHptUGZrQmdmc2ZRRjM3TG9weGJuMWRJbDVIK3I0TXZQdnBj?=
 =?utf-8?B?K0tZSDk4eXRWMnhhNEp1SlpFL3ArcU9LbmgzSXB6dVRyaFlDd3hReEluOXRV?=
 =?utf-8?B?dnQyck1LSGVtVHJCV21ic1lEZldEQjJ6VE1RQmttT0l4ejRuRWoxNzEwaWtp?=
 =?utf-8?B?VThLLysyMWNxSU16d3JkUFZPSFZGcndGSHRZSWhYdVdFdFJFb09xbDRZQ2NG?=
 =?utf-8?B?WWFVVmZDbUZmN21PcTlBSzVvYVhCYU4yMHJlZklsUVh4TU00QURPMC85N3Br?=
 =?utf-8?B?Y3NzNkFxc0JjQ24ydmhwUERmbW5la3FmY2pGU0hWeSsxQ1A2SFhMMVdkM1V4?=
 =?utf-8?B?RUZyMzV5WUZTU1poUTZ2TFl6TnJOSUpkcHdCNzBuWDd6YWdTejl5eE1KL2c3?=
 =?utf-8?B?a0JxQWd5U2UycVlaMHQyck00U1N2RDNYVE56eXFpWXNOTkJXZG9PNGNiZEx2?=
 =?utf-8?B?NW56YTNiZW05VDZONkk0NkFhcFB1TGg3TXdzZUtZSTRyK1ZUVjBWbkE5MWhl?=
 =?utf-8?B?ZzRIbExva25RYjVMakZvazBySDVPekFlMU9WM0FVV1laMTQ0ZXN2Q1BRWWEy?=
 =?utf-8?B?RnNidTJUa2c5K3U0UTRUTXdBc1NmdkdJUlg0VUY2ZWhVc2F1UG1yWUNlYjRj?=
 =?utf-8?B?ZmFYQnR2bTl0ell1ekxHR3UzV05CUzQ4eldsR21GVzI0R2l6USs3cS90bUxP?=
 =?utf-8?B?akNnYjBZbGtzNjlEQkdOMkx1dzQ3ZXoxcUNJdHdhTUNyQ0hwR0xpYXYvN09J?=
 =?utf-8?B?SXhuMkthRVJ5MDJLdXFFbUsvY1pJQSt5b1lrakQzNFlmRU16L2NpZ3pBN2Jn?=
 =?utf-8?B?Ui9oK1owN09VWjZjWStRQTg1eEJweVAyOXdNZ0lMUDJ5U2kxZHhBRXZUb09a?=
 =?utf-8?B?N1VDc1NST2Y4NDlRZzlNaHhQVHROU0hOY3JlMllhMmoyZWFvVnMrOVVjUDNo?=
 =?utf-8?B?QmliMTFpVW5jeDg3RENpbU5yL2VOeWVWS1N2b0NDR05QM0JGZ2tFWDB4V3NC?=
 =?utf-8?B?R1NpY3JGL1A1NzR0cnNqVlBpaXY0Tzk5ZmFxbEM0MTlWM1FMOXU4bDFTYURC?=
 =?utf-8?B?eWRRVnhmUFZrRDl0YlBkUXdCMFdBWGlYMzd1QXh4Wk4xcnF4MW9uSW1SWXhQ?=
 =?utf-8?B?STFRVVVpUk1kc0ltbHI2RW1IZHBpU1MyWXhzU3NJb3pWQjlxOENnbzdYTnpW?=
 =?utf-8?B?UmF5bytoL3RPZkxSL0EvQWZ1UDE2KzI3a3FiVXluY3NQYWRIK2FSZlM4UEQz?=
 =?utf-8?B?T3IySHZNRDNSa2hHYzRFNzlEcW9pa05xUmptbjVBN3JCbElOYUcrdXJIdnM2?=
 =?utf-8?Q?NKWnAclX932QEo6t8sGIg9WcL?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0eafac20-50de-47aa-8b8e-08de39dcf568
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7997.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2025 00:17:10.7288
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ARgavxDXGY7URocNd8/TJmiyUae2207vGBCKKRxhbOQTfIQ9WI7FuoF9klQiGAvYwxygy5ntFBTuP8HELdAOLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8133
X-OriginatorOrg: intel.com

On 12/4/2025 11:03 AM, Ard Biesheuvel wrote:
> 
> efi_check_for_embedded_firmwares() maps EFI_BOOT_SERVICES_DATA regions
> in the kernel region, so bit 63 will be set.

Ah, I missed that efi_check_for_embedded_firmwares() remaps the regions.

> 
>> LASS wouldn't care whether there is an actual mapping behind the
>> address. It only relies on the MSB for enforcement. So, any code that
>> relied on accessing boot services memory before efi_free_boot_services()
>> could get affected by LASS.
>>
> 
> This only applies to code that accesses boot services memory via a
> mapping in the lower range.
> 

Yes, I was referring to usages which use the lower mapping. Though,
efi_check_for_embedded_firmwares() doesn't do that, enabling LASS after
freeing boot services memory is still the right thing to do. In theory,
someone could use the 1:1 mapping.


