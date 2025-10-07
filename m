Return-Path: <linux-efi+bounces-5001-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B060BC2EC3
	for <lists+linux-efi@lfdr.de>; Wed, 08 Oct 2025 01:12:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EFD13C56B9
	for <lists+linux-efi@lfdr.de>; Tue,  7 Oct 2025 23:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D25F253B67;
	Tue,  7 Oct 2025 23:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Lwzt4chW"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2A433E7;
	Tue,  7 Oct 2025 23:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759878722; cv=fail; b=ob0UMuVQt4HStNiQvIxxIyhS1jVbiTxsKJfFGIfyinZT0HWZ0SsqA+jfWRMUcMUEdGC9nrHHPCZDnpJik05g/OLf2iN+xqmGkQvDcCIgVcBBhziu95x94W9N7PLV+dY7OMOc2BsQuIgsaaP6PEE0EWCP2uqmrRlnBA7nhe4VQOA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759878722; c=relaxed/simple;
	bh=ROFGHJgIOPlqURyNrU/AsLGCQsSIoNjsjC4XuuRJdLE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ep/Y26snd6wdNpqJx9tGTEGsx2jdHL+cFTxQQylmzCQDMh5z98OHUa9rlczRrIYMILjSHgiW5mBMM2pvhDDzb34xzioPg6P1KUlJUbmbnYlbqGhMip+D9gZTF2ajqlHdb+Hip7/iFOSiYZ0gLioGDeC0/s7mCohNb1EEbFbgMDc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Lwzt4chW; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759878721; x=1791414721;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ROFGHJgIOPlqURyNrU/AsLGCQsSIoNjsjC4XuuRJdLE=;
  b=Lwzt4chWV5W6Mm+zbspQoj7rbZE0fJEXlQl5stp/re2SOym3ZkoM6G9R
   dAuHzccdtlXs3iFYvJtfhFzXcfq9iFFF8F/csel+tPks27DbhI+mCWiqj
   d49woyB2imiCZ3c0ffebkujGeAEZhyB6YlQrc/kopS5PMihYqhpwetpKu
   oBoRNzj8m+Z1tXUPP6SeYa2E7vkryR7aDql9ykVOxBAdXXotNLJ58Jl2a
   gExJkRg6giH+Eb0CUbJ9QwcFE4b5xBMky6bamp54AVBeZC34pw+wRPKUJ
   WmO6CU9jjt7RJJGcJaXgkRf8WfxxVnqE4CbgesrKiWzd1K1Kx0RNhwd/t
   g==;
X-CSE-ConnectionGUID: yMlVNfGATeud5hXxybHMHg==
X-CSE-MsgGUID: kfOWL5YNQk+jX1BTeXkkRQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11575"; a="72330996"
X-IronPort-AV: E=Sophos;i="6.18,322,1751266800"; 
   d="scan'208";a="72330996"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2025 16:12:00 -0700
