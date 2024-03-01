Return-Path: <linux-efi+bounces-684-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EF9286EBC6
	for <lists+linux-efi@lfdr.de>; Fri,  1 Mar 2024 23:23:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFABA28968A
	for <lists+linux-efi@lfdr.de>; Fri,  1 Mar 2024 22:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A50459B62;
	Fri,  1 Mar 2024 22:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cXIw+xsx"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F03338DCD;
	Fri,  1 Mar 2024 22:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709331614; cv=fail; b=Cbx+yjwiv9LAvUosb6B3Xw8mmmWGl4XKJu3xRAm9EXLEhboZVmLXxCjMXx0h7YQ1FF8VRbAg5ZO+Fp/ek7cqoETGYtQRzZ6oH8zym9K9J7IrsxXFt6csrR26gpalapiy0niRI9JjK49xRSxF7+KoTBQsQiNggAEsguxDBg+3ZAQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709331614; c=relaxed/simple;
	bh=TSijtdnwkfSLcFcCwDWsseL5iltYhozFQzZtTLqBSJY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CqDwWEh0bmk382TIzM8o3gcYPbrf4pLe+fMbyX7RTK680ErnqlQdIFtGF36G8+RtlsXfVx6QbovgGvGqtH5aLw/bFIa/jh6HHmWEyZwf6xhs22I55UDYsdVFYb7K8Uyiz+sf5mW7dv8Pkrkxgo+Xv8c/fXonWC9YUFeAXm3FD2I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cXIw+xsx; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709331613; x=1740867613;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=TSijtdnwkfSLcFcCwDWsseL5iltYhozFQzZtTLqBSJY=;
  b=cXIw+xsxKxSoauCpdoFtZIMFcp0lexQtbs+C5IpxZwW+EOAoG7LNNHjV
   Z7R0mWGNrJvtTylClLgLlk+cyLxetBiB6LE3u6VZpucrpC1OU94Tl7CNO
   fzxJeROAOHbr+ToWxeouRfZmQL76qbdDxokM3xx1qlCHFUSW4qprdhXCj
   HLnjKr95eux6xxDhR9tNt4QY7N5E/F6DC38i+QZ+54VKL0/jybKxgLDmZ
   CCaOihnBUNRr/C5XLUpXUAEjhUY9vF/Gija20/UNW5KsVfveTFAwvb6p+
   2ej2JI7jvg58cdTLdVnFpVyXXe5ZcfhT5W8qre0KrTxWefzMcXtbJICIz
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11000"; a="14596735"
X-IronPort-AV: E=Sophos;i="6.06,197,1705392000"; 
   d="scan'208";a="14596735"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2024 14:19:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,197,1705392000"; 
   d="scan'208";a="39175952"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Mar 2024 14:19:58 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 1 Mar 2024 14:19:57 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 1 Mar 2024 14:19:57 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 1 Mar 2024 14:19:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QaaFrPD9hq0nEv7ARTWhnKkpe76ip9GPFcY74QKzmXGIZ7xkMoYhDuPM2dW+XwI7mTDWqWfParDxgmNcrYXR9ALoLANSDuWlI0AgX8gNxMNMxx1hlk8ZBoZR+8eGee6lSwwN+aZV/Gzg6qAtcxtry2m9C3KBFRxsTQvDwjpw4yK/vRtV2xaR4b7zocPjffNxFXNgFbU4IyUJP/xK58TLbOc4XVr12yCC8ofDwB7XZ5AVvuE4QTRooduufgvYBKVCaBN52KWX8z6Ymy9CSDCoQVq5CxGkhFaPoX1zqgYTOWbr7KohI2TvpnyodM67FdTf5AmfcGIrQXFUzkM9IKexyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JUI0HQ9KW8wzsrCN/ZMGECKwl6ZLfgHjgAk8MJGr2fM=;
 b=WCQiPAV/u0rnQbecEd/3mvjLizfewY+g+/Grv+nnVWqbBxEh65iGiCXjxN7lpbZ4I9UHTNEMTudPqMzNWXUSK+H6zkt1CsQcEB8f2a1ruddBDARZ3z6u/xkGNOnRbZq52EXtM2AAX6i+pFwlGF/n2UUTaETrUWd3hfIwNqcrb+/ZoIfYSjCUnds1cggTzp9YDt9Swe2GU2SgvPWSp2IiOhXuKUBREqmQFQ+dxOxnAZPhiWhBEcbpKqJYBPTOXWnPrD860/NdPa0d3qrfMGANmbq6suosGZNAzpZnfGmwrJ+9Q70JjVTYUJuYc9FcMxLbjOz7F19uzCpfrrgREsfOZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by SA1PR11MB7013.namprd11.prod.outlook.com (2603:10b6:806:2be::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.12; Fri, 1 Mar
 2024 22:19:55 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5c74:8206:b635:e10e]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5c74:8206:b635:e10e%7]) with mapi id 15.20.7339.024; Fri, 1 Mar 2024
 22:19:55 +0000
