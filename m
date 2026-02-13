Return-Path: <linux-efi+bounces-6136-lists+linux-efi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-efi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cIFYHx1Xj2lqQQEAu9opvQ
	(envelope-from <linux-efi+bounces-6136-lists+linux-efi=lfdr.de@vger.kernel.org>)
	for <lists+linux-efi@lfdr.de>; Fri, 13 Feb 2026 17:53:49 +0100
X-Original-To: lists+linux-efi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2772513867A
	for <lists+linux-efi@lfdr.de>; Fri, 13 Feb 2026 17:53:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 62BCA300B5B4
	for <lists+linux-efi@lfdr.de>; Fri, 13 Feb 2026 16:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FD273164DF;
	Fri, 13 Feb 2026 16:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HsOi5LU+"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D802F16CD33;
	Fri, 13 Feb 2026 16:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771001627; cv=fail; b=pae4s13v4rfBzKVzBn56IBUcbCXyG95abueS/EGb9B7CGCnmshCuPo/LtM2P2waY41HadHNYNRTWaQs4EBO+gYNrQU1ISluQHdMFu+CdLbe2iataBAOfebgp9VOD4WKeaWH4I5lVRwjMYEzTS22FKgFIxHZ2rYxPmzaSYJxSF4w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771001627; c=relaxed/simple;
	bh=ejrCfq3h5zcvu/9GdJiEzE+QCV7smEwVjAAn9W5E+4A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jxrbjLWpi1MbhkHGaPE/l8tOLgxOD46gKpYeLAqlopqMlBM85OYxO+vRyXnChGBanJaR4JKKFHiYnzhJx7ogKuEqWuXXoWNXmamzZtIx7EgCIqRlcpTi/niycQ8g0evENs6hDSLzJOYnB1MuKHalNHYNgGZrD9x7/d92kvs2BfM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HsOi5LU+; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771001626; x=1802537626;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ejrCfq3h5zcvu/9GdJiEzE+QCV7smEwVjAAn9W5E+4A=;
  b=HsOi5LU+VTc405eLdjjvjZcTGTDaoWibSyRLq7BGMWeTcWgxTXRZn9PV
   lyAawEK8JnkRfajB8QVQFbVl4JRSu42ZIFHtMPpkcvO/CZWV1HgThDFor
   Ltlx0HYL/+RHbHogNGvbiLxyH9I5VZSJGqDnOGu5c5Jat3eJUcpIM9Rgl
   MujB1cUaLteW/WzwyTV3CaZeqUPTWC8uAaw2cXgb28WoiPjNify7D394A
   wgfQnzCivVfsOlj6M8Hcfs6iUF6gktZqqyFBSCSQ8OHTFDYQ1iQcIiBNS
   si2BahAxURYNklUEZJii9gceRPD2Rj3LZXqv5LS4JJoEAYuJlOCTvfa8w
   w==;
X-CSE-ConnectionGUID: 8ugrpi9vTvmup0U+yW7Wcg==
X-CSE-MsgGUID: 6k1yJfq/RxWOrstMs9XhtA==
X-IronPort-AV: E=McAfee;i="6800,10657,11700"; a="76037818"
X-IronPort-AV: E=Sophos;i="6.21,288,1763452800"; 
   d="scan'208";a="76037818"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2026 08:53:45 -0800
