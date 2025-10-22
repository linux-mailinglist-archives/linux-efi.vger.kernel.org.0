Return-Path: <linux-efi+bounces-5086-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 53512BFE17C
	for <lists+linux-efi@lfdr.de>; Wed, 22 Oct 2025 21:50:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 873E14E7FE1
	for <lists+linux-efi@lfdr.de>; Wed, 22 Oct 2025 19:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E0ED2EC0BF;
	Wed, 22 Oct 2025 19:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TXqAUAGb"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4AAC2F0678;
	Wed, 22 Oct 2025 19:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761162592; cv=fail; b=Ck0f08eP7mHQmJ5kyU8glKD9hpdzxXCbSbQQgCxu27Ruoqt4rfNQFyfvJ2HopT6IO4N9VA48KqyYfdWP491vt/urBvusF9Lz7fT0LY4BNXLdHV20OImuuM7wLK7EudqmUZ/7eF6mUs7yoq+IjLrHOy732DZcOZTBTCKB7wbAv/8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761162592; c=relaxed/simple;
	bh=CXYAN8vSH9/ofLS4EyAciysX7oJ+2WvL6wUPKttb18s=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=f8fAVnWIX/pt1bPKvWphoWasMmrFTCIbUh9e6epO6bUZuQCNzA7nxcwK50t8KJUYLmF4R12ggGPJBKbCkK0DXcMX86kOlKMBgygHIE330el6lwuVxwtGEVBMJfyoqspL1wpIj5lRCOz6l5mOJSUo2asA8kWbm8gPiE+PT3LH9gU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TXqAUAGb; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761162590; x=1792698590;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=CXYAN8vSH9/ofLS4EyAciysX7oJ+2WvL6wUPKttb18s=;
  b=TXqAUAGbQng84wu77ZleUSEZTP4+oNDUrHvsZXjAJturse6XpWqTSqvm
   CSp9kgVQkpgVZYQAebBCgw/Msrbqr3Je/ipPETU7SmgbHf0ost6nOM2BL
   OYi5QnmGYa885jHSf/v2CzLqdn51wS6ssZfiRQhIw3MJqeEl+K2rqyJ4u
   koEBc8OSdkhW/56pgMPFNOgUewzXW8h09zF6TEMiKHM6CjPkV16eK82sI
   H/qNb3f+St8tVxkaDZZ2LzUivJsNxTdNkEDIduEzCfHoc4ZRcBTg5fnYl
   QcXeGC36rsTDRKqx89iOnPsH8n3sb4eqJwEKsLhRr8IOYv/WQ230wtNJ+
   A==;
X-CSE-ConnectionGUID: qAHc7yJPTF+XMLmD4eCR9w==
X-CSE-MsgGUID: FHFKWWNJQcuyFdUz8zFGVg==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="65939155"
X-IronPort-AV: E=Sophos;i="6.19,247,1754982000"; 
   d="scan'208";a="65939155"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2025 12:49:49 -0700
