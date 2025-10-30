Return-Path: <linux-efi+bounces-5269-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E58A6C21F00
	for <lists+linux-efi@lfdr.de>; Thu, 30 Oct 2025 20:29:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EBC9427861
	for <lists+linux-efi@lfdr.de>; Thu, 30 Oct 2025 19:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A645E2EE607;
	Thu, 30 Oct 2025 19:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CAeiBPp0"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD11922B5AD;
	Thu, 30 Oct 2025 19:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761852541; cv=fail; b=uL8PHdqhwnr3EmhZ3ueuw5qhCdiEdZrdgBLTtiMEiiFIr8asX0NZnEH6nFW6bFKzsljctterKBIeIMaU+WzCq6eAgO1MWXCnIDwot/0OwkVZCcuYZ9whC+Yi6wNdX524u6+1zELoMWxWlsVqqT+If9NviEAOiR1aKZILUDFLGVE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761852541; c=relaxed/simple;
	bh=Z6vS53LCrBhr9ynky3iAfyMGrJHgOCxY5Yf8VXcCNjE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Rs0y6pBONN0ZQhrtupoQ2XdEhovH6QlguYezPPFD8aoYPkN9prU15avzJf93xxOy21XXF7KHJSBBPLp3zJr/BbY8wp4r5fCeWAf1y3weeani/wxdjeggiTpiU1FfgbggDArs77FaIpsEbzPzkfMes+31Pdmo5X06qEogxQEm8Vg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CAeiBPp0; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761852540; x=1793388540;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Z6vS53LCrBhr9ynky3iAfyMGrJHgOCxY5Yf8VXcCNjE=;
  b=CAeiBPp0nIVQvbHuOctBDMMJ1J0GjZbLSzcVHktLEtd/8fEvbPT9N8Ug
   O7vyb3ZqKZ33oSU2cbMKa+m0h4XNuwYxs4YKPBKcG9wdViVXUR8A2jVg8
   mQvcRveyzUAX4AiCPSQlN5a4dSaKU13O1DD7MJ2XsvnqmP8ABqdMblmYG
   X96kf+x5KyDXt8g1FnSF8ojOLKpFVmq+s8hoGc4Ufnl+2RgL5Y/GxDa9V
   vS90mKaFMapYZGq9TWBo/VE/YByb/2uDwJl1k+I2HijvxxDw02B3xq3Ud
   J9dJBUo6zpPqpWyu0Tp6zpiyuBQHsi0XViCTKS7RxRu06aZz4G0yDW3LZ
   w==;
X-CSE-ConnectionGUID: KpkLtU7wTK+U8HKn89RXNw==
X-CSE-MsgGUID: QsY7qtF3SDi4KXqPJ/YJYw==
X-IronPort-AV: E=McAfee;i="6800,10657,11598"; a="64047932"
X-IronPort-AV: E=Sophos;i="6.19,267,1754982000"; 
   d="scan'208";a="64047932"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 12:28:59 -0700
