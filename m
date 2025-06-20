Return-Path: <linux-efi+bounces-3891-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D64CAE2603
	for <lists+linux-efi@lfdr.de>; Sat, 21 Jun 2025 01:19:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8AD607AB2BD
	for <lists+linux-efi@lfdr.de>; Fri, 20 Jun 2025 23:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0583A241676;
	Fri, 20 Jun 2025 23:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i1K9ee+S"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B6042A9D;
	Fri, 20 Jun 2025 23:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750461542; cv=fail; b=rn/dCdCqUkqVbZmxYYPwD0mUb9b6w0uvBgtiZbAZT+5hLAV47uHLIcTCp18/WZ1PsKIBkp2uxQfbQbBIxicWLmOK3Jyeras28DO3JxKBZExlBnf2Xx9YBnr1lSs3YtXzqjuInZSKiNQRBm1btKAirTOm+DQJnXLZc+z9fh+o9OU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750461542; c=relaxed/simple;
	bh=MhAyLnFoi7IY7ZmSKPeVthSpk2Yr8NKNokpbKbwW13M=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bExPTUwCc2xSvLNiMxDNUSnCcZa+F+q3G3qvvrzKEfyfoRQVfmMuydw5/rppFTyIkDLr+WWbkfDvM+0LodlMa7+rYzln5Lqdcu79RoRaHJthyj+ZVqsYJfjqN+u3DPfCmUZWYPbkfETZGSo9xYDtSEdGWnvQFG/1EqLHK7BMgg0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i1K9ee+S; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750461541; x=1781997541;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=MhAyLnFoi7IY7ZmSKPeVthSpk2Yr8NKNokpbKbwW13M=;
  b=i1K9ee+StTMHhpat2fAVyvCIc7bHtGwWf3dO6ulVi55jXMWovuUswnZb
   9ZY7li/M7WnkgBYBgGX2KOFH5+h/nlQW+wOZYwbaMwj5HSg8t0/QHAYU1
   0tXwKIcGKWsj72Ufe9Kgoaq2gqcjJcY0Y3WvVsOO9zcXP8NpkwvEK67ld
   u5MSDa20b3lcufmREdQPmqcs+YyOecv4DSwHg4GGH5g0MJ/SkIW1zFFa/
   psgGu/W5OciMuPn6IAgEMfwCYaBxMrhLZo3H0BF47rePVhtw31RYXYFov
   Hvhn7vJo2NNz7KnupvfcFnzSSBTK+QuluWn8bSwlxPHlLz52lXVoqszMp
   g==;
X-CSE-ConnectionGUID: DTmA9zd/TvOn/DUdZ5rfdA==
X-CSE-MsgGUID: wzuD6p7cQvyQxhBQw1z3Gw==
X-IronPort-AV: E=McAfee;i="6800,10657,11469"; a="63343302"
X-IronPort-AV: E=Sophos;i="6.16,252,1744095600"; 
   d="scan'208";a="63343302"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2025 16:18:50 -0700
X-CSE-ConnectionGUID: U8uOyGv/SOWac3Gk8HaieA==
X-CSE-MsgGUID: vuaqnqmpTsSO0p/DxNoOzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,252,1744095600"; 
   d="scan'208";a="188266438"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2025 16:18:50 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 20 Jun 2025 16:18:49 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Fri, 20 Jun 2025 16:18:49 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (40.107.102.71)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 20 Jun 2025 16:18:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fDg2CShG3j5GfrIfiiYX2hXXRDxUuLHUUzZR6vqZO8PpV7URIFwcHhlNJb0HC0mFv/70XSsUwyLvXPuxLomLGmkVJYQmrXK2uJloD+wFhlmcPKIn0jdrErguCTBH1HmwjvVZUN/8HiJ0RMD/c3pE7+Dm6lKdJjvW5bv8lkC5xFyhjPZP1c2SKDrvfdTRnAbmWhO+brYIVEmsCyKdGlJovdRnf5sjU/Wua1fqlGKB/8OAM8CsnlRa3uGWlZzCWzrfwc/ljQMy3u1MgDd8qdDDE3GqvwE9NWO9/jdn3Evv9IvDNCXNgM0joEQjDBWkjP3tOX0Gh9a8wUVMmADkMyRqDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZL9x0oduidmX497+9WRPDvWGXohkI8+K70PbGYer6MI=;
 b=bhxOZlRyBgKiE6vGdNNM2nn261si7GE1LzV+v093Tfaecmf8/OFDxsvycKIl+OFv2/dHcc0QLOHD+tCbEIjswOGn1pxNWwO3J6ciw5LudiAvpcHOmH4yekKMCKZT3FQpkls8hI7KZR/1kWjOGZsFAotrU1eCwHv4UfagV+p/qe1+19+/EjNq8xGrov+GZ6SD8q5QM4xQJ4B8xGt68i86rwyhgYdkqTgl20CZ7Q2woaTj6KNDTwgzLqX0zAhsPMZsuihzzmS1OoKjHZjkJUYOCNl5EL4k/+i/6cycYnajO6CiQ7yoJZoE0JrXJYnnADrom2iI4oJEXU2xw7ZDms3s+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by SJ5PPFC295640A5.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::852) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.18; Fri, 20 Jun
 2025 23:18:33 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b%4]) with mapi id 15.20.8857.022; Fri, 20 Jun 2025
 23:18:33 +0000
