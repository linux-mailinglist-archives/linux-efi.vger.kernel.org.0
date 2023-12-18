Return-Path: <linux-efi+bounces-239-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D101817C52
	for <lists+linux-efi@lfdr.de>; Mon, 18 Dec 2023 21:57:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BD881F244EC
	for <lists+linux-efi@lfdr.de>; Mon, 18 Dec 2023 20:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B555E73465;
	Mon, 18 Dec 2023 20:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KBrrRMzq"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C28E1101E2;
	Mon, 18 Dec 2023 20:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702933027; x=1734469027;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=FGjfUAv8O9adH+cJKApZT98kcHhD4shY13oGae/rCBE=;
  b=KBrrRMzqJHDnYu0s6r/e5WJSNqngugPBWSryHxH+ckn7OI2kMlfSfJqw
   diy6y0A7AwCVP1JH4Ze3tp4dGHujaZ+1Vuk8I5ty4B/SjsHFpJKokwYOj
   UyHzOkKpq4Pu8MiDvG6UoQpiST4s6PFI/UpBAuoNhpBk0rooVcDIQ6PaA
   CR3sqPOobeRMsD3zyp/zK7kt3yjA/JR3oMOu0b7volCzbrjjLfevFpdkj
   rakemM+NQwTRo0XFoGxaVTZIQAdHC7q7/nanqFvxFx2hFqK7eFPRUHX1k
   wm4b4dJ74rtHSBNKs0qMuv76AVfRssyjUUZCjhBKlEpa+RLklYt3WSJtX
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="380548025"
X-IronPort-AV: E=Sophos;i="6.04,286,1695711600"; 
   d="scan'208";a="380548025"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2023 12:57:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="779234904"
X-IronPort-AV: E=Sophos;i="6.04,286,1695711600"; 
   d="scan'208";a="779234904"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Dec 2023 12:57:02 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 18 Dec 2023 12:57:02 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 18 Dec 2023 12:57:02 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 18 Dec 2023 12:57:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TfPd28aIjV5jp7jxWHzL8YhJIxE06S5aiOLtRXM8VuY9woqEfh78GUUhQirRmKqUlEygyj/p54iHWyOTAZr8MpDqdQ9CdEAwhOJp4gyiqYVOwfmrmslmfZfWD8u0Jd6dlfr9yXcvdnS47bcQ511X0u+ncvuwuiWE8sWAE9HyWEWI05yi/qSPupIMUHuRUOMr/w4zPDKeoQ7+xKHgDvaLuQvo7DPdRUJPXSRW+45YrUI2nC7nC4CdYFiEC7x+2BymnUva3s0nNp+SXZ89eYXhJLsHqBmMHf2xe6LuE9LSDB04MnofSN98ahj4IXz2MM6ifHJnZSX3FrXGFqO8sLikdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4ym6x8sbyK89GDq7pWfu9SKf94Q/BZd+rrjQYoaSY3I=;
 b=VLajCKfusatxid3t8mBE7g+o4P3RlYQ5Fp+oxGMWDzFtihh2buO04aCJSjU3xySjHpTTIA8AV0hhbRStt+qc/+Lq38JsmP5F4sfk9Eq66ji/NYcOm0OGVwc8thd1wR9F+Gr21xn30XZtwAOPGSy51QoFXqZH2qL/G5yfVGsB0InnKOm5iO7lVvbjYfOHIrayLIlQjNs7AW2fm99mme1IFgAjfBbpqObU8zjS39fBngPmhuq8Hrx7iUp9TRj5BCxILnDJikXWLeCXBZ8ut57kBoI28zdgdtY3APZcaSiMsTBjj1VPfUY/5lg3x+XkyX6f6hr98Ff18VhftTIzcU//6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ0PR11MB4782.namprd11.prod.outlook.com (2603:10b6:a03:2df::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Mon, 18 Dec
 2023 20:56:58 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6362:763e:f84b:4169]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6362:763e:f84b:4169%5]) with mapi id 15.20.7091.034; Mon, 18 Dec 2023
 20:56:58 +0000
Date: Mon, 18 Dec 2023 12:56:55 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>, Ira Weiny
	<ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>, "Jonathan
 Cameron" <jonathan.cameron@huawei.com>, Shiju Jose <shiju.jose@huawei.com>