X-CSE-ConnectionGUID: 0HiF99bcSteel6u31nZjhQ==
X-CSE-MsgGUID: Tc2Pks+dQMKbWef0qZMAOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,267,1754982000"; 
   d="scan'208";a="185308270"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 12:28:59 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 30 Oct 2025 12:28:59 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 30 Oct 2025 12:28:59 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.66) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 30 Oct 2025 12:28:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PHb5EzEmM1TwSX0xMtMzBBKMihJBEmKVcTCvJka+KiYcM1CYHhThbHjSK5D/vFmnPZCKS20zfRN0Ciszp1QJnM+eGDKEKlUHlxScYw9Q8YAivgihhOc75iwY2LFDzpyo5tWy9IlayDquc2oBg2UPHrVKk2RONokfH/VFacz9euqOEuVh0e4ibViJvpp3ui4+8DseRKCbE+vYpdSBlyiF9VGMhgkTxFyW4HtthDDGspW0BUY1EHr2OeWM8NImf1w5lM18UKStjHS7fAmlTF69/ZDjnpI9CLs2yRUmWW8Ba6tXuCOCatZMcC9TOSgQMX7XGpcGIEPFpP0RFAaAna7fGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CXNdoKaAiVXUwTVGLcDVVGP9WzpJfhQ3O2nvsdWSowg=;
 b=iO2/WrjDd/9eg9IcVfQXd1kSXnIcCHdFzcd0OMHPxDGfqvdKCwBh/IYzdzxmqsrtvOija5jN58i6NN16iPIKCVjOkW/jEoDnAALYWAQ7Cn27Pqz/rWUaeI0g05FiJD2dkBGeuQtl/iPdoppGGviG4w1mfNR9LzrUXLqvOJTt+M98P22N4Vquiq5tV4IseM0JpAFLADa+zykjmZKwrwBxDJi0O0rwrKMdH40BftU+BAXjvGncaOJZbwYrEuBVHm/Bgzcv9+Ha7PAzChsKBk/t+NucqEOsjF3wYO6CR8GCUZW6c/F1/aT0s3jynOxaDKjmu5gIikm6v0mySPFadZ2L9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7997.namprd11.prod.outlook.com (2603:10b6:8:125::14)
 by DM3PPF291EF9BF1.namprd11.prod.outlook.com (2603:10b6:f:fc00::f15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Thu, 30 Oct
 2025 19:28:56 +0000
Received: from DS0PR11MB7997.namprd11.prod.outlook.com
 ([fe80::9105:2b7c:b256:7a6c]) by DS0PR11MB7997.namprd11.prod.outlook.com
 ([fe80::9105:2b7c:b256:7a6c%7]) with mapi id 15.20.9275.013; Thu, 30 Oct 2025
 19:28:56 +0000
Message-ID: <e3c7987f-7f8d-41bb-9d4d-966f35941757@intel.com>
Date: Thu, 30 Oct 2025 12:28:52 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 08/15] x86/vsyscall: Reorganize the page fault
 emulation code
Content-Language: en-US
To: Andy Lutomirski <luto@kernel.org>, Dave Hansen <dave.hansen@intel.com>,
	Rick P Edgecombe <rick.p.edgecombe@intel.com>, Thomas Gleixner
	<tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, the arch/x86 maintainers <x86@kernel.org>, Dave Hansen
	<dave.hansen@linux.intel.com>
CC: Jonathan Corbet <corbet@lwn.net>, Ard Biesheuvel <ardb@kernel.org>,
	"david.laight.linux@gmail.com" <david.laight.linux@gmail.com>,
	"jpoimboe@kernel.org" <jpoimboe@kernel.org>, Andrew Cooper
	<andrew.cooper3@citrix.com>, Tony Luck <tony.luck@intel.com>, "Alexander
 Shishkin" <alexander.shishkin@linux.intel.com>, "Kirill A . Shutemov"
	<kas@kernel.org>, Sean Christopherson <seanjc@google.com>, Randy Dunlap
	<rdunlap@infradead.org>, David Woodhouse <dwmw@amazon.co.uk>, Vegard Nossum
	<vegard.nossum@oracle.com>, Xin Li <xin@zytor.com>, Linux Kernel Mailing List
	<linux-kernel@vger.kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, Kees Cook <kees@kernel.org>, "H. Peter Anvin"
	<hpa@zytor.com>, "Peter Zijlstra (Intel)" <peterz@infradead.org>,
	"linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>, Geert Uytterhoeven
	<geert@linux-m68k.org>
References: <20251007065119.148605-1-sohil.mehta@intel.com>
 <20251007065119.148605-9-sohil.mehta@intel.com>
 <a33d59c7add98dd9ef352ac95178821dbcd0ce0e.camel@intel.com>
 <3e3d2426-6296-4a61-beae-4e3ff5d60f2c@intel.com>
 <f4ae0030-9bc2-4675-ae43-e477cd894750@app.fastmail.com>
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <f4ae0030-9bc2-4675-ae43-e477cd894750@app.fastmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0009.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::14) To DS0PR11MB7997.namprd11.prod.outlook.com
 (2603:10b6:8:125::14)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7997:EE_|DM3PPF291EF9BF1:EE_
