Return-Path: <linux-efi+bounces-6219-lists+linux-efi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-efi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cJH9CvfxnWk+SwQAu9opvQ
	(envelope-from <linux-efi+bounces-6219-lists+linux-efi=lfdr.de@vger.kernel.org>)
	for <lists+linux-efi@lfdr.de>; Tue, 24 Feb 2026 19:46:15 +0100
X-Original-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 859DC18B8C7
	for <lists+linux-efi@lfdr.de>; Tue, 24 Feb 2026 19:46:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1CF3F304EA83
	for <lists+linux-efi@lfdr.de>; Tue, 24 Feb 2026 18:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A52671D5170;
	Tue, 24 Feb 2026 18:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n0IzPzq3"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74CCDF9E8;
	Tue, 24 Feb 2026 18:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771958767; cv=fail; b=DyXIz3jhsJACuFnMc0MiCxpwizLYgtOPx6j1yT8S1ykosAbrLPriCAt0DVFu8ylk15dePyz7v7+ihYyGifOZvt2NCWk17wHfqAijCkL5GVYfWR+HRGSiDmtJ8c3vfa6T9pRmMZeeWCWTZaICO6qbjWnckATyLLXEy8IYS5BGviw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771958767; c=relaxed/simple;
	bh=egIJOCzzstqwd6pQ+yeNUl5F7vzrHBMmlgqojs0FlEM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ASgAPnWNhbb3Yg+8EMfGIy/14dJ3eZ0E/zEGzqw88VR+3UcMVLOksDTKoo56hRjxzz5O7Zkg0HkfJt/jwjIpgSqsYWtpCHE4EVWtbpmgJGsvhFxshx0/LqX58kKAPrlp7tVogRjIoeq0h/2zOuNNXapaqkOA0hkyqA4kplkTRDE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n0IzPzq3; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771958767; x=1803494767;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=egIJOCzzstqwd6pQ+yeNUl5F7vzrHBMmlgqojs0FlEM=;
  b=n0IzPzq3xKLAs98VLGDK2kXQWt4QfaCKM/PuwQHGQl23in26kKCKiwWD
   MUK4FlDqEtAnWLf7CCD5ogjSglB0c2G7TzhZb4JZuSVckJTYSxWmvK0pp
   qW4QrCvX0DC4D+OCdclYfvi5cmiqpzy/wanee+lYnceG2bD6Tk9SHX0ro
   H9eP0Hpf+hqcEzK8gIjp14Sa8veRCguVnnyAJCriChPV7Zl4LBnMJmsYY
   A+9N5oHVjnzaIbFxSgT6S2u4dKudlQb0o5XKIFfr6qHNUq4w9fhYaUM/B
   2df1zjOPzQ9hOtXPyuK4uuI08iujbe3T+piuMTHLWIvo3yN92UkwyB5mz
   g==;
X-CSE-ConnectionGUID: iWg/AXY5TPKPI2K7i1DB1g==
X-CSE-MsgGUID: 49s+8eg2Qx+osJRBHlwKKg==
X-IronPort-AV: E=McAfee;i="6800,10657,11711"; a="76594747"
X-IronPort-AV: E=Sophos;i="6.21,309,1763452800"; 
   d="scan'208";a="76594747"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2026 10:46:06 -0800
