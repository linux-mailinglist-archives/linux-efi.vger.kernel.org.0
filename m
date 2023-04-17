Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 882636E54F9
	for <lists+linux-efi@lfdr.de>; Tue, 18 Apr 2023 01:08:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbjDQXIW (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 17 Apr 2023 19:08:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjDQXIV (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 17 Apr 2023 19:08:21 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C199A3A92;
        Mon, 17 Apr 2023 16:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681772900; x=1713308900;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=yAEAgwMwgRMbEcRqLvpigCwM42Nkcw9n84AzIC2OBDE=;
  b=HbZ96MGfuGDK3s51g1/2MVYkBwVbY8m4wrU9IiU4QRrx2+BNuviKgl7n
   vWZkelrjOrMhsKXB8jfsafTPG+szHuWsR8UkgiaJsuH/gTkQafAa5uz7Q
   eAj2yuMDyioTYtrd/mvigCSmYctRxfMivWPjmPXnh+Ylk/eD2EZeyV9wg
   tZPix8/gcuK3S5ms0AlP2PH2xysuQtC9oJmdsOQrN2Ur8P1BGOuW28tmc
   HwPk9/YbyBjrQBwecoI2hqgqTtC9QB70IeZ97ERxdJEbftmblKVjgrKza
   pcSln4iRkXjYXzjBDgBwKI5UMpt1QbYfRWpSzaF4ebI91DV/oqc7yLHIb
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="342523930"
X-IronPort-AV: E=Sophos;i="5.99,205,1677571200"; 
   d="scan'208";a="342523930"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2023 16:08:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="690863274"
X-IronPort-AV: E=Sophos;i="5.99,205,1677571200"; 
   d="scan'208";a="690863274"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga002.jf.intel.com with ESMTP; 17 Apr 2023 16:08:20 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 17 Apr 2023 16:08:19 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 17 Apr 2023 16:08:19 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Mon, 17 Apr 2023 16:08:19 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.45) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Mon, 17 Apr 2023 16:08:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DWG0tnAmtRxwr68QGH0gJ+H0sNIck25VoGSNXqyki9EHkbtlQGFAvtObiuj9kwDL1lb1x8Yb3K0mHPlf6nTgADDaQ/UPbWIBtr5XRK8LJQqFXrbs482wake/18MOTcRpv8oMfp+78Gg8cMVGvrVNzxYAzK/CiJBoG9T7VQXspztfg+JFU7Nj7U05BcTIIdKFrQ1yyhCjfN54DGddLm05WZSQm+9P4B7za5qOtuqqSBeRRdfSmWh4gKBo4cMnMu9Q5u0mnenRpss6Kl2aJKeXDdLhqYFHdwsvU6CTqLsYkcFqbBJBQg73ibmoJg95O7Z3op+fApDM2fw7JrgCyxvfBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mmapHKzpuFDAQvHz268ZalA380EB3dv/M3eshGaXtzM=;
 b=GQhWQerbbgi5bhHqMOhftnPmrLIiwfKy+eENuupYQ+XXdLZ1OLMnXo4UegFmneZIv/alQ2Qwi9rjaopK0jXp3P3OmMX/S4n6URRweqp7eVhh8F61TqHWIP3b9Jv1W/SLC3QYphHwO1G+HIIR6kV8YgetYeHbHdPvud32vadE1OQanCbc+oMkyRc+na/h7uqj4G4Hw+lF9dZfJhXFZJtU9puzEAHDI7G4YI3cnwxh4MqL6H0bNZoqMLncd/jHYzZEl9jPTauTHfE/lmF7Me+0TQLqN+vcmd1Yom1ziR1fzVssiTi5Xg13CScICkPyDLLbLhMkvyeFTL8GHJVQPjV/rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH7PR11MB6723.namprd11.prod.outlook.com (2603:10b6:510:1af::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Mon, 17 Apr
 2023 23:08:17 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::ffa1:410b:20b3:6233]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::ffa1:410b:20b3:6233%6]) with mapi id 15.20.6298.045; Mon, 17 Apr 2023
 23:08:17 +0000
Date:   Mon, 17 Apr 2023 16:08:14 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Terry Bowman <terry.bowman@amd.com>, <alison.schofield@intel.com>,
        <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
        <bwidawsk@kernel.org>, <dan.j.williams@intel.com>,
        <dave.jiang@intel.com>, <Jonathan.Cameron@huawei.com>,
        <linux-cxl@vger.kernel.org>
