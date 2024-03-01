Return-Path: <linux-efi+bounces-679-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65C7786EAB4
	for <lists+linux-efi@lfdr.de>; Fri,  1 Mar 2024 21:51:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D17D11F29804
	for <lists+linux-efi@lfdr.de>; Fri,  1 Mar 2024 20:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 306475337E;
	Fri,  1 Mar 2024 20:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ht26aA8R"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D2039FE8;
	Fri,  1 Mar 2024 20:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709326287; cv=fail; b=WkxnxIH0HimRQmCKvx8Z3xlLnqQnSkStBaAx4IHJdA0HZx02f7Pl7TA5DlnZGFp2VyaPrg4PeJ7HFd9mKiBzYBYPqagyFQs/MUlDuTdyqHai1w8oyqvYVbX2tyw0vUTPjiYifMdvBsIf66a/sZK/esWhTApF/YBjqctGu7Fvi1s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709326287; c=relaxed/simple;
	bh=Epg4V3g9doS7O+zQVbr/iPHHE/AkAsujShfzuUFp3Hg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dQJf/IabgH1rdeapviGA9CaQzonk77/8P/1bBlhqI25PGqC5ufMXFneRkstzCr6gVwPNvT23oCfOD53WMsPx0faKNz9Js9eB6rVZMGc5pQcVmP2d/OBUxQquO1+L2nrvgr1zRvPeF3IuwN06LgdtidCPjtPnYc5dJFktDiVmVSs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ht26aA8R; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709326285; x=1740862285;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Epg4V3g9doS7O+zQVbr/iPHHE/AkAsujShfzuUFp3Hg=;
  b=Ht26aA8Rr+5GRky4yGLJodMeJ7P7vzvl350phaLxHKptDuNUOyAfVWgY
   cW3GAq4FpozL2D0IUFwESGh9bLjaZoxgB13W0X6/c45m24cJwzKFxv/U5
   VHq5aLFxxUsupuXWiTuQ1FVEYPEFsvKNx2y/wZsuREAer3YRq3yBMRiik
   wg4e3ULSKH/61oGADP93koiT450gSoDeliC5Yi9JDNFEeg6UwphyL6rwc
   UkeZZZbkAzVhRua1SaYVXpAO1TxQMnB3bRoF+3rdNQ5GxGqDwZBF80Qcw
   FJv/dX4WoaSazw1Uy5HAswSsWsqpc53f5BdWsV/GP50HbBhDMh5tQ5Wws
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11000"; a="14524722"
X-IronPort-AV: E=Sophos;i="6.06,197,1705392000"; 
   d="scan'208";a="14524722"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2024 12:51:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,197,1705392000"; 
   d="scan'208";a="39321509"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Mar 2024 12:51:24 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 1 Mar 2024 12:51:22 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 1 Mar 2024 12:51:22 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 1 Mar 2024 12:51:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iqwrr20OkjFzet+91XJIXn2mDuy+AwJajkBSqR2JJMECVxsRoLTFg8jodHZWGOSYC5eEN/s0/qqRjrWEjJLN6Oe+0JGKmwMSYvvs8ANZSNW+iKYJz+W+Kl09tw5ZsVIywbATeZrEd3uTSNsxF62pOrTPfQwDRMVCLPGsj+Y/yaQ2mO0CD6H+zRwlxupLcPs3hRxtbNWMqBgRXsPAUKfMO6EmyqfSmDW8u8e+ZkWwl3CNgC/xl3wXQJB0EwzI1Jib8pcotB5jVQe4MJgOwOK9PnGeU9G8ykbF7H9hppw0ngP6TJpYYYT7RNA25lU1Hhu3fxHYZ0WYa7pWnMTwRL6qhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=opKm32GNfUbm9vygrKSe5GEzKZuLuH+d/FD2cStK/8s=;
 b=CnoaBJJ9AYo6NNxIWPstsyJrHLMBnWOOcYlO4THOct089Cckgp8NAc0VjK64iYY/ykhOGS+sx45MRpKzG1f3Vbiljk7HzwIsiB0DOdCxGexhww4jQOyDHhum8VzTZEJR87c3Fqi7XQ/BHZZJwY3EEZV34ga2NSjg4PZPH+9hWMoEG4lKDzAhC2hU+0pLgw+vovaIGrI2Q5zNCz+bhOqxP37Z2DX6r3PzwZDBJhzpaL1DI/zT0uL4ms+Qv6czKbFcYluqO6qZegqn7gbbSDKHLlTLz5HJW24odQfB00GbZJUb5MfaYPj1X+LZWpRhs2jdIDPV3s3I9SWjDIhgeWMazg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA1PR11MB7698.namprd11.prod.outlook.com (2603:10b6:806:332::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.21; Fri, 1 Mar
 2024 20:51:20 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71%4]) with mapi id 15.20.7339.019; Fri, 1 Mar 2024
 20:51:20 +0000
