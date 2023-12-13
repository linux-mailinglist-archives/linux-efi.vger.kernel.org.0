Return-Path: <linux-efi+bounces-197-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E620B810664
	for <lists+linux-efi@lfdr.de>; Wed, 13 Dec 2023 01:17:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1137C1C20E21
	for <lists+linux-efi@lfdr.de>; Wed, 13 Dec 2023 00:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 487AA38D;
	Wed, 13 Dec 2023 00:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P/2+aiGJ"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA06AD51;
	Tue, 12 Dec 2023 16:17:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702426629; x=1733962629;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=UrLOssPdbk/vOgYAba8KHbSJNrsauMLwKwHHtgJpkuo=;
  b=P/2+aiGJqeWwhgOnEyVO+4Vqu1lLBiyHtGuOXyFvxWvJGNTQ7UIaa4if
   +898CT/+NdkeDovLqdcv+cArkxw8u+RUhKcsypsRSEzZWdNK6fk3k8ix/
   DFHOUkNNy3l3uvgXetUF3Mj/qAdwWPdutCyZtUTSRr19S/IlEdzzp4fjU
   PGo7FhCSoZEsB3qS1KicMGVHYF0f2ZylzwkmkZ2yLJxGw0X2vPq9rr2w9
   VGGT+nKJFJlXf/S8k/AfGPCVg6DaN25fGWd63v/ZInP0B3bsRLajEMwRI
   1lyXOCUOpwDCS+8q3wU4GbzuTy/qkCGZy1h8ML8c8J2l3A1drUuRMstq1
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="8266699"
X-IronPort-AV: E=Sophos;i="6.04,271,1695711600"; 
   d="scan'208";a="8266699"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2023 16:17:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="807970868"
X-IronPort-AV: E=Sophos;i="6.04,271,1695711600"; 
   d="scan'208";a="807970868"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Dec 2023 16:17:08 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 12 Dec 2023 16:17:08 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 12 Dec 2023 16:17:08 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 12 Dec 2023 16:17:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hw9VbhfkR15CIY61qOOulOoU9fGnAT8UprE0HQOhbK+UfOtTNqUKl/+ZV26Tw5LmZ2o+PIZbvy/nMyR+jnoqeFQXXiof+cxxAXkTGu5sg4BcNKPk24IXJXm1gJA0R309hkqQFDJX9BCcbylK1cbprnqgs46bDzrhGAm/9oz2TjBm4gkWKGgBn1iPymg9c/ovEGCOnoI+Anb1Gjz+pod5XuPluuqCzDe9B46+/INT+ZRIKzwVKv+82NJUflz8Xo2FHaQSx5FYJcbu1G9zq07uOLX4nxgabOLIkVGzYuY+g4Es1LyCCTPk5tYVq3sFcrXdkwbd9JcbVhRnf9u6F3vPvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wtVrxLHWfeG3J7Fby5DngKX54XvhHuiVptbkcnhJto4=;
 b=Ch7PTyLKDWLDDPSsfXJSUWrMDk+jGFgAKEq6Pgg9Xwut75f47jxqz2cgjfYiPnszuzy+RnG8QCgKg5YzcX3DYoCkI19v+FbMkyOzCfbjatR2bYbl74ThCvijXoZm/6KP4MwkAVoi4HMtJrH458x6GLMk6zMammIPUTeVjNS67J3ZQdFrTKzZv6RTfBQcwmKQmLpI6ZhJE1wzugGT0AXzDZ6Zzue+m1lY1iJlveNsWxtKT5+mKjZr0wXLrG8lKGkHcx22FZqAvzLE8aeuicxf4LyfVUOE6lnpGqWAa7JM3+AqbTDW7Zy8pD7B3X2BeYAMoS73kfANzMgCJ65ZCkHYkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by CH3PR11MB7201.namprd11.prod.outlook.com (2603:10b6:610:143::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Wed, 13 Dec
 2023 00:17:05 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::da91:dbe5:857c:fa9c]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::da91:dbe5:857c:fa9c%4]) with mapi id 15.20.7068.031; Wed, 13 Dec 2023
 00:17:05 +0000
Date: Tue, 12 Dec 2023 16:17:00 -0800
From: Ira Weiny <ira.weiny@intel.com>
To: Dan Williams <dan.j.williams@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>, Smita Koralahalli
	<Smita.KoralahalliChannabasappa@amd.com>, Shiju Jose <shiju.jose@huawei.com>
CC: Yazen Ghannam <yazen.ghannam@amd.com>, Davidlohr Bueso
	<dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Ard
 Biesheuvel" <ardb@kernel.org>, <linux-efi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>, Ira Weiny
	<ira.weiny@intel.com>
