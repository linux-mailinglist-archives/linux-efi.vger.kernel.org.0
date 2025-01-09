Return-Path: <linux-efi+bounces-2556-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2D2FA081F6
	for <lists+linux-efi@lfdr.de>; Thu,  9 Jan 2025 22:08:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 185023A6612
	for <lists+linux-efi@lfdr.de>; Thu,  9 Jan 2025 21:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6BB21FECB1;
	Thu,  9 Jan 2025 21:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SiBdvSBe"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA7EC77102;
	Thu,  9 Jan 2025 21:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736456919; cv=fail; b=gQtSpwnHV3E1VoOhH6hTOJOjYlTMp5afmlx26mg5rO8V50DezwyUkBXAAbCQNX5hy9xtkhGYRS1aitjicTrx4UFEBXfxF323XDMqoviEuI0LRsCBM5m0/WcLZ3R8GRZ4hhdv6hZh3GHskqtI1G3I4FaMi5odzpkTbhSvVtnKZMQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736456919; c=relaxed/simple;
	bh=FvDUGYmS+Xzx2vZ9iHr7WYjpSKCMcTD8gLs8lPz+xN4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fr95aylt4i8uA3S2ZeepmpLWh2th4+j0e4Dn6bGbGzzPoZzmbpXNhBO4QqkDJbja37BM4oms0QmD1ZTGgrumRAy634t5175x68ivdZrk2dgh5zOFqbfcUJP2wc6v5VrC00ehab5kn9h8Jr+OUtnmB4dPZ8ZnRZWtQh7wFEu+GbQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SiBdvSBe; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736456918; x=1767992918;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=FvDUGYmS+Xzx2vZ9iHr7WYjpSKCMcTD8gLs8lPz+xN4=;
  b=SiBdvSBexoHcikCcSReaz8jYNSdq066/C3R4xL9ticAh84UsMHZtwvGq
   ANKOZQRl99+oDdKe41iLh+iGu//PxpsoLHmannQYXlzfkbnHWxc8+TYOz
   sRh9ofQKbqmGNP83OaJPU/oEzYkMWoTINr5PN0nsPtyQvGBD5oDcrEuqb
   wO+w+BYOfEoRRyenwQlVP4XgTe/m9req2IzdI2r1gc07y7nPbHQNpBAiM
   lsGOQrwiXN/lYAmMp6/46QdKYHTdWOjeJNzxH+nRwqViajpuQKbJVxOCY
   WlDCGxb6adloWZc0P+HqK2vdd8eUjFomcevI022NdQvUTCVc032DfdrUQ
   Q==;
X-CSE-ConnectionGUID: aW7Xa8FiRMeMBb+AGstcKw==
X-CSE-MsgGUID: VQeiftWMRFSlJSWvkoRRRQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11310"; a="36898495"
X-IronPort-AV: E=Sophos;i="6.12,302,1728975600"; 
   d="scan'208";a="36898495"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2025 13:08:37 -0800
X-CSE-ConnectionGUID: MNao04JXSKurebdIxomwbw==
X-CSE-MsgGUID: pSQjIu/gQAKWglrlXiviUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,302,1728975600"; 
   d="scan'208";a="108435735"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Jan 2025 13:08:34 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 9 Jan 2025 13:08:32 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 9 Jan 2025 13:08:32 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.171)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 9 Jan 2025 13:08:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mF/mi0O8iEh+y1Scd0pYVCdjQxwqW5kCqC1J1mKk/BAJTf3TC1VfrjbgnzMDzjQOBl7yDQKh2AnEdzXZv+MdgHA7dy0Y33hwquPgCIbXtbrL+QW3G0KY++O+M70W3P9QD4MULgwRZmbT0qQT39ZCX9c8ROZfE7qCbpPTGZGtt1gI7X1IiIxAKbHpgRjktu2z7GzUkRg96n/YaTcPXbx5+dJHb0E9Ah+0tWNrdbKuDJaon/JE1C2L/qQ81pz12u3PEm1h/XI6AMpV/NHREw9uEfeYsQLo/NKHQ29DrezanUd6sKruVO943vAUluKeiMp3a0WAtb/zo9+u/ghWV4DPeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fl7W/2KdS4kSsPkeCkqTT5TYLjIixLj6wanDcbTQqC0=;
 b=fx2i6ncP6U2qkhl7o87swkWTGA9ohoasKSqV2hqVry/Ka0MTQDemGe9iVm7MUO8CnlYWwTRHdOt4qDTObxewv2oGMYpgCT6LyQ+lR+rj81AtsEafeODk3Qt/i8yUPVHlVl6KNXp3HmtLPwZP1tAT4krhBXG7kGl11JSUnopQo7PSdHdqxEY69xt+CSM+6ST2KC83do2LBXokz1g13zt9NqHR0Nr4OLCv24g14E90e2o/nTOAtC59xFLz1G1zp13UXq+tsccb2ud+xKu7eLvaf5S0CpqoaGP5eiNhHl2ZG5HfYYU4Hhawwc232FhN29eR3kRhl7+3QFNwuhuMMgntHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by SJ0PR11MB5053.namprd11.prod.outlook.com (2603:10b6:a03:2af::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.11; Thu, 9 Jan
 2025 21:08:30 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%4]) with mapi id 15.20.8314.015; Thu, 9 Jan 2025
 21:08:30 +0000
