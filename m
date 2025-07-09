Return-Path: <linux-efi+bounces-4202-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AB81AFDF41
	for <lists+linux-efi@lfdr.de>; Wed,  9 Jul 2025 07:32:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 011A61C258FF
	for <lists+linux-efi@lfdr.de>; Wed,  9 Jul 2025 05:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA7E125EF89;
	Wed,  9 Jul 2025 05:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eXQs9IOi"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30011EA73;
	Wed,  9 Jul 2025 05:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752039140; cv=fail; b=bYkhk52hVgB4E62xfUCXxgidfkx/4E5ufMDrq7I26MqqggzUeRXPh3otXNNTCevAhRCFv8J6CO9ZK82HKNiDHmVvCWZ1yU1K4uI+QjzOjJQ56pJFuFDZbqp8XlpCdG8LyEUgUbMLu9/9IauX3WQdkkJuiL6zivYID2iNUdFcUxw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752039140; c=relaxed/simple;
	bh=hcE2m0WfCbd0NeAB03fGwAA4NrHxRSidKzvmYJBdn1s=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=o1DKk9bkAJOW7Sr8+if2mNclfFfJDZ6GG58o05wMD25g8lDKYUNQ0sLbFPYB2X87eTpXzvTryUORcd9y83tFukbiHMVB7ZHZAwGX/Il9OVgqoYUcUoBf+FLE9hSywrAT1bD/lsKECclBAH5yvsy/sutbw+DZIBjyGNZE6+Gz9Aw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eXQs9IOi; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752039139; x=1783575139;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=hcE2m0WfCbd0NeAB03fGwAA4NrHxRSidKzvmYJBdn1s=;
  b=eXQs9IOi98Oe57rC9AOZ3OGa8mfRsu/0pw3NojDUgeibu5lYjP40+MlL
   fH/0kuI+b70sxOFu3J/MCLqoq6CcwENhvRqF+t+kTR/TTxmev+E4BlPfk
   vVv9jYjVCiV7cZkNH+ZP0zSpaB7IyVt8EOZzPOxlI0uaXlsg/Q+oF9VJb
   icZ1/4JCV2Bmf5vmqBcO3rAS3eV4GNoaBtavJ6xTmxBe1AZv91EUoDlRV
   +B5ej0BBynSrrvIWFfoIVlqPnJEYQUVC2En7HNDv19JCZKKc8nhMNMAdi
   sbRE1BPXFkdrx4MnVfJ3umsJuyL2+ZuhhhgFM/okEZfxL+pJLp1nHR7dq
   w==;
X-CSE-ConnectionGUID: TLxLJYoJSVG+00VBj93uqA==
X-CSE-MsgGUID: 6ryptvbSSNSoa6X4homdoA==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="71870185"
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="71870185"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 22:32:17 -0700
X-CSE-ConnectionGUID: KDmjgZllR5mSFSGddxo8Yg==
X-CSE-MsgGUID: +uovXDF/RziXWmS2StpyaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="161228254"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 22:32:06 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 8 Jul 2025 22:31:55 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 8 Jul 2025 22:31:55 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.41)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 8 Jul 2025 22:31:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XZetKauZAfLiPdM0xsHwO+5yQCYc/X9BmDQOYcGl01vAPrGgBFSG/UUKrQ8vavnIGLL/d0FyBUPZRWMwORjOMExIN+mzMqwh5Bf5+rCOz7ydY2A3v2GdXpEMw0YfV244u8jmLuH53wFDkW7DK5UUkI+6N0peGn6OhNbHipd62ahA8sr2r+FEeJVKYkQEYqqicCpq5ExevPxlKGcsYJdcCdbBzxDl6f5UAoIZEE6Ods/oYTErlh4+3CbH5QzTUNJhGgZuM+m+fNVYeLYYUh+n2/zwwSqOmBRfDCnOYj+i0CzNpwFmU7ueqjYb5xewi2jdPbJv+BwZpbD9RMZpYMocNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3YZC12vzhWAuowSi1Hu/DcUbLmuy6Du9owAgx82oOVE=;
 b=bKNzpVfWpFx4I6NM+5XQ/H20zlqq9HuikNK3LUJ15MduejGFULsVdnMDxR1J/omciY63JVZCSm8nCoqS7v6s12WQgYsKEwvdPft42NF0SAbMOFQOgrKhR8RjbMPC+JyrTGDZnNZnKprSo+kyz/ygRLjpe9SMq4c4sLk1e/XwKCFRRaI5VAGWzHEXEw7GGu7ImTM6OZ+6gU4XjWBwuTzwRH5GAMHRDEsfTImtCU5PZEfy2E6vKvlmCf+yDPulWkdy9rxUez/wM779l83l9AsPvxAcz4HZXxwx/+VjJXOJCHifonDsqtl8o9QYS14q4UXePRK0AOLuaJ+5+WxBSkC4kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by SA1PR11MB6758.namprd11.prod.outlook.com (2603:10b6:806:25d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Wed, 9 Jul
 2025 05:31:09 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b%7]) with mapi id 15.20.8901.024; Wed, 9 Jul 2025
 05:31:09 +0000