Date: Fri, 1 Mar 2024 14:19:50 -0800
From: Ira Weiny <ira.weiny@intel.com>
To: Dan Williams <dan.j.williams@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>, Smita Koralahalli
	<Smita.KoralahalliChannabasappa@amd.com>, Shiju Jose <shiju.jose@huawei.com>
CC: Dan Carpenter <dan.carpenter@linaro.org>, Yazen Ghannam
	<yazen.ghannam@amd.com>, Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang
	<dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>,
	"Vishal Verma" <vishal.l.verma@intel.com>, Ard Biesheuvel <ardb@kernel.org>,
	<linux-efi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, Ira Weiny <ira.weiny@intel.com>, "Rafael J.
 Wysocki" <rafael@kernel.org>, Tony Luck <tony.luck@intel.com>, "Borislav
 Petkov" <bp@alien8.de>
Subject: Re: [PATCH 4/4] ras/events: Trace CXL CPER events even without the
 CXL stack loaded
Message-ID: <65e25486de5ea_31513a29492@iweiny-mobl.notmuch>
References: <20240228-cxl-cper3-v1-0-6aa3f1343c6c@intel.com>
 <20240228-cxl-cper3-v1-4-6aa3f1343c6c@intel.com>
 <65e24fda80e44_3651e29440@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <65e24fda80e44_3651e29440@dwillia2-mobl3.amr.corp.intel.com.notmuch>
X-ClientProxiedBy: BY5PR03CA0015.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::25) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|SA1PR11MB7013:EE_
X-MS-Office365-Filtering-Correlation-Id: 4032f2e1-c089-4cd5-4e94-08dc3a3db8dd
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4DkUL9hyL7uYZcjEfdQzCzsDTU7KpAziF+VCHLs8hou7pi6Fecuf2mbrFq3vVbOiss/m7rWk6cy9BJVzxTcYQuVslPkZuYxBhxTJyg2bAXuPxCXb4Jj9AvSPQNJYXGfIt3QsBoLwDdmMyjE1tHMjyBMhUdMRRWeXUFhKIdgwSyAPmQPwkexA14i8GfRUvGJPZzXcxgCvarUPLTJqJZIIy8aJR8yMsm4RSMBfv+U9szyszrls7fIa8iVpnb4TM0uI6SmGkK2Cafqai3CdMEZ4tAPT9mc1/NK010c7cHs7FGcbWcHQP1XagjRUhYBhbouPtmiw4jREdoAvh8osQi+PqgrYLfMpcHjZ8Cv2ON6+8dcfL3SEFLGn34gDUmoZdYzkQ7LKPHQaCAKaq6jNMpX1ftGllzm/5BBZltGalHorVc2M6DA5zBQ6PFy9L+yK1mg9doWk86Xce3uFaxftHoDsnGmwlOp9kPHxLgwo7dqCWVGx+0YS3jUFpTWnSKRVqEDMmrEBDZhJzOqVtKgig/6ZwgqsUEG5PUqD0akFXiAWV2GPBWsKdDSGSK742A3JbrEgDIJNHiWct0Gr2H8eZyEx2NFnUlryaaL+GrfDARLobyK4zMmqld/84tlOQlkEUqB2nHjTO90UQTGVPFGihk9FKg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gbC0XlqxVjfXFSST6UqmSUYlrieMypIjO+lY9OxTqjEDc1i9kKVxoetdIhbF?=
 =?us-ascii?Q?0aKu2wLpK2DYKVrApnTOLJBFpd+GE/JiLxy0xv8ekR+iKCJj0LRMoeDIznOu?=
 =?us-ascii?Q?U9pPn2xHXcDs1yOl8Tf7uWxxTBmY3ZwdXMNCflEyYm/ym+fXZr10sPhD91sY?=
 =?us-ascii?Q?kxud45Zju1bmJG4F0lWmncmkl/ecBRNoNlGE7WZVgr8E4+AuxHKYOcAzfyOj?=
 =?us-ascii?Q?CsgnQCGYBHmWj0W4wcCNM/jw33ND5DZfNwdTiUhAL62DtY+uDEK0slHQn1TN?=
 =?us-ascii?Q?RyaPm+6LHhUpR8W8jkLZ+INbpViw1+zkjDSMfqhgfpTQ2BSjRZkZW/4RFB3W?=
 =?us-ascii?Q?l52R0Wp1fdNff/+f0LF4naSF3PEd7sFbdrnJVnVziRvUkmAFS9Vruqoc1Fy4?=
 =?us-ascii?Q?MuxAJQdtNSgawP4/LuWCAuyroqqkHRrHVGYqe7dOMDSHmiCysx6FvOk4lp++?=
 =?us-ascii?Q?tbfLkk2SfXAAbb1fVG9xT+aL3HKwZqokhODyTFNfDXiMEnbmyet6ppld1rIz?=
 =?us-ascii?Q?OeodnA6E/B4EdipxLkDpKX3uJnibEya6WUnMmfC8+pgdl0GUeSovQE2Z59Fq?=
 =?us-ascii?Q?vyn8wKonTe02JwjLozp9fIqUtDEedMGm4iIjpC9dq3g8uiC6G6gVWJZ19g/f?=
 =?us-ascii?Q?z3a6flBSVxaO+Mzb7pAzNM9381+wySeKXT1uEOwIIFo9+9GLMpJPkh9lWGhu?=
 =?us-ascii?Q?uWD5oAkBT6h+qVIaw6Gd+P4t0Xm3dsqrdsn4Y6qnj6SpTti2msSZy93dYgXf?=
 =?us-ascii?Q?LlDRM8eQe5kTfPWmzr9Upj8SIfTQtN/lZIiyIQyCKisM+Lol3OgOUxVglvTo?=
 =?us-ascii?Q?M/2jXbes438B6yGpcaasAb1JWrXVbNXBT4Cvy/LF5OJnW2Mhm4moCwjH9TIa?=
 =?us-ascii?Q?/VCTIX6vkQhqTaU4XjprsvKOdzX08p7upRCAQx9RhF2pKTFyKCJRNZNsKiCt?=
 =?us-ascii?Q?0owxJ8sMj+MQemUSSgETtKANrI74w6jzhLBYyD7jBkMIYelaKrsizJNN1C2r?=
 =?us-ascii?Q?ePcQyeG+81LIaOjjEHb5Dlk3CNWYtgUGn5TN58lNZYLZ+ZEFF2pfJECwCtiL?=
 =?us-ascii?Q?vCGxBuexPKx+2YA/E8mDY+r8aAVuj5aqrfACYWMsWzYQ5WuC1obn0uY69klT?=
 =?us-ascii?Q?b3PtxqUGfNfdZu6mLwDtjn9pbZHSF1/8zpsBvCf6BssCf1N6AxpwVA3p+24F?=
 =?us-ascii?Q?KI0MOdcb8WzOh5k8XrUXodzV2S49E+EXR7++y6MJccpopqegaENU4NGpdJz5?=
 =?us-ascii?Q?7waIpuGOXY90+NwSssWBbv4wCMpzWTTUWe2/Xo5uY+IN4Kk1XUxABaa+hIGT?=
 =?us-ascii?Q?Rz8ABZFNmZN8J21peXN+JOG9ly3yZTZRNiFrq5ppc6kDY1KGZp2KHz235HY8?=
 =?us-ascii?Q?fhI0cHCIaimjJUpyOCmORUbHuvTUymPLiYx5VXyHxLttjcywv8WY6iryIHrx?=
 =?us-ascii?Q?V5+nEwGjdLqNhf1c84rvATV+x31o/8L81b2r/GhDvsJEvD9O2SlrpLMyS+dd?=
 =?us-ascii?Q?toSEOYq4kr7rOlpL031jeHsdH73EcSwHFj3ZGs6qUdKHqyezH0+sinFXk9tO?=
 =?us-ascii?Q?uf8ghx0sZojo+ZJHa1QfmJ9LOv4a4MWO9Oqc7Dzi?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4032f2e1-c089-4cd5-4e94-08dc3a3db8dd
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2024 22:19:55.0309
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y1HfUUn96adwSqyMqjkx8GVjUBcz2zl9JAbr17YVbUrg6kNc+ZL1gTXZ+kvw0lhrM6R7OFVnoEMUPXiDjS4C8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7013
X-OriginatorOrg: intel.com