Date: Fri, 1 Mar 2024 12:51:17 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Ira Weiny <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>, Smita Koralahalli
	<Smita.KoralahalliChannabasappa@amd.com>, Shiju Jose <shiju.jose@huawei.com>
CC: Dan Carpenter <dan.carpenter@linaro.org>, Yazen Ghannam
	<yazen.ghannam@amd.com>, Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang
	<dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>,
	"Vishal Verma" <vishal.l.verma@intel.com>, Ard Biesheuvel <ardb@kernel.org>,
	<linux-efi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, Ira Weiny <ira.weiny@intel.com>, "Rafael J.
 Wysocki" <rafael@kernel.org>, Tony Luck <tony.luck@intel.com>, "Borislav
 Petkov" <bp@alien8.de>
Subject: Re: [PATCH 2/4] acpi/ghes: Process CXL Component Events
Message-ID: <65e23fc5402c1_3651e29483@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20240228-cxl-cper3-v1-0-6aa3f1343c6c@intel.com>
 <20240228-cxl-cper3-v1-2-6aa3f1343c6c@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240228-cxl-cper3-v1-2-6aa3f1343c6c@intel.com>
X-ClientProxiedBy: MW4P220CA0017.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::22) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA1PR11MB7698:EE_
X-MS-Office365-Filtering-Correlation-Id: bd0b4746-c73a-423d-0e8e-08dc3a3158f5
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KdCxZ0ENUapKVKwdeDgjmzH8FMOCiN+vzPMJonX4EAmjsaZShkfBAnhmdymAYT0kZABW8rFmG5Nigbr2NFQFy64FhER1Lv32v8L3Ws2aospUSVDJ/Cp5ndtKiZtVWcebAS775IQpWOI0vlQZ5IWfHjyC39+QO+5WDOXD6wFjHKbbUkvic0ObuOCUA2fmZANLxrYmXmTgx2WprAKl/7iENBA0Vxo2xbNBvBrUp/X/tZ7oTj1B1tjPmtu/ltt3hYwaGG8Iq37KPVeAe6EjzH3L4R3qUH5whUi69B592oVqmVgHWYdYdKblHy3lE69cDio26B4YLh8vnqJ02XHZxpGn1SYW4b1tgL/HtLwtcTfW+ozX1lVmHeNZKt3jHh6hTtQSzbHsBG5SYW2LDxVh3KRzcGg2M02C2eHh9FcS80iPPh/bFwbmpSR2Hcg1vGSnkk+vN6+0JVwAfTVV8w6suX9N+86PqD0jg0Ystui/mJhHhRrzZfyhKhMsSNlMFHcvF+u0Cf4my/C67qwVn3ALgATvmOBnmEdKhYZsJjBopwLEG7VXCLjk26hcbSMvJ6sTgzGJZuOlBk5LUA3ULyVfVUQc/cHRHFEf3XVAZ8qUzhagF24=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yR9FjFEo5H+XUb2eRODQSqt/SO+bSWznoP8sex7lSRsS1cV9jzn/YECdosNn?=
 =?us-ascii?Q?OQicfAnr4xhZ/UZBeQ39ZE5HTDy0vQvYKR+EEqKTV1VJMgw1tMnrX13hRY+o?=
 =?us-ascii?Q?ia015Pw2EK6hDiLpstC3c5mR/EW6Sw34KeJ8XMtVNMt9DuBVDVKGEVUypBEa?=
 =?us-ascii?Q?A1NbJyatPt/7HDaYceKC6uqJEIpMJBKAf6efRUuwF9CR6GxK0IVqy2Mby+Yq?=
 =?us-ascii?Q?zegNuIE2i92t/x229qhatJSV4l42yfiwG+dy5hnXRWTx0Zr9Ecz6fKUKhXLJ?=
 =?us-ascii?Q?EjMHGvF/tU0dKhqxjpy63K/e/a3VQ5GhnSuMxHYaGwaaQVHqwfW+ZbzuLbKe?=
 =?us-ascii?Q?vFChp3b2TkrzOsdimidfmrIvngQ+ixOwjQxfw3Lpv9FeT1CEMUx503NsSu1U?=
 =?us-ascii?Q?ZfLYG03vUm1cfanPAWy8G4eDYP+dnA/C0F3sU0sqvZJyaovbH2DAsFxhrA06?=
 =?us-ascii?Q?AXJJ2IrFbkDot2vhvMxzFdBSXkHBlNwKIP5GOZUewyCWm59FZ/XkrLIcmyXP?=
 =?us-ascii?Q?QXEHMM7aadEoWhyw4j0zklJh0bucHNp2usEmWWKxenrp5bdsl4doJhXueoRP?=
 =?us-ascii?Q?XTROB0JFLoVOPbsCLP49yAcw1R74SaEDtItni0oHtnUaYTzWKEYGFQ7oR5S2?=
 =?us-ascii?Q?yLpXKM7ig+TUMvqnBzqOQsxfzc2h1eMr5npkKDWK0d2PZsGao30pNCOW/zgM?=
 =?us-ascii?Q?1trjHbNDBUhnqDjXK+lPsbjqtVzJcL9jqH7j/QrMuJPopWLTCqVePCsXyv6T?=
 =?us-ascii?Q?lmCFvCbyAq1E987Sc8lPTI7zvx8IHE8HbYeA25KbvsbM3Ggp0iGLkQU4uU3N?=
 =?us-ascii?Q?8Bo587zau1pBxuC8E2x5nY/mIAUtiKqC25FVcYb9RHxgYjrj7vMuS/0Hx8N5?=
 =?us-ascii?Q?1pjIC9KhKFAqGNA2bwYpJUBpCni6w0tCzaq/WuWQOsyWzczXfvuhCdDrs+AN?=
 =?us-ascii?Q?1PoBl88AVPwtRC3JGjUOrPvtlr3rvA5Y7z/ieCKPfLz+WFbR7usMKNV+m3zs?=
 =?us-ascii?Q?tb6g8Ovis/03j+BeVpjlwQpkf028XSew7UviXKqH7bwMZHtpJ/Xzniy+5Qe9?=
 =?us-ascii?Q?3/y+faH+sCgOZitDpegxC93rkYwOscRLw0zK+U8gP36Oz67xZPUvLYLQsOUd?=
 =?us-ascii?Q?f8WQn8gs6C5JcWIDLQ01QEc/Y88whNHvnWGEMCm8dIU5MEqKApL6+V07MkwI?=
 =?us-ascii?Q?dkYZPz5GjdxDLmlo9ZaUj90fmPrsmqvxuMfkfsM+AVcRLAWk2tmJ8Q9pPqKw?=
 =?us-ascii?Q?YeuwdcVxwBTJyYzxZkiYv4uPWV2H8+5hqR+g5V5rY5vIq4TJxCs/RpIqaoXI?=
 =?us-ascii?Q?u+y4bhL6g4gtzeJ4cu5YVAcA/eTTmO154pUerj4epvlTIDO9+qyEjGx8npwe?=
 =?us-ascii?Q?kaxWoPUUeDXkVZBzX8X1lU+lpqk2l1+I0dEI4aXWajE9ebUxzCzzIcBu6fTv?=
 =?us-ascii?Q?1Xln9/j4CWnh/S80O/kIOy/Pehte0Urc4DBma0P5RImuGlgTqrdRj/a4JPJV?=
 =?us-ascii?Q?hzIcCXTaTXwDquszXWWNEHS45UiE67c1A9FjSUKWobv4qy+UaAch8zmL3zyq?=
 =?us-ascii?Q?c40OQ+ghRhBRJB4bXt5vlGydEOWDA1LS3aD34ePk/ANqqtl3ZNsqME62kHed?=
 =?us-ascii?Q?lQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bd0b4746-c73a-423d-0e8e-08dc3a3158f5
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2024 20:51:20.1851
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hMP+r8TQMfjyF4xwOYI09ADAA8D5OEwDxOYDrENuuyWAi7GsXU0xpMGbp+l7Bt1NcemwCNiVsi+KMFwDQ4sAu+Np3xl7o/ktqkAQHLsblAw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7698
X-OriginatorOrg: intel.com