Message-ID: <b1408df7-abb4-4ac5-aff7-c04fda7dec7c@intel.com>
Date: Tue, 8 Jul 2025 22:31:05 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv9 16/16] x86: Re-enable Linear Address Masking
Content-Language: en-US
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Andy Lutomirski
	<luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar
	<mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, "H. Peter Anvin"
	<hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, Ard Biesheuvel
	<ardb@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>, Josh Poimboeuf
	<jpoimboe@kernel.org>, Xiongwei Song <xiongwei.song@windriver.com>, Xin Li
	<xin3.li@intel.com>, "Mike Rapoport (IBM)" <rppt@kernel.org>, Brijesh Singh
	<brijesh.singh@amd.com>, Michael Roth <michael.roth@amd.com>, Tony Luck
	<tony.luck@intel.com>, Alexey Kardashevskiy <aik@amd.com>, Alexander Shishkin
	<alexander.shishkin@linux.intel.com>
CC: Jonathan Corbet <corbet@lwn.net>, Ingo Molnar <mingo@kernel.org>, "Pawan
 Gupta" <pawan.kumar.gupta@linux.intel.com>, Daniel Sneddon
	<daniel.sneddon@linux.intel.com>, Kai Huang <kai.huang@intel.com>, "Sandipan
 Das" <sandipan.das@amd.com>, Breno Leitao <leitao@debian.org>, Rick Edgecombe
	<rick.p.edgecombe@intel.com>, Alexei Starovoitov <ast@kernel.org>, Hou Tao
	<houtao1@huawei.com>, Juergen Gross <jgross@suse.com>, Vegard Nossum
	<vegard.nossum@oracle.com>, Kees Cook <kees@kernel.org>, Eric Biggers
	<ebiggers@google.com>, Jason Gunthorpe <jgg@ziepe.ca>, "Masami Hiramatsu
 (Google)" <mhiramat@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
	Luis Chamberlain <mcgrof@kernel.org>, Yuntao Wang <ytcoode@gmail.com>,
	"Rasmus Villemoes" <linux@rasmusvillemoes.dk>, Christophe Leroy
	<christophe.leroy@csgroup.eu>, Tejun Heo <tj@kernel.org>, Changbin Du
	<changbin.du@huawei.com>, Huang Shijie <shijie@os.amperecomputing.com>,
	"Geert Uytterhoeven" <geert+renesas@glider.be>, Namhyung Kim
	<namhyung@kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-efi@vger.kernel.org>, <linux-mm@kvack.org>
References: <20250707080317.3791624-1-kirill.shutemov@linux.intel.com>
 <20250707080317.3791624-17-kirill.shutemov@linux.intel.com>
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20250707080317.3791624-17-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR05CA0029.namprd05.prod.outlook.com
 (2603:10b6:a03:254::34) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|SA1PR11MB6758:EE_
