Return-Path: <linux-efi+bounces-4074-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3375FAF06C1
	for <lists+linux-efi@lfdr.de>; Wed,  2 Jul 2025 01:04:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6C11445282
	for <lists+linux-efi@lfdr.de>; Tue,  1 Jul 2025 23:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 441BD26FDB6;
	Tue,  1 Jul 2025 23:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fXVR7oc1"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E9626B778;
	Tue,  1 Jul 2025 23:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751411066; cv=fail; b=mxNvjCYmpUDsXavVRKIDIXInjuWJvEgBl47v2ZaeHeqrwGGBD1So5lGKvVzfXTfvR43n8nPw8IjtfKIq63RwZvR+ZOe+geO0az8P9MsZVx6LVoLh5BuxCJkyvxQzRd7QHjZ3L3ascr+OJKC7el7c7NbmGHfPoUxKu2Gaatvt+o0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751411066; c=relaxed/simple;
	bh=X23WyTFvtqTTmbKG103rvwwaBFzJPgVKBYjDxlHyBi4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZPFKMYnQ9Yh5v72ENoOlxi7KFq3VUIAbHDP5KCyNfL/1YK/AL6aj4O0y4XSElhLpm5iyy3+ORY+5t9CUaCj7ccqKIEKo0h1E9f4ZFzwjkVMIZ5E1KUs7dqncAwzznxO4QEKf5AWueYvNDonM98ocYP/20fEQoOySAzjYHrzdOCU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fXVR7oc1; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751411064; x=1782947064;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=X23WyTFvtqTTmbKG103rvwwaBFzJPgVKBYjDxlHyBi4=;
  b=fXVR7oc1/biX35e6gCIIVd7tee6RDbFSdxd6PKNYg5JTXb1ap+R5wWG2
   9S3ELmK87os8s/Iv6FL31xRU8l5nxMdk9S0a6QKr9NiLs9S4tY3bY1vLf
   6ftV2hSRxDdn3/1EZI0fKwnnZHd9murzW6e34gaARdYcvSx3kgvZxVFfl
   9S5cV5OR4/1l/QsKcehgKh8b5wHA2/pKtiuMs8SjN9Fbry2ctVJNQva0R
   g2vAYA1VK9EPkzvfKqVqXdAMTY/QM2haPY5dkjkwucoNQDhUWVX+7sN78
   bGAN6U+m7b1OZ3iXo6osdteCrQlBeUbki6eU0DIJ9bss3bYpk+hU2a/el
   A==;
X-CSE-ConnectionGUID: x+IuY53nTD+E8YO9HqHh/A==
X-CSE-MsgGUID: h6pfLD2MQO2QJJbjcacoNA==
X-IronPort-AV: E=McAfee;i="6800,10657,11481"; a="53802776"
X-IronPort-AV: E=Sophos;i="6.16,280,1744095600"; 
   d="scan'208";a="53802776"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2025 16:04:20 -0700
