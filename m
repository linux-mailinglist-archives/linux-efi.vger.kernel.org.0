Return-Path: <linux-efi+bounces-336-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E1F8824A74
	for <lists+linux-efi@lfdr.de>; Thu,  4 Jan 2024 22:47:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06D6AB21E17
	for <lists+linux-efi@lfdr.de>; Thu,  4 Jan 2024 21:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 749932C845;
	Thu,  4 Jan 2024 21:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gO4mDHQa"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB1D2C6BA;
	Thu,  4 Jan 2024 21:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704404824; x=1735940824;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=2rkuCEBuk2pKSS1fQ2nmtyUZzkK+TOK5AaDOFZLZMB0=;
  b=gO4mDHQaPF46YFt9rlIA8rXrBrhA5FPKJvM8p5Bov0F6BgPG18l7YvQm
   VBvd8Hgxo3FF5Q5+DwIw/U/qYUaXU2Kj3kxIwPX8qSjXIsFSwz04MIFEF
   axtgmvFMF90THzoF9/uvB++UF9dH5sUKuGUD1kFoLt0w/yIiDLQjfD100
   XCkRH4llP2Su2SzS2HUY25lDEwzvZJ7QpXh4yF5iMRlfpdxH+Fq33iOQp
   XzrYAoTqcZWyrQ2XWnsQNfgUo4xo+IAd+H4id0w/WamTt3lmI6+MFwbxQ
   Ot3tNg0wtxTKTLK1xx9KZw7te5BkF6KvXdWpBtur/KAkqGrWdIDHuuAK2
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="382348531"
X-IronPort-AV: E=Sophos;i="6.04,331,1695711600"; 
   d="scan'208";a="382348531"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2024 13:47:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="773658221"
X-IronPort-AV: E=Sophos;i="6.04,331,1695711600"; 
   d="scan'208";a="773658221"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Jan 2024 13:47:02 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 4 Jan 2024 13:47:02 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 4 Jan 2024 13:47:02 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 4 Jan 2024 13:47:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ePcKUpBThLcd1FcGB2GN4olBy9sPrSE9omQJaTBCvPlpR52ETmxOZlTlvXnCgNdX+zCXlDjBGyPgD0Lj2SWthhW0iv+aKSupKPivBemyudxUh5veyVMCn7oyOO/2X8AGZBGM3ktU7VKDWsPey2z6aBLOehH4Q/hP49AzoTo+KIIW2ASInVngtsv4W9HA1J02i++s/elji6xW27NMpdj4W2INkZtuMdlg8iIClMX0oy5KJsuZQSN8VcSRC80DQ5M03iCmG7J0EHb+SGujwVcF/ip6k/IY2pisj086oy3yhj+JEiC2k7a/Icak4oXMlGC4tKW48ORgMZjlqeQxgIqRng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pIUgY2YDmP5aETGi/f29D44FPF/sp4OWxiwKClSiSac=;
 b=ITnV5fyeHcX+HBDVAqaC3SErApSBmuHoSXY1USeZ+gbFkIvIu71dALUxeaBd3QMgrL6dGuXIqEdZfxVHiTwRCl/Qm1EsldsEXBWFyBGpR8eBMjyyjs9HGG4YUiM66SrVUfzxeSc93LpSuteNIZwLDRWg7JeUKJxAmDCtebHoeoD0qc4V5g7EmUQ8RFUpCDUe9n6XfArxoki46uHcfXWe2+Qf4+CvpXPejwze6k5Kf/k3DPo4hullUJ0adH4u2fDWNTpZN+uteeh9mNqfBGjuyTq3FL+IS5iJ9HTZuwi82UmpEeWEHgqhRUq9LCTZSPdROj++u22P8e12aU1XQsH5Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by SJ2PR11MB8497.namprd11.prod.outlook.com (2603:10b6:a03:57b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.16; Thu, 4 Jan
 2024 21:47:00 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::da91:dbe5:857c:fa9c]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::da91:dbe5:857c:fa9c%4]) with mapi id 15.20.7159.013; Thu, 4 Jan 2024
 21:47:00 +0000
