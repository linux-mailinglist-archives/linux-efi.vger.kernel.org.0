Return-Path: <linux-efi+bounces-156-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28F0880AEEF
	for <lists+linux-efi@lfdr.de>; Fri,  8 Dec 2023 22:46:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD88028174D
	for <lists+linux-efi@lfdr.de>; Fri,  8 Dec 2023 21:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C0495788B;
	Fri,  8 Dec 2023 21:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HOc9vBV+"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35DB310E0;
	Fri,  8 Dec 2023 13:46:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702071977; x=1733607977;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Z2Hev7P52x1UEvNyxh05/7Ky4bObeQzMxekYa0KK8MQ=;
  b=HOc9vBV+7zpCJ5AaAyUiD3SXYb/ohgclpBZa7z/nPPeQWtMO62dHo01B
   Pp+nWg1Vu4jIOTzeBuEUNt5xJOxUfKkLEHIU/PYFzwjaERCWF5mBNNjhR
   cbud+yFhDxYSsp/cnad+5i3W701tDFVUL0KpLyNY3Q9fqB4P+kS2hCFLQ
   bqRmtVQYOK+631zeT1U4HK/tm47nYhpCYSOPznooIkYaEHV5ocRv565/3
   He7aputGGkVpkVwPDVpKbFtuxnc6EcIIcWOHrntz0tIp7QkyiD7u2yAfY
   6bCwclLdlQwbrv9oo1cx7Ehzi42UZKTizLH5W3wSyZS4WjLk4Vbgq5SCd
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10918"; a="458784938"
X-IronPort-AV: E=Sophos;i="6.04,261,1695711600"; 
   d="scan'208";a="458784938"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2023 13:46:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10918"; a="890284329"
X-IronPort-AV: E=Sophos;i="6.04,261,1695711600"; 
   d="scan'208";a="890284329"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Dec 2023 13:46:15 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 8 Dec 2023 13:46:14 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 8 Dec 2023 13:46:14 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 8 Dec 2023 13:46:14 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 8 Dec 2023 13:46:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FLmxfMQvd1//7WjbdmEyba2UD8gWflZWMO984ExXoKLNQHa1kSNvrHSbsUP5awmTVj2O7mXNsNW65Pmju6MrXWe9Z49S6YBhhu4gubDAhvl0DrhU/ohsx3IXd21Mwm4hG1DoJDOsvCbMqvNFt11KsJ1zFx6y6tnjwUe9GP6yY3L4epGRxmwTbaWFEfmtNOt0mIh9xg3bo4IArKD9Xoxn5LDjLZG9ZMCbvgCHz22RE04unESuZWEn3+dVy3otPBfXl2wDppbKOF6NQK68/JS6z654NepZ+nSJ71Zf+KJETRvV+gB+BMR1zZFCdUwYAlzuGXKiGZ7hsf5H+l8JxZnAGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gwf1xJY0QcfNHArphUfRkEEQWt0XHK6/Cf9rNCw7s+g=;
 b=CtNFo8FclIbblYoOKXLpa+4K2nJeJGTgQN8jc2V7qBdXy0zB4hjXYyibFze2NH1ggOU2aJ+bgdAtDio8kvFeykWv0IyOIY5eF5UMWceiJ3S2Sx4zQA09bAqISnCUYghi85JXmXov13PVjeCMtsRLMsfZffh3ihGAHtWRgMp9uYc945yUsf6+2OKF9NUK/3vYMAzfs338qJUJjp0mYtrDZFapKZzrn/4GrKl29FS65xJTnhxJPlcBhtILldnRWUcITkO+D0QalGCWesWEpTqYYi1KhILgcOtlUI2poUpcU2NLnkRMSbI0XjcnIGWsaECNd+QzM5tIkKbR4c9RINa0BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CO1PR11MB5137.namprd11.prod.outlook.com (2603:10b6:303:92::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.28; Fri, 8 Dec
 2023 21:46:11 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6362:763e:f84b:4169]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6362:763e:f84b:4169%5]) with mapi id 15.20.7068.028; Fri, 8 Dec 2023
 21:46:11 +0000
Date: Fri, 8 Dec 2023 13:46:07 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Ira Weiny <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>, Smita Koralahalli
	<Smita.KoralahalliChannabasappa@amd.com>, Shiju Jose <shiju.jose@huawei.com>
