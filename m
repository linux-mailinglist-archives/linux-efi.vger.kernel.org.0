Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 400E37AE5BB
	for <lists+linux-efi@lfdr.de>; Tue, 26 Sep 2023 08:23:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233807AbjIZGX0 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 26 Sep 2023 02:23:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233825AbjIZGXX (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 26 Sep 2023 02:23:23 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62C1519A;
        Mon, 25 Sep 2023 23:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695709390; x=1727245390;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=z4zd7PyHM8fr0FWB8xLDeORPF+nQEScpeOVJlNu7GCQ=;
  b=Gz/cF1LVgazRDOvg1Te6mqz/t+8qA3C+IG9Ep4gu3BwVpYPObVbbq93+
   FUaGZqKYzuH0KeU54p15EDl6/7GXE+R4Kwv00TFyvand1Ak8UXCZytf/M
   s0dnAGvAAqLMpKxDoKclM04sM4UpfGzi4aqxe2cbJrKM5uqGMWZy/M0Is
   cvPwET+kHBV3Fgh4SMbPEUHw0NLxQrWVnpZZKEC2mobWmkx/wzmIFNaRQ
   FNyf6H+dU01gzz6DH7tsZei6wlvanAoAUQmk6RAcu86g5oxLDeLGgekjT
   DOenxHZiB1HPzlR8y8+RprbMrIrwAbTGWERdK6HKhMDQhoYKKiic0Swop
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="371831013"
X-IronPort-AV: E=Sophos;i="6.03,177,1694761200"; 
   d="scan'208";a="371831013"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 23:23:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="814356050"
X-IronPort-AV: E=Sophos;i="6.03,177,1694761200"; 
   d="scan'208";a="814356050"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Sep 2023 23:23:08 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 25 Sep 2023 23:23:08 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 25 Sep 2023 23:23:08 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.102)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 25 Sep 2023 23:23:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hmRVKoHIEn0sE50Us/mhR/d4TiqOs+qBDKsBdXJboRYLhh7UMKirWugtNJz60oiLk/g8lcrR54kwCEYSFU17K2mykDCEvdXZcuq77a6DMZ0Hw7Xd7ZqtzWaUzE4hMb009HjW4Gkyq1dspq91v2xebRHyr98AerUR3NPPWIVN6Az6v1G9WYSVfmvGfadvzox9KQ9+LEsUgoZuXMSDuqNqenplUEezLLHwwor0EfnK2sUt8cyGVr6apgG5Vkw//X8VK9mY45qFtyhChkc838PfFGSSn1PzoTxwXBtkHbLkWLJk65CgZOsdpbr8BlUulKuQCXGuK7WXcuL1P4eYurztug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I6RUb1wdNBd63EUg1/3JvXp+YYwZ6wtjQw7v9yMgBRM=;
 b=TCphy5j+l+UeE3XPNcjhr9lsWooBgF/36SYN7zCSmXk4OdJE6FYFZactlom7OQUS7e3A92AbxZfsEe6FRo9W+HiLh6sy7SjGzdwr6JHnVObFkiqyb7Z8jXyqN020GIxGyyPmdFgqFGBqZXWo3GgDPBZyz/q94cA+ShwJnxwNGjmndwDi/QVD7j6yGGGj1BTJ6sSEPVUi+JJZFEuKcoouRfCSv8HXCeB3JHtzd/BCZYnnFKpsUcDY8DzCItZHn6aEMTYiqJyWI7+HOov2IZHkrh6aM2HjvBLCgRsmGS2Jk6urmBpFxKTCKQtcUg5klGISbnuYJduo0A6lcS8+V80Hng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15)
 by MW4PR11MB6934.namprd11.prod.outlook.com (2603:10b6:303:229::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28; Tue, 26 Sep
 2023 06:23:05 +0000
Received: from CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::d35:d16b:4ee3:77e5]) by CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::d35:d16b:4ee3:77e5%7]) with mapi id 15.20.6792.026; Tue, 26 Sep 2023
 06:23:05 +0000