Dan Williams wrote:
> Ira Weiny wrote:
> > 
> > diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> > index f433f4eae888..9ac323cbf195 100644
> > --- a/drivers/acpi/apei/ghes.c
> > +++ b/drivers/acpi/apei/ghes.c
> > @@ -729,7 +729,10 @@ static void cxl_cper_local_fn(struct work_struct *work)
> >  
> >  	while (kfifo_out_spinlocked(&cxl_cper_fifo, &wd, 1,
> >  			&cxl_cper_read_lock)) {
> > -		/* drop msg */
> > +		struct cxl_cper_event_rec *rec = &wd.rec;
> > +		union cxl_event *evt = &rec->event;
> > +
> > +		trace_cper_cxl_gen_event(rec, &evt->generic);
> 
> So it was confusing to read the empty stub function 2 patches back when this
> change was coming, and basic reporting of CXL event does not need the
> workqueue indirection. Note that EDAC triggers trace events directly in
> the atomic notifier chain, so CXL could do the same.
> 
> >  static DECLARE_WORK(cxl_local_work, cxl_cper_local_fn);
> > diff --git a/include/ras/ras_event.h b/include/ras/ras_event.h
> > index cbd3ddd7c33d..319faf552b65 100644
> > --- a/include/ras/ras_event.h
> > +++ b/include/ras/ras_event.h
> 
> This is more heavywieght than I was expecting and defeats the purpose of
> centralizing advanced decode in the CXL driver itself.

Fair enough but it is not that heavy IMO.  It was mostly lifted from the
CXL traces.

> 
> I would expect this to be just the tracing equivalent of the
> ignore_section logic in cper_estatus_print_section().

I think it is fair to give the user some information.  I'll redo this
patch to be first and drop the extra work item.

Ira

