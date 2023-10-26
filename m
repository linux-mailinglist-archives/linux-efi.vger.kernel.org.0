Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D68387D8BF8
	for <lists+linux-efi@lfdr.de>; Fri, 27 Oct 2023 00:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232306AbjJZW5C (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 26 Oct 2023 18:57:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234964AbjJZW5A (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 26 Oct 2023 18:57:00 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38517D43;
        Thu, 26 Oct 2023 15:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698361016; x=1729897016;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=YFEN/dudt+yKMfVpjzH/7tkSgSCk1hMXdMbCLhjBx3s=;
  b=aG32tyk30GCd6IlyrOL8cLN0OQYOn/oo/CS1Nza+FSMZMEi/5oekGXl9
   r+oLpQaJDZa+onQsMLG4YMzGINIreXbm8EJHEKB6CuHDYZud8iuZCJpp+
   XfLAS2RijvNNG67nsibfU8jDm/aoVR9HbSOrKJmSKLDt6WkuAv2OcsZ9B
   Kdooe005FirBv10Lt8poYnzbf0zKbKa2nc9iUyHPZNWZ2H/J4ofYEddw2
   xqg2hPi3igdLjrSxrq+D6AcFC9hEc2tg/hW9X0X4oDifz4k619Ox+EODu
   oKv9ORpEkQCfgCafevsEgqENTz4P5CrkFxqnxf+a/XgCD51SLBdY0aBFT
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="378034218"
X-IronPort-AV: E=Sophos;i="6.03,254,1694761200"; 
   d="scan'208";a="378034218"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2023 15:56:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="850065957"
X-IronPort-AV: E=Sophos;i="6.03,254,1694761200"; 
   d="scan'208";a="850065957"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Oct 2023 15:56:16 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 26 Oct 2023 15:56:16 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 26 Oct 2023 15:56:16 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 26 Oct 2023 15:56:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E8oGWLSwjCaoxKTTjWjVlNHIJRUV1DuRbJkewXwpSCZPFItVs1N9Nh5nd9hDv4uNAIyYiD0UjZSDzjn3a4KzFMyEf+UHVufIAJvRP66xKQVNPCDyuQ/2syK4uxElr+KNTCRrGOnJ1pM8+Z/0OhdbpOZh6ZeY/4P7gxs65OEY/oxZ6fQDk6OK837h4eeOOBWHkEZr4x77vyuyjMbv4mcICg6yQDokXL+FXX38BkdEY8hb7CptlxngRiE+21kWx2FxAenz8wyht1CE7s5usDHzqPNcQHDpCY2xe6By32XfNeO/o3uVBOzLdSa7Xd5mxdu/qvcflzZN0VicW0uxxMi+Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mGoCP6E+G5jd08biDLtc7XGiwXg6r0QhDPcWn62zvH4=;
 b=Or5o7JetbM3pBGrheNjZIXpp+uUvX0vJCY7LF0mUaBGaZVAeOPFGJnyE/W67egFnshNbTX21vEmV93y7Gne1SGcFkXFZ+g+zMOoQS+omTDkD7+maVPFZoT6NeAhcwa6siIiTPlPS0WXn4PZOPV0IwlEO5a6Q1Kafw3gfBX1RSRvQYuKmNNp8MD3kO7RIV4xDQckGnC2/U6HqZit2PTw8n1AEgmiFoV7Z2VQlIADK5WQZTmZwmee654RpzZ4we7JXe29Dks7A6FJODivLlnYAeKrvEgZYeNSRB/DqMifsp6E0obMlKt2209weGBGwFKaSqodXo324w4E28hj4gjCVaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA1PR11MB7295.namprd11.prod.outlook.com (2603:10b6:208:428::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Thu, 26 Oct
 2023 22:56:14 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::e75f:ec47:9be1:e9e4]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::e75f:ec47:9be1:e9e4%4]) with mapi id 15.20.6907.032; Thu, 26 Oct 2023
 22:56:14 +0000
Date:   Thu, 26 Oct 2023 15:56:10 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
CC:     Yazen Ghannam <yazen.ghannam@amd.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dave Jiang <dave.jiang@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ard Biesheuvel" <ardb@kernel.org>, <linux-efi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
        Ira Weiny <ira.weiny@intel.com>
Subject: RE: [PATCH RFC v2 3/3] cxl/memdev: Register for and process CPER
 events
