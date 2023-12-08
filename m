Return-Path: <linux-efi+bounces-151-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C583E80ABFA
	for <lists+linux-efi@lfdr.de>; Fri,  8 Dec 2023 19:22:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 485281F21274
	for <lists+linux-efi@lfdr.de>; Fri,  8 Dec 2023 18:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE77C47A43;
	Fri,  8 Dec 2023 18:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WFNNTLac"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B10F84;
	Fri,  8 Dec 2023 10:21:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702059718; x=1733595718;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=gHaNTRxbkt9HYWe+IwMxxExE511yTtACUQGXrxxip3g=;
  b=WFNNTLacX49Gvh1da/9e/l2OkpF1dYMTejiaZfU6zU9fJrnFI+o+vsdh
   De4Gb/+7+ZYT3mFF00gXun+pwOIf8t5G4Aw4tFvLhVa1AxjiFvGUWXRL2
   94KRWstOZjXS6sN15ymZA3e9f1zefqofgR57TSBbgiiB0eCcso34q4C6f
   oWIVDGmAQBmlD4n+beHan3ew3J+/f/vkAbsoIAJd/4U8mKZZyFXNhhopJ
   y1exkL5D+8JLT99QMXafmAOXHkPgirlchpsPcj59eHz7JCNsiX0UbXZ2p
   g/IvAUTq82R+oCyEp7tgW8QrEq2tOecV3znTBRnXerZy77p26IE/2jV0M
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10918"; a="393310118"
X-IronPort-AV: E=Sophos;i="6.04,261,1695711600"; 
   d="scan'208";a="393310118"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2023 10:21:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10918"; a="838216152"
X-IronPort-AV: E=Sophos;i="6.04,261,1695711600"; 
   d="scan'208";a="838216152"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Dec 2023 10:21:57 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 8 Dec 2023 10:21:57 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 8 Dec 2023 10:21:57 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 8 Dec 2023 10:21:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QokNcSLJWiCfK61B1yFiqNQODEk8YomxnnbgTWJRUB6+37T9o/VR/RxW/ae7sJfOENG+CFjfEGKjZdC+YdZL1sAkPK6QOIs7GhNbTsDRuNm0RgfdY+cNUU3p2wZWlCjOmyZmC3wn2dLnSi87vwsgC/kn4EkaW5XvbH0NpCQyZIaW+S4tX5m1yr5bZIPDHAplPaQ4iERax9StLcmmk48c7rQA9fPPwILEuHSl/BeTGaFBU+sUMLH2kpO2FXjpGPU+5y+ObHJwCrdklL2Zwp5wz8VfuaE3LAVSFSGEuBtzK+qDn1fU5ro8Y6lqXuDIwh8nedPP/KcYbPdODEepk6zGPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J86H2WpVGzi2U1hs6/ZT5VeIvSciQAq4ii/gb0GLJng=;
 b=gwWaqQQMfT9VoMzUOj2Gw7tGVF3HGV85kL/7W4SwnZpYYrhK5VGdiyXZ/yjZeiQNW+KqL5QAP/vQbSsDxLeqpfOONJwR44ISr8YS7h+mwMUBoQiY+ZikC8m5zvPWh6/0ESJcdte7/5yBsZOP8PNuhm3442Jghd7UyrkJz15qHbVynsbdnpMJKmc9+W9ynlSyXjlxKUJPfd5WMnvwAHrUCn8Htd5Yn80WGuZfjCyJQxgm4eZRqQucGZy4QnaoqBFJkO1I4XZFiz1ygMquRXL/4DnSkQ9jNZoRIDzzbCaE0QfzfVdVmlXMU9af5P0qRFNRQCk/IYuqWXz9tDFghFsJ2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by PH8PR11MB6610.namprd11.prod.outlook.com (2603:10b6:510:1cd::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.29; Fri, 8 Dec
 2023 18:21:53 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::da91:dbe5:857c:fa9c]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::da91:dbe5:857c:fa9c%4]) with mapi id 15.20.7068.028; Fri, 8 Dec 2023
 18:21:53 +0000