X-CSE-ConnectionGUID: f5RKoL8QTiGQbV/Tj24c0Q==
X-CSE-MsgGUID: 3KAxj3TbSAyMOggpkJT16g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,288,1763452800"; 
   d="scan'208";a="217945799"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2026 08:53:45 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 13 Feb 2026 08:53:44 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Fri, 13 Feb 2026 08:53:44 -0800
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.31) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 13 Feb 2026 08:53:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qBIF6HrDgOWy+xEkIJOqStIFSe/ynsuiLDtjNKEZqBagl65YT5z8pNJaxjZxqGy7RkP7VxiXIIUw4Ll0ZzvEu8gnVZ5FVEf3zEu34MfwRqYiip/uakqw0cgby9d0DlWfykkkgbwNSsYfTRGSnZl9fJGL4NOeEzm0NNdKFOX9egdrrKsdvT77tl7ArrpTUo1ZXADpy3ax/NPxNaM5XWKzleFpFU8cN0ecNuY1qsovHqTof94qosxDxETqZVA3ycM39hK2+44OCezEje+DkgqIA3bDzB/99eVNzHygqUg34uWMiAh0j68O5s4N1EmIjFOFg9q5RgzUliSYtGwM9oeVag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ejrCfq3h5zcvu/9GdJiEzE+QCV7smEwVjAAn9W5E+4A=;
 b=NzawojIZOrqPDENbBrQUXnJpnCayNVD+wZrooF8tUmxQQj1yOt3aNCdImLyV0oBgbcYnVQSeLKtikkkln1T4scKZVAgaidPr+scg4wG0Wty5rsXmKj84L/1JScmcaQaWiUSUGq6yZg0biFWvaMH0UlTA4+WiG+RFvv7QY2A9kUpMYmxhzMF5B0D8tw4AzP7fPlZouDatjuuTsy/oOgujTYYlpNxOgx39XimVGJ7HAB3bexKYaJmSA0otZhtxJNAPUWe6uODDLRKpOwFPb1yxaRhcSqj4KDpbrOp/l9oxF06D1Irt3G9RXm2SvrsARiOJC5HjQ2tE961vEvDlzPTkEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW4PR11MB7125.namprd11.prod.outlook.com (2603:10b6:303:219::12)
 by MN0PR11MB5985.namprd11.prod.outlook.com (2603:10b6:208:370::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.13; Fri, 13 Feb
 2026 16:53:41 +0000
Received: from MW4PR11MB7125.namprd11.prod.outlook.com
 ([fe80::690e:5fd2:b08b:52af]) by MW4PR11MB7125.namprd11.prod.outlook.com
 ([fe80::690e:5fd2:b08b:52af%6]) with mapi id 15.20.9611.012; Fri, 13 Feb 2026
 16:53:40 +0000
From: "Verma, Vishal L" <vishal.l.verma@intel.com>
To: "ms@edgeless.systems" <ms@edgeless.systems>, "kas@kernel.org"
	<kas@kernel.org>
CC: "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>, "Wunner, Lukas"
	<lukas.wunner@intel.com>, "Hansen, Dave" <dave.hansen@intel.com>,
	"ardb@kernel.org" <ardb@kernel.org>, "Edgecombe, Rick P"
	<rick.p.edgecombe@intel.com>, "Weiny, Ira" <ira.weiny@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] Fault during memory acceptance for TDX VMs with certain
 memory sizes
Thread-Topic: [BUG] Fault during memory acceptance for TDX VMs with certain
 memory sizes
Thread-Index: AQHcnQipj/eome8ll0e7a2romAu6hLWA2ImA
Date: Fri, 13 Feb 2026 16:53:40 +0000
Message-ID: <2e77439b64b47f230e8d363a256066677cac11ef.camel@intel.com>
References: <c2632da9-745d-46d8-901a-604008a14ac4@edgeless.systems>
	 <b6f00f31-ab39-4a76-b758-b3cfb1b0dfbe@intel.com>
	 <cf37b7df-1265-411c-8aac-f82c3732fde9@edgeless.systems>
	 <aY8Quu2WJG5HB3PP@thinkstation>
	 <5a0fa6d2-f138-4360-bf02-5478eda4b495@edgeless.systems>
	 <aY8y6uCyejTXTejt@thinkstation>
