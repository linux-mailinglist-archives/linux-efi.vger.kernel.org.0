Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C23F68A4F4
	for <lists+linux-efi@lfdr.de>; Fri,  3 Feb 2023 22:52:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233846AbjBCVwS (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 3 Feb 2023 16:52:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233847AbjBCVwP (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 3 Feb 2023 16:52:15 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 291542CC77;
        Fri,  3 Feb 2023 13:52:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675461133; x=1706997133;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=389+5oynYkw9ztsMvjARBIG6Zxsf2RY3805LFhl5sjU=;
  b=LaifdPTkV7Tmvwe7m8E96/TXIU8XbB8xfx/7xpoj6XUqDDgThim/S9Ay
   LfIbo/CtYlhm/qTMs82LqFp0zueWoJgGldtPf58Y8bCJ6riLw/CiRwWQU
   IAqSeACe6ttQ1qtsvIqe6NPrcwzeEolIzl7m4/toLqThAc6IUhN1F0ySU
   5YSoWD9wpKRVHiPadol8geAretoZ+qnY15oYZY4A0KiXBp/EFucJIuTjY
   +vZwWJvXQ9sF7a3yAgH1rXSi2CRNcilztakymMd7T3DyL8bve4PPrg+BG
   KvQRV76IBXFY48OIuXEzBYaSlbet42MPdEbj8iASxijB27Ic2cYFfoEuN
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10610"; a="312521601"
X-IronPort-AV: E=Sophos;i="5.97,271,1669104000"; 
   d="scan'208";a="312521601"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2023 13:51:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10610"; a="789833152"
X-IronPort-AV: E=Sophos;i="5.97,271,1669104000"; 
   d="scan'208";a="789833152"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga004.jf.intel.com with ESMTP; 03 Feb 2023 13:51:48 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 3 Feb 2023 13:51:46 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 3 Feb 2023 13:51:44 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 3 Feb 2023 13:51:44 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 3 Feb 2023 13:51:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f082HECG61KaPEv2xUAaSCWfWhWNgVtUQ9p87pqB+2+X/Djqwf+1EPa5C4UZbjN8Iu9efI2IP0Ksx55kCpp+jejol6tLJsAcLiwKgnR6OhAaDF5fgYkvgLyEHnUoa7mDXgUFqk6ZrqeZ6JuwhAmygqAw0FqJ42wfq7fBj7XmdBLSo4Gp/I0Qm4Yy9K+GiZU7CS+0QCHTXp5POLPH8itninaN+jJQ9p4hUnPvQfB4ibI2hHzAi5F1uoMpBCeb1fDz5KU2imcZ50a6zSAiRMM7pvruY7cjXn3DV+Nc3byWHGqwERMN6HW1iLePcf2gbzZCSzzxBiWbxCkQSe+5ZfLVWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EJPIkMDBrhEGbraq5SeB8KLZY+jh/XcW583EFtk1J7c=;
 b=Z5w02GP836q1RoTx4rYYTFhRuWeIZEMGG0xGvofnu/ForJlMwu6p3aSk/0m+JDgdaQHaMw4fgtfj8neJCzA6Qu8Vkh+ddUBAvhZk/0ZrBPieWMLLpt9kkC7kQxP3glObDv0bcxAamc70HyC37diSPWHJi/V2AGSKE66A4cMQmyxOjvTI6u7Dp7QhdulsrMjTGsDnYeyP9I8tanvvXQm7CO6oFteUJPCF4VAJf8El8pSyALTFR1ZRBBNYM1LBlKln1/tfUwNiReV5VPVVCaq+SByFtJ31glcA23MzBBfzQmBlwZNSR6XXko/ILyi5YqOeNXR7lOZMHfLFhEQTNcUJuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by PH7PR11MB8121.namprd11.prod.outlook.com (2603:10b6:510:234::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.29; Fri, 3 Feb
 2023 21:51:42 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6851:3db2:1166:dda6]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6851:3db2:1166:dda6%9]) with mapi id 15.20.6064.027; Fri, 3 Feb 2023
 21:51:42 +0000
Date:   Fri, 3 Feb 2023 13:51:40 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>, <ardb@kernel.org>
CC:     Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
        <linux-cxl@vger.kernel.org>, <linux-efi@vger.kernel.org>
