Return-Path: <linux-efi+bounces-5322-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 85D7CC26DC5
	for <lists+linux-efi@lfdr.de>; Fri, 31 Oct 2025 21:05:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2DDE24EEE93
	for <lists+linux-efi@lfdr.de>; Fri, 31 Oct 2025 20:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C883320A3F;
	Fri, 31 Oct 2025 20:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e3MpTOLg"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90992F7446;
	Fri, 31 Oct 2025 20:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761941104; cv=fail; b=X3UFtDGkbPCojUzCZTkaPoD8IMVcR0DogD8TkZUdtYrQzUlcnZnBcaLhnO/h5GeR8d2RC3o1cdvtxTnAk3T8oay41rnImzL2+cQjRMtWORtxn7uNHcb5TpleH+c3ovEMqUj9mdyzUCsQJX/BjBglXTUcgfnnO6lE2kOBt3x034A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761941104; c=relaxed/simple;
	bh=w9kLA4XLzap0ALxIhxV9Z92JAEDu7BnsXi94SIaagIU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TQ3W3VZaAIdwk4+ERjdR02AvBJ4JGFLXAjPU5RpXRpNrIUh5MldUQczoe3j8JvlDyfYvnoEBY9UDzk+PVtZQsWnuuPCPi2Y8kbiXMPISlW5lFk0J6ncZ8P53mhM3vibni7cZ2wosm4iSW+Zy/aK5Sv58emWNnDnryFQ00bH7axQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e3MpTOLg; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761941103; x=1793477103;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=w9kLA4XLzap0ALxIhxV9Z92JAEDu7BnsXi94SIaagIU=;
  b=e3MpTOLgG8jGoiV1hotqs82TgvhqR200DLpu1p2uZ9So3WvhqlPAROXN
   uhNNtNQb16oGRnvm6Hz5e/BOaTeFqVM44CRgWIgQ5CGw+dPKBTYAAQUCl
   LpvXY6za6gHW5nqEFWsp3ZSH57RVn/WMymooey+s9OCmXwO7FqDrTdJZ2
   BokJRmzOQzYouPzTca1xT3rODT+gCQnDLWEm9AV4yVlRCJKcjDj3v8V4F
   JuECO3pj5Di8x6euNk1brKmlsQOQCShnpFGP9TdPYm2XYch1CU7cVOek3
   BeVq8YqfNStRgs8SAqUvKoHVxq6b6W0hZYqpHO2PSP5mzenHwmJYKndNL
   Q==;
X-CSE-ConnectionGUID: Nkco5sLbRqW2LVAJTa+IcA==
X-CSE-MsgGUID: n/B53oy6QROQIhc3ZGdg8w==
X-IronPort-AV: E=McAfee;i="6800,10657,11599"; a="63997912"
X-IronPort-AV: E=Sophos;i="6.19,270,1754982000"; 
   d="scan'208";a="63997912"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 13:05:02 -0700
