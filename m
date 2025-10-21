Return-Path: <linux-efi+bounces-5078-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E7F47BF8033
	for <lists+linux-efi@lfdr.de>; Tue, 21 Oct 2025 20:06:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AE3874E7984
	for <lists+linux-efi@lfdr.de>; Tue, 21 Oct 2025 18:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53D6124728F;
	Tue, 21 Oct 2025 18:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZLxcEXg8"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED69633F3;
	Tue, 21 Oct 2025 18:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761069974; cv=fail; b=rOkwZ4/7TN7EhTMbK2/OpVkrrFEPSc9jTvZ3GbfUA6j0+/Gu+JtJdaPnqgtJqkhTSs32i/PXzdMdrEGBl+jdy9pxgTwtOdcYQtNUlH2xFhtyrSSVCFuGsGBZYJf5dkx3ivmr0Z9cGbpTYB68tnvKBeuIU1vNdpUnJn20ozwfZZs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761069974; c=relaxed/simple;
	bh=ewnOuCcvkIM6hwBn8L67urOyb/htvzDCnHhtPm2hRBo=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LWgBv7VbNQwpEiUZUnYY/pLlj0H3oOz/RbtpNmBH5AGHDn/9U6bvlGiTARgdo3tS5kMFHvU0V8RJ2lCVeBswSDWcOcHvJYe5PQfeqfjOu/bUgaZIQ+zXLcCVzw39OOAizuSnKOcYFNxbta6r3mB0cWHfyI9wHkR4Uh1tQkugZ20=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZLxcEXg8; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761069973; x=1792605973;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ewnOuCcvkIM6hwBn8L67urOyb/htvzDCnHhtPm2hRBo=;
  b=ZLxcEXg8uaDJopfgUj9+6R9Z2cv46YFYsjVqWhhrJz9q9eU5tTR7uO1z
   9mRgO9b311wV+NQAG70mnWmNIR7+W20i8wRiKowJvHTnxUtjn6X3gUOGZ
   5RZQAXzgmxnllNPRjeB2mE+iU/32Ka9b63AXEZ3AcA1UkT7JLd14XTZsU
   +ZlCrl7tym6KOiGtC4lFOND50vn+SddXM41I3PaVu72KFsjK4BfjtybZL
   CyWpmwrrSag9mNgZbaaRto4UTyKbZZ5bgFb+OK9rGjws8Maz/MdcwVJQx
   G5vk14ynTlw9ZU8ocUM4wrwphquOPU/L1rgy9w1MJQ3D4hne4Uad7q7TW
   A==;
X-CSE-ConnectionGUID: NxOI5cn5SLuusy60LVWuOg==
X-CSE-MsgGUID: Nnw78nrNSGaGthznwH2O+g==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="63354875"
X-IronPort-AV: E=Sophos;i="6.19,245,1754982000"; 
   d="scan'208";a="63354875"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2025 11:06:12 -0700