Subject: Re: [PATCH v2 7/7] cxl/memdev: Register for and process CPER events
Message-ID: <6578f7fc4e04a_22539529429@iweiny-mobl.notmuch>
References: <20231211-cxl-cper-v2-0-c116900ba658@intel.com>
 <20231211-cxl-cper-v2-7-c116900ba658@intel.com>
 <657897453dda8_269bd29492@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <657897453dda8_269bd29492@dwillia2-mobl3.amr.corp.intel.com.notmuch>
X-ClientProxiedBy: SJ0PR03CA0191.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::16) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|CH3PR11MB7201:EE_
X-MS-Office365-Filtering-Correlation-Id: cd86c513-6bcd-4547-5fce-08dbfb70d5fc
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DUWWWrUJXtlAhQj6Gk94MMQe2+cuMUCUyjiaASETXjuk7aqvokBxMGeeCH+qWUYCSXknPJcvKTofxRSMWVFKmByi9plSgyE8sLtGXLiDoX1QhaxEBi8TdJSMEJ8AJK7CfQ59ftntrMgZjz8FX4FO+pw+h229mDyPaUDCsHvxoG6RHYHavXuEN+w8rQ8tzix9qkCqusnUgjR2fr0ZfFZ9v5QqhXj68OL0Or94d1XwZy3CQi8rbosxbtE94AwuLeJ5+27F8r4n5tAnept/m4K6bBbIdMmV9CiZXobN4dvD/LFdAvGig9Uw21Me28HbFCEFoeyVad7jjGhcZb6QYfB4UEbexQNRdgjsuq20SAtjpNCQZTpyHz7ISSmJ31Ex90L5M3Mo6/JD+WmOvZsgZV1/u6wuN/pANuWoNivnbLQbH5KUXi/4YGn3C4/602faKzczM/Upw+jUV8O9KOndqBYr5uT704iq3tefMtWnL4UFR/tPs9G5PzMgGUfEXc+3MelsKtiP153O9HZfRWviozYO+mNGPWXtTJZ/ePs6tN1W88JtpQjtQQVNj6vT3EsuWsdo
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(346002)(366004)(396003)(136003)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(66476007)(54906003)(38100700002)(82960400001)(66556008)(86362001)(6506007)(83380400001)(107886003)(66946007)(6512007)(9686003)(6486002)(110136005)(2906002)(316002)(6666004)(8676002)(26005)(478600001)(5660300002)(4326008)(8936002)(41300700001)(44832011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tfSacMdk0WE/U0aRvoKJbH5zV8fa2GqCpWsRT0MjtgORYWIl2++HovJSZshP?=
 =?us-ascii?Q?LAsOp5KsQV7OGu3FXfOj+yw7/Wi3P3GBG7AFPt9Ew9N4w7EfJ1JAYKqLrzIz?=
 =?us-ascii?Q?K0hQSFyS3ClvyeO6GiiOTyBDeHdKkXP8ApQ66iAY1Q41MNMWjYn93TZ+dwjE?=
 =?us-ascii?Q?sdkKLoMasjYd3dBwwEWv8eVxeKvEVPEQ7C2lhD0yZNm4rfDSr7HIKOLlxHPG?=
 =?us-ascii?Q?6MiQMHklmuxWCMBiDnD8ch0/D/l6mN7sPBhk1sWZy0nq1ju2KXXQxhLmy4rt?=
 =?us-ascii?Q?muss/2tiALjLatbdbzHiqmO4xhxvYSN3bIqQ/1gRvC9Ppi1ffHIY2OPZIIVO?=
 =?us-ascii?Q?yLPF6cKeXhhRPytF+00tLEIacAC8H28ujetZq+esKFbBVADB5e3oG7rJAehX?=
 =?us-ascii?Q?scFkHcOBw2nuohfrhuGhJ5qzOn9lBkSR8b2af2CknWOzaznDdq8q9tulZlaH?=
 =?us-ascii?Q?rVPtH708k20QiJoqzMJAMr6Ey5oFEJQuy3qVQorYOkFdUYXKDrfBs2NeSNsy?=
 =?us-ascii?Q?Fl6iKextO0Ue+nmFvGEU1dthHOFUt2+32+eeXrNentxYbEYxtvZu+KtRM6xh?=
 =?us-ascii?Q?2qTollfyBMBWGEXaQ1WS7ubRbB1m+3PC55FZau9EA8gnLbG8x3OpmXY2JQAb?=
 =?us-ascii?Q?j/iax13+pqmrh2oBXfl+BVqGEgcV8cSjW12IUSOFcS7CPeLsNjSlBCI8JJf/?=
 =?us-ascii?Q?g30AWHw0FbfwGgITQaqarmiv6JPu5vmVIFcvNSiK63xGF+gSth8wqVFna313?=
 =?us-ascii?Q?pKIgIwZeCgDWXr5KZxzk8cueYymrL0+wT/ACAQxR4/x83IAinlr2MAiJTn8b?=
 =?us-ascii?Q?kQEydJPi41Jnb3vyHNupAUzKw8OPPvIiOA8MUsu/OsG6DGyoM27NgZL+CXuf?=
 =?us-ascii?Q?RQZ6gi+Qq8S9m8/wnFkqsk92u4aKHFEaIkao89XzcjL2rmpLQZTwzGhQF0TK?=
 =?us-ascii?Q?kS2GZO0Yar4X/Mg+MunbOW7rqvou68mKIQNE20ls/wLbAVIAJLBUw9Y0U2yP?=
 =?us-ascii?Q?dbCr/NO06QWn+piKpZc5E+DRDw2awh+g4JEOJmOr0PS4bys8Ut5ALKGJoXGC?=
 =?us-ascii?Q?g0xye/bCR4yTrpeI3I9pDhcdoNgyI3sQqQ8QTwDBFLXKRrRr/0+z9qVzz+MG?=
 =?us-ascii?Q?4q4SenOAx7Em0O8SR/05uDq/mxo+K6sxKbU2sQc0fy4P9s2yQjYs0VtT7C+Y?=
 =?us-ascii?Q?k7weworVL3LsPsgtJPDdXYLJXDpcY4x3Ada0WJnZW2yX5RAjqfBdx8LxWV9p?=
 =?us-ascii?Q?T6NbMp2BPyB9ACtzzvr7j2xHjHGfJHuYMceCrMlFlTN3+bDTEA75DYbn/+8I?=
 =?us-ascii?Q?hbFbLzwNhNsTdM9ljTP3Wu/BD7hSt4rWf2peAwp+7Pl7QTRrLsEwgjQ0SZfT?=
 =?us-ascii?Q?S9jAihiP9clX41mpvDuXD7C3Jhl1Z9Veijf4mmrhkfrXZi5qhSwjfx0i4Yc7?=
 =?us-ascii?Q?gdY3m8h3gZBXifm8X8dBn6e5cp54dCRSeTp0mQF/pJa+L4nQ6knHhHID/FDk?=
 =?us-ascii?Q?lUNFTXT9+qLMw8JQGQSnHs+PlWHEdPb7P+0I0pVHf6PlQbaT713DAOJ2m8FM?=
 =?us-ascii?Q?xwxqjXXAixVCb9+N3/6cZAXUH9y+1qRqZNYEKQMD?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cd86c513-6bcd-4547-5fce-08dbfb70d5fc
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 00:17:05.0118
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zi0szGGTpOWAX20dT3DCWBMQNF9OVDA6KDAYAsEINm0kKUEXAInhlh6PU8qNbk6qvdPtpGnBSR6T/ghBc8Qfqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7201
X-OriginatorOrg: intel.com

Dan Williams wrote:
> Ira Weiny wrote:

[snip]

> > diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> > index e5d770e26e02..7a891b4641cc 100644
> > --- a/drivers/cxl/cxlmem.h
> > +++ b/drivers/cxl/cxlmem.h
> > @@ -481,6 +481,8 @@ struct cxl_memdev_state {
> >  	struct cxl_security_state security;
> >  	struct cxl_fw_state fw;
> >  
> > +	struct notifier_block cxl_cper_nb;

delete this...


[snip]

> >  
> > +#define CXL_EVENT_HDR_FLAGS_REC_SEVERITY GENMASK(1, 0)
> > +static void cxl_cper_event_call(struct cxl_cper_event_data *ev_data)
> > +{
> > +	struct cper_cxl_event_devid *device_id = &ev_data->rec->hdr.device_id;
> > +	struct cxl_dev_state *cxlds = NULL;
> > +	enum cxl_event_log_type log_type;
> > +	struct pci_dev *pdev;
> > +	unsigned int devfn;
> > +	u32 hdr_flags;
> > +
> > +	devfn = PCI_DEVFN(device_id->device_num, device_id->func_num);
> > +	pdev = pci_get_domain_bus_and_slot(device_id->segment_num,
> > +					   device_id->bus_num, devfn);
> 
> What if pci_get_domain_bus_and_slot() returned NULL?

:-/  yep.

> 
> > +
> > +	guard(mutex)(&pdev->dev.mutex);
> 
> Lets not open code this since device_lock() is so prevalent it deserves
> its own guard() type:
> 
> DEFINE_GUARD(device, struct device *, device_lock(_T), device_unlock(_T))

Good idea.

> 
> > +	if (pdev->driver == &cxl_pci_driver)
> > +		cxlds = pci_get_drvdata(pdev);
> > +	if (!cxlds)
> > +		goto out;
> 
> Lets not mix usage of cleanup.h helpers with usage of goto. The helpers
> are there to eliminate goto errors. Just add a new helper:
> 
> DEFINE_FREE(pci_dev_put, struct pci_dev *, if (_T) pci_dev_put(_T))
> 
> ...and declare @pdev as:
> 
> struct pci_dev *pdev __free(pci_dev_put) = NULL;
> 

Even better idea.  Done.

Thanks,
Ira

