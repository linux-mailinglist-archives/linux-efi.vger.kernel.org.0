Return-Path: <linux-efi+bounces-138-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03A508098F9
	for <lists+linux-efi@lfdr.de>; Fri,  8 Dec 2023 03:04:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46C301C20C55
	for <lists+linux-efi@lfdr.de>; Fri,  8 Dec 2023 02:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68C851854;
	Fri,  8 Dec 2023 02:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hMy2Pzi3"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 870FF10EB;
	Thu,  7 Dec 2023 18:04:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702001070; x=1733537070;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ldJYDmeUhNms4G0/nEBL/SWIfvFzx1pRE64iRj4xcPk=;
  b=hMy2Pzi35F0RAElvXy2omawBoQwNtehaV8Y2UD/zc2kuurAye7ssf6kF
   VKdCp0mFXm1tkGv1s8s3V54pUFTamPvstjIdjOUtX0pI9G3W4g0UlbBj/
   DatisIJ6VJcPiFkd6YwhkwSQy5qAjSCtyekB/WlkV6Yl5ZJmSKPuHbmTB
   RjOo17obvezzHrtZUO8V0Ej1gQGoT439N85DXreiIVKzmHePHIW5rvyok
   F1RiX7R5zAIREaGJ25YWOHPN37ebmcAz120cEixMYmknbqlAG9yweXwA1
   C+dpMOWID2AseAsAXOSE8DbuI4SN/yurASdqYp4BphODnBKFdr1wLBfW4
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="384745146"
X-IronPort-AV: E=Sophos;i="6.04,259,1695711600"; 
   d="scan'208";a="384745146"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 18:04:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="721710239"
X-IronPort-AV: E=Sophos;i="6.04,259,1695711600"; 
   d="scan'208";a="721710239"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Dec 2023 18:04:29 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 7 Dec 2023 18:04:29 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 7 Dec 2023 18:04:29 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 7 Dec 2023 18:04:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nqvPOV63RIT7+flEpbnNsmg3p2zk87BW7pBZFtHSCWsJlxy29zHcLbsbbiKuY4kqW7wwxitbxpX7sYCTL3i4dbgySJWn+lVlli02EgwQJaAQ2zRWnseRrTcHTprXHKVKok/EJw3P4ymuu652Ux1oClONA2JRQtFXPoWisdgbqnxrlsHwLR7WfS8WXEJS6o0AyQfL+3/FHYLtYVMtJOBg2PpQ6IpdlIXPIpjts/bysvVED/pPTCl+jjih9PX784vsUXPVjsLUZYs1ruFkkStAOTSxoye3HILf13ESY7/FgpPM7RvvS1ndoXmmSx03xDIGzWzYBIi01ZzV7WrcGObBHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kCaHdXr2omLH8ND31cCFx5PcNsfeAFlDWRIXjcpuZfk=;
 b=W1xamm/lLRXli8vxpqNGGIvxYjwyMcaB11p28qwlLtHXwkZwLWRoeoFI7JC8zDzQL+GcGvXdERUW6+wJYaCv9GU3jJ28sh2ZTCwdyZq0oe1t2VibOwRV7sxBb7C2vegfwdE+nj6vK0laeFgXJSkUCSiEZi4n44x+cdNDhPjaXox/o6N31llFR9NAcqs4iIAcX+tRq0qgYvg77qfreZ35U2wAyBSvAXZSQ6pWgbar2LqNziG28LcNwBta5MDmhBPKnvGFqyOKzTtI95zQ2WpTTU0rSXlEcx3U4WSmPVbVULpeAsDZ5Sf2Mo17u8uBO9AAtWIgJPy6K+hYzV8hy+TkNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH8PR11MB6976.namprd11.prod.outlook.com (2603:10b6:510:223::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.27; Fri, 8 Dec
 2023 02:04:26 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6362:763e:f84b:4169]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6362:763e:f84b:4169%5]) with mapi id 15.20.7068.025; Fri, 8 Dec 2023
 02:04:25 +0000
