Return-Path: <linux-efi+bounces-1360-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CEB8091E96A
	for <lists+linux-efi@lfdr.de>; Mon,  1 Jul 2024 22:17:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3FCA4B21C12
	for <lists+linux-efi@lfdr.de>; Mon,  1 Jul 2024 20:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E563016F903;
	Mon,  1 Jul 2024 20:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dRK0tISO"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 222B116DC09;
	Mon,  1 Jul 2024 20:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719865039; cv=fail; b=MEs76aW/QqaKL8gcRrhtsG+X2AVCcqRFBYqGNhvtYjiu2V6vy8JSxLwpJSrvr2fNRvXZdRBnbSP3hlA7ISIYTcKPq6e4TyB7bwziLVNtfHJYRVRw91whgWDSUYKGu9NrEsISUFWMG9paL8DWNvUjMHCRW+Wl58CsGedMWRhmRtM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719865039; c=relaxed/simple;
	bh=D0X3sgweHk9r8Y01El+iohEWGodbB0wA09BaL9Xa6UU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Rj4hfcPkXN84glAbP5skkvmc9PKM12Km5WmA1pH5cQahv7BfoAMrht11VItdqwBHyvadnLqzggDpYElaBszaxJiCFOx+p85XXD4hi7oX/rCqsutOqQr5cxX87OlZlfbe7zGtS5HyFFmzy6ZHlIkF3OpRJ5dI0gRaJp/LzgJBqy0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dRK0tISO; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719865038; x=1751401038;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=D0X3sgweHk9r8Y01El+iohEWGodbB0wA09BaL9Xa6UU=;
  b=dRK0tISOPVhp7oUCjMTI/FBSGtb/cltdaEU31kFPBd2wIJS8roSleOrM
   8ZdSkJTWw3NjQw8qgr01HMgrTcTPHv+gq/XaFlUc2b1+OE3vEgclvQh9O
   idEa9FSEmljISdgXleWBB8qxah2IQeG9XHX63nEASpebPrnWxpXDYSlL+
   3OHM6VhyF9JzMvKlj/aU5EZkQbfe6kjo+dA9v5myNjIcDCyN1B/2GB58+
   fvh1yulP2ef67/mhAmEOg1/h7aSEvJW1Lm0UMaNcJ7xi8mdAk/Sa5iPbQ
   q3ww7BZpZqiArq1iCcB+bcyF73qyCK4dSFcAW4EQLf4Dngk1SXff5qswQ
   g==;
X-CSE-ConnectionGUID: zBeLAH0VS8CFgzVC3UIFcw==
X-CSE-MsgGUID: gvBteIbLS1Gg3gjlJJi09A==
X-IronPort-AV: E=McAfee;i="6700,10204,11120"; a="27611087"
X-IronPort-AV: E=Sophos;i="6.09,177,1716274800"; 
   d="scan'208";a="27611087"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2024 13:17:14 -0700
