Return-Path: <linux-efi+bounces-260-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97B40818B78
	for <lists+linux-efi@lfdr.de>; Tue, 19 Dec 2023 16:44:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05C951F2391E
	for <lists+linux-efi@lfdr.de>; Tue, 19 Dec 2023 15:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05DB01CA9D;
	Tue, 19 Dec 2023 15:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NEgn1OqG"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9231CF86;
	Tue, 19 Dec 2023 15:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703000642; x=1734536642;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=/ZJU8Z2b9UjmCjTveQ7e3RdY45XYt3hibub4y587gck=;
  b=NEgn1OqGkFVupWIN3VeBdgBCepHPs1vqauzWnDqkYETHaeV5ztngB+Rw
   ca8jvbUc2ugk3qcbUdyO0dp640BGrUANA+xSudCVbqCAxQnyQ4IWhxiA4
   r6tjLZDQRzXVPUyeaoy70basno7zRFrVH9WCu4nvCAfiEeVKn0bFJeO76
   65ilmanWTFGdIioJfifDpm3aWcUsuQuZB4IwqjDZSDa6W6AANQzZ/pJNJ
   bYEwcU+QZ8aJI9y1SE6sHYQaV1PZCmjGmKUQnnEyew3qF74KcPH5opUrD
   JaloMTvh29MByiPSxoMW4/BcQVb/fjCfEvC3y8wt0JNNUXDFudVzSOzbC
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="2529374"
X-IronPort-AV: E=Sophos;i="6.04,288,1695711600"; 
   d="scan'208";a="2529374"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 07:44:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="919652087"
X-IronPort-AV: E=Sophos;i="6.04,288,1695711600"; 
   d="scan'208";a="919652087"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Dec 2023 07:43:56 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 19 Dec 2023 07:43:51 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 19 Dec 2023 07:43:51 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 19 Dec 2023 07:43:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L1Fni3q7s56Vr69Fh3Pi3gnsvxnZjXRw74vpq/f5fo4LGMo1SPksFp5XM26wWme/B2CqFhGTSxNglYa3lJFP2kQLqTdQwQk4n6vcjzCMQ9tQzT0NKQ/4te+wkpOvR4Xao4sUN+/1FbmX3fHHhcjRy9psBG4p5Z6a5cLNdCQoL7602vv7jK4bfTv5nKEsurT8yh6VL2dvVyD6NXtp4dZp+G3XBVp+MVwj8BgIalQXnNn7KIFcQczHel0TGgCdwwLBqUZ4YAgyQcaVSoR4yUT6a4bPxIrvu4aWXfvEd74+58z0xRVW6hvDpmp1kmaB1LdviA5M3v9MSCPzPcfp9DeDww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hPh5w9Khzbecp+skwdYc5nMAFiRByABszmjg4EYZIPQ=;
 b=mvAZp9ZVjWtlhXqjT1rXKlofgB8KvVMaB9OVFT0p6M1QidGYfXVVaySMhmvuoMqldB+tkJjWE8HLKUfIldTh5eovvosIPl8uP46DL/yNNb4dh5UU3CN12JywXPOXPZ96st4acVYgPGD4Z2bcBQYFiBWAh+XskUv9wigR/jTE7cJ4HllYc2q0arXG9hkm0Loe0aWR84ch5VX2NhZmr8kHjhuHOrSEX5jCSA8ww5LD9fWElWpTjYQuWoGkGgKDPgSWF+6D8ciUqyRHppQ9eQSnnaAs49gHPcbpmSC4XTZKEZAboSWEyxLfPJuBKvZ4Mf1h/rHVdZliHnMVCNw0hmlvrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by DS0PR11MB7970.namprd11.prod.outlook.com (2603:10b6:8:121::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Tue, 19 Dec
 2023 15:43:50 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::da91:dbe5:857c:fa9c]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::da91:dbe5:857c:fa9c%4]) with mapi id 15.20.7113.016; Tue, 19 Dec 2023
 15:43:50 +0000
Date: Tue, 19 Dec 2023 07:43:45 -0800
From: Ira Weiny <ira.weiny@intel.com>
To: Dan Williams <dan.j.williams@intel.com>, Smita Koralahalli
	<Smita.KoralahalliChannabasappa@amd.com>, Ira Weiny <ira.weiny@intel.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>, Shiju Jose
	<shiju.jose@huawei.com>
CC: Yazen Ghannam <yazen.ghannam@amd.com>, Davidlohr Bueso
	<dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Ard
 Biesheuvel" <ardb@kernel.org>, <linux-efi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v4 6/7] firmware/efi: Process CXL Component Events
Message-ID: <6581ba314ee16_24f6b29431@iweiny-mobl.notmuch>
References: <20231215-cxl-cper-v4-0-01b6dab44fcd@intel.com>
 <20231215-cxl-cper-v4-6-01b6dab44fcd@intel.com>
 <a32464b2-9810-ca9d-73e5-4ed4cf69fea0@amd.com>
 <6580aa72ca0d1_269bd294e8@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <6580aa72ca0d1_269bd294e8@dwillia2-mobl3.amr.corp.intel.com.notmuch>