CC: Yazen Ghannam <yazen.ghannam@amd.com>, Davidlohr Bueso
	<dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Ard
 Biesheuvel" <ardb@kernel.org>, <linux-efi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>, Bjorn Helgaas
	<bhelgaas@google.com>
Subject: Re: [PATCH v4 7/7] cxl/memdev: Register for and process CPER events
Message-ID: <6580b21723b2c_269bd294f8@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20231215-cxl-cper-v4-0-01b6dab44fcd@intel.com>
 <20231215-cxl-cper-v4-7-01b6dab44fcd@intel.com>
 <4cb5c275-566c-9414-7088-1e91378a409a@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <4cb5c275-566c-9414-7088-1e91378a409a@amd.com>
X-ClientProxiedBy: MW4PR04CA0246.namprd04.prod.outlook.com
 (2603:10b6:303:88::11) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ0PR11MB4782:EE_
X-MS-Office365-Filtering-Correlation-Id: d7f7cfb4-5f08-441a-2015-08dc000be010
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kie7J3YtDghQQXzW/bwNrCBmVkWe2gb2DEdMeQwhM74WdFT5qXcEduGxnwoD8Pz49d1zihCJChlXYazPo0APlD/wNi0iqXiJc0lb1+Qmdthmoche3bqV4s091eIb7MMU8j/zyDtXe1MI2LxdSid/fpS5Wva0XXgPNe+UXlPzaubC9dhdqz6JK3+N1e3N3kh8mrL8seYCDJGF7Nm0pz8La2ZPu5hpaUugcqJlnGwTrNyk7P1DUVvmKy+jiIMJbkngHYbVwwsWmqQ1Holv6vAkMHBKGQIgPrhsNl31ACQ7F4eJ9EBm6soWr3LEn3bylJZAvNPmiPWzVtXukMLfa3lsg7BVgPdQ5WpmEzL/bywLz30k2j2ORQxHpuntg515rK6dvblBllik39q7ZyeFHK6juSYjJVy3oFVPvJztsftbFZL13T65pw8i0IFTcMErfQHpweR/wCwL6Nfy6iGMMOTxZ+H2nlBY1nE+IHv4JPquzMixvs8emYEV9+/af1fRAg/OcDjGiDnbGZpnZuX83ByOBvvV/zyTaVT/JszXyzKB5JFFiX75pjOsUQrDGSRiK7ec
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(366004)(396003)(376002)(136003)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(26005)(82960400001)(38100700002)(86362001)(83380400001)(5660300002)(6512007)(9686003)(53546011)(6506007)(66946007)(8936002)(8676002)(54906003)(66556008)(316002)(6486002)(4326008)(110136005)(66476007)(2906002)(7416002)(6666004)(41300700001)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?InxHJvccsbQldYozWDWhALbt2Q7CxQnOD3CFDLHG4bKX79ED/ixk7II5celC?=
 =?us-ascii?Q?78Og7JApXGdoILvVWcZe6Ljt3YJp0ZC4s5kTPCsr6R+1srVQpAiDqAM5ZVN3?=
 =?us-ascii?Q?FDPLEVPb2jCifBSljGmJ24RgpyMwV+g5c9by2pNA6pFQwT7VK6KKwpyYCFTm?=
 =?us-ascii?Q?tKJrlaFQHKC05n9ZdSJm9VTuzFAjyRM+lpr+pXbjkyGsE83DnVB/tt0R7eiT?=
 =?us-ascii?Q?q1rncdfmtBQfLxfI0SjZ9Jf98PgGAc97bL5LHEg5h6d567TtBqdobH6O7V/4?=
 =?us-ascii?Q?elIO7x2liayBE3aFT2wsePkG0mRwy/oWTLWtKIbt5+venmQlYdHukNtwQJlM?=
 =?us-ascii?Q?554OzZZ0ZAQmCXc+YXG7csQRhkkxfEXGcvdTi0tzSCZwY5K4fs+jFwWtsn3l?=
 =?us-ascii?Q?3nISKf9g8eS2lmpUNAYiy6url/m55dTeCuut+I9teCxK29KEHGDjpKSfSDZl?=
 =?us-ascii?Q?JEi3RNsxNwysTYedQsTcEwTqH3gNt0yXi3YMdyhKQUqi/NiDFfww/K1p9i13?=
 =?us-ascii?Q?ZBsMTjMKDTu4z8GA0Qhpz11KeD4rVc9YjszK9/WrJs9mxUSOzeIB4m7uOKHI?=
 =?us-ascii?Q?mmvviqhh+vBpyjcLavhmTfdOKwk1w5Ge2bbfbH5ennqy+5h2aftO4gQsoSRX?=
 =?us-ascii?Q?+WJcxUf4bx5hVMwzfpAQgzlurAdH6MFao4CUZhGrB3vJuYw0qOewHnMygXaT?=
 =?us-ascii?Q?5CJw4545PZ9I6sskTdSrpVMxV60mLLYVvDBL6ycVusJ1wLatyoLG2GRPvlv2?=
 =?us-ascii?Q?OCNwsIVBQjxnspKQHBkM6qkgb0pQvqp4yLupYSpy+5BB55F51coaPYNzECBG?=
 =?us-ascii?Q?1wIzFlA87EgkkBy3AGnkqPMUMqpYsaVYLt4wgcV3xnc/VEeVAu7Z4I521zoz?=
 =?us-ascii?Q?ktMup6Xz5KsgRb77ZcSDShPw9lRbFJtCeNWB7CTqtx4HRmxlwXpmqglqwXSu?=
 =?us-ascii?Q?zAOWAlI1KnqzMiZCOHmls8AsywYKxZ2FPGpL7N+AZ5LwjZ+dBB8CjiaBcHEi?=
 =?us-ascii?Q?O2lTFIkfPk4+u9O3SDQ8IQ8jx7OjpBCM7Vl8Jf5N0iDxEQRN/Xx58f7XHnnV?=
 =?us-ascii?Q?QoqgeiGki4X60vnOvdJEqV31Ly16gJ9SyMyzunfznl/d/8/VCc6FeOuEvgMQ?=
 =?us-ascii?Q?i1T+pFt3zZAbFjkKN3K0X9E7iNNMcRBjv5EK7aGVSn07viVm7osbnBn+lypV?=
 =?us-ascii?Q?+4V/Pc923AWNIYTioVDIeMPsBURpWD1Z23zvVYlJvV884GukaJJxs+c4O1/d?=
 =?us-ascii?Q?sjW4FaShBiE2MjhDJl/2r1nVK1C9t9oLgfKOilF8zdr6hYXW3lP4zIy8XNR4?=
 =?us-ascii?Q?J7fy/UuKXApg38tJgwn+WlPZi9GMG/BcwDw+V55OgIdb74czIp7PY6cwP+Rn?=
 =?us-ascii?Q?mDtrp+h0MjRMPglxoKPjgKAKnswaZvoaUNVIF5li8ln9VeEdeX3Xh0UWmNR8?=
 =?us-ascii?Q?Y2kNVnmt5CdyQag812OCEqb3Hsh+ndBEleU3XMOZrX7PysmzTF7m4bctX6od?=
 =?us-ascii?Q?NiEA7U1/ESDckcdcpkyvpv8bbxDyauFgJlU4k4+lPz1Ypwq/rKV1AgDTbxRE?=
 =?us-ascii?Q?BYqCcyUa5hOtQkv4YsxJJozFsY+8cIjb9WVCt2dzO2DDfI6nsOr/P/rzTgUO?=
 =?us-ascii?Q?dA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d7f7cfb4-5f08-441a-2015-08dc000be010
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2023 20:56:58.5689
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YNrIme2jXGJimU9V9nUV39Sbml1fj79LAiCloJ3qOxEGkFt/VxEv8h9gZEqOrq5Y4QxQvttZkilgA80cAZsSeeBMPI+ag54cElcl2j4uPTo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4782
X-OriginatorOrg: intel.com

