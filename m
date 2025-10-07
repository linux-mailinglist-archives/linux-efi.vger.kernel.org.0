Return-Path: <linux-efi+bounces-5000-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B8BE8BC2EB4
	for <lists+linux-efi@lfdr.de>; Wed, 08 Oct 2025 01:05:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 247B634E364
	for <lists+linux-efi@lfdr.de>; Tue,  7 Oct 2025 23:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FFFD2264B0;
	Tue,  7 Oct 2025 23:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Lp+1JAHp"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7D32C9D;
	Tue,  7 Oct 2025 23:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759878347; cv=fail; b=WwYv2xaDEJq8t7hymw+tyl++QO6G9wM+c65CAYnZusqTlZyTh4psJTYnd5ZWi8CJ3uIG8n5iwFRHEDtbVGSc62yH9APkWuyH6oM2i1zQRJLiAfg14oI4rExEByak/wo/i0EPj/8VS7duinwJxkDEFXlCoCOplBkGkRQ/LAGniqc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759878347; c=relaxed/simple;
	bh=TIFNVRepltEyObviTezCHAx5ng8Kdg2d1a7W1nQ286k=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Zw1cnRkO23G7pvW3y212+ISZ2006psSpGtCvht9Sib3Hb0D587ig/wf23ccFc4vx1Evlqw5VTtpSVehGzmGjz6mJKW88A1edpoJ1GsJYvEIaIewrV0tguxkejKI5v8+Ou4zC0At7bBnHwu7jt3grc5lh9qo9gtU5A4kG/koW1RI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Lp+1JAHp; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759878346; x=1791414346;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=TIFNVRepltEyObviTezCHAx5ng8Kdg2d1a7W1nQ286k=;
  b=Lp+1JAHpRfXuu08wcNe2jup5Kz58EviLL9RPNtD+RLP2pLRzoNv0MoSE
   0Xau20jY/phLyti8UDlJm2ZvVDx8r5vmE6UN8roJJIQPDaOTCXRIDStzg
   lqM3g47EUMOzR/X7WyAVRyvj/GdS/x0fLWmXzuONwY5fVRb8GJhlKp402
   mQrpBoKeBSSEXvpsGrsGIDAFdYJRtaZXZcanuOhm1+faOM/UReNxhnKWt
   gNepEpXFjk6iaPVcxslGn3jeESM5/YojQUQVuDRDIoh+a6eImKhB39F05
   Bz0gHwzpNkIT8CY8gJ38vdbiaIWngNgdxj+MPudwkplS2gUDWyGKIy/NX
   Q==;
X-CSE-ConnectionGUID: NqpCMK6BQ2KYUTTiAm/Onw==
X-CSE-MsgGUID: aHO1K0rJTZCt+svdSxjbAA==
X-IronPort-AV: E=McAfee;i="6800,10657,11575"; a="65919439"
X-IronPort-AV: E=Sophos;i="6.18,322,1751266800"; 
   d="scan'208";a="65919439"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2025 16:05:45 -0700
