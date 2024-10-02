Return-Path: <linux-efi+bounces-1889-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 577FD98E692
	for <lists+linux-efi@lfdr.de>; Thu,  3 Oct 2024 01:04:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BE612844BE
	for <lists+linux-efi@lfdr.de>; Wed,  2 Oct 2024 23:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 769AA199929;
	Wed,  2 Oct 2024 23:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ijwA30hP"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3546C8286A;
	Wed,  2 Oct 2024 23:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727910272; cv=fail; b=Yqv6ACVCgy7PXkrlKXh29UE2wnv0u4/cZqlUt4CZe74e3uv3MxJHouWK2tjbpe6JCa4qyaeQqQ8fBiopFwTuKrtaAgftnQZq4KZ6OcvMyjaqIgzvnVDvwfGKkXOWvc4BvEivw0/ibUrL7ZqJ+SbG7WQkGPWrXfFLfscwHTRbFl4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727910272; c=relaxed/simple;
	bh=BX8JHrMcbnZIM7ZJgUjt99FP/YU5utP0g1phJDfgjm0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VXObMFFBJy1YDekp+avpOxrX27O/USGn3NB3AEd4QdLn8pcdEeqZMrBSrgQU4QEcvT4s3iEWae7ZIfQtiaOgFP9Yd5MS6SM/l3Efa1DdXtD1pmqc1xSnPfkZ8qnBkJumLfMsH84i8B60SyhqF2DTTMMfkgnalzmhQq2KB+FFjM8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ijwA30hP; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727910271; x=1759446271;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=BX8JHrMcbnZIM7ZJgUjt99FP/YU5utP0g1phJDfgjm0=;
  b=ijwA30hPRq5SDExjWDfhvWfEGz4oMtmpX4mbBYIGTqnCUYHqjNKZ8oN0
   8mDlUY3x/0H5P7CSYONNuTCvD37UcmYiDmgI5DFqaEP+Hbzcx02vxeJHW
   SaSjWCuZ+7zoKZ4UF8PljnIabau+yjzv5MxUNuy+Q6LLVOwa3dkt+fOem
   nQ/7q4T9F4v+jImbIuOCmeIdC1II96jF/E9mIqAoTV4OGB0G7I+g7MDdN
   DlbdH622JJTE5qWAa0/x4Wwz3zvtJLOYnE2WWCoXvpwoIECP91d16bjbL
   lYAaF8FPSLEXcGW+GCEd2uJrhU/y5cmf127/HmDdaWfO/Y8ZRbw4KoVAf
   A==;
X-CSE-ConnectionGUID: zUtNRzxOT5q1XPijJjgYDA==
X-CSE-MsgGUID: J377z3WEQ1GUHvawb42MUw==
X-IronPort-AV: E=McAfee;i="6700,10204,11213"; a="27224721"
X-IronPort-AV: E=Sophos;i="6.11,173,1725346800"; 
   d="scan'208";a="27224721"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2024 16:04:30 -0700