X-CSE-ConnectionGUID: KjUjryBjTUWu5aoFPjtg5Q==
X-CSE-MsgGUID: ByVTd2iCTAi9ce9+IUx6BQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,309,1763452800"; 
   d="scan'208";a="214194451"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2026 10:46:06 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 24 Feb 2026 10:46:05 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Tue, 24 Feb 2026 10:46:05 -0800
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.24) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 24 Feb 2026 10:46:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M/ppS0V5wQx9UqVrDwuuI6wmDfHw0ETu3hZkAWSDpoQw6mHoVp/kw3v9lXUAAmB++ZXODFFkyMOLS3r7qydiLTY9/HRmFGc5w8O+BST/Qe21PRhQCQ2zF6DhgG/PufcwQUgk7E2IKsCelkJ+ljBCNJP4SEA8KdS7PWHgwi8HRDqxgyp42hdfgmEmQvHwet/Y4CKEkOLuRN7ynt+kOfeYe7TfUoNZkBDPOpRmMwc6utKCPyq7wbIWsMCm74c0EzGC2CI/DjVqSaxosWzhgofv6RP1pbe6qahA9BPjHTHvzMQkZSGoL9YkiQgZXltBuUPONrVbQqKmxpVz4p87oEUdNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gImrXv2D/sh5Gwj4eeZc4vSLwmQY6d6j0Kbn11SUnaI=;
 b=Y1ijwc4c0s+S1J4MeitabnrXjh4j21ToSYCMQG6hQsxIOWY+opKb7Jf6pC7EkTIZUC6QJx7ym2aGHP/0wR75RiqpUXETLb/mC8KiSlDquuMDDp9HERp1XIHFplWyAIuobvE45Q1m6cpjBwGPwEAxc44jqlY8FMx2BresjTAEIr10iLgUarBl9ac8pBr2f0/5MouHq2CetDrWruElAfpecxODR9e8Qqfn9Z90FAjisrl/7eN2mSI4CFDnpcdR2nRiLxnlTuQB6yy6uv/HQGJtohVUjOOg+v5vrFqNKxhKNQPAnpJfphEYe5KhbcXrrZM1pNJj1mGMUBM1yv3sSW5kNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7997.namprd11.prod.outlook.com (2603:10b6:8:125::14)
 by CY8PR11MB7825.namprd11.prod.outlook.com (2603:10b6:930:71::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Tue, 24 Feb
 2026 18:45:57 +0000
Received: from DS0PR11MB7997.namprd11.prod.outlook.com
 ([fe80::24fa:827f:6c5b:6246]) by DS0PR11MB7997.namprd11.prod.outlook.com
 ([fe80::24fa:827f:6c5b:6246%4]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 18:45:57 +0000
Message-ID: <b476c206-08f0-4582-a924-2164ba6ae84b@intel.com>
Date: Tue, 24 Feb 2026 10:45:54 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] x86: Extend LASS support to EFI configurations
To: <x86@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, "Thomas
 Gleixner" <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "Borislav
 Petkov" <bp@alien8.de>, Ard Biesheuvel <ardb@kernel.org>
CC: "H . Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, "Kirill A . Shutemov"
	<kas@kernel.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>, Andrew Cooper
	<andrew.cooper3@citrix.com>, Tony Luck <tony.luck@intel.com>, "Alexander
 Shishkin" <alexander.shishkin@linux.intel.com>,
	<linux-kernel@vger.kernel.org>, <linux-efi@vger.kernel.org>, "Maciej
 Wieczor-Retman" <m.wieczorretman@pm.me>
References: <20260120234730.2215498-1-sohil.mehta@intel.com>
Content-Language: en-US
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20260120234730.2215498-1-sohil.mehta@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR06CA0027.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::40) To DS0PR11MB7997.namprd11.prod.outlook.com
 (2603:10b6:8:125::14)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7997:EE_|CY8PR11MB7825:EE_