Ira Weiny wrote:
> BIOS can configure memory devices as firmware first.  This will send CXL
> events to the firmware instead of the OS.  The firmware can then send
> these events to the OS via UEFI.  Currently a configuration such as this
> will trace a non standard event in the log.  Using the specific CXL
> trace points with the additional information CXL can provide is much
> more useful to users.  Specifically, future support can be added to CXL
> provide the DPA to HPA mapping configured at the time of the event.

One could argue that support should have happened first and taken the
event all the way to EDAC, so this needs to merged on faith that that
those patches are in flight.

> UEFI v2.10 section N.2.14 defines a Common Platform Error Record (CPER)
> format for CXL Component Events.  The format is mostly the same as the
> CXL Common Event Record Format.  The difference is the use of a GUID in
> the Section Type rather than a UUID as part of the event itself.
> 
> Add GHES support to detect CXL CPER records and call into the CXL code
> to process the event.
> 
> Multiple methods were considered for the call into the CXL code.  A
> notifier chain was considered for the callback but the complexity did
> not justify the use case.

Not sure what this adds. If you want to talk about alternatives and
tradeoffs, great, but that should be a comparative analysis in support
of the chosen direction.

> Furthermore, the CXL code is required to be called from process
> context as it needs to take a device lock so a simple callback
> register proved difficult.  Dan Williams suggested using 2 work items
> as an atomic way of switching between a callback being registered and
> not.  This allows the callback to run without any locking.[1]
> 
> Note that a local work item is required to dump any messages seen during
> a race between any check done in cxl_cper_post_event() and the
> scheduling of work.  That said, no attempt is made to stop the addition
> of messages into the kfifo because this local work item provides a hook
> to add a local CXL CPER trace point in a future patch.
> 
> This new combined patch addresses the report by Dan Carpenter[2].  Thus
> the reported by tag.
> 
> [1] https://lore.kernel.org/all/65d111eb87115_6c745294ac@dwillia2-xfh.jf.intel.com.notmuch/
> [2] https://lore.kernel.org/all/b963c490-2c13-4b79-bbe7-34c6568423c7@moroto.mountain/
> 
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Tony Luck <tony.luck@intel.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>

