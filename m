Return-Path: <linux-efi+bounces-4979-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CEB4ABC23E8
	for <lists+linux-efi@lfdr.de>; Tue, 07 Oct 2025 19:23:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 878354E17A4
	for <lists+linux-efi@lfdr.de>; Tue,  7 Oct 2025 17:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3C4C2E1EFD;
	Tue,  7 Oct 2025 17:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kaoYRUfj"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A9B2DEA90;
	Tue,  7 Oct 2025 17:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759857825; cv=fail; b=Fa7VXw3AsyQSWUhAxAq4m/hu21KWDbR4JoinmipNjqaw863vFzboWP3/FO+BmoDVZFhGy4iuWuMkGt1m5YhHPy7DAlTba+HpLZa2DDDmuwVvjmvdMia+TrESwxIERc9ONVU9t3fNrsXvF1XFlnIzcw7Ef3mIswZtfyR09PkKaX4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759857825; c=relaxed/simple;
	bh=0cju3hIJYDbgLcFvUTY40fiy9bxtFrgNNCBn82Q9Z6Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gvUSoLQbAf8EnVqT1+Q+BuXwTgsrewVb7/dB7DUAJ9qODfRGliFcwX4+Eb6USwNZTXfIVfKI57NxurFjnUjcQ3pz+Sfeii3MqJG9Lj5z83Tzj0WczW20gNE9nmSto3pBBEQKN6N0v9zRbGsUx5aYTLbsMBRNS5u6EtBw4h0ZBj8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kaoYRUfj; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759857824; x=1791393824;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=0cju3hIJYDbgLcFvUTY40fiy9bxtFrgNNCBn82Q9Z6Y=;
  b=kaoYRUfjsYxRZ4Qu2uSXrZt6hWLrVpNqa1lWnk+Qi5KWT10TbyYyefDX
   JZfAHlt42hBVe3Sg256NgS9ER3zR3EfaiCdNB8k6oGadf+iAafM8c0DPx
   fnsnhPS4aggzOg7s+USfbyk8n7V9J8/DbvnZQjmrbklbfuqe8tAy8bJOV
   Tyr+5tWs6OExs90Pdl6cg5mBzKc1sh7MrTF1u5kuLuASWUkqTowsdOdIk
   6Jsp5kmjSElx7sXDEJl5j+/YNaQYskHvWVG8YROytmSiZ7TGuwEDzGDaO
   GR1akR6iepwS9HlOqpOelKmPkx5HJ0c29I0NQeBtOGl7h4KYxBLEKlhp3
   Q==;
X-CSE-ConnectionGUID: 6fErGBfLQI6BQ9gKwDeM9Q==
X-CSE-MsgGUID: TbLnpzunSNOx5z/g5RjQ8Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11575"; a="62091218"
X-IronPort-AV: E=Sophos;i="6.18,321,1751266800"; 
   d="scan'208";a="62091218"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2025 10:23:43 -0700
X-CSE-ConnectionGUID: foAx4HX9R9WXc5p6KN5Pxg==
X-CSE-MsgGUID: 4AbW0SFMTBudrWL2kROTeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,321,1751266800"; 
   d="scan'208";a="180141557"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2025 10:23:42 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 7 Oct 2025 10:23:41 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 7 Oct 2025 10:23:41 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.17) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 7 Oct 2025 10:23:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MxFk/rNnJ8dMJZ48hkM+n/b1NHTPrZB7hwLvZyinlo4WJ9qCxz/UWSUsihEDMUticg3pKPj0jPN/YhNU1CwjKheqgjpx9UX5AoKzwabyfXlJ390hK+tQyziyp7TuLS/HmBfp3jFJPo8zI1DYJhsFG59ktQ8mGmxa/gohwZFHJWGG1Eto9UgY8/LYMHiqvXVbnTSzs84eHFLjQ45H4yYszyEP8NjxbTOSCRp4EglMFC9Z+ER/1iUYhJfDmJ585KJN20Y0gZ8tIboczZJhlC8TNh64D4qmTsw1zvY/zuAgaJX2LhyCkuNg1hD2RY7P5DFH7BZuh6P2HnbqFQKpaRE/0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0cju3hIJYDbgLcFvUTY40fiy9bxtFrgNNCBn82Q9Z6Y=;
 b=krDO7op4kpc3IPQVgjHTiwEoUP2EOui5+kzFR6GvtYPRLWyf7AirZEqCZo5AqiK57s/mGs0Rsy6X0E8tXlSW/w4d0KbnUwc3as/hO/tBkKXI6EHfdDEOcKyuyJn4AZE3iqoOAwCvNkyzPVpbJrXXZW7IG0hR2XeQmPNwtyvIs/OEOyMXKpO2Wr+irrrFNJHqg7Q9ioiHGjR+f2knT+pWKvjiwGlZlmg3cGbnsXH5de3acVNaJdNuBqx9r+aPJCLduAlaMF0Rc4/P+ULR09bJWP4/Y604h//sEKr3R7OYE8j2jnO5r0/y8FeGa2eVsyho413lAVlcnSDwxIK0BqG8QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by CH3PR11MB8706.namprd11.prod.outlook.com (2603:10b6:610:1d1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Tue, 7 Oct
 2025 17:23:31 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9%5]) with mapi id 15.20.9182.017; Tue, 7 Oct 2025
 17:23:31 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "Mehta, Sohil" <sohil.mehta@intel.com>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de"
	<bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