X-CSE-ConnectionGUID: V03UyQIaTxKtRVvzm8HUhw==
X-CSE-MsgGUID: QqfQooW7TKus6jbBykOnrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,280,1744095600"; 
   d="scan'208";a="153672068"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2025 16:04:20 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 1 Jul 2025 16:04:19 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 1 Jul 2025 16:04:19 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.68) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 1 Jul 2025 16:04:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BGnu+PtHirjvdB7Wgf5gghTrFj1voilzbGDARPzEJw9uB1Bx3lyL1wuwrhVFcEcBDpuTuNuLSQIjyeynPl2kgJGboinsZEVJedIyWFeSoYIKFE1X/VkI+p9LO0J4TeHiMDgsoW4QC2xDCWGYaSAqtyoZGimbC7ms5B4TKAsR9JSlbrgpzmBEUs24tsCHTJDRV+PcGxLl1VRMRgrOgY5DeFJoQ8iDhnAK9w6ZL0cw6u0iagmxwD1mUN9pnerNfePlHVjNV3bhg5ZrHQn/eqoIVhw9FltkW3kV71LWwgz9klcpaLiNWKXomhlqkRQTttQ/5Mt+LUePl4U6iKOOl03VSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PjNr9HuRu6BfU2R90Q3RkVPxwE4mW2ZU/8USB8s7utc=;
 b=teJt8OzI6yG4KG3CuFiEhNpk9NLFIQxCkM+eVMSpfMiflpXKPrs1pedat1qSFGxtc3vlBNNe7MDDsO7fVg1vj0HiqjQFB5j7gopK1dq4EcembcaFXC5xJJE/kVEiRBXP9w4spzSNpS6N+FP+Ar0AKAjrLPDwcjjfwhSSiHv9vi4coc9NSCZB7ipNSReNul9GZc/L/47TM/WREKbi2pKbtU0t4/7RPUiiu3y37OCv6N9aliaGNCnoxAW2DJLoDshly5mkndXGCX4nY70pxPcu628hK7J+KUufmsrnTha7AbOOb8Naig4xdQ8/0xbzKCkfTwNfv+W+uvoTg8oeV+reaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by IA0PR11MB8303.namprd11.prod.outlook.com (2603:10b6:208:487::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.29; Tue, 1 Jul
 2025 23:03:48 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b%4]) with mapi id 15.20.8880.027; Tue, 1 Jul 2025
 23:03:48 +0000
Message-ID: <121a34a7-518c-4f2c-8e89-c6cacd02a9df@intel.com>
Date: Tue, 1 Jul 2025 16:03:45 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv8 15/17] x86/cpu: Make LAM depend on LASS
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
References: <20250701095849.2360685-1-kirill.shutemov@linux.intel.com>
 <20250701095849.2360685-16-kirill.shutemov@linux.intel.com>
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20250701095849.2360685-16-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0039.namprd04.prod.outlook.com
 (2603:10b6:303:6a::14) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|IA0PR11MB8303:EE_
