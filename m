Return-Path: <linux-efi+bounces-266-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B18D78194A6
	for <lists+linux-efi@lfdr.de>; Wed, 20 Dec 2023 00:37:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ECDC0B2141A
	for <lists+linux-efi@lfdr.de>; Tue, 19 Dec 2023 23:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF3813D0D0;
	Tue, 19 Dec 2023 23:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jtiVQIAd"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E44283DB80;
	Tue, 19 Dec 2023 23:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703029023; x=1734565023;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=s9aeYaEOxaEGRDMGxxA7yFEJluIp3L5IMRQyR1E6+9g=;
  b=jtiVQIAdxlZZSZUPk+vgxsh/LT8shh7IpIgmoPQm2EEqid/SlKwnEbF7
   x2MkxGveeofw86NEALFNpMiaOqK0D79bqcITlFq+YDaEx+xoZQzKuvNaF
   U6oWgVcy7LfnSzX1E51nWioJghspHJJYq5k+kDkKHOmYNedeT7knYJ8s1
   h9D9MFwdb54Qnz6McgsgGRxueXK6YOdAYFIBJkBxouUKOM3vWYsTXgIcM
   4awO+UldlgV3EkjQ/B9/r/gIVf8GE5IHCP9B9OBHhhqYu92dkk0lRmmxb
   obpSP5H51XfhRrkFKbBwyaexSO0gem3njGGcaSwd4CB8j3/uTP5f2Q+bw
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="2826504"
X-IronPort-AV: E=Sophos;i="6.04,289,1695711600"; 
   d="scan'208";a="2826504"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 15:36:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="1023292968"
X-IronPort-AV: E=Sophos;i="6.04,289,1695711600"; 
   d="scan'208";a="1023292968"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Dec 2023 15:36:47 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 19 Dec 2023 15:36:47 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 19 Dec 2023 15:36:47 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 19 Dec 2023 15:36:47 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 19 Dec 2023 15:36:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hjD+bpMgSi9M/A6vSbQWluake8F0eT8S41yZIUlq1ycE3oQX2mkG4M5HPrn+IwsKN2cqHpO5qLD1ex18CYRBSRARiSiMd8Zxaow/2pbc0f1zddHuQjv44vAKUlj5w+/PwOL0HwzaQJLt3VK3b7b/ykLTX7IGr8PId+ijlvRnyQKjuaIFUDDR8ERM2ZwEERwmSvCbtMGf2kyXMKHI/Xz5JmSRFFRiNnqlAwXT72vQBwgRNQudgyFkwuuyc41K+ALdh1cS9jQ5KiE/ArBydtmDKW3VlgY2GORfuq/iXXlvLVOKZacy4eY4At46Ew3tbbefIRDpLD3nie2HeuhVGG2PlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qF25wnZCZMiB5oO/TJ1BKe0DU0i073Q642QHKBI7U5o=;
 b=ny6Pus6vDey1QMqSPigpENUrrmmxiSrMs5Jj8ccQnb3BkUlecln6TEG9U/h5ox149AtoRSOBRzYzu4+XTGibZeOysOWfQ8IwYf536mM/Uw8i8pOuHFQRq2hXHjJpVsjuXvOdegH2utyP5TquKPHV8g0y6ssWf3z9J64FOtefswE32yoIY+XCSM2wt+WEma+xIRVlJ9j9LZrA51yvLx0harxfXs1U7JbKVpA6crCrRQq/It//js0nJe3okb7MWRKLbo8GSgWwA4wfbFbpJ9AxOEOD6+S2xGuLPI1QLHxhHR+VJSNlc8wmiQir13AZnGJRqRngGcxCcefap9wSaYpacg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH0PR11MB5109.namprd11.prod.outlook.com (2603:10b6:510:3e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18; Tue, 19 Dec
 2023 23:36:45 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6362:763e:f84b:4169]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6362:763e:f84b:4169%5]) with mapi id 15.20.7091.034; Tue, 19 Dec 2023
 23:36:45 +0000