CC:     <terry.bowman@amd.com>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>,
        Ard Biesheuvel <ardb@kernel.org>, <linux-efi@vger.kernel.org>
Subject: RE: [PATCH v3 2/6] efi/cper: Export cper_mem_err_unpack() for use by
 modules
Message-ID: <643dd15e9bb8_1b662943c@dwillia2-xfh.jf.intel.com.notmuch>
References: <20230411180302.2678736-1-terry.bowman@amd.com>
 <20230411180302.2678736-3-terry.bowman@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230411180302.2678736-3-terry.bowman@amd.com>
X-ClientProxiedBy: SJ0PR13CA0016.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::21) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH7PR11MB6723:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a96a417-ae18-4a0e-c381-08db3f98a09a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IhY63UICuxXDc9PaGkDW9/KZq/QyE94bXCf4nz0AaEcPSbHAitHD9CB5IqMVPS0cDqN2lmGr1PqB9tq4pk6T67cMwoopDg/k5qQVH3wIx1FntSieZQSFwSY1aDy2/u0bIGYBoK22KgHc4cfyaaCnvg/gQPOzIb3aekqK6LJJRmkdxvuJSVEhYO1ZhzMN+V94vRgiE0+Igzx620v3NmMnYHj3ina8v2al7wNHyteHVN0JXh2cFQ2IiT7NW9uDD7rs+reED68GDD8iWlS/qBX4q+ffQOhOshX1fkklYdFlVyQD29KHgO38Gehhl5dTsLON+Zk1v94dXHJdiPSF9kAe2K4qmju4KNr5NHOV+o9Uq3DgrGVdbU/aHiwEVk6Zv6qcOi8zcVeLAG0tG18saD2u1MUyezIOfylXmX3YI1ek1bxW3hcwgPvPsSpsbrAYvs4cBdoUf2vHLxra3AZm6E3TPSVMSJUVcpQKwsGZeNj4ve9/HSvheEz4Knz1gM2MDajYwPtrtjwOKFToZerdUWTT6vi6L3mGIQv4dB8L4ZPF6M9qBPaVcWbbBooaVPaf7SDf
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(396003)(376002)(346002)(39860400002)(136003)(451199021)(4326008)(316002)(66556008)(66946007)(66476007)(6486002)(478600001)(6666004)(41300700001)(5660300002)(8676002)(8936002)(2906002)(86362001)(82960400001)(38100700002)(6506007)(9686003)(26005)(186003)(6512007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OeUZVCF4gkajZiDcku7PIH1wAV9sEppQBnzWNI/uv1hMmR6BPjL3N2VkFHn7?=
 =?us-ascii?Q?C3pnQjSS+hT0TLYLts49UEclXWyYj//1LszOUmyDnnJ7CCf2eb4nmHtXtQX6?=
 =?us-ascii?Q?pIZcqVWvPic6JNCrp09WEnbtKPmDJN0D6awZJ+pjozytI4iwXtTDJ/Yj2NnV?=
 =?us-ascii?Q?RW+wa4p4o2E0oWOjCP8vLVBY6jTxkpo4d4q5girupzR4izQUqwzSO5msME36?=
 =?us-ascii?Q?RsLagWJfQ4QTVAqDqeINEjGdtSdYi+valOK6U8cX4U7zOAtn5ILLVNwlINKM?=
 =?us-ascii?Q?CKZdTxqx9WwxE1kwBfBBfsPMXcfNohY8uZwn0fc95xxzSt0yoEOOnUOFltxU?=
 =?us-ascii?Q?DuRJtNWQZbpd2LVJNGw/LSjwyDpV98skbWgWmH+M6RHnzqaVgS98c4sV+V9h?=
 =?us-ascii?Q?k3RAgl7s50jhx2fdWB6559ewYIzgeKwFT+22Llb0y1pkV5jeUNQxyrYKuv51?=
 =?us-ascii?Q?E3Lbt7aLSA6fRYfWWWXzL/sgKaDkMmXxJl8D4j5ggr4VFP46f5WQ6HO7Pxks?=
 =?us-ascii?Q?L9k7svjMkndcHJXjLdpZxzGyBvnFMdGkEnxa6qZ1XQ8cY1MnjCPvHYFxMnUu?=
 =?us-ascii?Q?+aRvK816ti42mcnQIxuv2rxLDBHAP+wRpEhvgkEEQRIEIDrlqSVMwz4kcYR2?=
 =?us-ascii?Q?i8gk/mrnqZpQS/F5JzJVbW3sp6fZxnD0SvxOigiGv93CI7go5Km26lQg2lxw?=
 =?us-ascii?Q?WQeaYiF6II+8RUPmpLV4ZxGKzjI2ZYOscoYOdx3OatwXSnG1bdxq/kq5+Xm+?=
 =?us-ascii?Q?KSvzhzDthgfUGswpB9n266gVqlsPjwOl49yMHUcv7q/oJZSf3nH5R76AhM/o?=
 =?us-ascii?Q?zZ2OpLKidUVEsVSl/1T8/oZQBHrzra4q6CiBNevIqk42QmrMc8+RXy4NSN3u?=
 =?us-ascii?Q?WtkC2St3UPJQqTa3XRDqDx99ntp9Xy9DNNMEUnGwEO2bB9WUECTkuDXaz9h9?=
 =?us-ascii?Q?LsnQJMx76FD39cnYjPgy7sUSIPGTM+w+lbMBfHNdHsRAjPBIUKJD51fcgEj0?=
 =?us-ascii?Q?b4Yer49F0pMwL1I9UH18D3wCxOZxQvHOmow5e50C7kgvRdtOuc7WA8pH1tl/?=
 =?us-ascii?Q?8zOVwILjjP7guZ5RAzrmDxyk6DLWgV2wof2xZ6dVpDq2j1M6eHef5DgF1+ck?=
 =?us-ascii?Q?el9Hot7eghfnjWgJ7KcII5iYDfqVHgNwXHNnP4W9MyGzV4JS/X8GKBAxxe2+?=
 =?us-ascii?Q?31va8OFim/Q/VHRm7Zwjl0pZMQhtaLRNuF9h9wqX3YLAq4hfCmDpO8+aK1rf?=
 =?us-ascii?Q?53Ldd3MYvqjAgvLLs0/Zl9B4wUTFtSLCH4NX+ienArQY1xzRItuUIf9k9cJE?=
 =?us-ascii?Q?o64sFH+dd35oEs31LUdbmpQTFnPXu4MPM+1I5h0UU2JVh9tAz9W5khL/T2Ho?=
 =?us-ascii?Q?DC4BJzc/EIlvaMQZSi6sCyyF6BbfP5SrFlgak0KKr+jUTCM5uMXrFZfdH1em?=
 =?us-ascii?Q?taq1XGIg2N4rPw/Rb+ze10MP9o2f8AMfHysjQT8N7wl4egl9LxLvzR3ZOBWk?=
 =?us-ascii?Q?h8N8efV6fPQ80awvTCiyuL4+ZeQ2GtYVpxUJ09lg8cqIg4x4w053Ef4i1tYE?=
 =?us-ascii?Q?RwR6eIhUeARmsQAzZm69UXVtuaaEsIJXXbuAJ52LyU4dk4kbzUiY3+M5pLkU?=
 =?us-ascii?Q?cQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a96a417-ae18-4a0e-c381-08db3f98a09a
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2023 23:08:16.8697
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tofIBWR6c4PNixwJIg3lzA3n7jxF8IqWgAeOsUqkcM8JPIuQrNFi0CtVhC+K5V5NGxOF9IbqYRz2wcBb9aZuvaSUZK+NT21kxJURHgICDHo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6723
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Terry Bowman wrote:
> The CXL driver plans to use cper_print_aer() for restricted CXL host (RCH)
> logging. This is not currently possible if CXL is built as a loadable
> module because cper_print_aer() depends on cper_mem_err_unpack() which
> is not exported.
> 
> Export cper_mem_err_unpack() to enable cper_print_aer() usage in
> CXL and other loadable modules.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: linux-efi@vger.kernel.org
> ---
>  drivers/firmware/efi/cper.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
> index 35c37f667781..ff15e12160ae 100644
> --- a/drivers/firmware/efi/cper.c
> +++ b/drivers/firmware/efi/cper.c
> @@ -350,6 +350,7 @@ const char *cper_mem_err_unpack(struct trace_seq *p,
>  
>  	return ret;
>  }
> +EXPORT_SYMBOL_GPL(cper_mem_err_unpack);

Looks ok to me. You could make it:

EXPORT_SYMBOL_NS_GPL(cper_mem_err_unpack, CXL)

...to make it clear that this is really only meant to be consumed by the
CXL subsystem. That was also the approach taken with the otherwise
internal-only insert_resource_expand_to_fit() symbol.