CC: "corbet@lwn.net" <corbet@lwn.net>, "ardb@kernel.org" <ardb@kernel.org>,
	"david.laight.linux@gmail.com" <david.laight.linux@gmail.com>,
	"luto@kernel.org" <luto@kernel.org>, "jpoimboe@kernel.org"
	<jpoimboe@kernel.org>, "andrew.cooper3@citrix.com"
	<andrew.cooper3@citrix.com>, "Luck, Tony" <tony.luck@intel.com>,
	"alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
	"kas@kernel.org" <kas@kernel.org>, "seanjc@google.com" <seanjc@google.com>,
	"rdunlap@infradead.org" <rdunlap@infradead.org>, "dwmw@amazon.co.uk"
	<dwmw@amazon.co.uk>, "vegard.nossum@oracle.com" <vegard.nossum@oracle.com>,
	"xin@zytor.com" <xin@zytor.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "kees@kernel.org" <kees@kernel.org>,
	"hpa@zytor.com" <hpa@zytor.com>, "peterz@infradead.org"
	<peterz@infradead.org>, "linux-efi@vger.kernel.org"
	<linux-efi@vger.kernel.org>, "geert@linux-m68k.org" <geert@linux-m68k.org>
Subject: Re: [PATCH v10 05/15] x86/cpu: Defer CR pinning enforcement until
 late_initcall()
Thread-Topic: [PATCH v10 05/15] x86/cpu: Defer CR pinning enforcement until
 late_initcall()
Thread-Index: AQHcN1cvY6j1K81lp0qBDTHAPM2QU7S274OA
Date: Tue, 7 Oct 2025 17:23:31 +0000
Message-ID: <171d197d80701224b83e707948ae5e0a33e27b28.camel@intel.com>
References: <20251007065119.148605-1-sohil.mehta@intel.com>
	 <20251007065119.148605-6-sohil.mehta@intel.com>