X-CSE-ConnectionGUID: fW6OiHk5SKuLt8U/rK7S+w==
X-CSE-MsgGUID: Sir31FNSTqKwUb+I2reRSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,247,1754982000"; 
   d="scan'208";a="188245893"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2025 12:49:49 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 22 Oct 2025 12:49:48 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 22 Oct 2025 12:49:48 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.21) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 22 Oct 2025 12:49:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YaJ0S/VVWXmrdWdRWivi/CPySXah6kXuzYXjjMn28bF1DBWy+G8rPiQUljDPsx34y7v3F4/JMwiSW4pSyzSeoXxC+ILgdQ/Pih3qTMSMp/ZQmfcUs8QP9+OUuBNI3akauJu5SkjyV2+eXUS8o4SLv96GbCoRIn+ylUlyAfBhWKYQdJlPSLpF3x67Zibagx0ntxwk+zKFcLYnAr0ES4cCuhB6gUusv55rrSlhgpZrshnaBp4aarLOxLPcsNTEQnEYCnqnViOWzCeMJSyMAQv6mzQ1PcEXrGNw/el9z0DPs87fs5Q1vHoNmj22XBBo7mtLtDwxW3PwtFi5CKBtTe9/tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CD41JXUKVkwY87Rj7PNEZoAEPV3eVlDy+Wa0otT9NZo=;
 b=tf7GkJ2jq5sbxY3nwkJMUlEUGP9WC+LCKskOV+q5rK5x686rOHiYaL16bU6BxWaSSF4TRfllnnSXkRdO8qbZcaJTNMJR+nM/riWLAFpa2GZ8s0WYYeD1DbISnub7YrzGKphSU9bLUFN6Tjt1Sh1cSJBKcxAV/CpqX9BbYZkAE07MUVN5LdRl7Um3O/6jhqMBfijQ66a41T0iAOIezHdUWj2phoYHEXqJyEjY0SwDe1MBk3fptp1/5rjpGWPs5muJp+LTJTBsKD3Cq32luEoavPLH7X1jfIS2QJfDnpofVSprvH/vnp5moxsCDbuvfNa9jkerUCH+LHXGcan5TJfsWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7997.namprd11.prod.outlook.com (2603:10b6:8:125::14)
 by IA4PR11MB9231.namprd11.prod.outlook.com (2603:10b6:208:560::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Wed, 22 Oct
 2025 19:49:45 +0000
Received: from DS0PR11MB7997.namprd11.prod.outlook.com
 ([fe80::9105:2b7c:b256:7a6c]) by DS0PR11MB7997.namprd11.prod.outlook.com
 ([fe80::9105:2b7c:b256:7a6c%7]) with mapi id 15.20.9253.011; Wed, 22 Oct 2025
 19:49:45 +0000
Message-ID: <34d91e30-9a94-4bbb-9a57-3679afbede2e@intel.com>
Date: Wed, 22 Oct 2025 12:49:42 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 03/15] x86/alternatives: Disable LASS when patching
 kernel alternatives
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
 <20251007065119.148605-4-sohil.mehta@intel.com>
 <20251021200328.GMaPfnEDibnBrhNTmQ@fat_crate.local>
 <144029e3-30ea-4e94-9afd-4da53ce4a657@intel.com>
 <20251022095657.GBaPiqaYxPMonQWLtw@fat_crate.local>
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20251022095657.GBaPiqaYxPMonQWLtw@fat_crate.local>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY1P220CA0004.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59d::15) To DS0PR11MB7997.namprd11.prod.outlook.com
 (2603:10b6:8:125::14)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7997:EE_|IA4PR11MB9231:EE_
