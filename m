Return-Path: <linux-efi+bounces-261-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD591818D1E
	for <lists+linux-efi@lfdr.de>; Tue, 19 Dec 2023 17:59:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3ABE1C24746
	for <lists+linux-efi@lfdr.de>; Tue, 19 Dec 2023 16:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33CA82032C;
	Tue, 19 Dec 2023 16:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H9TCKmo9"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5222320DC4;
	Tue, 19 Dec 2023 16:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703005156; x=1734541156;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Vo5ce1LzOEusJN30K0599txJ/gluUHQRg+pGFStsjyY=;
  b=H9TCKmo9DSTrv/3uu637VBjQASo0S1O+LtGv8V0wlZeVhTEq1AD/XRm/
   VCfjwDqW1CWaxZSvXPvoXFgGX049TO90le86mjSpc5zbWazyaaBJv0vFL
   RgFs2/9Ff7tDbGcUA7D4iKjQ3Wt6pFe/ASLhFiNPfnRdsinzo9sA5HrX2
   1EWSnBvkFLi2wVGEwtcs0CpgTVi7FVvF5439Xovh1u3wHuES2nuTQeTmy
   /55DKF3twFkGBLHB67AYYEgtxOqB6LXsv1PFstM9nvVt9kBZxj9ITDQF5
   tbrWRmDErcEm4BS5y9rGJv8YMmtcEVzRT6tE0sb9yuIZuTdXutmUjg8Zw
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="2511149"
X-IronPort-AV: E=Sophos;i="6.04,288,1695711600"; 
   d="scan'208";a="2511149"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 08:58:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="899429534"
X-IronPort-AV: E=Sophos;i="6.04,288,1695711600"; 
   d="scan'208";a="899429534"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Dec 2023 08:58:25 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 19 Dec 2023 08:58:24 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 19 Dec 2023 08:58:24 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 19 Dec 2023 08:58:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P3s36T2oZpgssq2W8yQjXblaujzoClZAsdXSeXncsN9QnYWvAN4+Ux1ajvGVC3ryLVyA06bwtqcCKmHmiwfEuEXcIl4hp7YVs3pRrnDzmIXzwRIufF08mP7J4hfhCOhrZd2VS0i/Qh267T306xC9NeAjWx2Lhi5AXeBI2FRlEz6W3NuA+s8sFJql6OU9130FwhVgK83qXxuvzzfXZwf94ClvPNWOuLC/eyPoQ1cH/5cbNfmTaUiKRY3iGvBXgmbDXXxspc8oP0MDOZDuPyJadcyNebfNdvQJ+boIMM6tk802BIdl+NEJidlbIKDWqk0QvO+dviJOMayF5MyDe2FgOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/uq+NIax3dxwi25Mw+5R/V5Mj72LCr+zQc1DQzPTPSQ=;
 b=jRahd5NX2qaa36apsySK1sWjCPjMl9SyrzGAm9PDK+fe0PeUVuWobkOCTbfRHFoDMer3SyBRJOZ6VoRJa5gxiY6/BPhunGzWU9IxjnLWVcUq1w1Zs6K2OS/cpPMgGLC+iCJ8AGNBdFScrjoJKO7GvuhN4Y/7CFB6X7CBA/PGl2NW8NVb+s2J1JyxJCZ1h/8bMuhL+JSCLeKDkLQI5EWz7CWC4kOV2itl+SSb/ObmFlS428H3FpiGf27iz+p/lMrMkLOYeSr7m67f7j9jpBLo2aEMIzrFB5e884WJz3kXnC6OkxnB+YityJBnOUk26ip/sEUYiKi3vumBqAbxPGrAhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by PH0PR11MB5808.namprd11.prod.outlook.com (2603:10b6:510:129::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.37; Tue, 19 Dec
 2023 16:58:19 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::da91:dbe5:857c:fa9c]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::da91:dbe5:857c:fa9c%4]) with mapi id 15.20.7113.016; Tue, 19 Dec 2023
 16:58:19 +0000
Date: Tue, 19 Dec 2023 08:58:14 -0800
From: Ira Weiny <ira.weiny@intel.com>
To: Dan Williams <dan.j.williams@intel.com>, Smita Koralahalli
	<Smita.KoralahalliChannabasappa@amd.com>, Ira Weiny <ira.weiny@intel.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>, Shiju Jose
	<shiju.jose@huawei.com>
