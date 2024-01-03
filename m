Return-Path: <linux-efi+bounces-316-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE73382383D
	for <lists+linux-efi@lfdr.de>; Wed,  3 Jan 2024 23:32:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 455E21F2822F
	for <lists+linux-efi@lfdr.de>; Wed,  3 Jan 2024 22:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0A611802B;
	Wed,  3 Jan 2024 22:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ep37E9Gq"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A381EB2D;
	Wed,  3 Jan 2024 22:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704321151; x=1735857151;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=jzKx9Fr65aDAAfMllOokvRpD9M1H7rs2ZZeNRwIX0SE=;
  b=Ep37E9GqMGGBbWy+zuxZYZEqhBRdksy7bF/1Z1SkHjtjzVojmCYtVAlw
   ZVw82FaYV88jX4PUIrK7+ms60cToKNWsuUDyST5xcrosBuQgZWTeTqTSp
   rtJOAHPQ9lKKEyFBkBicBwcPQldHjaVofzEsvief16w5W/Xl4NeCDt7a2
   Y3pnOvh2uA/n3B3EmYvN3Qg/OdfvIdAVxul12ysb0onv3akOCq1IR1EZ1
   jnp/Z4h6NMc69NDH61CHe5bcIU0Au3uc/IUJ39Db4HXwmavaaXE4XShga
   LA6g+dLq7R7bsiskk28R3NgBzZzAj1010s73/Fpzu/FshWqASk3zw1lsj
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10942"; a="461392107"
X-IronPort-AV: E=Sophos;i="6.04,328,1695711600"; 
   d="scan'208";a="461392107"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2024 14:32:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10942"; a="783645686"
X-IronPort-AV: E=Sophos;i="6.04,328,1695711600"; 
   d="scan'208";a="783645686"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Jan 2024 14:32:29 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 3 Jan 2024 14:32:29 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 3 Jan 2024 14:32:28 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 3 Jan 2024 14:32:28 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 3 Jan 2024 14:32:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XTNY6ZPmk7YvOhFGYcfgku+7PfpBZu/GuniKOP6jsrGLsmQgRkYAnFPDUS1CKYj+nLzy/t7VyxhY6sIdYpA9+6gpz+F8TsV16QOsTrLx+mo/PBM+PXnACOHfGxnEZId/6BpTd0peM/yPKwG91nYBhRVk7hGH3PA9y0oPaPuc1mK8+yqmxNfApaOLEMr+Ht9X92oy9laVJIcrjwZyCmgmTEwnpEhA4wXzFKioTd9v4aWlE3UyKklL3JUfgWoS7ok4VFnr7kA8aXUE8Lmx1DHWBJOn045rXBf9cFtNfYusCGXP/0MCt/oDdASrtwu4PFcBMq4hBaQTbhqocP+5fwIaxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/vXX+KNJzLecPIQOzX5Q31zbmzn+bF5BSq8F2TCC6cw=;
 b=J8jG4DiUncvvqQ+l6pmn95lo8ijrsb+ZVHYNf5mV7UgqS4H303zNLU019MgA3fbYUEpAik6bt1m3QasDd9itRPni+1Z1inFkf0a75w7Yje6GBT/KJOME/UBuKMhVQrXEH7dgqlsqUMZjbDXNT961rly18MHEDDvo99a9hkcqB1dBaw4ZIk33uRXKLpnmsKlVPUJOvONN9/kepzCiKLSpjvzZGKHlNf4wqIZJzVgTpLOE5MD31jv4eAoshINI/s93GTvf/6Hxd3TWOAHMxeoFwNOMehB/BMJ3NiEYC/Gk4Od3abdVtBbR+ED1kndirJhXSdockkp/YEtIT4Wa2YAI/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by SN7PR11MB6560.namprd11.prod.outlook.com (2603:10b6:806:26c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13; Wed, 3 Jan
 2024 22:32:26 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::da91:dbe5:857c:fa9c]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::da91:dbe5:857c:fa9c%4]) with mapi id 15.20.7159.013; Wed, 3 Jan 2024
 22:32:26 +0000
Date: Wed, 3 Jan 2024 14:32:22 -0800
From: Ira Weiny <ira.weiny@intel.com>
To: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>, Ira Weiny
	<ira.weiny@intel.com>, <linux-efi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>
CC: Ard Biesheuvel <ardb@kernel.org>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Dan
 Williams" <dan.j.williams@intel.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>, Yazen Ghannam <yazen.ghannam@amd.com>
Subject: Re: [PATCH 3/4] acpi/ghes, efi/cper: Recognize and process CXL
 Protocol Errors.
