Return-Path: <linux-efi+bounces-174-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B2E8180DA46
	for <lists+linux-efi@lfdr.de>; Mon, 11 Dec 2023 20:02:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53653B20CFF
	for <lists+linux-efi@lfdr.de>; Mon, 11 Dec 2023 19:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5289851C5C;
	Mon, 11 Dec 2023 19:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fbQ0K6xp"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81950B4;
	Mon, 11 Dec 2023 11:02:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702321337; x=1733857337;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Plnk0dMWJF6+FKICpjMKw+roaaRvlIKoJ/Ypn3wYICU=;
  b=fbQ0K6xpuiub21JMwIcBHMnjaVIkshwQ9RFDPN7nKiBf0F7gx+gvrXDY
   sZe3gToKKy3CLBV29qBypqAqFOS7gEj9pLevfoV+z314HTDoExPvYBrVk
   Snhxh9QNJnxuFswYH7p4lh8Qt+llEPD1gQePQRV8sMSPrSknOmkwpMYx8
   gpYIFVFaGRlotZvpHFnl02PNA0W03f4V88+fv9rBnAN6X65f03R/771uG
   6WFwp89BUeAUewXANdID+bJRtjpLxotFMCOzXP2f3SnScqW/CA36KTVX1
   YSIRLFMDHLoyFHrpAyjFEKU7h+gFtWryA9pPbMTUZoUCiGmkOtusLWCem
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="391864875"
X-IronPort-AV: E=Sophos;i="6.04,268,1695711600"; 
   d="scan'208";a="391864875"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 11:01:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="1104581021"
X-IronPort-AV: E=Sophos;i="6.04,268,1695711600"; 
   d="scan'208";a="1104581021"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Dec 2023 11:01:59 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 11 Dec 2023 11:01:59 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 11 Dec 2023 11:01:59 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 11 Dec 2023 11:01:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZM2QK9/CiVKyVcRnc4ZtrhMjOK9GxipZTjt5ixXtLrkXJ8Y82WmdNiFL6eU0kcwolyOzWDRdRnZP2SQ1mRVx/FL2F9TGb1bXTXSU8QwcxSXq6nuAUh1I/36EQHs0UfABxbSv4JJbtyqaSFdgPQWy2ToghgTxvlhp4J10NsZC4SF6VGWt44YuB1+rcZ1L1JrXe9wErqtaBOUWoRTa2IRNERvq4guf8NVT4jwRE3ub+X3e6yBcwI+PTLDANE9LuHiC2rHsRq7zvKwz0vDnuhDNoX5Ilx9ZoEZBKb0qxcKlYTib6aCfiBwcPwbWik4NFuUv/7FUzA/myStollXfnTeRxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ans+f92PPigGuf5cGU1kJ/3UWX0TsmJXWY4/EZqUjU0=;
 b=bBq/Fft0DCE1oyUpZJ5zhuhVFE4Pm/zc+G5BEG8oUCQslxivQ4EaYeqxijmNk2qLgRCbOCLbb+KvT0TMV6jcfo24/1M4r9ab15FZ8ayUZjJvCFNzcK0y0rLVmdON0scgHktdc0de8SHqKiNGg22QhjQn6n3UO/UxGjRWJiF69IK+w6OUxWOzIfvPqS8jU+INDM+WHp9qhboQrhG6AWIHxaV/EnEw/7Ce3zbfBm57bWh9jwpoyok8iocBTbjCNxlzMz0Y9A0XUP/HpiFJ9iyla6FyygH/ohMFycaS9hDqoWWvAWJWYlQrtW3NIpd89MxCIaD7vnkrV+pAzqzU/RCG0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by CH0PR11MB5457.namprd11.prod.outlook.com (2603:10b6:610:d0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Mon, 11 Dec
 2023 19:01:50 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::da91:dbe5:857c:fa9c]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::da91:dbe5:857c:fa9c%4]) with mapi id 15.20.7068.031; Mon, 11 Dec 2023
 19:01:50 +0000
Date: Mon, 11 Dec 2023 11:01:44 -0800
From: Ira Weiny <ira.weiny@intel.com>
To: Dan Williams <dan.j.williams@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>, Smita Koralahalli
	<Smita.KoralahalliChannabasappa@amd.com>, Shiju Jose <shiju.jose@huawei.com>