In-Reply-To: <20251007065119.148605-6-sohil.mehta@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|CH3PR11MB8706:EE_
x-ms-office365-filtering-correlation-id: aa3553f1-5f78-4650-7d87-08de05c63c93
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?Ymd3cFhibzg5YTA2OWpuTUd5ZVZTS3lmSEl1bXI5RTI2YTlDTkc3Vy9wdUY5?=
 =?utf-8?B?aW8yOFd6OVdrdGRZcTVMV2drOCt3a2xCVDN5L2xaa2VNRTF1Vnk4ZE1zdllD?=
 =?utf-8?B?V25ndGg4SnBNOFJCQmJnRmJKNXNENWxCZXdscnNJVVlOWGJrUU1QQzdZSHhC?=
 =?utf-8?B?L0R0U0pJRDR5cjhkajlkZlErMFI0YTV6ejVzZjlaREpxb0c2VFpqSVYxTlNF?=
 =?utf-8?B?a1R5VHZSOCttMEVaS0FEVXpIdGNpVldHd0NFcFNsMGJBUmtOOTVHVldpdnds?=
 =?utf-8?B?dVFDWEVrcUJPejlHN1NORVZGTlltSjV3R2NXb0N0NlRMOHRodW83dllxQ1gy?=
 =?utf-8?B?U1ovQUhUY2V4S09TV0dHaFZNZDU4YlZKMGZyK1RmU2pFRUhhdUhrby9FOWwr?=
 =?utf-8?B?RWlWR3REejBobUF6SUxBamhsS3NkblhMWkM3TVpGK3lMbDV5dEZMbG8zeUZh?=
 =?utf-8?B?TnRHMTBvakljNzcwRzNhUU42SmcyYzRlU1NWalNzRHFidDRrdXRjdFdPMDBi?=
 =?utf-8?B?dWVkREZlMzhDV3dqQTZ1eUVhOVMvK09IMGQ1djZvYlduVVY3bVVheWdZSkNW?=
 =?utf-8?B?VUpUL2VPZlR4Y2t5MDRTSEUyNVNXcWw4UDRRYjNNZ2FtZjE1dGRPNUNRbHpn?=
 =?utf-8?B?b1BtLzV4YzJJSHZoWlBaMm1keHVUZmhuZHh1d3BObFU5WEJkQ2YzU20vaXVT?=
 =?utf-8?B?ZGo4ZkpZK2hHMGZsMWRQTnJhT0ppUElUOXExZkdUaURWK3JoSGo0Q04rWnlv?=
 =?utf-8?B?UmljZlBRcEQrRWtIWFBJWURUbnhrakpNTUY3TUxIT0IyT2wzZ3NVM2ZoNTY2?=
 =?utf-8?B?dGlFTlVCN3ZrbW1YWnJDU1phVG5HNVlNM0pucXg3ZVhFMjBRZDlEcUF2VFFm?=
 =?utf-8?B?WEIzS2Eyb0lCZTlRMHpqRG0rcStLZVAvLy9ZTTVucGcyVWRaQWs0NHRNNnF6?=
 =?utf-8?B?eGFvdW93WmpTTkZYNjlaVVJxR0hteUduMk1mVDhINW9IL1owMEcvUm5HOGJM?=
 =?utf-8?B?QWYraVVNOTNwT0dDY25GRWdHalh2OXhRSW9TbWZCajMvbUJ5Mkp4dTc5Zkps?=
 =?utf-8?B?TkdQWnIvbVJhNzhYZXBkTXFJc0JzRmN2WGpKQWd5MTd5dkFRbFFwV0xhZmFs?=
 =?utf-8?B?Ry9BblN6dUg1UDdBNzJEU3ZJeUxleWpxYXI1cmFmb2h3YU0vUGtrdFozQVA5?=
 =?utf-8?B?cm1XditTZThXWmhTR3JHQ05UQnQ0bHNxQzlNZVFJWms5UUYrVVFValcvVDBC?=
 =?utf-8?B?T1FCcHUvUXppTXZYU0h4emplWG13VXk5MHFEY2hFQWtma080ZHZJUzhPVUxs?=
 =?utf-8?B?VzB6Um52dUJabksxRTd3TmZ1T1FQOWRVNmw3aUNJVnpxdmp5UDdLVUV1VXVu?=
 =?utf-8?B?V2pDTFh1WUhxTEJ3MVcxZ2FpamhKTjRWaU5vS2tEZWdYWXNxY09yaDVFaUs2?=
 =?utf-8?B?UGtNR2oxN3YzYjJxMkJseUtzUi9tMXE0dW1EenlBVStOV0x5aFRrKzNUZzlQ?=
 =?utf-8?B?ZjdaVHc0Y0pPK3ZoTXhpLzQwaGJnKzFVaFFXcTZ2eHFNa290bDBFQjhYalV5?=
 =?utf-8?B?M3lHVFNCVDd6QVhDZ0tvbG1qNXZlSmcxM3NCcVZvQ21hdnhMOXZLU0h0TGJD?=
 =?utf-8?B?QnR2OGk4RGlRUS9WR2p5VlJLNXFsT2VwcUxRcWRWSGlIdWdaY0E5WWIrMnRp?=
 =?utf-8?B?VVc1OXdSb3NnT3RnZG91L0JqTEFvMElCdGVSNHdhL0hhNzVSOVUyOUoyYjNS?=
 =?utf-8?B?STR3aklCc1FlVkIvRDFlVTF2Z2xsZ0dPUEhPS0RrVGxVUS96SXNzdDQ5cmJM?=
 =?utf-8?B?UlRkeEZlUTMrK1FuZzFLS0lpajhOODE2RlkwU01TdUhsSGVrRklFbjZ2b3lr?=
 =?utf-8?B?K0c4Yy8yTXdzZHFCQnBqa3ZYQ1I3Ly9qN1pDQ3ZvRGYyZDNuN0kxem1nSnVE?=
 =?utf-8?B?VFJjTGlvUTRkUC9hZVBUZGdreHJ5cEpHSncxeHVDL3BESTBKNnFOTnp1TzFC?=
 =?utf-8?B?dHlMTUE5b0d0N3lwMVhBdEs4Z3VmMWV0U0RKQnY0WW5oR2ZOZ2Q2aWY4cDFY?=
 =?utf-8?Q?PgnjSX?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eTF6Sk1ORXBTTWpFL212K0V1dEdvS0VCcWhXaVo2c2pBeTk2UENQeXlaSjZ4?=
 =?utf-8?B?ZFQvTktsNWx3dkRybEpxK1BENkJ3M3hIOTU2RHZvR21hSDFLaUZRaXF1OGl3?=
 =?utf-8?B?MDFZT1R2dUNIVU1ZajFmTVVvWHdkTDNBWnY5akYxZFMwY3paTTlPanFnNmha?=
 =?utf-8?B?U0JlTnlPYXdlVHFEZkx4QllEQ1FWeHgvanZmRGxuTUFoKy9Vc3FBdXUzYXly?=
 =?utf-8?B?SExBeDlpZ0NNM3JqQVRudEdaSGFZY1JxcWttMzdCTjV0SWhkdkhMS2RzUkpl?=
 =?utf-8?B?aHBOSTN4aEdHdzhQUFlvcFkwTGtSNEdFZjFSRTJYSUxVckxSTnlHdG1PTHU4?=
 =?utf-8?B?SGhHL09TdHpDNS8wZ2NYblJKQWRSQjJORmpZYzdIaDE1b0ZzeTBIODl0WHc0?=
 =?utf-8?B?SXhYaUx3SVJZYXBoenphQjIwRmE3SXFJZGpscjVJUXlOMFJvZVB0ZjArYlZo?=
 =?utf-8?B?N2lyNnFCTXJWVlhFVE4rUWtxckhNWGxpTUhWaXl6ZnlLbWtIeVBmZ0RGM25E?=
 =?utf-8?B?bWRvajJWZ05xc3hDclFsVXdoQmtzOUQ1eEVhZlI3bWo1UkViTmRtVitNaldn?=
 =?utf-8?B?Wi8xOUx6MXYyMlJnUkZvNWV3YTVDcjM3OVovanp4WTJybnNyUTdOeU1LVkF3?=
 =?utf-8?B?US9hWFFJT2EyWFRCbkVtSXI4NG5DR2pIaUFyV3p5KytOaEVoRFF5VnRyM1ZC?=
 =?utf-8?B?MWUyMFA5bkt2eDBMZkozVGJ4TUFvRTRYaDVjR0I4bnkydGNYNUpBYWp1NXY4?=
 =?utf-8?B?UnZqblBwYUp2eVg5VTlCZHBsb0pTWDVPNVJNeGI4emFZSFQ1NVRiT0k4M3JQ?=
 =?utf-8?B?QjY0RXIzZVA4aGFXd1JOQ1NuVzdvaVVFdHRvditUUkRuMDR4cmdIWEcxRVNz?=
 =?utf-8?B?UkFQbWlBNEdqODVNNVdwZnRVQjgrZmRpVjJYWG1ZRFBhbGFySXF3aWlzWkU5?=
 =?utf-8?B?QjZmc1JMMGVjL0cxbXZQUVByWEtwTE9sVGU4TW0rNE9VaGRGUmsxOFFVWkdp?=
 =?utf-8?B?ZzkyMzZyZ256ZTdhM0xhcnNxSG9kK3RiTXQ5Slh0MWtKaHBQWFlPcmtLa09Y?=
 =?utf-8?B?ZXZsTzJGUGpXMGJCZVRVSWtiMThOdUZreEVFR1ZHSnMzSkdSSkZqaFlsL2la?=
 =?utf-8?B?c2cxVlZOTUVsYTcyaGNGdVd3Vk9CVHE0ZCtZa3Y4WWJjc3lCWGtLcnNTRGVR?=
 =?utf-8?B?UU5HWUQzZUMxTW9tLzJoc2FKMytSUlIyTE5rcGdkeXpJUFYzblNwTFJnVFdi?=
 =?utf-8?B?YkVVUVBCWGlnVEp1eXgrL04rcE9aYytrUys3MXpXWndBaEg1cHR0c3pzTkd0?=
 =?utf-8?B?cElXc3NzVVRvazNpUzc2YWhVMWxLRytmTEVjcEtSak9uNW9jeEFoV1REaHRN?=
 =?utf-8?B?ejBWUTJLVUd5N2FCYkg1U0V5WFRjUFVub0d0L2p0YngzRXNMaVI5RkVDS291?=
 =?utf-8?B?ZnJaMm1WQjFOMEVobVF4c0MwNHBpaFlNNnhBZWtjaEU1dlAwSk1XM2RpT3VG?=
 =?utf-8?B?c2NMOEtzNEp0c1A3dXJRYnZXd1U0bjRnTG9Gc1Y0aVhQdzJLbGpzMUJVM2t6?=
 =?utf-8?B?SytkZUlpallSemYzZXYxR0lkWUovUnNPcG9GeUJKNGRLQzJHa2g4bkdYbGJx?=
 =?utf-8?B?RGRqbmtianVJTEp0RHJ0eDBaM3YycGF5ZkJ2UnZQVk8zMjJJbVJ5N2liK3Yr?=
 =?utf-8?B?YWcwdzdEaThKckhIMmg1ZlRCUWVOeFFWclNSZkNLM3VreUs1dnp4Z1grblVv?=
 =?utf-8?B?bHJnQmNXeGE5eFl4aXNPOWVjRGVwUERONzNYZWJsV29hcXA2ZHZZOFVFeWZs?=
 =?utf-8?B?czVCVzFmU1NIaGhETVZYaHVKVXJvMWNUcjRONWpNcUl1Qk40Si91VGlHR3BQ?=
 =?utf-8?B?Njd0dktzZzZvdVVjcXBqQnE5MFlqaVBZQW9rUys0VzI0ajFtRlUxRGk1QW9D?=
 =?utf-8?B?UzcxS2NvZGFaN052SU1WMGpFSGRJRGNiVzNmRFl4V3F2L2JyNDJ6YTdhQlhJ?=
 =?utf-8?B?emdSQVhJNW5sZTcxZGZ1aGsrVFF1dExZWE12c3FEV0NtbVdiZmQxaEJYcDFK?=
 =?utf-8?B?c09NVEdmNVV5VS9rSGtzTUJFb3ExNDlER1VzQ2RyMXpGeDBHdXRlYS9IZ3Nt?=
 =?utf-8?B?VkxjNnluWnBNU2pXakZONHhiQ0Rnam5weEJWYzZoU2Ewc3dtMWVRczR2Q0x6?=
 =?utf-8?B?T1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <957B21DC16F28B468E2F8E3834D6775A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa3553f1-5f78-4650-7d87-08de05c63c93
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2025 17:23:31.0724
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xjjD0lXVYRUTmpoeWqDoxocdAW/E+mvh9UA2TRUJ/hZZQA71LbwDFjyKS5UZgrKds9SeV6zkEsR7ADdCQqA8u6RF3BJP4wXSo24uC58PsFs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8706
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI1LTEwLTA2IGF0IDIzOjUxIC0wNzAwLCBTb2hpbCBNZWh0YSB3cm90ZToNCj4g
UHJvYmxlbQ0KPiAtLS0tLS0tDQo+IEluIG9yZGVyIHRvIG1hcCB0aGUgRUZJIHJ1bnRpbWUgc2Vy
dmljZXMsIHNldF92aXJ0dWFsX2FkZHJlc3NfbWFwKCkNCj4gbmVlZHMgdG8gYmUgY2FsbGVkLCB3
aGljaCByZXNpZGVzIGluIHRoZSBsb3dlciBoYWxmIG9mIHRoZSBhZGRyZXNzDQo+IHNwYWNlLiBU
aGlzIG1lYW5zIHRoYXQgTEFTUyBuZWVkcyB0byBiZSB0ZW1wb3JhcmlseSBkaXNhYmxlZCBhcm91
bmQgdGhpcw0KPiBjYWxsLg0KDQpQb3NzaWJseSBuYWl2ZSBFRkkgcXVlc3Rpb24uLi4NCg0KZWZp
X3J1bnRpbWVfc2VydmljZXNfMzJfdCBoYXM6IA0KICAgdHlwZWRlZiBzdHJ1Y3Qgew0KICAgCWVm
aV90YWJsZV9oZHJfdCBoZHI7DQogICAJdTMyIGdldF90aW1lOw0KICAgCXUzMiBzZXRfdGltZTsN
CiAgIAl1MzIgZ2V0X3dha2V1cF90aW1lOw0KICAgCXUzMiBzZXRfd2FrZXVwX3RpbWU7DQogICAJ
dTMyIHNldF92aXJ0dWFsX2FkZHJlc3NfbWFwOw0KICAgCXUzMiBjb252ZXJ0X3BvaW50ZXI7DQog
ICAJdTMyIGdldF92YXJpYWJsZTsNCiAgIAl1MzIgZ2V0X25leHRfdmFyaWFibGU7DQogICAJdTMy
IHNldF92YXJpYWJsZTsNCiAgIAl1MzIgZ2V0X25leHRfaGlnaF9tb25vX2NvdW50Ow0KICAgCXUz
MiByZXNldF9zeXN0ZW07DQogICAJdTMyIHVwZGF0ZV9jYXBzdWxlOw0KICAgCXUzMiBxdWVyeV9j
YXBzdWxlX2NhcHM7DQogICAJdTMyIHF1ZXJ5X3ZhcmlhYmxlX2luZm87DQogICB9IGVmaV9ydW50
aW1lX3NlcnZpY2VzXzMyX3Q7DQogICANCg0KV2h5IGlzIG9ubHkgc2V0X3ZpcnR1YWxfYWRkcmVz
c19tYXAgcHJvYmxlbWF0aWM/IFNvbWUgb2YgdGhlIG90aGVyIG9uZXMgZ2V0DQpjYWxsZWQgYWZ0
ZXIgYm9vdCBieSBhIGJ1bmNoIG9mIG1vZHVsZXMgYnkgdGhlIGxvb2tzIG9mIGl0Lg0KDQo+IA0K
PiBXcmFwcGluZyBlZmlfZW50ZXJfdmlydHVhbF9tb2RlKCkgd2l0aCBsYXNzX3N0YWMoKS9jbGFj
KCkgaXMgbm90IGVub3VnaCwNCj4gYmVjYXVzZSB0aGUgQUMgZmxhZyBvbmx5IGdhdGVzIGRhdGEg
YWNjZXNzZXMsIG5vdCBpbnN0cnVjdGlvbiBmZXRjaGVzLg0KPiBDbGVhcmluZyB0aGUgQ1I0LkxB
U1MgYml0IGlzIHJlcXVpcmVkIHRvIG1ha2UgdGhpcyB3b3JrLg0KPiANCj4gSG93ZXZlciwgcGlu
bmVkIENSNCBiaXRzIGFyZSBub3QgZXhwZWN0ZWQgdG8gYmUgbW9kaWZpZWQgYWZ0ZXINCj4gYm9v
dCBDUFUgaW5pdCwgcmVzdWx0aW5nIGluIGEga2VybmVsIHdhcm5pbmcuDQo+IA0KPiBTb2x1dGlv
bg0KPiAtLS0tLS0tLQ0KPiBPbmUgb3B0aW9uIGlzIHRvIG1vdmUgdGhlIENSIHBpbm5pbmcgc2V0
dXAgaW1tZWRpYXRlbHkgYWZ0ZXIgdGhlIHJ1bnRpbWUNCj4gc2VydmljZXMgaGF2ZSBiZWVuIG1h
cHBlZC4gSG93ZXZlciwgdGhhdCBpcyBhIG5hcnJvdyBmaXggdGhhdCB3b3VsZA0KPiByZXF1aXJl
IHJldmlzaXRpbmcgaWYgc29tZXRoaW5nIGVsc2UgbmVlZHMgdG8gbW9kaWZ5IGEgcGlubmVkIENS
IGJpdC4NCj4gDQo+IENSIHBpbm5pbmcgbWFpbmx5IHByZXZlbnRzIGV4cGxvaXRzIGZyb20gdHJp
dmlhbGx5IG1vZGlmeWluZw0KPiBzZWN1cml0eS1zZW5zaXRpdmUgQ1IgYml0cy4gVGhlcmUgaXMg
bGltaXRlZCBiZW5lZml0IHRvIGVuYWJsaW5nIENSDQo+IHBpbm5pbmcgYmVmb3JlIHVzZXJzcGFj
ZSBjb21lcyB1cC4gRGVmZXIgQ1IgcGlubmluZyBlbmZvcmNlbWVudCB1bnRpbA0KPiBsYXRlX2lu
aXRjYWxsKCkgdG8gYWxsb3cgRUZJIGFuZCBmdXR1cmUgdXNlcnMgdG8gbW9kaWZ5IHRoZSBDUiBi
aXRzDQo+IHdpdGhvdXQgYW55IGNvbmNlcm4gZm9yIENSIHBpbm5pbmcuDQo+IA0KPiBTYXZlIHRo
ZSBwaW5uZWQgYml0cyB3aGlsZSBpbml0aWFsaXppbmcgdGhlIGJvb3QgQ1BVIGJlY2F1c2UgdGhl
eSBhcmUNCj4gbmVlZGVkIGxhdGVyIHRvIHByb2dyYW0gdGhlIHZhbHVlIG9uIEFQcyB3aGVuIHRo
ZXkgY29tZSB1cC4NCj4gDQo+IE5vdGUNCj4gLS0tLQ0KPiBUaGlzIGludHJvZHVjZXMgYSBzbWFs
bCB3aW5kb3cgYmV0d2VlbiB0aGUgYm9vdCBDUFUgYmVpbmcgaW5pdGlhbGl6ZWQNCj4gYW5kIENS
IHBpbm5pbmcgYmVpbmcgZW5mb3JjZWQsIHdoZXJlIGFueSBpbi1rZXJuZWwgY2xlYXJpbmcgb2Yg
dGhlDQo+IHBpbm5lZCBiaXRzIGNvdWxkIGdvIHVubm90aWNlZC4gTGF0ZXIsIHdoZW4gZW5mb3Jj
ZW1lbnQgYmVnaW5zLCBhDQo+IHdhcm5pbmcgaXMgdHJpZ2dlcmVkIGFzIHNvb24gYXMgYW55IENS
NCBiaXQgaXMgbW9kaWZpZWQsIHN1Y2ggYXMNCj4gWDg2X0NSNF9QR0UgZHVyaW5nIGEgVExCIGZs
dXNoLg0KPiANCj4gQ3VycmVudGx5LCB0aGlzIGlzIGEgcHVyZWx5IHRoZW9yZXRpY2FsIGNvbmNl
cm4uIFRoZXJlIGFyZSBtdWx0aXBsZSB3YXlzDQo+IHRvIHJlc29sdmUgaXQgWzFdIGlmIGl0IGJl
Y29tZXMgYSBwcm9ibGVtIGluIHByYWN0aWNlLg0KPiANCj4gTGluazogaHR0cHM6Ly9sb3JlLmtl
cm5lbC5vcmcvbGttbC9jNTlhYTdhYy02MmE2LTQ1ZWMtYjYyNi1kZTUxOGIyNWY3ZDlAaW50ZWwu
Y29tLyBbMV0NCj4gU3VnZ2VzdGVkLWJ5OiBEYXZlIEhhbnNlbiA8ZGF2ZS5oYW5zZW5AaW50ZWwu
Y29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBTb2hpbCBNZWh0YSA8c29oaWwubWVodGFAaW50ZWwuY29t
Pg0KPiAtLS0NCj4gdjEwOg0KPiAgLSBTcGxpdCByZWNvcmRpbmcgcGlubmVkIGJpdHMgYW5kIGVu
YWJsaW5nIHBpbm5pbmcgaW50byB0d28gZnVuY3Rpb25zLg0KPiAgLSBEZWZlciBwaW5uaW5nIHVu
dGlsIHVzZXJzcGFjZSBjb21lcyB1cC4NCj4gDQo+IFRoaXMgcGF0Y2ggZG9lcyBub3QgaW5jbHVk
ZSBhbnkgY2hhbmdlcyB0byBoYXJkZW4gdGhlIENSIHBpbm5pbmcNCj4gaW1wbGVtZW50YXRpb24s
IGFzIHRoYXQgaXMgYmV5b25kIHRoZSBzY29wZSBvZiB0aGlzIHNlcmllcy4NCj4gLS0tDQo+ICBh
cmNoL3g4Ni9rZXJuZWwvY3B1L2NvbW1vbi5jIHwgMTkgKysrKysrKysrKysrKy0tLS0tLQ0KPiAg
MSBmaWxlIGNoYW5nZWQsIDEzIGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0pDQo+IA0KPiBk
aWZmIC0tZ2l0IGEvYXJjaC94ODYva2VybmVsL2NwdS9jb21tb24uYyBiL2FyY2gveDg2L2tlcm5l
bC9jcHUvY29tbW9uLmMNCj4gaW5kZXggNjFhYjMzMmVhZjczLi41N2Q1ODI0NDY1YjAgMTAwNjQ0
DQo+IC0tLSBhL2FyY2gveDg2L2tlcm5lbC9jcHUvY29tbW9uLmMNCj4gKysrIGIvYXJjaC94ODYv
a2VybmVsL2NwdS9jb21tb24uYw0KPiBAQCAtNDc2LDggKzQ3Niw4IEBAIHZvaWQgY3I0X2luaXQo
dm9pZCkNCj4gIA0KPiAgCWlmIChib290X2NwdV9oYXMoWDg2X0ZFQVRVUkVfUENJRCkpDQo+ICAJ
CWNyNCB8PSBYODZfQ1I0X1BDSURFOw0KPiAtCWlmIChzdGF0aWNfYnJhbmNoX2xpa2VseSgmY3Jf
cGlubmluZykpDQo+IC0JCWNyNCA9IChjcjQgJiB+Y3I0X3Bpbm5lZF9tYXNrKSB8IGNyNF9waW5u
ZWRfYml0czsNCj4gKw0KPiArCWNyNCA9IChjcjQgJiB+Y3I0X3Bpbm5lZF9tYXNrKSB8IGNyNF9w
aW5uZWRfYml0czsNCg0KDQpDYW4geW91IGV4cGxhaW4gd2h5IHRoaXMgY2hhbmdlIGlzIG5lZWRl
ZD8gSXQgcmVsaWVzIG9uIGNyNF9waW5uZWRfYml0cyB0byBiZQ0KYWxyZWFkeSBzZXQsIGFuZCBr
aW5kIG9mIGlzICJlbmZvcmNlbWVudCIsIGJ1dCBubyBsb25nZXIgZGVwZW5kcyBvbg0KZW5hYmxl
X2NyX3Bpbm5pbmcoKSBiZWluZyBjYWxsZWQuDQoNCg0KPiAgDQo+ICAJX193cml0ZV9jcjQoY3I0
KTsNCj4gIA0KPiBAQCAtNDg3LDE0ICs0ODcsMjEgQEAgdm9pZCBjcjRfaW5pdCh2b2lkKQ0KPiAg
DQo+ICAvKg0KPiAgICogT25jZSBDUFUgZmVhdHVyZSBkZXRlY3Rpb24gaXMgZmluaXNoZWQgKGFu
ZCBib290IHBhcmFtcyBoYXZlIGJlZW4NCj4gLSAqIHBhcnNlZCksIHJlY29yZCBhbnkgb2YgdGhl
IHNlbnNpdGl2ZSBDUiBiaXRzIHRoYXQgYXJlIHNldCwgYW5kDQo+IC0gKiBlbmFibGUgQ1IgcGlu
bmluZy4NCj4gKyAqIHBhcnNlZCksIHJlY29yZCBhbnkgb2YgdGhlIHNlbnNpdGl2ZSBDUiBiaXRz
IHRoYXQgYXJlIHNldC4NCj4gICAqLw0KPiAtc3RhdGljIHZvaWQgX19pbml0IHNldHVwX2NyX3Bp
bm5pbmcodm9pZCkNCj4gK3N0YXRpYyB2b2lkIF9faW5pdCByZWNvcmRfY3JfcGlubmVkX2JpdHMo
dm9pZCkNCj4gIHsNCj4gIAljcjRfcGlubmVkX2JpdHMgPSB0aGlzX2NwdV9yZWFkKGNwdV90bGJz
dGF0ZS5jcjQpICYgY3I0X3Bpbm5lZF9tYXNrOw0KPiArfQ0KPiArDQo+ICsvKiBFbmFibGVzIGVu
Zm9yY2VtZW50IG9mIHRoZSBDUiBwaW5uZWQgYml0cyAqLw0KPiArc3RhdGljIGludCBfX2luaXQg
ZW5hYmxlX2NyX3Bpbm5pbmcodm9pZCkNCj4gK3sNCj4gIAlzdGF0aWNfa2V5X2VuYWJsZSgmY3Jf
cGlubmluZy5rZXkpOw0KPiArDQo+ICsJcmV0dXJuIDA7DQo+ICB9DQo+ICtsYXRlX2luaXRjYWxs
KGVuYWJsZV9jcl9waW5uaW5nKTsNCj4gIA0KPiAgc3RhdGljIF9faW5pdCBpbnQgeDg2X25vZnNn
c2Jhc2Vfc2V0dXAoY2hhciAqYXJnKQ0KPiAgew0KPiBAQCAtMjExOSw3ICsyMTI2LDcgQEAgc3Rh
dGljIF9faW5pdCB2b2lkIGlkZW50aWZ5X2Jvb3RfY3B1KHZvaWQpDQo+ICAJZW5hYmxlX3NlcF9j
cHUoKTsNCj4gICNlbmRpZg0KPiAgCWNwdV9kZXRlY3RfdGxiKCZib290X2NwdV9kYXRhKTsNCj4g
LQlzZXR1cF9jcl9waW5uaW5nKCk7DQo+ICsJcmVjb3JkX2NyX3Bpbm5lZF9iaXRzKCk7DQo+ICAN
Cj4gIAl0c3hfaW5pdCgpOw0KPiAgCXRkeF9pbml0KCk7DQoNCg==