X-MS-Office365-Filtering-Correlation-Id: ecfdd1aa-bcca-4346-1767-08de73d4f2b8
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SjlVUEhJYm9RVlZ2QVI5clBGdXhkZVJKVXg2VGluNkQvbHRHMTZYLy9TZnFS?=
 =?utf-8?B?ZVFNV3lpZFlUWHVkanRlWHhyaDVXMzRNVHA4V3RveTdTTGNYZm00aHQ5c1Fx?=
 =?utf-8?B?RTZFdUQvaUJjWHQyRXF6S1dlVkZyWFdZSmMwdVpvaVVsbFBNc0hHLzZ1NGNI?=
 =?utf-8?B?b2p3TTMrdzJYN1N4Zm8vS0RnN1E4SFpkNm8rK3dFYkhVdmx0Z1lMQWRDQ2wz?=
 =?utf-8?B?WEFiM25OMXBkYXEydGpsQVliRkJRa2IxS1M4SUpvRGpjSUZOcjFoa29RN005?=
 =?utf-8?B?azNnVVA4eko0Qys0aVhjU29BYTNhcDZWUElhdzg3MGl2ekRVRk5UdVFSUmcz?=
 =?utf-8?B?bzFMTmJOb21ONm1LdERrVm9WWlRsSmIzcmlNNzFsNHBNTDlpbmRwcjRJQUFV?=
 =?utf-8?B?WXhwM0NzK3ZQYkpoS0FVandiUDlZUVQxQ0RacmNob0ZYdFFtRU1jbDMwYlVS?=
 =?utf-8?B?TXN4Wlc5aklYbGlJY1FqcTRYMU5SSjR0dnEwM1VGa01qVkhlWGVINWtCNXBO?=
 =?utf-8?B?Nlk2cnMxYW45R3NrZ0VJVjZGQzJSYmwvdUxsMWdEUXhJV2NWaitNQ1puUUNE?=
 =?utf-8?B?aXRMcUFiY09ZbFFiWTZwQ2M2aXBEVWhYdkRydUtvejY3WG1adUdzcW1rQVBo?=
 =?utf-8?B?WnlLWUdsNWR1VmRjM1FRK0xSTFgxWitGQTNaK3hzallWOVNiUk16YU9xaXpZ?=
 =?utf-8?B?Wmd5bjRSNXc4ZTZSRXBTUk9PRnlmY1ZIOE1RVXJsL09qVkxvRDZOUnJJTnpZ?=
 =?utf-8?B?Q3paZzRZQmhoNzVIOG9KcE5qTU9sWUwyUVU5Z1g2cnhVZE80a0VyRUloMi9y?=
 =?utf-8?B?OFBZVWxhS0x4dVRmSW5oWEtnQk1jY1ZON1ZNcDZldzljaHZzRmV3TDdoT2V4?=
 =?utf-8?B?aXdBMnhFdzJnMU1qdkNvZGZhajJJcE44Wjc4TFJ0RHNTQy9PcktwS3lMQzA0?=
 =?utf-8?B?b0tQTnY1bkoxVkJtYS9jc1JmdlkwQVpJVk1iUU5YYU8vRWxzams3Tk84SUlM?=
 =?utf-8?B?TW1xeHpHeHVOYVdOdy96ZmtEUHh3d3g3MVBLeVlhSnQ2ZUxaWTdDUmlHK2Jx?=
 =?utf-8?B?NnU4SDlSOXlpNWRia2NwY1pDU3Q4b1d6WU1UR2xOMnFKZkRaTEV3c20zd0FW?=
 =?utf-8?B?eTJJcUZMcDNodlg5RWhSL3I4SlB4OEJiRGtNSXVWYlZ4OWxCeHd1U0tBb2ht?=
 =?utf-8?B?aU1hL1ZScTBUZEhQcy9hZ3pqd09OOTlJZkcvMWtRVFZ4RlgzaithM1JwWFFx?=
 =?utf-8?B?cjN4dEZGMk5pb3Myc0x5NWVRRGp5bW1CNU5NUHc2TUdJUzJVVWxZN2M2TVQw?=
 =?utf-8?B?VTFYKzgyaEkrMThnUTVENmJlN0dDQUN1WHpuUXJUcXFpdEFLTjRjazZSZWZx?=
 =?utf-8?B?dWFEdTZxZHQzZXhnb0tRK245ZklzOHRkdXhJL3JHSnczRFRPLzdCNWpXdW4r?=
 =?utf-8?B?djMwc1kwaEZGNVhFSVZlOUV5UEZGU21kVGZFRnZlUTcxREc3M01FSzBpUEpw?=
 =?utf-8?B?a3FHV3IrdEJoeDMzVTl0OXNFZGZic1k1eHNlSUhGSkZ1RWE1RGYvd0NFK09Q?=
 =?utf-8?B?VW9UZEFMWUViSGxyYmEzZTl3WEloUk9pdlc5QnFiTGkwYmZ1SFk0TmxnaTNp?=
 =?utf-8?B?VUFsazZydFBEYmlBTFdRcUpnV0xTVDBOSE5wYmk5eWdjNFdpQUp3UGtjcDQz?=
 =?utf-8?B?alhoVFV4T0RPN0pGamsvQU80SHhZQVZnZVAwb0M2d1Y2RTk2TW9KaE9venlF?=
 =?utf-8?B?NlVOcFhLb044cFlvcURoRVpZNjdmMTliWEZIZ2RGdGZEcE9NNnhqV28zb0N5?=
 =?utf-8?B?eUJTQ0JLYm03N0U0V2ZSMmdnWG1CMnlLSE4rb011U0ZiSWhyYlZwZi90cHVM?=
 =?utf-8?B?eW1iVVAzYXJEUmt2V2sxeVZFNjlHNENTT1NLbk5IRkNvdGx1aEZ6S1BLQWFU?=
 =?utf-8?B?RGJMbjA1VHRnQUs5WTlZL1Vsb2VlOVZjVlJJSWV0UlJiZlh2c0VxK3dQUmRB?=
 =?utf-8?B?QmovOEhGLzRCSEJ0QTdJVjFOK2lzakgrTXppWUVrU2Vodnh1UkVubXo0ZndR?=
 =?utf-8?B?emtaalhyZ0h1amJJWVQ0c3BFV0w1ZTR1eS9pby9lMWZHN0M4d3dEK2UxRzY2?=
 =?utf-8?Q?MMyI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7997.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Qlp0bHhWc0hsSGk1THB0VnVwRXphZTVBdXZZOGh1UkxRWU83Tmc5UEUxNHFv?=
 =?utf-8?B?UzJGb0J0Ly9ZQ2EzbDJzbWhsTnI0bENvSkNXWTlmN1ZSZ2lLcHU1SmtyTGd4?=
 =?utf-8?B?T09xcEVRc0VveSsvcmQ3U2prNTNnNTVLdGkyQ3d6cG14TERpdjczOXl6Zk1D?=
 =?utf-8?B?ekpBSDkycWpOaWkyWGlwS1h6UzlaeHNWSThrRUZpNUhuZkxZWWRsaEllT3Zr?=
 =?utf-8?B?Rnh1UE54REtlQnFvZXNyWjNpdGQyTUE1QUU0WEdBTFQ1b21PS0F5aE9MRDJC?=
 =?utf-8?B?ZCtFcW1BT1phdnpnek5sWkZRRFhHNEtLSTlzZDcvM0lJSnlxTFk0bm10Mytu?=
 =?utf-8?B?dGtKdm1pZ21WOXpzbUIyV25IOVlVMmRHcXNJY05zdm1NVUNnejVaSDVVVm9n?=
 =?utf-8?B?V0lJL3FkZ1pWSkpVc2UyZWU2bTY2eHgzRzU1SjBCT0RZdWRJaG0vZzQzajNX?=
 =?utf-8?B?d3lDU1B5TmRNUVdLM1dxdFRhYUdvUWRvNE9jRXp1MUhRSzROVU00NzJWU004?=
 =?utf-8?B?bk1sRzlrNVN0S3hsQzBwMUhYUGNVN3UrWlpwcnBBcllET1E5amlLZ0tqRzNG?=
 =?utf-8?B?OEJMZ2x4YW1udE4yYlBiSmZ6Z3lKM3IyTHJpQU5DT2JIYm5kUy9xckE0QWlT?=
 =?utf-8?B?QzN6NW8vZU9TYUcxTlpEZTF2UlMwYlNNaWlhUlBPay9Oc2QrVkhLbGtGY2tP?=
 =?utf-8?B?WDdsMjlHdGpCeEVTVHpEMW81MEFkaXdnb0p0V3pnRTBLdzMxUFhURGxnSTFn?=
 =?utf-8?B?TFBjN0hyTWljc3d0Ymp1OExtWk94L20xSkJkZllobjF5S1ZzNlR1cURCMm5u?=
 =?utf-8?B?NDcvNjdCNHdoNnhhN0FxaGJmMmNkMGdDQ0pUazE4WXdrSzNCbXZuaHNiQXFG?=
 =?utf-8?B?WmYybWJaRXpTNy9mak9WUlc5eXZhMndIQUxMeHVWYk8reW54SFdGUDNCL1JY?=
 =?utf-8?B?VHh1N2hGVmFhalVLeThZKzc1RVBnOExiVnUyWjlnT2ZCZmdabWRIVTVhOTJq?=
 =?utf-8?B?SUdvK3pFK3Vlenp0Mms4RkhLaStQK091MllBQWJUblV6NWdob0YxS243SGxl?=
 =?utf-8?B?Q1lOVDZCRXQ3Y0dZZnlucFZVR1NJSHJwalRXMXRvMkpnbklhdm9ibnEyekVn?=
 =?utf-8?B?VGNqRjlkdi84NkFQcTBpMmM1bGpJTU9LSjcvd09mN1hFc0VJZks1enAzZU41?=
 =?utf-8?B?V29SMC8vVXBsTXhXRWkycmZkSzBxT1J0dTZCekpBS3Bncm9PY1ZtQzRUOWlI?=
 =?utf-8?B?YTI5aG1Lby9nUmdOMGpLemphTWtlVU5jNFdiQThjSkVWZDJ2Sm1xbldUSHh5?=
 =?utf-8?B?aXlrYk5iekV4Tm1ML1VaSzN2TXVtVlFqRHZOOUJDdEttTkNvRlVuLzJjTWxP?=
 =?utf-8?B?bkQwOXRibE1HTnMreGRHeGo4SjEveVdJeVhSWGZNbUxSTnE4Yjl6ZEM2UDZn?=
 =?utf-8?B?WUtEZGdXOTh1V3lGTlBjN1FlOG1mM29VOXg3MlZCQWMwY09BVi9HRTA3NWQx?=
 =?utf-8?B?Z1JuZ2ZIOFNNbmVpU2V4NS9ycTluZkM0Y1lJTWd3Q1VWOVNnem1lejRXTEJr?=
 =?utf-8?B?N2FESHk0TXRCUUlwdEVsallYR0ozZ2Mrekp5Z1ZsWTQxd1dpZXhwU2lULzdZ?=
 =?utf-8?B?ekYza0tNbTRDVU1GY2tzMFB0VE8yWDk3QldKQW8vMHJIUzM5YmZiR0tFZEpl?=
 =?utf-8?B?dHp5L2l4NE9TZ2I5S3VDZzhWR3VkSTZEYjFaOWkxWnh4N3JtVm1rNE40Vjdq?=
 =?utf-8?B?V3hDZVdEaHpwTkZhKzRLekhaUUNKTUp5S0xPKzMrK1dCaWl6NUtvVVJVOUFv?=
 =?utf-8?B?NTV5Sk9MenVNV3BreFdMaWtsa1RLcGpDeklQWlk5TjRERVkvaUk0MWlnVXFu?=
 =?utf-8?B?RCs0QWppZlB5Y0xGSjFEbk9ZUDE0VTVBM29ZSkJBQWtVekNRckJmU0VhQjBt?=
 =?utf-8?B?MHp0OWxwY214VWZoQ1A5VnlVL240MHppRUdHbHBSZjludk9IWDN5UDNTVGdq?=
 =?utf-8?B?RW1XMUtTTHd1S3V6NGh2RENST0FmRFB5KzZCVHZyL2lLM1R4VDlLT1cway9P?=
 =?utf-8?B?Z2NGQVBNSk0yMnBaclhuaTc1Z1lCcmg2cjZxdHltYTNmVzVHbEVUSzRXVUpS?=
 =?utf-8?B?STVMaGZiNC9YZDJGaUFYeTdPQ0tIcldmVk9veDN1OGNoVkVGRnpSL2hQQ2Rk?=
 =?utf-8?B?RXpKUlM2Qm1TKzF2UUZJb21oSFEwK3M3aDdhVW1QczEyeU9GaFBsY0FVTXls?=
 =?utf-8?B?blQ4MEk2dHZlOXBtL0dBanRjVGhCaWtobmVEZzJpUys4dDAzOGpuRzlJdnBn?=
 =?utf-8?B?cnJLS2MwOHJhRExsaUZWQzljVVNZSGZEdTFMa25PTW1NM2EyUzFhQT09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ecfdd1aa-bcca-4346-1767-08de73d4f2b8
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7997.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 18:45:57.7024
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nP7TjcLULiuCXDPeQ9yLx8xRPkUrIQgpvJPuUeGsLJvUgdJDPJt4XIik/rltsu0F86kwy6UKLLEAMYbZhoDaAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7825
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6219-lists,linux-efi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:mid,intel.com:dkim];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sohil.mehta@intel.com,linux-efi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-efi];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 859DC18B8C7
X-Rspamd-Action: no action