In-Reply-To: <aY8y6uCyejTXTejt@thinkstation>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.56.2 (3.56.2-2.fc42) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR11MB7125:EE_|MN0PR11MB5985:EE_
x-ms-office365-filtering-correlation-id: 29ee380d-e570-43fa-d8c8-08de6b2070cf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?dnNnM1ZtcnFTMEdOajFsM2t5UVRWaWFqREhqMEcwcGlHcGZYaUJMRlZIUTR0?=
 =?utf-8?B?YTNTYXNBNUpoODJwbkdvZmpTd1hHRzhVdjQ1dWhVbFZWbzFhZWVidW1qOU51?=
 =?utf-8?B?VmN0VXN0VHFYT3ZacGdRbEpqaDJuZGkxZ045czFEbDdiTXdGVDRqalhtMVU0?=
 =?utf-8?B?WW1OQzJoTFo5SnRpQlZqTzdRZE1XbVR3K2N5R3djVUl1V3JiQklEQm4yWGN3?=
 =?utf-8?B?K3JJZFJaSVNMdVdnakVPQkg4TjErSDZ1UzhPV2pSd3BJWVVjdklLd25aaHZH?=
 =?utf-8?B?clI0N3hqd3hvS05vM0pOemxqTWJtb0dJc0pkTEsxNDdEajQ3UzJ5RkcwUGo0?=
 =?utf-8?B?R3AxbTgzVGRtTXBvSVluT3NXN3ZGNFd1OEdkRDc0VS8zZmMzVUNKc0JtQU9I?=
 =?utf-8?B?ajVuSDI2aXVlQU9RNGVjcTNneURpSWhLaStVcVRxanVnUjlhYjduR3QvVDRl?=
 =?utf-8?B?QS9vYUE1QUJDM1E0Rm0vTGxWMHA3LzlDVXAzRVRkdE92d3lhRWk5TFdkVGk1?=
 =?utf-8?B?OUZON1VyQWRVenlZNzJ0enV5YVNmK2tmN3JGT2FjaTdYMm81S09yNU5SblhE?=
 =?utf-8?B?djV1d0F1WEU1aXF2dWRIa0NDbmg3aGkyN2hBOWVNaGl6amFpdFVJeVdwUjhM?=
 =?utf-8?B?YTBCZi9zc3pOOW9uaEROKzc2WVpTQTRNYmx0WTcwWmlieFQrRWw5STRzcFVI?=
 =?utf-8?B?MlVSTVpma2JUdGVrNUt3THRTaWxZcURYeGxUcDQ1RG1Zc2xQdjdWR0FRdGVC?=
 =?utf-8?B?VnNHeG05WFNNYklDN0t3dFRVMndlQjN5ZnI0d2VLakpmTXpKcE82UnNpWlph?=
 =?utf-8?B?RDRqemJLeElwaWlQL0FyRmhqbSt6WVpMZUxlMEpJYW5KWXZLK2lndDJYRkxz?=
 =?utf-8?B?YUZYZldVUmpRb1pFTVBZR0kyNnEyMFIvdnFnNC96Y3lhL0FkQUdBOEtES0ZZ?=
 =?utf-8?B?L0RRN3hoVGh5cWpFaUxyWndTb3BsTjExKzcyT2k2Z0ZhQmhhT2Q3cndLVEZ3?=
 =?utf-8?B?MjFsMEQwVktjdDh4SzlyVjFGei9mVjg1ai9aVExBR2FDZ3diYmlWejBjcS9m?=
 =?utf-8?B?bkZpSVV6aHlwTnpDUFE5d1dtREM4MzduZ1l2VFZucXFwYno4K2FEcGp0U1BZ?=
 =?utf-8?B?VlFLOThSUUtMMzc5blNzUVV4ektEbE9XTVBUTkZ5d3gzY3JoQWtaNkM0MEdy?=
 =?utf-8?B?UlQ2eFQ4dGdyKzJVWFFOODFwRkJ3cjFlbVZqNFQ2a2RXSmJFZTdMOW9wRS9w?=
 =?utf-8?B?OE85R3BwUkxVOCs5Q1huSG1rdEErbzdhNDZFaTA1M1M0S1hlVnlnaU9HYko1?=
 =?utf-8?B?eVBsRzFmRGE3aXZZVTZKREhFTC9zckphUDJPNlJvbW5PU1JDQjc3Vkowci9D?=
 =?utf-8?B?OUR0a1FZL3A3enh1ejdhci9ZUitlcGxTV1lxcno5UittT0xReVVhTCtSdW4r?=
 =?utf-8?B?eHNFWkcyQ3piOXk0dUtmRmRjTmhRRFpjdG1aY3RmNXhVWkxZa1pzUU5CN1Jm?=
 =?utf-8?B?U2RQa21IalFrZnR0ZWUvQWFMdlVlZnpXL2tuUkVjVHl5eTFkbmRGN3R2c0dJ?=
 =?utf-8?B?UUJXSzV6RTE1U2crOFZCaWVrV0ZtTnQreFNsTzhNOW9aUEF6YXg1TDVoQlMw?=
 =?utf-8?B?emdHUmxiK1g0NGloLzNhRTNSNm1iWlRyQk9Fb054UDA3UmpMWkVKTkQ5RVM4?=
 =?utf-8?B?bG92Z3pOcXlmMFlkcU45TG9pN21OUytWdUhQOC9IeFlseVhvYW5HSjdpY1dE?=
 =?utf-8?B?TUhyajFaOVBjYmIwenE3MDZmQ3V1ZlRBbVRNdWdpMzF2V21TSVYydGwway9s?=
 =?utf-8?B?bGduMzhBaVFtRDhvWGhqUUVadlBVdDJteTkrUEpqR2FaRGVCMWlhMXRyR3Br?=
 =?utf-8?B?allybTRnclNSVlkrRmFXM2dIZGdxd25LOEJLWmVxWkJCdkdnRmwvUUpKeVln?=
 =?utf-8?B?NkJsZkFuelFYMm5KTUFFdDF1dmR2Vld3bWwxUSs2RnluUFh1TUhSMUljcjhp?=
 =?utf-8?B?ZEN3WGlPL2lrVmxPTW9SM2lXbk5FQkl0Z1plMHAyTit3SUVKeTN6ek4zdkpQ?=
 =?utf-8?B?b201TmY0NlZXQWhFOEYxODZYNEloZDZuYW5zOG9JZC9XOVBlajNTT2JJTjgz?=
 =?utf-8?B?WWRKay9qSTdHQWxCQS9iaCtKdHFzVUFweVZrcDhSOVlDYUJrMGZFSkhUYjBH?=
 =?utf-8?Q?hTA7XloVT0xCmxneiaOwO34=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB7125.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OFZrYURKcGNqTi82SGMwb0txeVFHVDBwMnBTek4xTUQydlB1U3pza2x3QXhw?=
 =?utf-8?B?aUV1Zm96RXVlSDc0ZFpmS25XZDUySDVjc3lGSlBKY2JVWVQydm1oY3pzek9U?=
 =?utf-8?B?ZGc0TWZLdTl2a3RwTnFPTFR6aXc2TEdyZktWUXFsMG44M1V1UW5Tb0daSy9z?=
 =?utf-8?B?eDdpeC9YWHcxRE9IN2N6cUNpTEUxYzFibXdLU3d5TW1qL25YN0RwYnplckZT?=
 =?utf-8?B?TWhTek5OR1U4a2RCemtyalFtWW95aWx3UGdLL0oxQk1teFBKU25kTVZ4d0lo?=
 =?utf-8?B?ZW0xblJyQTFyK1J3TDZubFdNQlhYRUFvdFZTWGZ6S01nU3AybzJHTWdWUEha?=
 =?utf-8?B?T2trcWtGSEREdytBcHFpanZhV2o4VkZNYlVtcGIwQU5UdWIydmlGMXhLQWZE?=
 =?utf-8?B?a29EMUFvam02YWRsc2RYSkpGVWN4QjRUQXZkK2p3Y1Q5YlMycThVcDlWODFt?=
 =?utf-8?B?TTlpd2pCYlRVc2RKS2pQYUxXQjAzNmx6Y0JoaHlPeEdpVDJ3MjRlQ2ZkTkNz?=
 =?utf-8?B?YWxQajNVOUdqTmpiQk8vSlJ1bldIWlVYeVlZL1pLZS85Zzl4T2NmcHlETXZq?=
 =?utf-8?B?eUQwMmIvTms4UUhkZ3YwVlpKd3ZaUGp1MEdVcitoVmFlcXYvK3NCTVhpZmU2?=
 =?utf-8?B?eitTZnpVR0hnV1B5T0x2aURsNFFQWEc1eXI2alNnMGhpRDY2NGM3NHNaa00x?=
 =?utf-8?B?ZGVxeU1lVlhkZE1OVWxVaDVRMEdZcEFZZyt0OE0rU1BDWW8vY1MydzcxcGp6?=
 =?utf-8?B?TjJ6ZVFpM2lpaEdFWTBQanZTS3QrWnpremZZWHU0M1VKOWZJV1B3M1d2Ulpy?=
 =?utf-8?B?dG8yM2hkSUtLN3VTSEdUd041N2IwcHMxSDZ6anlYK3BPNDBkdlJNQjVzK0Vp?=
 =?utf-8?B?bkNlZUxRaHlQVUh2bUdFblBvelVwTkVEMlNaRUVlTmNPb0x4cDNCc1Qwdk0v?=
 =?utf-8?B?bDFzOEpRbkNxVHBxOHprYllMVTFodWFROTEyS3RQbWNtaUI0c05Sb3owbGtD?=
 =?utf-8?B?eVVNS0JpQnFoOVlzVy9NRmsyalNrWEo3VmU3NkpmdDBxV2lzVVVmeE5sT3dI?=
 =?utf-8?B?UWRqbWFZMDdHK25PRno0Yk5MTVpZdWJtVm4yQnp4S1FHbkNtb1dDNW1Nb0dM?=
 =?utf-8?B?L3pLczRRSkR5TnpRMW1wUjFKZXo0RDBzZFgvSEZrWGtUcjA1dit4WkhTMmFP?=
 =?utf-8?B?eFpZYVhISW1nV0VZdUdSSXowSW15VEYvdzNabzMySGU5QThvOFpmT0NucWVo?=
 =?utf-8?B?dkZNdmhPMGd4VWo3T3h6T3ZTMXNxbXRyNTFMV2laK3NYUzdLMjBDMnpWa2Ey?=
 =?utf-8?B?MnpONTVFWFp4Vmw5aGVORk1CZkpQWDBJSlNaeFM5ZldEeTMrcXR5ekJqRUhZ?=
 =?utf-8?B?OWFEdlFKcjRIVncvdWZBV2RTOG9Ed1NBTlQ4MHRZV1h1eVdXVlJCQVlNa2lm?=
 =?utf-8?B?WG9EYXQvNjJ2dFdDUlFKUm9yWEp5dFNvM3pNZm9maFErcGxab3dKcU1vaVZZ?=
 =?utf-8?B?MEo1eWRFUWcvckhpTDlVUUI2REV1TUduM0VDa2lwaE9QVHJHdmFOc3RVdnNo?=
 =?utf-8?B?Nkp3RzBoY2RRdXB2QVJrYzNZell2dVlrS2JNOEI1bnY3aTQ3VUlLS0FwSlp5?=
 =?utf-8?B?bUZZRUprTTJFK2tqRlRoUndBWkp3UkZJN3lnYkxmYWY3Z0VRbEhVUndIaDk3?=
 =?utf-8?B?cW1FNE0rSElPVy9TZWpqSXh2MWc5Rng3SkRYcFQvT1l1SWYyWlpUdm9XYTBF?=
 =?utf-8?B?SC9YdmpyMVdTTmxzT084OEZHUU80TkhuSVpnNSt5NUtTcHoyb0t5UGlNL1FP?=
 =?utf-8?B?ak92MG9oV1VuRndXQ1p1K0RTSE9MZnBCRHRvUXJ3NFlGTkJSbENEK25PQitM?=
 =?utf-8?B?ajVPdE1SWE5nd0RtUVc4dkpXa3JoUkJrckJYSzRpQnRtR3NoRFcvckJmbC9s?=
 =?utf-8?B?UXlVOVRsNSt4M0pWY29TVit5RmxiSGVncEpOVlIzV0VGc3prZ0JWdURnLzdQ?=
 =?utf-8?B?dTNOSmYyU2NZMjFGVXd0ZGhtbmdUeXpjb2ZEUzVUZDhUcDVqN2RmZE5xVzBQ?=
 =?utf-8?B?a09uQlJqbzVLcHpIWnl3OFpVcVg3ejdWRW04UVdyL1l4UFRNYzVoRXFrME5P?=
 =?utf-8?B?SEdIbGZEOTJSMUE0ZzlFaStBOGh3UEVybWY4dWJHN1YrVVEwRzYrS3B0Wkho?=
 =?utf-8?B?NU9kc1pEWDFPNWRBVG1wYlJoTWJaOHVpNlNEaE95ZGRod2pQVm1WN2FpL3Vs?=
 =?utf-8?B?WlBURXNUbUhCd1hNMExqVFZJelY3L3phcmhEbkdnUXI4c0pLM0pGdUovRGRm?=
 =?utf-8?B?bUtQK1VibUFWcElIdHYrQkYvdWhpR1crMCtTb1lOSG1hZkxKVkE2dmowSE4y?=
 =?utf-8?Q?muGxN8Qhmb3u92+w=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CF018AA27673774E8B8A4CB648AF0FB1@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB7125.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29ee380d-e570-43fa-d8c8-08de6b2070cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2026 16:53:40.8737
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o69GeCYnWz+vKKkF8JR4iiMRBipBE8sHrKtmanGnmRfdc/RLJYau5xYdMCf8kbN5zOW+KjXGIP0xcsK1ceKog0nd72VLOwqk4PgdVRRPCCs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB5985
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6136-lists,linux-efi=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:mid,intel.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vishal.l.verma@intel.com,linux-efi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-efi];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 2772513867A
X-Rspamd-Action: no action