X-CSE-ConnectionGUID: PKRkBDo4TquTyHuObIhmag==
X-CSE-MsgGUID: eE/359IMS4OGvNC+hY6ZJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,270,1754982000"; 
   d="scan'208";a="209880602"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 13:05:02 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 31 Oct 2025 13:05:01 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Fri, 31 Oct 2025 13:05:01 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.28) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 31 Oct 2025 13:05:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AsOa2d1AfrJRDSC/RL+hKdHK0EbnvSf9Y4o9UgN5bNxdOjBgGXHHD08fKvYmhcLFiCPKqlnDhLJo97IiiO2nOhOQz5zyv2bwoLmtxESYNXkzvTsKOoIbCoQHSl1geW+TJvU4bSXoX6ox9ZWaQDlzG3R9kQXrPpjm4SkJFGQKdNWZzHhyiiQrVFKSz4NsZhvGfPNIMSyE06aRnrDt16jz6CvSeqdEehaQhZjC1E46JtqiiG3Nva7WifIGncAbws+O+krRG+EjxQm1zt12DxMTDS7TOn+Kq43gQZyaStLijne7yi4GcnMDa0JAtBfe/ttq2sNwjFaPoqkMpMs2TXI+0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LSHsqaCDUUbyh32Sr6ThP2PMMWwfZW0UZbmKiNqiD2M=;
 b=jskjPfG5YFBdSODLK2fEHxyx91F5OTuarrQgTeEzdQNd6KClJsNgho74FWYTChzMcvnxnM9YC45QkCaTdcZpLcDSudQY5Ko1l39CEITmYk8OfV5ZSExXlnQTvO89QN7cFzWx8Smd9z75Ec29RqaZN158U6nYiWmEyjGITzJLxC7LQrEd9CeLchTrsHFNQ/dwE4z1JI27qZIyS9PoIy6vIm7rfxMWmG1LO/QfqRFxJXg6/WVlOIj9py5FuAZJRR519LxfZntfidaHPXtT7xu/lLdlzq8FNma29WQWXgauMixdOv4HTdJuUrzbkHo25kD+v9LMRsFJrCZAmzGso6rASA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB7989.namprd11.prod.outlook.com (2603:10b6:510:258::13)
 by CY8PR11MB7363.namprd11.prod.outlook.com (2603:10b6:930:86::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Fri, 31 Oct
 2025 20:04:58 +0000
Received: from PH8PR11MB7989.namprd11.prod.outlook.com
 ([fe80::752b:acc8:a52:38ba]) by PH8PR11MB7989.namprd11.prod.outlook.com
 ([fe80::752b:acc8:a52:38ba%7]) with mapi id 15.20.9275.013; Fri, 31 Oct 2025
 20:04:58 +0000
Message-ID: <c061a802-3ba4-4d4e-bff3-1a3465c64163@intel.com>
Date: Fri, 31 Oct 2025 13:04:55 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 9/9] x86/cpu: Enable LASS by default during CPU
 initialization
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
 <20251029210310.1155449-10-sohil.mehta@intel.com>
 <50a8d23c-8c91-467c-9ee4-5894dc31d2f7@intel.com>
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <50a8d23c-8c91-467c-9ee4-5894dc31d2f7@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0106.namprd03.prod.outlook.com
 (2603:10b6:a03:333::21) To PH8PR11MB7989.namprd11.prod.outlook.com
 (2603:10b6:510:258::13)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB7989:EE_|CY8PR11MB7363:EE_