Subject: Re: [PATCH] efi/cper, cxl: Remove cxl_err.h
Message-ID: <63dd81ecfd91_dfba82949f@iweiny-mobl.notmuch>
References: <167545240944.3932004.13241445887801999410.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <167545240944.3932004.13241445887801999410.stgit@dwillia2-xfh.jf.intel.com>
X-ClientProxiedBy: SJ0PR13CA0094.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::9) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|PH7PR11MB8121:EE_
X-MS-Office365-Filtering-Correlation-Id: 241afdcf-8e9b-47dc-1ab8-08db0630d62a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vGc2tjOZGZmV7lf2QQ7L4l4oyzl7nviRenqRQrI8lrIemwyyJATJRHset7S+FtaeoR88KhJuRDkcz58qcKLKZCpeF/eBsnJwCiDk7Oe5K1i7oGPKegp8OY6RehweOi/hZ8CG9Do0igKkDcKzF3P4V0ew+USKCyyfSQUPchmn8dj/WLYvge24fjZL0ZYkucwAMPzwS2lxuI46YSXGDN63GoJjQ200I0ChTBURAX/4tGvvP0iUYSc3XPkIsNoZ7dEHzwhEe8PlRzMlr9bV6CUnmWRhkQZ6k2m+aV6H44twA3x9e05DwrxDTOzK/I7ydTVLBbgXuYQL34m6IL8Gfp93jr94JzbP7HyS/irxSPcCvkJ7KV6EanaZ/ljYEwWYmWdAJ/lIjG9wmmG8v0iXHXlOBav5xDoI+LW7Rw4dmYbKI1+c/sa79xafx/IBUChYx7JnXx72K9YmiN8pfMS8Og7xu+MFa5v/xSIbxk45QySBBiU4k2ZhK29fOw9mgIsLmIB9W0GnyTHH1c6HyQ4ozwPt+HqDbkOU+4uZbxnMQnk+FiCwzYS2WxUsc+Pfm6CjWwVcqMJWDTSRNPDKRRR2fTstQlp02kjHB6ZT/72h6CIMycGheN8vEa3p/lJwKwfe9K+hy83in2pFqVDkWAVQD3d/jQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(376002)(136003)(366004)(346002)(39860400002)(451199018)(6486002)(86362001)(478600001)(41300700001)(6512007)(186003)(26005)(9686003)(6506007)(316002)(66556008)(66946007)(8676002)(66476007)(83380400001)(38100700002)(82960400001)(4326008)(2906002)(8936002)(44832011)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fAmJLUXQiY9p/x0Z99NaTVmSpceK8X2rPwtp+UgpnxkvKNEBJ9hqvlGrWqN2?=
 =?us-ascii?Q?Xo4Wcz33EN+7j1LXMCMJeYK0Fekbr129uHtGuKsrzNEbNZX8JS5A6+jyyTpZ?=
 =?us-ascii?Q?Jz28bvuRzPV7c+SfAxAi3m7RlYX+Q/InhFKtVi6aqVEViPxZJqXt3EPnmLxa?=
 =?us-ascii?Q?J+a5UcBVhugvIh99QOSq2PoV9OZKAmbgm6Mw2JhP9J9Ps+5V7dRU+RuTs7VI?=
 =?us-ascii?Q?Z80wf+P83yi7GsY3QCllO+jkJSoxbMmmRYbym9F5yeG8vgDmyy9Vx0wQ/rfr?=
 =?us-ascii?Q?/wCT1GD7UDWgtwtNr/QCZTZiEMqwujkYKEwCaYwpWUq/o7wdQmnykUq7v/SZ?=
 =?us-ascii?Q?/VnrZcGM23E+G9LEkueKLJ1zoTTMchAn+rd1CJHSfoZOjdfqlYj9JVg/9So0?=
 =?us-ascii?Q?+rl9324UujzohRrfcJBsE4ZzK7FrImLsjRAxk8BYJqKZLLiVreszY14VlSzU?=
 =?us-ascii?Q?nEfXjZDfUB9jUYzANpNS4r3P+5ISLVQlmakwSbywbjrzvITryb+WLZ0KpRC6?=
 =?us-ascii?Q?yvmHgKvLPPlDujG3/M5QMQ1s9Z9piMNqELFtAIrCo1uQa1LqjFaaBlF1cTbp?=
 =?us-ascii?Q?3BK+Yu3pI7WnhuOj+jZVIcgX53MAqYYUk2ZtzRN2R9o223LRlDhfBqZCzqUQ?=
 =?us-ascii?Q?lqwUWxp+yws4TGIi+h+7Nc0Ykvr+MlJlo8Ldb16MUUHfYLH3XDmz+9R+WjhV?=
 =?us-ascii?Q?F/usIlYYSfjbLSShvmcEw6esvh0xVNn/GJ8sjp0GpaGKFb5s1R8hFYnvzD/J?=
 =?us-ascii?Q?XXWlHEDCt+tSXhujSkdxb3KJ0zzhp1cByZ3A9xaPeM0LNNU2fGQIy8bsOxE7?=
 =?us-ascii?Q?uKSJupR31RPMFe1LSdSQNuxFxcyOxfscvN4pBkzYxFAD/vWZOW2J1FJhHB2r?=
 =?us-ascii?Q?3gd10cS1xHcn6OZCok9wZfqg8qQMQmcieio+hbywOhTc024c/KTaknjch0Tm?=
 =?us-ascii?Q?D9OMRlY8toWxLeVx9uMeS6PJKrYTcyf5KJmB3YVqqBauD0KamMdJjVYolAA4?=
 =?us-ascii?Q?AzQHG5foVMu/BOTWpPgfYCXwdgUIp+XdWgEdTYqT/ziOsUXzBx+XtCU/IMd8?=
 =?us-ascii?Q?KPEbCZhFqDjvJvGp7BXA3vQGDzG8QgqLdqqgOIVfGNJ/LvCaGVtPYR0Z+8yc?=
 =?us-ascii?Q?kMDWTJILl6Pa8Y2rZal1fgF2cdIi0YEWMCTNNDwB89DnC1y0wZHRkSm2Iq+d?=
 =?us-ascii?Q?qAaVCF4yCixZVySOg6yTzTak4mWzh5NBzHlS7suVfdhRbqyS4HQoSbKC8BD7?=
 =?us-ascii?Q?mcVIgxZD+N3ui1vKyvXiyLOivwhu4GLAiNgzAcsZNM0fphuo2ouDljBYba3q?=
 =?us-ascii?Q?3m7qcT7g2Q5a/cpm9icTiOr2Xb5J+PpueYDvqGheu/7DdB8nIVh6gmQuv4uF?=
 =?us-ascii?Q?/wx1bFBoFRl0K5rRSe/fhgAzZIB4jyVjJbJcjuigKbklCudClPQ2+lnqUwVd?=
 =?us-ascii?Q?sV8/PIVTass/7WAUM71l8dSojYV46+ZGTAwVKpK0MDoDLL1EpHtM4KlyiyAz?=
 =?us-ascii?Q?6sUtwQcQ1oEghtp91m2HK5+AjTeOEgqlw/zftJleY/toGrqczKOCriQAo4Xb?=
 =?us-ascii?Q?IfVI5vyUQCSzXU4xaOFZI5+35+mzJY04liqoUuA/?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 241afdcf-8e9b-47dc-1ab8-08db0630d62a
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2023 21:51:42.6524
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M7ucOMrybKZr+4eMI3Z/AHHaNwH7EGFDHTbWKDlzRZLhqpYlpF5XTmPiIyQ2SOumsJ7UKkTEfiO9YdnStfggUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8121
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Dan Williams wrote:
> While going to create include/linux/cxl.h for some cross-subsystem CXL
> definitions I noticed that include/linux/cxl_err.h was already present.
> That header has no reason to be global, and it duplicates the RAS
> Capability Structure definitions in drivers/cxl/cxl.h.

