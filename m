Return-Path: <linux-efi+bounces-991-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C998C8B42D4
	for <lists+linux-efi@lfdr.de>; Sat, 27 Apr 2024 01:50:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6BBB1C22845
	for <lists+linux-efi@lfdr.de>; Fri, 26 Apr 2024 23:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5615B3BBDC;
	Fri, 26 Apr 2024 23:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SaBbJhmS"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED473A1B9;
	Fri, 26 Apr 2024 23:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714175419; cv=fail; b=FOeo7xegA+4vWBEwMvjrrgkpezHwFtkXaooq9j4TjcUoNQV0NxO7gclqDpT1s9nIt62mw9dgUddM7232swdMlTb2g0w0Im5z+RnJGO1bMIMNqGF3NBQglg80euuPTIahm2t9i2KLDhiyh3Rt3IvQ8jfqtbMdv/ecR0+SgbN5CiI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714175419; c=relaxed/simple;
	bh=a55KtndMMqSn9sEB2Cb1jLpzO4BubWn7rD3G9DVUjLI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FtBIIbZfBDDGu7fDeO0IQBmYL4HHonV10fYpJv9sxDNTGYpA4HLVqoBFCfLW2YQh21MruyQ/J4l/WRl5Vwt6DpbkAPEQa9tjjOfo3gUwzh8x3ofRpRA/Be8ZvMAJ7i+sYiHZtTNK6CDUi3leH5fwTaqOVzJDcRA93mGtVy4NGgc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SaBbJhmS; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714175417; x=1745711417;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=a55KtndMMqSn9sEB2Cb1jLpzO4BubWn7rD3G9DVUjLI=;
  b=SaBbJhmSiz62a02UOjlOGnid5OUHYNp+aBABcfRSLjv2pNK9nby84f2x
   Tk2ONawvztwWn46XaB9imz836MGyPJElJcXTU293acc8dD0sRYjgKG5kJ
   H5Ez3EG2V0yKhlNzJmBTXIUKcIPsWCVfkW/nPdWEe/pziI7v7qsgxpYdP
   5DYOotfEvwdRkcmCmNkb26XzsKkH2Hff9V41mKMgIAfLUPs3uhm0jfDPM
   lRu3Az4m5QvaDX2ndWokiMDjkJEo6fg9NkPuWmpJyXHeXW3Ap6OZigC4v
   wbRbMdjWkjaZq0OQkHRZFEWpLKQyZIwt7b+6dmSOL2nSbZILFFHwq5FAZ
   A==;
X-CSE-ConnectionGUID: aK+VGM7aQ2+Qmg2oOaaI0w==
X-CSE-MsgGUID: NINEXn41QUWDkm+bQWSSpA==
X-IronPort-AV: E=McAfee;i="6600,9927,11056"; a="9757129"
X-IronPort-AV: E=Sophos;i="6.07,234,1708416000"; 
   d="scan'208";a="9757129"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2024 16:50:16 -0700
X-CSE-ConnectionGUID: grqaGWo5RwqMmOGf43oOpA==
X-CSE-MsgGUID: CyuGgfKGR1S8TErG4M/aNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,234,1708416000"; 
   d="scan'208";a="56481851"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Apr 2024 16:50:16 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 26 Apr 2024 16:50:15 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 26 Apr 2024 16:50:15 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 26 Apr 2024 16:50:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V8ij1QXaec29rWyBZxqSrIGm7/2Uagc81YWGwfSGK//AvcWBp+Py5OVuWQ+WfVj6KXypQ3d6/8NGtkXMnNVBXYpgco6opHYi1S2QDVfD8Wt42/GfT+XOI1DCW4xBRcbPdkjpJ/V8T1c9XfCJJEI/9mBVbttO+CWJoVvWfYfOsJIEJOMQ3nFT7NdNyDD8h0dOZbRpAx5G+LtJfbcKkL1fuIgJoQEdlEsoXqLunu6PwNmz+sL+943XtpkRhXFRm+f62LdqGWaPiZcLsq0hnN4WAQADcMdgNvAdoZz59SXAKE/BQfj0yLiYhoJOfVXroKjkJK0MUi00ses/JibEJo97Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ODBSDVgVm0b3BVZSzn0cxsv/g+GsWnyxQKUGPFUBFK8=;
 b=W3/MaCJEw97tjWM3PuyDEev1c6Pv43g6F3JzR7iee6NVdsA+eZSTr9/jNvOJtWBR9njX+MUPfviYV+A9r2AHqfeTU08TL58t9pgnslE/rjV+fZiCErz2FA2FLxbsCRcKBnySDhy52a9OLYrNIae6gf1kx2X2o4VUIuMOCsANYPjWH0u+NEdeFrU6uYRXPCQj/PYyJ8ciCU6MZfqbaRX90mx0VyB4MNqqBPWOyRym4yCssq39Dn2LXvpkEKvwE+/UZ4DFP6IkPumZVzoncxXqPKvx7b/vzKmB/Rp36iRB0dtweEnj1Buddty4YIO3Wy/+npHTyWjttytKCluNvvKQTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA0PR11MB4573.namprd11.prod.outlook.com (2603:10b6:806:98::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.31; Fri, 26 Apr
 2024 23:50:13 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71%4]) with mapi id 15.20.7452.046; Fri, 26 Apr 2024
 23:50:13 +0000