Smita Koralahalli wrote:
> On 12/15/2023 3:26 PM, Ira Weiny wrote:
> > If the firmware has configured CXL event support to be firmware first
> > the OS can process those events through CPER records.  The CXL layer has
> > unique DPA to HPA knowledge and standard event trace parsing in place.
> > 
> > CPER records contain Bus, Device, Function information which can be used
> > to identify the PCI device which is sending the event.
> > 
> > Change pci driver registration to include registration for a CXL CPER
> > notifier to process the events through the trace subsystem.
> > 
> > Define and use scoped based management to simplify the handling of the
> > pci device object.
> > 
> > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > 
> > ---
> 
> [snip]
> 
> 
> > +	switch (event_type) {
> > +	case CXL_CPER_EVENT_GEN_MEDIA:
> > +		trace_cxl_general_media(cxlmd, type, &gen_media_event_uuid,
> > +					&event->gen_media);
> > +		break;
> > +	case CXL_CPER_EVENT_DRAM:
> > +		trace_cxl_dram(cxlmd, type, &dram_event_uuid, &event->dram);
> > +		break;
> > +	case CXL_CPER_EVENT_MEM_MODULE:
> > +		trace_cxl_memory_module(cxlmd, type, &mem_mod_event_uuid,
> > +					&event->mem_module);
> > +		break;
> > +	}
> > +}
> 
> Is default case needed here?