Message-ID: <f6d73a46-7ca0-4898-bb23-9095be403ea9@intel.com>
Date: Fri, 20 Jun 2025 16:18:28 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv6 07/16] x86/vsyscall: Reorganize the #PF emulation code
Content-Language: en-US
To: Andrew Cooper <andrew.cooper3@citrix.com>, <dave.hansen@intel.com>
CC: <acme@redhat.com>, <aik@amd.com>, <akpm@linux-foundation.org>,
	<alexander.shishkin@linux.intel.com>, <ardb@kernel.org>, <ast@kernel.org>,
	<bp@alien8.de>, <brijesh.singh@amd.com>, <changbin.du@huawei.com>,
	<christophe.leroy@csgroup.eu>, <corbet@lwn.net>,
	<daniel.sneddon@linux.intel.com>, <dave.hansen@linux.intel.com>,
	<ebiggers@google.com>, <geert+renesas@glider.be>, <houtao1@huawei.com>,
	<hpa@zytor.com>, <jgg@ziepe.ca>, <jgross@suse.com>, <jpoimboe@kernel.org>,
	<kai.huang@intel.com>, <kees@kernel.org>, <kirill.shutemov@linux.intel.com>,
	<leitao@debian.org>, <linux-doc@vger.kernel.org>,
	<linux-efi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>, <linux@rasmusvillemoes.dk>, <luto@kernel.org>,
	<mcgrof@kernel.org>, <mhiramat@kernel.org>, <michael.roth@amd.com>,
	<mingo@kernel.org>, <mingo@redhat.com>, <namhyung@kernel.org>,
	<paulmck@kernel.org>, <pawan.kumar.gupta@linux.intel.com>,
	<peterz@infradead.org>, <rick.p.edgecombe@intel.com>, <rppt@kernel.org>,
	<sandipan.das@amd.com>, <shijie@os.amperecomputing.com>,
	<tglx@linutronix.de>, <tj@kernel.org>, <tony.luck@intel.com>,
	<vegard.nossum@oracle.com>, <x86@kernel.org>, <xin3.li@intel.com>,
	<xiongwei.song@windriver.com>, <ytcoode@gmail.com>