Date: Fri, 26 Apr 2024 16:50:09 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Ira Weiny <ira.weiny@intel.com>, Dave Jiang <dave.jiang@intel.com>, "Dan
 Williams" <dan.j.williams@intel.com>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Smita Koralahalli
	<Smita.KoralahalliChannabasappa@amd.com>, Shiju Jose <shiju.jose@huawei.com>
CC: Dan Carpenter <dan.carpenter@linaro.org>, Yazen Ghannam
	<yazen.ghannam@amd.com>, Davidlohr Bueso <dave@stgolabs.net>, "Alison
 Schofield" <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ard Biesheuvel <ardb@kernel.org>,
	<linux-efi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, Ira Weiny <ira.weiny@intel.com>, "Rafael J.
 Wysocki" <rafael@kernel.org>, Tony Luck <tony.luck@intel.com>, "Borislav
 Petkov" <bp@alien8.de>
Subject: Re: [PATCH v3 1/2] acpi/ghes: Process CXL Component Events
Message-ID: <662c3db180909_b6e02942e@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20240426-cxl-cper3-v3-0-6ade7dfc849e@intel.com>
 <20240426-cxl-cper3-v3-1-6ade7dfc849e@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240426-cxl-cper3-v3-1-6ade7dfc849e@intel.com>