X-MS-Office365-Filtering-Correlation-Id: 06b69982-344d-4076-7b67-08de17ea917d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YUY2ak96M01JSFZMbjdrY2hoRWlYS1ZsZEEydUhqemMra1k1WWc3dmhtYnBY?=
 =?utf-8?B?SUFFd0ZOa2dRWWtrWlR4aHFDQU5PRUhNS3E1VCs5ZTBwclQ0REFTM3JkbnBJ?=
 =?utf-8?B?eStXK1FMcDM5MUVZQmRheFRDNzdNcm9pL0ZzZUI5dElrcXBpbUdWemtlam1G?=
 =?utf-8?B?Nk5FY0wzVWN2MEpySGFrRjE0Z3cxeXQxNjBxNjl6ZE1ZQVZzTlVDSmhRNlhT?=
 =?utf-8?B?dHBpUVpNN1VTQ21IVElyWWxtN0s5aVlkQTcybDZWMDFnNWZWNU0xU2krZ1Z2?=
 =?utf-8?B?QzF0c3lPSDVZampzL0trVWUrNFpBZkhuemxxcUxhckM0ak96MGRScllKZHFn?=
 =?utf-8?B?NjZLOHFkdTBmWDFqSXFMZXhNdk11ZGVBdnlabFpsT0JyL1ZQWFQwNnZsYm1Y?=
 =?utf-8?B?SGtJQU1kN3FVUlNLSDJ2bG5QSWh0Y2ZwTTNDVTlXaXZrWlJLWWxvRFROSnNF?=
 =?utf-8?B?TzVWL2x3N1BtN0VzMW9lN2VSNHhkNWFyb2xRTFhFRVIzZ0tMNnFHV0p5ak9h?=
 =?utf-8?B?SW9pT084MU9Ndm1NcUZVKzMxcUtCVnErMDFmMytaTXBETDlFdjhWaUZETkNM?=
 =?utf-8?B?ZWRwSjA1QVN0ditXQW41djRPUnp0T20xRldUUjRPcldab1NtVERSRFFSUGtw?=
 =?utf-8?B?b3RZTm5YNnptc1picE9HSytON1pZZkI5eXJEajRudHdBV0xyL1dxT2xYamZO?=
 =?utf-8?B?U0diNVFVZk5VVUlrLzZvSzR6eGI1dFpodkRYM0p5WHdQR0JOUkowYVNVWHNF?=
 =?utf-8?B?ajFSM2Yxb3hPNklWT3k2Wm9wamtUa0VGOWJWYjlYWVBqMHRBSld3MVVSUUlu?=
 =?utf-8?B?cGkyQkVUaUtCSWFyRGJmTWdjZGFNaDMrQmNINlpsS3RvTkl4NkZxOXRDUWVP?=
 =?utf-8?B?cnpKbDNta2RLQThLVllsSWdoOFl6djVPUmFYWDI2SDFXdDhHSmUzT0dlekMr?=
 =?utf-8?B?NTBpdmFXQWJ2TFFjc3hzcllKYUF6SjJpbzF4Z0NrWGtCK2dMQ2tjcnVmRXVS?=
 =?utf-8?B?UHB0cWRCQm5TWnhPbGpQSkZzR3FqMFlqeWJHbWF1L3pSTk1jTU5QREkyNTRq?=
 =?utf-8?B?cERqdjU2OUxqU1p4U09WZllUdkloeVRGYzlVcDRVRmJEK3k0NDIxQ2Q3OGlt?=
 =?utf-8?B?elBGRS9GODFKckR1SjBtUlVueUI4ZWpoTmZjNGRXYmJGaUVxKzFxR3hpSk0y?=
 =?utf-8?B?SUdha1VEdkxpR0JPUjI1L2ZFeStGdno2Skh6OHlJbHEwZG96TlljNjlCWjJy?=
 =?utf-8?B?V0NuaEJWTDRnR05oYzhwdElMcHNyNVNlL1B1emthVHdkNzJEUW1UcWhjS1Iw?=
 =?utf-8?B?QjJHQXVnNDg4UWdPeUlieDhDQnRHQ1lyTGFnLzIvNFJTOVRmKzFWTmhrUDRN?=
 =?utf-8?B?UWUzbFVHbjByUzRRQjA1aDNBdFYrV1lDNjZibHkxdFJmMXc0d01XWTEzcmt0?=
 =?utf-8?B?NksrK1NBaWZHQ1kxYkNpZEdDb0FCN3Zhb2xvOXR5Y0J5eklScjZ0THR3NW9l?=
 =?utf-8?B?dVZDcno3MDhCVFZEQ0FVY0V0Q2I5UjQ5b3BvK29Jc3ZiZytYcVRPZ3ZTZ2th?=
 =?utf-8?B?Qng2dlFKOGZ2NllGSElTbE13MVlFY2ZoRThVKzVtVmNnNHVmcDRiRUxzVUV5?=
 =?utf-8?B?M0pEUjVaYmdqMmlJVWQwVXc0V3BhMFRJc05CUU8xVldlczNRTFk1M2RRYS9L?=
 =?utf-8?B?NThUN1MxNlNoYWVsc1ZRTjZTV1o4ZEVvQkM0UnRGNktTbHBvQlp5ZlVndndo?=
 =?utf-8?B?a2ZVVVBUamZEcENVd2NibGRyKzR6TGlOYzRzTS9aNDZza2xyazVranA1NlFE?=
 =?utf-8?B?MHRwVWlhYlQvZFlLYmF0czd5Y1ViWHhJNkttS3d4NURsSTZlQ25wOXBZdlNC?=
 =?utf-8?B?eTNmNXp2RzlWajBiRDdIN3BaOHFXR1Q2bHFYQ0l6SWQrKzB5c3EzdllVaTZq?=
 =?utf-8?Q?dZDJtEJkzl4+tMHFvEMAq3xPUywTf8Tq?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7997.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c0FkNlVUV1plNlJsNmFDSy9PbGh4aHl4MzYyS0NjZGQwcUwySjBidXlxUDhB?=
 =?utf-8?B?amFnRFk2ZDBBVm9zZnhFK2VmYlhDVFZUODR1MGpQd1Z2M3cxUDZVK2ZTK0Nq?=
 =?utf-8?B?cWIzWitKN204S0YzL3YzSEU2MDYybm96dDc4THIwc0NTakx2bU5sdDZyV24v?=
 =?utf-8?B?OEsyV01USUluc1hzbHVLYkNjbW5oQ0MrNDhLVUVFUGV0dEZtSXBYWkIwdWEw?=
 =?utf-8?B?TWRyRVluZnRRTjZPNHA0ek10S0c0cVlHUWQzeGlJL2szL0dma1VJTmJqWVJV?=
 =?utf-8?B?akxjNlVkTnJaaFBIRGdwVVdyYmFEekpvVGVlS1FXZHVwV3Y1aXk3Q3FGWEpu?=
 =?utf-8?B?ZjdONHNQeGVwdzRqWUhMTFNVKzZWNVpXTWRINmZLYklFQjFqRFpXc1lQL25Q?=
 =?utf-8?B?TVJ0Nk01NGg0Vnh4dDRBK1RuRVlRZzRzVm13WHNkVEZDOGVCTytQU2k5VmxZ?=
 =?utf-8?B?by8vTjlQWVRyaEN1cERVbVdtd0NCWXBkaUhLR0VvQ3Z3eTZjbUs3UEtsRFA1?=
 =?utf-8?B?UlBLd0pYT2xiWUNmUzZ6cHVpYU5KS0Q4djJNeS92QzV2L2dvMVdscS9HODNP?=
 =?utf-8?B?SlZxdXdYZ2pkSmwvSU5BSzJrQ1dhWG51M0dnVWhkRXZxQlN2WDFGZmtkSmZR?=
 =?utf-8?B?ek5XK1VNRlA3QVBkQlJDMWJlQklyQjhhQy8rb0xYQ2pVSjNCSEwzd2NrZm10?=
 =?utf-8?B?d1FycHp6SlRlRVppTzRtSUNiOCt4VUN3eHRMeHpvS0YvOWN2bDRMZ1AwSGEr?=
 =?utf-8?B?MFZUblVqcTZiVk9sZkVSOFBkYW1iMmlva2hUK1BGcVZzbXNLSll2S2ErQzVS?=
 =?utf-8?B?M3pYS0o3ZGxNSUNUOXVVK0pvYk1JTWJ5eXdVbkhISitWb29EVXZScDhZRy9E?=
 =?utf-8?B?MVI3Z0psU3plVmtVQmI3a29ISEhuNHp2RHhvb2VuR0JicCs2Nk1mTVdxSTZm?=
 =?utf-8?B?TzVmcjRKeU1EclRBa0tGemM2bTNlejhvZi80QVJEVzdxZ1A2SWpHMVc4cXFa?=
 =?utf-8?B?WlNyN0dhUjd0YXlxR0FET2dBd1AydEkzUW9HRnVSRjhQSDEydDNScFRRb0x1?=
 =?utf-8?B?WDJwY1VKWndmYi8wYUMrSnpaOGR0d21oMjhuSkNkNWFmYlF1cnE5QkFpcmZK?=
 =?utf-8?B?c1llcGZqY0JqR0cwTE9iQjd6ZnN1STFMd0s0bUFQcXE1S2lCMWVkNHcvRC96?=
 =?utf-8?B?VHh5ZHdaWnR6Zlo2TUJIWDVHR2Jud0xJdWszS1BzakoreVhwbndBL0ZVemgv?=
 =?utf-8?B?azBiR0FiN0V0Qkx1bUdoZURldHNBeGZwT2VVV0NmYzROdDFEUEJ1aE1IbWJI?=
 =?utf-8?B?TXhkWDlMcU4xSTlDaTltVysvSG5USk1ab241Umk0ekpsMXJEOUFMdm9YSi83?=
 =?utf-8?B?VkczMlFnUW5GcFVjLzRXZ2tRdWNqQ1RMdFdaaWFPanUwVjRsWkFuT09MQnRu?=
 =?utf-8?B?QkM5U0E4VFYzclg3NFZmKzNoU1NuRkNKR2JYTjdNWU03bi9CMXRlaXhscTQy?=
 =?utf-8?B?MVlvczlCWkFGaFRIYjVORENaNTE2UFIwWDIwSC9RZlZYMTJjNEsxVWUvbTFw?=
 =?utf-8?B?OStyaXNqclJUaFZtUEc5ek1GZnNaV2JpWHpSR0JZTGEyMllRaHlvQ2dkbjVK?=
 =?utf-8?B?cDdOT0hHbnBGQlVSNW1rZndzM2RrMDRzTzN3UnluVGVwMHoxUEFrOWVqcjB6?=
 =?utf-8?B?cS9mK1NrcjNiMC9jUWNSNEp2MGNyanJPK2Q1M3Rjd3dTSGxNNm1DbXdMZ2xZ?=
 =?utf-8?B?ZERBeVUzVzgxdEZIaVhLVjVxTTJrMUtqWlQ1WElMVUJMczd2dzk1Qkd1SlZ3?=
 =?utf-8?B?S3VKOEtLckdUM2s5Zmh5bnp2Z1dpY2l5UjJMVUY2RlVvN045Rk1pcTc2V3o0?=
 =?utf-8?B?QUlPaWFIL2JQS2NuNzJ6UFBleUJsOGo0d2h3aG5LMUgxcDJvQUlQWFhvTktv?=
 =?utf-8?B?OWgyamhYdnBrbXFRWk91NWFDRzFPSUR0WEMzSHBkM2pKeStSTWNNZ082WXRx?=
 =?utf-8?B?blk4R0NlUFFDSzB0UDluNXpUZ20rRjNHcGcwZ0U1WXYzaHdDczg3azd5Z1d0?=
 =?utf-8?B?SXVSZ1kyaElDVnorQkUvUjZiSkdmT3d5RUpDclQ2YzVtL3J5NS9jcEkyTTlO?=
 =?utf-8?Q?a7Q6Qvy8pLRawoNQUTIg96kaZ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 06b69982-344d-4076-7b67-08de17ea917d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7997.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 19:28:56.5947
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k72d7Ju03mYbkk+RC30tLHhcWDn5InG1oS4Tzq0VCP9cDIXsjPl3V7XNGjumucziliXAwzd5cdoBkSTXkEmKjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF291EF9BF1
X-OriginatorOrg: intel.com

Thank you for taking a look at these patches.

On 10/30/2025 9:58 AM, Andy Lutomirski wrote:

> So I think all that's needed is to update "[PATCH v10 10/15] x86/vsyscall: Add vsyscall emulation for #GP" to check user_64bit_mode(regs) for the vsyscall case.  (As submitted, unless I missed something while composing the patches in my head, it's only checking user_mode(regs), and I think it's worth the single extra line of code to make the result a tiny bit more robust.)

I probably don't understand all the nuances here. But, the goal of the
check seems to ensure a 32-bit process running on a 64-bit kernel
doesn't ever go through this vsyscall emulation code, right?

I guess a user_64bit_mode(regs) check wouldn't harm. I'll add it when
the vsyscall series is posted.