T24gRnJpLCAyMDI2LTAyLTEzIGF0IDE0OjI0ICswMDAwLCBLaXJ5bCBTaHV0c2VtYXUgd3JvdGU6
DQo+IA0KPiBJIHN0aWxsIHRoaW5rIHRoYXQgd2UgbmVlZCBhbGlnbiBzdGFydC9zaXplL2VuZCB0
byB0aGUgUEFHRV9TSVpFIGluDQo+IGFjY2VwdF9tZW1vcnkoKS9yYW5nZV9jb250YWluc191bmFj
Y2VwdGVkX21lbW9yeSgpIGJlZm9yZSBkb2luZyBhbnl0aGluZw0KPiBlbHNlLiBPdGhlcndpc2Ug
KGVuZCAlIHVuaXRfc2l6ZSkgY2hlY2sgaXMgYnJva2VuLiBCdXQgaXQgc2VlbXMgdG8gYmUNCj4g
dW5yZWxhdGVkIHRvIHRoZSBwcm9ibGVtIHlvdSBzZWUuDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9maXJtd2FyZS9lZmkvZWZpLmMgYi9kcml2ZXJzL2Zpcm13YXJlL2VmaS9lZmkuYw0KPiBp
bmRleCAxMTFlODdhNjE4ZTUuLjU2ZTlkNzM0MTJmYSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9m
aXJtd2FyZS9lZmkvZWZpLmMNCj4gKysrIGIvZHJpdmVycy9maXJtd2FyZS9lZmkvZWZpLmMNCj4g
QEAgLTY5MiwxMyArNjkyLDEzIEBAIHN0YXRpYyBfX2luaXQgaW50IG1hdGNoX2NvbmZpZ190YWJs
ZShjb25zdCBlZmlfZ3VpZF90ICpndWlkLA0KPiDCoA0KPiDCoHN0YXRpYyBfX2luaXQgdm9pZCBy
ZXNlcnZlX3VuYWNjZXB0ZWQoc3RydWN0IGVmaV91bmFjY2VwdGVkX21lbW9yeSAqdW5hY2NlcHRl
ZCkNCj4gwqB7DQo+IC0JcGh5c19hZGRyX3Qgc3RhcnQsIHNpemU7DQo+ICsJcGh5c19hZGRyX3Qg
c3RhcnQsIGVuZDsNCj4gwqANCj4gwqAJc3RhcnQgPSBQQUdFX0FMSUdOX0RPV04oZWZpLnVuYWNj
ZXB0ZWQpOw0KPiAtCXNpemUgPSBQQUdFX0FMSUdOKHNpemVvZigqdW5hY2NlcHRlZCkgKyB1bmFj
Y2VwdGVkLT5zaXplKTsNCj4gKwllbmQgPSBQQUdFX0FMSUdOKGVmaS51bmFjY2VwdGVkICsgc2l6
ZW9mKCp1bmFjY2VwdGVkKSArIHVuYWNjZXB0ZWQtPnNpemUpOw0KPiDCoA0KPiAtCW1lbWJsb2Nr
X2FkZChzdGFydCwgc2l6ZSk7DQo+IC0JbWVtYmxvY2tfcmVzZXJ2ZShzdGFydCwgc2l6ZSk7DQo+
ICsJbWVtYmxvY2tfYWRkKHN0YXJ0LCBlbmQgLSBzdGFydCk7DQo+ICsJbWVtYmxvY2tfcmVzZXJ2
ZShzdGFydCwgZW5kIC0gc3RhcnQpOw0KPiDCoH0NCj4gwqANCj4gwqBpbnQgX19pbml0IGVmaV9j
b25maWdfcGFyc2VfdGFibGVzKGNvbnN0IGVmaV9jb25maWdfdGFibGVfdCAqY29uZmlnX3RhYmxl
cywNCg0KSSB3YXMgYWJsZSB0byByZXByb2R1Y2UgdGhlIG9yaWdpbmFsIEJVRyBvbiBhIFREWCBz
eXN0ZW0sIGFuZCBhZnRlcg0Kc29tZSBMTE0tYXNzaXN0ZWQgZGVidWdnaW5nLCB0aGlzIHNpbWls
YXIgcGF0Y2ggc2VlbXMgdG8gZml4IGl0Og0KDQotLS0NCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMv
ZmlybXdhcmUvZWZpL2VmaS5jIGIvZHJpdmVycy9maXJtd2FyZS9lZmkvZWZpLmMNCmluZGV4IDU1
NDUyZTYxYWYzMWQuLjlmNjZmMGY1MzU0MjAgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2Zpcm13YXJl
L2VmaS9lZmkuYw0KKysrIGIvZHJpdmVycy9maXJtd2FyZS9lZmkvZWZpLmMNCkBAIC02OTUsNyAr
Njk1LDggQEAgc3RhdGljIF9faW5pdCB2b2lkIHJlc2VydmVfdW5hY2NlcHRlZChzdHJ1Y3QNCmVm
aV91bmFjY2VwdGVkX21lbW9yeSAqdW5hY2NlcHRlZCkNCiAgICAgICAgcGh5c19hZGRyX3Qgc3Rh
cnQsIHNpemU7DQogDQogICAgICAgIHN0YXJ0ID0gUEFHRV9BTElHTl9ET1dOKGVmaS51bmFjY2Vw
dGVkKTsNCi0gICAgICAgc2l6ZSA9IFBBR0VfQUxJR04oc2l6ZW9mKCp1bmFjY2VwdGVkKSArIHVu
YWNjZXB0ZWQtPnNpemUpOw0KKyAgICAgICBzaXplID0gUEFHRV9BTElHTihzaXplb2YoKnVuYWNj
ZXB0ZWQpICsgdW5hY2NlcHRlZC0+c2l6ZSArDQorICAgICAgICAgICAgICAgICAgICAgICAgIG9m
ZnNldF9pbl9wYWdlKGVmaS51bmFjY2VwdGVkKSk7DQogDQogICAgICAgIG1lbWJsb2NrX2FkZChz
dGFydCwgc2l6ZSk7DQogICAgICAgIG1lbWJsb2NrX3Jlc2VydmUoc3RhcnQsIHNpemUpOw0KDQoN
Ci0tLQ0KDQpUaGUgaHlwb3RoZXNpcyBpcyB0aGF0IHRoZSBvcmlnaW5hbCBzaXplIGNhbGN1bGF0
aW9uIGRvZXMgbm90IGFjY291bnQNCmZvciB0aGUgdGFibGUncyBvZmZzZXQgd2l0aGluIGl0cyBz
dGFydGluZyBwYWdlLiBUaGUgRUZJIHBvb2wgYWxsb2NhdG9yDQpwZXJmb3JtcyBzdWItcGFnZSBh
bGxvY2F0aW9uLCBzbyBlZmkudW5hY2NlcHRlZCBtYXkgbm90IGJlIHBhZ2UNCmFsaWduZWQuDQo=