Date: Thu, 9 Jan 2025 15:08:26 -0600
From: Ira Weiny <ira.weiny@intel.com>
To: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
	<linux-efi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>
CC: Ard Biesheuvel <ardb@kernel.org>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Ira
 Weiny" <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Yazen Ghannam
	<yazen.ghannam@amd.com>, Terry Bowman <terry.bowman@amd.com>, "Smita
 Koralahalli" <Smita.KoralahalliChannabasappa@amd.com>
Subject: Re: [PATCH v4 5/5] acpi/ghes, cxl/pci: Process CXL CPER Protocol
 Errors
Message-ID: <67803aca1fa7d_15ec9929472@iweiny-mobl.notmuch>
References: <20241217022032.87298-1-Smita.KoralahalliChannabasappa@amd.com>
 <20241217022032.87298-6-Smita.KoralahalliChannabasappa@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241217022032.87298-6-Smita.KoralahalliChannabasappa@amd.com>
X-ClientProxiedBy: MW4PR03CA0253.namprd03.prod.outlook.com
 (2603:10b6:303:b4::18) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|SJ0PR11MB5053:EE_
X-MS-Office365-Filtering-Correlation-Id: 80d02291-c6bf-4ae6-c5b1-08dd30f1c4a8
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?u+El+DLK2cJGSW9E8VIuWiWKmfCtrnRBftwR04HDjhQegUJcM7IcVkqgJ2kd?=
 =?us-ascii?Q?H1FvcpN3jETKml+qNpBtr2DhTAGg4pYRgMI75IeGMKaHsZux+M9tcoeuclqZ?=
 =?us-ascii?Q?lyOfElk2hXrcTEZ1vbUz2I2fvW4Pu5HopN//+XIddWVKZXzUb4B7XrJEM2an?=
 =?us-ascii?Q?8MuyTfOx/nmikHVeSGP3K7RJVjvJBe8wNhaIn4qwqPSUzAtERcf2FYkS6SYH?=
 =?us-ascii?Q?sozRyCrwr9jfgWDJ0xgtBeJqsnYWC2JUbpN0jg7AtABaGMIseQ2BxLvuMW7v?=
 =?us-ascii?Q?EMGHnYV9WDwhkxtIJf9ZcheCSSyYEu6XstxWDVekBDFYEYacxmEsu0spCsvP?=
 =?us-ascii?Q?+ZzX8AdAS4w921845knY1EN5vqm5WAcPQIIf5W80bAjpPRgugfamykSmjskA?=
 =?us-ascii?Q?atardXXPW2D5N8j8TIcpHz84spno3Pj+cJw0SJz0vVsun28sXNPUzNtNm1l/?=
 =?us-ascii?Q?glQvbYQbu9BI+DigsFcLUaTzvvbZkwgx37S+9pE+8FfXy8jRwyLAcRSrwUtT?=
 =?us-ascii?Q?M7PTOZbSg9CQqCGdCGmE5YbeoCGQGYk12bE04lRtUSr2B/7AXQgjLS3RGz2T?=
 =?us-ascii?Q?zVuQyeHkBhtr3u14tKW/FUEqGxSZXekN5PGtgqOVEcLIL2mlqsspw68OGLu5?=
 =?us-ascii?Q?uPyydKr89bcJoMSV8vQV6/9UmWBjlClzgLj5IcgSirjNXCCdRQ+yLyx7hsik?=
 =?us-ascii?Q?9zefTR5NcCdx1jSMUBXrUThjOp168T0TTW7f7BOCA53LEbPTtHgSwRIl7FHw?=
 =?us-ascii?Q?1L/jEvfuVi9AQhBc351aIb7Y6gmd6Bn6EHz5MZ+YWH5EuvP8vs4OFlLzPw7v?=
 =?us-ascii?Q?HAjjlVKNsm/7hTarTpemg/sr7JQpvelPxGB8VitC0wzOJi/GNrKAap1Q8Wje?=
 =?us-ascii?Q?X+m7ZCzn6TwOUrC1lMdhJI+Lt24CVsFgRouhwPAc69mfCWA9BSQrhL1SO+GL?=
 =?us-ascii?Q?xV34xQ1ydi9s14vY352wNiYmylzT9Ghk2fi+rQAcHl6BvpcaxPftwg51IG5P?=
 =?us-ascii?Q?7n+gZ8M/k4tw9q03+MWzypXUhUbrQn6UPL03k/v21qodhXLe28nsuABmgcxZ?=
 =?us-ascii?Q?cB9Zx7OyiwxQOHcImXTz0agwY0EUmQReRfWKCfuqdXlZJGnK/BHwdrAMAzqd?=
 =?us-ascii?Q?uAqH2JXHtO7P73WTcdbolKTTlpszsVv7e8M/TjwqlFHPoVEaPAY+3A7GEx+p?=
 =?us-ascii?Q?7wjDou3co391XxBguGcdqftfh8yh495qU6ZXWkeK79Jqw1eljSHSJxBh7peu?=
 =?us-ascii?Q?9Q97bPcqrRpnWSZYy3uUSU2IVwFtONpuUdZ+I3JMsP9r1ofcJRL9s1bcMbUb?=
 =?us-ascii?Q?cIrz3wJgOaP6uaHh8BJfZPR4g2Wlih2LBoDwgJuQRSfj/m1E+fYdurVxAUtd?=
 =?us-ascii?Q?ejLqdAqPmPU/9USR6I6cG83CCQ4A?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DUnXGFDKwZ/+IC7mUIUjTdJS4r6LJJCC/Qz6XMrOzu9+GS7M7DnNYToGYASo?=
 =?us-ascii?Q?a3Kj/d8E3u3NU9nIj4sWm7poOhMtGqb+7ovmC1bY6WdP6Tfw+DUOSRanRmnu?=
 =?us-ascii?Q?qA5tljHMNCO/2h94FZlKAK81sPlxg8r+4yhJXNa9I7fF7EBYjoFE6yIe880i?=
 =?us-ascii?Q?ziWB1zyasYvNpyfadu9eNvZBxrBdjt4cMc7GkC/6cxNHN8c/Mv5hdN0thEOP?=
 =?us-ascii?Q?zgyMhoNeyX5B9edRLFLpzR8HzPFCtP1REnxG/8b2ykD8EquP9TvUzlQ/J+AY?=
 =?us-ascii?Q?+fhmrodQmMpn336hR49n63uMLWh3uTc+99Tb9T7BliMwg18RJgghSdEwo0K4?=
 =?us-ascii?Q?Ys9PPfwMsVqqQ6IgnHGfet0nuUb1uDcgTEIfoqAMX0bs4qeeVS7UHp30I7X8?=
 =?us-ascii?Q?F6bCGX0/m6Q/sYABUnfIfF+7hIFf/zB9vKJWopUlui7DvlHXCM6YzB1v7sEs?=
 =?us-ascii?Q?yFMc7Tg1bltEGR349i8aEnWMCohnREhA90oATw3au/Xd/hBBump5wH2WQwbA?=
 =?us-ascii?Q?y3EWXt1rs6dCmBkkwPQE/Opwen+oP+A2+mN/Gt6rGMHy2EYDfZXlES7eFEkd?=
 =?us-ascii?Q?MHIVwH60RcZ/xBJypweazxH/o9/8j2bekA1TziFH9HF7F+42ZU3AnaMlNTJ7?=
 =?us-ascii?Q?+qF+x1vnz7V6gSrxRxHMfm///4jgjZA04BCcqS1R5fB+oBdMxxZFfsa/WWlT?=
 =?us-ascii?Q?O4sAbUllAXBPLqtSI0wEoB1FKDH2PbTD0evjlhfmny+icwgSo5YTfPwYgA86?=
 =?us-ascii?Q?l381wy5JKFj22/6nVzXiSeKnWv6ATYrXpe/hJEo5KUeDDqTRnJbUmiBdNYo6?=
 =?us-ascii?Q?sFshENAqlyv2XfJg3DCpK6l0xKFeC+ZrlZsD5Q24NodTFU8WPBfwkwpNu1TU?=
 =?us-ascii?Q?VJYN4/jFaEdxl5BYNxdwOI2sdovwigrjgZEbyvHgMPwUBkgBfzZANi7JYtV0?=
 =?us-ascii?Q?j2duDOl0/34bavBvC4PpY4QPBRQYCVPZ4jmBHXs8i6+XNOm8UhudGyntH+86?=
 =?us-ascii?Q?kUOEvv3dnz1+mOyyceixTUzPWaIxUC+celDfRNGKIDwc9c5hUZyjvTdAe0YE?=
 =?us-ascii?Q?NhVztSGzMVh3XdDmqDnUlGVaU1D4qWGJSbtTTPDw9PIVb+mYF9u5LrJB/uqp?=
 =?us-ascii?Q?MGoRnZI1zyAacEDhfDxLR3XpSorFKFZgiD1lsQickxuR969B2diM10iAhQca?=
 =?us-ascii?Q?Gn+DQBRyTVcTCKSQsbp1BXbjGxehIR8QLGrggyFvYnqupjdj273pZ4M7vo3u?=
 =?us-ascii?Q?YPZ/kbwdvK8FKUY65ScGuKhMLH5QK18cUxEb/nfRLmVGatLExM/FZg88X8Vu?=
 =?us-ascii?Q?TR3TtpaR/H17ITBl94SOumV94meEEN8XjDOpDfgNZaqSq0E4IJ7er8kkU215?=
 =?us-ascii?Q?QhV0LMB1YYzH33uorDcOdKd5tlMLFzh/CTALpDm3b6K4xGjyii1Asylesg1Q?=
 =?us-ascii?Q?ED9Uffo3EdY5cnZH89XZkO40vFfzy6yjHvC4poBejxX3LOgHODoawy1FudRh?=
 =?us-ascii?Q?oj/1GgZ9lkICN/s4PVlPYh/rvUpyk8aPgysXUNFNaDPJVN0x4P/7US7GYJIl?=
 =?us-ascii?Q?ePXxY0m2YF48qSIeTp3EiP0lw8JN8kArJlg62sPj?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 80d02291-c6bf-4ae6-c5b1-08dd30f1c4a8
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2025 21:08:30.3456
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ML7A45pfJhtXx2gDDE5xfiUU9KgGn9LBm3xnlCBkklOoPcANihx97dvKJZn9SGdrAcRenO+75TvsUEZwrUCVOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5053
X-OriginatorOrg: intel.com