X-MS-Office365-Filtering-Correlation-Id: 16398547-45c9-4257-2339-08ddb8f389b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YWpxZ0hLZTNiOG9pUFN3dXRGN083YXpGRCt6S3dyMkM3K3VhenF4em1uNzFP?=
 =?utf-8?B?eUtON3RXL3hpYkJNdFJkcElpTFRleVloUVl1cVd6TWliRUlTWHJ0MWI5bTE2?=
 =?utf-8?B?RHBrdFFnUzh6RHY0ZGZTZGhORlEwTWo0ZThkQzI1TDBuSVlEeDBSVlFwclg3?=
 =?utf-8?B?NUplSHJZQ3BXV25nemt3QUdWaldxSkRWMEVWVC9kUVhJKzQyTEZtekNqUGdn?=
 =?utf-8?B?dGE3dWc2QTl6SjFrN0k4Zmhna1hadnQ2dldJTWV6NDlWUnNtNERSWjhnQ3NO?=
 =?utf-8?B?ZlFLUHhkUUFoK2krK2l5MS9mZ3l6WC9FczdubzlhTkJGay9oa3pkQ2hyNUxx?=
 =?utf-8?B?RmV0bDN3enVFV3REMHRQZGJPL0E5QVFEZ0NsS1RnZmlqZ1B3SXJ0QmNCb0x2?=
 =?utf-8?B?emJBS1RYNzhSUzBBN3g0VFpsRlhiZDlRb3RmTDhjQ0E0Zll0c2lNMkd0WHZn?=
 =?utf-8?B?NFRXNzNVd3pNRlNqdkZMS25sRUc4UDg0VE9md0lFUVBCY3B1MWJyR0FSMnRo?=
 =?utf-8?B?ZU1mOS9KQ0d0QU40RmtpeGlxdElITU5JbFRVYlNhMUh1UTJSWjdoaWk4MDd6?=
 =?utf-8?B?elQxbDFtajNWWTQ1S3ZqOTYzcENISEM2aFg3N0swS1BIS1AyT1Vnc3Z5UnlC?=
 =?utf-8?B?ZHFCZEErUjNRVmlOODBoc25JOVFDUFVOcnJvM0MvemVxYkFjckFmK3RlN3Zz?=
 =?utf-8?B?ZGw3Snd0Q2R0UGxvRFlXQWw2K1BWOVgwT0NmUDVYdlIrN2hZOFN2L1FxNGps?=
 =?utf-8?B?dklReGtwajh1UkRPRElTYVp2YTExRmxUbUoyNk9WUVNBUWNwc0xpWUdRMjIr?=
 =?utf-8?B?MnhDZXlsaEowS3oxRHB0NG5KQ2RuSytTMmxLMkRrcVRPVmFKejNNRVREdXJa?=
 =?utf-8?B?TGlXUmVPSnJEczRhS3V0TW5Gdmp6LzVjVkI4c2MrdFVVZG1jb0tJWnZ6SXIv?=
 =?utf-8?B?NlZEMDNKVjFrSUdQazBUMldsWVI4Ny92c1ZRaW02RUhya3ZndkFKZ1VEeWtx?=
 =?utf-8?B?QmlSQjVTUHl0VEdIMjYwZE85NDN0OTh0ckt0SGIybloreHlBalpEcW1RYmJl?=
 =?utf-8?B?eGpzY1cydjdjOEY5ODhSZlhMS3k2WC9adkpIZ21PZzBZanByMkZsTHlIL0tH?=
 =?utf-8?B?WmQ4Si9hRXR0OUZvWThEYmxyeVRtcHlPbjkwRmlwek5yQ2pEQVozRWx4ck1Q?=
 =?utf-8?B?MjB5T3lLOEt5Rzc3VVphbi9WcEJSNEdaRCtHQmFpRk0xeFIyL09Ic1dyRzVk?=
 =?utf-8?B?OUZkQzh2U041clROR3V0cjgrWGtncloxamdrd2xJMnBaS2IzRFp0WlBOcXp2?=
 =?utf-8?B?ODkrR1pJWitaTTlvN2dubUl6NGU0a3QrdTA0OTFqZkd6b1R4SEFxcysyTjhQ?=
 =?utf-8?B?TnR6dVlwMnZvMzJoN2tFNWRzZnZYV3lEUzNPRWpvL05odnRZKzJNZmxrcEpS?=
 =?utf-8?B?MXdSYTlkaGhucVlZcThtZ0xoTllMaCtXd0JJd2MvL2tyM1EybjBkQUFWeG5C?=
 =?utf-8?B?Z1pyczBycEJnU09LNWhBOE8rUjJxcWhId3lCVzcxOG1QSFV1SFNFUW0wNmN5?=
 =?utf-8?B?elJhaW9SUlhZaWs3V09uZnp6VEhqZjJ1TU9pSGhCN3kyZ1I0NEFsVUNGelFK?=
 =?utf-8?B?d1U5bmJnMkJGRGEzNDFCV2RuTk9wNHJzMEVUUzZXUkl6NktvUXgzQmRTVnFE?=
 =?utf-8?B?VkdLZUZrczFnbkdTVXloSXlUdzd3cG9MSUFRQ1NObVpldGZLU1hXV0Evanl6?=
 =?utf-8?B?aDdKdmpkYmZ3VjJXK2lRWU9nQmNaZ1ZtV1p6b2RBM0dWTHpBNUNsOGVXZ3Ix?=
 =?utf-8?B?dVdHV3I3TkpMVy9KNjA0ckV0bmtDVVFCNFU1S3ZCaTI0aHNEbE1sWjEzalVk?=
 =?utf-8?B?cW1vNlk5VGZ6RHBpeFZlU3RYaDNFd25Kb3NLbWwzRWg0dGc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MllNSkFQdk0xODBTZ2F6T0pweDRmUEp6ZXVCWE9VWUQvaW0xTnY1YktVUTE2?=
 =?utf-8?B?RUNpUEpnL1QrRmh2cjU1b0xwQm0wVHFZUFhiYXEzdWNIM2IzK1R3UWo3ZVB4?=
 =?utf-8?B?Q3lnVkh3aGZvU3JrOVFpRjFlVnpYY2pCdURFYTNsZXBQUWNxTFZvUElXamV0?=
 =?utf-8?B?NEcvMVVOUWRES1VuVFZuMXVMaUJKbzRSQnhWeUc0WFpHSXNlVm1HZ0Nic0xn?=
 =?utf-8?B?dGtteUFnblZuSEpiejE5Smx6dDBKWU9Tb0tIb0JrZUNqbG5xbHlPWEtoOHdO?=
 =?utf-8?B?UWZRMXRKK1d6WU8wQ2s5cytMTnhqUnRKY0xNSXVHaDJpTkVNUXdBYUNFZ1lt?=
 =?utf-8?B?Mzk5N3ZwN2JVMHZZelg0UFJRZ2E3Y0pkeUFyeGZaY0RmaEUyN1RmUE5kVUVs?=
 =?utf-8?B?VzlnaTl4MnRLa0NxdmM3dmNOdGY3cWxoNDVQb1RmYzc0Q0VrY2tHbTNpeHl2?=
 =?utf-8?B?ditWdlZsTmxwVkcwSUhtQUEvaUlMR01jTlJ2YUFORy9rUGtBWXo2bHN5eFhO?=
 =?utf-8?B?bm5zNGtkcDgyUStjV2I4ajFhQXVvZnBELzRaNnUrUDN6Mi9Sb0tIMm54bEpO?=
 =?utf-8?B?aGVXL0JCOFF1S3lFY3J3cWRIRUYwMzJ1V2o1a0tjK0RTOHB6ek42UlI5VU43?=
 =?utf-8?B?bEpQN3ZPQ1MvTGNKb3dwdlkzU25XaDN1bUhRTnVYSnl1cjNjNlNGUy9xbmdO?=
 =?utf-8?B?Y25ieG5Ma095NUIrTXkzN0E3bVRoc0VRZjB4ZjEvbTNuVFBYUmZKQ0lmdjRk?=
 =?utf-8?B?RkZTOThLK05RNWt0RXd1N1QzYXBzV0dCbG41MnlaQ3ZERklsTGJHYVVPZHU5?=
 =?utf-8?B?WVVDUkVnY1hsR1hRSnpUb3VLTmZRMml4K25NdFNweVA2eExtUXZWSVdUbFA1?=
 =?utf-8?B?UHh6bXFvWXZFRmJhSERWaUZ1OHVLZmhRczJZZHJEQ1YwM29BYVhmc0hPUFpM?=
 =?utf-8?B?Mmd3YXkrOFJadFdlYVdBK0MxR1FiZlUrdS9UWERPUzdKQ2pJMDhlMk4zUDBx?=
 =?utf-8?B?dFZtZis3VnpWRWhXeXJOVkVFeHFaUGNpVStLLzVjM2tDN3dFSEFDVS9FTEhh?=
 =?utf-8?B?Nm1yQzRXS3ZmY2hQWmd6citabGdkUUlEVkVmUXVWcGFnK25Kd29tTTVvczVQ?=
 =?utf-8?B?bmJlUFBKTFFXNVUveTRRaU90UnhkNXBvS004VytUK285VDRxdEFFT0h3TjJi?=
 =?utf-8?B?U0M1dFljOHFqWHBLR2FBbW85SFF3elk2Q0hwUldScGtBNDVCWTdsNUlTQ0sr?=
 =?utf-8?B?QzlVMXJ5QTZLTGFSRTMyRy9OL2lFUFJ1Z2tFamtBekwvZ2ZQWitranhtN2Ri?=
 =?utf-8?B?NE02S2xmT1dEWE1OM2wrbkdPR1llc1V4MHNHZTNQRVhUYnlnc2VOQWNPbDVr?=
 =?utf-8?B?ZWhmUTJEQjdNK2MrUVVKUzV5WUZ0YUgvMThBdFBSUWFDTHoxRGJDV3hJRHQ0?=
 =?utf-8?B?NithYjdDQ1psZEVCQTdYME55T1RXVWlkSDgrbnhwUzM0UEE0Rjc4dDZwNW56?=
 =?utf-8?B?SlFhcjVpMnpNRGlLa2hGanNKUllKWVYyTkh0dzVXTUFWVi8yK3VnQWF1dThP?=
 =?utf-8?B?cExjMkFCRE9aUlZXZlpKRVFtUmFSTXNxQU1xb1BEOEJucitKMGsxRS9UQWFG?=
 =?utf-8?B?dGVQZlZ2MlhsQjFaWWxieEJWdHU1ckh4c2FZVDBlaThsNUxuTW84RTB5UUxE?=
 =?utf-8?B?M2RpNHo1cGk5R2lMTGVxYmFRSDhWWXpHTnhTWEpiZ1ZYclN5ZUpEdEZrUzNY?=
 =?utf-8?B?RmIyekg2QTBiK3pqMHE3b0xVUEFCb1RxeFJFVFZadU45M0tSMG9BZytNNE5Q?=
 =?utf-8?B?VHhZMmtzRjFtc3I5a1NuejcyaU1ITmliaE0vUWpTZXZBNUFQOUtkZzRUMWhJ?=
 =?utf-8?B?aW1zN2tab2w2cSt1dms1UDdXdzI0V2ZOVzFNQUNBOXNxRGdvV0Y0dVNsSGRr?=
 =?utf-8?B?SFhHZDFDU3RyMUpYRWo1R2pLOEtnanZBdHBkK1l5bWVnejdHSjZKN1lNeld0?=
 =?utf-8?B?WVpYajlUMFhwQnVPUWdwVFVDaHlTdXhLZ2RlbFhJQVpmREUrdUt6bjRwTHV6?=
 =?utf-8?B?TFVudlZiV25LeG9nL2VXSjVXNnNJRkdlTUJ3SUdWN3lHUzYxY2MrcXNObFBO?=
 =?utf-8?Q?Jajd1w5AYNHbgz5iXIfY4ND4R?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 16398547-45c9-4257-2339-08ddb8f389b8
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 23:03:48.5004
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rignbYVxgZbUaJxtAZ99Iolw9BfSpZuShiylIqvq+8Q5ewuKq7nwgVhQFD3LHYIy1FCeSKYoSx4cwrAP68NiPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB8303
X-OriginatorOrg: intel.com