X-ClientProxiedBy: MW4PR03CA0140.namprd03.prod.outlook.com
 (2603:10b6:303:8c::25) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA0PR11MB4573:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b4310b7-48dc-469b-ab22-08dc664b9d65
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015|7416005;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?y8+157RUMMw7r6jAQAmGn9Yp4bU/bBFwNg9HRv6OJSQS+n5hL1aXcdkbZdGw?=
 =?us-ascii?Q?Gi8tVdvoA1VLXDea9ClzfPF+iX1P0fEq8Vl6ld02Ba5XCceUPtiVnlXVYE1o?=
 =?us-ascii?Q?c2fUFSKh2TNoOKQTTMhg/9O6l+6b8Rjp3bowZzFIqj6HIrZkgdM6/JE5e2D0?=
 =?us-ascii?Q?uYc6aP4oq/+SastW50A4U4w4Ts13qDGLv9SJVWn4pLKWIupq+t3EYMwjbdSR?=
 =?us-ascii?Q?1VR24tV2v4SZK0hdfVwkdN48oXVTa1kkRVg29xEOsBsw5JbjjrIjJ3cEdpn3?=
 =?us-ascii?Q?7X5o5ruab4pRh3/ZDRIPQllluBdgsGM3Ltz7Mhvqwy6l0etlAv941A1UdB2K?=
 =?us-ascii?Q?lFmAs2AuT3ejawVl6r7bkMurR6RierIVsV+ItYx3LQia4xFvAr/dS0eAyH1m?=
 =?us-ascii?Q?pifYUuaRhHLK/miBKPauX9l2ri8upGG1IR5wSfDe7FAL67TOLsE1hgO0EnRR?=
 =?us-ascii?Q?WHWL/a4wX4oRJW5Km1zQL71jHIwEegBy5VzONojKNZUSFMOslroWGmidxD4P?=
 =?us-ascii?Q?ORnSVIZ7477XxsaOKd2RrzSIQV3yECbpxSUaUADlSb2Jbw7vwYJB+0wmDOAW?=
 =?us-ascii?Q?cZDqmJWnXYHcj6gu/zQzoWKTefBP4p186639iuvQqu1ng5db7SiZZ+g6G+XH?=
 =?us-ascii?Q?QQwmpPBJ2lsjKbl7IhbwGh5lzxDWr8IfkYKDmnElszgF1EzUM1renBkDbCq+?=
 =?us-ascii?Q?/8XtPso2YhQJ2eAmt8oE6RKxThyuvDpcgRynkUcjkb7rOcGGy3Nq7VjRSJyf?=
 =?us-ascii?Q?yftqJ8Jbou1yBUCaIzu906/LL4A5USws4SD+Ue3U0Zv9cZMAUXDcaoPowGvy?=
 =?us-ascii?Q?cuWLSTlAW/2iQDkOjRRdPcCgeULtjV7+8YIHnLE5yPWAsBilVn+wy5UNSqWY?=
 =?us-ascii?Q?sKLSKXuDBbVBuocCqfy/GxTNBJ2uY9Efv+Xb7SEyJwrSyLyYBHrtP9EtK9N4?=
 =?us-ascii?Q?y3WinTmb4aC1oo1a3T4CfIa6FdqXkTJZuB0aCkL94fAIUMqXFw4A+XJY4nDk?=
 =?us-ascii?Q?Rt9rxbsQove8DLsDcr7fakWYTwNdhmwS4PenfMwh1GoXHx4TG3w23Plo5Q/F?=
 =?us-ascii?Q?0w/x+Xzgs6XNYl8uw1+C5aTCAT9roz1J8CPwiT0Jt55z4YvhVWWRKrgPeaZd?=
 =?us-ascii?Q?eV0Mlq+Wq/lyVxbW4UVj08EtdwYJUKWwGm/MpYsrSBB+foRhqWzCgsOnb/LV?=
 =?us-ascii?Q?18Gg1INRmgUOqWGGLLt28D+jIqY0jkrSkJZ7ipfWDePHsF+g8MWln5fMnEY?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5rsahuVLIPZJCbIwiiL1nl/BVY17FjEUA7YQ9fMIe1JZlvS1UXrFwt6g4M3i?=
 =?us-ascii?Q?/2ev6z4IMqM1ZfZ/9tM7KT3gQaK/TsnV89aNPWYmFKVVGGHGRKTlN0vBNx+0?=
 =?us-ascii?Q?lHbyM8xEiUM+26M0KDNp7drAMNZYOyVe8Ziq70T9F8nMdHFtD7H89iQUHjWt?=
 =?us-ascii?Q?t4Bog1fnTnbVdQEHax4Gle7ug/0w0srXTmbuHTANBr2VrqhNVtHZQeamWksz?=
 =?us-ascii?Q?R+1J1hoAGYAjlPNQJThRViXo0T3FKgP1xunvomrqYLQ96PPTHjqQPfNZfP6b?=
 =?us-ascii?Q?NWSKKx9p27XauWEDSkZb7M4/wBwUTHwiSIeHNue7t5MVR8/zccH1LfTnZ2ux?=
 =?us-ascii?Q?wG//heXRFUMs+ZcCoTHMZ9EMkD1Lz+TEtp0adi39oFzEPA/9x9r5E+aho+4B?=
 =?us-ascii?Q?yg8Zl7bbwoMvmY/PsqqoqiqKl1zZiai1ChD4Lhd0S+UUrPggW71zZ9h2NW9H?=
 =?us-ascii?Q?WFNz8kyjqP8uiPFyPVHNrT8uZoD4fKHYt7FgvNtguyvONxeaSnl2//t8GC0N?=
 =?us-ascii?Q?Fh5UErQ0P0Tz5ssTgvJaStv6k7vudady54nB0CS4YVxEVVYbJ8LUAykS+nST?=
 =?us-ascii?Q?dFHDRA5rTfotsWpCvu8pRrXgmGv1I4dk09nGU46NESsDIC6rsXqKZuLmqWcg?=
 =?us-ascii?Q?km2JfcdKlvsSLJ/ojv65/SWpmjM11y5nGjCzfLL79FohY1buqmJTRxoH7Rvk?=
 =?us-ascii?Q?c7uhm8Co/3foHblQLxxI40ssZQCk9Jn8M6Lp5G3dv1+29wM7/QclmNgEXAjJ?=
 =?us-ascii?Q?jiGl3i7DeFkP4xe65v8u71/pXp72jO+SB+K+nXilm0TPBDbU4/r17b8P7Hlv?=
 =?us-ascii?Q?yf/9PoRU1pmxP46EJjhmJGzcaN5meTsB+4Orn2bZX1e1o1vVRCyxX1Ll5inY?=
 =?us-ascii?Q?ynfjWSGammKKdbgWJwVStL4ueszx4KkNmdeKtHBZNUq7s2rn23rm+X1QrFmL?=
 =?us-ascii?Q?EdSFvF/yxv1Z0IReyzu3UNzubkmGywAaISUJSatvqEe2TWsWIgsPj5wvFJQs?=
 =?us-ascii?Q?gpJ/BxJYPnQtR97GgR3amaoEmiaZvA5ByYooCj2nmFWnx9mci46rcGPEL9+p?=
 =?us-ascii?Q?ihzjYn8mkkfIpfzIY2RPy6prFyKp4fcb+VfBLh11Oys26aWMU4OYZ8Amt69v?=
 =?us-ascii?Q?0g2tV5pSYqu5m73pvMinc7R++iy4E+vNKeM1lFZHBK4L3MsRQeoqgMyXHRJj?=
 =?us-ascii?Q?MQiO/s737BYF1v2B/tB0kIw3kj2GMCzc/I6m+ZYWGPkaXYALaSldgIAxPVYi?=
 =?us-ascii?Q?7VrLxEsg/kSzRltwcUbz/jRwxeiiJbDEIXf7sXBqnCzM9lIKc4ynO5ag1QEp?=
 =?us-ascii?Q?BI/gwkYbgFitzCdPAowBx4VIZ6ncoki+90cQtnFrmNU1V73JW4ArHPQxNvhC?=
 =?us-ascii?Q?OBcC1U9Xhv2BXoFwuYw3pHCmOMQsItK+IJmHb1FaD8YhmoCz3bP0DSWMJ+/B?=
 =?us-ascii?Q?3LLrZQK9qnVxyQ4XZHMFzrvzbGOoBL1LunsF1dmmfkSxiQ0G6s0fYhjnaYZI?=
 =?us-ascii?Q?7dOu5LKFLyGKtRlkFXSdlHqPmDdrYyQbYJl1VRcisIS+9U4K/+krEXBuprS6?=
 =?us-ascii?Q?9DSr9jB5l7udBTt/D/5RB+VDy/V040JEEY07udTF0Kn7kA6ZzntTmox7PZVj?=
 =?us-ascii?Q?JA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b4310b7-48dc-469b-ab22-08dc664b9d65
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2024 23:50:13.0742
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rsnx7/DX6n17KipRUL2poRrgj1yYMrSGTMbn5eeku+VWkpuZ6j7JfkS7ImVt95A104cYl1sWG5RE1GIdBAzCSN0isBd22TH0JxKdSBjgAFA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4573
X-OriginatorOrg: intel.com