X-CSE-ConnectionGUID: 1PT/YOJfTyyL5PhUCl816w==
X-CSE-MsgGUID: VPAFarK+TR6TWKN7zxHqJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,245,1754982000"; 
   d="scan'208";a="207328701"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2025 11:06:10 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 21 Oct 2025 11:06:09 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 21 Oct 2025 11:06:09 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.20) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 21 Oct 2025 11:06:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ripn97gc099vxyfjAYf4O96DZBFF9uKyPr8wDDSbw3ni6wTWIEugCqqgt2+YaS98N18XEKsyPSnlVrwQuwguWvYEXLwdatL7mEIc9Y+3cjKQwVGS1D1F1rhtkyOzR+joG6sat4UgaVASW3VfpnpVPOoHeKTTRL0WdtZfWarepAy2hJQqDk2hscHWHQwbuQSOUxxiUVuS2JbHkRfF9/XC1IaLjYke1I7GIq7a3bHZb9TknqhxQIa0V1BgokIq0m18DWbW3bPmYtlB6BC5PPJDAYvD/16l/4I9nX00RoOxPsmfyJUX8bx0mPwrCKAfoYj0jvh9TbVCQZSmDAdSl5/wbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wbU67dPv54mlFqY5P9y1abT45LzMW810j/YCYTeKX6k=;
 b=GL0mNTvg7y1jU57SjZ8IbwnL4yBjEJo/YaJqLMqQKJAAbD0JKUZHUtG72PnY3/J3oaMPP7vMpiAC2aTsYnVmpF/jaoy9EjLkEJI8ImrrwxiKd97Z5K+VTc7ZAMK1gYqOP3sLOVkxCPjNmCh/EScZExF+AJIdnzgEMs0PIAl+RKN71rREXAffOwSovcc8WpT2PTe5bswPLs9gCvLcF6DHUDr2HuNAweDt7rOEg3VhrfiFFCDtb6D/7k8NDHonq1EJPcFAsanyhhy6PK2ccY9qTGiR8QbqSF+W9TythIxu8WsAXu1xObb5Va4cw6ALjtQGIkgm6Vr1HydP0962/bNl4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7997.namprd11.prod.outlook.com (2603:10b6:8:125::14)
 by MN0PR11MB6110.namprd11.prod.outlook.com (2603:10b6:208:3ce::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Tue, 21 Oct
 2025 18:06:06 +0000
Received: from DS0PR11MB7997.namprd11.prod.outlook.com
 ([fe80::9105:2b7c:b256:7a6c]) by DS0PR11MB7997.namprd11.prod.outlook.com
 ([fe80::9105:2b7c:b256:7a6c%7]) with mapi id 15.20.9253.011; Tue, 21 Oct 2025
 18:06:06 +0000
Message-ID: <714268c1-b78e-4096-a40b-b9c3861d4446@intel.com>
Date: Tue, 21 Oct 2025 11:06:03 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 02/15] x86/asm: Introduce inline memcpy and memset
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
	Andrew Cooper <andrew.cooper3@citrix.com>, David Laight
	<david.laight.linux@gmail.com>, Randy Dunlap <rdunlap@infradead.org>, "Geert
 Uytterhoeven" <geert@linux-m68k.org>, Kees Cook <kees@kernel.org>, Tony Luck
	<tony.luck@intel.com>, Alexander Shishkin
	<alexander.shishkin@linux.intel.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-efi@vger.kernel.org>
References: <20251007065119.148605-1-sohil.mehta@intel.com>
 <20251007065119.148605-3-sohil.mehta@intel.com>
 <20251021124751.GLaPeA9z8BCIe8AudC@fat_crate.local>
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20251021124751.GLaPeA9z8BCIe8AudC@fat_crate.local>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0018.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::31) To DS0PR11MB7997.namprd11.prod.outlook.com
 (2603:10b6:8:125::14)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7997:EE_|MN0PR11MB6110:EE_