References: <9d351d80-66fe-486f-bdb3-370859dc47cc@intel.com>
 <262c0fd2-ac66-4ce7-903f-4062f1fe1d6e@citrix.com>
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <262c0fd2-ac66-4ce7-903f-4062f1fe1d6e@citrix.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P222CA0008.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::13) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|SJ5PPFC295640A5:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fdd4cc4-e662-47e6-afdd-08ddb050c661
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aFI4YmlVdDBBdGcybHJZZDZOaDlqSW1uQmJubTZVd0U4dmFpK1h2VDcyb1pi?=
 =?utf-8?B?S25YMGM4VmNPdWx4ZkNZSDkyT0xPdzVHSlNxa1NZbTVTak5RcVoxMmY0WVBC?=
 =?utf-8?B?ak9xa0xwQ0dHRy8rUzdOMTI3SUg2dVlMNCs3dEo4MXVOQ0FhV2VUeGZObTNh?=
 =?utf-8?B?N3ZUQ2lkamVjdHV3cnBZWjZVUzZtWVFqQnNDRmR3cEtIUlNkV2l4UUdrZE1L?=
 =?utf-8?B?bWg4YllkYm9ac1VZbHhWSzNRdlVaQ21XU0liUFQ0WlBLQ2UrajVBOW9PSFhU?=
 =?utf-8?B?dWNzQjN3RnhsQ1h3WmZCb0FOdWZkUTRTN1lCT09UTzhJczBBbS9uVzQxYmJU?=
 =?utf-8?B?T1BOYkM3VDUvc1lkWXQ5WGlLMzVRRGZ5YmlUWVJUcmkvWEE1Q3NRbEYrNWIv?=
 =?utf-8?B?c2FEdHk0WTVKQWV4bGl4SHNmcVZmQWZFb01zendWWW0ybDlUQkhpVnI4NEw0?=
 =?utf-8?B?TUR6QThndnpGTHdUU3NQdExLQ2lzd0ZpUENFbVNkRG5wWWlZMVVrVW9ObGc2?=
 =?utf-8?B?aVE2YzZhL1lRd3VvZmN3VXpIdEdsZWJyLzVmNG1kWTdOdmxkMUYycjkrUEox?=
 =?utf-8?B?UkdtdW5MMmgvUm1hZml0aEZobGxYM2F0ZGxENmQ4Z0QyejNxL0JWekVTeXBt?=
 =?utf-8?B?TklhcGs1RHlzR0U4cFBoS0ViWXo2RUlIdWRkY1V6aHd6c08xZEhmYXJ6OURq?=
 =?utf-8?B?ZjVVK0EzdGpsWnFXWnpPTCtTK1BzYVh4WFN3MG1VOHMzKzlseG9RRVFPdlNj?=
 =?utf-8?B?M241WjdtRjNqandXMWNSRnZjUmlid05hQ2g3Q3gzNDlFZDNuMEJqeUdHTWFM?=
 =?utf-8?B?Nm9KNzRTNE9mcGdaczNWZi9UTmZUVStmWmYvbjBGT3FudWZqd0k5Tlhqd0wv?=
 =?utf-8?B?YzJZYkR4bDRhbG9NNFZ1YUNqTWRGWUp5dmhuRmlpZTZNUWNtLzd1ZEdJejEx?=
 =?utf-8?B?akZqTG9abytzMEFBYkxaTWJjMFlNLzU0Skh5Y1lFSnJpNjlkakZGNU9VcWtO?=
 =?utf-8?B?OHliN1JpMVY0dk1QcGNScEN0Z0hGWFpJdmpXelplN2Q3YThLOWZzYXFpa0xn?=
 =?utf-8?B?RUpKOWE2WGVEUTU3cVFiRHZjSS82cDBKbFp3Tk9RdHpkQk9TK2gvZitiUUhS?=
 =?utf-8?B?bUlnTDZ5Z2JSWkpoZWl1UXlEb3hvV1Bkd1dxdGF6czlkb2NDTis3Q1BoN3BQ?=
 =?utf-8?B?akNkOTdsYXVMRUR3OXdIQWxaN3VNZFFaUDJHWllTQmJ5UERtQ2RRYXM5NGUw?=
 =?utf-8?B?bjMvL1FHdnUwL1hXeTFIRVVKSHp2MGgrVmtGNUI0N3lPbGdNZXZXN1J1MklR?=
 =?utf-8?B?a3U5eVlxUTRnSWcrK0VQV3FQaHQzWHo1VWg0STg0MWZ6aGVzYkNDOXFyaXNG?=
 =?utf-8?B?UFNnSkNieThkQnZKbE1pUUludjB3Q29MODFmVnlIMXhYSENKcXdkbmp1Yi82?=
 =?utf-8?B?bnVTQ3dTTE5QWUZ5a20vb1paWWh5QUlLeVhGeUw3c3ZNVlBMTlhuakE4YVMx?=
 =?utf-8?B?MDFKWUNwQ0pvYURSR0xjQ1VSS2F1dDRsdi9ST2w2SGlhUndYZXNTM2N3R2h0?=
 =?utf-8?B?U1dsR1NUVGRWWjBXZ0d5akFuVHEvQVJVNjJmeVJIc3doakNJdUp1Y2M2MlJJ?=
 =?utf-8?B?OTRGQkp5QlFZUHpocjJQeWFhVG9WWm91dHNvN2NHT1BPQStTeWZrSEkzUm04?=
 =?utf-8?B?OUpDUlU0anVQQ0d4VFdMVW1IUHVuK2VQWnEzQ3F2SnV3bnNRRlBKdm5EY3VD?=
 =?utf-8?B?TXo3N3J1VVNoUFZVdDNoQ1B5YjROZ3YxODQwa0pzVGYzOHNLa0drM3JTRE1D?=
 =?utf-8?B?TWJmUElMYzdaWWcramp3Qlk5UnNNSVIvOVd2R2g0WW1vMlB1enk1V2syYlU4?=
 =?utf-8?B?eGpkQVg5TVN4VTRFWEFLUUEzV2NwQ1FHTjZ0VlpmVCtvRGR5RjJzekFkVmRU?=
 =?utf-8?Q?yiUpoihihQE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S3FaMnNKQXdlUjFKV1B4SkhzbFlqZ3JISHczOTd6OUZGZ1hHUGZHU0I5ak50?=
 =?utf-8?B?TGVOTThjcFFOYWZlWXhmZW9KeHc4em5jTzBWVk1teVpoSWFNdDJiTS9lNTJo?=
 =?utf-8?B?TFFhb3hhQ25WNldJZTRYaHJQUFREVGY3M1FITmp5VFdHRXFvK0x3blF6Qjh4?=
 =?utf-8?B?S3JDcEpERjlETWgzZ1U3QjRCL2ZzZkFFRmZ3NHJmWWVXa1JMVHlWNlpLTzlO?=
 =?utf-8?B?R2JYSmF0TUlkRWl1ZDhVclZzdWRWOTIyT2pJd09tUk51WDN6M0VSWXpxMThy?=
 =?utf-8?B?ejMrL0MxSjUrZFdvRVM4UE5ZL2FkS081NVFVTlB4T1hydXlaNlV1NkpabGE2?=
 =?utf-8?B?RUN5eUVpSjd0NWZHSUVYMmVjSnhza0JwS3lkSmxNajJ6UUJOMk1rc0RaR2Q4?=
 =?utf-8?B?SXNMck9FRGhSR3d2b21MTUFFamRobVRDZ1VzakVxRVd6cVcyZ3dya1NBZlBi?=
 =?utf-8?B?OVJyOHB3QTU3RjlDbWJ3ekREU3VnSjFBZlJDek1XMkRLMGozQVNzWHl1NkU1?=
 =?utf-8?B?UGNPRW5URGZNekFxbURJUk5RUEhoV2h2aVBXTzdtaEtMMzh3NEJnaVpqYWE2?=
 =?utf-8?B?em1hMHJNdUNLQ3pLRDU4MVNteDRHTHJNcFA2Qis3MGNlOGVCZGZEbEtLbi9S?=
 =?utf-8?B?bXJ6VnJxMkNYb2h0UDZKbjJvdVFwZDYxL2NFQy9CMkQ4QkNrMHRCL1g5aDNt?=
 =?utf-8?B?ZEN4N0tYQ3Z1MEFFeEJEdDJXcm1PSmFjcEZzeG5VOVM2Uzl0S2d3MXlxc1Nv?=
 =?utf-8?B?Ymo4QzlJQ1VIVEpaQzB0TFpiV0d3ckt4cG1SN3JxM3E5ZHY1M1o5MWlrZjZE?=
 =?utf-8?B?UWl0eXZnaUdoQmkzYWxlRk5IanNMQWdhTHQrTEtrTzdxRXp6ZzdYMzA4T20z?=
 =?utf-8?B?K3BSODJ5emdkZGNFWi90TURsUU9zTW1xdkJOVDgxQ3lHYXJWNDFUZlAzNUJa?=
 =?utf-8?B?Z3ZJM3dYdUU4cTA2UkhjNWdFZ0g1REJTU0dIemY3QjUrcjI0YnlYc2VLbytl?=
 =?utf-8?B?d3pFS29Zdm9HMTBTOHBuNmRWb2ZFV3FjK2dMOGxHaVEwTGxKUmN0aCs5bkdv?=
 =?utf-8?B?MlRqdXBQa3REN0RiN21lY3c3TXpSMk5MOTQ0RlZmc2xBWTlqYllHcXJjTnpI?=
 =?utf-8?B?L1YwTTQ5clBnR3lhWWNRUXk0aDVmaVVoQzkrNkhOWjEzbitvVW9LUXEwRitX?=
 =?utf-8?B?N0NDZ1o2RkUzSmc0bkdYSnF0NHloR2haMWdOblBNYUFBYXpjVmpheDNJcnpn?=
 =?utf-8?B?UUVjcHZTNGZwRzF6MmxKa2k0MWZrZXB5M25uWndjZE9mTzBRNGlpQllEYm5C?=
 =?utf-8?B?N3B4UTZXTW92bHh3cElyc1oybjk4N0VaYS94WXdKWndNaU9GRnBiYkhCWXdx?=
 =?utf-8?B?YlVXeG8rU3VjUGFJYUo1NlV0VkpMWVppaFZoWDVzbWt3L0pWZE45eDBoaWRp?=
 =?utf-8?B?OHpIV2NVb2tpdHlPYXRhUkRpVkk4NnJOUHh5SXA2U3M1TFlqcktIakI4cGVU?=
 =?utf-8?B?RTlZQkUxRnVYbGNmU1NSSHNWWW1aV2tEcVZnbHdhaXRvbnlsV1VsWXVIVHBo?=
 =?utf-8?B?TmhsYzNTUHhsa1d5MExlVks3WG5RRm1pdUhXNGdzUmVUR1drTFo1UThlNXp4?=
 =?utf-8?B?ZzlLa213S1dSeExHMmdsVWJxWHNRY25MMnpRbnpxTXoxak8xVGQ5SGdkTjA1?=
 =?utf-8?B?WWIzOVRxU2VLalZ4YVpqU2ZvMVkzM0N0ckxTdnMwVkxXVEZZbUZBTERaNzBa?=
 =?utf-8?B?aE9WK2JJb3lhUFhyVlhSSWlOKzBkVkVnc3VoL205RzlrOXFjUUlHN0FxaGNT?=
 =?utf-8?B?UzlhMkR2TlBacEhBY3hUR3U2YnR0WlgzSUVlZDMrNW91dklFS1dPT3E4U2I5?=
 =?utf-8?B?L1ZGdmtDQ2pzanIxSnFaN0crb0tlUmpFclJBZnFMQVZQNTEzQ3o0R2Z4NmRK?=
 =?utf-8?B?ZkJYWVJWTHh5S2JRZTVDaFhBeXUwU0swT290L3JscDdQbmNwOVlCUGVMblJU?=
 =?utf-8?B?cXpOUERkU2VLY3RXaVAyRzE0NFBBUnUwWndmQlhxMk43UWo2MG53WVppUmVB?=
 =?utf-8?B?b1BmTVZtRE1qLzlvUktJRE1FM0VCT1dWeXdwSmt6Q2prc1ZKYTMraTB1ZHox?=
 =?utf-8?Q?kzGt5sFC/1jY3T5xPA7wzXE6S?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fdd4cc4-e662-47e6-afdd-08ddb050c661
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2025 23:18:32.9966
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: apZHS0ghnHT+V+S/9G9dEUK8eduV5M9JDnYdd3YJQZthf/0564gj9tyPVIM1Tl7HgsrtH1x49pPCwpfvPBjzqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFC295640A5
X-OriginatorOrg: intel.com

On 6/20/2025 4:08 PM, Andrew Cooper wrote:
>> But, the resulting code is wonky. It needs to do something more like this:
>>
>> 	if ((error_code & (X86_PF_WRITE | X86_PF_USER)) != X86_PF_USER)
>> 		return false;
>>
>> 	if (error_code & X86_PF_INSTR))
>> 		return __emulate_vsyscall(regs, address);
> 
> To do this, LASS needs a proper interlink against NX || SMEP.
> 
> If neither NX nor SMEP are active, the CPU does not report X86_PF_INSTR,
> meaning that fetches are reported as plain reads.
> 
> This leads to some fun corner cases in SMAP and now LASS too for virt.


Maybe I am missing something, but LASS works pre-paging so it wouldn't
generate a PF, right?

We have a new vsyscall emulation for #GP (patch 9) that wouldn't follow
this path.