Message-ID: <653aee8ad2717_780ef29418@dwillia2-xfh.jf.intel.com.notmuch>
References: <20230601-cxl-cper-v2-0-314d9c36ab02@intel.com>
 <20230601-cxl-cper-v2-3-314d9c36ab02@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230601-cxl-cper-v2-3-314d9c36ab02@intel.com>
X-ClientProxiedBy: MW4PR04CA0268.namprd04.prod.outlook.com
 (2603:10b6:303:88::33) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA1PR11MB7295:EE_
X-MS-Office365-Filtering-Correlation-Id: cab19653-cd0a-4632-6077-08dbd676c0e7
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yMsDExirGSdJJ4mwos/pBK+L9Q6Vqrb+Av+a/rk2fU13FToVAfH3rXqJkdhOxRXK6h1fl6hx47qwkUOCh23iGtP9Ewx4/yMng+0VCJPExxnN+RBQyQRUoVcq1Nv0LPA43t1LyiV/9YJHHSAC1PfpMuDiVRO5Ru4PsW0rVncQq2l/6LMkQPCaDQc7TwZBTIGUW1RrYlYD20mNrPFKnJ9V3pFlsWKuFVe99w6rg4EdwQr7Umh5Xt1RRylYvlLMig1hIcnV6xwvtsZ9Tn/PcUKvRjHl2F7S4jdmrW50nL0jL2MjhcQoxb4zp8T36nXoPkrSOLbhPJJnjzKQMPzIvZrNz3YHb21325eYURmKOyoZO3xmtqIQtrkb5I9ZWUHfSFF7D2lstST6Gil1ydymNqpk3xhtlGTBC0VxQbhiy7kOUrdDokbzl3KvS4TkjrbQzw87FYZ1p+mAlXXUn897vfIt9ImdCrSBEAljjjrVe5P42/BZV11oZ5CcCUWRXi9/nlwOMeMVVHVN46QlKpBnhPTu6sW+bCPwSKuJ1HabBGeKhx7hBzQsPXgcqy5/lh+FSjVg
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(366004)(346002)(39860400002)(136003)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(6666004)(107886003)(26005)(82960400001)(9686003)(6512007)(6506007)(38100700002)(83380400001)(478600001)(2906002)(110136005)(6486002)(4326008)(41300700001)(8676002)(54906003)(8936002)(316002)(66476007)(66946007)(86362001)(66556008)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5wQeZseHwIrU76aoeEMNe+RHxZ8Vhn332ZYIUt80+sgnVFvUs+/sM1o6oE1Y?=
 =?us-ascii?Q?UCDYH1mMPiTOhiM6V6T0rCcBkthX0z5kRtLnwXIdLJzqCBA7Nk1d4gI/MxzS?=
 =?us-ascii?Q?0DL3nuEiYoXEwaWf8R37eDWUgUViA6TlGSgz81JrChzYlZhxlxa6Wa2Wz3sx?=
 =?us-ascii?Q?g021ArQqsbKK44NNp76vSSCvDHeLp3sDkkDsO+mMHQoOfQXuKFd3L0SEQ4cJ?=
 =?us-ascii?Q?EhJzSiagfe1kwopbP7oCvwCYc134uajF6Qksiu8KukqFb+M4ZhY4RAtTHdbF?=
 =?us-ascii?Q?aUQCfcwDWzy1mzjsBc6Y6ylrJyRkvcOzw6loArd8V7vhOZJDVo5CTeTJh2Cw?=
 =?us-ascii?Q?Lf2tJQhF/8Y5b5UqihCSqk6VbnZbV7W0SlPAJqR5sKDln7Fdo9CXPZpdSmE3?=
 =?us-ascii?Q?1ZimtVIPQ5tHukclL7pgbjJ7uHzQubCQAgoIZfedZeut9kgw7vnadbQ5auRT?=
 =?us-ascii?Q?BW44o41xD5eeV7NUa1zZ53MmZQF+IMIy4wqWb2yWYChTyayT+Z9TbnWZxC5b?=
 =?us-ascii?Q?LknG6f5tacUPyktVC28SAkHwmC1vmwmbSl2UyJJptFitRBzbRhSANipJ8FSt?=
 =?us-ascii?Q?F0njzW+GkHBV3wSHnNQFfq3cZn9mxesHOFM4z8QzR7E4SF3TghdYXE7Y4hZe?=
 =?us-ascii?Q?xZHKLsETrWuDKe9HeWpjUfthxkqQYnYaynkD268RHV4PHayRyCqWiRxosmXf?=
 =?us-ascii?Q?sKhMGz3LkR6B2pvxw3P7047G3l4NXwO/75W5KnK5O4BzFxbFB71JfxYmKZPy?=
 =?us-ascii?Q?HOYkcn5d/hMBhQq/rTaa4MADvdj/WdiOl06WrG+LIa1bZWdHWEi6VgquuUtZ?=
 =?us-ascii?Q?YKPZZ0y59Oxw+ValKIF+UUwe2hwKzDXPJkODbMVscdGRSoLv8tR8PfiubbAt?=
 =?us-ascii?Q?Yw4hnExqu/ee57yTM/jcxL7J1JACURGr6GkkBhQWAmX8E//lNkshpYtK+aq0?=
 =?us-ascii?Q?Y+LLXgEi1nSQN1Cq9ko9k9UUn00pwUYS2hq+cDdodObeb+xjckHmX1hbqnxr?=
 =?us-ascii?Q?0Kt+KpnHtLm6PSWBoskU62AV62Y5FtDt00zxvreRhWS5bpBJxTnzTtdwFp8a?=
 =?us-ascii?Q?YqhkR83dYNbHGNQuMI78AXvSPWYqVSmxpSHyzxchjPt6Ph3K3qoWkXCnbEzi?=
 =?us-ascii?Q?8toikzpbZfP/y6Jf+QydBmK1t78Xfzl1hrC9rMamHvAvd2ar/mmUxJRHweCe?=
 =?us-ascii?Q?xrno+Hw2KEpenDXdOBmJa+g9jq4hTseJkCMKCD3FluoCRDAOpR8YSuDnZV9R?=
 =?us-ascii?Q?bKhCtXH6uzLEC21F5ckBp0ZZCJKhp//zUzKGvSIQ5hGfvzlngDpSYwbGgCsE?=
 =?us-ascii?Q?b5FWIx1n1mvw6zvag23i1OVv+mHpV9YR+05svM1swh7eQPmrxOob5Pm7gRwk?=
 =?us-ascii?Q?+wu+5l5EwYox5IGJNTFN/JC3/3dLWb9+4al6GTnWcawYBM2GE9kVIoL/q1ew?=
 =?us-ascii?Q?WLjPlfd8qTloIZZ1htViDGLbqLpYGMfl+FO6HbO0LvMTMQqysBnFnCDRhbae?=
 =?us-ascii?Q?ZwasMq3xFX3w/rE6+crGri5U0jhUM2JBHBNa4AE8Z+qEyvUCVesDw8eY2j9k?=
 =?us-ascii?Q?bmq5sRRHbVMo0TZuPeLKshzj/r587fO6RxGnIe3AVclhTxlhAUXE56WtsQpl?=
 =?us-ascii?Q?KQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cab19653-cd0a-4632-6077-08dbd676c0e7
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2023 22:56:13.8173
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J0XNDKZrsTLC48Z5JI7Dw7hqOomB44BqMtEfG400HSGfo5JSsa9EYvX/W9CXN1ZsKdCm+tmuNsZakqcoUWyD1SefkWmlD4JzFUjD/Vng7Uw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7295
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Ira Weiny wrote:
> If the firmware has configured CXL event support to be firmware first
> the OS can process those events through CPER records.  Matching memory
> devices to the CPER records can be done via the serial number which is
> part of the CPER record header.
> 
> Detect firmware first, register a notifier callback for each memdev, and
> trace events when they match a device registered.
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
[..]

The changes requested in patch2 cover all of the comments I currently
have on this patch, just one more cleanup below:

> +#define CXL_EVENT_HDR_FLAGS_REC_SEVERITY GENMASK(1, 0)
> +int cxl_cper_event_call(struct notifier_block *nb, unsigned long action, void *data)
> +{
> +	struct cxl_cper_notifier_data *nd = data;
> +	struct cxl_event_record_raw record = (struct cxl_event_record_raw) {
> +		.hdr.id = UUID_INIT(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
> +	};

Just do:

	struct cxl_event_record_raw record = { 0 };

...and the compiler will take care of the rest as initializing any field
automatically initializes everything else to zero.