X-MS-Office365-Filtering-Correlation-Id: bd6e2afb-2fd0-46c1-8a94-08de11a4266f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZStqZk91ZDdBTUtQU2VBTnRoS3luWHFqUmQwNk1HeWpOTVVST0dyd1E1MWlM?=
 =?utf-8?B?Qk1BYm1YT0FCemt4N2ZwZUJWOUx3SndkQzVMTk1LMmhyY082bTQ5dXRhQWNI?=
 =?utf-8?B?b0hOWTZlMHNOb0ZZOXloMWdWaVZnbVBxQ1dlc3RVUDljanhMc1E1M0VOVHIx?=
 =?utf-8?B?RGJodnVjRTZGYnE3TTNGeXFWa3JudUsra2cyT09tV2dVTmlKVUtGbStoOFIr?=
 =?utf-8?B?Q1JuS3NvWGpRemZuZXRubnVaNTNEazJXbHYwQlZsYXhrTU9mNW5HaExReWls?=
 =?utf-8?B?QmhWWGk4bnJVQlBsakpoT0V2cTRBbFk5Tkl4eTNSS1RjR0tpWjVGZ29PWlh1?=
 =?utf-8?B?aFkydTZOSlpOaUtyZmpuMWxDQUtHWU9vM2VKelhNajU2dHl6UHNmaHFNODBz?=
 =?utf-8?B?bklOTW1MV1MrOUZheXpsdnhCdnROR0w4UzZSZFAwVWNMNk9NL2t1U0Q3WDBw?=
 =?utf-8?B?eXZjcUUzelNDMGVJMHRNdzY4eW9YeG1mR0RKYVA2NEFkV3IwZzVLLzlvaTdU?=
 =?utf-8?B?SFBEazljc1o5WDdTd0xxUjZscjRSN05iZTlWRGJsOWN2Wm1lb1g1cWhYQUNU?=
 =?utf-8?B?VGdSSG1hb09jVy93U3kvb1dRV01ucWpnamJRUUVzSEVjaDFVSVZZanlDd1pB?=
 =?utf-8?B?c0x3RnYzSDFkMnFDSkxmZ2pOT29Hb0ZXa3VpTTRqelUvaTJkMEdPQndCd3Mz?=
 =?utf-8?B?NVNkYmxtMmU5dXI0MmRXNVNQYTN6U0tkVmdhZkZRV0lmNXYrNTFOT2VlTHhh?=
 =?utf-8?B?dGxldHZRSlpDdVFPYjNRbDhBZ0daMzc5YUJzN2Q3aEZqdG1BNTBpOU9RSTRr?=
 =?utf-8?B?VEVOdnFQb2NlaUVCd0NGbVpUVGlRSVRYWnd2dzRWNVVtWTYyWlNuZFZhZzJJ?=
 =?utf-8?B?WFVrZjlaeG5UYWpoMHN5Unl6OWxJS1FrQUhqWDZLcU9QZFJ2d21iTnhZT1JU?=
 =?utf-8?B?U0dQUGxydVBsY096UWtnd1VGZDNuMHBwSVZFVGtOaGROOEpHTjNVK0xaT3VY?=
 =?utf-8?B?dEQyZXRIbmJTNGJNbVB3RjZNVlNkQUpWQWVlOHd3OUNEdVMwUE5LOFJrczJX?=
 =?utf-8?B?aDBhbVhlYlFNSjdYYWxNU3QyMU14aHYwL0cyVHZtU3NrY1ZLbzVmR2c2MjE1?=
 =?utf-8?B?TEt2YnQxa1c3bldCTURieTBQU1JwLzhEdTF6U2ZYRmtwTE9LeUtVNHlGQ3pD?=
 =?utf-8?B?azlObXZCajkwMWFUVVdRQ0hzYmJ5UGRjanJTVURqUWZjTjZrMkwyc0R6bnBX?=
 =?utf-8?B?UmsrREZTUktDYWVxN1dueEpuWkhIY3V6b1RiRHU4ZUh2UHg2QWtsZ3pzaTMy?=
 =?utf-8?B?YWVLRWw3SC9uNU44cW9yc3NTUWJaeDZ2YTFBb09OK2l2YU0yVjNROVNkdld4?=
 =?utf-8?B?R3hXbnNSZ2JJOFU3UEJWbHBpZTlLT3ptZUl5OHIwRXorRnZzZzhFNXBxVkw3?=
 =?utf-8?B?cGVSVmlWWU9JODF5NmwrVTYzTDB3OUlVZ0xqVlV3RS85Ulg3TkpEdkNmbWRo?=
 =?utf-8?B?NXZIMnNUUEw5UjFPZ2ZmcDBFVDhVMFpJY2lENVN6OVNLeXUzQ0VrRnZBdTBp?=
 =?utf-8?B?WG1hMXl2Q0ZleHNQVVhFWW5oYTAyUzBFVW16OXZPcWdMQmNHVDI5ZkdSU1h5?=
 =?utf-8?B?ZTUxQjlNeVZFd2R2V1cyUC9FRU9iN3R6RDFZSkRUdXY2aUV2RU9wWHZXazF2?=
 =?utf-8?B?VkhxMklPQVhSbVdrbTZiRFZNSDc2eTlka1JyYXNDT1F2OXdDU2oyWWVkVXQr?=
 =?utf-8?B?OHQyeTYxamppeE9IYjJMdmxhcXdraStsU0QzTWFQTDVKOEZmUTNjUElnR0JY?=
 =?utf-8?B?ejJTdE9vQ3B6QWExeGl1ZHVUNnRmSWZRSGJZMDZSajQ2N2gzVWZ6cHFYSnY1?=
 =?utf-8?B?eEF3NC9GbjltNnhxbjFqczBKV25CUk8xVTdyKy95ekpMK3h1ZktoaEZUcFdw?=
 =?utf-8?Q?JGVGOw2pDONhZqwgs3AtHxZwc7EwJ9nV?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7997.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bzlwd0tIWDZzVGtwanZWQVFqUDRxU0lhMkU3YkdsOEpjOUo3Yk9aRFEveEN5?=
 =?utf-8?B?aXBVQ0NZeGlaQTkySitMcFFLL0FtRkdzb2xJWERZQ1lxRVRPdmhWSkpmUGlr?=
 =?utf-8?B?OExSaVJudXZHdlFvdVFLdkdEamswSjVmNk1uNytUWHZzWFBnaHJHOCtXbzFR?=
 =?utf-8?B?ZzhjMDVBRzBwa3RBMWpNeGRGZjRpblBaWEozZ3BCQ1FWZWlJa21LcDR2a0Vu?=
 =?utf-8?B?NUcxZ3plUitYZHozUE5uYTFaczFDUjN3U2gycldIZG1CQi93NUZOZGtvUTl1?=
 =?utf-8?B?dUFSWEYvSW5YdW5CWWh6MGxnYVp2c2NxSlI4Q3VRR1BMOU5mYk5HSUNFTTNT?=
 =?utf-8?B?WktLeG55QjExdnAzbGZ3RjZKbnVweCtYazZBNVRnS1A1bGxBK29jNnNENi9K?=
 =?utf-8?B?TkN0TnE5TTVocUg5bG5KaWtKa29MQWJtWXAvS1F3dzFINmpFWUxmUW5XNjJp?=
 =?utf-8?B?dzFSS1k1S3pma04vNDVBZFBBN2NZcEdyZ3Z5TjF4dmRpS3QyS1FidGZya3FZ?=
 =?utf-8?B?MHVJRjRRb1RYUnlwUUZJTHp1V20zWUVsNThmMUZTbWVHNngrenpNbDJxMEc1?=
 =?utf-8?B?RGxCMGVZSE5FT1Bmc3VqclhYTU9CWm1PSGJFa2VVWmsrczJoLzZMbnZjVEdB?=
 =?utf-8?B?LzNQc0doL01WdFhrL0JmVURnbDdsd285N3N2UjEzeHI1dVc2NVV6dXRDZUVM?=
 =?utf-8?B?WGtQQm0wcTZOTDR3NDRiOXFEOWdVNjRiOEFvdEdUY0N3SFIxdXhzbmk2ZCtX?=
 =?utf-8?B?aTUrL1A4bHBzNE5BMGpwdlphOUwvcDZpOWQ0dytNZ1VUd0w5NWgxcVZsenVF?=
 =?utf-8?B?cnZDNUhPaFpkRFBkUXBybkx5cTdZbG9FU2hGS1pidDkxOE1pZkJNeE5SWGJy?=
 =?utf-8?B?M0YxZ1Mra3dhWFhWcDZLU2pJQ1JQM1I4VFpxUzV4bE1URnVLMnQ3cU9FaVJw?=
 =?utf-8?B?Zjd3MjdydUkwdXcxVmN5RE4vRm9vbDNUQnFQNk1vd0pwVjg3RkJoUFMxRytH?=
 =?utf-8?B?L1N3SHVoOENySEFzWFU0SUFTVDd2K2cxeitpaXl0MHJlZkpVR1ZFand6eFpt?=
 =?utf-8?B?SzFIY2E4alJoUTJQczFJVUZWOXlJYytrUmg3L2FVeTFyVWZTK3dJT3FyWEU4?=
 =?utf-8?B?RENDZGJEUWRFcUJmeUJkS3paNU1jdmV2MXgwNml6RTF3NzlLSEcwTTBuK24x?=
 =?utf-8?B?c0NPczJ2ZnFWaXlhc3JzNHdkbmZzSFNsWW9BWjliWGNpUFkvand1S3pRdWZJ?=
 =?utf-8?B?MjRtNWRuWFRRUjU2Y25WOVdQQ3RRVWU0TTZIcmNYS0YyemY4c2JTZk9RSi9O?=
 =?utf-8?B?L3RLMXIvTEc5Vy8raVVSejcrb2ZCSlBCd3l3ZVdVdUs4d3BJS1U4MkFud1A1?=
 =?utf-8?B?RVZGa2dNSnp6T3BVR1BHcitaNVpIdFM3N1pPQm1jSFZaS1hpTWpPdXB0Y0ht?=
 =?utf-8?B?MWY3ek9JSmxyOFZ4THZaQkh6MVpveGRlbjVJeEM2ZmtrNy91Zll3SlNaWjAr?=
 =?utf-8?B?WERVUVliRmt4d2N5MDgvclkrb3YyR0NHOUtSSWZNRDFzd2FxRndRbENDWGg5?=
 =?utf-8?B?bGxNM24yMitYYXNFa1IrMlNPdE04ZGlITXErRTJpTkFCanVNLzJISHBDcnlX?=
 =?utf-8?B?SW5US2RHWmJmd3hlNitRM25GMEZkTFBsVWR6bXlKR0FjZUNlVEVGMFo2elRj?=
 =?utf-8?B?T083RE5rb3BScDlmc29LZlp4MW45QmRLSXZESU52SzdWUFhySWl6WFpud0Y0?=
 =?utf-8?B?dWZQaUlYMjd4U3R3aE9BM0xFN2VaNHBGNDRFN2wzSEhPMkhpemFJN2R1ckEy?=
 =?utf-8?B?VFBobEhpeEYwbzNRSDkrL2JhMFA5SVRqZ3ZaYkRpUWc4T2pJVWsvVVFVK3Ft?=
 =?utf-8?B?VEdPS3o2UkdpZjdjZUZxT1RTV0FDODBlcEtHWXNMOG9aY2JOK0haNDZqVXJ6?=
 =?utf-8?B?UzhmZkxOWUlGeGpkZFVoc3lwNno5VHVabWVwcWx5QTk1ZWNqVGROU1pTekJH?=
 =?utf-8?B?SU1NOVRxdnBySnpDbGZRalVMVjJYZHIyYVNZc0dwY09uczRMb25wL1Z3MzU4?=
 =?utf-8?B?amRZQzk3VHdJWVlxQlJEMDVKUUgvaHA0OWZUTGNtcmE5SlhvT3dYQWx5S202?=
 =?utf-8?Q?4RkP34oHrl42lWYClkrSaVP39?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bd6e2afb-2fd0-46c1-8a94-08de11a4266f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7997.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 19:49:45.2702
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q7er8rAwbMU/aFsLR5YIy/ZTw9/P3rcrhH+XfzvIv7xaKQYQGmPxwj2lMw0Xvw/6VqB/FtpJawsUn0nBf19SBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB9231
X-OriginatorOrg: intel.com