CC: Yazen Ghannam <yazen.ghannam@amd.com>, Davidlohr Bueso
	<dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Ard
 Biesheuvel" <ardb@kernel.org>, <linux-efi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>, Bjorn Helgaas
	<bhelgaas@google.com>
Subject: Re: [PATCH v4 7/7] cxl/memdev: Register for and process CPER events
Message-ID: <6581cba663770_24f6b2942b@iweiny-mobl.notmuch>
References: <20231215-cxl-cper-v4-0-01b6dab44fcd@intel.com>
 <20231215-cxl-cper-v4-7-01b6dab44fcd@intel.com>
 <4cb5c275-566c-9414-7088-1e91378a409a@amd.com>
 <6580b21723b2c_269bd294f8@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <6580b21723b2c_269bd294f8@dwillia2-mobl3.amr.corp.intel.com.notmuch>
X-ClientProxiedBy: SJ0PR13CA0184.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::9) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|PH0PR11MB5808:EE_
X-MS-Office365-Filtering-Correlation-Id: c2d9c3c0-db3f-4d18-0122-08dc00b3b3d0
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GjPN4fKXav+8aNwT8Fa5chK8Hl/kWZ97m8ZYYolnDXhFeHozlPwqHht783e8Zz/ZZF3FCJqzwa8tFsH08tBFgjQQqJpTaEEGJhxLiWuJ4ZpqxcMmy07Gd+DJR9YVoURrvKy0btt0icOmFLcxLfZYwhSc0vWgGBUZXN2wc4Z99O1I4T5XW+zrdVhk+P5RZYTNeQtQqnoOatc6wChqpTJ8/ukZh+YFj974wnKFBHY0QplL9QysfHFYLZPVWd5spGGBxF9VTHJIMWH+WsqoEpP/oNBjG0vfa0d7vsyq5y5p0+rQW7ODvUmYef5ir9n+bdvdq9MwAaLhbKG+i3wcR1C38Ri9HnDMBOfaqQwo3Ez0/b3H82qWm3vlGPWmkxbugUlvyT5l1g69cSxk6rwTT46sj1nn9+xQn/MVmwvzjKVUms2vgpvGM2UO8EW1t1A2kSHN195qbOqMD1Sy36sK0H8+GshpBo5lEZCN0L/M+a+7VKamkhazVrkbrrafxdHGucG1mPW4UseJ3GBCoEzWDlCF4wWi6Xf7obsZvrZz6AEMmDDRAioIEEkfXgX9hWbw6a+A
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(39860400002)(136003)(396003)(366004)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(6666004)(9686003)(6506007)(53546011)(6512007)(2906002)(7416002)(83380400001)(5660300002)(4326008)(110136005)(8936002)(8676002)(478600001)(41300700001)(66946007)(44832011)(316002)(66476007)(66556008)(54906003)(6486002)(82960400001)(38100700002)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?B0GU4lXL6eePx/JxtHbxQILwCjTSFUkk48UPjD92aew2hJulvv8HiKn4Ch5j?=
 =?us-ascii?Q?Go/uk9R9Mi7bHmDGeRJ4snFSMFeX2QZcFTt9hNVIa9nRTmSdyj10BfzCYaOG?=
 =?us-ascii?Q?qCH7h3pTrJXY4FQ1HaQ26OAtaygIg1/DhdidMPxgjP/990UJts8X3WmWb5rD?=
 =?us-ascii?Q?hvCnk5bRQOQIhxZkQ64PRp9BSo8J+UTNi9wgmkYhr56PzuIHg/l2ZH16bcxo?=
 =?us-ascii?Q?2ZLStfgJSSv/AMxFBAlCndwhtoAj10RUpFysvvpxECOO08iIbCsu+5hv+I5r?=
 =?us-ascii?Q?KSzL7wNjInKyu9oCsyW5Y3A6DlRFPmRqcV62iVkM3NQJmtCpu+Loljz0kQhm?=
 =?us-ascii?Q?lcE3epZzRSqhLSNCnD4NqSj6NApKklzzmNah2f5It9+kRmaLch4AtHwDfGr1?=
 =?us-ascii?Q?ZRsbPryMHFs2FeELhveVgvBQ2VyyYWkVCFnyN8kmDpV8rb68/JpCyVP9uJK4?=
 =?us-ascii?Q?n7NRGG6l6UBSY1aGGrencSGZ25tKY1f93/JX+R43FDkJkBq0nVk8W8CoURSP?=
 =?us-ascii?Q?HCCPQ4vMFui0g0EN0kW+XfItu9jldtK9vEzXfsXX+VvGdX58oY50coTbLDoR?=
 =?us-ascii?Q?GxIC7Vo1yYnLbJPYaCxtQUeP59g782rk90leNmyG/PUUZGNulyaVs56iTW0J?=
 =?us-ascii?Q?s7sKe4kvmqTUmZz3xV7i9t3ERFJQGTn1dCS+J6+3EXAnA2F5C+X0Rl1jKw0A?=
 =?us-ascii?Q?+YWdNMvvsltYpda+193d/NBh4HO9vU6KnzWkbHTVKMUDLQSGou5oePgzeQy9?=
 =?us-ascii?Q?Ta/OW0bnVLoEgiEdF21qz6XqCNOmaNrJ/WQ4+pKVaJrPbviooqPMzyZQDqEm?=
 =?us-ascii?Q?EKj4/bpvX8lZ9+GBZNEIeMvWBpzhG1v1b3xrX2+0gqW2OlGhF1FukPpRD+FM?=
 =?us-ascii?Q?Uz34/k9iaLDqgM047NBEvmUbx0Cxb+89jjjkC8Mj52TXLp1TFioI6g9AUVMt?=
 =?us-ascii?Q?RP0eSkU/WBwbEU8rODqBsJmWCyNdU1Qlq28dxNSvjqM+B3Xcv0EBPHkX+zfT?=
 =?us-ascii?Q?a4U4VYuYUXd3snlI6MhqDgG5UY1nadSGH8ctt4qnufR6wdvY2keRgRurjrmy?=
 =?us-ascii?Q?g1uDbZTOeyeTSOs72Do7iqTZdV5BX7RPtxU5RTOnPLl9M+Xna6ZTu1Y0mkw0?=
 =?us-ascii?Q?/wNy+vKGD0zrhN+rZkiVgSEVrOX8xcMfZLnF+hfkko94LRGN3iLhMrPWxTy/?=
 =?us-ascii?Q?8T3c6oJjgjX1eoqtWUZSen9SYwRCgcw+L/RHCIuWlYog+ADsiZ2S3jkbCzSB?=
 =?us-ascii?Q?K8vyv/byFZ4icQJeVkPxqtlpfS4BIgiW/DTpxpBJqcKEv8bJ7mo1u8EMONkN?=
 =?us-ascii?Q?EKr7p7eRti0rkEnmbAHGKdWelLyPGa34iNlQSCVCw/+HZ7iYfXla7OMc01PF?=
 =?us-ascii?Q?Zh89NnQcYz6vffwwioGdYKNF2MVnbSNRn/cjGKUKvwj+Jx6p+DwdgKTHhYFJ?=
 =?us-ascii?Q?kQfFDHODFwr6E7UHTmE8hHJaYBMjeGWW2xJPjB4/ZLE4Lcsmau7uSTSi2zY6?=
 =?us-ascii?Q?stAwBwD6shqNmSj7VsXmp6Sq/Q/OXOG1estIrcfVOJEs/4CmxVjCsXx42Cpt?=
 =?us-ascii?Q?ZBNsgs9ooPROKPqTMf9yVz19+zk6xhuICdrlBSVM8YK1wlvS5GQR3wZHh/kI?=
 =?us-ascii?Q?a9jeB2tRvIUCqCaogg6+OQ6sKj+ti2uQgELbtD4ekMuN?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c2d9c3c0-db3f-4d18-0122-08dc00b3b3d0
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2023 16:58:19.7123
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WoxgTvaZP1RLKnG9BiHh91O8EyyIGGv4CVY3EVjPcHZGBvVpdPbZXbL0UrqnVXL0oYcIJ2c9SVR5Zj1SNu5LEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5808
X-OriginatorOrg: intel.com

