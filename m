Return-Path: <linux-efi+bounces-380-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F80582911A
	for <lists+linux-efi@lfdr.de>; Wed, 10 Jan 2024 00:59:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C52AC1C2197E
	for <lists+linux-efi@lfdr.de>; Tue,  9 Jan 2024 23:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0A1E3E483;
	Tue,  9 Jan 2024 23:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kQMigTcD"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3553EA6C;
	Tue,  9 Jan 2024 23:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704844765; x=1736380765;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ym9W9iK/nVyLd97SL7e98xx2swartVZBbbtpAh346QY=;
  b=kQMigTcDbrPI8GYmQRuaDeYLXUbKv6TIPTJcA3p46LyCB9ZskaYL8k3/
   90BmHM8/uxu1CJnmgDJJYSkT1e5/y2hHc5AD7QL1lyG4ajU+LfUw1YfA+
   o45dzQcWFhQ5WZyVvWbkqZS9jGi4Ns7gae+7TmR1RXYmDjf8pgeBYWo+/
   1dZ1Nvjy5Jelnr9k7SU0sVTaYslrC5AA1Fh5al93st21dhw/JnAE5DCCl
   UM9dJQpPLOCI1mkvziUldSitofb8l5igRayjzdszdWhi8pdOFHdoDgTDi
   KsEUu7p5F6xEt+Mz+svSl5xii0DWBjk7OqwPf+uUfimJtUmKUHmJh2Wc8
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="5111655"
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; 
   d="scan'208";a="5111655"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2024 15:59:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="872411751"
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; 
   d="scan'208";a="872411751"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Jan 2024 15:59:12 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 9 Jan 2024 15:59:12 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 9 Jan 2024 15:59:12 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 9 Jan 2024 15:59:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BVkMBtouvs6HJoO+u3OZWHaRcqWzf5HdnA2enBPmSjflaJza3jHgVcc1MS1V7FVSz8mastIJ7KnqCQAl3ttugtiy+G6329z9skJ3Mcy+8aBukgtudqp4BMqCV2iHVupK0qxhkW0p1XYTA18okKMvPVLSCWXzQ3GzV1p0dy0hdU+iyYc2GDEy2rmbZ7pqhDOG0W+Y0VOk8Y+XosYdgZ5Ev4BzeD/B10qSx8u8qqLDobXnZt2KMAxuzTechSntB9iAH8BURBil3V/BgI/LFuIZdm7C9ZP7Wsx/4rV62LlezMxnj3moHo/9OWQ3r1G4Ku6fix+ILUrt4NQeESRm5JEJEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NdyHypq0KGjoQClrzLgIZe0W15s8zROP4k9uo58k+p4=;
 b=VKFJX270hdl8gh4C0p9u2KYY9FQrTagg5MstoXDHkjNA2sV1qHtsKOvJHAZSy1zZ1PQsDfW5kzcZwe1gPrcmchi9IVzhZ6GxJiGYIL1L5Gj9OM92gawdXpW3+7ZEopuq2owp6CW8JDm5pbuChx2rp0m77ezTjLnGZiP2/nvgUuX/rL0BXWU1Xr/gKXbuaE3KNZtrCRaEGwHNf2ZoInJEavoFSmZB6Cf2SyKnh70gR6Ux/398N/7x72/VwzQUU4p2JZhVVJ7h/J7/UbTZnSsfQgz+WCzty/vL+XCeDLNogPBjJyKcl+9/N6y9lsAYN+VT3BCzb9oM438uxeQEO1CnHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH7PR11MB6881.namprd11.prod.outlook.com (2603:10b6:510:200::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Tue, 9 Jan
 2024 23:59:09 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2%4]) with mapi id 15.20.7181.015; Tue, 9 Jan 2024
 23:59:09 +0000
Date: Tue, 9 Jan 2024 15:59:06 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Ira Weiny
	<ira.weiny@intel.com>