Yeah, it looks like an uninitialized @type value can be passed through
the stack here.

[..]
> > diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> > index 0155fb66b580..638275569d63 100644
> > --- a/drivers/cxl/pci.c
> > +++ b/drivers/cxl/pci.c
> > @@ -1,5 +1,6 @@
> >   // SPDX-License-Identifier: GPL-2.0-only
> >   /* Copyright(c) 2020 Intel Corporation. All rights reserved. */
> > +#include <asm-generic/unaligned.h>
> >   #include <linux/io-64-nonatomic-lo-hi.h>
> >   #include <linux/moduleparam.h>
> >   #include <linux/module.h>
> > @@ -969,6 +970,58 @@ static struct pci_driver cxl_pci_driver = {
> >   	},
> >   };
> >   
> > +#define CXL_EVENT_HDR_FLAGS_REC_SEVERITY GENMASK(1, 0)
> > +static void cxl_cper_event_call(enum cxl_event_type ev_type,
> > +				struct cxl_cper_event_rec *rec)
> > +{
> > +	struct cper_cxl_event_devid *device_id = &rec->hdr.device_id;
> > +	struct pci_dev *pdev __free(pci_dev_put) = NULL;
> > +	struct cxl_dev_state *cxlds = NULL;
> > +	enum cxl_event_log_type log_type;
> > +	unsigned int devfn;
> > +	u32 hdr_flags;
> > +
> > +	devfn = PCI_DEVFN(device_id->device_num, device_id->func_num);
> > +	pdev = pci_get_domain_bus_and_slot(device_id->segment_num,
> > +					   device_id->bus_num, devfn);
> > +	if (!pdev)
> > +		return;
> > +
> > +	guard(device)(&pdev->dev);
> > +	if (pdev->driver == &cxl_pci_driver)
> > +		cxlds = pci_get_drvdata(pdev);
> > +	if (!cxlds)
> > +		return;
> > +
> > +	/* Fabricate a log type */
> > +	hdr_flags = get_unaligned_le24(rec->event.generic.hdr.flags);
> > +	log_type = FIELD_GET(CXL_EVENT_HDR_FLAGS_REC_SEVERITY, hdr_flags);
> > +
> > +	cxl_event_trace_record(cxlds->cxlmd, log_type, ev_type, &rec->event);
> 
> Currently, when I run this, I see two trace events printed. One from 
> here, and another as a non_standard_event from ghes. I think both should 
> be unified?
> 
> I remember Dan pointing out to me this when I sent decoding for protocol 
> errors and its still pending on me for protocol errors.

Good point, so I think the responsibility to trace CXL events should
belong to ghes_do_proc() and ghes_print_estatus() can just ignore CXL
events.

Notice how ghes_proc() sometimes skips ghes_print_estatus(), but
uncoditionally emits a trace event in ghes_do_proc()? To me that means
that the cper_estatus_print() inside ghes_print_estatus() can just defer
to the ghes code to do the hookup to the trace code.

For example, ras_userspace_consumers() was introduced to skip emitting
events to the kernel log when the trace event might be handled. My
assumption is that was for historical reasons, but since CXL events are
new, just never emit them to the kernel log and always require the trace
path.

I am open to other thoughts here, but it seems like ghes_do_proc() is
where the callback needs to be triggered.


> Thanks,
> Smita
> 
> > +}
> > +
> > +static int __init cxl_pci_driver_init(void)
> > +{
> > +	int rc;
> > +
> > +	rc = pci_register_driver(&cxl_pci_driver);
> > +	if (rc)
> > +		return rc;
> > +
> > +	rc = cxl_cper_register_notifier(cxl_cper_event_call);

Quick aside as I am reading through this, the "notifier" name is
misleading since this callback has nothing to do with the
include/linux/notifier.h API.