Date: Thu, 4 Jan 2024 13:46:56 -0800
From: Ira Weiny <ira.weiny@intel.com>
To: Dan Williams <dan.j.williams@intel.com>, Bjorn Helgaas
	<helgaas@kernel.org>
CC: Bjorn Helgaas <bhelgaas@google.com>, Ira Weiny <ira.weiny@intel.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>, Smita Koralahalli
	<Smita.KoralahalliChannabasappa@amd.com>, Shiju Jose <shiju.jose@huawei.com>,
	Yazen Ghannam <yazen.ghannam@amd.com>, Davidlohr Bueso <dave@stgolabs.net>,
	Dave Jiang <dave.jiang@intel.com>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Ard
 Biesheuvel" <ardb@kernel.org>, <linux-efi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
Subject: Re: [PATCH v5 8/9] PCI: Define scoped based management functions
Message-ID: <6597275045fbf_267e82949d@iweiny-mobl.notmuch>
References: <6595f9eec5986_be70229443@dwillia2-xfh.jf.intel.com.notmuch>
 <20240104183218.GA1820872@bhelgaas>
 <65970003ee9ef_8dc6829412@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <65970003ee9ef_8dc6829412@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: SJ0P220CA0011.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::31) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|SJ2PR11MB8497:EE_
X-MS-Office365-Filtering-Correlation-Id: f8e3c414-222f-4433-8f2f-08dc0d6eae2c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nrZrqLHQjemIKQrk0pqoyJHxxC+Qv/FHugMz1IcyVuhfFvtr0NqWfCPktm7XX2ZdSzyr9e5E4MUGK9A9QXC1Yt6f0/Nia/62aN4CXgt1kCY418N5O0p08rNQVoYvqRjEeY2iEnu5Y/Ys6N/OndZlw7T9H9GR8rGSDEJCtmHR1OUMqKzWYmVTdl7AHX3h/zaYB+aFZjYOdeVTNMPAjb+Zfd0BUr4tInf9403KyZ/xliAyDPhhHGYHYB0VzJEJKuUEA0s2hAlxSzTw/jYkMCXG9KMvjEJnlUoLHlEWdB9+UIOuzPwjpiTKN3mowbwaikxzEqkSHxS9aUB+Yi/a34+7IEw0g6HOdT6i6KiH/lNtX5zRodVzoVZgskJRNgttakZenNHUq3Mfoh6gW4MvJX1n2fuNuhV6rE8+yEA2aQIlM/erk2BDYTKPNPOGxtrpWLRNtcWAGDp3wMUbT/DCx2hTbgyTx85H2InI+xhdd1s50KC6SBsMsuhWXHYR2OseMHrffsHbCbVJImoHhgM4Cxy7+q3CnUE027BfQrZY+Wl8CnwZ0gDyulXx6Z91kXKd6ueQ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(376002)(39860400002)(136003)(346002)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(6666004)(26005)(6506007)(9686003)(478600001)(6512007)(38100700002)(86362001)(82960400001)(44832011)(66946007)(41300700001)(2906002)(83380400001)(5660300002)(7416002)(54906003)(8676002)(66556008)(4326008)(8936002)(66476007)(316002)(110136005)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?U09usRBCrjSlY88cx1Eok1C/f8thM+tT1w1AmgfcYzAEacDCF6TyvIwRRr+8?=
 =?us-ascii?Q?X8OWO2ws3t7/MmLvKvs7h7MuBQiUwoRIt8h4XDHsT3zy+2lmBIZNn6gEF/SL?=
 =?us-ascii?Q?mNPfCKpelD0u3vKuL0/pLYMRzwnE1H4+hfqaDmO2tVJspoypiypXOOUI/2gk?=
 =?us-ascii?Q?u/2fNoM7T2m9lroKDV8zjzpwWdqhFUNTz0pBnE8KJNsJdwO2XRfdJD6pK8x9?=
 =?us-ascii?Q?VsaqzhmLMp40iiud6R21lQoBvxDDJ1UvjNBCULeppG75H2YhRKtTqOmNIGPz?=
 =?us-ascii?Q?UdIud/e/Htb8/8JAoMwQH1PXCEkv7SA0a64Tdbmn8HO4GZKmiMQPSf8manNR?=
 =?us-ascii?Q?g6CTqJH1FbT0d5v63aYeKQB7HNW2/c8o6nEy3rCc/pu2fEzR14ciwoR3vb/K?=
 =?us-ascii?Q?IpyEcqaGgWcCV53ZUvhYnGnlKOBmLpeO3aZ9+LkH9W//GLZ+J0KfKD1b0Pr/?=
 =?us-ascii?Q?+nlLMjPbp2AV+b2cWRSZ0flaN1epX/DwFlpZAr3IKD7Q1MGc2Zg4GSGQ3ihK?=
 =?us-ascii?Q?Ha9bPBZURfj5O/YRxYTi3ytSJjoJCImTCfZEmEcPpBDQAokAH+pMfCSaGkDz?=
 =?us-ascii?Q?AVd7JEiUHMsR7kowMxq8BjVrIXmV2JUXHbbh3FoGQAf+/aMBbfhS/AvTuQg5?=
 =?us-ascii?Q?u/c2s2IOs/6jH6U6ZyCQhSDLQia+VY4kW+QqucmoigFmyWM58tuONd7EXqMV?=
 =?us-ascii?Q?ZeLAOdoamYAuoIchDMj+A8LrdZQ9ocNoARYUlQzCiRG9+GeTlYxq/a0YY6xS?=
 =?us-ascii?Q?q+YAElPJ4fD7X37qHspmjvrn2Dmowgv3yfNIeBWp0zDmY9sMUqgvxZbfPVpm?=
 =?us-ascii?Q?guAJmb7mNvBrCVetm0Up7r2Ki/d70Xh85YAf/Lel5WgYkMY1YcNXnW71a61u?=
 =?us-ascii?Q?KwnZH1xEwmhixVNbUacyO/6tT0l7+L7lF1OedNkMVHHwpaOjm5pB4igIoN+n?=
 =?us-ascii?Q?fEcv+IY/bC8V5Mjwgkf5Qx4s2P/k9XptGqPYSob+ffDBs0Zftad4xersFJuX?=
 =?us-ascii?Q?THzYoagnUIvtjQOj26hvnWgA/eGiy7wq2INvfQzLv3ekOqsMgHnSoQelChqe?=
 =?us-ascii?Q?DFbMeuxGAzGXdFKcO5xHXH2AShIGdjlOjRYQ/e6pmOprDFkw5HvchtrMgNGe?=
 =?us-ascii?Q?eT+pJeZ7ZaQHQjCzRXb8JAjR/SXlsSRvPd9tWl2rNknd5zy7eDvEVRlPL3tu?=
 =?us-ascii?Q?3tx/rek9o6nGIiON2F7ljl2D2s47oDcmlnsOnOIp4GX3vgnEPqBA8/zkaYPf?=
 =?us-ascii?Q?6zc3VTiO4M35GvQqCqmhViFi3qYYXlmziWxPdCYtf+1M9lFbfP7VvxzbCjv+?=
 =?us-ascii?Q?AMTEkG6NOty/79CwTOemNkBN3KjQsVgwL/Ntm5aJexZ7RsQ54SyqaLdCbNQ9?=
 =?us-ascii?Q?OYUEmiF7d81pz1yyHXCuC4oLSqkVOBrURJgQbYpKSMZWf83Ys6E2zY9E4KTt?=
 =?us-ascii?Q?zArhHQ8wzWMqoMOsRdAcDeEyIsJXagP70uxdRHGBKlgecMeT8y6VH4GtVk8s?=
 =?us-ascii?Q?6xqhznXePSiNjS4dAlaadJTVaa3Zv7EZL41gR8dGLadrI80wf91N+VzqSuH3?=
 =?us-ascii?Q?yl0pdrzX1XHFiaBtVBnHexdg9hH00Z4N6cp6FSf6?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f8e3c414-222f-4433-8f2f-08dc0d6eae2c
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 21:47:00.1633
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 04b30ARXeNb/I22sEcrwwFrRH93YNuLxXybOp+mBJ6wEE9AQu0IM//X/M/6pRjPhLQe+Zq0aR56R3nEcpnd7oA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8497
X-OriginatorOrg: intel.com