checkpatch will whine about a missing Closes: tag.

> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
> ---
> [djbw: use kfifo for record data]
> [djbw: Use work struct for sync between cxl reg and ghes code]
> ---
>  drivers/acpi/apei/ghes.c  | 127 ++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/cxl-event.h |  18 +++++++
>  2 files changed, 145 insertions(+)
> 
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index ab2a82cb1b0b..f433f4eae888 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -26,6 +26,7 @@
>  #include <linux/interrupt.h>
>  #include <linux/timer.h>
>  #include <linux/cper.h>
> +#include <linux/cxl-event.h>
>  #include <linux/platform_device.h>
>  #include <linux/mutex.h>
>  #include <linux/ratelimit.h>
> @@ -33,6 +34,7 @@
>  #include <linux/irq_work.h>
>  #include <linux/llist.h>
>  #include <linux/genalloc.h>
> +#include <linux/kfifo.h>
>  #include <linux/pci.h>
>  #include <linux/pfn.h>
>  #include <linux/aer.h>
> @@ -673,6 +675,116 @@ static void ghes_defer_non_standard_event(struct acpi_hest_generic_data *gdata,
>  	schedule_work(&entry->work);
>  }
>  
> +/* CXL Event record UUIDs are formated as GUIDs and reported in section type */
> +
> +/*
> + * General Media Event Record
> + * CXL rev 3.0 Section 8.2.9.2.1.1; Table 8-43
> + */
> +#define CPER_SEC_CXL_GEN_MEDIA_GUID					\
> +	GUID_INIT(0xfbcd0a77, 0xc260, 0x417f,				\
> +		  0x85, 0xa9, 0x08, 0x8b, 0x16, 0x21, 0xeb, 0xa6)
> +
> +/*
> + * DRAM Event Record
> + * CXL rev 3.0 section 8.2.9.2.1.2; Table 8-44
> + */
> +#define CPER_SEC_CXL_DRAM_GUID						\
> +	GUID_INIT(0x601dcbb3, 0x9c06, 0x4eab,				\
> +		  0xb8, 0xaf, 0x4e, 0x9b, 0xfb, 0x5c, 0x96, 0x24)
> +
> +/*
> + * Memory Module Event Record
> + * CXL rev 3.0 section 8.2.9.2.1.3; Table 8-45
> + */
> +#define CPER_SEC_CXL_MEM_MODULE_GUID					\
> +	GUID_INIT(0xfe927475, 0xdd59, 0x4339,				\
> +		  0xa5, 0x86, 0x79, 0xba, 0xb1, 0x13, 0xb7, 0x74)
> +
> +struct cxl_cper_work_data {
> +	enum cxl_event_type event_type;
> +	struct cxl_cper_event_rec rec;
> +};
> +
> +DEFINE_KFIFO(cxl_cper_fifo, struct cxl_cper_work_data, 32);
> +static DEFINE_SPINLOCK(cxl_cper_read_lock);
> +static DEFINE_SPINLOCK(cxl_cper_write_lock);
> +
> +static cxl_cper_callback cper_callback;
> +/* cb function dumps the records */
> +static void cxl_cper_cb_fn(struct work_struct *work)
> +{
> +	struct cxl_cper_work_data wd;
> +
> +	while (kfifo_out_spinlocked(&cxl_cper_fifo, &wd, 1,
> +			&cxl_cper_read_lock)) {

Why is this taking the lock on retrieval? The work item is
single-threaded. The only potential contention is between
cxl_cper_local_fn() and cxl_cper_cb_fn() collision, but that can be
handled by a cancel_work_sync(&cxl_local_work) on registration to pair
with the cancel_work_sync(&cxl_cb_work) on unregistration.

...but I am not sure 2 work items are needed unless some default
processing is going to happen in the "local" case.

> +		cper_callback(wd.event_type, &wd.rec);
> +	}
> +}
> +static DECLARE_WORK(cxl_cb_work, cxl_cper_cb_fn);
> +
> +static void cxl_cper_local_fn(struct work_struct *work)
> +{
> +	struct cxl_cper_work_data wd;
> +
> +	while (kfifo_out_spinlocked(&cxl_cper_fifo, &wd, 1,
> +			&cxl_cper_read_lock)) {

This just looks like open coded / less efficient kfifo_reset_out().

> +		/* drop msg */

If the proposal is to do nothing when no callback is registered then no
need to have have cxl_local_work at all.

> +	}
> +}
> +static DECLARE_WORK(cxl_local_work, cxl_cper_local_fn);
> +
> +/* Pointer for atomic switch of record processing */
> +struct work_struct *cxl_cper_work = &cxl_local_work;
> +
> +static void cxl_cper_post_event(enum cxl_event_type event_type,
> +				struct cxl_cper_event_rec *rec)
> +{
> +	struct cxl_cper_work_data wd;
> +
> +	if (rec->hdr.length <= sizeof(rec->hdr) ||
> +	    rec->hdr.length > sizeof(*rec)) {
> +		pr_err(FW_WARN "CXL CPER Invalid section length (%u)\n",
> +		       rec->hdr.length);
> +		return;
> +	}
> +
> +	if (!(rec->hdr.validation_bits & CPER_CXL_COMP_EVENT_LOG_VALID)) {
> +		pr_err(FW_WARN "CXL CPER invalid event\n");
> +		return;
> +	}
> +
> +	wd.event_type = event_type;
> +	memcpy(&wd.rec, rec, sizeof(wd.rec));

Unfortunate to have a double copy of the record into the stack variable
and then again into the kfifo, but I can not immediately think of a way
around that.

> +
> +	kfifo_in_spinlocked(&cxl_cper_fifo, &wd, 1, &cxl_cper_write_lock);
> +	schedule_work(cxl_cper_work);

I think you don't need 2 work items if you write it this way:

        spin_lock_irqsave(&cxl_cper_write_lock, flags);
        if (cxl_cper_work) {
                if (kfifo_put(&cxl_cper_fifo, &wd))
                        schedule_work(cxl_cper_work);
                else
                        pr_err_ratelimited(
                                "buffer overflow when queuing CXL CPER record\n");
        }
        spin_lock_irqrestore(&cxl_cper_write_lock, flags);

...and then take the write lock when modifying that cxl_cper_work
pointer between NULL and non-NULL.