Change looks fine to me but I'm failing to find these duplicate
definitions?  Without any duplication it seems like stronger change to me.

> A follow-on patch
> can consider unifying the CXL native error tracing with the CPER error
> printing.
> 
> Also fixed up the spec reference as the latest released spec is v3.0.
> 
> Cc: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/firmware/efi/cper_cxl.c |   12 +++++++++++-
>  include/linux/cxl_err.h         |   22 ----------------------
>  2 files changed, 11 insertions(+), 23 deletions(-)
>  delete mode 100644 include/linux/cxl_err.h
> 
> diff --git a/drivers/firmware/efi/cper_cxl.c b/drivers/firmware/efi/cper_cxl.c
> index 53e435c4f310..a55771b99a97 100644
> --- a/drivers/firmware/efi/cper_cxl.c
> +++ b/drivers/firmware/efi/cper_cxl.c
> @@ -9,7 +9,6 @@
>  
>  #include <linux/cper.h>
>  #include "cper_cxl.h"
> -#include <linux/cxl_err.h>
>  
>  #define PROT_ERR_VALID_AGENT_TYPE		BIT_ULL(0)
>  #define PROT_ERR_VALID_AGENT_ADDRESS		BIT_ULL(1)
> @@ -19,6 +18,17 @@
>  #define PROT_ERR_VALID_DVSEC			BIT_ULL(5)
>  #define PROT_ERR_VALID_ERROR_LOG		BIT_ULL(6)
>  
> +/* CXL RAS Capability Structure, CXL v3.0 sec 8.2.4.16 */
> +struct cxl_ras_capability_regs {
> +	u32 uncor_status;
> +	u32 uncor_mask;
> +	u32 uncor_severity;
> +	u32 cor_status;
> +	u32 cor_mask;
> +	u32 cap_control;
> +	u32 header_log[16];
> +};
> +
>  static const char * const prot_err_agent_type_strs[] = {
>  	"Restricted CXL Device",
>  	"Restricted CXL Host Downstream Port",
> diff --git a/include/linux/cxl_err.h b/include/linux/cxl_err.h
> deleted file mode 100644
> index 629e1bdeda44..000000000000
> --- a/include/linux/cxl_err.h
> +++ /dev/null
> @@ -1,22 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0-only */
> -/*
> - * Copyright (C) 2022 Advanced Micro Devices, Inc.
> - *
> - * Author: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
> - */
> -
> -#ifndef LINUX_CXL_ERR_H
> -#define LINUX_CXL_ERR_H
> -
> -/* CXL RAS Capability Structure, CXL v3.1 sec 8.2.4.16 */
> -struct cxl_ras_capability_regs {
> -	u32 uncor_status;
> -	u32 uncor_mask;
> -	u32 uncor_severity;
> -	u32 cor_status;
> -	u32 cor_mask;
> -	u32 cap_control;
> -	u32 header_log[16];
> -};
> -
> -#endif //__CXL_ERR_
> 