Date:   Tue, 26 Sep 2023 14:18:06 +0800
From:   kernel test robot <yujie.liu@intel.com>
To:     Xiao Wang <xiao.w.wang@intel.com>, <paul.walmsley@sifive.com>,
        <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>, <ardb@kernel.org>
CC:     <oe-kbuild-all@lists.linux.dev>, <anup@brainfault.org>,
        <haicheng.li@intel.com>, <ajones@ventanamicro.com>,
        <linux-riscv@lists.infradead.org>, <linux-efi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Xiao Wang <xiao.w.wang@intel.com>
Subject: Re: [PATCH v2 1/2] riscv: Rearrange hwcap.h and cpufeature.h
Message-ID: <202309201921.GvBmYK5q-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230920074653.2509631-2-xiao.w.wang@intel.com>
X-ClientProxiedBy: SG2PR01CA0189.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::15) To CY5PR11MB6392.namprd11.prod.outlook.com
 (2603:10b6:930:37::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6392:EE_|MW4PR11MB6934:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c4f5e02-2df5-4e9f-d087-08dbbe590b58
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CIAtVLuFx0LzHs83Za9glylTXT3t5WYRaVkiowcGWIK5EW/VDC5SEdLoVeFcac+txEyyeyuXmQGhcztNwBqavaP2E49YhHI1IgJWQZ6B7JXIpEsDSLGOVNgzwQdVsdi3Ym1gpFnNPz3dG5848b618Jc0qd864IJEN18/BPcG4wMN3M4WLj0VtJITol4Yyy8WkVYoFlmNS6APhAPJyE4eSmT2VbXf58J1YVKWpKrdBNIOBK/4CY2HoohJ3LSio9vsDD79q96ylqlbh05HFuxeqUgcnAf8wddz87KOjM5ZJnVnZ+MGUuauF+iKquxGqGZorjX6pcq7OK7iPBdUUHofUEOecDRuT0UxlsXXWNI98wkOqu6PPRRl7wCBgoc77einnmzKDpk1zNo/fqi2F8KCz+d9QkW2x0Pvn7Sg73l7++mFB9/+s8GE3X69d6nMJ0e/nAi92m2aZHE/BUgDYw7SYUgnFwZ0dqOMgmSHkP4VfOe2gM1uvhdHrWW5dflusDXPAGPtGTPQZDJnj1GN6wdgaN5rwMzc5k5EWkCjrmoZVSeqrfyrlBh+dPgSvnxDsisKxNeLLi9NISUD4K8S3WFOCQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(396003)(366004)(136003)(346002)(230922051799003)(186009)(1800799009)(451199024)(41300700001)(6506007)(83380400001)(38100700002)(7416002)(66946007)(966005)(66556008)(5660300002)(316002)(66476007)(2906002)(478600001)(6512007)(82960400001)(4326008)(6486002)(86362001)(8676002)(1076003)(8936002)(107886003)(2616005)(26005)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Lgys7eGXcfYHQcB5A6+xKRD+PQOOVyUETwEcaG7OFhCVzR3kws6ovLjLjVlu?=
 =?us-ascii?Q?U1w1LhMu80WH5QKRVSMupFsZWMfemyJgLM05G3PVr+9A9aJQ1j1fU6owsXJX?=
 =?us-ascii?Q?SHI/L7efuS/StVqh7UJmTzUcg3AeiLq15spbd4j1vuf/vJdJi9sliQEsfdXK?=
 =?us-ascii?Q?jZRlJ7vYrQJ5y5Io6ZFDm1zCTqP7T/ZDhQ57lDohqnsvfU2QoGvA3F77+v6R?=
 =?us-ascii?Q?x1WtD71tsVWusyWuM0RPiWAo/Sg3GK5ZfvasJRfqG+Z6Fv0QzGyGzSYbOege?=
 =?us-ascii?Q?tSd9qdW3e18M0AMhAMacIpD2j2bMHn9AfEuJi7EBPFK5a1JYD+KiR6Dz4ajp?=
 =?us-ascii?Q?upEUxvzvdc4rLCLB+E65y0o9/gbr6/TKH1Q03bMIJZnzxESAz8eGk6NwuOV2?=
 =?us-ascii?Q?Ehv0VwDNCYgLzD+zEYP+J7Aokz+bC3uj1E6PqLl2q0/UJ+Mzc2wknsFE7/kd?=
 =?us-ascii?Q?LBD5n1Zo0Pvd8A0DMon6w/N51rN9W1pzMMMXf/7AlqB33439heVyqWGSZ3mH?=
 =?us-ascii?Q?m0NgmJpJmjTeT3KKd6sqi//hIhnosT4g/N1c0tA4TJdMwxfFenIVZc1HS754?=
 =?us-ascii?Q?O6DsjyNQj5Td8norvyJcG9Fu99SAxGxUP8Ag8i95huPhhbTCJzBGZlgPFRqz?=
 =?us-ascii?Q?LFocUUS4MFHr1EmKvozA/Db840LmdpAGs4uM3EWTMZAtVIr0krlaKk0+8yz7?=
 =?us-ascii?Q?HC9rbNQoOsVagbVwrCtMgrieBX/fUsT9F3vuF6wtHSevhOAdMcrCvZLZn4mo?=
 =?us-ascii?Q?iHZGU4O82M3vsxq7GCNPqSx1BqV7NswLe1rktKxHDLWVn08F9NmoRmf4Lv4H?=
 =?us-ascii?Q?pLZfRkyj/FcED/XXHWtn+1MqeMjLZqDD3JGIrizm+W+TbEnqfhiAV4L/W306?=
 =?us-ascii?Q?fWfZqNzsYbFe5KdKNGx/3kffaUrOXnuHFwaooQOmK4U2oY9bA89gLhP+U/3u?=
 =?us-ascii?Q?Q1a3IB/VXfB4JTpQIAgZpe8Yn8ZBC26MhnTb9gciXf9q/Le7LeVJCN0HPTn4?=
 =?us-ascii?Q?5uRVnHRhNGKC0GGyq3mDeaJu1E5sjt2Ume1ArMiQG7MuL757aITYbQIdqjHs?=
 =?us-ascii?Q?p1AWhxnQXx8tnF0h8EB8BDMdX+C7bXptu4PYehJ5XpmFATFtv/Ig8jpImTjg?=
 =?us-ascii?Q?uObdgGHYpDKFcpooMlLPg+W77yFyJW/PhEfkCnbnSpPqnDqJLem5cgIQFlvP?=
 =?us-ascii?Q?Pomitn7AXXhSI1R+RHW/q5rkf2cqwKnyMGrycB1Q7VnttVmZNK6v/HiP4mPq?=
 =?us-ascii?Q?ZfbddY8UGckkhzqUKuqXZ9puC+FJqwoiNY8EGr3gYtS+ULp6p6KqUSVIfkYn?=
 =?us-ascii?Q?Ssg4ubasCNEU4KuIW4FJMg/B3i8HB/Otsy2ekg5HatYsSiwHu/96/8XL1EVk?=
 =?us-ascii?Q?O6LvN2Sho1WaMwb4wdEreH2dKuR+/F7bmf7f1zwLpnEahaDdj2aQKUj10Ye0?=
 =?us-ascii?Q?AGt7g07GF75WvaZxQhyzmmOS6NN+DeeR2mBNfBkR5cBuV3OnxVzjHzumRMPX?=
 =?us-ascii?Q?vSADgu/SpDZQSU/eVRcK/MmRDMovW1SpuXFH8N4+Ez3QWw62kTT/tnOkQElW?=
 =?us-ascii?Q?MxTCCpIw/urh/FP6yW4zLNnsVrzR/QJRZFIhVLrg?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c4f5e02-2df5-4e9f-d087-08dbbe590b58
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2023 06:23:05.8244
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kADm1L6IEu2iMNpihMD5zXym0yv3Y2/qxlUZwIQL7IJu/i31jE8TDdJ92Ts9t4Fm2rL/N+Frwwyaq2jUfYjxDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6934
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Xiao,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.6-rc2 next-20230920]
[cannot apply to efi/next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Xiao-Wang/riscv-Rearrange-hwcap-h-and-cpufeature-h/20230920-154024
base:   linus/master
patch link:    https://lore.kernel.org/r/20230920074653.2509631-2-xiao.w.wang%40intel.com
patch subject: [PATCH v2 1/2] riscv: Rearrange hwcap.h and cpufeature.h
config: riscv-rv32_defconfig (https://download.01.org/0day-ci/archive/20230920/202309201921.GvBmYK5q-lkp@intel.com/config)
compiler: riscv32-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230920/202309201921.GvBmYK5q-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <yujie.liu@intel.com>
| Closes: https://lore.kernel.org/r/202309201921.GvBmYK5q-lkp@intel.com/

All errors (new ones prefixed by >>):

   fs/binfmt_elf.c: In function 'create_elf_tables':
>> arch/riscv/include/asm/elf.h:70:25: error: implicit declaration of function 'riscv_get_elf_hwcap'; did you mean 'riscv_fill_hwcap'? [-Werror=implicit-function-declaration]
      70 | #define ELF_HWCAP       riscv_get_elf_hwcap()
         |                         ^~~~~~~~~~~~~~~~~~~
   fs/binfmt_elf.c:248:31: note: in definition of macro 'NEW_AUX_ENT'
     248 |                 *elf_info++ = val; \
         |                               ^~~
   fs/binfmt_elf.c:260:31: note: in expansion of macro 'ELF_HWCAP'
     260 |         NEW_AUX_ENT(AT_HWCAP, ELF_HWCAP);
         |                               ^~~~~~~~~
   cc1: some warnings being treated as errors
--
   arch/riscv/kvm/main.c: In function 'riscv_kvm_init':
>> arch/riscv/kvm/main.c:73:14: error: implicit declaration of function 'riscv_isa_extension_available' [-Werror=implicit-function-declaration]
      73 |         if (!riscv_isa_extension_available(NULL, h)) {
         |              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> arch/riscv/kvm/main.c:73:50: error: 'h' undeclared (first use in this function)
      73 |         if (!riscv_isa_extension_available(NULL, h)) {
         |                                                  ^
   arch/riscv/kvm/main.c:73:50: note: each undeclared identifier is reported only once for each function it appears in
   cc1: some warnings being treated as errors
--
   arch/riscv/kvm/tlb.c: In function 'kvm_riscv_local_hfence_gvma_vmid_gpa':
>> arch/riscv/kvm/tlb.c:18:25: error: implicit declaration of function 'riscv_has_extension_unlikely' [-Werror=implicit-function-declaration]
      18 | #define has_svinval()   riscv_has_extension_unlikely(RISCV_ISA_EXT_SVINVAL)
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/riscv/kvm/tlb.c:31:13: note: in expansion of macro 'has_svinval'
      31 |         if (has_svinval()) {
         |             ^~~~~~~~~~~
   cc1: some warnings being treated as errors
--
   arch/riscv/kvm/vcpu_fp.c: In function 'kvm_riscv_vcpu_fp_reset':
>> arch/riscv/kvm/vcpu_fp.c:22:13: error: implicit declaration of function 'riscv_isa_extension_available' [-Werror=implicit-function-declaration]
      22 |         if (riscv_isa_extension_available(vcpu->arch.isa, f) ||
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> arch/riscv/kvm/vcpu_fp.c:22:59: error: 'f' undeclared (first use in this function); did you mean 'fd'?
      22 |         if (riscv_isa_extension_available(vcpu->arch.isa, f) ||
         |                                                           ^
         |                                                           fd
   arch/riscv/kvm/vcpu_fp.c:22:59: note: each undeclared identifier is reported only once for each function it appears in
>> arch/riscv/kvm/vcpu_fp.c:23:59: error: 'd' undeclared (first use in this function); did you mean 'fd'?
      23 |             riscv_isa_extension_available(vcpu->arch.isa, d))
         |                                                           ^
         |                                                           fd
   arch/riscv/kvm/vcpu_fp.c: In function 'kvm_riscv_vcpu_guest_fp_save':
   arch/riscv/kvm/vcpu_fp.c:39:56: error: 'd' undeclared (first use in this function); did you mean 'fd'?
      39 |                 if (riscv_isa_extension_available(isa, d))
         |                                                        ^
         |                                                        fd
   arch/riscv/kvm/vcpu_fp.c:41:61: error: 'f' undeclared (first use in this function); did you mean 'fd'?
      41 |                 else if (riscv_isa_extension_available(isa, f))
         |                                                             ^
         |                                                             fd
   arch/riscv/kvm/vcpu_fp.c: In function 'kvm_riscv_vcpu_guest_fp_restore':
   arch/riscv/kvm/vcpu_fp.c:51:56: error: 'd' undeclared (first use in this function); did you mean 'fd'?
      51 |                 if (riscv_isa_extension_available(isa, d))
         |                                                        ^
         |                                                        fd
   arch/riscv/kvm/vcpu_fp.c:53:61: error: 'f' undeclared (first use in this function); did you mean 'fd'?
      53 |                 else if (riscv_isa_extension_available(isa, f))
         |                                                             ^
         |                                                             fd
   arch/riscv/kvm/vcpu_fp.c: In function 'kvm_riscv_vcpu_host_fp_save':
   arch/riscv/kvm/vcpu_fp.c:62:49: error: 'd' undeclared (first use in this function); did you mean 'fd'?
      62 |         if (riscv_isa_extension_available(NULL, d))
         |                                                 ^
         |                                                 fd
   arch/riscv/kvm/vcpu_fp.c:64:54: error: 'f' undeclared (first use in this function); did you mean 'fd'?
      64 |         else if (riscv_isa_extension_available(NULL, f))
         |                                                      ^
         |                                                      fd
   arch/riscv/kvm/vcpu_fp.c: In function 'kvm_riscv_vcpu_host_fp_restore':
   arch/riscv/kvm/vcpu_fp.c:70:49: error: 'd' undeclared (first use in this function); did you mean 'fd'?
      70 |         if (riscv_isa_extension_available(NULL, d))
         |                                                 ^
         |                                                 fd
   arch/riscv/kvm/vcpu_fp.c:72:54: error: 'f' undeclared (first use in this function); did you mean 'fd'?
      72 |         else if (riscv_isa_extension_available(NULL, f))
         |                                                      ^
         |                                                      fd
   arch/riscv/kvm/vcpu_fp.c: In function 'kvm_riscv_vcpu_get_reg_fp':
   arch/riscv/kvm/vcpu_fp.c:90:59: error: 'f' undeclared (first use in this function); did you mean 'fd'?
      90 |             riscv_isa_extension_available(vcpu->arch.isa, f)) {
         |                                                           ^
         |                                                           fd
   arch/riscv/kvm/vcpu_fp.c:101:66: error: 'd' undeclared (first use in this function); did you mean 'fd'?
     101 |                    riscv_isa_extension_available(vcpu->arch.isa, d)) {
         |                                                                  ^
         |                                                                  fd
   arch/riscv/kvm/vcpu_fp.c: In function 'kvm_riscv_vcpu_set_reg_fp':
   arch/riscv/kvm/vcpu_fp.c:135:59: error: 'f' undeclared (first use in this function); did you mean 'fd'?
     135 |             riscv_isa_extension_available(vcpu->arch.isa, f)) {
         |                                                           ^
         |                                                           fd
   arch/riscv/kvm/vcpu_fp.c:146:66: error: 'd' undeclared (first use in this function); did you mean 'fd'?
     146 |                    riscv_isa_extension_available(vcpu->arch.isa, d)) {
         |                                                                  ^
         |                                                                  fd
   cc1: some warnings being treated as errors
--
   arch/riscv/kvm/vcpu_timer.c: In function 'kvm_riscv_vcpu_timer_init':
>> arch/riscv/kvm/vcpu_timer.c:256:13: error: implicit declaration of function 'riscv_isa_extension_available' [-Werror=implicit-function-declaration]
     256 |         if (riscv_isa_extension_available(NULL, SSTC)) {
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> arch/riscv/kvm/vcpu_timer.c:256:49: error: 'SSTC' undeclared (first use in this function)
     256 |         if (riscv_isa_extension_available(NULL, SSTC)) {
         |                                                 ^~~~
   arch/riscv/kvm/vcpu_timer.c:256:49: note: each undeclared identifier is reported only once for each function it appears in
   cc1: some warnings being treated as errors
--
   arch/riscv/kvm/vcpu_pmu.c: In function 'kvm_riscv_vcpu_pmu_init':
>> arch/riscv/kvm/vcpu_pmu.c:556:14: error: implicit declaration of function 'riscv_isa_extension_available' [-Werror=implicit-function-declaration]
     556 |         if (!riscv_isa_extension_available(NULL, SSCOFPMF))
         |              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> arch/riscv/kvm/vcpu_pmu.c:556:50: error: 'SSCOFPMF' undeclared (first use in this function)
     556 |         if (!riscv_isa_extension_available(NULL, SSCOFPMF))
         |                                                  ^~~~~~~~
   arch/riscv/kvm/vcpu_pmu.c:556:50: note: each undeclared identifier is reported only once for each function it appears in
   cc1: some warnings being treated as errors
--
   arch/riscv/kvm/aia.c: In function 'kvm_riscv_aia_init':
>> arch/riscv/kvm/aia.c:604:14: error: implicit declaration of function 'riscv_isa_extension_available' [-Werror=implicit-function-declaration]
     604 |         if (!riscv_isa_extension_available(NULL, SxAIA))
         |              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> arch/riscv/kvm/aia.c:604:50: error: 'SxAIA' undeclared (first use in this function)
     604 |         if (!riscv_isa_extension_available(NULL, SxAIA))
         |                                                  ^~~~~
   arch/riscv/kvm/aia.c:604:50: note: each undeclared identifier is reported only once for each function it appears in
   cc1: some warnings being treated as errors
--
   drivers/perf/riscv_pmu_sbi.c: In function 'pmu_sbi_setup_irqs':
>> drivers/perf/riscv_pmu_sbi.c:803:13: error: implicit declaration of function 'riscv_isa_extension_available' [-Werror=implicit-function-declaration]
     803 |         if (riscv_isa_extension_available(NULL, SSCOFPMF)) {
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/perf/riscv_pmu_sbi.c:803:49: error: 'SSCOFPMF' undeclared (first use in this function)
     803 |         if (riscv_isa_extension_available(NULL, SSCOFPMF)) {
         |                                                 ^~~~~~~~
   drivers/perf/riscv_pmu_sbi.c:803:49: note: each undeclared identifier is reported only once for each function it appears in
   cc1: some warnings being treated as errors


vim +70 arch/riscv/include/asm/elf.h

2350bd192fa2d9 Palmer Dabbelt 2023-02-02  64  
2129a235c09896 Palmer Dabbelt 2017-07-10  65  /*
2350bd192fa2d9 Palmer Dabbelt 2023-02-02  66   * Provides information on the availiable set of ISA extensions to userspace,
2350bd192fa2d9 Palmer Dabbelt 2023-02-02  67   * via a bitmap that coorespends to each single-letter ISA extension.  This is
2350bd192fa2d9 Palmer Dabbelt 2023-02-02  68   * essentially defunct, but will remain for compatibility with userspace.
2129a235c09896 Palmer Dabbelt 2017-07-10  69   */
50724efcb370c6 Andy Chiu      2023-06-05 @70  #define ELF_HWCAP	riscv_get_elf_hwcap()
2129a235c09896 Palmer Dabbelt 2017-07-10  71  extern unsigned long elf_hwcap;
2129a235c09896 Palmer Dabbelt 2017-07-10  72  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