X-CSE-ConnectionGUID: of97jNzSSgyAFlVQD9roQw==
X-CSE-MsgGUID: p5JtI5KJS6GTSWwS5Hz97g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,322,1751266800"; 
   d="scan'208";a="217388227"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2025 16:05:45 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 7 Oct 2025 16:05:43 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 7 Oct 2025 16:05:43 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.1) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 7 Oct 2025 16:05:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xT/UD+O21pF0+AqbB6nohdds7JIei+KZk+yKuoLUzbtG1P7kjuboW1iitBvXeiClMV5t3Z2De4ylR6z0jNiY+PTX3vR5sCvbf8nyCxuFmKJNLgCMY3eBr7FAiXivKWR2adXaEirV9gIWuTtMb2VkbnoPo6fSFEF2ZQa5HoWLl6RQq4ac+qgqyngouqAzDsGv/w4eBabj4ilbNYjDoi3lZoyWjOCKwk36YvlvlX3xdXQSGKM7jQLyGp+Z2ZrI4dSgTb7w8EW/GbWhOK3nFblTKllrl0XNmhBuvWL6zvXWXEhOsj6C4Az8M2kXl1nD3lFwuQ4b0U54J8luFUxEIwIgBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=19Z0SEE8YiXB4tzHXJ8Xyzl5NtuBI9RJGgMXiDai82s=;
 b=FZ4DXI5tjYWzygo00Pf/K5zv9qgQrOAQyZN6zbx6ykHZX3JOZSvDbhg2EOwTPydcxBPCyy+u/EVK7/gyleTaeaTuH9bX0vgXUUUDtCTSd7+hA16WNJMg2Qh3kZXBgqnk0DdIf7yiNAtwk8OQp8oy78tPMd1HFEKEcxOAIK03ZKD46R3Jkh3dRyliXfj893Tbl+1gYTvfJtfTA2QhwRiOT6hkorV/5yC+LMj7MrIUFoiNKj39nDLjmdb/OJWuX69Rri03y6ZGBiyfqzdTVM5VJ/lspx79CSqqTRrl1nc4tEPkz0F5fhWQrK+Vusrxtl/n3n2kdUJQcKHExPwmjbq8HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7997.namprd11.prod.outlook.com (2603:10b6:8:125::14)
 by CH2PR11MB8833.namprd11.prod.outlook.com (2603:10b6:610:282::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Tue, 7 Oct
 2025 23:05:35 +0000
Received: from DS0PR11MB7997.namprd11.prod.outlook.com
 ([fe80::9105:2b7c:b256:7a6c]) by DS0PR11MB7997.namprd11.prod.outlook.com
 ([fe80::9105:2b7c:b256:7a6c%7]) with mapi id 15.20.9182.017; Tue, 7 Oct 2025
 23:05:35 +0000
Message-ID: <6a71fb30-32f2-4847-b4da-e52b67433ce0@intel.com>
Date: Tue, 7 Oct 2025 16:05:30 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 05/15] x86/cpu: Defer CR pinning enforcement until
 late_initcall()
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
 <20251007065119.148605-6-sohil.mehta@intel.com>
 <171d197d80701224b83e707948ae5e0a33e27b28.camel@intel.com>
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <171d197d80701224b83e707948ae5e0a33e27b28.camel@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0P220CA0005.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::12) To DS0PR11MB7997.namprd11.prod.outlook.com
 (2603:10b6:8:125::14)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7997:EE_|CH2PR11MB8833:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a2674a2-06e7-4c2d-bc49-08de05f605b3
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UFNsVEYxQVhiMkI0VUFoQXVqTXZ0UEV2RTFmM3ppeWRBMmxyTTVwKzlnUjNT?=
 =?utf-8?B?U0NNVkhVQWtLRldRWmFYRGhqMWNxSGw0UlNpS3JaSkJzYVYwQW1QaGRuL2k0?=
 =?utf-8?B?ci9aRDYxc3lBZWgyblc0VG16SnNQS1ljTTNVTWlWOVdncEhLMElpcGVHN2F6?=
 =?utf-8?B?N1EwTjN5WlpiRFo4VXc4QmZqK3BSSlQxRE80dWJqU09GY3RoaGlhQmRNR1Ur?=
 =?utf-8?B?RURBc3JtYzNzeW1VSjYySURveXBZTkhhR2p5RUNNMFVOYWhKZmI2UTR6NU9G?=
 =?utf-8?B?T0xMVTR6WU95d0N0SGNxOTBTOS9tM3Fjc2dQRStWbmlEVDhWdG03VXI2RlFC?=
 =?utf-8?B?NUZmUjN3WTEyRHo0b0pCbTFBSDRxSHYxVGs2cGhPSFY5RkJZNTBreHV6b1FS?=
 =?utf-8?B?UktKUzc4L3NJbFVWbTBmYTNVQXhxemN5VW80amFRSyttMjlMQVc1YzI2UVMz?=
 =?utf-8?B?bGZ1Ykg2alhoWVNpM05YRWovaFNTK2ZsWDB2anJIOURWVWFGenVyam9heXZ4?=
 =?utf-8?B?RERTd2FaWXcvN1BDbFNwS0EvcUovbnVIL3hscUQyZlBXTmdmdWtyZmVKMVRw?=
 =?utf-8?B?VW50V1F6TGVaUWdpVSsyM3JJQnpWcGhmQmo0ZlZRTUZLSlNyT0VGMWpIZ3FC?=
 =?utf-8?B?WCs4YjFocDFmV3kvRmNLTnE1YVhQa2hDR09QN2tYWXZIZ1lLL01vN0VycG9S?=
 =?utf-8?B?ZGlXZitFWEx2dmtNNmN4Q1JGa1ZPRjBVVzZHYlVwTUJIM09LUGlsZCtVL2JJ?=
 =?utf-8?B?aFo5cGpUcXp1WTBMT0xZbWRWYmNLNnZoYklwREFXVnVORWVnT2laOHU2bHI5?=
 =?utf-8?B?M2tyaHNRQ3FtMytHNG5PNnZhMSs2N1VobEZZQ0tRUkdFUHlFNUNJOWY3Qy8x?=
 =?utf-8?B?bFlqaWdqd05vNjN6Rm9oS0RiTVpVRHZ4dk9OZThEdUxTbGFlbW5GN0xJTTVS?=
 =?utf-8?B?OENncU5ncm5oVjRQcEt3MVpsVHFXdGpFQkNLd2FVNG1XSGx5ekdKenVFaW5Y?=
 =?utf-8?B?VnhJazZBazVueHBXOFBsNEpJbzRVSFN3ZGJrS3I5Qkhjbmo2aWdvdloyQjJU?=
 =?utf-8?B?aXU5OWsxcnZHY2MzS0VQR3NDSjVjcGhUQ1lsK0g4TGNUVE9NSEdPanVwWHFQ?=
 =?utf-8?B?Y3dwa2hwdFJVZHVsaTZIeHRsc1AwbmFjU1RtZ1hPSG9teHdqQlRBUWw3K3Y1?=
 =?utf-8?B?Y01tRmR4Mk5rU0svYk9QNFc2alUyQU9vZll3WnpMNHFseG10OFBKQjdKanpy?=
 =?utf-8?B?T2d0amtjOUxDMDA3OHNhQjMzUUR4QUZwYWx3UEY1ZUt0SzZsa0hXdlZUeFhQ?=
 =?utf-8?B?R0EyZ05lUm43STVQY2tUSklNYzkya1lDWTdYalpTTUw2TWVMSWNwNURxY1Rz?=
 =?utf-8?B?Zzk1ZVBXUjdTdDZ5SXVmUm1YRkdnODJCUlNkZDN4M3JvWlFXcnpBeVh4aU9w?=
 =?utf-8?B?eDJwNnY3VStGWVN6QVZ3NEJIc3pjbGlBNUVodDlCYWppYS9QbTdpdFVXM1lT?=
 =?utf-8?B?MFVRT2F3VnJxZi9OeHJqRjZFOVcyczQ3U1Y1MVpGVEVRUU0way9FY2dkT1py?=
 =?utf-8?B?aEJFdkdJajZNMTBtMVFsZnJNNkZUK1hTQzBYRW5jOTkvc1Vib1M3c0hEU0dB?=
 =?utf-8?B?VzNFYTFSblhKMllPSVRRWjRBcmZHS2IrYWg5UUNmRGlkRmlCalg2TW5xTUJq?=
 =?utf-8?B?b2p5di9vbkhGaGY0cEQzYWJ2aDhua1o1TlBZWlJTTXlLTUpuQjNEYkN4QUZB?=
 =?utf-8?B?cUg1MWZROUxLeStHTmlRMzZxcm5Nbk43WkgvcjRvaWNSanh5eW0vbDJVV2E1?=
 =?utf-8?B?SG1iNSswVXU1K1pSOXJ4K3d5Zjd5Z0swUy9YTVVDa2dSTFEzSDYyQ1JGaG9V?=
 =?utf-8?B?YXZiMmFIQW1KQ0FuZHZWWXIxUUZsUnduT3BzdCtnaStmcWczR0ordHdoY2Ev?=
 =?utf-8?Q?CrrwNKvieu2KfwWuGcdB8ko80V1aOdyb?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7997.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bjZsQXpGS2d0MXR3TGN4U3NsVVo2ZDdNUzVXOWdTU3JzTEdzblZENnZENW9K?=
 =?utf-8?B?VUczTGlibUM2WkE2WjBoL21UUFRkM05zMCtDOXkwMFBOWlVwdk02OEUvbWpN?=
 =?utf-8?B?VHAzL2crQ1ZNYzhhVEpkYXNOaXlFaXA0R0NoWGMySWYvZmYycjRONTl0RVdZ?=
 =?utf-8?B?TXpWVUV0Z3FPeTRvcXRMdkJOaEU5dFhDRExoSTlIdWtBeUpwU3lHM200eWVk?=
 =?utf-8?B?ZzBHR1Iyd3QrWURtMGtQOEFvS0UrOWRhYjAvT1luVDk0QWlPbXM0ekpEOVBK?=
 =?utf-8?B?ckxNcitpWVlON2gvRi82SVFBTXVFRVptWHUvbWlvSy8wUEZSMG83MmRyenBj?=
 =?utf-8?B?cExVR3R6TTRYR2hYM1ptdWZlUzJOemllOENrU0IzT3EzTFo1cHBLTE9SZ0E2?=
 =?utf-8?B?bUJXeWRvTkZXNkk4WktmalFxZURnUHBRNk9IT01Nb1RhYy8zZXcxeUdrNEY4?=
 =?utf-8?B?NW1hb0N0eFhESmlHOUtJZXdMdnFJbGV5eUhCazM0aUZDTE5ESTIzUlU5aUZr?=
 =?utf-8?B?UDZqb0lHZkRvZ3NLOEZUYTQxN0l5clplVHpBdm8rWjMvdXBneEtDNzEvK2Mw?=
 =?utf-8?B?MmYyM0ZyR1ZteW4vbUxLVmQzU040UW9OeTg0SFFoRkJlRGpySWx3eEtPdEk4?=
 =?utf-8?B?Q2dYUFozNTZQWmk2alNwRUlzM1pPVlpmRndHQUIyTm9IUklIa1lMSUFoNERv?=
 =?utf-8?B?RThDODZqTzQ3eDFwYmsvMTNmRkZSb2ZrRXJzRk9pbGdtL2UyS0g4QmlScFlQ?=
 =?utf-8?B?bEx4K2NJUzl4SEllSHg4QXZKdjNuTW9wWUVDazdUQXg0UE40L05oL2E5c2w5?=
 =?utf-8?B?d0p6YnBjcHZwc1F0a2M0U1BRVXF2aEgvT1kveGZRNFRhOXBNYXlIK1VkTUxl?=
 =?utf-8?B?UE0wQjl5eEFZaHJiR0ZjZHIyYkJDa2FwRHlScHB3OVJIUTVmNXVRM0FBdWZW?=
 =?utf-8?B?bk5XbWxjNGdHc2E0Y08wZmtqL21IRXdUS1prWjd2YnRPL3l3UDk2NFhGdmdR?=
 =?utf-8?B?d0RZSytEeFhBamZDUzV3TnhoRXUxL0JvOFB4dWo1ZGRyQW5HMkxIU3NOR2ZB?=
 =?utf-8?B?WmRJYVN4UWppWVF6QmxRWkNjUUdWeXg1TTUyTkwrY3FBUGp5RStlT1ZsUWV1?=
 =?utf-8?B?RWM5VGtRVlczRGFHemxacHJKMllwZXdkeW84eUR1aCtxSUFmdDhpUTZqaUF5?=
 =?utf-8?B?VXpkcTh2VGMxSHpuUkN2S2Q4N0xpanB4TVo3cEhieXh0VGFOMWRhZndmaFpO?=
 =?utf-8?B?SmVFZHdvRVhKVHVYVUNsTlg0c1ZFVWVrcjN4dWg3eXlxNDYxeW9vZ3ZFQ2Fw?=
 =?utf-8?B?cHpXblA1eWRNTWh4TDAzc0k3Y0hQN2RBZThoUDJsMHZwNUZVV2l2akZxSEM5?=
 =?utf-8?B?OUhLR2krUWJYbDRseUUyQ2loaEtuSmVsbHZxSlp3RlRzTUt0T2VvUXpJUFd2?=
 =?utf-8?B?Qkl2RmlwNWtRWm5iUUpoYkQ2cUd1OWNRQTd1dkxWTWwyYWJjSWlZU3YxbEZp?=
 =?utf-8?B?dDE3RXZKdFNaWkZQUi9WcnZ5dVNjTkFhNUEyL0txaXhXYlZwSUtkWWRvTnE4?=
 =?utf-8?B?WnU0eUpIdHQybXdkaVJCSWhsNUdBbkpPOTB3d25ybW9xUWZzc0JMeW9wYktF?=
 =?utf-8?B?Y1RWZ2wyWnZtUzNMVksydFdlMERXNE8wZld3bnkyZTlOTk5IWDI2RWtkcm5V?=
 =?utf-8?B?dW9HN0g0K1NoeHpwUWpJNGRVbWZvTmM0U3ZkQ0JvenYrQnQrcytHK0VzM1ls?=
 =?utf-8?B?UVdqN3hza1Z1QTRNUm9aYmM0ZFQ4RkhSUDdydDI3SXkrV3oxNnk3MGFRbk50?=
 =?utf-8?B?TDFPTml6SVNIVGplaVVROU9WVnp3NW9HT2tOaUEvcVNlRjFpbEJXS1R3K3Vk?=
 =?utf-8?B?b01aZnJSMzduKzVJdG5DRlZCMm8ycThZTEQ3KzQ4blFHVEJETTBQdlB1dmRX?=
 =?utf-8?B?Q0hweVVlQlRXRm81K3huSy9QR1M0bk8rNlNkWklSUEdGOEdxL0dvQzVXZ01D?=
 =?utf-8?B?TlB1TFZJL3ZmeFBSbVJQWEIzOFJHamFSNlBjZVg4cHlyNEZKVnM5bGtJNWdW?=
 =?utf-8?B?eDdFR0w2R05zSXNWQU1JVE8veU4yVmRqNHluWHEvdUN6U0c1NGZ1c3ZvOVRD?=
 =?utf-8?Q?uF5/Q6qB4w9kA6ubPBUA72Ng/?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a2674a2-06e7-4c2d-bc49-08de05f605b3
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7997.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2025 23:05:35.0605
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ow4/joDv7i4SzVnvDmpVpJcluiGHTlu6yDxuASykwylShulinuvC5mhPwBTGDdBZZBAV1/KVEPpsEAuj0O5kJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR11MB8833
X-OriginatorOrg: intel.com