X-ClientProxiedBy: BY5PR17CA0067.namprd17.prod.outlook.com
 (2603:10b6:a03:167::44) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|DS0PR11MB7970:EE_
X-MS-Office365-Filtering-Correlation-Id: 274a748e-e9d1-4613-edfc-08dc00a94be3
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MoJkILRLGSNUa0qfm+qLRKtqqwkcsrumrwhNg95XV+3k4Y7u+KVdqOYrbPT+bZ2GFImUXvErquDn0ESQa4Db4OTJjoPYExgkFBcGqHBaPPOzutmL4aaUGfAdb3YQHSYcfkfm+ghH1OZQ32WuXU74AAfy3FoosoIXKtkUpt8ZQMoERy7cHJ+kmEGv4Qzb1ZkBP2M3pZ/hk/28GxzM/BmVT5wf46t2MdqCvXLN55eKn5joNl5AWvYWFD9ItTxTbu035y1hDsakWoeNhwI4+0/y60IxXTGCCQG/E1cwVr8E7m+RfU0JSHqMNNHY05aLCOBAxoTRJCrJC000h14cUBU8g83DRbx7bm8rKFargA8CVlkNsKCjV7iTFjpTttHgRr+jQYh/T6BZeqn+kAc/UEXl0wsDlLEtoiMEmTqMRkatVF2IC/ZCMX5riIe9DA8zHI1MbTqL+ocMGTYv8f44ywzhsiwtL2qElwjDWl5w1YiKP6V8ETY6ZAtqpE/2t0hzC+nB69ZsHIlmsL/Rk3CaMlkFOc74ak+z59k9ZRXD8EsqPSio4HplEAnX3p/FYzgtjBab
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(346002)(136003)(366004)(376002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(86362001)(82960400001)(6666004)(478600001)(53546011)(41300700001)(6506007)(54906003)(66946007)(66476007)(66556008)(9686003)(6512007)(38100700002)(2906002)(110136005)(6486002)(44832011)(5660300002)(8676002)(4326008)(316002)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vrUqwtze+z8w2rYO3huwf1JAaJ4+tZD2Nt+WaBACqcFC1pwIxUgNUFzJ+bYS?=
 =?us-ascii?Q?lPCoFjZsXeSNNzMuaQ9tB7ZpB5TZuafXuQ5alkjg5cMVYNz4SeTrw9iA5arP?=
 =?us-ascii?Q?iyy6D29bhXBj/dCY70Xz5vwWCmjDJDECQrh/MxkvUItBl18PZePm4401hkgz?=
 =?us-ascii?Q?Y7TRi3LoFCxUb6caRQX/ci3/2x9B9Qsux1upGry/tR6R2cjDMAUYAYggOsTN?=
 =?us-ascii?Q?QMeFYiNWiN74mpjYHxOUxvuoCjrU5KONXZnV61e3iLJ3Lj2jp859WzH6K9nT?=
 =?us-ascii?Q?jq0aXqKQmRCeKIxY9KENaj8X+ZNwGo6qKHbzdwqytro9KumUGUeoEk1Ntl2R?=
 =?us-ascii?Q?T9RnvSEpDPFC9QKt2rRACVtr7Itg9v+Kzl93MiGs3wEBoVYfd/wMY+m6k0C3?=
 =?us-ascii?Q?/k4V72JuPM56WBJUmarInOYt23osClT9AN0Tvpwf4aVDMBgHjt0AKIVc75Qf?=
 =?us-ascii?Q?WPyyUeePK3Hm7Tw8zUNkCLMMfN5pKlqPqui6mWip2++6AFF+k1wmDorHLBTh?=
 =?us-ascii?Q?IaBU+zLz+S1x27cU9LnSK0fhRqX9oWqRl/IsLogy9FoBJy2k8gEpu/VSotGw?=
 =?us-ascii?Q?GO7GVGfsboBhOywAoybnZm53b+Rc1p2Xhm7iFYZc3sD/22sA7PQLg2tqB15I?=
 =?us-ascii?Q?xB9hwzGHv2MT08vQ3YbN53EdOeXqyMU2aDQY2D0RHfWWkFF6B0OkZ0NBLEWU?=
 =?us-ascii?Q?Jip4Hma8GMz+/eVlaDA5BnUSAIARx5oHx34z0OXtkfAGwhztwrfCt74OI65I?=
 =?us-ascii?Q?Zw8bdfhcunbg36durQQL1EZgQ1nA17Ji3MRXYlYShjuqp3bQwgOyukIbyLEC?=
 =?us-ascii?Q?t6wF3H/FL1nNP+vU54z9tj/yYtlvaMUXMYgZEWLvoZN4ne6i2MKcq0M/8dW2?=
 =?us-ascii?Q?Y+vN11z0MZPub1+jSsfxlyLuHpoVf6tTa/q85ikt9PmKwBhfzu6K9N7NA/n6?=
 =?us-ascii?Q?PyvhndBmxu46Qb+AT9Y2eB6r/hpGjsQuDw2TtZ2C9u/2LL2KsbTCWlqdYgVi?=
 =?us-ascii?Q?+crD6An5Ebxom09c2JuNgLyobT3/eoBEQoAzE739vshvdguTadcj30uq9Bdg?=
 =?us-ascii?Q?UtMcavyEEXxm1soK+j/SDPPluy/98bxwzFSght3uuiPjMSMPiEeHypK+glh+?=
 =?us-ascii?Q?Nx26HA+lLFH0fuKyPEAs5R3TxCEh18W9Ae7CpTwcIfpOdszE7ER2WGd6JlDN?=
 =?us-ascii?Q?vMJUuNBtM2bE4Cmtb5QMU3nntwJnIwD3aMDfJsdFiodTTmjZPq3/JWr7eMIF?=
 =?us-ascii?Q?WPyNwJh4bM0yDVcm+STaaZP/SaqOMWDS85SwkvH5oZ8CgYw3dgQlSfct8zzf?=
 =?us-ascii?Q?uNJXzXB84uIBizsH2qRlzmvrWqDrDENdf4XvgSt4ILmj8RJl1pB6ej4t7wo9?=
 =?us-ascii?Q?fOJBTctuJifPPt2eSOip+KWygDKZZpcUgmvLtO9oPIKBN8pamWqdhL6bY3fy?=
 =?us-ascii?Q?+OUUZ19phzlExTpSZ6hxsWNj7uxhtx/86ZDxW0RHgp/k3INsfj2SxJ1tEmdD?=
 =?us-ascii?Q?BgiiJVgxoTPlsu6swES0tJgbtHb8hfXLbi4AZ5sY/tJ3Ihw/aCukUc0+u/PM?=
 =?us-ascii?Q?ajw32g5L66cS+gluzSGZwrkdbfpJP8Cc5wnSl2IS9RFjdUuGDS+A8DouCXBH?=
 =?us-ascii?Q?uJFYWggI0/UPmGt+jI0H6WM0TRP2aPkifn97BKbuBk99?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 274a748e-e9d1-4613-edfc-08dc00a94be3
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2023 15:43:50.4004
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FZ2t7StMacCXv3mSjbCh7HEnO5suus4jAq1cEUrBI+gxAeYiJis8YyftgWz927Op9BVrmUfJ5f3npYb4Po8kNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7970
X-OriginatorOrg: intel.com

Dan Williams wrote:
> Smita Koralahalli wrote:
> > On 12/15/2023 3:26 PM, Ira Weiny wrote:

[snip]

> > > +	struct {
> > > +		u32 length;
> > > +		u64 validation_bits;
> > > +		struct cper_cxl_event_devid {
> > > +			u16 vendor_id;
> > > +			u16 device_id;
> > > +			u8 func_num;
> > > +			u8 device_num;
> > > +			u8 bus_num;
> > > +			u16 segment_num;
> > > +			u16 slot_num; /* bits 2:0 reserved */
> > > +			u8 reserved;
> > > +		} device_id __packed;
> > > +		struct cper_cxl_event_sn {
> > > +			u32 lower_dw;
> > > +			u32 upper_dw;
> > > +		} dev_serial_num __packed;
> > > +	} hdr __packed;
> > > +
> > > +	union cxl_event event;
> > > +} __packed;
> > > +
> > 
> > For some reason, prefixing the struct name with __packed attribute seems 
> > to do the job. ("__packed device_id" and "__packed dev_serial_num").
> 
> Good catch, yeah, the expectation is that follows the closing brace not
> only to match the predominant style in the kernel, but gcc appears to
> not honor it otherwise. Looks better with this on top:

Very good catch.  I did not mean to do this at all...  :-(

> 
> diff --git a/include/linux/cxl-event.h b/include/linux/cxl-event.h
> index 2b137aead750..975925029f6d 100644
> --- a/include/linux/cxl-event.h
> +++ b/include/linux/cxl-event.h
> @@ -130,12 +130,12 @@ struct cxl_cper_event_rec {
>                         u16 segment_num;
>                         u16 slot_num; /* bits 2:0 reserved */
>                         u8 reserved;
> -               } device_id __packed;
> +               } __packed device_id;
>                 struct cper_cxl_event_sn {
>                         u32 lower_dw;
>                         u32 upper_dw;
> -               } dev_serial_num __packed;
> -       } hdr __packed;
> +               } __packed dev_serial_num;
> +       } __packed hdr;
>  
>         union cxl_event event;
>  } __packed;
> 

Yes thanks,
Ira

