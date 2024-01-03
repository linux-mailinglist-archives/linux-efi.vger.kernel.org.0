Return-Path: <linux-efi+bounces-313-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C93F823777
	for <lists+linux-efi@lfdr.de>; Wed,  3 Jan 2024 23:08:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B245B1F25F23
	for <lists+linux-efi@lfdr.de>; Wed,  3 Jan 2024 22:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 729161DA36;
	Wed,  3 Jan 2024 22:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L2zQVESq"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3767F1DA2F;
	Wed,  3 Jan 2024 22:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704319699; x=1735855699;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=bWYKfW+W155izAfPOJLVTn3/PlPChrsQgZyYVzEfHoE=;
  b=L2zQVESqcUT+4y7Zy8JqMBZryOQRqiHLKHs1TROqCAu5DFh5GjU1B69Y
   Y+GejHe1AgNKwMMfQVumLp9itV1ZQJGUwxaufot/UtJq+v1F8Aa2+OnNJ
   L6XkIUm/0oCH3Zsyz2lWgYL2qCLNszpNgcBH666rPPp4DNg2+GeVFFwz1
   0trnMaYg5gRiqKLlSoVcuKBrvnx2K4+x4NFtG48lhmG6uPgilCisK6s5M
   meqXvP/L+tQUxp1YYhA82jbPkARgRmE/f0Rs7JO4L5jg/jd5FfgKQrcx5
   PpXq/IPogkuFt3+qhUG+JZxxe7sQNrfSHnVACmZ510yZ5q+zqIMbiBhMh
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10942"; a="4429286"
X-IronPort-AV: E=Sophos;i="6.04,328,1695711600"; 
   d="scan'208";a="4429286"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2024 14:08:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10942"; a="756356935"
X-IronPort-AV: E=Sophos;i="6.04,328,1695711600"; 
   d="scan'208";a="756356935"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Jan 2024 14:08:16 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 3 Jan 2024 14:08:16 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 3 Jan 2024 14:08:16 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 3 Jan 2024 14:08:16 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.40) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 3 Jan 2024 14:08:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W1KkxFwPAY/deGgW7agwWUhswZb5sRa2XWdFqzM0hDhyVCElzsar5AvTlxqhjFz+leWZbfZMZYLs+FQwk2VRqe+jnVV1iQkukvuVe/Vlkvoakt8A5AT4IG8DvXwi9mHsA6iufH6vvbScpjNmBbyGnyKx8EkmQiIgsg26a6zh+VAWbScW1w4/OyDjKjV8Ra1Z4dNW3lEDQj5WgkzL0qScQRpFA4YWgRM1gZGw3dkJaNiATfJRCtGGRE41mos630OSUip9VQn33wdngjIMCQlXPwidgTV9wzp1KTg1hQsgA60wpzNpWFxv66rOYA7VIQT4aZrt09BcEISP6oKm0cW8SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TojkqcjoY0kFugvfUGsw1UVFhgXrGOD/YKQc4OYyla8=;
 b=TeNd02OnMHTvVHBpB5VXt86LYjUuCdYmiBhoKCvIU68CKShH+hQKaNaGYn5YVg+QmFrfv528H1ztT+g/UlTSznxDnFY3wtxFGhqZOBP0u3IvH5ZuOJtUviIKQYobl+TuGWE2Y06az2ydd4k4OYtBS6PVO0I2Khf8QlcIq7+j8vL+J9c1VBjFuXP2yc+Q9xijBmulFK6PZSKae4KmUirplQNFIBtAaF/Dk5eEks92d7X3goTcxWDtEng6jVI/GNp9+DENKzjbskfmp0aGKgXLLRQCHjRssvRMor5QFBaZrZILpRrZ47bi2EpfJZ/8M/rhTVhmGQ+LD77ohicOaebPBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA1PR11MB6537.namprd11.prod.outlook.com (2603:10b6:208:3a3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13; Wed, 3 Jan
 2024 22:08:06 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2%4]) with mapi id 15.20.7159.013; Wed, 3 Jan 2024
 22:08:06 +0000
Date: Wed, 3 Jan 2024 14:08:02 -0800
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
Subject: RE: [PATCH v5 9/9] cxl/pci: Register for and process CPER events
Message-ID: <6595dac27b081_8dc68294e3@dwillia2-xfh.jf.intel.com.notmuch>
References: <20231220-cxl-cper-v5-0-1bb8a4ca2c7a@intel.com>
 <20231220-cxl-cper-v5-9-1bb8a4ca2c7a@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231220-cxl-cper-v5-9-1bb8a4ca2c7a@intel.com>
X-ClientProxiedBy: MW4PR04CA0202.namprd04.prod.outlook.com
 (2603:10b6:303:86::27) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA1PR11MB6537:EE_