X-CSE-ConnectionGUID: lGB/fdq7TFu7y4R6D7p1iA==
X-CSE-MsgGUID: kzMeGcGvQQqX2UBsPZD/HA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,173,1725346800"; 
   d="scan'208";a="74183762"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Oct 2024 16:04:30 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 2 Oct 2024 16:04:29 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 2 Oct 2024 16:04:29 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.175)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 2 Oct 2024 16:04:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eK3pdypou5ebYJ/DymsfJPONasbhVZzHJmWuDqF3wpb8EcQVy96hQGjsSxzjpx3jSVhYHz/rOmrGslOfD5fHEiMKZmWSEX895zujBqpYtYM7bJWHJz9gMIDaT+1xrtUy7dPphmnKH/SUGCQAzEvl+788H5C6uf93s7piZK/xC4XQBN+rjc0Z3lchZce0dsll4DbpWrE6C0R5j+GWoq3hzNee4n1OybhbEd5oo7NC9wd3PvUARNe8PZclHhPfUsfid7GTsZLLLQPz7w9PS4HNQ6sP28lVGOPN09GSllXAvRHvf6rdfCYvlh6FpayCHydUqni0wHXEnsuAsSnCDXHF3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/5Rfa1DVdwRpcOH+xcQ0Zo/dMgWfG3qJ4dC6oKjgJ6Q=;
 b=mtG4Guu1cBbBSMk/gn2zvV2ror64thxBeTajbn/ohWMzM/KmrbdjoW1GPALfGDQWHYQZo2sKvAv48AU0LsODjs8ua6Oc/RzZPiXY7IS3+p8cYhAe8Qz32BORyAOE9bDxClZM1Nz2QKhjnrMqNubhlRI2+EOEaghkjC89hcZzmlhvqSZWqI/LgkGKxXEofMgG1F8CN5YIrUU1uaPX2V+G0jP11M78XakJWCqeiOQa+e7ZHtOAlqGiHzcnGcGzzCVqcGlrKUWAk7VPLGQwuBtlKaBD51xfMO3tA4xiHgcDhjZGjGMrkd0wGPLDfoROIh1gVpZSBWmTaVfMHWKikkod1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MW3PR11MB4713.namprd11.prod.outlook.com (2603:10b6:303:2f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Wed, 2 Oct
 2024 23:04:27 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8026.016; Wed, 2 Oct 2024
 23:04:27 +0000
Date: Wed, 2 Oct 2024 16:04:24 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
	<linux-efi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>
CC: Ard Biesheuvel <ardb@kernel.org>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Ira
 Weiny" <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Yazen Ghannam
	<yazen.ghannam@amd.com>, Bowman Terry <terry.bowman@amd.com>
Subject: Re: [PATCH v2 2/4] cxl/pci: Define a common function
 get_cxl_devstate()
Message-ID: <66fdd178bced1_964f229451@dwillia2-xfh.jf.intel.com.notmuch>
References: <20241001005234.61409-1-Smita.KoralahalliChannabasappa@amd.com>
 <20241001005234.61409-3-Smita.KoralahalliChannabasappa@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241001005234.61409-3-Smita.KoralahalliChannabasappa@amd.com>
X-ClientProxiedBy: MW4P221CA0021.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::26) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MW3PR11MB4713:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b1c7922-a822-4b5a-02b2-08dce336906f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+qfUQQYie4Whw1y11O7Vja/q4700QhsYOrJfO0CkLKD4t+SivV2QegjAsh3Y?=
 =?us-ascii?Q?jTHy1ZOVzFdSKcS7QevHPOhnfbxV9SYRX2FPWJOwLONiuVaqkdznn9Xqj5U0?=
 =?us-ascii?Q?RAb6CGdTw5PnIyzreSskFNPCymdw2FaHdzJHtdWvNbsp9/ZjPxfxA0byLwUt?=
 =?us-ascii?Q?W5oaC1tLFibs/ii1qKNiOoXMrRE4QkSB9UQGTqzmQVIH9AigHlzUV6+Ic1HR?=
 =?us-ascii?Q?RyhYYpohdytQED6QQmDEBA6vvjj5Ma8hbn9aPKyCngCyAADo9gwBzpSq1fgS?=
 =?us-ascii?Q?o+uKWOFozku5hqOMh/ic1h1ZM9yPb9PsQQEN0I0WAPdPRiptJLjq/eukQ0w8?=
 =?us-ascii?Q?ZAkyPld7VaUj7ttSR5SkzHkj4gfmB7nzTWQpH4DDu9KXXLSg54cWXTZFwj/W?=
 =?us-ascii?Q?DPElsrQaOmzG3m8C1Fv1lnO4UzSTaUdQmN+D0d45At1D+2Z5pA1gHyxN08n7?=
 =?us-ascii?Q?g/zAd4l/UsfEW8ZmAp0gXOfPv83dnSzNk2F4SmP3RbVY5pia1uzG+E6HVvR9?=
 =?us-ascii?Q?xMqYw5JbBI0OtRfhJbMNR/37+NMAa3WV2zUWCzmNCg0f6vuURaUuyfH1gyLn?=
 =?us-ascii?Q?I5VXpl0A+pEEEFKcqhkl6R59YYANrqwvxxA+1OxHogm0sZH98fTuYIRxumUc?=
 =?us-ascii?Q?GenCieup5uyhWaKiJgFEJw8NLvtg74JQFwqRMBlAb8QgOEpk6Kw2W7Dv2pC5?=
 =?us-ascii?Q?EHti+NMmkIotdeTdJ8euBk2m4wUBzGaVEJmmHLDVn8n2VRBEM2LMOrvzjWJ1?=
 =?us-ascii?Q?QViITvWO9w16Vv54S8YssjCU24+qgJxXurMCLhJTBPXc2+J3p3yGJboJtVM6?=
 =?us-ascii?Q?0L8JteIZqPEnGwqjbb0+omcarylSD12yne4VEImIDn9SDeK2eU2y7rSy8fGF?=
 =?us-ascii?Q?vDjyxhxQOZIIledS9UGlsrGp5IUd3QTIsPbGz3nHOYBSX9+qL7Qko0PzyFdj?=
 =?us-ascii?Q?W1qQPohzJggib32OMFIKOM8atmyCnlUTzu2uGNAdqdv0QJfHHKia/cP2J23+?=
 =?us-ascii?Q?i+Ago1b7ZAqlu5N/f36Bi/Ozs/I8/CCxd3BxvuXOVvE6m79RKo40hAklCRu7?=
 =?us-ascii?Q?qexoSpKV248rW1X7Hw+dO/n2Ls5IV7sSYC0mPw0GnCgHjiyUQ8M5hPSc8VfC?=
 =?us-ascii?Q?Q+wyiq0fFSvXbG0UT/k9cTxV6thARzSUoEP0SNDpLGskdAfY0sm/NnJXsbJg?=
 =?us-ascii?Q?H0txXOtjGPTz0Erbx2AXtQ3kxqICQlEYRqcBEyrJfRvbJwjhPT2zIJyuJ0FA?=
 =?us-ascii?Q?yrKOomFnho3DOzDMsozov2i7fM3LZIb4+CUQv7pmCg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WNrAB2FhM/XPOLjBcmpaapvZgkJFOjzS0MR1txdpT1jBSfyRDacTgkQGu7qi?=
 =?us-ascii?Q?1lXMUVmBDGXbucWm7eZWWmLwNF/vmL0D66d+RHzPN4hUfmJrtJg7bXH++P+W?=
 =?us-ascii?Q?4pAVrvDY7fIdyqDhBN/7J8ic3HsVeIhXsNV1LvmwDFdscsERND//ryWVQcMD?=
 =?us-ascii?Q?+lQSAIM1xyMulVQTxuk+gcEOW6xUcgnOxwDsOqaYEydvo2HqwqZlDI6NfoNX?=
 =?us-ascii?Q?4xhjKd6VPLRLDLgyVsZiuOwgFacno7RJ2MQpFyfpXIK02XKGHhgEVZ9SWVKs?=
 =?us-ascii?Q?N96h2NPaqrwpoOrAXGi3HO+o8f1YAchIckS7h51AYHp/RfME17ZbLDgpxjfz?=
 =?us-ascii?Q?PfhGnL4t0UWKX44yK3HX0TIvyql8vNvR6QV0TtjBL6sjU7MLpoQmfDj4PVQQ?=
 =?us-ascii?Q?CwC1BcPuz+Ios8vfvtWve8CRF2wRkVDmLY7OA5RdXq4KCgBtSp01fIsBkGy8?=
 =?us-ascii?Q?Jks2J04DuuIRM7zde4/squcjzunnIysU7X+F/l3XP05XUuP7xw+/xkX41wqt?=
 =?us-ascii?Q?OrvVF2K+sCw/ksVlRcbUi/7rYrbLCEpuh5hrtoxTGjVXXWJRH3VxW9QqgKkk?=
 =?us-ascii?Q?kgwVEbTTG7lZGSiImzJz+LJmidH3FCVZB9STbcr1Ft4kPk9LmB61f9rauQSp?=
 =?us-ascii?Q?GMBxAlPXHtU+7cgEPDoUEBwyEWykEPbFZYTEknELIUNGHwD93LJnQGRU0JGS?=
 =?us-ascii?Q?q+n+o2MJ6KUd60oTtAS8ZHcTKk8qSWbJQDgdUVvbUgcW+nqtGJ+yyaKWrCH5?=
 =?us-ascii?Q?6IUJ+j5WNhmhES15MAE6UDeBmqUS4A2nwVUJVVaM2oNEZHZ/JfuvLIEK8fps?=
 =?us-ascii?Q?uKuCVYXXfTkpldHRc5AqJBuVeQ3Fiw1YaAOcOl2Tx4cLNeWiHDn4+OxQp++L?=
 =?us-ascii?Q?ROIJ7PthIQ5Sb9UvEn2YHy6T4qP+sIIOgu0PBhWG/4DsEf4FWYZJ/K4d6Otl?=
 =?us-ascii?Q?YNEsLVrG9sGvmOf1wt3APdvgex+0V7AZleduzP4DNlBkOiPHk0ge1EhJKQR3?=
 =?us-ascii?Q?9AqFXfTOIsWXBXuZo4ptZMyxKmEHHrLCaKPupqOTdKqZ7q6aEHdHtwTAj5Am?=
 =?us-ascii?Q?FO/sGTzhPdTQdDn+qzte8Q8wrhjHg2RZXUVhaB4xQRqExzipI6IFcYCxB47D?=
 =?us-ascii?Q?R06MWCHVWjLpdyW1udi1074w8Bf6hVXt/CHndmqLdnHedu2ulAWKutQ5XKsj?=
 =?us-ascii?Q?lAGyl10YrfbV/foomltJwho+BaPX1xTpiRDjKCq/AXheTM13NFDiGrQEpykr?=
 =?us-ascii?Q?JgWA5noTsURcYnIT9VaSlVLnD1o+gd6QV8cJG+yVa74wZZzX/RAWojsIZgUq?=
 =?us-ascii?Q?jltHLme4/VXM94wszLit+yN9uQh1iCJpkuPOtaGRy1EQY3w7SMzX27zCYxd6?=
 =?us-ascii?Q?W8RNJvcHAWKAl+Lixv/lgxb7uxposg4wp85WJJVF3Mdo8Jsci6cPnIgXEvvZ?=
 =?us-ascii?Q?mBqf1GxqAp9YWe5koLlwVSC56+VLkWqsSbS6Ejx95smetEXKfhzaRo9Ervoh?=
 =?us-ascii?Q?DSBLjpsk+6SlpFl0rIj3jQApmglbMwXkDxMSbC0waQT6FVB39XrqQPDzq/wU?=
 =?us-ascii?Q?kPP9RZeBrnsdQj5mUJTxvDRZFzp0zHF3jgQD6M0v0y+sO2X9KwgOlnj92tfY?=
 =?us-ascii?Q?Sw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b1c7922-a822-4b5a-02b2-08dce336906f
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2024 23:04:27.1764
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OGsMpscKgH8FZf/TFo70cM5EtgVfkGCSBfGVlWkP5MArzbdXGhBx5qIFzlfpGLjyEoa3Fpko0N9lOuxQddIYYeT8fOn9F6qL70GHCz05k1A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4713
X-OriginatorOrg: intel.com

Smita Koralahalli wrote:
> Refactor computation of cxlds to a common function get_cxl_devstate().
> 
> The above function could then be reused in both FW-First Component and
> Protocol error reporting and handling.

Ira caught the bug in the cleanup conversion, but I am otherwise not
convinced there would be much reuse for a helper like this given any
endpoint-flagged protocol errors would reuse the common
cxl_handle_cper_event(), unless I am missing something?