Dan Williams wrote:
> Smita Koralahalli wrote:
> > On 12/15/2023 3:26 PM, Ira Weiny wrote:
> > > If the firmware has configured CXL event support to be firmware first
> > > the OS can process those events through CPER records.  The CXL layer has
> > > unique DPA to HPA knowledge and standard event trace parsing in place.
> > > 
> > > CPER records contain Bus, Device, Function information which can be used
> > > to identify the PCI device which is sending the event.
> > > 
> > > Change pci driver registration to include registration for a CXL CPER
> > > notifier to process the events through the trace subsystem.
> > > 
> > > Define and use scoped based management to simplify the handling of the
> > > pci device object.
> > > 
> > > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > > 
> > > ---
> > 
> > [snip]
> > 
> > 
> > > +	switch (event_type) {
> > > +	case CXL_CPER_EVENT_GEN_MEDIA:
> > > +		trace_cxl_general_media(cxlmd, type, &gen_media_event_uuid,
> > > +					&event->gen_media);
> > > +		break;
> > > +	case CXL_CPER_EVENT_DRAM:
> > > +		trace_cxl_dram(cxlmd, type, &dram_event_uuid, &event->dram);
> > > +		break;
> > > +	case CXL_CPER_EVENT_MEM_MODULE:
> > > +		trace_cxl_memory_module(cxlmd, type, &mem_mod_event_uuid,
> > > +					&event->mem_module);
> > > +		break;
> > > +	}
> > > +}
> > 
> > Is default case needed here?
> 
> Yeah, it looks like an uninitialized @type value can be passed through
> the stack here.

