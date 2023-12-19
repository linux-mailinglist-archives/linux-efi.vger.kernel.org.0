Return-Path: <linux-efi+bounces-265-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9FA3819498
	for <lists+linux-efi@lfdr.de>; Wed, 20 Dec 2023 00:27:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEA711C24B73
	for <lists+linux-efi@lfdr.de>; Tue, 19 Dec 2023 23:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC52326281;
	Tue, 19 Dec 2023 23:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GP+fZtu8"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36AC40BE1;
	Tue, 19 Dec 2023 23:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703028442; x=1734564442;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=u0a9hYWL8suSJCcHi0cemxLU3w1Pv9IYN6rw2Ft6MuU=;
  b=GP+fZtu8mTdWA22ZhNwae2BTgIS9ykOYL0JzED6zgmQmZrVSmbEEaH0f
   t5z+c7x+Wm3ioI/nikq9vFJT6LkeuF+10VXTuHb6RZlhTMZMn3Oj0JPE8
   hm/APjjYDt3EcDX3vAG0PMH5dc+YJNRhNVR7r1soilmjsyTL72A35mODT
   SN+DRQlBTaPBdujsR+gZ+pY4lILijFiX+0o0TV5N1QqFaUR6F1ctpCyBq
   GUbXe4ktPDD3Mi091d24JNNIbWNm2WOZft5Ap8ArDPDCMFIiQMZU+T7YW
   sM7i6jYhfwhqShf2rZseDDd2H2stt7uYguJf6qT7XqX1LBRMprWGe3KL/
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="398518642"
X-IronPort-AV: E=Sophos;i="6.04,289,1695711600"; 
   d="scan'208";a="398518642"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 15:27:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="1023290057"
X-IronPort-AV: E=Sophos;i="6.04,289,1695711600"; 
   d="scan'208";a="1023290057"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Dec 2023 15:27:21 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 19 Dec 2023 15:27:15 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 19 Dec 2023 15:27:14 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 19 Dec 2023 15:27:14 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 19 Dec 2023 15:27:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UdS6PB7FILY4GyNsviihKbxu7fJMZiUEGd+85JDgNv+a4CER8M6Lu1pdAnKfUF0tYsRfno8YkQSP2CiPcR2Kn6ArjgfJd3O8do2/uyzZ7p03+MlvYfn1U/3x2M4/fjgNb5BSHKhrEgEZP4/Gd0HQX1PkCeQlNvZ0kSaLbSEtFUzPgbAr7iXBrVvrqq517PEOtkpQNhCP6oPoVZjCB3koPaKwdY2jqyFapCmtLCNMocT6JldX450crntOzJniA9GBhFYISk433JnMJ8MmFLYEXGFM3AGtuyWP+FeN/lZB5AqgMb+DE30PBdej4pZQYaCEkufjDlV9hcC2kPJLkf96HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WdIgNmZWA83RvdiwWbRtm2wSisKOoAh2krjiHlgyNH4=;
 b=gJ32Iakzf43Fkf0G/g5HqjcSlcMnW/fkAYR90S1FJUXscXT6x0KGdbo/JjkOmjZyeTDxQOzpUm0Kn9EmKQeux06wyxhqeUavGrA4yUCF1nznselvuPmQ9kTP5tCsXaBq5/lIOA1/GJDoPnTZyYZ+1re9dN4QmHNCP7SDRM2BpjF0kBMb/1GR/GD1NXJlGoEOM90hjjcqIcE9eiEg78642gwQxdxqDWQz+rKPtp5De4GO/jXFvqWUiudQPll7LHBVYFhxEaaX7kBrfXIzyEllZHLSC2hg1Qr7v1TnrsOydNYCanJO1Li41pCS3/NNZVer86hBZ5LzAizBashLM69kgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by IA1PR11MB6076.namprd11.prod.outlook.com (2603:10b6:208:3d4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Tue, 19 Dec
 2023 23:27:12 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::da91:dbe5:857c:fa9c]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::da91:dbe5:857c:fa9c%4]) with mapi id 15.20.7113.016; Tue, 19 Dec 2023
 23:27:12 +0000
Date: Tue, 19 Dec 2023 15:27:05 -0800
From: Ira Weiny <ira.weiny@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Ira Weiny
	<ira.weiny@intel.com>
CC: Dan Williams <dan.j.williams@intel.com>, Smita Koralahalli
	<Smita.KoralahalliChannabasappa@amd.com>, Shiju Jose <shiju.jose@huawei.com>,
	Yazen Ghannam <yazen.ghannam@amd.com>, Davidlohr Bueso <dave@stgolabs.net>,
	Dave Jiang <dave.jiang@intel.com>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Ard
 Biesheuvel" <ardb@kernel.org>, <linux-efi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>, Bjorn Helgaas
	<bhelgaas@google.com>