X-MS-Office365-Filtering-Correlation-Id: 90227f3d-c4a9-45fa-b9bd-08de10cc8155
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MzJJMnI0UHh0T3d5Nk4zbnB0ZWZpK3NJSmc4aXhxTXptMC8vVkpiUTZwMk1T?=
 =?utf-8?B?d0xLUDlOU3BCSzdLMitUTG1oaGtYUllienRlb2lyS0twZHlsUHM4a0I1VjZq?=
 =?utf-8?B?NDVUcjZReHI3dk4wS1ZPRjBMMmFxbm9DZGhUM012bEx1Y0xkNnNBekdrdE1U?=
 =?utf-8?B?YjE0Y2RZdzVsOERwU29sS3d4WmZUaUpVd0xlNlQwQjllZjFCc2wyL21MK3lV?=
 =?utf-8?B?SmRwcFFhVVBtY2tsSm9HU2JITVVYZVhaeHdRN2xCU3NUOEJDMDkva0hJaXZJ?=
 =?utf-8?B?SE1uWEJNSzlrWWFXRHpmQjlWbEViVkxrek90YmZJaEZ3NXlROW9kY0FzcGc3?=
 =?utf-8?B?dEtDeUFkZDdqQngvYWhYNTF1aXNKazgvVFQrZzczYUZ4MlFVeTVzbUp6TTN3?=
 =?utf-8?B?anVZK1VSY3k2cHNLSlNUQTVOSy9Cc1pUUTNqbnI4UkJNWURsMVcvNlJCRWda?=
 =?utf-8?B?c2ovMHpIaVJJd0RZdnpwMzVBeVp4Rnl1L2dEMS9BTmN4Z08zdEovREI2cXdV?=
 =?utf-8?B?NDJzMXBDa2c0dUZucHo2WmE2WFpFcjB2eUY1bm9hQnp3SXZkN29jMmN5RGFr?=
 =?utf-8?B?WjRmYUlJZ0tEY2hjQXNjUmNXY1RrVVY1Q1BFTjAxOUVENThTQy9TV2paWnky?=
 =?utf-8?B?RlIwNFI2YXUrdU9yT0NKM2xpeEdhUkZpNlBNS0psaVB6RER0UHJyUGZVRy9J?=
 =?utf-8?B?VGxkcVphaVVoaUdUcUlPeEZsTWRFdWd1YWZlMldHbG1lZXNwZ05jTCttUVA2?=
 =?utf-8?B?cFB1U0EraEw2amZJMFNCV0QwSkYvYS9TUGtMK3NORDlQRFo2cVc0ZmQ4N3ZN?=
 =?utf-8?B?WmU0L3B1bHVqS29tRElUd212UVpMQVR6QVNsdlFaYWRzRzZSejlURnRLb3Bv?=
 =?utf-8?B?L1NFQm84bWphVHFDUzJ0RldHQmNoMzRoVURWbW9MbWVUK24rUVI0NWVjVEhn?=
 =?utf-8?B?dThYdUJMT2pPMy9IR29LaHhKRk9YdVBKN09FaHM0bE1aVUpFM1NPbGJLTFRV?=
 =?utf-8?B?TERqZmdTSXFxc09FS0I4S09ubVBMdzNTMlNGV3c2OG1oT1VYV2o0dEVpbTNS?=
 =?utf-8?B?Tk15L2FJc25MVnBMN0ZDMnR3TlZ4cWpzNHpvQ0lpd0xvbUl1OFBzSno2d2p3?=
 =?utf-8?B?OFVsNUFyZ0V3ekFieGlOZW9iTTNKZWQvTjhqMUVzYUVsZ1ZuRDZ5K0VMS2F4?=
 =?utf-8?B?aFhoVXkycWJiZDVUQTNXbWxvbEVLOEtwd291YTg3NlJwUm10QWtIL01TaVlz?=
 =?utf-8?B?VEZTRlNhZGlDNzRBY2FOUVZXTkZkSGhUWklBcFduQ2w4d3ovZWlHTTFBOXp6?=
 =?utf-8?B?VHdCN3EwN3hTdE1aRStLZDBtcmdwLytUZVFPeDR2VlZJWUJTQ0VBNzNxVEhz?=
 =?utf-8?B?TUpiMFFoeCtrUjhaSUZ0UDVOOTQvNjZvd3REdEdhQ1JCUk92cWJTTlN4blZn?=
 =?utf-8?B?K09zV3pOeUxTaVV5dmNhVktYSGkzeUdhTXBMVG01dytxamhld2JnV1hHMFQr?=
 =?utf-8?B?WTdmSlR6bGhYOWtwVENrdzBKWDhQVEF4YWtxV09sMFNkRUYzUnUyZVlhcWFT?=
 =?utf-8?B?UnBxU1RveFJySlVBSVVBZ1UrT1U0TWtLSEwySTRZNWt0RmtoUERGakJ6My9y?=
 =?utf-8?B?ajlkQUtmNFhTOTJpc1F1aytyeXJGd2doNTRRMnB1MUMveUdZNzBlU3c2bXhV?=
 =?utf-8?B?WExKK2tlRmUzWWE0Q1RVTWtKM0t3UnhYN3JTZTFPRjhkZkV6dmY1WTJFUFRp?=
 =?utf-8?B?Z3QvNERBN0F6aitxMjZDL1p3VUhYajBRUG1JL0pueWZkWHZPeE43ZDA2cHdZ?=
 =?utf-8?B?MHV2dnBreWcvVjNlOU5xbFpHOUhzQ1VEeitndzI3WU9Gcy9EU0lnVzlLNXpV?=
 =?utf-8?B?T2FDdUVENDdraHI3UlNqSmNCQWJ3R3ZoY2RCTEFkLzVJU2dnQVR3YzdPYiti?=
 =?utf-8?Q?WLugdv8UuUpTf6uXSb5805uHnf1FogfV?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7997.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ektNSDEzU1BaNFM1czRLajhNaGVlNlNrSDdpbUxZQ0FZc0lHZDFLaXl2ditu?=
 =?utf-8?B?aHFCMjhkelVLd0F2a25xTHFYZlkwY0FrbzFGNjV1ME9QZGo0RjJUUkVwVU9w?=
 =?utf-8?B?cU8xalFpb2M4UUFuSVVaMGloL25TbldGTGhhWjJiZE1VdnpyVklRSXhCSUFZ?=
 =?utf-8?B?OXhkWURDeTJRT1lUaysrTXV1RDYwMEJHZUxmTElvaCtCbmlHWDFmb0ZWUzRz?=
 =?utf-8?B?QVJFU2RUNEl0Z0s2QndIR0FOTmdwZ1QvS2FGbFd0Z05rL2RrQWtqcSswQ0xS?=
 =?utf-8?B?aC9RUVU4U3VqR0g5czRvZDhHbklpT2syYlE5MHFWaklYNWM0N1E3bXBjR3dR?=
 =?utf-8?B?OUZnZVpKSU5sTTZQQU0yakVBYUFLUXlJbWlYWnFzVXF5dVd1UVlGMGs5QmhH?=
 =?utf-8?B?aEhzUlo3aG93V0kyNDQwYitibU51WHNNVzdaaFJ4RGJnMVc4MmIyUlNiQ1VR?=
 =?utf-8?B?WXlXTStVU0ptaStkY3FYMHA4VThwM2wyYzJ1TVZ6a0UydUhWWjBncVFzZ2Fa?=
 =?utf-8?B?OVZsZm5vbGpBRXRLaWQ3R0hFMGpsL2VmZDVScmtHWEpaSlNhZkd6UkhXcndB?=
 =?utf-8?B?MWR6cExDd2lEMmJva2NYaHRPaFhjS2Vna2RjYThKYW1IQU54K25TYzUzNHFW?=
 =?utf-8?B?SzAvQ0MreC9YVHFnR0thOVJoSjZnUnZWOGkyRHlLT3J4ZDg1RUNDZDRaZVAx?=
 =?utf-8?B?TGtwUDlqTWJXQlRLQmd3TFJVdUlnZ2ZUREZXYWw1V2FIanFteDNIOG9sRzk4?=
 =?utf-8?B?QU52QU0rT0NqTkpmM1hXR1NtdE9IaGxuMk1NcXFVclBlTWdlSVhDZlg3YTZn?=
 =?utf-8?B?QVVzU1dpd1FpN1RnMFF5dDduTUJWZ3hNNzZLU1FncDZqbTJiWlFRWjVESXFV?=
 =?utf-8?B?VFBMNHJjNEZWYjY0NG9xYnF0cWxLZ1JycE1HZE0xV3BpNDdJVjYxRnErRHRY?=
 =?utf-8?B?Z0xQRUZ2MjVzcmtERlNMRVc0NEdMakxJZnZEWllDS1QwZXhoSUs1bm9Bbk1y?=
 =?utf-8?B?c2FUMG1wUjc5OWcya0FIUmh3TSt3UitDWUlVdHplYklkQjluQzBtYjIwOUla?=
 =?utf-8?B?SkpvVUlpVVdmNXlONUp2bVgwYnRlYVRoV25KWUo5Y0d3azlacWlkYUNrRU8y?=
 =?utf-8?B?TEtnT2V4WFFmdStxTkFxYjQ2ZEZyZ0R5QVVqN1FZajhFR29kaytsbkoyQVc3?=
 =?utf-8?B?WkNreVlhY0tTQ1I5T2c4N0dLNExtdzJ2UU5hcjhjTmJKaG1UK1huSHBlbmcz?=
 =?utf-8?B?VzNOMkJuZkRuOFNkRUlJaVowU1hueUxSYWFpa2RMOHNiZFpNeDBhT3NoaFYr?=
 =?utf-8?B?anVvN0FtTGl3dmM0bjhPekk1cW50MHFIYUdtMEIySS9IYm9aejlFMmNrT3or?=
 =?utf-8?B?NWNqeHdtZE9qZnRsb1hBTGE1ODJrc1h2eWdIQlozemV1ZDhsUmc3aVdIUHBB?=
 =?utf-8?B?YTlZRXFGeHByL091VGFBQmtjbzBqRFBOTWdnK3M4U1VWOUZmRWQvSTdzZXVr?=
 =?utf-8?B?dktwaXpadFlFSWRqbER2QnZxQkZHQnpVZE5adFlaSEdCbGUyekx4Z2c4UHpk?=
 =?utf-8?B?Sy9aeS9lckVQbzNFUzE2NWVzSFQ1VjBTbHordHI2U0kzd2hwSWVyeTEvNUhu?=
 =?utf-8?B?OEREeHJtbUNLZnlRb0xTN2NROGNPbjg2MGhOVHF4Q2lJM2l0OVJQL29RelRZ?=
 =?utf-8?B?YmVHZHQrT0tDS3lWc0hFcWpuUTJMRGlyaXAxcTFmWndBNnB1bDFQVmFzMGZN?=
 =?utf-8?B?dTRvK1ljNXA3b1lkRGNOZmE4Wm4vZm9DYUVvd3FINlU0SG1qUi9UMXlnb2xI?=
 =?utf-8?B?c0UvbmFLTTRzL2FYRVlYU2g4OGViRDZnTlI3djBPbndvVnp5eU1uaGR3a1M4?=
 =?utf-8?B?TGhMUGk1Y2x6d2ozL1dMak5sbWU5ZlhBTVBWa09OVS94N0o1eEFFUDd5ejYr?=
 =?utf-8?B?Rmw1aDduZXJKb0ZkR3g0b2tFeU9BL2xnUXlraHVRS2lmMkN3MElSUkgxVFN0?=
 =?utf-8?B?cVlyZzBxbDk2OUVzWXV0UGhYRXZIZXdnNktLeHFzcVkyUFpZL1B4aU5YNWdt?=
 =?utf-8?B?RjVFQ042V3FicVgyNDB0M0JrNWw4aEJEbXdDeU1jcldOSWU2TERZaUNPbDYr?=
 =?utf-8?Q?IxPmx8IldiNlAI8COlMYfr7P3?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 90227f3d-c4a9-45fa-b9bd-08de10cc8155
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7997.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2025 18:06:06.4582
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8n3ibQC21Cjm3xqfFNDyaaezmpYJvwt+PYzH8zZC/G2ng4rCCAl6futqskSvOZpwIMxCVS75AJWPcdDlqaE1dQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6110
X-OriginatorOrg: intel.com

On 10/21/2025 5:47 AM, Borislav Petkov wrote:
> On Mon, Oct 06, 2025 at 11:51:06PM -0700, Sohil Mehta wrote:
>> From: "Peter Zijlstra (Intel)" <peterz@infradead.org>
>>
>> Provide inline memcpy and memset functions that can be used instead of
>> the GCC builtins when necessary. The immediate use case is for the text
>> poking functions to avoid the standard memcpy()/memset() calls within an
>> RFLAGS.AC=1 context.
> 
> ... because objtool does not allow function calls with AC=1 because... see
> objtool/Documentation/objtool.txt, warning type 9, yadda yadda...
> 

Sure, will add some notes here as well as in the next patch where it is
used.

