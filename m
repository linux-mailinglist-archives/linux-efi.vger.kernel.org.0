Return-Path: <linux-efi+bounces-299-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 03A6682228E
	for <lists+linux-efi@lfdr.de>; Tue,  2 Jan 2024 21:29:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80F011F234FA
	for <lists+linux-efi@lfdr.de>; Tue,  2 Jan 2024 20:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4AA616413;
	Tue,  2 Jan 2024 20:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JQzyv4+S"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12CE116406;
	Tue,  2 Jan 2024 20:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704227361; x=1735763361;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=DLbtB5fYsltpt583Zt17NGLr91w4ERN1ROzT5Eylqhs=;
  b=JQzyv4+SfNB6u2zWFKl5v96KPTzfPZuxbeXk3tjZuq0RnweOlp1qzU2N
   Bpbp+v5kTSGSZhbGTgP2//u9+mx7Nqfz0ysEEk/XEe/7XkPLnXBJMQQsX
   wYS3HHY05CR4kHqOh2Scvv7JL/d4Dzx+MkqPqAFiK0AHYRbVS0uhknGAu
   Oil9eRcvjrAJDURdNgFAqX4NBT7YnExZICb6SX2pd2Fq6CsTysXXnFNtk
   nd6VcX9FsDVP3fSIOXyyp/z4zcLmGc/EMMJrzweHORB8goFGXjqs/VYSl
   kVPy0jb12mig5RSjJ4sCKFCBR2iIiATRIKIKi4PqxoJAMPGuK3aU/fmoi
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="18459445"
X-IronPort-AV: E=Sophos;i="6.04,325,1695711600"; 
   d="scan'208";a="18459445"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2024 12:29:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="772943140"
X-IronPort-AV: E=Sophos;i="6.04,325,1695711600"; 
   d="scan'208";a="772943140"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Jan 2024 12:29:18 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 2 Jan 2024 12:29:17 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 2 Jan 2024 12:29:17 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 2 Jan 2024 12:29:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nAUQYoEe4q2PgX8IuxSpmqvQmX9I9UhX/BYDyi3xGkYTQ91kiJo8EFdiTVOxperVbOeyGiQvJj2g/PQ9bcIQerxwqf0tIA8fxw2XXckr9i3QVw3uIR0L2+UsxxPOSYqdMp7cxbkQ9mv2nTLnCSa34GuN5xTUPfu+R82G/eqjuHMGMyM+zpjcDZ1K1X+HXC7DdbW8WWOKwFs/J6DqHbicImSFAC1anRZFiuUkUPn2lNzgfpQ0Hz1pG7KdklMRmakhYd8qAChpGAye+tmHjJvCVs0o6dIo/SX22Pvt89VbvcBtpK/mh52aQ5qTkjIPrhK5EqoSybUQmHhuwLlmaX3ZoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LEszyWH8j9kbJNBtgK9lgYK1GSfsbHbAxuMttE/6X3A=;
 b=hSQwONm39iCeeQDEXmcL9F2StcG4M5JlvD9XMfofNWcmO89WcojyGvUIdoXeJ+alY0/Fqrd4FRd8q/p9tXPQr5ojpL5JjWDNEz6TClTXQE8nnYmO2gWnT0ONRyhBbcAwuSsW/kY14X0b4F+fMBpqaE27NXzD46DJ+30Ku2WViWLMKm3/RboxNxxTuC4nLa/0p6VEINPg5kY/YKNoyqFHNnbYhzPt4cXpaE0C7bMw1LysTPav0NIrcOJgUT8V6OvjrLXiXGkPDYQqWCEidOhGk7MdXIyUCJy6mjjeYZwVRRNsz9bq0NPRkZqN1tmDGeTZRuw+D/AZfVOdh/h0rAIlBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by SA0PR11MB4752.namprd11.prod.outlook.com (2603:10b6:806:99::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Tue, 2 Jan
 2024 20:29:13 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::da91:dbe5:857c:fa9c]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::da91:dbe5:857c:fa9c%4]) with mapi id 15.20.7135.023; Tue, 2 Jan 2024
 20:29:13 +0000
Date: Tue, 2 Jan 2024 12:29:10 -0800
From: Ira Weiny <ira.weiny@intel.com>
To: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>, Ira Weiny
	<ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>, "Jonathan
 Cameron" <jonathan.cameron@huawei.com>, Shiju Jose <shiju.jose@huawei.com>