Subject: Re: [PATCH v4 7/7] cxl/memdev: Register for and process CPER events
Message-ID: <658226c9a49f3_277bd294fb@iweiny-mobl.notmuch>
References: <20231215-cxl-cper-v4-0-01b6dab44fcd@intel.com>
 <20231215-cxl-cper-v4-7-01b6dab44fcd@intel.com>
 <20231219143732.0000181e@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231219143732.0000181e@Huawei.com>
X-ClientProxiedBy: BY3PR04CA0026.namprd04.prod.outlook.com
 (2603:10b6:a03:217::31) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|IA1PR11MB6076:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f4da181-0ec5-468d-ad9b-08dc00ea06fd
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ESVZHgGYKgwFI2rzQfXdRqs4TuaBtPmCsryQoxevk2khF5LLnJAxNcLEff9oleolurwXQqzbp5qCe5EmP/XTk3XxdV5x6QPAvtkPfW9zmCO+QYaRYt7lA2GjrgSz/0mGAV4aVc3i7X1/CY/S0Gab1Im2Chn1Rs5SwcQlnnuSogVAc/ETpdpZZQ7EPemptEGcEJBUq9nx0H2vt+ofuIAOdWTu9mtmyhTEK+nQMI7CyxlqNOS4/K0NbwLGYtxM2SqAlWD/RVdAioQPr1z28vUzlZdCxFjO3ARSOXpTXGPoEuftna2UiS4iasG/Rk5uIqV0b+5C/3cXfbyOoWIxSKMuSrMj4nvSNq0zt+Ejh1wzTGnygCIkJb7AK8YGd0GZ0ozIKQfC5ZFFfupHefLCtFu8/JeChYensxdrQt8SJF6qft0pH1bHSw4m3i8J9cSm+Ueken9QAr9/Y6sj5emVpzO3Xf+H+pDg/OrlL5c0BYkzVESziOdjHKLuTx+nV23QHouk5tMcWT2+nDK7UGSIxWVF5yJ+vwOCyrZQ1Aff13Ac5tN85FylWjI3hdeUwNfRGSkD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(346002)(39860400002)(376002)(396003)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(44832011)(2906002)(8936002)(8676002)(4326008)(6666004)(6506007)(9686003)(6512007)(316002)(110136005)(7416002)(54906003)(66476007)(5660300002)(66556008)(66946007)(82960400001)(41300700001)(38100700002)(6486002)(478600001)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6kzoraZoV0Dzho+k7YsU/OXXYVUbAXaDdXh3Hc4k77kA++gg18YXVAdZuSPB?=
 =?us-ascii?Q?G8ABTBc6JDvQ7ZVOlTyYdY0F/v24CCKmTZcJ2ouxIMNY27rrMXCvgW9CYwIF?=
 =?us-ascii?Q?zUY4TcS671IA6wtuJYaRlrOQZ+hjesvn8L2dJtj/8FtithLCttR0IofVuPUJ?=
 =?us-ascii?Q?SznnwH7T+j8/f5CwnEL5BryPjL6ltAmXbe1j9ZqLJfZcWnYWxQIBVFGmvhK5?=
 =?us-ascii?Q?/FzKqiUs7vmVn1s6cCsjDgLRnf/mYKvzifLS5VzEc8BjRzwTkx3D+wFR3ugN?=
 =?us-ascii?Q?3BTryqetRIpPFINuR17U7VHf2kFxoWQIZDIhejybdSJu/hwoN+jonBluvjhI?=
 =?us-ascii?Q?zJer60MIQzArza/Swit+v7MRgAhNI4vc2zNb+bg9x59pNWL6VluENcb47SMY?=
 =?us-ascii?Q?PbBRv4SHUKEcKY/7v4rBKsUGioVVIOmNYT2u8Di7H2RIb0P5RAB75JYxc0K2?=
 =?us-ascii?Q?b5bEFPvvtcOAShi95UlkbZoKv1SBOmsGvj0NM97EZ1v5Xr6inSYsVAWfNIM+?=
 =?us-ascii?Q?Jjx4Toe9B5dDh9aFEtqRQnT3PvVlfv7r81uQiSb8PTVDLxE344CaJuCB58LY?=
 =?us-ascii?Q?X6LsuDAIktZCV5F1JxSYhk5t2XQ4YX+O6zyIflHqSA+gr7H4x6+USRG3/q+T?=
 =?us-ascii?Q?kA2V+wWA6lteLHFhuzru/k/JBLwosE2xJvlATMBXMYKSnL96a1eHeIj7HLps?=
 =?us-ascii?Q?PWv4oHnETEVMoo0DOSlA57ZXSPP+8gF/Nsi1wqd6L0OKDrQgj1UMSmfhZhzZ?=
 =?us-ascii?Q?Oh47t9HCJJr0va2hJ/u8x1lHyzexK5ktjVk+DgAVkgrIgO077IRH3pSXFDZ4?=
 =?us-ascii?Q?y9HYN2M21FkIQkAP6dekz38ypO1RlT+NfqaVwWcHwZtSdad7VUJrMbac6zjw?=
 =?us-ascii?Q?W7CfmOC08N+5HQgtbVYmOdZc9wGWUpHf1lXQD0HD0udCH3sgG262FVYjTzl/?=
 =?us-ascii?Q?DeXM4kvfsJT9b4kAr/Qy/FhujUImlofGjJh7LBZt8U1M+vyP2GNRT+Y559nj?=
 =?us-ascii?Q?bd6IgdvMjhN+JxFA2LpMRNDvGj2mrLy///DWr9+uAZIkL3vl7OycRjXmn1pX?=
 =?us-ascii?Q?SWO2/apX3kTzdj1vCK8U2lM3eZ565143sP07vGWlRI96AvH5Kx2K6USGi/In?=
 =?us-ascii?Q?ZO9BhMh1WEoApndyToPAlxg2MXu67u49Xkr9buoYKqlJBciukKljsyAMfoaN?=
 =?us-ascii?Q?u8kCECDIaRXx3Nr6k5dsfsVrkIlpivoBYqxnVmLBJhYrGabceKwfQkLlIMXj?=
 =?us-ascii?Q?lpb4lddX3N9WJRFkiid/e/kKZ+Mfpximpv8SWScg9HHWovEkxxfEHLdOllqj?=
 =?us-ascii?Q?vVUjgvEpIeCr2eC+pfH6/Q1EZCed0j/bQwXt6jDbEwc4OZkLqCS8SZKeq/WN?=
 =?us-ascii?Q?BE8MWBoJKRDjs5VLLHa3558iJJt2XVytwSmOfLXb3NhvOSlO3Lnk4A/zRnYy?=
 =?us-ascii?Q?68XbqZYjaBO0J59I3P4hYTZt+B3iHcXXPr7l+IymVjfUSCe5HKEdl6AiJYYP?=
 =?us-ascii?Q?u30z/HmOStG7ujy22g1E7gQ5fkvzf40uwIGid49I7J8Si5v3cfS7F3z+ms2+?=
 =?us-ascii?Q?noS2ChU0Hwj2VaW2q8SZ8SR1pK5SbbShOSnUTf8RDtHhK0Ogzzuv6U/+97Xy?=
 =?us-ascii?Q?UCXOdEfd3lB5Qf7UBAQuIY0NpO1KJYelyQs+HPvQwOxA?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f4da181-0ec5-468d-ad9b-08dc00ea06fd
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2023 23:27:12.1719
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CHVOtIXp0NFgye5Rt4cqVzJuqQAv90USZv+oY+3eggAsLFtAgiIyQPYsH6H0iglKShvfXEmRm3vae+ivzM8lwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6076
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
> On Fri, 15 Dec 2023 15:26:33 -0800
> Ira Weiny <ira.weiny@intel.com> wrote:
> 
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
> 
> I'd break out the pci guard stuff as a precursor patch.  That's likely
> to be used elsewhere so it would help for backporting for other users
> if it wasn't buried in a patch doing other stuff.

That is good.  I've done that.

> 
> Not to mention that has a different set of likely reviewers to the rest
> of this patch.

Yep.

> 
> More generally maybe we should just hardcode the UUID in the tracepoint
> definitions?  I think for everything other than the generic one we
> only ever call trace_cxl_memory_module(... &mem_mod_event_uuid..)
> etc.
> 
> It's a little ugly to match on the UUID to call a function where it
> hard coded, but less so than inserting the UUID like this does.
> Better I think to make it obvious that this isn't actually a variable
> (for the ones we understand).

I thought about that a bit.  But I built the tracing code with generic
macros which contained the UUID.  That complicated my efforts.

I've reworked it again and it took a bit of time but I got it to work.  It
was not that hard but there is a caveat in the generic macros, which I
made a note of.

[snip]

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
> 
> This is handling two conditions. I'd find it more readable split like:
> 
> 	if (pdev->driver != &cxl_pci_driver)
> 		return;
> 
> 	cxlds = pci_get_drvdata(pdev);
> 	if (!cxlds)
> 		return;
> 
> and drop the = NULL above.

Done.

Ira