Hello x86 Maintainers, Ard,

On 1/20/2026 3:47 PM, Sohil Mehta wrote:
> Solution
> --------
> These patches take LASS out of the path of all EFI boot and runtime
> service interactions by:
> 
>   Patch 1: Deferring LASS enabling until userspace comes up, which
>   ensures EFI has completed switching to virtual mode and all boot
>   services memory has been freed [3]. 
> 
>   Patch 2: Temporarily disabling LASS every time a runtime service is
>   executed after boot. Runtime services execute in a special efi_mm
>   which doesn't have userspace mapped. So, the security implications of
>   disabling LASS are fairly limited [4].
> 

The patches now have tested-by tags from Maciej and Tony. Also, the
patches apply cleanly on v7.0-rc1. I am hoping to get some review
feedback on the patches before resending another version.

Ard, are you okay with patch 2 that disables LASS during EFI runtime calls?

x86 Maintainers, patch 1 introduces a common mechanism to defer
initializing features until userspace is about to come up. In the
future, enabling of features (such as SMAP, SMEP, UMIP) and CR pinning,
SPEC_CTRL MSR can be moved here.

Also, there is a possibility that the freeing of EFI boot services
memory might happen later based on the recent discussion at:
https://lore.kernel.org/lkml/20260223075219.2348035-1-rppt@kernel.org/

Overall, the approach in patch 1 seems useful. The implementation is
based on a combination of late_initcall() and CPU hotplug callbacks.
Thoughts?