That was not my intention but yea.

Added a generic trace with a null UUID.

[snip]

> > > +#define CXL_EVENT_HDR_FLAGS_REC_SEVERITY GENMASK(1, 0)
> > > +static void cxl_cper_event_call(enum cxl_event_type ev_type,
> > > +				struct cxl_cper_event_rec *rec)
> > > +{
> > > +	struct cper_cxl_event_devid *device_id = &rec->hdr.device_id;
> > > +	struct pci_dev *pdev __free(pci_dev_put) = NULL;
> > > +	struct cxl_dev_state *cxlds = NULL;
> > > +	enum cxl_event_log_type log_type;
> > > +	unsigned int devfn;
> > > +	u32 hdr_flags;
> > > +
> > > +	devfn = PCI_DEVFN(device_id->device_num, device_id->func_num);
> > > +	pdev = pci_get_domain_bus_and_slot(device_id->segment_num,
> > > +					   device_id->bus_num, devfn);
> > > +	if (!pdev)
> > > +		return;
> > > +
> > > +	guard(device)(&pdev->dev);
> > > +	if (pdev->driver == &cxl_pci_driver)
> > > +		cxlds = pci_get_drvdata(pdev);
> > > +	if (!cxlds)
> > > +		return;
> > > +
> > > +	/* Fabricate a log type */
> > > +	hdr_flags = get_unaligned_le24(rec->event.generic.hdr.flags);
> > > +	log_type = FIELD_GET(CXL_EVENT_HDR_FLAGS_REC_SEVERITY, hdr_flags);
> > > +
> > > +	cxl_event_trace_record(cxlds->cxlmd, log_type, ev_type, &rec->event);
> > 
> > Currently, when I run this, I see two trace events printed. One from 
> > here, and another as a non_standard_event from ghes. I think both should 
> > be unified?

By the way, Smita,

Thanks for testing!  I really do appreciate it!

> > 
> > I remember Dan pointing out to me this when I sent decoding for protocol 
> > errors and its still pending on me for protocol errors.
> 
> Good point, so I think the responsibility to trace CXL events should
> belong to ghes_do_proc() and ghes_print_estatus() can just ignore CXL
> events.
> 
> Notice how ghes_proc() sometimes skips ghes_print_estatus(), but
> uncoditionally emits a trace event in ghes_do_proc()? To me that means
> that the cper_estatus_print() inside ghes_print_estatus() can just defer
> to the ghes code to do the hookup to the trace code.
> 
> For example, ras_userspace_consumers() was introduced to skip emitting
> events to the kernel log when the trace event might be handled. My
> assumption is that was for historical reasons, but since CXL events are
> new, just never emit them to the kernel log and always require the trace
> path.
> 
> I am open to other thoughts here, but it seems like ghes_do_proc() is
> where the callback needs to be triggered.

I see.

Ok.  I'll create a pre-patch which moves the protocol error first then
I'll put the events in the ghes_do_proc() well.


[snip]

> > > +	rc = cxl_cper_register_notifier(cxl_cper_event_call);
> 
> Quick aside as I am reading through this, the "notifier" name is
> misleading since this callback has nothing to do with the
> include/linux/notifier.h API.

Fair point.  I debated 'callback' vs 'notifier'.  I'll change it to
callback as I think that is equally correct and as you say does clarify
this is not a 'notifier'.

Ira