Date: Tue, 19 Dec 2023 15:36:42 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Ira Weiny <ira.weiny@intel.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>
CC: Dan Williams <dan.j.williams@intel.com>, Smita Koralahalli
	<Smita.KoralahalliChannabasappa@amd.com>, Shiju Jose <shiju.jose@huawei.com>,
	Yazen Ghannam <yazen.ghannam@amd.com>, Davidlohr Bueso <dave@stgolabs.net>,
	Dave Jiang <dave.jiang@intel.com>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Ard
 Biesheuvel" <ardb@kernel.org>, <linux-efi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>, Bjorn Helgaas
	<bhelgaas@google.com>
Subject: Re: [PATCH v4 7/7] cxl/memdev: Register for and process CPER events
Message-ID: <65822909ebe4c_269bd294f5@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20231215-cxl-cper-v4-0-01b6dab44fcd@intel.com>
 <20231215-cxl-cper-v4-7-01b6dab44fcd@intel.com>
 <20231219143732.0000181e@Huawei.com>
 <658226c9a49f3_277bd294fb@iweiny-mobl.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <658226c9a49f3_277bd294fb@iweiny-mobl.notmuch>
X-ClientProxiedBy: MW4PR03CA0079.namprd03.prod.outlook.com
 (2603:10b6:303:b6::24) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH0PR11MB5109:EE_