On 10/22/2025 2:56 AM, Borislav Petkov wrote:
> On Tue, Oct 21, 2025 at 01:55:51PM -0700, Sohil Mehta wrote:
>> In the series, we directly write to the CR4 bits, so they don't have any
>> wrappers. But in the future, lass_enable()/lass_disable() could be
>> confusing if wrappers were added for the CR4 toggling.
> 
> Are you envisioning to export the CR4.LASS toggling to users like those two or
> is former going to be done only at those two places?
> 
> Because CR4 toggling is expensive so you probably don't want to do that very
> often.
> 

I agree. My expectation is that those won't grow much beyond the
existing ones.

My understanding from your discussion with PeterZ is that we would use
lass_enable()/_disable() with the LASS alternatives but leave the
existing stac()/clac() as-is.

Below is the updated patch with the rename and the text to clarify usages.

diff --git a/arch/x86/include/asm/smap.h b/arch/x86/include/asm/smap.h
index 4f84d421d1cf..4f4a4e0efff5 100644
--- a/arch/x86/include/asm/smap.h
+++ b/arch/x86/include/asm/smap.h
@@ -23,18 +23,52 @@

 #else /* __ASSEMBLER__ */

+/*
+ * The CLAC/STAC instructions toggle the enforcement of
+ * X86_FEATURE_SMAP along with X86_FEATURE_LASS.
+ *
+ * SMAP enforcement is based on the _PAGE_BIT_USER bit in the page
+ * tables. The kernel is not allowed to touch pages with the bit set
+ * unless the AC bit is set.
+ *
+ * Use stac()/clac() when accessing userspace (_PAGE_USER) mappings,
+ * regardless of location.
+ *
+ * Note: a barrier is implicit in alternative().
+ */
+
 static __always_inline void clac(void)
 {
-	/* Note: a barrier is implicit in alternative() */
 	alternative("", "clac", X86_FEATURE_SMAP);
 }

 static __always_inline void stac(void)
 {
-	/* Note: a barrier is implicit in alternative() */
 	alternative("", "stac", X86_FEATURE_SMAP);
 }