X-MS-Office365-Filtering-Correlation-Id: 9549417b-a891-410b-37a0-08ddbea9cf29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?N1Y2aVNoQ1QwY0lYSzFoMXVUYnI4b2IwOVY0QXFGRFZndlJQVlZuM1Ewb0c0?=
 =?utf-8?B?S2VyVGUzNTVnVzZJRVExRkRqd3J2eERXanRJaUNTTDY5VHQ5d0k5M1hyN21s?=
 =?utf-8?B?VzNERmJXd3AweWhaSnlQSWs0ZjVybjlBSVZXazkvaVgwcm9Hb1Z2U1lQVXVX?=
 =?utf-8?B?MlN0MjQ0amdXaDRjKy85SVpQcjlycFZReHJUSktJVjByZFpoR3JrL0xKY1Mr?=
 =?utf-8?B?bUxEZkRrUXFyLzFvcTNZRllZaHZodzNsNmQ0UXQ5TGU5dmo0aS9rSmMxYytJ?=
 =?utf-8?B?dmpLclpEclgzdWIweitBS1BqcXlNTmkxWjFkb01CNCtvZVFFRDdacjVDWmd0?=
 =?utf-8?B?ODRXOTNob3cwWVJmbkVpSTRsMVMzKzQ5TTRXaEtLUnc1aVJLSGF2azRzVFFJ?=
 =?utf-8?B?SGhrd0hxVXlNeFBwQkcwVE1UTWNNWWFiSVJlZkdyYnFicEoyd0sxaWlwSXJC?=
 =?utf-8?B?NVBKbjdOY3FzTS9sbkxLTjMxM05QdkR0Y2x6c05UOE9NZk9pZ3hZN28wMVU5?=
 =?utf-8?B?bVNvcnRLbEtpU2x3NjNpV2Q4K0llNkhLMUpDTG8zOUxHbEhPbTJIdjRHSklw?=
 =?utf-8?B?bzNManAzZU9KeDhnb3cwWDZja3R5NktMUTFvYjAxUmVGSGl3R3MwWm9ReG1F?=
 =?utf-8?B?ZUttNktmZEJJckUvSjFoWFBWanEzWnVpM3NxZ0JidU1tWHRzdk5lTlVUdG5W?=
 =?utf-8?B?cUp4Mk0yemQzWE5CVU1Id3NveG1LelhmSC90WCtmbnQzUm00aGVFSGxhRFVZ?=
 =?utf-8?B?YmpyUUJsT01JVHphRVhhbnVrYkVwd3FHOUVFSUdldDlBaVpqNmF0MTVuWkZ6?=
 =?utf-8?B?dDN1UUllTnhKaTlkL1M4Ry8rVHIzZ2lBZFdIT3VrVnlGelVoUE9QTFlqUFFx?=
 =?utf-8?B?cE41YngxL2cyNEx5N3pXdUlsUjFTL2xDN2plYTRscVZ6NXRMaGNwejJCYmZz?=
 =?utf-8?B?WG40RHJzViszUlhFZmhYVmt0blQxZm5MTEpKd1hHR0JyQ0ZRZ0pOZEY5V1F1?=
 =?utf-8?B?bTcyZ0xrbzVKWWdzQnRHTmtBK2ZjM2JOVmNZNXRjdmRwdjZGdkVGYzNxL0JY?=
 =?utf-8?B?R2FHc05heW1aMXRCcm9zOFdkUTZYd01MT0NNS2kvNUJ5VGlMeFBGVjJyVEpP?=
 =?utf-8?B?VXFhMjkxM3llZk5OVkJFclc0OThTcTIxaUxuK0dRMFI1eDVBNHVyTXpIYjE3?=
 =?utf-8?B?MWkrclROdDFIbUs1cHF6MUF3S0wwSGxlMW1LRFpwNGRqYUJscnJ0Z1JXLzlF?=
 =?utf-8?B?VHg0YU85OFVCYlhEbXRveGZlRkt2ekdFTmFOcHNCcTJ3M1RJYmd4MU8yamRa?=
 =?utf-8?B?YXo0Ym5adUJlbEFYMHRBU1RkN2dYMUxNS3I3eDBKL1pnNGsvVzBBTmNHaVM4?=
 =?utf-8?B?djEzYXpPb2xPNkgwU3Jldlh1SEhMeEFoQXJSVmhCeDRNdVBSSFl1L1lSVlNl?=
 =?utf-8?B?V1FuS09ZR2lSdC93SmhFaFRYMGZCZ3llSWNidVk3Um5HUnAwbkZ1Z1ZhdDlw?=
 =?utf-8?B?N01JZDVBVXc0b1Y3MWVqbStuOXVSTEdtOWxtamhBNzlON2JlRGt6cDd2QnRs?=
 =?utf-8?B?VEExZERRMk5MVkRMNm94YW03eGVyMzJJZlRCZHZaZndNdnBua3d1emNPcEFU?=
 =?utf-8?B?YjdsZUtGenljVmExTTN6bGpDN1VIT25uTU9CUVc4d1k3bDQrT3RMR0pObVJE?=
 =?utf-8?B?aUcyQXBsMnpDNWJpWlpRUUhRWjNlSkdyWFJlMElUaitwdEl6NlV1UVZVN0FY?=
 =?utf-8?B?SFBHM2FjZ1ZwT3hIU1JxSDJVNVRPeGF3RmRxdm9GZDZzS290alNuUzNjQ2NH?=
 =?utf-8?B?Vk44Y2RHOTV1ODVXRlJTSURrVTBWcEtRQTRpZVB2MmJKUGFlSmgxMUdsWGo4?=
 =?utf-8?B?QlJKaXZjNEpFU1NKOTJ4dk9BdWkwRld0L09YWVVRNE4vQldkditnVHRDMXVO?=
 =?utf-8?Q?IrQKqizp0FQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OVJtaTllWWtTV3drT0RnNVkxVHlCQmhIaUdZb2JKQnI5WHF1VFk0MjZhWVF5?=
 =?utf-8?B?Q1BjVEc0dExvSlpkaGx3cC8xTVJvdWIxeFd0T0JHMDJObTdsNjVUS05XWVg2?=
 =?utf-8?B?YmV6UDZ2TXpYTXRmQmRKa3EvSVNXaytDNjZDZUlkcXc0S0Nnd1V3K1pwNThV?=
 =?utf-8?B?alJDNUtwM0ZuV0tNNk9lYWdIeldVSzVjM2dTMW9POHRObCtwdjZCQVF6em9P?=
 =?utf-8?B?S3ZBN0xtcUZCcTZ3RC9qbzBTWTJBV2RUOVYrcU5sSUhWVWlXY21iclczbUgr?=
 =?utf-8?B?YlQzb1JET3RmczdYWUtNNUZmN2lpTm1CaHVPSmNNcjlXNmRraXBwb0lKeUZD?=
 =?utf-8?B?YVdyNGF2UURHajRteGROdkpHY0Z5R1Via0JES05ibnhwTE0xRHBzKzE5b2pI?=
 =?utf-8?B?em52SEN3Z0dSNGRJZXlFTmp1WHJWV1krSVBTT3UxYnkwdVlsY0x6OFRPTXVi?=
 =?utf-8?B?cGRjdWxjL1lWbXRScGtucU1uV0JRbitwa3RiVXR2VExOQW5DbzdCeWZ2NFk2?=
 =?utf-8?B?QU51ZVFEK1VNemlXWXZGc3pzVkRpaUFIWG1VR3ZVbDNYeHhoSkd0Rm9jM3hD?=
 =?utf-8?B?eE1SaGs2d3ZmdmlLOTZjY0l1OVMwelBRMmVtNXZWbC9OUnVlb1g4aHp2SWFG?=
 =?utf-8?B?ZTVvSWFFVVNqNWJNY1NtVkFiNlY0TE43dDhUM05QMHVPK1pJaVF5QlR6ck01?=
 =?utf-8?B?VmhwVVR6TGNybmtDYzJ0Y1hlZE92NHhadUtOcmtBUk9CZCtveDNBVWZEcmVy?=
 =?utf-8?B?aGcxYjRDekZEZHlYQkZxQk9sU3BUZkFZbzJ5eGYxUUluUjJqSUR1MnpZVkp4?=
 =?utf-8?B?YjRiVk8vR0g3N01YbldFWEtOaWxDZk9Gd0cvY1ByTy9Pdk1Qd3dJSzFmdGFH?=
 =?utf-8?B?enFDU0NxTUpzNXpJNmptU3lMZWtqajltcS93cHNOMDgydnZVQmVYcURnN0I1?=
 =?utf-8?B?dzRza3NpY29seTQvTWRqNDhacU1ZTGZ1alF3ZkE4UTRyd3ByZDBZWmxycDNG?=
 =?utf-8?B?WkJDSy8rZHo1Qmk3WnFNY0RZMHcyLzJaOG9MMlN0VEFRakRRci9Oa0VVUlB4?=
 =?utf-8?B?Vjh6dncxK3VjYVdjWGVoZlowNzI0M1ArR0lRaElKVGliMFNMU25kTEF5SWx1?=
 =?utf-8?B?cEZrRzlXbDBWcVpwSGl1NCtucFhaTWk4bGxjUjcvOW55VzE3a0p4Zi90eDdy?=
 =?utf-8?B?VWM3eEtJNzl4cCt3TmJ1bWliaWc0VUF5NkhwM0RSeUo1Yjl6Rm5FakhVYkpM?=
 =?utf-8?B?a1ROcmxLUnVERlY1dEl3aEhpaE0yWG9GeHBEalpZc2k4OTRJZXpVWmJ3OEZO?=
 =?utf-8?B?SjBQRko1WU9NSU1MTDlnU29wUTU1dDRLVk5rbmVwUW1xVmtYZTByTmwwM05I?=
 =?utf-8?B?MHVpblNQaFBmbHI3bEYwL1d6L0xGY1lvTkZMZXk3Yms1dnRvc3I1ZUU5ZExZ?=
 =?utf-8?B?UzFHa1VqV1NQYVlvOEduUzIxdUo5V1NMY1ArZ2dpUzYydVJFNGNES1JJTTQz?=
 =?utf-8?B?d0JkZDhxOStYdDBTV2l6bnBYYzJvYUJCQXgzSEwvbzFlK1RiRjVRV3ltS3Ay?=
 =?utf-8?B?SWcvY3pVK0xlYk5hcllNUW5HT3N6V3A5SFNTaEp6OXRIZ09TM0lEOElYbFBq?=
 =?utf-8?B?b0wzREZGT0RoTUUzREVaQkJsdVBlMmtKV29NWjZPSy9GMTVwbFBKZXR4RlFL?=
 =?utf-8?B?U29iNGh3RXEvKzNpMDdsYXFuOWExQUVFakU2LzQwRVA4VW4rWnZkL09VTENq?=
 =?utf-8?B?Zk5VaE9oWXpQalNMSEJXeGpCZnlobkpmVHRlaTVyRkd4WEZzZXpaYi91Ylov?=
 =?utf-8?B?ZUhoYW5GbVNqdUFvYmN0a2JUR2JLYzcrOEw3UFpDejVuMmlKelQ2TjNuN1NG?=
 =?utf-8?B?Z3FTRjVjUjdpY3JzWlZ0SElTc0hMM2xldGd2cDlIR2RRbStNUTFQNGxXTFR1?=
 =?utf-8?B?aStPSDVIL3hSKzY5ejdhMmU4SEc2aElMMFZoN0FVaGZOVXFCWmlKWU9LbEtY?=
 =?utf-8?B?Y3hPMEpuM3o1RjZKWDROaFM3WjNiczE1ZDMweDJ3WDZ2RituTk5FVm90UDI1?=
 =?utf-8?B?WnVSOGIxKzhMNFp4SnlVNE1lbHhqSzZoUVFmd3hYNUlnSW9DSlZTR091NkpM?=
 =?utf-8?Q?fzonCfRjlaSzNr11mUiwQARrq?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9549417b-a891-410b-37a0-08ddbea9cf29
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2025 05:31:09.2286
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 44XcfA14l1qaL/C5tpG8rEv46PxbRtouDTGyQyhGQ2GtzDpXR7+NThRT9V+BX0YiwI14oEORTcOWriYJmV2tXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6758
X-OriginatorOrg: intel.com

On 7/7/2025 1:03 AM, Kirill A. Shutemov wrote:
> This reverts commit 3267cb6d3a174ff83d6287dcd5b0047bbd912452.
> 
> LASS mitigates the Spectre based on LAM (SLAM) [1] and the previous
> commit made LAM depend on LASS, so we no longer need to disable LAM at
> compile time, so revert the commit that disables LAM.
> 

Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>

You may have missed my comments in the previous revision.
https://lore.kernel.org/all/af709ffa-eb11-4de5-9ae8-a179cb99750c@intel.com/

Mainly, x86 maintainers prefer imperative tone and references such as
"previous commit" can be confusing sometimes.


> Adjust USER_PTR_MAX if LAM enabled, allowing tag bits to be set for
> userspace pointers. The value for the constant is defined in a way to
> avoid overflow compiler warning on 32-bit config.
> 
> [1] https://download.vusec.net/papers/slam_sp24.pdf
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> ---
>  arch/x86/Kconfig             | 1 -
>  arch/x86/kernel/cpu/common.c | 5 +----
>  2 files changed, 1 insertion(+), 5 deletions(-)
> 