X-MS-Office365-Filtering-Correlation-Id: 5655ab00-9680-4298-94f4-08dc0ca8764b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ykTipd6juVmoL3owpWnvs1n5mQDvVXlyTKR0TfGyB03uZdldUxrTkmrKRS7TzVXd9xb7mr2fNecxyIXcnmzkG4ucW8NN1HeJBbmWBmTYSTeFOXvlbQAnzYiwv9osGvB+tiagjWmXWxyPXDCz0ueOYmczdlu8/P9JIEB0Ggtu2A1DfQXjm7IG06aTtcxA/BEvvmHf3Uz1g9aCm8tgVxiXIuCG/vhhnu87zdEcAogLOBGdhIdbWkHbZa4tAXvsTc3avkE2UiQlFQYGkZxboUGtb8X8iwVB02tHlNFz7bBgOYsiA2r4lN0FV8Fm5j4P6MOfFlJpXiIu69pf6glCC96aRdzuYsvgh8gTXNPTL5v/sEcrghdOy0D3eUOSW4L4m+8KpMrT+pVGnTOBn34MCbN5V6FBJM/p/peo2cu+HiCLdC9TVaBInUSzakF1zNUCN2nYQCvJKWxQ8kuNu3wtpIa6q/xLqjEjbwFYPc/U3WoEEzSIu+RnU48F8MAfJY10TD59gXb+iDxVpsi4lcaiKDBlPBU/WP3H4dKmePHGhQj0Gzr7mJncQKzWIxM5EUTte2ij
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(366004)(39860400002)(396003)(346002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(5660300002)(8676002)(8936002)(54906003)(4326008)(83380400001)(6506007)(6512007)(110136005)(6666004)(26005)(478600001)(9686003)(86362001)(107886003)(316002)(6486002)(66476007)(66556008)(66946007)(41300700001)(38100700002)(82960400001)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rhdYlanWqMhfSZsbF/IRBRrL4sSfUiUTHHKRaDeEwfWp6VtILx7WedY4iWcF?=
 =?us-ascii?Q?/5gEkDnXG+GNZK+JXfSDI6dMiNcAWCA+yIuRS3zOYjpAhr/yjbur3MyQ0vdU?=
 =?us-ascii?Q?Fz0QowOoxmj2Wt4w8LSNCHeGJukZn16iqXAnJGPTBv2xWVxvWV2898zecdyv?=
 =?us-ascii?Q?bxGwUVJlcn25H4d8Lq7NhGnwFOB9YXNxi0F30K/UCtpI+KtHSSQ5o0g4sRun?=
 =?us-ascii?Q?WzuFdcyJHwkQt/IoQq7G1tAHBi7NE8HmakDcio4i/3vVzwDQozVrqsuET+wW?=
 =?us-ascii?Q?aeAMd5RqQ9QFkW09rqfrG7eh1828zX05HmwNjaS9PxKr+XPuXcJ8eYbYhx5Y?=
 =?us-ascii?Q?ukSsXtXy4J+MRtWMSBPnwFzr/F4Iiv8ABDAwLnkCPPe+C5SUVshEs7UCra4x?=
 =?us-ascii?Q?dEZF4e+2yj/VifmtiJhALFVYuj6e6wNqKQINLZMI80sciBWx97GOUrD5Cmsd?=
 =?us-ascii?Q?bPVixOuwfri+Evj08zqG5SC6KfkZi4LeqOdQ9aPxnWiRcaVUDnAcsXw6ClYw?=
 =?us-ascii?Q?d/AFkWjMEPxTiSeHf10AZbV6OK0HiC5T+Q8SSWHH3QXoI1PbciMGjGHoMqgC?=
 =?us-ascii?Q?QV2MeFl1w3OdbElazI8WEzxt8WZr+gmfvbzdX/9LDzQaX9nqu8tjQ97kHxtH?=
 =?us-ascii?Q?2hbxXsHz9woFXzr4zwe6rHhz9JCJ4fyX90i3jd4jeAAvbhxleyp+EU5cCeTv?=
 =?us-ascii?Q?V3ROxUfa/Hk9ZKh+e2GuYNsr4IeBv9Jua294BSKXSpEecjXc2QIEiXQQyma+?=
 =?us-ascii?Q?2keeGhmqXgr3VJ/Z5ADwB5YlBzh5AmOv7AVa4V5++/P3v2LSTJfftvbAFJf0?=
 =?us-ascii?Q?1VnKoytuhfzj6C29NqDHKQfzxyNGe/etbVUL8G65pfa+BdAjactnUZI8bmut?=
 =?us-ascii?Q?o9yEMOR6sHj7NserF1RkVsdczfptZB1K+n5okz07FeXujDcUNiDOjNIY8AA4?=
 =?us-ascii?Q?4LMiqJnAtEeg96fnJk5RlQWgkCddY5i3FOhk6LxS27wOvxcRmryFG0FmSdEi?=
 =?us-ascii?Q?5W5s/HTyuHXco0U1NN4xDG0M5Nr2xWir+rpVkoJUBDWR30ubGLCGjv2N7q5k?=
 =?us-ascii?Q?6HUHvWyOa+6qpdsvF4QGJpzzEJIXJu23NgfypRDN5dNhYalDtJ5kbOwf1bY4?=
 =?us-ascii?Q?qevoamcmIUxt4875tjxUsDW3qK1H3MBLtHeE01+DJNxkHTPf2JIcp+x8tgPf?=
 =?us-ascii?Q?Wc08Arp+sQ6HNb8/eWXULjBFKCfOh/ktNOjhvZelrSD79YkaGtkUSGmMjr/l?=
 =?us-ascii?Q?hQouoAfLTJbPqgrkxHsSLhO/7dqaFp7nU0yJSRhhlGfvA9mZ/unxCoqpxHsE?=
 =?us-ascii?Q?yZtIjHMsKuJmae14iOmW1ImdoIhx7BE28RqVgB3qbwvkAqvDYZRuywNq7ihl?=
 =?us-ascii?Q?JJwDDcOCaM6+Dpf+Xq5C1S3RmLaHTBOSDnilh81yIg6afUfy7YfM9Gw55Ia3?=
 =?us-ascii?Q?rZDQpRD5Gacvzbgr4O4sA/PWc6w6nDo49a9q0ZL3jByDUkfG4Y8+DAxKHaFx?=
 =?us-ascii?Q?dGOoWcS/qedbQ8hYytm8rht1AaACs3QN4Dzr9MMs1EbVtHLncMRsjXZMEGUp?=
 =?us-ascii?Q?MusbrsYva0PRBzpR/rELaR/DUQm6Rw5MT9V7bhklMr/zZ1W/vQRGORiwIOV6?=
 =?us-ascii?Q?CA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5655ab00-9680-4298-94f4-08dc0ca8764b
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2024 22:08:05.9976
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EsOeR3ik4ZLy7wfO1327RevMbEKu1DxO/UcBdDkllAuf69gMVSaVfJXwASpmY4YwiJnKDQsvY4dk+WYhjwU4HkmYxz3mjHt7PjTvyNY9NAQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6537
X-OriginatorOrg: intel.com

Ira Weiny wrote:
> If the firmware has configured CXL event support to be firmware first
> the OS can process those events through CPER records.  The CXL layer has
> unique DPA to HPA knowledge and standard event trace parsing in place.
> 
> CPER records contain Bus, Device, Function information which can be used
> to identify the PCI device which is sending the event.
> 
> Change the PCI driver registration to include registration of a CXL
> CPER callback to process events through the trace subsystem.
> 
> Use new scoped based management to simplify the handling of the PCI
> device object.
> 
> NOTE this patch depends on Dan's addition of a device guard[1].

Now that you added guard(pci_dev) earlier in the series you can just use
that here rather than guard(device).

[..]
> +#define CXL_EVENT_HDR_FLAGS_REC_SEVERITY GENMASK(1, 0)
> +static void cxl_cper_event_call(enum cxl_event_type ev_type,
> +				struct cxl_cper_event_rec *rec)
> +{
> +	struct cper_cxl_event_devid *device_id = &rec->hdr.device_id;
> +	struct pci_dev *pdev __free(pci_dev_put) = NULL;
> +	enum cxl_event_log_type log_type;
> +	struct cxl_dev_state *cxlds;
> +	unsigned int devfn;
> +	u32 hdr_flags;
> +
> +	devfn = PCI_DEVFN(device_id->device_num, device_id->func_num);
> +	pdev = pci_get_domain_bus_and_slot(device_id->segment_num,
> +					   device_id->bus_num, devfn);
> +	if (!pdev)
> +		return;
> +
> +	guard(device)(&pdev->dev);

Per above:
	guard(pci_dev)(pdev);

> +	if (pdev->driver != &cxl_pci_driver)
> +		return;
> +
> +	cxlds = pci_get_drvdata(pdev);
> +	if (!cxlds)
> +		return;
> +
> +	/* Fabricate a log type */
> +	hdr_flags = get_unaligned_le24(rec->event.generic.hdr.flags);
> +	log_type = FIELD_GET(CXL_EVENT_HDR_FLAGS_REC_SEVERITY, hdr_flags);
> +
> +	cxl_event_trace_record(cxlds->cxlmd, log_type, ev_type,
> +			       &uuid_null, &rec->event);
> +}
> +
> +static int __init cxl_pci_driver_init(void)
> +{
> +	int rc;
> +
> +	rc = pci_register_driver(&cxl_pci_driver);
> +	if (rc)
> +		return rc;
> +
> +	rc = cxl_cper_register_callback(cxl_cper_event_call);
> +	if (rc)
> +		pci_unregister_driver(&cxl_pci_driver);

I think this order should be flipped. That way any errors that might
arrive due to activity caused by probing have a chance to be serviced.
Any that fire while initial probing is happening will pause in
cxl_cper_event_call() and wait for probing to complete. Of course if
probing fails, all is lost, but I think there is some incremental
benefit to trying to catch those early records for things that are not
probing fatal.