X-MS-Office365-Filtering-Correlation-Id: 937ae4ca-ee74-44a8-799b-08dc00eb5c94
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gxyXnxt+xFQK0soINOicEGP0dWy6QEp9d9uTO7+MWpKjCtlT+QjkzD6OVHZz9MWzE98WiH5hbed5x6dLNTX1Gx7JZ/8pExG6I8rYvgyPb2iSRGfMwu0rT4qOdJpjEyjQA4OR00yAMsV02+y8BopE/LdLRjhQCSgrj2LImzR4WLFjk3zCktQEmelWQEk9Cm5cB8gvKmrC4M/3dqx4v5Odm9d1yZ8PEJVE4yCSdl0jhzifCuZ+CgdlmyWLCo6tpeo7hCaz3vnlZXfFFVpS3wB55wAFhDFutrw3jeYLsCPuFreVYggaJXOXWWWXnFOYgwG2oGH+lN33r8cJ8qBntgfS4q84j7++B6GBFt5IYdGJoB66Wrh328Ks/0jOWnSXdRmehcgHQzOaxvyDCzngiuf3ho9jkLwgbbF5My99YjfqBpnRjWMaUOt2+X8rs8RGMUdofDk/uyWbb44I4ogBNLlxoke59DqN1D6vQHiusodV1Sg7OSXFKjFopOFRVtanJnQK82o+j5LM+2FyVCWUft4U1mT+B4U/EPYiPEacs31RS86iO6ITJPw/xrLl+AQUg15L
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(366004)(376002)(39860400002)(396003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(38100700002)(9686003)(6666004)(6506007)(6512007)(478600001)(26005)(41300700001)(86362001)(110136005)(4744005)(316002)(2906002)(54906003)(66946007)(66476007)(8936002)(66556008)(8676002)(7416002)(5660300002)(4326008)(82960400001)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/knYxTe6qsVkCAApHUylQIcpi90X1DKLkrayBVRqYDk/8LpvkgZIjXvGUQUR?=
 =?us-ascii?Q?kxCeQQAGWVPw448fUedMa4sQRHFHIcNQpsAtkALEFWrcYHBsaIkRgVrPDuSb?=
 =?us-ascii?Q?H6dxr065uX9335ICShcOUtI5/7YZWddlovtFh5W9A1wrA8EMND3BFQqd9DPi?=
 =?us-ascii?Q?6wUrQ02G7eW+ryiOP8T6sCPcawJm76i3TxFoDLCK1XsCyrmiKZmJoMvWYXpt?=
 =?us-ascii?Q?M7MIrQI0Mtig4gwC3sHhW2vudXJr0yAKP4yAOS444M+eJb3kttFKjMEVGgN+?=
 =?us-ascii?Q?FCCz51RD98NBMqdf29Stf96G4WzcHF6Iz58vypAPVT6UBplaAmqGMhGL5F3k?=
 =?us-ascii?Q?2crwIyE3ukbfSZopZjULMmY89VQvNU2ymkm1n/16p6mWNBBiAqJFlCuXLW8r?=
 =?us-ascii?Q?oTfDOlbezgM2Ctt0JSbOH+bXyKs8kTCx+RwYpe2xT/+9zVkYiyffTwdFiRQJ?=
 =?us-ascii?Q?1VzQp3ZE/BvO0vRKah2OI3YGUlPbidcteo7F0WokpFEKGLYo4eZBTs1LfCzc?=
 =?us-ascii?Q?yyLzEOTE2r/R7vageu0e8nt2PObJqYxlR/Gm9ir65nJYOS/rAJxJjqTZFpDI?=
 =?us-ascii?Q?7bF1Q5WpTQc9cVBWzk1dvwY2yTL1kA6w8AnkHKVRq3gyokrvUzpltELynEP7?=
 =?us-ascii?Q?0eLkrW3did/p3zJ4z1x+bYEaMmJVt0Es97OPMksL3RiZNDtLtuE6gCA2PH7l?=
 =?us-ascii?Q?m8MfcEUT/Si7GgBNMo3GEyTmZDeV9IXU09jKyMWmWSWACypErkTwFFw8pKRB?=
 =?us-ascii?Q?p1fa3tXfSZY9qO5zXeHFMO/RTnjCR9v/mCX1R6WbhAVo9ADtiYfe2dAq04tu?=
 =?us-ascii?Q?n9HMSMKMQJSZjztWhgOAX3/7Mz2dLZC7aW0ixCIgWuM3kc+t0c+gIxeNgXRZ?=
 =?us-ascii?Q?Wo1gJBEMjh0kOr2o5Zy9JP2sroAebPZxDPFDEMFMEQbZVpQhwDf1lIJkIRpf?=
 =?us-ascii?Q?qfonjfVbzAEvSTVgBoKEUPYNzCMLplhoCBCkVT558hG8jYk3ysdLHyOstbqh?=
 =?us-ascii?Q?4GylMeIu//3fvRr7H2uh1bANhEUWdW6mcgTBXoyk7fU0uCsOKth8LiAt7Llq?=
 =?us-ascii?Q?xODpEPptNc19PgdypUCVX+kMGlR68dPoNRrUlo+IKE1vv60U+cisOQydx8rZ?=
 =?us-ascii?Q?0AuBRMgnJ/Dg3d+rL9M9QEMxUr6MjXY99MkKiCjE+lLa3zWHm4c0Zj7bGXjk?=
 =?us-ascii?Q?Kwcs0ByUV+kBJ2yn5sy+gVCJzbQs/yR/sWInTCbrmbFOE18shW5kgPCyP+Ra?=
 =?us-ascii?Q?5Ue44oP8kGWzvQ5A0f7mAjiG84o5w3qJsudZ3V7QmMtHKV9tiS4xzjzNneJM?=
 =?us-ascii?Q?euzB8/916vaUdmG12Zk1oGiKt6LgicDTi2AJ2jSTRck4YPTyygj7UNRBrqFw?=
 =?us-ascii?Q?OuSvshDRL7AWJ+s8O0h3rcs0ySrgFNNaDTvHDiMpQR7dSNAQQ8djHBWhRECz?=
 =?us-ascii?Q?wFX9GPN6UsQn3ig6V5R91z/Q5caWOx36tJaKn19nkD44VMjpdd3mu3TyowKT?=
 =?us-ascii?Q?ekt63FKj+HaEsTbWnx1rIfbfoUoNjVViWjWOBuQEWQRSk4HeMjuN9AEckruI?=
 =?us-ascii?Q?634CgpmwkG5NwCFSs32jMPELAofn1eNhJcFHJIhV4umd+BK07O9OfgosqB9S?=
 =?us-ascii?Q?dw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 937ae4ca-ee74-44a8-799b-08dc00eb5c94
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2023 23:36:45.1617
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LwOjog9g88yfSrJk9qOom/Q7jsCHyJaE+CNMj0XTX2srY/R2DjH6iPZ5Qc9Rkss4UsNprfdrFIywWNXDo+oIAvVNFlB4n6Bx+jLc7mosLFw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5109
X-OriginatorOrg: intel.com

Ira Weiny wrote:
[..]
> > and drop the = NULL above.
> 
> Done.

The NULL assignment was more about making it clear that
__free(pci_dev_put) will take no action until the pdev is acquired.
Otherwise, any future refactoring that introduces a 'return' before
@pdev is acquired needs to be careful to assign @pdev to NULL. So, just
include it in the declaration more as a __free() declaration style issue
than a correctness issue.