CC: Yazen Ghannam <yazen.ghannam@amd.com>, Davidlohr Bueso
	<dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Ard
 Biesheuvel" <ardb@kernel.org>, <linux-efi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v5 9/9] cxl/pci: Register for and process CPER events
Message-ID: <6594721656849_151dc12949b@iweiny-mobl.notmuch>
References: <20231220-cxl-cper-v5-0-1bb8a4ca2c7a@intel.com>
 <20231220-cxl-cper-v5-9-1bb8a4ca2c7a@intel.com>
 <80a5515e-4eae-37b7-08c1-03573ec4e37c@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <80a5515e-4eae-37b7-08c1-03573ec4e37c@amd.com>
X-ClientProxiedBy: BY3PR04CA0028.namprd04.prod.outlook.com
 (2603:10b6:a03:217::33) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|SA0PR11MB4752:EE_
X-MS-Office365-Filtering-Correlation-Id: a135c37e-7de1-4d01-5f1c-08dc0bd17c09
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3k9fPBJacDEEFdoo1yTxQSn+JjCqxfhMf2iDhXmKV808eNuaS4y8syGhvVSXjfNL96tLbeDDSng4H6RNYuCh7ippYPJ2BWBwcBZawo11e7Y990+2N6tXLjqlB1EC+a8fCmQH4O/Ec7lkUNLPPlaXXsWVmjAwvPCQoDZ4ZPXlm2pqFB9QNIKyxWu72VVKGJ41ED7x+r1C/n8yFr2ndRwvmFMjBSJ+tWwKgHepWdVHLbOljUoykrkIh6CQCy3LPLxU6Tpq3uW4myoSDkmDUtZqoPHM4KrKnPxtI/RS1Kluvpm7Rbujfgm6NXbu39AbWAUnvSIqnrTKWPP6LsgoAS8e5GynD3PhCK22mPo/0yFPSzW92cDCxVErmUQiw5d8sVMfEA6mLAEUXnPlGDVcOAiw9L5/IZjj0stp8kk5r+A6wbRnobQncK6gpwaOn5E5HCpVW9OYu+wyBb26XsTHFwTp2e5T038EmxjWwF+Qfy3JCFuI8GAojSMsISQS3L+6bHHz7oeqK9DFNULAWxwTwNx385/RzikBVWhKIFmIcL0iCpM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(396003)(346002)(366004)(136003)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(9686003)(66556008)(66476007)(6506007)(6512007)(6486002)(86362001)(66946007)(38100700002)(4744005)(82960400001)(26005)(2906002)(4326008)(478600001)(44832011)(966005)(41300700001)(316002)(5660300002)(8936002)(54906003)(8676002)(110136005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GBybZdbQZL0FZMAFvjXlDzk8IU8i863WBfKdKzM95q2tA9GsXa0uaqN3OP8B?=
 =?us-ascii?Q?oSIV+4pJ7y1mtnzSA0qVimiEdER1Uqn2DS0OoHK5ZhBib7xmGo1FgjZOpPuq?=
 =?us-ascii?Q?XV+2xpsFYbLPeXRH5nnwV1arbwdT+ooa3GYu7mTuVwy0h3czga+j7TxD8UJ0?=
 =?us-ascii?Q?Rwnh4WqPW2lh8nz7cd3HjlSQZvVWMewQWgoro89cenIH/KamIdO8nj9oRWho?=
 =?us-ascii?Q?1Rmxqr3PDC1awFjLjs9yCnUFtjEZjg/USzOP/X6x5qSZ0zJ5loH1KSJ4bjK1?=
 =?us-ascii?Q?Ec5uyO+TXoMbvJZL63JaSybakwXmxRU4yJDN/9/Q5CvDyNsuxQgIbm8890ei?=
 =?us-ascii?Q?5dUvp3lbyJcGIi9MDztKcMteYppln06YApTLC6uh3hZxpKcYdn4/rjq09unw?=
 =?us-ascii?Q?Shk4jev+g717iXHnfiOCr8WvcAYYHDTGCt9IiTJg9DFnE5KisY/h0ll2hcwW?=
 =?us-ascii?Q?pj1KHiZisFpZM59hpftOteLMRB6LiPsC+lm0upM/Ka7MJxz13S8UvFaeIsEo?=
 =?us-ascii?Q?sv7nW/YZetTmU73HVvdR7n/GBdk3WebTHnDLE9v3xMhsWPsaZavspDKD2DPy?=
 =?us-ascii?Q?v3EL1HIQNfdydj6g4jGqaWU4TLFhxyyZJdiBGkFkgiLwWOnKa1PSC1bjuzDp?=
 =?us-ascii?Q?ZRaO88JOd95a4KKC+H6K/CmEwPQcyK/V2pNtp79nhb94nVBDmrVtxs70x4XB?=
 =?us-ascii?Q?yvTUIfK3P6pTZffKN4VMtYJoujY5FN0IJ5taUV/V3O+cV0y8gFiLQE0PQhiW?=
 =?us-ascii?Q?Fk1RLNvezUEvlkD0c8QpXzZLO/D0SoEVBrW8iVKrE4k0ffmamaM+DJCRbpcO?=
 =?us-ascii?Q?YeQzWvfCjW+zAUL61JKWpKsyq6AUPBF3CZd/VCTLiwQG+P7gMQjsOqNVeYBn?=
 =?us-ascii?Q?SIL6Vbf4Q1s2XYNnUAeMGri8U3tDYIlZ1rkzGi8v9JGKPdXttbVGtwmn0kbl?=
 =?us-ascii?Q?hKl2e5GCeGJuMvcJhdWD+Q2DhwbJ4U9zYCTCVNwR8TDDc+fsAHoUJBddT9bg?=
 =?us-ascii?Q?mDYJF41jJEAF+Vnq1EykZKCYdxRHRzCzr9w/GFpp4Zvdd0cVzHpqI7XPBJls?=
 =?us-ascii?Q?Q8y0QXd80Fyi5ntMEEbhk9+SQ1jMmAnWvzWsiqX1h1K3sX7vhy6Gc5MGbU2f?=
 =?us-ascii?Q?e+v0hIjrrClgzCLuCsoGLrmzu82l+8zYxDdlgqsi8nfy8DmXBeCex7ab2xom?=
 =?us-ascii?Q?MsrB36G1oTL/Iloy356gz0rO/iEZkU9r+L29xcEde7M9qc2DVNB2MfqV7Nbm?=
 =?us-ascii?Q?kXeQR6Scc40dJuIL+cdjI/4ZwBkeMAPJWWYs5n+PxwHmduMEbhhkbkHW4yZV?=
 =?us-ascii?Q?E/zhophWFrQpmG8UXU+f64DVnHSLoA7CsmE4L+YZQkSjP5YNIKpNsUlyamd0?=
 =?us-ascii?Q?mSgpBVuFT5qPHufpAzc7eKagvcZHg/VLV3DyhBA2AccsX+2Y0S3tJzfDW7Xw?=
 =?us-ascii?Q?9FqTwGB3BPu3bxC93CkpsnobdEXOK8E1TkhSUFkg0Q9tMHTFPXhTFQq83wu6?=
 =?us-ascii?Q?IScHURnarwjRYMlaoxnkSuvaM9hWRA35sidvY77qJUAp6x1BAiuGkG/ESB+K?=
 =?us-ascii?Q?63zPTkr88u0WiBZfU5YKGOPDDqr+NdW5AsSFWofz?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a135c37e-7de1-4d01-5f1c-08dc0bd17c09
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2024 20:29:13.8774
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zi5mmflK3hNcO1M1HGw48p4duT6NTOdHk3iZtiD73Ip2AamQxwo2fF+OmVphVisCs3kdVyR6LU67MM2PIKtYOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4752
X-OriginatorOrg: intel.com

Smita Koralahalli wrote:
> Hi Ira,
> 
> I tested these patches. It works as expected.
> 
> Tested-by: Smita-Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
> Reviewed-by: Smita-Koralahalli <Smita.KoralahalliChannabasappa@amd.com>

Thank you!

> 
> Since, the trace support for FW-First Protocol errors are missing I 
> wrote a patch for it. I reused the existing registered callback 
> cxl_cper_callback making some changes to it. Please take a look and let 
> me know what you think. I'm not sure if its appropriate to reuse the 
> existing callback or define a new one..
> 
> https://lore.kernel.org/linux-cxl/20240102150933.161009-1-Smita.KoralahalliChannabasappa@amd.com/T/#t

Awesome!  Yea I just went through it.

Thank you again for all the testing!
Ira

[snip]