CC: Dan Williams <dan.j.williams@intel.com>, Smita Koralahalli
	<Smita.KoralahalliChannabasappa@amd.com>, Shiju Jose <shiju.jose@huawei.com>,
	Yazen Ghannam <yazen.ghannam@amd.com>, Davidlohr Bueso <dave@stgolabs.net>,
	Dave Jiang <dave.jiang@intel.com>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Ard
 Biesheuvel" <ardb@kernel.org>, <linux-efi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v5 9/9] cxl/pci: Register for and process CPER events
Message-ID: <659dddca99517_5cee29433@dwillia2-xfh.jf.intel.com.notmuch>
References: <20231220-cxl-cper-v5-0-1bb8a4ca2c7a@intel.com>
 <20231220-cxl-cper-v5-9-1bb8a4ca2c7a@intel.com>
 <20240108135005.0000288f@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240108135005.0000288f@Huawei.com>
X-ClientProxiedBy: MWH0EPF00056D0E.namprd21.prod.outlook.com
 (2603:10b6:30f:fff2:0:1:0:12) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH7PR11MB6881:EE_
X-MS-Office365-Filtering-Correlation-Id: 109992c9-cb71-4d06-ef86-08dc116ef879
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5CHCIdWG9i57SvdVBrnDM+H5/USge9kkyRjImP2R3jtY37WhM5qVMrU4sDIOBFlsYTcTy8caBR54b08KjxQACrwcqAO40IFfDIedohZKMhSQwo0CPIMIo44+ciufb64uCpRhG9aXqB1qayqxWnyEqLeioIsyKsX4dOjcVt2tLfaMKMxaKbEGlofimS1f4xEVrL3afE+7au/41MNqsS3yhubsVClUSDo4JRAEqKciJleDg7rPXgN9MPkUmNZtQhRiBFH5q2SN0cUTQQ1Y2bgZutDzNEZYP/Mi/O89kqAigUIX2pMhAOp3FNX1DZp4t7FpbOQU0A7/0iVTDy67yaL4g/ZnuOhGyDZphlAg/nZ9HHkeLPDxSyJaA/QatFp18e/pYkXGDXzepkzWn/Bl5ljgZNQ1SVr3u8Mc8Dh0XCV2UITCoEf2ZXWGJlWpzEXNyTPHFvWXjrRPSxd0yYrR8i34kwq/pfa7dlRyGTfEx2uFcr5jXsGjL49RwIKklYd1W9Wso7CaGd7NXbYGJ4J2XqgTCtwOnm9vr52pq/lGkkXpP9k=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(366004)(396003)(136003)(39860400002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(26005)(966005)(478600001)(9686003)(6486002)(6512007)(6506007)(6666004)(38100700002)(86362001)(82960400001)(2906002)(41300700001)(5660300002)(54906003)(66946007)(8676002)(6636002)(316002)(66556008)(110136005)(4326008)(66476007)(83380400001)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LyMcA85RKAzFMpjFXu8IYL9AYM2NMG919F3PW370cUBZBnTw56jkRL78OVSl?=
 =?us-ascii?Q?5pmk9oKKi+0/Rtm9H5gSCbS/RgL4HlArG+DSi9Wqm9yVVdJecsE0vZC4K+vF?=
 =?us-ascii?Q?rlHRZ7ZqRcxTAFOfJmVcQnJKMi68bRKaPwKrV/uBnFbQXmvr5vckRy5QxP0D?=
 =?us-ascii?Q?PA4q7psLGdkvPb1yyQK73yrTSclt8p102r3EIxv5ZAMZvB7W0eDBHOJVzkxp?=
 =?us-ascii?Q?0s9iLAjvrqf2+vVQSCnDtlplPp8ViELcVKFfeQmhDTW+69fiT1PFFtTpBoI0?=
 =?us-ascii?Q?limbwf8CcZo5DsGkR5UkNtuy2nePZHzb5kxqiZUNbWb96f6AUTHj1tsd9oby?=
 =?us-ascii?Q?gikz2KAmbCMwjojv0K4YmgL+cHN98+LAvmP8nfhj4LzGH635hyqu3y7QlpEu?=
 =?us-ascii?Q?3n2BizEWz1K6kBgiMaK+3Mj8De+qyMKFupF5SCQAliibgc7Agty1CLnlJhiL?=
 =?us-ascii?Q?E/5hf7BV54YkfyOaYAC7MdAaSZ1KbnR45IPJ/W1v4J079zKTu9fQaO64RcBN?=
 =?us-ascii?Q?vmMFrpMnnzNQfS/Kx2wO4MkXzcizAV2ULbCkwVbjK6fZiOvYAglzYMt+CvFi?=
 =?us-ascii?Q?+hKQ9dWVctcZK8SptuF5/pVznMjPRIuOvI6ks19Wfy0HYAwPcmV8zORvxMsW?=
 =?us-ascii?Q?KWKpygJdP9sw2HN0PQZRNfJSmSD25xBRonmoVf4EKuh13hniAw1bhuxOhwpp?=
 =?us-ascii?Q?RYvSpx9iCU0Nx9fnYnIDxqh2Jpwu7HElKHz3wmSNxecKp4vLorr5kVoKFc2L?=
 =?us-ascii?Q?5xplj30uLh8JsjCaJ7y48Uiw4DnPIboK8+mnPfV637SuSHuSeKygZ0QwBzDL?=
 =?us-ascii?Q?woVrqeAoNTQ+N4F1NpKN/7looupgRQkr2toHwJ6Baf0SQXEvWbik2rxiV7vn?=
 =?us-ascii?Q?yJYCtceqS6uXOM7Es7HKOCUxr3s5w5MhrLavo8gZDp9A+KaohasfVuD71ufe?=
 =?us-ascii?Q?0w+OurWSSibHJjS3Nn5JjSOZvLE9lWxAiPnE4fVnJVc5A8gUwmRbi34y0oby?=
 =?us-ascii?Q?9k3dckGWrEGYy0CisOGtW31K3AwJmDWhq+yAjSs0v4Po077YVs/D/x7c533V?=
 =?us-ascii?Q?2yrZ23V/TZyeIkF9/fBbGiM5qF+dEaOIHveCHz27Bis171UyYrNPDTBENJ3+?=
 =?us-ascii?Q?vBJKP/AYRj/EYOIXnq4ShsSgjPRdtlJ8vQh+5ETXB5MAypNKOJzq0ZV78P7z?=
 =?us-ascii?Q?NYWNgdd0Gw/a0Oy9AO9mJd6LmG6XsxmDE77qcWOCC6x/1YshwLIY19n4voJu?=
 =?us-ascii?Q?9iixF8SaazOgxaKjqLG/Cd569qhsEJPxDazvmWGZyIOUX+5Ktde8GBh0en/X?=
 =?us-ascii?Q?CXjaABeiAdBp4n3FFXIHBeQZcTc+zJcRh7LyPqjnQEvwPMTHiyZY2DqbMv94?=
 =?us-ascii?Q?IzfeUimDeLlOZBhMLX2UgAl3B/BvzLb4YQYeUHlDbl14hldubCqW5TpLX621?=
 =?us-ascii?Q?HRDHYLABpbAX1PWQwGFtIK6XMaW3H1eF/O6sjK5dSndgvKl3/zAsU+mvu2uI?=
 =?us-ascii?Q?9IUWdzcrOdwUOgXBaRGLDj3+h+r7GSYOVCjLk91BT+WXzV4X9UTuyTejtFao?=
 =?us-ascii?Q?m3s9BpdI/prGvuMa+TO8Ydgk7cmSw4fBlEgRJ6lI6lM3AH8bojafq8FwzIOk?=
 =?us-ascii?Q?0A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 109992c9-cb71-4d06-ef86-08dc116ef879
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2024 23:59:09.4915
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KR83BcEcf6a7GRYJVpm6yfWk5GNAv1/eOtGVokfY7bRA9482auGp5YJL3H16UitsaTE86qRLDuVb9Vuy7BGBNVnPpcUioAZT2VRyfZAk3qM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6881
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
> On Wed, 20 Dec 2023 16:17:36 -0800
> Ira Weiny <ira.weiny@intel.com> wrote:
> 
> > If the firmware has configured CXL event support to be firmware first
> > the OS can process those events through CPER records.  The CXL layer has
> > unique DPA to HPA knowledge and standard event trace parsing in place.
> > 
> > CPER records contain Bus, Device, Function information which can be used
> > to identify the PCI device which is sending the event.
> > 
> > Change the PCI driver registration to include registration of a CXL
> > CPER callback to process events through the trace subsystem.
> > 
> > Use new scoped based management to simplify the handling of the PCI
> > device object.
> > 
> > NOTE this patch depends on Dan's addition of a device guard[1].
> > 
> > [1] https://lore.kernel.org/all/170250854466.1522182.17555361077409628655.stgit@dwillia2-xfh.jf.intel.com/
> > 
> One trivial comment inline.
> The guard change Dan suggests makes sense.  Otherwise I'm fine with this.
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> I'll bolt in the other stuff I need to test it from QEMU this week.
> Did the protocol error first, but these are easy to add now I have
> that working,
> 
> Jonathan
> > ---
> > Changes for v5:
> > [Smita/djbw: trace a generic UUID if the type is unknown]
> > [Jonathan: clean up pci and device state error handling]
> > [iweiny: consolidate the trace function]
> > ---
> >  drivers/cxl/core/mbox.c   | 49 ++++++++++++++++++++++++++++-----------
> >  drivers/cxl/cxlmem.h      |  4 ++++
> >  drivers/cxl/pci.c         | 58 ++++++++++++++++++++++++++++++++++++++++++++++-
> >  include/linux/cxl-event.h |  1 +
> >  4 files changed, 98 insertions(+), 14 deletions(-)
> > 
> > diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> > index 06957696247b..b801faaccd45 100644
> > --- a/drivers/cxl/core/mbox.c
> > +++ b/drivers/cxl/core/mbox.c
> > @@ -836,21 +836,44 @@ int cxl_enumerate_cmds(struct cxl_memdev_state *mds)
> >  }
> >  EXPORT_SYMBOL_NS_GPL(cxl_enumerate_cmds, CXL);
> >  
> > -static void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
> > -				   enum cxl_event_log_type type,
> > -				   struct cxl_event_record_raw *record)
> > +void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
> > +			    enum cxl_event_log_type type,
> > +			    enum cxl_event_type event_type,
> > +			    const uuid_t *uuid, union cxl_event *evt)
> >  {
> > -	union cxl_event *evt = &record->event;
> > -	uuid_t *id = &record->id;
> > -
> > -	if (uuid_equal(id, &CXL_EVENT_GEN_MEDIA_UUID))
> > +	switch (event_type) {
> > +	case CXL_CPER_EVENT_GEN_MEDIA:
> >  		trace_cxl_general_media(cxlmd, type, &evt->gen_media);
> > -	else if (uuid_equal(id, &CXL_EVENT_DRAM_UUID))
> > +		break;
> 
> Might as well return directly and save a reviewer having to check if anything else happens
> after the switch

Might as well keep it as an "if () else" tree as that's equally clear
and more compact.

That immeidiately then opens the concern of why the upper level
__cxl_event_trace_record() is calling a lower level function without the
prefix. That can be swapped later to meet common expectations, but it
feels like gymnastics to parse all the uuids *and* still pass the uuid
to the cxl_event_trace_record() helper. Yes, I see how it happens, just
not totally comfortable with the result, but not enough to hold up the
series.