On 10/7/2025 10:23 AM, Edgecombe, Rick P wrote:

> 
> Why is only set_virtual_address_map problematic? Some of the other ones get
> called after boot by a bunch of modules by the looks of it.
> 

AFAIU, efi_enter_virtual_mode()->set_virtual_address_map maps the
runtime services from physical mode into virtual mode.

After that, all the other runtime services can get called using virtual
addressing. I can find out more if you still have concerns.

>> @@ -476,8 +476,8 @@ void cr4_init(void)
>>  
>>  	if (boot_cpu_has(X86_FEATURE_PCID))
>>  		cr4 |= X86_CR4_PCIDE;
>> -	if (static_branch_likely(&cr_pinning))
>> -		cr4 = (cr4 & ~cr4_pinned_mask) | cr4_pinned_bits;
>> +
>> +	cr4 = (cr4 & ~cr4_pinned_mask) | cr4_pinned_bits;
> 
> 
> Can you explain why this change is needed? It relies on cr4_pinned_bits to be
> already set, and kind of is "enforcement", but no longer depends on
> enable_cr_pinning() being called.
> 

cr4_init() is only called from APs during bring up. The pinned bits are
saved on the BSP and then used to program the CR4 on the APs. It is
independent of pinning *enforcement* which warns when these bits get
modified.

> 
>>  
>>  	__write_cr4(cr4);
>>  