+/*
+ * LASS enforcement is based on bit 63 of the virtual address. The
+ * kernel is not allowed to touch memory in the lower half of the
+ * virtual address space unless the AC bit is set.
+ *
+ * Use lass_disable()/lass_enable() when accessing kernel (!_PAGE_USER)
+ * mappings in the lower half of the address space that are blocked by
+ * LASS, but not by SMAP.
+ *
+ * Note: a barrier is implicit in alternative().
+ */
+
+static __always_inline void lass_enable(void)
+{
+	alternative("", "clac", X86_FEATURE_LASS);
+}
+
+static __always_inline void lass_disable(void)
+{
+	alternative("", "stac", X86_FEATURE_LASS);
+}
+
 static __always_inline unsigned long smap_save(void)
 {
 	unsigned long flags;
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 8ee5ff547357..b38dbf08d5cd 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -2469,16 +2469,30 @@ void __init_or_module text_poke_early(void
*addr, const void *opcode,
 __ro_after_init struct mm_struct *text_poke_mm;
 __ro_after_init unsigned long text_poke_mm_addr;

+/*
+ * Text poking creates and uses a mapping in the lower half of the
+ * address space. Relax LASS enforcement when accessing the poking
+ * address.
+ *
+ * objtool enforces a strict policy of "no function calls within AC=1
+ * regions". Adhere to the policy by using inline versions of
+ * memcpy()/memset() that will never result in a function call.
+ */
+
 static void text_poke_memcpy(void *dst, const void *src, size_t len)
 {
-	memcpy(dst, src, len);
+	lass_disable();
+	__inline_memcpy(dst, src, len);
+	lass_enable();
 }

 static void text_poke_memset(void *dst, const void *src, size_t len)
 {
 	int c = *(const int *)src;

-	memset(dst, c, len);
+	lass_disable();
+	__inline_memset(dst, c, len);
+	lass_enable();
 }

 typedef void text_poke_f(void *dst, const void *src, size_t len);


