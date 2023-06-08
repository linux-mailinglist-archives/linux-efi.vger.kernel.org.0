Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D048727A4B
	for <lists+linux-efi@lfdr.de>; Thu,  8 Jun 2023 10:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbjFHIqN (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 8 Jun 2023 04:46:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235643AbjFHIps (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 8 Jun 2023 04:45:48 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD53E272C
        for <linux-efi@vger.kernel.org>; Thu,  8 Jun 2023 01:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686213938; x=1717749938;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=uNYFgncB9qmc8pPYyBRSgtGCHatEHmR3v8kqFoMyMyI=;
  b=IrNyj3Bv/TXncxFyYfD+H4LQXoQzmZleYn6tEianZBKrjsjq4FenqLd7
   GysDq2pomq8/abJGYeg/RHxINl+7XQxTUQkXPm6BmnqgXX8dNWkMH/TZd
   LURZiCT3OtE2FajZtO9V5g7kYVbb9Z1/E9wNVjtff2Knu9IXwSP5y+ZHp
   HLQcg7i8zRV4PvY0QodiY7NWzlIqWLLDfX9yiJGIZjNNKoyEtx3UNY7L6
   R/Sa4o76lVfFDxOmR2jcDVcJK7kqG18bvYqdMjG3vj7MbqhHgTspmF+kK
   v50A+WOA6TFUrRshiCb44NS2bxpRe3MGDBBjGM0o8ORK3vejhL8b0JFe0
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="356105551"
X-IronPort-AV: E=Sophos;i="6.00,226,1681196400"; 
   d="scan'208";a="356105551"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2023 01:43:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="703998121"
X-IronPort-AV: E=Sophos;i="6.00,226,1681196400"; 
   d="scan'208";a="703998121"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga007.jf.intel.com with ESMTP; 08 Jun 2023 01:43:42 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 8 Jun 2023 01:43:41 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 8 Jun 2023 01:43:41 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 8 Jun 2023 01:43:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ktONhZ4jQEjBEBQkZsWUhve00+j75+VptmrRft8eIL8xLJBW6Lk04pQvPusr4z/afu/yN0Y8hbXmK/dmdxrrSLS2I82Oo9bpJEewvfRmZ2bHRp+mOacKFHORd2QBnFNqwQb+wvkGKc8kadYSKkt5OsGX0Yj7ACr4tXkqWuF0LjHRzzNbbR2njxs8Vi4UuZ0BLNg+rrySf0KKt1RpRXfZ4NR4gOI87gi+uOXfAFTMbyyh1fQCVAgRZFP1vjxfrgmRBhoiozZO3bWNQS7r4Y+a7Gk+8O0hGO52KWdmxMw3iiq23623TR4YNeZVeEDGrIbEsl2lTxnIzmCBYQFRq3Ekcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w5UuFaRh3gB0jShu8OXjtxc3msEasdBuTpzHBzYLqVM=;
 b=diOSQkla5JWM2Fner0FhaIy7ya3efLMka29E5HnanxiCwCvFeG6fU/QWWaAaF7Zz5yIW/yal9PwukRn2d4b2foAuiK+BCNFOYx5tXNxkhvs7+KflUkTyZR4xUOamoCVtV3bO3Svg7nTmKm0k76etIbpVlYZPTPZqIDmmelgR94IfNyBFaqaW9V8PqZDpdda54I9EHDfexsyV1vt3Ic8xAqfzM8ZotUfgjRRSpfI2L0T0U8GK8EB/+cIaGpflHjMwrje810R24M0Zv9Ar6Dd3YBYBwAOuUSKRs5ZINGsulQuv/OO4dlnuoWiN4JfV+hVHFdVacchzKJTMgY/WW+KFQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL0PR11MB2995.namprd11.prod.outlook.com (2603:10b6:208:7a::28)
 by PH8PR11MB6974.namprd11.prod.outlook.com (2603:10b6:510:225::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.36; Thu, 8 Jun
 2023 08:43:40 +0000
Received: from BL0PR11MB2995.namprd11.prod.outlook.com
 ([fe80::d549:ec18:45ca:2786]) by BL0PR11MB2995.namprd11.prod.outlook.com
 ([fe80::d549:ec18:45ca:2786%4]) with mapi id 15.20.6455.030; Thu, 8 Jun 2023
 08:43:40 +0000
Date:   Thu, 8 Jun 2023 16:43:28 +0800
From:   Philip Li <philip.li@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
CC:     kernel test robot <lkp@intel.com>, <linux-efi@vger.kernel.org>
Subject: Re: [efi:next] BUILD SUCCESS d0a1865cf7e2211d9227592ef4141f4632e33908
Message-ID: <ZIGUsPRdeHx8u8T6@rli9-mobl>
References: <202306081655.Z7Ghy5aC-lkp@intel.com>
 <CAMj1kXE49wV0ou8jn7qZFEauioDNF2wB5hsh_se9Xsvs7MXS2w@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAMj1kXE49wV0ou8jn7qZFEauioDNF2wB5hsh_se9Xsvs7MXS2w@mail.gmail.com>
X-ClientProxiedBy: SG2PR04CA0151.apcprd04.prod.outlook.com (2603:1096:4::13)
 To BL0PR11MB2995.namprd11.prod.outlook.com (2603:10b6:208:7a::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR11MB2995:EE_|PH8PR11MB6974:EE_
X-MS-Office365-Filtering-Correlation-Id: d59ce062-124e-43f2-b938-08db67fc7531
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nmkq9wE+sKaI8kiA8MsBTp0rLasQTTqvCc2ad80lmRWdf5ilwpkEd/QHd8saNbUiI5ftfOumA+uSdfxosrfnFxZkjkzg5suNMQ2845ovYkNqvqyHM4hbgGPjuGF0RkaDhcelQR9CFugVvuFD/4sG2750kMEEv+pXIRBBplnT+Tt7t79fzHrg7V0uFDTJmY/WwOxKS/DGDFv2F8RzXF7qSuXn/8E+qCXwBbDf86Cu3y8QHX/GB3rZhVnN35PRcXhLJYwGyULNNOvx9Gz61YG71whKfiJa+JWtMqyuoicuteqSPJb9tbMPyJOZAWKsOFnboFEMWjCOPE49Lm5pr47liEUu+BPrVD6GdPLjlvQbQm1pexi+JR9kWOprA/Qo8uue2YQWoYb05OIcUJrP0m5WvAtYIpfgeiLEkH5/PSPwgXFvhMcyaBSKQ+TqXfgXDoq4p/K5uJrpSWrckEP0J7MwBhN8jnIzik6/KRvV3pK8EgDOZkciGE7nebKL3hP3nqPAnljr6AWjU3h5zSfVKYU0wJaFxfbAHpInOUT8t9jdV8PRtqVWmhIQV3ZX21K0YhVqz3h33te5H6pXmWzA5dKO4NGxe51S4DFD+KuDb2lwD+KGktAOUBrW9DEZyrnuqQaS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB2995.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(376002)(366004)(396003)(39860400002)(136003)(346002)(451199021)(33716001)(26005)(6506007)(186003)(9686003)(6512007)(966005)(83380400001)(6666004)(6486002)(2906002)(8676002)(8936002)(82960400001)(44832011)(478600001)(38100700002)(5660300002)(6916009)(86362001)(4326008)(41300700001)(66476007)(66556008)(316002)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EDPnFDNxcvahmrv9qC5PaC6X7AGVqRpFP4Ea+IiX4YFFMhpLdrUQVc82FJzh?=
 =?us-ascii?Q?4Xb2BtzamaWE9cSbZ5WJ6pDhEpLcBbkyCsmUYHdo+CRceF7nOMY6tKpENrL0?=
 =?us-ascii?Q?QXa4kb352XVYLNdQSmK2Nb/h7tWPNyzrOKWrd15rLOOBNbrU6Sov/2UisH0J?=
 =?us-ascii?Q?Axy7E/q4fU0XuoT6npplZVlQxir0nxeXEIGIvFcAh1+BK0DOx2eRtQGbAKyH?=
 =?us-ascii?Q?mX3289IiLvgTH7z0FvaQ3KE2wcclidm7w+ZKS/AbpAXL9kvNVM7v+NFx4ezc?=
 =?us-ascii?Q?P+0QY58g1F/NqM3VBpQUHqRjbrFOiFouHXy4Zc6oK844kiWXfw3d7x8E/DJD?=
 =?us-ascii?Q?v2xNm0UqINC9VvdXG/E2Wqgi8fFHFYd36dtoGZSJ069U4OaavpK9Bt48TwLq?=
 =?us-ascii?Q?CYhyL3g7ACQf93jlIel4KMI4wjVC+VsJWS6bIzHrkVHNHfdOfcQYOhIGQ3aL?=
 =?us-ascii?Q?xdl6WxfhjwkNVKUqUM7lpCMJSpy/WDwfZF77mhg0xI9dw7t+3gj5bgidk9eY?=
 =?us-ascii?Q?V9Ug86IZAfWEsPTRCcTWCOxuG2DwoX49qmwznIayP9MeG+JbTFaPdentjdlK?=
 =?us-ascii?Q?UFDFhhRiWTjXRBUvBouu/IuJhDeLw8zJi30kU4bXOrOhdBVh8Vz5XoacwJ3v?=
 =?us-ascii?Q?0knQx0SrH8k6Zrf339eRK/F1KB0WltE26DLg9dpFTcGdO/Z56CaGl5crPyTe?=
 =?us-ascii?Q?Ydg8rMaQinGQxdTx0AgmcHCJvkSptZF+nMB0detROKRNatOoV5QKsp7F8TlC?=
 =?us-ascii?Q?8bOukdyrzPDdlCLNhRK26REGbF4q49OpBAqK4p99kFWOEoGwVORHu35iDXXg?=
 =?us-ascii?Q?w+OZaxkPNQ5O4Q7VtYOynAmWoCCQYm4toI8aNbYMyyrMpJALKYgabhMwIk20?=
 =?us-ascii?Q?Cj4CptOIPOaY1M9FKDjA5ZrXUfTIt+VZ3Wl8d9AVUgQ4oLsV9wQf3UxaWyDl?=
 =?us-ascii?Q?bOk0ejGiLiSiy+qoxwEqyhYvuOV01AV2yrfvdp5RQ8GcO5UvU6Dk98NIBfHm?=
 =?us-ascii?Q?rRnczOw25Sz0v2Y81tEBVfAxXkrdfVndhEoYTOFlzao/ykKTehBvuKQB4sz6?=
 =?us-ascii?Q?QOE04ZuKKhX82JJkXQ5f2+OKr3L6ScROZRNSmcLNEjXJgkgVYrnJBEm4BkZW?=
 =?us-ascii?Q?/ZK1aMCz4qw/GTknOcNj4oW6fMWytT8YU8ay2m35p1GEnnhVTtcucdMPYCLJ?=
 =?us-ascii?Q?SsVXvrv6kPyKAOwdbaUoefvApeVMPuPf+lOGO5RgVmCGvgb8mVd5ClAfPsbV?=
 =?us-ascii?Q?1Obl1OQgs+FbYOZ/PzJgQiB29KdkyTuB+kolW/JTQvx9Vq8zAUxljomXB0sI?=
 =?us-ascii?Q?uNa/4WpqFlbdhIXsWNiDc3cs+OckVAwVZ76IpNmCEi56F4NFyMjBiKC44ruT?=
 =?us-ascii?Q?0bBX9gBMNvYb/z1Syc7mvGWOU+c03FpMAucOhP9AWCeyrHfATsxmWcf8Wufz?=
 =?us-ascii?Q?c+MMKfFrA4+naGRkezwYx1uXpd5TA5qNScD5+SL5087crqWOFJmD4y501O2n?=
 =?us-ascii?Q?t03jBzIYe7FUONC6vi+vlxM5h7phAsX1iyuJJGRkzyo/bDbA5bAZJy21T4gn?=
 =?us-ascii?Q?uOCjoqGCx9/hxWlpW2rtitottW5Zd7/p21rKun2g?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d59ce062-124e-43f2-b938-08db67fc7531
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB2995.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2023 08:43:40.1900
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7JBQdt/yRHsJW3WXzmor654GrZGjHAkBqAgOPtsKzNFvHSFP7zO+sNO2wOtuszt6ZSDz/43g0vhZuDbcfrtfEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6974
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

On Thu, Jun 08, 2023 at 10:13:06AM +0200, Ard Biesheuvel wrote:
> Hello,
> 
> As requested before, could we please stop testing ia64?

Sorry, some code path is not clean. We will fix it asap to avoid
tesitng ia64.

> 
> 
> 
> On Thu, 8 Jun 2023 at 10:11, kernel test robot <lkp@intel.com> wrote:
> >
> > tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git next
> > branch HEAD: d0a1865cf7e2211d9227592ef4141f4632e33908  efi/esrt: Allow ESRT access without CAP_SYS_ADMIN
> >
> > elapsed time: 841m
> >
> > configs tested: 113
> > configs skipped: 5
> >
> > The following configs have been built successfully.
> > More configs may be tested in the coming days.
> >
> > tested configs:
> > alpha                            allyesconfig   gcc
> > alpha                               defconfig   gcc
> > alpha                randconfig-r015-20230608   gcc
> > arc                              allyesconfig   gcc
> > arc                                 defconfig   gcc
> > arc                  randconfig-r006-20230608   gcc
> > arm                              allmodconfig   gcc
> > arm                              allyesconfig   gcc
> > arm                       aspeed_g5_defconfig   gcc
> > arm                         axm55xx_defconfig   gcc
> > arm                                 defconfig   gcc
> > arm                      jornada720_defconfig   gcc
> > arm                       multi_v4t_defconfig   gcc
> > arm                         nhk8815_defconfig   gcc
> > arm64                            allyesconfig   gcc
> > arm64                               defconfig   gcc
> > csky                                defconfig   gcc
> > csky                 randconfig-r021-20230608   gcc
> > hexagon              randconfig-r015-20230607   clang
> > i386                             allyesconfig   gcc
> > i386                              debian-10.3   gcc
> > i386                                defconfig   gcc
> > i386                 randconfig-i051-20230607   clang
> > i386                 randconfig-i052-20230607   clang
> > i386                 randconfig-i053-20230607   clang
> > i386                 randconfig-i054-20230607   clang
> > i386                 randconfig-i055-20230607   clang
> > i386                 randconfig-i056-20230607   clang
> > i386                 randconfig-i061-20230607   clang
> > i386                 randconfig-i062-20230607   clang
> > i386                 randconfig-i063-20230607   clang
> > i386                 randconfig-i064-20230607   clang
> > i386                 randconfig-i065-20230607   clang
> > i386                 randconfig-i066-20230607   clang
> > i386                 randconfig-r002-20230608   gcc
> > ia64                            zx1_defconfig   gcc
> > loongarch                        allmodconfig   gcc
> > loongarch                         allnoconfig   gcc
> > loongarch                           defconfig   gcc
> > m68k                             allmodconfig   gcc
> > m68k                             allyesconfig   gcc
> > m68k                                defconfig   gcc
> > m68k                           virt_defconfig   gcc
> > mips                             allmodconfig   gcc
> > mips                             allyesconfig   gcc
> > mips                       bmips_be_defconfig   gcc
> > mips                     decstation_defconfig   gcc
> > nios2                               defconfig   gcc
> > nios2                randconfig-r012-20230608   gcc
> > nios2                randconfig-r032-20230608   gcc
> > nios2                randconfig-r035-20230608   gcc
> > openrisc             randconfig-r011-20230608   gcc
> > openrisc             randconfig-r022-20230608   gcc
> > parisc                           allyesconfig   gcc
> > parisc                              defconfig   gcc
> > parisc64                            defconfig   gcc
> > powerpc                          allmodconfig   gcc
> > powerpc                           allnoconfig   gcc
> > powerpc                     rainier_defconfig   gcc
> > powerpc              randconfig-r003-20230608   gcc
> > powerpc                     tqm8548_defconfig   gcc
> > riscv                            allmodconfig   gcc
> > riscv                             allnoconfig   gcc
> > riscv                            allyesconfig   gcc
> > riscv                               defconfig   gcc
> > riscv                          rv32_defconfig   gcc
> > s390                             allmodconfig   gcc
> > s390                             allyesconfig   gcc
> > s390                                defconfig   gcc
> > s390                 randconfig-r001-20230608   gcc
> > sh                               allmodconfig   gcc
> > sh                   randconfig-r026-20230608   gcc
> > sh                          rsk7203_defconfig   gcc
> > sh                           se7705_defconfig   gcc
> > sh                   sh7724_generic_defconfig   gcc
> > sh                        sh7785lcr_defconfig   gcc
> > sparc                            allyesconfig   gcc
> > sparc                               defconfig   gcc
> > sparc                randconfig-r016-20230608   gcc
> > um                             i386_defconfig   gcc
> > um                           x86_64_defconfig   gcc
> > x86_64                           allyesconfig   gcc
> > x86_64                              defconfig   gcc
> > x86_64                                  kexec   gcc
> > x86_64               randconfig-a001-20230607   clang
> > x86_64               randconfig-a002-20230607   clang
> > x86_64               randconfig-a003-20230607   clang
> > x86_64               randconfig-a004-20230607   clang
> > x86_64               randconfig-a005-20230607   clang
> > x86_64               randconfig-a006-20230607   clang
> > x86_64               randconfig-a011-20230607   gcc
> > x86_64               randconfig-a012-20230607   gcc
> > x86_64               randconfig-a013-20230607   gcc
> > x86_64               randconfig-a014-20230607   gcc
> > x86_64               randconfig-a015-20230607   gcc
> > x86_64               randconfig-a016-20230607   gcc
> > x86_64               randconfig-r004-20230608   gcc
> > x86_64               randconfig-x051-20230607   gcc
> > x86_64               randconfig-x052-20230607   gcc
> > x86_64               randconfig-x053-20230607   gcc
> > x86_64               randconfig-x054-20230607   gcc
> > x86_64               randconfig-x055-20230607   gcc
> > x86_64               randconfig-x056-20230607   gcc
> > x86_64               randconfig-x061-20230607   gcc
> > x86_64               randconfig-x062-20230607   gcc
> > x86_64               randconfig-x063-20230607   gcc
> > x86_64               randconfig-x064-20230607   gcc
> > x86_64               randconfig-x065-20230607   gcc
> > x86_64               randconfig-x066-20230607   gcc
> > x86_64                          rhel-8.3-rust   clang
> > x86_64                               rhel-8.3   gcc
> > xtensa                generic_kc705_defconfig   gcc
> > xtensa               randconfig-r031-20230608   gcc
> >
> > --
> > 0-DAY CI Kernel Test Service
> > https://github.com/intel/lkp-tests/wiki