X-MS-Office365-Filtering-Correlation-Id: a68f9918-5e62-4696-a185-08de18b8c472
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VWRBSm02TFo1Yk1VZG1PRTg5SnZwSE5aWTQxTjdxcWplaGRud3FZRkM2UmFI?=
 =?utf-8?B?SlZHR2xyVXl6Yng5anB0ZU5yV2E0TGEwWGJmVHlUcVJDMVVlbDF0MnFycExN?=
 =?utf-8?B?MzRNZXRETnI2aUs1Zkk3M2FwSEV0NDUyZ2swNmlwNWJ6K1pTdzgxdzF3OUtj?=
 =?utf-8?B?MFdNUWcvVmhpQTZ6NlFmV01GVy92WXNJRVJhR3NlSkphUXUwT0JMZnJDTUtG?=
 =?utf-8?B?MEpFUW11SzU4TlFnRWNTRVVpQkhsSGxqaWYwOWsxQWw4anRQZDFUcE9KTk5z?=
 =?utf-8?B?QUZSUVBGdllra0NIYkhXekNBQ2EwTWJwMHVwMnVFMiswZHcxQ3RzeElvZzdx?=
 =?utf-8?B?alhGbzBTNVNSc0ExaHBzckpZVjJTQnpWQWNEZWdJK1BobDdUd04xQnJhTEMv?=
 =?utf-8?B?K1lhcUQzZDl2RExDem5YVC9pbnFIaXNtYVE5czYwQXhTT2lJN3ZpNFdXTk9Y?=
 =?utf-8?B?K0tHZEhjeGRpU3FHU3BaVldYdW9BVy9YeEkrKzdCY3RnazlKV05HNE04cDJN?=
 =?utf-8?B?dlY0Q0hZZjdJNFdZS3V4UlZDUGRjYmtnNkYrQTZreEc2ckdDWXJUR2VWcStr?=
 =?utf-8?B?MFphRFg3N29KTk9VR3krMWU0c0htcFFlVk1TcmVlb3hhaCtCcXpmWVMvaFM5?=
 =?utf-8?B?SVRjLzBQVlhQSWxiRklUS1U2RU9hZ3cwRDU4N3VnNzg2M3pRSXJYMVJjRWJI?=
 =?utf-8?B?SjUxeHRjdDRrRmFkRnFuenhEYXdHRGlXZGE2ejEwVExaVzNxVHdKYW1QOENT?=
 =?utf-8?B?TmxSYmMvenZiN3Z0VllqbHAzdWpPUnUrTDZhUlpmUmVuRzZjSG1XdjViUFlm?=
 =?utf-8?B?QkhKeFMwZFp1cXhsU3J0bmZhWGZPZHQ5TjN6TlA3WGxRRTJ6d1pUR0d5dVF4?=
 =?utf-8?B?bm8yMGNWRjExK053TmttWHZNcXhEaU5HOE9aTVFrVTB6UzRsTlFlMStmQ0J4?=
 =?utf-8?B?akx0MEM5OEExR043cnROL3lXaHFrQjdNQVZkRGUwN2xWTXZRYkV4OW9qc3Za?=
 =?utf-8?B?NWxWbUZBdjJOYnRjQmhxSUVvK0k1Z1hDOG9Ob2YzVkRYMzEvUFFJc2JuaEh0?=
 =?utf-8?B?eTFhRmhhR1JSdHhrZk5yYVJhTzhnOHhDTFQ0RFkvODlFU0t4cWpMK0xQZW01?=
 =?utf-8?B?UlgwSlZOZ1NjUnE3Ui9pK015Q3pHSjBVT1BuREhVU1M1RUxmeXBpUmFSNU9i?=
 =?utf-8?B?RWN2c0ZJUVJVeXBQRFJCRUcrdUNFaUQyeEFjNGRqV0FINHd5bzZRa1BCZW1B?=
 =?utf-8?B?cGt4emxUdmVoMHdsa0tUOXpIMUdKWVRaREpkYW1vTjBYME5QT3lSQnpocXhp?=
 =?utf-8?B?WWtqVThVcDZUUW0xdlVib2UxWWlMWUtPZlVhWUxUOFA5aXMycy85enJTUHRp?=
 =?utf-8?B?MHBWeVIxaWFzZE0rYU12WHhvWDROV2tVWTNjNm1RenRFc09jUERrT0NqYmIw?=
 =?utf-8?B?RksranV6QnZXN3RveG1mTU0vYWkwdDZOZlplUEwzbG82VDFORUE5UFd1RDFt?=
 =?utf-8?B?VjZaWkFhWTlPd2w1WnVUSkFwcWxDSG51VWtXcGJKaHpFSm12S3cvSWtub0Zh?=
 =?utf-8?B?T2YyY0pRV0Vqa1FNc2IwSjk5Y3FReDJzQjNCaXQvRGloRDVuMzIvR2RyUFJC?=
 =?utf-8?B?MjJZOWxjSHhrMi9HdFh2OUlYYTJvMzZYRnRTWlpGU0Z3UVZWVE1hL2dCaWp1?=
 =?utf-8?B?akZhNG5qZjN1Y0VCSW9jQ044SlEvRFg5d0JjeDhIaS9SMGdxZjV1TkxyQlJZ?=
 =?utf-8?B?UmQ5MmpqMkltRS9YWUhsWGdlckl1M0txbXZtNXFCdTJxaVNZTW81VnpsODJ6?=
 =?utf-8?B?SkxoODAvK01iam9HaS9oblJjZ1hqMlBBaE5XRzc2RXBITExUQ3h5N0RpbDM2?=
 =?utf-8?B?OU9UM1MzaGx0NEhHWnRBblJCT2ZqM3hNQm9NZG9BQW1vcXhKWEUrTzJkOUpQ?=
 =?utf-8?Q?RE5UIc2uXBykBh/Chr+uLoS+eRUyfwVg?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB7989.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ci9YZHpSbnFjMDVka0t5WmVPR0FadDhVdnp6ZE9Dc3FCaUx5SmtaZDBjOEJK?=
 =?utf-8?B?YTM3a1pGWGdGQjdnM1VEK21UVkl4L3RyNHdEZXhTaThRaUhndUhYenV5b2FU?=
 =?utf-8?B?ZkVXZzlRdzVRVWJJaXRuaGJBMGZYUUhrbzlNa3JVVnpoeDExczZVMEk5OXZY?=
 =?utf-8?B?R1N2TFlOeTloZFlTNDNUS0JtQmNTdHJiNGVRb1QzRkxESDhyeWtkTk5Sb3F2?=
 =?utf-8?B?RWhHNWNQbzRRNnZpS3gvMXJEd1FJRTV4cHRIVElSVHM2MitKbmZ3MTNPMm9T?=
 =?utf-8?B?L0dtYTE0V1VjYlQwa2llVVlFNzhUc3hYSFNYaUVTRVVYQ3BrcWN3NXkvbDRB?=
 =?utf-8?B?ZXZsZGJ4NzB1bTNNSnJ0R2tvL05DQVlabUNib3RTNDdXVVQxNEVER3VCbTRM?=
 =?utf-8?B?K01zS1BZajQ2MWNwRFA1blVLSlZnU2Z0UkRpZHZIS3MvN3pkemI1dFFPQ0Fp?=
 =?utf-8?B?ZEtRTUprRnZsOGMvaENid3pReXpmdnVsLzJPbzdqYk92NHZzZGEyRDFjOGxl?=
 =?utf-8?B?QXB1a1Voc0RweWIyMjIxQW1WYTdVSmY4Z0xvVUI0ck1mSzJPYW41NW45Mmpp?=
 =?utf-8?B?dTdqVVk1N2dNWVI2YlF3N3VyejEyUG51aU5xRlpjbVRwZ0ttektQbFdVWFFn?=
 =?utf-8?B?YWhpeGNxVmRmSjJjU2ZqVFVrWkJtTHdyOVBRU2dDR002RkU4ZU9EVE42WFRZ?=
 =?utf-8?B?bEtnMlBhcHI5ZmtwM1FsMmI0Q2UvR0Myd2d3TFZqaTdKc2N1TFFHZGdtcjdH?=
 =?utf-8?B?YlRFK1puZnl6bjNDQzRYNWFJRmpOeHpHNkVwRHR3UzN5YmRzdm90c1JLRmVF?=
 =?utf-8?B?a2xjbnZnVXpHZnhTSVVNV0dTaU1ERktiRkJOM1NIS1IrK3lHdHZRK0JlaWRI?=
 =?utf-8?B?dG4wNWs4b2wxWGV5eGthUHpLNXgzWE9VMjJqM3FwMWpMZTc0cVdmRCs5Y0hT?=
 =?utf-8?B?YjRmZDhDbkdZWEl5a244ODRpd1VmUlVmSDd2dlFldlJIWnArSkZiYXFVYTd1?=
 =?utf-8?B?bG8wakRMS2haQjIzaWtBcmdiNitiWFkvQmd5TDVTOEJCNXBveE9kTW56T0JQ?=
 =?utf-8?B?MWlRYTdzSTFFdTFPNG0yZndqVmlrVUxXa0Flb2xRelltNHhXSjVIRXBxbXRN?=
 =?utf-8?B?LytrbWxZU3pVbTY1Tko2N3haNGdVRytXWE9wYVpPbjJRSzd4dmZESnZIc0wx?=
 =?utf-8?B?WEVFV3NpczJVQTBhcm82UEZMT1VVd3dxTUhpK1JIWld5ek0rbkF2UTVjWlZt?=
 =?utf-8?B?Z29aRXg1WVY2c2lQdkhXRjRhYkNCZmVpdnpITDViUDhwOE9SeWdEQnZLcmRU?=
 =?utf-8?B?dTgya2wzOGVkcHo1K0IrRW5MTUw2VksyYlpJRVFVRGtORmVsSVdXeFR1L2U3?=
 =?utf-8?B?VGxvNWZNT0dCWVh1MmtrNE9wRlVFQnpmY0ZXUldwWjJxRDU3ekVtMjhnTE5z?=
 =?utf-8?B?MmVhbkhLcFlzOWhZSzQ1cGMzRVgrVnRkUThmeWc0a2E4S1lZdDhmdjN6TU5w?=
 =?utf-8?B?MlBxOW1yazJINkFGVGM5NFZUQjJ6a0dVR2ZKeG1IckVidFg3MDFwMHA2bE5E?=
 =?utf-8?B?QnBYRlB1aDRWN1JMWXZzWkI5SFd1VTNGcTdaMVZZeTJFWXV1akxBamFwVVNX?=
 =?utf-8?B?OCtTM1FITkFteXM3MjVETHhFK3NpTHdKKzE3UnhkblR0cm5OUU5XTVVyeTA2?=
 =?utf-8?B?d3loT25rWmtWMVpsalFCeTJWNWx1MlhJalpaTU9sTENsd01iRk84eXpHVWdt?=
 =?utf-8?B?OGdZeEEvUGZxZnk5K3FIWDk4Lzd5RTZXZjJVd0k0SnRmejJ3MEVNYktHdWQz?=
 =?utf-8?B?emJGeTUrYTRDUjc0MFNEUDdoN2M4b2tGanhsZGRSZXhEVjl0dHhpVVYrZEJh?=
 =?utf-8?B?UDNOUmhhRTBiYklvcDBKSndmQk1iclNhbVhYcGljVXFLK1dDeXhwWHAveVp6?=
 =?utf-8?B?RWxLOWxpbEdkVTUxWnI1RzZob3FPSkhuNzNOOERJTjVCSUNVdWc2ck9mRDJR?=
 =?utf-8?B?NjdxZW9Qb0VKRG1nOEZCRTBMM081ZEcrYlZFeWVKeFhvZ2sydUFrbHFXQzJV?=
 =?utf-8?B?UkUxSlp5bnJ0cERtUnd2VGFGOGcvcXIyOG44MnR2Y2xydUV2NWp1cWw4RDZL?=
 =?utf-8?Q?5KkyvNFycHaKj7BYw/MDLziUS?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a68f9918-5e62-4696-a185-08de18b8c472
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB7989.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 20:04:58.3861
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NupTPSdcVZhOGNxPi1y1/H0NKvsBOQC01oLoP+0Z9h2JDkj+Rs1l45uNCQENGpEh7TfI1FSmYe9Pc3httxbtNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7363
X-OriginatorOrg: intel.com

On 10/31/2025 10:21 AM, Dave Hansen wrote:

> 
> But I can fix that up when I apply this. I think it's mostly ready.
> 

Thanks a lot for all the reviews. I'll try to get the EFI thing sorted.

If we end up applying this revision, can you please remove the "default"
from the patch title.

Making LASS depend on CONFIG_X86_VSYSCALL_EMULATION makes it off by default.