Smita Koralahalli wrote:

[snip]

> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 740ac5d8809f..5bad24965e24 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -650,6 +650,68 @@ void read_cdat_data(struct cxl_port *port)
>  }
>  EXPORT_SYMBOL_NS_GPL(read_cdat_data, CXL);

FWIW this export changed to...

EXPORT_SYMBOL_NS_GPL(read_cdat_data, "CXL");

Which I think made this patch not apply directly.  Applying by hand fixed
it up.

>  
> +void cxl_cper_trace_corr_prot_err(struct pci_dev *pdev,
> +				  struct cxl_ras_capability_regs ras_cap)
> +{
> +	u32 status = ras_cap.cor_status & ~ras_cap.cor_mask;
> +	struct cxl_dev_state *cxlds;
> +
> +	cxlds = pci_get_drvdata(pdev);
> +	if (!cxlds)
> +		return;
> +
> +	trace_cxl_aer_correctable_error(cxlds->cxlmd, status);
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_cper_trace_corr_prot_err, CXL);

And all of the exports need quotes around CXL now due to:

commit cdd30ebb1b9f36159d66f088b61aee264e649d7a                   
Author: Peter Zijlstra <peterz@infradead.org>                     
Date:   Mon Dec 2 15:59:47 2024 +0100                             
                                                                  
    module: Convert symbol namespace to string literal            

Over all it looks ok though,
Ira

[snip]