Date: Thu, 7 Dec 2023 18:04:22 -0800
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
Message-ID: <657279a68c270_b991294e@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20230601-cxl-cper-v1-0-d19f1ac18ab6@intel.com>
 <20230601-cxl-cper-v1-6-d19f1ac18ab6@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230601-cxl-cper-v1-6-d19f1ac18ab6@intel.com>
X-ClientProxiedBy: MW4PR04CA0107.namprd04.prod.outlook.com
 (2603:10b6:303:83::22) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH8PR11MB6976:EE_
X-MS-Office365-Filtering-Correlation-Id: 635f40d9-c36f-4c8c-1eaf-08dbf79200cf
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z+XYREg6jLxZAh1ana9+rR8zc3y/G7E9pJt6FIuQz0P9u9FKxO81xMPmd7e9HBzmcd8cmEjx1Qi91rQzLbOI6yt8cpLgENwLho51gO/D/MLpbV1014FiYPXCaXuAPzAqMgGrV/QCWUeWMo1hn8bx5v29bzV0KF12xsgcomUPgo3RowHYA4+UzQGN6FmURPnPxEERRmdccKuG0YWXe5/o/+SjjCo36wBnt4oB+pt7UQMIGcge3LJbTvrz2aHmTV6qc7U4uDavJy5ik6OFZhLCWvhLfjL1ttcDfnesSvx0GxCRMLEkULq7mq7jEICDZv+jFpfn5nqG97slp7woGY1PxiKL8OOrNmZS9jxKhlHvYnBzxXqZdgLztAuNfj+j39/mk/c56f/+lJR6gCPT9g4a33BB9oozZ9G0vBBAdbxpWXti+daUUizZEMi4165FdHOV2m1rybCe6Slbf3st3V/eGleMfPZb5Umwk5H/x72Nl5V5OMxewI7xAO9FzL7f7Nd1aaVmTQCIUFcLdMGctWUEHfww3zYsBcgFJXY0ckmhy03pCPuAA+U2to8iIbGWf5d3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(396003)(346002)(376002)(136003)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(82960400001)(6512007)(9686003)(83380400001)(6486002)(478600001)(6506007)(6666004)(107886003)(26005)(8936002)(66556008)(66476007)(54906003)(8676002)(316002)(66946007)(110136005)(4326008)(38100700002)(86362001)(41300700001)(5660300002)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KCpxVnhqkiEtvDile6QqKkfONeVlpwijAvnGtfbGicDR1VaSsFCCLYZJCjCd?=
 =?us-ascii?Q?7monWtP6y+52acMAc3gumk/x2/wQiF+nJscKPVS+8SP6CWIUDA/UmN09aXgp?=
 =?us-ascii?Q?EC8XggewKrL/dgDa6+Uc95rM6Q/Reyn4a+cZWG77kl7QOUjSA/YLYlMlEz88?=
 =?us-ascii?Q?jkTdfC7SsdsSRw5t3/dEoku3c6XHZ9IfZACFSSVv6Ld05Il/5yuW0HQfeO4+?=
 =?us-ascii?Q?E39NiPevJAjC3vXiD2lgTfmcbsVCTPK9dM2Bsu8FP15mZbFHGaCiZwCrv3hB?=
 =?us-ascii?Q?NCwElAcD3U4b60xk++FSOGyxGSKrmBRKjabyDACZE7ZXVG8wzhBIOHz4qM/3?=
 =?us-ascii?Q?aO4HYEhUXh3t8v5JtcSI2kKq2WXsil+Q9Ih9GUit1X1X+F5UhBFaNocNSIpG?=
 =?us-ascii?Q?cPQCxCdmiWZiISnSNRNgPeIjBMSlm/srYPdP3SnZJWgEZGgVB7JpyLFQqfzE?=
 =?us-ascii?Q?GoNgMPItKne7kswvUSsiQIB+ZRWfO6eHwtdQ70F118WHM3jtvueTLyE2Mv5L?=
 =?us-ascii?Q?4pYW1wIqVFeRbpMvz/EFxq+PPltWggdUWb0hHQSMLTtJkhTfXXeFB/CFW5J3?=
 =?us-ascii?Q?bOJARZK0OxqXuylKq8c6fcl1ZkKrX8ZltWt2ULk/Yjg66XOdUz74JrPVQjXg?=
 =?us-ascii?Q?7OTh1n9ClHlxEA1OB0xzBAI08YtZ4lfPCu74jIE6Jpr9hUfi4lAqs8vbjzex?=
 =?us-ascii?Q?df85dIY9FaCL+9hsyXKpM51VCpUCbLBJcpGj9dPxkpYWxfOof7XxCnH6XA0+?=
 =?us-ascii?Q?xuEnTjoGbCtk0I3HUnnZwhIFFwg97PptQbYLEgFK8Drm0hMu7MAb4gifr3WB?=
 =?us-ascii?Q?thh33L8JojBPsS5tr9gX9S+z0HFKC2w+Duy1Qax2tMIlUz6u+PMaP561RSWz?=
 =?us-ascii?Q?kLSLS0q0i9FYi9ijJfKgPwhSiDZFVK/jcU/5rw2JD9QEKrdYSBc7gRlFOsti?=
 =?us-ascii?Q?bbzJO3xsSF1R4QxWQB4lT2CM6bzJoTlmsv3F+jeAhPZnr2xqL8vSfjwCSuxl?=
 =?us-ascii?Q?tpvrIyUeKNcAuIHYo+JppHtc33ZTzOjv3r6fbhcXCoLL3j67e+pajeaaVCP/?=
 =?us-ascii?Q?HSHaItLFj6N06iWQ4METUx4OPfhpTUgi0Ay9Ez0LXrMPKUzvvQfn3rZprkcx?=
 =?us-ascii?Q?cFNI1Y8/y1vY9MaT2ehJQVP6lKj6QIJPgkL+3HnDwmLFt+ZNo3GsdUJSX6Gf?=
 =?us-ascii?Q?FQwWwjAe1jA4huXOyd2n0eh2c1wQayrrZIKFlQQirIKKLaiLtX2G7rUvQKI0?=
 =?us-ascii?Q?7voukPPCMpMLrwhnWgr9F0JaOMkRsD6DqhJaeRXhIYDSF5mCaE6Na9WAnnlj?=
 =?us-ascii?Q?wcpEUGtcmrBbhYrWb5tm3JAdqZ7IJ9P0+gIvGdg4o8rf6XISvf2vvWaYVJuD?=
 =?us-ascii?Q?1sLKupOT2T/ZspIMRGSF1aK6EyXMTYA3C9AWQMbJH08hAfNSX6mbziSANpii?=
 =?us-ascii?Q?9+ItDM28067r0Q+DmqFYsUf8SvCSlxHmW5DxtiH2y6jW9ZeykbkDDUeCTqfR?=
 =?us-ascii?Q?K81yjsjpk2gnzk2D2lQhXCERqg3zIJOfTI/W3trJKDN6DJPO8T5Tgia+1QGF?=
 =?us-ascii?Q?UMMiZBASGBC0Y3E5eEFw30jPEB9zj5wXsy7oTC2/sE0nuawukSWAWxqn6s0Z?=
 =?us-ascii?Q?mg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 635f40d9-c36f-4c8c-1eaf-08dbf79200cf
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2023 02:04:25.5827
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cruw8udhok99kHWwg9NC2np02kan5UmYnuDOdzdvcazFkcnjzoOUX55swvDugkzS8V2zlbfLWGkpX/fhKFI/WnDqxbQK/HpSOxHiVsXOEow=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6976
X-OriginatorOrg: intel.com