On 7/1/2025 2:58 AM, Kirill A. Shutemov wrote:
> From: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> 
> To prevent exploits for Spectre based on LAM as demonstrated by the
> whitepaper [1], make LAM depend on LASS, which avoids this type of
> vulnerability.
> 
> [1] https://download.vusec.net/papers/slam_sp24.pdf
> 
> Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> ---
>  arch/x86/kernel/cpu/cpuid-deps.c | 1 +
>  1 file changed, 1 insertion(+)
> 

In terms of patch ordering, wouldn't it make more sense to introduce LAM
related changes after LASS has been fully enabled? This patch should
probably be after Patch #16 which enables LASS.

Logically, the LAM re-enabling stuff can be a separate series, but since
it's only a few changed lines having it at the end seems okay.

Patch 1-15  => Enable LASS
Patch 16-17 => Re-enable LAM

Other than that,

Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>

> diff --git a/arch/x86/kernel/cpu/cpuid-deps.c b/arch/x86/kernel/cpu/cpuid-deps.c
> index 98d0cdd82574..11bb9ed40140 100644
> --- a/arch/x86/kernel/cpu/cpuid-deps.c
> +++ b/arch/x86/kernel/cpu/cpuid-deps.c
> @@ -90,6 +90,7 @@ static const struct cpuid_dep cpuid_deps[] = {
>  	{ X86_FEATURE_FRED,			X86_FEATURE_LKGS      },
>  	{ X86_FEATURE_SPEC_CTRL_SSBD,		X86_FEATURE_SPEC_CTRL },
>  	{ X86_FEATURE_LASS,			X86_FEATURE_SMAP      },
> +	{ X86_FEATURE_LAM,			X86_FEATURE_LASS      },
>  	{}
>  };
>  