CC: Yazen Ghannam <yazen.ghannam@amd.com>, Davidlohr Bueso
	<dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Ard
 Biesheuvel" <ardb@kernel.org>, <linux-efi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>, Ira Weiny
	<ira.weiny@intel.com>
Subject: Re: [PATCH 6/6] cxl/memdev: Register for and process CPER events
Message-ID: <65738e9fc239a_45e0129476@dwillia2-xfh.jf.intel.com.notmuch>
References: <20230601-cxl-cper-v1-0-d19f1ac18ab6@intel.com>
 <20230601-cxl-cper-v1-6-d19f1ac18ab6@intel.com>
 <657279a68c270_b991294e@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <657371eec6ac5_1e7d272948d@iweiny-mobl.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <657371eec6ac5_1e7d272948d@iweiny-mobl.notmuch>
X-ClientProxiedBy: MW4PR03CA0312.namprd03.prod.outlook.com
 (2603:10b6:303:dd::17) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CO1PR11MB5137:EE_
X-MS-Office365-Filtering-Correlation-Id: d18c3356-81e9-4110-5143-08dbf83717b4
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1j2/OK2S0Ksu+LZV7mTbNN7Cel2y+PwtBhfb/K5NqlqQhG4o7RWxEsSmquJJ+OaBkyYxbGqlsLhfc5S1fE/u7JW4fEvxB7HN4cda2DVbmo4bNxYrTuWjPQDy2Yqi3FVdx16mwrzAEZh3nr+nNrJBhzsYqA51FDEArbOVVAKyd/P2mnFxBY8PdQn+NNmR+Xsk7lUcF3XcshwKGHjxjyuE5pYHNa0W6hmI55g1Zi2otzf+qO6xBZDLTHPt5vJNj9y9lCXTKWgb67uA+F1P0/0BSAzzaBMCY2SRUHq3FsWmXlHu6t9w360PgoBabJOaV0LbNpn2P33uWfMqKjzKADfrv3DVW/p2u4o1rZqg4WhtLpDXZKUXH3MIlA+VBzu/AdWVHvaP9ImUxhU7FkQUuW+GBYOS+sQ9o/8lrq7BRp9DkOfKuZ1QWYP+TcHjSNVmLGQhucEQS3ta3JcKe6cs5tIctUKWfZbMtwrqDamD3t99G21fAfweNqtbl89dphTQUkN92SFjRVNESe3/Upsb2tJFijF8n8aMmSI9iDIPvaXyccrS6+2GiX9ZDZDZMkoXqCvL
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(396003)(346002)(136003)(39860400002)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(6666004)(6506007)(6486002)(478600001)(5660300002)(2906002)(110136005)(66946007)(66556008)(66476007)(316002)(54906003)(4326008)(8676002)(8936002)(83380400001)(82960400001)(38100700002)(107886003)(41300700001)(6512007)(9686003)(26005)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Cy8AARwO3TS95PjU1GpqLbTEcJs711yK+DsAbYrkGnaVCjb85zFKnaj7QnF0?=
 =?us-ascii?Q?6/bOnkeMX+2tlUcXqyRDyRPhiPOvW4nJjSEDnAWjFpX5QkryQ18SWDNmFK1N?=
 =?us-ascii?Q?oMHbbZQItx5H/Pwt1AobqNk4kyummoDsuISh3jEdk+VzgO5QenmTAMtxOzH6?=
 =?us-ascii?Q?waEP0SLuEX6uVphRD3zCjCdC3qb/cjXftjKjTo4lDBlQihP0zPmWrwwhP6mO?=
 =?us-ascii?Q?8mRN1azId+MrY6fP6gGwVPTDfBu3UWwxFbCqJuWTVyTy/F3ZbgAB72okPiPP?=
 =?us-ascii?Q?8jQq/QJHk7RjDr76GjkQ2p9jNof7lpy31uCNVq8PsxRWgRa1cmGzfuNIJXlW?=
 =?us-ascii?Q?s5HFLRV+ElaoGwuRFJ1BFMTwTI9EvICu6ujDBESTE1OWUxkabjgTLLXpWBMy?=
 =?us-ascii?Q?byviteXafVtbUSwY73ASjAbfoq0fMapW78/nXH8e5XbDJJNfj+m5wjQRDWOc?=
 =?us-ascii?Q?l+BXpShaTKyRqORqrtgyKT1t8Doto+u0ybFa8+/pTwghau1276dqVKxpMWa3?=
 =?us-ascii?Q?ztuJvHNIljfASbScjHhAnQCfdqL0Lsh0L+t3l610FVh/jm3armZ/G7NMc1xe?=
 =?us-ascii?Q?osJ6E9Nl98UseSOxQrLZX97/p55cpt9MQABirGkZ29KqvE7/VPV1Z9e+rh9/?=
 =?us-ascii?Q?htwjDdRyDrYZsyGrWjiwXVVJWrYuX8orm7iFZJZaoQc5tGVqtNQfrlkCi6Lt?=
 =?us-ascii?Q?Ujb5rdqHyyNVCzK/om5MokkO/LArv3SVrMgHzLneBinrzQ/mPHgnu7nCfEGM?=
 =?us-ascii?Q?sUa+oxrWfbitxVcu3OB/v8+nMKiddFPvdo6XuSAF0E7LIICiYq+hXezza4gm?=
 =?us-ascii?Q?/gEYzIqqqK5VE1KWnk2uUQ+OxgWFMBLbN+AC2m4ZbYrdl7LZm8Ivj5HWviXc?=
 =?us-ascii?Q?61H0DEoQJ2NGa04qmQ5fIQT1cuhNCyNuc+ddwivIDbNPblSaf0SNYLj9AKRU?=
 =?us-ascii?Q?d4InuNEpBctolCqyIvgsO6ymLh1Nmy65W8Q1sJs06fnSV7gqffKEnkgCRquH?=
 =?us-ascii?Q?Bkux+9uoKLgQhOgm44nXlWPBIMyNokZARzxApiImWirzy90acwaK8M33h6GB?=
 =?us-ascii?Q?RBoHvsoYUaNYlLxjHtw9nF8HbvOqHMLUrxu7lFUcH2Z0EzWs7oLc21pVkri4?=
 =?us-ascii?Q?ttwrt7ACkVFNZwKMMhkjkceLUIJ0HpQk6P/xSjytv9CleORNyoew1wNlJI3V?=
 =?us-ascii?Q?56Iqut55GXMb4rO+K4zIo+PyNTmZBY7YmtO5wlvlruvXjlcN9a/BpU6FQpNM?=
 =?us-ascii?Q?Cy0pq9azxzuQr4TGI0BT9yYQzCkPH4NHeVFf+dglazSJv0Y3eplJaztC1SIa?=
 =?us-ascii?Q?uDBfG2WefZ2db0F7cbqcxTU23tt74TBUeeyIeCVp/50lnhgoFF/j/Ef1MaEk?=
 =?us-ascii?Q?MshgRxuboQqGyyGBIi/aVq/Y0UUypmszAq4KXBGkzQ4BlvlaHl7D4G7VrUy6?=
 =?us-ascii?Q?x0wC9+hTp7XWlySaWcnQP55H+ROF8t8AzYW/wHCCiSDDDUf2nbFoNBGccvJl?=
 =?us-ascii?Q?O8iF/gn3CRvQ8N3HYCYxvTh9s+kiAngQFY8ykhlpMMWyLJJTZaezeHXxj3/s?=
 =?us-ascii?Q?U8Ui6PHFw4AmYdXpRocV/7Yb5HCV99CyVeW93lIHS1hg/XeBD4X7Zsfedv5C?=
 =?us-ascii?Q?vw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d18c3356-81e9-4110-5143-08dbf83717b4
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2023 21:46:11.3352
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6Z6UR6UKz19iqxgIy01hbf5ljBmee8iPwjq8xcmAcuV6Oo/wAlkHV/RN1alIzn1Na2dHte8u2iQ2EC3ZR9hJCORetU9agDjyORfJOAAOoLQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5137
X-OriginatorOrg: intel.com