Date: Fri, 8 Dec 2023 10:21:49 -0800
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
Subject: RE: [PATCH 1/6] cxl/trace: Pass uuid explicitly to event traces
Message-ID: <65735ebd531b5_1e7d27294c7@iweiny-mobl.notmuch>
References: <20230601-cxl-cper-v1-0-d19f1ac18ab6@intel.com>
 <20230601-cxl-cper-v1-1-d19f1ac18ab6@intel.com>
 <657263c249c4c_45e0129471@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <657263c249c4c_45e0129471@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: SJ0PR03CA0358.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::33) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|PH8PR11MB6610:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a57f934-a203-4d9d-a4f9-08dbf81a8dd1
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZKixL/5TFnmkTaacq2pdLQkD6JwKB1FcaG1q4OIG5K6+ZU3uhb9+gH0ue3OjpAUB/YZ4D3PHs3RhRRgY0Gp984K8OactQRd7G5OV2xrCyIXGwuQyQKkMmRUy7HAhOPeGPBj4RIXdkBMwPuml/WccwOFIfCfjBfvs/Oq8zo0RzObCh+9XXZETG9H/+abxXSmVeEA6VRDcnUEeV/CRnJ5H4hxZBHoZA/WMFfTPfelHW3lyxENV3KVP1h9g3uPKBHVLHaY7kzzfJhv1Z2dO7GurzPoiMpPkwB+iMzoj7v943TpiO9CI22kmwXPc7ETxIh6WWTyeP0z5cQ6eKrITLhGMKCHFuB109aMibm43C75gMfhLCZCw5mW7IzOQ4DXDn0HjOJPeI8dAVmOpMqrABubPSldWkh9+ZP1kTr+vxEoasMVLfU8mrDDYECVDOvxjKdci4cLMvQTlM4cnutSY2ILPoPj2EK0930fzfykDXqjL2II2+DcevrMISR7Bm2TYeReygbY67Li0gbGFxskXGIm+bP3CBfNzoRzEBC/s4bDeL+O6EE7HQOZ/m3K1ILvv+GwC
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(366004)(376002)(396003)(346002)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(316002)(54906003)(4326008)(110136005)(66476007)(66946007)(66556008)(478600001)(6666004)(2906002)(6486002)(5660300002)(8936002)(83380400001)(86362001)(44832011)(82960400001)(38100700002)(107886003)(26005)(41300700001)(8676002)(6506007)(6512007)(9686003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?n2PzhorG0bna5swTIVILQKJEVDfFt9VS3r5R43c15pGlbGrd1TvAzLzU7+Je?=
 =?us-ascii?Q?gKy8EDZkzYAiqP3oN03Y+cDTLSQLxQ9Cc3vFFZXNwWB2I4d7kCDBC42TuB74?=
 =?us-ascii?Q?ZL1SSPr+OOMf14V97ZrJdqfEouzAPaspWZB1d7SzB9U3jkoICeAYYBQ/Fg8u?=
 =?us-ascii?Q?CLPqXhrazx1d2EqDqosRyflN3oxezcMqKiqV4catTTllcXfdKrOZRxCJhz2j?=
 =?us-ascii?Q?sKiIieGvM/KD8pvL0dpfZtadAG6LrbKvioNaEfPGY1AMegJd35YoT19KGlOD?=
 =?us-ascii?Q?CR9035ltmsnDtZ9zpFDPjQKo9Q1W8+q4M/YSacpfDR3jsFf5LMAU4W9Edzq2?=
 =?us-ascii?Q?9Cffy6zVYdbnU/Fv2SQW8NXv3gtfRjNGTJakdujmR+KFdXZ/WjjrV75bwrAO?=
 =?us-ascii?Q?rGxhoRj95DL/eXFCQpGZW6FEoZPGkPw0JJ1BaaM0QwolaZdT+tpfuNV55Ig/?=
 =?us-ascii?Q?aRFHtuJUNnGp9TiwB1Ko8UoYCJrPrIoqaM2ht2hbp0ufgE2zONdHzIT2uLvT?=
 =?us-ascii?Q?wAzF08927DQqaC46X8HvuKHQaXfPBIbdhFw+t4djcX8mDaI2TNJ/gKnfcHY0?=
 =?us-ascii?Q?vSMK6aL+spvYIvH4kh7f8iv4u+lkMSUsIjZUF+3NYCzGRMSmfaNDrTWsu9Oq?=
 =?us-ascii?Q?vX+rrEtJGI2su/CGgy6k3gVJOxyL9EuvHAfqTfAtNxAEd2SNWfRJ1AxrIxHz?=
 =?us-ascii?Q?nFZs3BAm+171Q3FuwXaTAnxZWPYudvbj2cUq9jeEsP2DnNyRHl4vKrFbGufj?=
 =?us-ascii?Q?PwZD+cYXXau+s1DVRaoLF2jd0jrkLSKhSAUACL9dK2/VBFvo7X9QOYFchqEN?=
 =?us-ascii?Q?Gwurli+3+GG0cTClV69bhF6JQhNWQTluuqVzCa9p2TrtuaxqsAvtdn0XMNWe?=
 =?us-ascii?Q?X/aO8creFAwaoBgIWTEqX7OA9PVn8WA6CxOalWhJMAQtRNmQqcOGKoGdhODy?=
 =?us-ascii?Q?MEBz9J1hBJrIQP3zfRwsEXDqd9XFmtbJ1SkyqrLXnL++JXzEEnyJuV4LvY/i?=
 =?us-ascii?Q?vaM0KHV3D7eG0yqSLapt7joR3GUaTHkrgcI1qPXKCvDCo0jAK3KtbUJqSJwp?=
 =?us-ascii?Q?8btkotTkwFPqmeZ4JT7LPnbXHXelSet33lQCHwldOhKYA+x1dU7oVKufPp2o?=
 =?us-ascii?Q?dsbPXyoi6nvpieRao+5ECv595GXRoVXUWXeDdU0czSFpPuVP3OtdD8KEMCmN?=
 =?us-ascii?Q?F9luulwZ/TyxG4Ta/DhnUNlISjIeJwUurKx8IRXh0fQYdi62FxVSZp5YhLbx?=
 =?us-ascii?Q?gk8AgFmPJMaiqnVYFpNitlWbM7iQ1MBL88aRdqQ7yjNCMlK1LTBvXbNQBb+N?=
 =?us-ascii?Q?wnLOuxCPE3pHE4Cpv9SEbhqjYrcdXTIx+t2C4fu3C0Ga25L3sgBbwj/ycHje?=
 =?us-ascii?Q?YRY/j1loOuhWeGyP1rLsWz1V9kthKD05CMAsRNqPO4EHLJZwUhZuGMf0isjw?=
 =?us-ascii?Q?njIqgSIh/FuV7DdYprKlGNFcDqj1OiaHCiACrET9X8prCym7PIdIZ6iwfGlq?=
 =?us-ascii?Q?EBrTPq+fjPLFN+gbC7aHIjB9ZI1YPU12+y3ix5j6js4dyElDPAKHR+NTndIp?=
 =?us-ascii?Q?jwhPKroaA70Yj5m16ROQeeh3oTtJ5j+FPHyRyjlu?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a57f934-a203-4d9d-a4f9-08dbf81a8dd1
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2023 18:21:53.7019
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cq/r6jrDEX2K8jRdr+Y9DNvsuqlYSNGxxWf0+CB3qde3+kxozLnf56o27hVRh14b7C3gcSDTHCa/b7myutM3sQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6610
X-OriginatorOrg: intel.com

Dan Williams wrote:
> Ira Weiny wrote:
> > CPER CXL events do not have a UUID associated with them.  It is
> > desirable to share event structures between the CPER CXL event and the
> > CXL event log events.
> 
> This parses strange to me, maybe it is trying to capture too many
> changes in too few sentences? Something like this instead?

Yea probably just trying to squeeze too much in.

> 
> "CXL CPER events are identified by the CPER Section Type GUID. The GUID
> correlates with the CXL UUID for the event record. It turns out that a
> CXL CPER record is a strict subset of the CXL event record, only the
> UUID header field is chopped.
> 
> In order to unify handling between native and CPER flavors of CXL
> events, prepare the code for the UUID to be passed in rather than
> inferred from the record itself.
> 
> Later patches update the passed in record to only refer to the common
> data between the formats."

That looks much more detailed.  I'll add it in.


[snip]

> > diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
> > index a0b5819bc70b..2aef185f4cd0 100644
> > --- a/drivers/cxl/core/trace.h
> > +++ b/drivers/cxl/core/trace.h
> > @@ -189,7 +189,7 @@ TRACE_EVENT(cxl_overflow,
> >  	__string(memdev, dev_name(&cxlmd->dev))			\
> >  	__string(host, dev_name(cxlmd->dev.parent))		\
> >  	__field(int, log)					\
> > -	__field_struct(uuid_t, hdr_uuid)			\
> > +	__field_struct(uuid_t, uuid)				\
> 
> Hmm, is it too late to make this rename? I.e. would a script that is
> looking for "hdr_uuid" in one kernel be broken by the rename of the
> field to "uuid" in the next?

True, probably best to leave the field name alone.  I'll change it back.

> 
> >  	__field(u64, serial)					\
> >  	__field(u32, hdr_flags)					\
> >  	__field(u16, hdr_handle)				\
> > @@ -198,12 +198,12 @@ TRACE_EVENT(cxl_overflow,
> >  	__field(u8, hdr_length)					\
> >  	__field(u8, hdr_maint_op_class)
> >  
> > -#define CXL_EVT_TP_fast_assign(cxlmd, l, hdr)					\
> > +#define CXL_EVT_TP_fast_assign(cxlmd, l, uuid, hdr)				\
> >  	__assign_str(memdev, dev_name(&(cxlmd)->dev));				\
> >  	__assign_str(host, dev_name((cxlmd)->dev.parent));			\
> >  	__entry->log = (l);							\
> >  	__entry->serial = (cxlmd)->cxlds->serial;				\
> > -	memcpy(&__entry->hdr_uuid, &(hdr).id, sizeof(uuid_t));			\
> > +	memcpy(&__entry->uuid, (uuid), sizeof(uuid_t));				\
> 
> Per above this would be:
> 
> 	memcpy(&__entry->hdr_uuid, (uuid), sizeof(uuid_t));				\

yep.

> 
> >  	__entry->hdr_length = (hdr).length;					\
> >  	__entry->hdr_flags = get_unaligned_le24((hdr).flags);			\
> >  	__entry->hdr_handle = le16_to_cpu((hdr).handle);			\
> > @@ -217,7 +217,7 @@ TRACE_EVENT(cxl_overflow,
> >  		"maint_op_class=%u : " fmt,					\
> >  		__get_str(memdev), __get_str(host), __entry->serial,		\
> >  		cxl_event_log_type_str(__entry->log),				\
> > -		__entry->hdr_timestamp, &__entry->hdr_uuid, __entry->hdr_length,\
> > +		__entry->hdr_timestamp, &__entry->uuid, __entry->hdr_length,	\
> 
> ...and this change could be dropped.

Yep.

All done.

> 
> Other than that, this looks good to me.

Thanks,
Ira