X-CSE-ConnectionGUID: sXonN7bLQCeEcypWMC8iMQ==
X-CSE-MsgGUID: RkQ54jKYQxm+e2EGlzR9NQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,322,1751266800"; 
   d="scan'208";a="180715279"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2025 16:11:59 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 7 Oct 2025 16:11:58 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 7 Oct 2025 16:11:58 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.14) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 7 Oct 2025 16:11:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WB/z9uvvpBT/fAz83TEZFs8yIVnPNuose59MPET0zXcR/s+IDwjXL7RAmaOqqf7Ny1T3kcHFaf1emxANZrvHu1IkDr1IGhasF4qS4Sc3JWeJedRdPr7tDQiMRSRvjBg5cmXvBQYWZZBtkUdXjetK7kd3hu9Zp7ilcEjFv1/XJL/o9O/Up+nN+dCOpfe8CqHM+b1ELl2Tz4kQTxiiwt1SMagVm5lFEyM+2duHwqD+7k9K8kdQB/A83wLCD9XshBwnwdIsYZpOWBz5HZ5rleClfpPJv+mQ7eO4HMEVY929OQ1gp42u0XQcOWuTVXnvadb5jC/CuYpz7yDj3xxeb9yLpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MxrSL1qpFRfvB85ItV/DhRmQ2C7mhNOoiEo/RCvjVz4=;
 b=ukRPi5yIdPsLGrotdqUbl957oT0KuiNgqWj4aihsNYrsuOOl+o6tGN10QwJwnVYT8ECT5UKQMvWRSGUWLQ05YUq2QlxFRuTrreLIruO4xikMpn5UGJwVD3ld0wSuhoTO8z8wRmDu5ImP2ojP+BgGcM1d3rX3acZr/5TZJSRFgmaXosuOfFff3f48yC2wykH8Q37BKZ9jDjY0yhByhp5lRvLFC5rslfgUlnU9tD0sQeAwlRKP83OayUBGDoTFN74P5okXbM5otu1EL9OsZj1PhHl0J/fTM6mVwgRd2YU4yKRRhZfhyNU4qb7OZnJVUcoFUuvlootos5/NCEDjcI3UHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7997.namprd11.prod.outlook.com (2603:10b6:8:125::14)
 by CH2PR11MB8833.namprd11.prod.outlook.com (2603:10b6:610:282::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Tue, 7 Oct
 2025 23:11:54 +0000
Received: from DS0PR11MB7997.namprd11.prod.outlook.com
 ([fe80::9105:2b7c:b256:7a6c]) by DS0PR11MB7997.namprd11.prod.outlook.com
 ([fe80::9105:2b7c:b256:7a6c%7]) with mapi id 15.20.9182.017; Tue, 7 Oct 2025
 23:11:54 +0000
Message-ID: <7635c45d-97b3-4773-95db-e61ad872ce22@intel.com>
Date: Tue, 7 Oct 2025 16:11:51 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 04/15] x86/cpu: Set LASS CR4 bit as pinning sensitive
Content-Language: en-US
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de"
	<bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
CC: "corbet@lwn.net" <corbet@lwn.net>, "ardb@kernel.org" <ardb@kernel.org>,
	"david.laight.linux@gmail.com" <david.laight.linux@gmail.com>,
	"luto@kernel.org" <luto@kernel.org>, "jpoimboe@kernel.org"
	<jpoimboe@kernel.org>, "andrew.cooper3@citrix.com"
	<andrew.cooper3@citrix.com>, "Luck, Tony" <tony.luck@intel.com>,
	"alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
	"kas@kernel.org" <kas@kernel.org>, "seanjc@google.com" <seanjc@google.com>,
	"rdunlap@infradead.org" <rdunlap@infradead.org>, "dwmw@amazon.co.uk"
	<dwmw@amazon.co.uk>, "vegard.nossum@oracle.com" <vegard.nossum@oracle.com>,
	"xin@zytor.com" <xin@zytor.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "kees@kernel.org" <kees@kernel.org>,
	"hpa@zytor.com" <hpa@zytor.com>, "peterz@infradead.org"
	<peterz@infradead.org>, "linux-efi@vger.kernel.org"
	<linux-efi@vger.kernel.org>, "geert@linux-m68k.org" <geert@linux-m68k.org>