Message-ID: <6595e076cac24_3ec8294fb@iweiny-mobl.notmuch>
References: <20240102150933.161009-1-Smita.KoralahalliChannabasappa@amd.com>
 <20240102150933.161009-4-Smita.KoralahalliChannabasappa@amd.com>
 <65944ec1dccee_151dc1294f3@iweiny-mobl.notmuch>
 <66b7feb6-b151-ad97-0ee4-3fd7da7137eb@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <66b7feb6-b151-ad97-0ee4-3fd7da7137eb@amd.com>
X-ClientProxiedBy: BY3PR03CA0004.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::9) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|SN7PR11MB6560:EE_
X-MS-Office365-Filtering-Correlation-Id: 79d34f6a-284b-47e6-2074-08dc0cabdc85
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0qxOQ5vOyEBn7Ws8/xiX0gpVSxg7Y7NCCbDWgV7EQL1dIHKEtbrR5GaCl3Eb9puRkdw7cH1jkQDGPZCHajwmeHbQGYdXfRd+2i5yHawzGJY0uihd+M18lZcPoYg934L21DB5qODPFLsjMtm3sZpW1JTBfMbV1kb1dxWyPzJnCys+hYPjCsIMscd4KuyDgTx/JW0oncfg2b6v+Hqs8s67Noap6JiY12h4fdOQKtY4sF0BJg7r7q+tntylnxRRqI6zcOYfnDXoEGvr7ufLBLPP1Okx85EZ6LOAeq8JGOufE150tS1I3Lo2jcSgGdz0oeAIa5eoif54QATnyls8fddLprYnCSSPuiDvAzIm9band6Ti8LlcakW+acYubE46BwK0+a3C3ICAGlrwVzgTPaJHbSxdPuKLt0F12+Gv1+Stb3gktllcTSc3CxCGKigsZ2Bvvl8iyhzjx80AnAwhikSV2LRjVvcItu+p7W9qsvHvn/nIuGKno8SUy8yEcJBhOOZStXgpYIgY1+bHmdHc5jG3dIy6C5+OuwTTtpXxqedKtQpdG9FKFfhRuE83IvqO+Jpa
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(346002)(396003)(366004)(39860400002)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(6512007)(9686003)(6666004)(6506007)(53546011)(26005)(82960400001)(38100700002)(86362001)(41300700001)(44832011)(8936002)(4326008)(83380400001)(110136005)(2906002)(5660300002)(8676002)(66476007)(66946007)(478600001)(6486002)(66556008)(316002)(54906003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MJid5/D9alX2v+sp1WwXpdO2p57DIZwXirWMVmJmpWfvIUGi0nLSla5QGYmt?=
 =?us-ascii?Q?/5a5OmjQuJVgmPbDihDPFlJbeiOA08WD/3BkNxO9s3LlychJMIAnwNLMNfRy?=
 =?us-ascii?Q?iMFnEwesF7/fukC7Et+gg4FI48eGXRsUU+X/ACOZJBj/7QZKeGGPLcvTQqin?=
 =?us-ascii?Q?5GS7N2QAZIlhJVAUqzPqTDKnsOauWrwWzMVBlRbU6zutkCDMMutcQDCl4rC2?=
 =?us-ascii?Q?ZYlAEeCaOxhWP77RT3d1vkK4G3gxYZxcsDfitldbhH1N3baAKHh4OngxKPYx?=
 =?us-ascii?Q?g7h9Z3VW52V7AQvug3mu4ikdhpG8qgDXm8By0IX7AelrFYVOU+XEsrKo58uy?=
 =?us-ascii?Q?Q6NgYKHcKyzBDDOd4jGjo9NlLlLb8aeE2PKpkRaptRuwB/l9mA2Mu9sPX4Ei?=
 =?us-ascii?Q?VvKZeksHCZZcbOdzBXaH+pyZxskaq8Hx+BnfSwzeb6uNzSnfYEfGY6YASA8n?=
 =?us-ascii?Q?oOSZ8xm3D/5cbep5r7TX4/3W7IeaQjHxBQ2KMmsJ1Hg+I7JdVNYvJaxfVX+j?=
 =?us-ascii?Q?QlARfDsFEY67ucuB2JMSn2M8pD/4fvLiUdBRtNaYdc1mtOaKVWsWdur+aLQS?=
 =?us-ascii?Q?2AQcZJLCooy+b2kR+hHiejl82Z2hAw8m4gkphfQNvBsNvOWUi0LsOMv83gSR?=
 =?us-ascii?Q?17If0KycR+MFjONRv4htX8lB/szo7A86VUrKh2K7w3ZcOiBrgmE3YV5GCqIL?=
 =?us-ascii?Q?BOUfKFr3Gin2v7ASZ4ZdGFexFlo5LVZmAZ3Xels2sNjk18/vZuXQM3WQSa/3?=
 =?us-ascii?Q?O6bzGEC0KNqDQr9JluVAiXFtNLarb4XT1IQsUpzz1Agk+VJy2eyiEgXOlsne?=
 =?us-ascii?Q?hor/tIA6SkM0VBH/VrsYcjydIRDuUUnBce+2Dt8tTze1pYI2yP9N6I/+QS6m?=
 =?us-ascii?Q?R9Il39cU23noqX3qDo7qfQUqicW+r3pm16si070XGADvUjCIfHni+xAmuHJK?=
 =?us-ascii?Q?TIMr5ntFHYxCpxsSzhbYWx4CwkfWhXHPladqILhYqLWy9UOBSVKu+jpDuJj2?=
 =?us-ascii?Q?5fmcpIyfML5REOgEuKrTleMQQiTfNXhtt2z9ybbNc7V4zfkETaQXVXRg3cKb?=
 =?us-ascii?Q?Dlmss+Br7inmM8mKcaJmdF4Uasfer3iv61sfAm6rTc0srg9P3uaEyATErhyN?=
 =?us-ascii?Q?jg+d25SO7idtUDpg5PRk/li7SJ75Xdxi2uEBS98t2VLR5hKNfxVPqqj2sJlH?=
 =?us-ascii?Q?qRL5odAt/FW0kqYC1GEBqPOPu4yHItFPbt0HTyM7dCyyH/WH362tbB370PCS?=
 =?us-ascii?Q?mUUrveLLehSto5u2pzzD3zw2bJxzVY+ff5B8SUXoCa0cfS2NlUkMEFVp/1hB?=
 =?us-ascii?Q?xB9NoEm7TRWv7AgHpDH9nMlJQkioFlL8nWM8iGhS6f6umr0Dl0bqNcfQBV7b?=
 =?us-ascii?Q?GDY5KcK/AnPckLAl3601ZglHRZWTKVrVu8Twz7WOSFZrQm6tp5z2P2Hksb37?=
 =?us-ascii?Q?MTk4f8a2MeM91dwLd4qMOwvd+EYsuKUUe+EuTHME1HkuB8uuGF3R907AlHux?=
 =?us-ascii?Q?5RqFZKxGNsrMYMxWFTdwQ8XfK2u7Pq++Zqs9/BdeJitrhZSuKXKvKg/GkMqn?=
 =?us-ascii?Q?PKUfnsMu+/vQSsFtvGdJdrv62pJFseGYfoiRnDsM?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 79d34f6a-284b-47e6-2074-08dc0cabdc85
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2024 22:32:25.9756
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1w9lFAiDnlevZjy9kzqvCLIe+wGAADhapYw3vx0+i5xmnX6V9jEK60lTdFs4cgvB+XIfJuJ0sDrVXXSAkdOu3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6560
X-OriginatorOrg: intel.com

Smita Koralahalli wrote:
> On 1/2/2024 9:58 AM, Ira Weiny wrote:
> > Smita Koralahalli wrote:

[snip]

> >> +
> >> +	return 0;
> >> +}
> >> diff --git a/include/linux/cxl-event.h b/include/linux/cxl-event.h
> >> index 90d8390a73cb..7ba2dfd6619e 100644
> >> --- a/include/linux/cxl-event.h
> >> +++ b/include/linux/cxl-event.h
> >> @@ -154,11 +154,17 @@ struct cxl_ras_capability_regs {
> >>   
> >>   struct cxl_cper_rec_data {
> >>   	struct cxl_cper_event_rec rec;
> >> +	struct cxl_ras_capability_regs *cxl_ras;
> >> +	int severity;
> > 
> > NIT: When I saw this without any addition to event type I wondered if the
> > series would bisect.  I see it does because the record is not sent until
> > the next patch.  But I wonder if the 2 patches would be best reversed.
> 
> You mean to say patch 4 to be 3 and 3 to be 4?
> 
> And since I haven't used severity yet,  fix it by declaring severity to 
> where it is used..

Yes.  What you have is not technically wrong but it threw me in review.

> 
> > 
> > Also, should cxl_ras + severity be put in a protocol error sub-struct?
> > Does severity ever apply to event records?
> 
> No, not in any of the component event records. Only place is in "Event 
> Record Flags" in Common Event Record Format (Table 8-42).
> 
> Addressed in patch 1 to make a sub-struct.

Thanks!
Ira