X-CSE-ConnectionGUID: a/ogFl+xQTKBU7JicsFGfg==
X-CSE-MsgGUID: Iu8DAB1JTouI5M96v5OINw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,177,1716274800"; 
   d="scan'208";a="45444663"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Jul 2024 13:17:13 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 1 Jul 2024 13:17:13 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 1 Jul 2024 13:17:12 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 1 Jul 2024 13:17:12 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 1 Jul 2024 13:17:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SxJA5jtj1FMHYXzlcJdlS0xGg5Wk8Hup9uECvDXRgqW6WfwZ9roiynPNh4u5VC3m43QRRRuXg3gVsxF+f+bP9RM0WKDgOFxv/+ZIEgQXOpN+T+C/NTiOqatbpndS3MTmIbgYDqP0hKaElNjze0yU6f/FV3/QAtsvnA2gUwj3w0ctMKMM4EFj1NDFDJdjsVxhcju7aDyiPNK+LM+atgBNJ5EZKqJWpi0B22IAH7GMtIubaTJI4ZJrBUE0M2HGK9uMTCaYQeJMffTBUjyDkGUtAFKumUXQi3Ef41Vr58HfsHnUZ/BiBd3ce9yJQmQPSb16c2G4OaPe7T0ABGXTRT8Iug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ni8BWx84isuWd2lIooC0+ZQeTi64NThwSMnw9GdwTw4=;
 b=AyoTLb2G9ZDSqsTQrzjY5wgm85PWPAnqti3AWKqW7Ro4AN0c86W/taHpyIR2tvWKcA5LsvdrFrw5b8YyzdXgL/Q5w0t3QZc10bNlwQ4j23be6zKF+HgZLiqhtwDpVYvYsya4+my2lH9AqjGRZc9FGwcHlerXa9NbJaNE82aCYJpffPqX9kHCbrzx6QRaUrPsfcXgAubgQ8fXiJ2SG3LeYE/n+Ythqwre1mDf8bfmeK6OrjsSgc/kNfRwB905bdarfpyU0kXvelxKdea2D3t4l5p6d1JJOpdhqP+ESY/nnGj+vuqfVMLwjRa0uStzV1YGuQcL2D7fpVPNcapQfcYuQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MN0PR11MB6182.namprd11.prod.outlook.com (2603:10b6:208:3c6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.33; Mon, 1 Jul
 2024 20:17:04 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.7719.022; Mon, 1 Jul 2024
 20:17:04 +0000
Date: Mon, 1 Jul 2024 13:17:01 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Ard Biesheuvel <ardb+git@google.com>, <linux-efi@vger.kernel.org>
CC: <x86@kernel.org>, <linux-kernel@vger.kernel.org>, <dyoung@redhat.com>, Dan
 Williams <dan.j.williams@intel.com>, Ard Biesheuvel <ardb@kernel.org>,
	<tony.luck@intel.com>
Subject: Re: [RFC PATCH] x86/efi: Drop support for fake EFI memory maps
Message-ID: <66830ebdb7f0e_5639294f5@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240620073205.1543145-1-ardb+git@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240620073205.1543145-1-ardb+git@google.com>
X-ClientProxiedBy: MW4PR03CA0335.namprd03.prod.outlook.com
 (2603:10b6:303:dc::10) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MN0PR11MB6182:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f90cf3c-8fb3-4258-f68f-08dc9a0ac606
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?T18NSqHev60qGZR+tr3/ZRuY7LHiJVo0wDp5qGCbmfVPRVaZERydX0SjobWs?=
 =?us-ascii?Q?pwB2iMmo6sCQvY2nwDioNWWWPcirr3COqM6bS1t17tUPyAmODm+iaDGi08ZO?=
 =?us-ascii?Q?F6JIuRi+1PXZBsewkLiy6eE3VaQXvt67i7zGqtuGbKMqHj8+pWxVNI6bdH9s?=
 =?us-ascii?Q?k5nZQAxUbyKm/BUt8lrii2mPBhvL6Oc9pAP7vvEDfb0UO8qLGoA/TwRSyZIb?=
 =?us-ascii?Q?bAgsMBQ69XCZ66cWfrgb8bqBQZ6yvp8C3IyI+LxFfnl85MLkODXQzkoCJF6N?=
 =?us-ascii?Q?iAqtmTRMMqb0/5OvQB9SiYe0gKv8IB6tHHSau9nYIdMRZmdZrOLjfyL1Ag9c?=
 =?us-ascii?Q?X3sRGbYlFuBGRClc/P7NXbIxL8GrI4c4aYfSlD3fFarrqY5m7UL5USfVns7x?=
 =?us-ascii?Q?WQybFJEFGxQAIarb0ZurcfVWs2/7m8pgx8anYsNJdfOslrIHD9L/l9rs1I+X?=
 =?us-ascii?Q?fEiyLI1qhcg66UZfSOYTgOxSpwZHbDpDI4rGg2uE3tDryGRbXeeL++ZSHoIL?=
 =?us-ascii?Q?BIg9g+0nA9GWFN14X9RvqKi6ICUQAo68yrmE/4yCVQeIfvOJ9taaWr/w8JM/?=
 =?us-ascii?Q?0h80f9U+CSW6Idnehe6Z/hfjL1LDVFtFCaOuhsY93NVhnba0K8Ltu4i92X8X?=
 =?us-ascii?Q?X0DSYXKrk+wTN9goako1kAGTwsZ4cPH33Zmrm9kxs6uhe6NK4iMctjaq7La1?=
 =?us-ascii?Q?R2KPTbNkxzMjYpWgQ9npWc2u+V1AYF7dQOgdo414//ZWP7okCuF8PkkOi6Sd?=
 =?us-ascii?Q?LdUCX2I3C3/tfmCTazZJmo23chvZCgCrZrp1PHAReIABGTU9DM5tBMIDCNbS?=
 =?us-ascii?Q?N5c03ALrTTP+B9N6xK4NcB+IsgXhgtwNkAm+oepYA42eqBp7lUQl+uWm7F2E?=
 =?us-ascii?Q?BtaK4S8QylM13OKfZ3Ksox7EMTgwRfodeO3BWxxpDJZtdUSOyVTVNaZaYHaD?=
 =?us-ascii?Q?v3mte5DZzlxa7G7nGZa0lFHJFZ/arefti9kHsPYe6E5vwjWVGZf/FKiB3KB7?=
 =?us-ascii?Q?rpBm9bRdtiVv4P8LT5BIGlJJDvhV90QI2BjdkEcH9pbOjARN6aahsBGy7/BG?=
 =?us-ascii?Q?HmXrTSWVuTxXKDxaHRfZAxDf1Umbfv919nSNfbelWC8qbL8AVPwglAio3oO+?=
 =?us-ascii?Q?/ZLK4pDxrYBMuakDv4we3qrD3UsWj9wL/LG5iaM8HxfIqHcKvn+lFhA+AiD2?=
 =?us-ascii?Q?kIPsjRlw7oKKOXKNBBQhG1VUbkC3ezrkf+oM6zTJVL7iPfOxA89wAcuL1V1e?=
 =?us-ascii?Q?39RsRcoB2f7GQZxOvuy8/B+Iw6fF5R/+/a5ZFSBs+Ft3uCym6CAqaGX58+Y4?=
 =?us-ascii?Q?gy4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iLBn7Fxl6tTyjHwvlyyETe/qx+7E9ykFN+m/oAz7VQoOf2XgiLxVQe45lqGQ?=
 =?us-ascii?Q?/I4UglqmFVcl+3jzRMQ/jqvXzSH+O/g/i+23qrneEABuvhlN7YPs05uA/EHK?=
 =?us-ascii?Q?ucJe7q4vuqN5Kxgfxtyx/mHEV4pIs/hNQ7PR7aIYSQlS9cGshMT6LE0Kc3Hi?=
 =?us-ascii?Q?7RlPHxZZvJYQmmfG9pFBiySOFE4wGyppS7GQU+NBQUN3Yr98TEA+nA8AqqY3?=
 =?us-ascii?Q?FKUlBFHb3UREurK6TH5Fk9M5HXSx9Z/DzgZBSZ5Ii2r00LKo3MHpP8PsAwcF?=
 =?us-ascii?Q?D1oDSvXCfo7mwl7SLdXGIfprDs6r23MGKexQ0pWCQwXNy7Nfu+upqL4fctAG?=
 =?us-ascii?Q?1XvLj63jDueY+uxsevh62QwPWpPfFToyNCEQYYFGLzv3hoD9+NHAGPpxZIed?=
 =?us-ascii?Q?18WFm48k6HgU6GfTRwKSuAZ/OReaz6TtRVOCH/bs3xTLyOg2IyBcFrw+OSl5?=
 =?us-ascii?Q?tBt0nguvd50rDJ97hJa4c19b1isN6idKWvK7DmSb6q+ep0WcjEhf2t+m6fOB?=
 =?us-ascii?Q?3XUKXLP8e0ZG9p8stHuIidrmbfubepT+93kNUV0KGyyWKB3KlzPZW6qcOeVG?=
 =?us-ascii?Q?DJVv8iH/uKZJfpYPJtJDcXk7UJJ4tD+79hhxHGpasSCqZx82oXTy/Jqz0ZvZ?=
 =?us-ascii?Q?IVCb5Vi+7AaYGhlYwBnZ1SmhNMUpAEKCgc8cvuQhark0c4OQ29ViTqsErTjG?=
 =?us-ascii?Q?IQxvXyiIvwanJJ12fvuieSSFbOQ97NGvdsRag7P3Q+LAusVNl6IHkQ/TOzof?=
 =?us-ascii?Q?Mpt5itCamoqgiTFWjEoJuEE1uWOZf0T8KyfvDJcxeMrBEY6ik3j3Q1Ii+USH?=
 =?us-ascii?Q?QL6NrsyktYveNp0sMThDZ1zWFPPueSzOI4jEmMSkrXD2IaUYff7HslkLVGBj?=
 =?us-ascii?Q?nLNOPhkoZ/GfoW2V/Lmq11KfCzy7Ws7Jufcikrz7zTn9PttTjM8qpFJCDnvG?=
 =?us-ascii?Q?BkniCcQTaOL03VwzoNd2IlFtOA4DfDPYKJd00ItC6Cj0hk7j/cJhvuG+5vuV?=
 =?us-ascii?Q?oIeTdG5OIGiahctt/0j8iL8dilF+B4Umj9elf5GubOFgaRkVEiYZUKk+rgqI?=
 =?us-ascii?Q?12l231THH122XPyu7uU82Pqu3BKicGG7zXJf1gtoPJt6/btcHPh1x8on8hb3?=
 =?us-ascii?Q?MZHXzakTYlaN+c2my+VZfCqnOwwq2gDahN6Fcc3/lf/BM1FtJzoNFG5LOVJd?=
 =?us-ascii?Q?cj9EmVfUE5zta7v88x72QrVJWsyCsi5jVK2VlXM4S3VjFyegLluBYp2aHAZO?=
 =?us-ascii?Q?9Zmb4EM4EaY9QgX2OnVFcpbKDCZfUxGQz0ImhfGiDAKgBM0c5NSXlPYGzWkd?=
 =?us-ascii?Q?HpaqaxSYNvEDM0gqTBgfH/jIrQ6pGcLsNKixTmfwgComJJVO8jLOval8a0B3?=
 =?us-ascii?Q?Mde/KV0HQWWfFlA1EtDNHsuL/0H2HL4ny/Mg4zlGSWK7yCJ2mTZSb7KZKEwu?=
 =?us-ascii?Q?ZYlZtOMdQyGk3g3MlAKg7cy+q0TQZjNlb6hin8kRNkdiac0+D2aZQgFbL+3X?=
 =?us-ascii?Q?lVMjA0KrWkTH2V3hEI4qDiJdH9g3mCiynUkntiTEykGhCw4gdvmbfqreINVv?=
 =?us-ascii?Q?VEEIhsxx0tHI0f2hKod6mV32kbKxWiOr7amKwuzdmGiwLlmOXctw20W3b7+H?=
 =?us-ascii?Q?dw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f90cf3c-8fb3-4258-f68f-08dc9a0ac606
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2024 20:17:04.4722
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LE/bWkvgb+KIcZ7TrUf6hwGPnVrBKdq2m/Wk7n70jw+RABhEaGaDtk0ZYeHbBmavSEV6+we3exLFjFxlC9fKZQ7x7M01H3+JtZB4O+/7kWY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6182
X-OriginatorOrg: intel.com

[ add Tony who may care about the more-reliable removal ]

Ard Biesheuvel wrote:
> From: Ard Biesheuvel <ardb@kernel.org>
> 
> Between kexec and confidential VM support, handling the EFI memory maps
> correctly on x86 is already proving to be rather difficult (as opposed
> to other EFI architectures which manage to never modify the EFI memory
> map to begin with)
> 
> EFI fake memory map support is essentially a development hack (for
> testing new support for the 'special purpose' and 'more reliable' EFI
> memory attributes) that leaked into production code. The regions marked
> in this manner are not actually recognized as such by the firmware
> itself or the EFI stub (and never have), and marking memory as 'more
> reliable' seems rather futile if the underlying memory is just ordinary
> RAM.
> 
> Marking memory as 'special purpose' in this way is also dubious, but may
> be in use in production code nonetheless. However, the same should be
> achievable by using the memmap= command line option with the ! operator.

Ugh, sorry I missed this earlier. I only now just saw this bubble up in
my inbox from the reply from Boris, but I have concerns with this
removal.

The problem is that what is and is not "special purpose" is a platform
*and* use case policy. BIOS can only make a rough guess at platform
manufacturing time, and certainly does not have use case information.

One of the main reasons to prefer efi_fake_mem over memmap= is all of
the end user hand holding needed to correct broken usage of memmap=

https://nvdimm.wiki.kernel.org/how_to_choose_the_correct_memmap_kernel_parameter_for_pmem_on_your_system

...if anything I have been wanting to rip out memmap= more than
efi_fake_mem just to cut down on the PEBKAC reports from memmap= users
from the PMEM days. Those reports only died down because Optane died,
but CXL is here now to revive that "fun".

However, that said, maybe the safety properties of
efi_fake_mem=nn@ss:0x40000 can be brought over to memmap=. The main
property that protects end users is that the attribute only applies to
existing EFI Conventional Memory ranges. So unlike memmap= that blindly
replaces the memory map whether it makes sense or not, efi_fake_mem=
would fail gracefully if the attribute was applied to nonsense ranges.

> EFI fake memmap support is not enabled by any of the major distros
> (Debian, Fedora, SUSE, Ubuntu) and does not exist on other
> architectures, so let's drop support for it.

I think part of the problem here is that platform with differentiated
memory, (PMEM, HBM, CXL, etc...) have remained somewhat boutique since
the introduction of this facility. As they become more ubiquitous, as
trends seem to indicate, I think the frustration with BIOS policy may
become more widespread.

So we can remove it and see who screams, but we may want to put a
work-alike safe option in memmap= first just to keep our own sanity.