References: <20251007065119.148605-1-sohil.mehta@intel.com>
 <20251007065119.148605-5-sohil.mehta@intel.com>
 <e873d2b06a18b69e246f8011c556259d21c7e022.camel@intel.com>
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <e873d2b06a18b69e246f8011c556259d21c7e022.camel@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0P220CA0008.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::17) To DS0PR11MB7997.namprd11.prod.outlook.com
 (2603:10b6:8:125::14)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7997:EE_|CH2PR11MB8833:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b19d05f-6f35-40ca-f03d-08de05f6e7c7
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?c3VnNEFXaHlpQUZKQ3NmWkRtcHhGazJRN1dsb1VjdDJMbmZkcmdiSkNEczlv?=
 =?utf-8?B?RmFLV2t6V0JzLzhpR09WNi9FZG9KK3RkWjBRTkVvV29FZVE1bWNQbG9OeHFJ?=
 =?utf-8?B?dG1Hamk1bGx0SUxzN0VUdmpGa1J5cUlOekxEbmJUQ2MzY3B4QTZud2RwMmtY?=
 =?utf-8?B?dlhhVWVURUNSTEhjOHgremxXaVVGdWUxbWtQQmxRbHFTVWVpWTNZNVFsRE1p?=
 =?utf-8?B?K1hlVjVwZHBZTmdKRlNDY0hFMnZzR05qQnZEK0xSRjBnL2pRZUxKMkdCMzhU?=
 =?utf-8?B?QXB1dGxoWFhxZFQ1dTVQVEVpTmtSdmh2QXRJZEJaSnNpWStnRUVVRDlQNUlM?=
 =?utf-8?B?ZkVtUGY1WHhJaHpic1JZRVhaOFVLYm5YOGxQd1FTZ2swS0srSU9VRmV4TytL?=
 =?utf-8?B?ak9UaVUvRWlqMkdWZWJ4d1QvL3N1QUZ6c0Y5NklWTVIwZUlQVlNhbVdTbGI4?=
 =?utf-8?B?akVwcitnNE52a1pkNWYwTUlHR2ZzZE5QV2hoTk5XWEl3dWgxTTZ6dnpHMlNE?=
 =?utf-8?B?VUIvNGdqNHgrTE9nV0dIVWQwamMrQ1FWSHpHdC95NzdRRlI0Z24wTDNzZVAv?=
 =?utf-8?B?TnRScDZoOEJ3S3hjWHpXREYvWXZtMkdWY2FQNUZHSlR0clRjYTQ2dlVFUzMr?=
 =?utf-8?B?cll3TkJTa3JBaTVRemZNWjBGZktSSTZVWnJhczZjMnAxN2VETXpMODhlRGRn?=
 =?utf-8?B?ZkNSbk1KYXhSY2RMczhpcjJZVkV1aDNzdTBhTnJTTTg0bjQvbzNReEtISEFX?=
 =?utf-8?B?WjM4RHVPd2JEbHRLSkNlWkRYMkRxd1ZuWHZOR21lWnZKYjN6clF2T2J1VVE1?=
 =?utf-8?B?SU9qblhEUDJ5Zmhob0YySnNxdUxxQUVwREc5dEtHdHd3VlJtNGluZTIzTDV5?=
 =?utf-8?B?QXljWTRldlR5V2o1Zm5rUFBxZnYzV2UwNkMyTm1scjhrZGxvYStvZmtQRFhM?=
 =?utf-8?B?S2c2NmtXSFlnV0VJNjZucmRyMDNERjFtR2VpZlZMWnZYeGRmSS9GZzl6am1r?=
 =?utf-8?B?NmYvZk9LQnB1V3k1WlFwempBMTBwbTBjMXF4SFQvK0I3ejcvWTlVSzhibjZM?=
 =?utf-8?B?dHJuQjNweUZPamk0ZTZIZnhOUVlON3FGdXdRYjI0ZXcxV0pSQ1ZteWFhL2c1?=
 =?utf-8?B?ZDIyUndWa004MTVVdkF4SzBCTnZibXJLcHp5VUdjLzQyYlcyc1VUVDNHZytX?=
 =?utf-8?B?S3VBbmVNQm1mTDU3Um9WTDREemw4K3hNOERXQ24yVEppNThGWW5GT2pFdjZo?=
 =?utf-8?B?YnY1Y1d0WnRZSVFtYnJOYm01SEVLQVFiNlkzNHRCWlg5REQwR3pvZHhiMVcv?=
 =?utf-8?B?c3RlUXBOMDc4eitjWjJUZE5GS2dZNVEvejlEVDB6d1J2UFkvWkhKelBERkhF?=
 =?utf-8?B?b0VZUzNRRkxhd2hFYVRDUVVlTjV4RXo5eTJoOTYrUEFmOGVTY2YvdWVtMS83?=
 =?utf-8?B?OUp4aEJtaUNoZGVOb0QvbENLQXh5OEFZU2R6Y1g5V3pud1B6R252b0pzQ3NG?=
 =?utf-8?B?WXQ3TFN5SzBmdEVoNjFocGd0SVNibWZOSUxmb3A3d083eHFMRStTc0J2aEpP?=
 =?utf-8?B?UDJ2ai9iblZxMTRhcy9qS1p2cWxuQ0hEMS84OFVCN3A0Q1NtWnFSNGsrWU1B?=
 =?utf-8?B?bmNHdVp4VDMrSzkwbkUvV1ZDR2NnanJMTmFMYnZwUHFRTm5pS3gvUTNWRkpE?=
 =?utf-8?B?L3BKWWlTU2tTYUwwSmZ3OVJERjFMR09KUmhpZFpoeWxQOG0ySVFYYWxQZ1hI?=
 =?utf-8?B?eFB1TkE4RC9XNEl5bHZWZU0zT1EzSVJFUDVjME1aL3VNNlZZcVZ3eTZGNWpQ?=
 =?utf-8?B?S2NhSElKQnpBZDRrS2o4UmFFb2N0Yjd3VGk0bTFGRERwck5ISmhjaDFDRE5V?=
 =?utf-8?B?ZHE5VlpuaWdGczlrNEdpV0dIYmNSVVZzQWlncTF6cmhCeFUvNkRua1kzcjI2?=
 =?utf-8?B?RlBHRThpVmNhVjBkL1BzMEZjOXg4ZmFxMm5xWnRNTGQ5Ny9OeGFnK0o5ejI2?=
 =?utf-8?B?WWVPb3R2VDdRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7997.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VXNUZS9FdXE4MzFCUWV0ZW1sSXhsTXI3d0pJay95cDl3OWZrS2NLNFEwSkpp?=
 =?utf-8?B?RlNHcjZLbkJKVGFtOFQ4Q2tyblZJU3phSVQvMjJ6aS9GT0xvMFRUTEZqZXRM?=
 =?utf-8?B?cDd6MFU3aXZhczhrU3dTRmxVVEJWVVRjR01PcWxpSU5oTzJrcS9tdDRIR1Fp?=
 =?utf-8?B?dWYvSGVsUzE0M1hqZVRiMktmTDRkZW0xS05jU21OVkE4U2xocEFGVWRIRGFv?=
 =?utf-8?B?WjM0OEVIaWRKTDhYMEhpWFJwdzBlY0E0UDBlNCtiM0ZoYitwSzJ0clNwU2dU?=
 =?utf-8?B?OThBcDBJTG96UjdCUEFUb3lGOVpXTms0TlFlUGlSTWhJTklSejVPbWZaMCsr?=
 =?utf-8?B?ZHBXNlRicDQ3d3hXcE1pcXBWa0VIRUlUaUpRdTg2emlhdngzbkxSOGo3N3lJ?=
 =?utf-8?B?bGt6ay9HaFRmS3Zha0tWcTArMWsweUxMS0VKYXl4Z093WVBFRGhSSmZzQU9W?=
 =?utf-8?B?d1BTU2NZenhnUGVIVzhtMEFvSGZTY0cxMnhqS1JseEtmOWhGOU9WRVNmbW83?=
 =?utf-8?B?TEplcnoxMUlXK3QyTlF1RU5PeUFENERoSTRWcGJpaHFsbXZyVnd0R0pnYit4?=
 =?utf-8?B?M1hyOEtuR3BycExjY2JsZ3d4M3hRK0szSXJPclE0Rm5DczVldU4zbE5HOHE2?=
 =?utf-8?B?cHlUTEpqRDFRUWFJYlUzd2ZMQXhKT1VyM00xc3F1MSt6TWlhK3pRTUM1SFg4?=
 =?utf-8?B?TjhlTDl2blU0RkhHVDE2ZFQ5eUs2aVc0QWN5dmh4UW44ZGFwR2VKVWtNU0xx?=
 =?utf-8?B?dFRET09sWGRJajBpNzg2bUpjUG5WK1M0NVZLSFJUaHN3bEpqM2J3VTliZ3o1?=
 =?utf-8?B?ZmorTEFCMG5CeWdmN3hwbEYwcVROdlA5QzVZWVpxbWR3ZmRRc0VzRFBkSi9G?=
 =?utf-8?B?VG50akkwTVFuVjdVZEt2dTYyY2pPZ3ZsVTUzMFpGWWFRMm1vWkxDWHU3clEy?=
 =?utf-8?B?UmpqeFdWQVpTWnlmcXFYMjBGQit6b2dnL0YxNW4zUHNVREFLTkVhUklPYldw?=
 =?utf-8?B?VkJEMnRZS2kyaVNoNkJIQ09wbWdVd2hFbDl0MlBhQ0ptQnh1aWFGbjFBQVl5?=
 =?utf-8?B?ZXNnSDZrSGpaTFZHOWthZXZTVWQ2UFJHcnlvOFVTRDU2SU5IM3pGekFycGlh?=
 =?utf-8?B?QnU1MmQvcFlZR014dHlDajNIN1huaTZlZ2FnRE5tb000VTJkajVwSkN2ZzhF?=
 =?utf-8?B?OTN4TGxNZE5LeWR2Qnd2VFIycGpvTGlnTmdMWWJzbGxOVGcxdmNHZVgzdGYr?=
 =?utf-8?B?TTIrWUVOMUpPdDNPS0N1bmJwQTh4Y1N5SU1CMEhrL2YvOTdVdGdWSVIrZHFz?=
 =?utf-8?B?L2pZTS9TNldKUjVrYmJrR2RGQllKSGNPYnA4dEptb00yUEJCeDJwem9PMnhU?=
 =?utf-8?B?bGM3Sjd5RFhwMWdqWGc1QWQ1OHFYODByRkcxNzBSUXFvRDdPSEdLc3hxeUFM?=
 =?utf-8?B?WERVK0J4ZEFIMDM4MmJ3cTdyVkxrZit0Y0tHcnFweDliZnZiQ28yREtVaFQ4?=
 =?utf-8?B?djhFNTJnNWdIVkNlY1l1MHRUVUkxei95Q2pydjA0Y09zeUcxVzZXTjM0V1JC?=
 =?utf-8?B?K2dVY1p4R2lFaVZFblRrNFpSRjBmRWp3NTVGajZWblBSNDJPY0NkMzJCQnEr?=
 =?utf-8?B?d3NlN3ZCY0lvRDVlTnBKNGZqSmJicllIV3N3SDR1TUgrNUpoSTBFaUNINGpj?=
 =?utf-8?B?VW1ZYlF5N2x5TXIzTmdkNFZrSytyTHh6ckI5c1oyV2tWR2dUSXZseHZFMDRn?=
 =?utf-8?B?YVpjVVpEZk1FVnFreHRXTVNib0FJbE1jYzVhdkxOOEU5dkR1RzBQbjB5UkZz?=
 =?utf-8?B?YnlRc1c3UkdHUTdKbndxQlFvWGg3MEdDeWVjbXk5cGlIQ3h0MlVEMk9UYkhr?=
 =?utf-8?B?ZGZjSDBHK2lGSXdPdlZhWkpaZnRkbWY0T21FODgyN21kcnR4OFkybWVTNWhr?=
 =?utf-8?B?d2dZYTBCS21yMDBLd3dKZ0l6VEVHcnBuSGt5UmlBa1pFd0cwMmxodmloNVEv?=
 =?utf-8?B?L3pwYlpEVkxWSGpGOEtSS1l2NjRoakVrUkUyaHRjdkFNYTBxbHpOMGlXSkps?=
 =?utf-8?B?anUrRDRmZTBmTGMyeW9zSmYwTFUzakNRNDVkQ3VsS0ZQcmtHeWFOQ1BYTC9O?=
 =?utf-8?Q?F+sE+JzqE0wHuzWJeQ40mwjGH?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b19d05f-6f35-40ca-f03d-08de05f6e7c7
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7997.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2025 23:11:54.3312
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ttk2eOiz1Gr6GSTVWgAMJQBHuRXzRZXxouUQhTbyV1+sthHNiE385uqMltTrg5achtN/ahhkE8VpWMujYF//9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR11MB8833
X-OriginatorOrg: intel.com

On 10/7/2025 11:24 AM, Edgecombe, Rick P wrote:
>> Security features such as LASS are not expected to be disabled once
>> initialized. Add LASS to the CR4 pinned mask.
>>
> 
> I was debating whether we really need this, given the LASS and CR pinning threat
> models. CR pinning seems to be about after an attacker has already hijacked a
> control flow and is looking to escalate it into more control.

Can you please explain more? How is LASS different from SMAP and SMEP
for which the CR pinning code was initially added?

> We could maybe get
> away with dropping this and the following patch. But it would still be good to
> get a warning if it gets turned off inadvertently I think. It might be worth
> adding justification like that to the log.

My understanding from the previous discussions was that CR pinning
deferral might be beneficial independent of LASS.
https://lore.kernel.org/lkml/c59aa7ac-62a6-45ec-b626-de518b25f7d9@intel.com/

The pinning enforcement provides the warning and reprograms the bit.
Maybe, I've misunderstood your comment.