Ira Weiny wrote:
> If the firmware has configured CXL event support to be firmware first
> the OS can process those events through CPER records.  The CXL layer has
> unique DPA to HPA knowledge and standard event trace parsing in place.
> Matching memory devices to the CPER records can be done via Bus, Device,
> Function which is part of the CPER record header.
> 
> Detect firmware first, register a notifier callback for each memdev, and
> trace events when they match the proper device.
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> ---
>  drivers/cxl/core/mbox.c | 31 +++++++++++++++++++++-----
>  drivers/cxl/cxlmem.h    |  6 +++++
>  drivers/cxl/pci.c       | 58 ++++++++++++++++++++++++++++++++++++++++++++++++-
>  3 files changed, 89 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 5ccc3843b736..8a0d4f67540d 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -860,9 +860,30 @@ static const uuid_t mem_mod_event_uuid =
>  	UUID_INIT(0xfe927475, 0xdd59, 0x4339,
>  		  0xa5, 0x86, 0x79, 0xba, 0xb1, 0x13, 0xb7, 0x74);
>  
> -static void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
> -				   enum cxl_event_log_type type,
> -				   struct cxl_event_record_raw *record)
> +void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
> +			    enum cxl_event_log_type type,
> +			    enum cxl_event_type event_type,
> +			    union cxl_event *event)
> +{
> +	switch (event_type) {
> +	case CXL_CPER_EVENT_GEN_MEDIA:
> +		trace_cxl_general_media(cxlmd, type, &gen_media_event_uuid,
> +					&event->gen_media);
> +		break;
> +	case CXL_CPER_EVENT_DRAM:
> +		trace_cxl_dram(cxlmd, type, &dram_event_uuid, &event->dram);
> +		break;
> +	case CXL_CPER_EVENT_MEM_MODULE:
> +		trace_cxl_memory_module(cxlmd, type, &mem_mod_event_uuid,
> +					&event->mem_module);
> +		break;
> +	}
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_event_trace_record, CXL);
> +
> +static void __cxl_event_trace_record(const struct cxl_memdev *cxlmd,
> +				     enum cxl_event_log_type type,
> +				     struct cxl_event_record_raw *record)
>  {
>  	union cxl_event *evt = &record->event;
>  	uuid_t *id = &record->id;
> @@ -985,8 +1006,8 @@ static void cxl_mem_get_records_log(struct cxl_memdev_state *mds,
>  			break;
>  
>  		for (i = 0; i < nr_rec; i++)
> -			cxl_event_trace_record(cxlmd, type,
> -					       &payload->records[i]);
> +			__cxl_event_trace_record(cxlmd, type,
> +						 &payload->records[i]);
>  
>  		if (payload->flags & CXL_GET_EVENT_FLAG_OVERFLOW)
>  			trace_cxl_overflow(cxlmd, type, payload);
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index f0e7ebb84f02..9cb0e3448780 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -481,6 +481,8 @@ struct cxl_memdev_state {
>  	struct cxl_security_state security;
>  	struct cxl_fw_state fw;
>  
> +	struct notifier_block cxl_cper_nb;
> +
>  	struct rcuwait mbox_wait;
>  	int (*mbox_send)(struct cxl_memdev_state *mds,
>  			 struct cxl_mbox_cmd *cmd);
> @@ -778,6 +780,10 @@ void set_exclusive_cxl_commands(struct cxl_memdev_state *mds,
>  void clear_exclusive_cxl_commands(struct cxl_memdev_state *mds,
>  				  unsigned long *cmds);
>  void cxl_mem_get_event_records(struct cxl_memdev_state *mds, u32 status);
> +void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
> +			    enum cxl_event_log_type type,
> +			    enum cxl_event_type event_type,
> +			    union cxl_event *event);
>  int cxl_set_timestamp(struct cxl_memdev_state *mds);
>  int cxl_poison_state_init(struct cxl_memdev_state *mds);
>  int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 0155fb66b580..ec65c11baf17 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -1,5 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /* Copyright(c) 2020 Intel Corporation. All rights reserved. */
> +#include <asm-generic/unaligned.h>
>  #include <linux/io-64-nonatomic-lo-hi.h>
>  #include <linux/moduleparam.h>
>  #include <linux/module.h>
> @@ -741,6 +742,59 @@ static bool cxl_event_int_is_fw(u8 setting)
>  	return mode == CXL_INT_FW;
>  }
>  
> +#define CXL_EVENT_HDR_FLAGS_REC_SEVERITY GENMASK(1, 0)
> +static int cxl_cper_event_call(struct notifier_block *nb, unsigned long action,
> +			       void *data)
> +{
> +	struct cxl_cper_notifier_data *nd = data;
> +	struct cper_cxl_event_devid *device_id = &nd->rec->hdr.device_id;
> +	enum cxl_event_log_type log_type;
> +	struct cxl_memdev_state *mds;
> +	struct cxl_dev_state *cxlds;
> +	struct pci_dev *pdev;
> +	unsigned int devfn;
> +	u32 hdr_flags;
> +
> +	mds = container_of(nb, struct cxl_memdev_state, cxl_cper_nb);
> +
> +	devfn = PCI_DEVFN(device_id->device_num, device_id->func_num);
> +	pdev = pci_get_domain_bus_and_slot(device_id->segment_num,
> +					   device_id->bus_num, devfn);
> +	cxlds = pci_get_drvdata(pdev);
> +	if (cxlds != &mds->cxlds) {

Checks of drvdata are only valid under the device lock, or with the
assumption that this callback will never be called while pci_get_drvdata
would return NULL.

With that, the check of cxlds looks like another artifact of using a
blocking notifier chain for this callback. With an explicit single
callback it simply becomes safe to assume that it is being called back
before unregister_cxl_cper() has run. I.e. it is impossible to even
write this check in that case.

> +		pci_dev_put(pdev);
> +		return NOTIFY_DONE;
> +	}
> +
> +	/* Fabricate a log type */
> +	hdr_flags = get_unaligned_le24(nd->rec->event.generic.hdr.flags);
> +	log_type = FIELD_GET(CXL_EVENT_HDR_FLAGS_REC_SEVERITY, hdr_flags);
> +
> +	cxl_event_trace_record(mds->cxlds.cxlmd, log_type, nd->event_type,
> +			       &nd->rec->event);
> +	pci_dev_put(pdev);
> +	return NOTIFY_OK;
> +}
> +
> +static void cxl_unregister_cper_events(void *_mds)
> +{
> +	struct cxl_memdev_state *mds = _mds;
> +
> +	unregister_cxl_cper_notifier(&mds->cxl_cper_nb);
> +}
> +
> +static void register_cper_events(struct cxl_memdev_state *mds)
> +{
> +	mds->cxl_cper_nb.notifier_call = cxl_cper_event_call;
> +
> +	if (register_cxl_cper_notifier(&mds->cxl_cper_nb)) {
> +		dev_err(mds->cxlds.dev, "CPER registration failed\n");
> +		return;
> +	}
> +
> +	devm_add_action_or_reset(mds->cxlds.dev, cxl_unregister_cper_events, mds);

Longer term I am not sure cxl_pci should be doing this registration
directly to the CPER code vs some indirection in the core that the
generic type-3 and the type-2 cases can register for processing. That
can definitely wait until a Type-2 CXL.mem device driver arrives and
wants to get notified of CXL CPER events.

> +}
> +
>  static int cxl_event_config(struct pci_host_bridge *host_bridge,
>  			    struct cxl_memdev_state *mds)
>  {
> @@ -751,8 +805,10 @@ static int cxl_event_config(struct pci_host_bridge *host_bridge,
>  	 * When BIOS maintains CXL error reporting control, it will process
>  	 * event records.  Only one agent can do so.
>  	 */
> -	if (!host_bridge->native_cxl_error)
> +	if (!host_bridge->native_cxl_error) {
> +		register_cper_events(mds);
>  		return 0;
> +	}
>  
>  	rc = cxl_mem_alloc_event_buf(mds);
>  	if (rc)
> 
> -- 
> 2.42.0
> 