Ira Weiny wrote:
> Dan Williams wrote:
> > Ira Weiny wrote:
> 
> [snip]
> 
> > >  
> > > +#define CXL_EVENT_HDR_FLAGS_REC_SEVERITY GENMASK(1, 0)
> > > +static int cxl_cper_event_call(struct notifier_block *nb, unsigned long action,
> > > +			       void *data)
> > > +{
> > > +	struct cxl_cper_notifier_data *nd = data;
> > > +	struct cper_cxl_event_devid *device_id = &nd->rec->hdr.device_id;
> > > +	enum cxl_event_log_type log_type;
> > > +	struct cxl_memdev_state *mds;
> > > +	struct cxl_dev_state *cxlds;
> > > +	struct pci_dev *pdev;
> > > +	unsigned int devfn;
> > > +	u32 hdr_flags;
> > > +
> > > +	mds = container_of(nb, struct cxl_memdev_state, cxl_cper_nb);
> > > +
> > > +	devfn = PCI_DEVFN(device_id->device_num, device_id->func_num);
> > > +	pdev = pci_get_domain_bus_and_slot(device_id->segment_num,
> > > +					   device_id->bus_num, devfn);
> > > +	cxlds = pci_get_drvdata(pdev);
> > > +	if (cxlds != &mds->cxlds) {
> > 
> > Checks of drvdata are only valid under the device lock, or with the
> > assumption that this callback will never be called while pci_get_drvdata
> > would return NULL.
> 
> For the device we have registered pci_get_drvdata() will be always be valid.
> Each driver is registering it's own call with valid driver state in the chain.
> 
> However, I see I have a bug here.  Using devm_add_action_or_reset() breaks
> this assumption.
> 
> > 
> > With that, the check of cxlds looks like another artifact of using a
> > blocking notifier chain for this callback.
> 
> It is a desired artifact.  This check is determining if this event is for this
> device.  It is not checking if cxlds is valid.
> 
> > With an explicit single
> > callback it simply becomes safe to assume that it is being called back
> > before unregister_cxl_cper() has run. I.e. it is impossible to even
> > write this check in that case.
> 
> Exploring the use of a single register call...  you must check if the cxlds is
> valid on that pdev.  Because the driver may not be attached.
> 
> Something like this in cxl_core vs cxl_pci:

I replied with sample implementation on the other thread, but some
comments here:


> #define CXL_EVENT_HDR_FLAGS_REC_SEVERITY GENMASK(1, 0)
> static void cxl_cper_event_call(struct cxl_cper_notifier_data *nd)

Is struct cxl_cper_notifier_data needed anymore, just pass the record
reference?


> {       
>         struct cper_cxl_event_devid *device_id = &nd->rec->hdr.device_id;
>         enum cxl_event_log_type log_type;
>         struct cxl_dev_state *cxlds;
>         struct pci_dev *pdev;
>         unsigned int devfn;
>         u32 hdr_flags;
> 
>         devfn = PCI_DEVFN(device_id->device_num, device_id->func_num);
>         pdev = pci_get_domain_bus_and_slot(device_id->segment_num,
>                                            device_id->bus_num, devfn);
>         device_lock(&pdev->dev);
>         cxlds = pci_get_drvdata(pdev);

You would need to first validate that it is indeed a pci device that
cxl_pci is driving before making this assumption. That's what the
cxl_pci_driver check is doing in the other reply.

>         if (!cxlds)
>                 goto out;
>         
>         /* Fabricate a log type */
>         hdr_flags = get_unaligned_le24(nd->rec->event.generic.hdr.flags);
>         log_type = FIELD_GET(CXL_EVENT_HDR_FLAGS_REC_SEVERITY, hdr_flags);
>         
>         cxl_event_trace_record(cxlds->cxlmd, log_type, nd->event_type,
>                                &nd->rec->event);
> out:    
>         device_unlock(&pdev->dev);
>         pci_dev_put(pdev);
> }
> 
> This does simplify registering.
> 
> Is this what you were thinking?

Just not in the core since the core has no idea how to do the "is this
one of *my* CXL pci_dev instances" check.

> > > +
> > > +static void register_cper_events(struct cxl_memdev_state *mds)
> > > +{
> > > +	mds->cxl_cper_nb.notifier_call = cxl_cper_event_call;
> > > +
> > > +	if (register_cxl_cper_notifier(&mds->cxl_cper_nb)) {
> > > +		dev_err(mds->cxlds.dev, "CPER registration failed\n");
> > > +		return;
> > > +	}
> > > +
> > > +	devm_add_action_or_reset(mds->cxlds.dev, cxl_unregister_cper_events, mds);
> > 
> > Longer term I am not sure cxl_pci should be doing this registration
> > directly to the CPER code vs some indirection in the core that the
> > generic type-3 and the type-2 cases can register for processing. That
> > can definitely wait until a Type-2 CXL.mem device driver arrives and
> > wants to get notified of CXL CPER events.
> > 
> 
> Yes these calls will need to be moved to the core for drivers to share
> later.  Same for mailbox event handling.

That would come with some pdev to memdev lookup facility to replace the
pci_dev->driver check.