Ira Weiny wrote:
> BIOS can configure memory devices as firmware first.  This will send CXL
> events to the firmware instead of the OS.  The firmware can then inform
> the OS of these events via UEFI.
> 
> UEFI v2.10 section N.2.14 defines a Common Platform Error Record (CPER)
> format for CXL Component Events.  The format is mostly the same as the
> CXL Common Event Record Format.  The difference lies in the use of a
> GUID as the CPER Section Type which matches the UUID defined in CXL 3.1
> Table 8-43.
> 
> Currently a configuration such as this will trace a non standard event
> in the log omitting useful details of the event.  In addition the CXL
> sub-system contains additional region and HPA information useful to the
> user.[0]
> 
> The CXL code is required to be called from process context as it needs
> to take a device lock.  The GHES code may be in interrupt context.  This
> complicated the use of a callback.  Dan Williams suggested the use of
> work items as an atomic way of switching between the callback execution
> and a default handler.[1]
> 
> The use of a kfifo simplifies queue processing by providing lock free
> fifo operations.  cxl_cper_kfifo_get() allows easier management of the
> kfifo between the ghes and cxl modules.
> 
> CXL 3.1 Table 8-127 requires a device to have a queue depth of 1 for
> each of the four event logs.  A combined queue depth of 32 is chosen to
> provide room for 8 entries of each log type.
> 
> Add GHES support to detect CXL CPER records.  Add the ability for the
> CXL sub-system to register a work queue to process the events.
> 
> This patch adds back the functionality which was removed to fix the
> report by Dan Carpenter[2].
> 
> [0]
> Link: https://lore.kernel.org/all/cover.1711598777.git.alison.schofield@intel.com/
> [1]
> Link: https://lore.kernel.org/all/65d111eb87115_6c745294ac@dwillia2-xfh.jf.intel.com.notmuch/
> [2]
> Link: https://lore.kernel.org/all/b963c490-2c13-4b79-bbe7-34c6568423c7@moroto.mountain/

Like I mentioned last time, perhaps Dave can reformat these lines on
applying to:

Link: http://lore.kernel.org/r/cover.1711598777.git.alison.schofield@intel.com [0]
Link: http://lore.kernel.org/r/65d111eb87115_6c745294ac@dwillia2-xfh.jf.intel.com.notmuch [1]
Link: http://lore.kernel.org/r/b963c490-2c13-4b79-bbe7-34c6568423c7@moroto.mountain [2]

Other than that, this looks good to me:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