CC: Yazen Ghannam <yazen.ghannam@amd.com>, Davidlohr Bueso
	<dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Ard
 Biesheuvel" <ardb@kernel.org>, <linux-efi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>, Ira Weiny
	<ira.weiny@intel.com>
Subject: Re: [PATCH 6/6] cxl/memdev: Register for and process CPER events
Message-ID: <65775c98e0b39_1f2db42944f@iweiny-mobl.notmuch>
References: <20230601-cxl-cper-v1-0-d19f1ac18ab6@intel.com>
 <20230601-cxl-cper-v1-6-d19f1ac18ab6@intel.com>
 <657279a68c270_b991294e@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <657371eec6ac5_1e7d272948d@iweiny-mobl.notmuch>
 <65738e9fc239a_45e0129476@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <65738e9fc239a_45e0129476@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: MW4PR03CA0248.namprd03.prod.outlook.com
 (2603:10b6:303:b4::13) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|CH0PR11MB5457:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bdaa976-e216-4971-40a9-08dbfa7ba14a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Rtlej2vQJsmKyC2BGZhRyOq60eykDOUrdgHDwLa1dBKXrFgDIzJdkC0UJ7ntyl2OczBLZpFb14kav4WU0qYBHN/wGY5GoRjfWE/0b9AGSHzuwDaIyHNVlLiYmZRLOOwHhiRrowySoPLBv4uHFYs4///jlpeYezqgMfE8TASvqPLwDOIgPtNXupMPIJEHm3WVeD/HS6QPKpyBtMEJLW0aAl5wugmNR1brh+at5BSLuVQw+bq32JDSDg6eegCgmtKxw9GLsYfR6vGii/GlFqn8IdAutIrVGfG9P1CT27FvozRco88l1CuRrXXNmj6dXtIdbqjvzmLCyl23ywOkRBqyYoPpmijI1mM6o0ZPXg0wpw4l7mPnhOmJQKq2Y0Ra7i3tkAUCoZNDhyeimGIKNI+swEFgn6/XbqDIONirOzOfQf8g+yjcRO5+vvJCLQCMTaMyId1L0ho4b9VOXk3lEw45VibTKnHzocboxC5Z5IuOoU2YjLhQD4mIaz+i5GKUwDEME2ZxwXeVxtzKZTXGvZkcEEt+c04D8pvTcdX1g66ueid90Bx7Loi+/1M93ez+GBMq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(346002)(396003)(39860400002)(376002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(107886003)(6486002)(26005)(6666004)(6506007)(478600001)(9686003)(6512007)(38100700002)(86362001)(82960400001)(2906002)(54906003)(4744005)(44832011)(5660300002)(66946007)(66556008)(66476007)(41300700001)(316002)(4326008)(8936002)(8676002)(110136005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/gjHnuckH3v5ngG/g2WcmpXw03qy2ZK5ubO9LWq3UcIG4kgj6+cd9dWt+1Ya?=
 =?us-ascii?Q?MHkHv5SLSbyf+5vfrRESXyH5DRDfz6OoTbKROolhARNcvHc+O3dtNfzGYmXm?=
 =?us-ascii?Q?rcA3g3mpt2KzMIntTVzBKtRVR5FiOyYbLQLBdDBnIgz8ImNgYcGYZXqH65tE?=
 =?us-ascii?Q?/50kwIwWelHJJ5dJF9JwgVuZJY6sdo0OkozjjfstJT52NfSl0spG+T/CBYKC?=
 =?us-ascii?Q?EvFt9JcQRA/8QLMBbe/nWKTep6BTHzyapvazxftdIZrEexliSZQ/ezFMdLnS?=
 =?us-ascii?Q?TXN9sVd+LoxGwmb5n4LZHXPXvZMal6G83KLpgErsEEVV/fzf7b/QDvDf+nL9?=
 =?us-ascii?Q?R5EZmhO1ZN+281ptke45DCbqZJhZBa6wT0Um+7tCetgpIpfvBI1JdYAdRl8Z?=
 =?us-ascii?Q?lfD10lVAQ6+rYWaQWC078W22AUKam8tfU6S50qv2a+LsY0hVporDDfG4kaYL?=
 =?us-ascii?Q?7avzaCGmI+pDdYADS+iympx54ASC0es2G5n90M3z9+EqOZSFvZgDOCun7UTR?=
 =?us-ascii?Q?Q4N96SdgWdbBeOh0JDf6XnmHkd/6x5MDc5AcUeXgfjnmAd+8UuLZO2DINuuE?=
 =?us-ascii?Q?kaNSgMLZj0FgPB4YppfW1nrBR5ZBBZujzC148Ctj4A4He56+lEBTy3ahKNh+?=
 =?us-ascii?Q?MzLfnvmxdlQTsLM1fT2r4edKD4hgK/JeTbxojKMytIXNWEajKWgtwFihV/31?=
 =?us-ascii?Q?3AFh42RR1Ak3hVUD5aoEjWJCJOgq6sIEfpNDpvfbedU0BbC+F7Vt8+GHQ2I8?=
 =?us-ascii?Q?l2QuYhZBVPDfKs94krTtcgkQUaYZkG331musLbZ/3Z6dr3K70h2ph9pb1x6t?=
 =?us-ascii?Q?eUXIlEUiErPtUMj/QInAgDVu0ADyNzuhrfasDw+dariqU2LM0FZhfxQsjqe3?=
 =?us-ascii?Q?9Q2TxYJMI/uf04mDAueIubQ2pjqKqSJzlG6m/d7ubykGWdg9W8HJHcbhkagd?=
 =?us-ascii?Q?IasP+SCK2utdBmOuw+8SaRBpcntAnfQ6lALjlRPxzg1sYmLQX9Ua6Xemk4EH?=
 =?us-ascii?Q?SeCDX1ZF9AyzB6JG9P4EVgoTGR65P3SxZfUQN84kekla3tB+pMa5fcPYk4qM?=
 =?us-ascii?Q?QfQuNwhqfimxkzZTTDvBSAGTvJJGohb5c3nW1V0Z5EQJUXjEpiDk+5r8QbQb?=
 =?us-ascii?Q?cc/rsHDMfVtHDJLvaNLKquJfDvAFV9IZZk0bWEpB/TKBvBLVn+LB56+/W6Vp?=
 =?us-ascii?Q?SetkLQ9JtScvJ0cs2xeEFtGi3CINCRQF7/9cDWNpFZdL9JnCD95auS//lX87?=
 =?us-ascii?Q?XX0p2AHonIF4f7tw+j74827VA9wlC8h3wf6T+Ov29SlmZcE3w8LH54uEvZ47?=
 =?us-ascii?Q?1OAaAafemsOeTi6UJeszW1SzfSS/n47LMW42zyTei32UcKRbogeMwhGKvZgk?=
 =?us-ascii?Q?zH+2e3FSmwWgv4vOJPKpx2cPsDNOJeN7y2IONpSHPrQf2G70vImwensWlHds?=
 =?us-ascii?Q?g8vNDOeFB8FP4gTzeCuRdpLN1t7Jr2uHaJH29+MDJTL+ferqDzaJpJ7mNJNi?=
 =?us-ascii?Q?jGf0f6Pb7u4dZKVf8hi1apK2eauVVJ+PNz0trHfQqPaaC488+BIUHpeSJ0UA?=
 =?us-ascii?Q?z2LdA87tXHJeA64Nv/QD1P5yJEkV6Rrw1u0WZx1N?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bdaa976-e216-4971-40a9-08dbfa7ba14a
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 19:01:49.9363
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V64wC2BdQB+oAS0NrLQIDY4TQ8qj41rcT+/EiOgut65lkpOBdR38/RohMzys/ywNP6sE244d7TmQCZhqxxBAwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5457
X-OriginatorOrg: intel.com

Dan Williams wrote:
> Ira Weiny wrote:
> > Dan Williams wrote:
> > > Ira Weiny wrote:
> > 
> 

[snip]

> 
> > #define CXL_EVENT_HDR_FLAGS_REC_SEVERITY GENMASK(1, 0)
> > static void cxl_cper_event_call(struct cxl_cper_notifier_data *nd)
> 
> Is struct cxl_cper_notifier_data needed anymore, just pass the record
> reference?

I think so because the type of record is ID'ed by the GUID which is not
part of the common record.  So the notifier data adds the cxl_event_type
enum.

Ira