Dan Williams wrote:
> Bjorn Helgaas wrote:
> [..]
> > > ---
> > > PCI: Introduce cleanup helpers for device reference counts and locks
> > > 
> > > The "goto error" pattern is notorious for introducing subtle resource
> > > leaks. Use the new cleanup.h helpers for PCI device reference counts and
> > > locks.
> > > 
> > > Similar to the new put_device() and device_lock() cleanup helpers,
> > > __free(put_device) and guard(device), define the same for PCI devices,
> > > __free(pci_dev_put) and guard(pci_dev).  These helpers eliminate the
> > > need for "goto free;" and "goto unlock;" patterns. For example, A
> > > 'struct pci_dev *' instance declared as:
> > > 
> > > 	struct pci_dev *pdev __free(pci_dev_put) = NULL;
> > 
> > I see several similar __free() uses with NULL initializations in gpio,
> > but I think this idiom would be slightly improved if the __free()
> > function were more closely associated with the actual pci_dev_get():
> > 
> >   struct pci_dev *pdev __free(pci_dev_put) = pci_get_device(...);
> > 
> > Not always possible, I know, but easier to analyze when it is.
> 
> I tend to agree, but it does lead to some long lines, for example:
> 
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 4fd1f207c84e..549ba4b8294e 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -975,15 +975,14 @@ static void cxl_cper_event_call(enum cxl_event_type ev_type,
>  				struct cxl_cper_event_rec *rec)
>  {
>  	struct cper_cxl_event_devid *device_id = &rec->hdr.device_id;
> -	struct pci_dev *pdev __free(pci_dev_put) = NULL;
>  	enum cxl_event_log_type log_type;
>  	struct cxl_dev_state *cxlds;
>  	unsigned int devfn;
>  	u32 hdr_flags;
>  
>  	devfn = PCI_DEVFN(device_id->device_num, device_id->func_num);
> -	pdev = pci_get_domain_bus_and_slot(device_id->segment_num,
> -					   device_id->bus_num, devfn);
> +	struct pci_dev *pdev __free(pci_dev_put) = pci_get_domain_bus_and_slot(
> +		device_id->segment_num, device_id->bus_num, devfn);
>  	if (!pdev)
>  		return;
>  
> ...so I think people are choosing the "... __free(x) = NULL;" style for
> code density readability.
> 

Also in this case we need devfn assigned first.

Is the above patch compliant with current style guidelines?

Or would it be better to do?

diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index b14237f824cf..8a180c6abb67 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -975,15 +975,14 @@ static void cxl_cper_event_call(enum cxl_event_type ev_type,
                                struct cxl_cper_event_rec *rec)
 {
        struct cper_cxl_event_devid *device_id = &rec->hdr.device_id;
-       struct pci_dev *pdev __free(pci_dev_put) = NULL;
        enum cxl_event_log_type log_type;
        struct cxl_dev_state *cxlds;
-       unsigned int devfn;
+       unsigned int devfn = PCI_DEVFN(device_id->device_num, device_id->func_num);
+       struct pci_dev *pdev __free(pci_dev_put) = pci_get_domain_bus_and_slot(
+                                                       device_id->segment_num,
+                                                       device_id->bus_num, devfn);
        u32 hdr_flags;
 
-       devfn = PCI_DEVFN(device_id->device_num, device_id->func_num);
-       pdev = pci_get_domain_bus_and_slot(device_id->segment_num,
-                                          device_id->bus_num, devfn);
        if (!pdev)
                return;
 

Ira

