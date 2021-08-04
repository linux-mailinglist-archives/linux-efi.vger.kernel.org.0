Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D34B3E04EB
	for <lists+linux-efi@lfdr.de>; Wed,  4 Aug 2021 17:53:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239441AbhHDPx1 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 4 Aug 2021 11:53:27 -0400
Received: from mail-bn8nam08on2132.outbound.protection.outlook.com ([40.107.100.132]:57601
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236453AbhHDPx1 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 4 Aug 2021 11:53:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b9uQzi1yJ2NRNs1bgefJXkX43ajvDYH/MKBBL9DEWdEAxDmxO3pRnyZVgIOSmpyonQBl/EAPGgihue3HjHVEtrus2v15h3PQi4/ymYzC6GKGJv8h4OmJ9N+5a1WwSmieWSde+MZkAUj++l1asaoNshVw2pJZ6aeXgrQgqnMmY6opuNeBa/aScN9lArHpSND80EBX/kyVa73UPy7t3p/NsMJe3baqnt7Ja553vZRkmszV9okx1/f698cs1yBBV5tP1fvnv5/mEn5slZJVAVv8Sv2XUm/fnUkd68D4x1CZBG2rz9g7GC9JveE18um9LtKREUqq0G3IVRkuiKlHfJkNJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dJSsIEmLBPakXUqyUv6sK6ohzrbQG39SXn+0lijkRjA=;
 b=V7PysgGVqffwHh72Une8cdkSz/05XtrLQBz60Wx/ZgSGHWcd3ajklEYWtPWpvUWJ5WE/OPpqHBunnJOXvgduKxheoxxykWB3pAwLSl5tBKFr59I8eMtpYqixRjNJ5i2L0pQb1GGUQ3dr5R9LoL/pJ+DaNKXE5O7jdebvdZa95Ug4VCrogrF4xeOK7yXNFfbW/fef8fgoEkit72MUuN7ungZCeHZANHuQyUDcAesmt4v79Q/f3qXQPx65WAmWNZtjsrjQCibdJwnMzFZo9RuDX5JryaarLs4OV/QBtP0tb8j1gKFjyjcm2L0RkHEod2Rc7fdvQ3OHvfzuLbmsa8ogTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dJSsIEmLBPakXUqyUv6sK6ohzrbQG39SXn+0lijkRjA=;
 b=EbXnq27WX84X7RUE5wq1c6ffkVE5ZyC/JHcTo6o1Mom8Q+8qG0mkGswVUGX3n4VQ9M6nmYAInwHe3Lp1KHazMo17zjAfR+hIc3wzFW3o+Jk1HSLcN4Bva09hZWLe8sYbSYSfxX9XBm3c5iLRfxPgRaunv/88YKyD9UQU34ttOnU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from DM6PR21MB1514.namprd21.prod.outlook.com (2603:10b6:5:22d::11)
 by DM5PR2101MB1094.namprd21.prod.outlook.com (2603:10b6:4:a2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.1; Wed, 4 Aug
 2021 15:53:09 +0000
Received: from DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::b170:236f:1f2:5670]) by DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::b170:236f:1f2:5670%9]) with mapi id 15.20.4415.005; Wed, 4 Aug 2021
 15:53:09 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     will@kernel.org, catalin.marinas@arm.com, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-efi@vger.kernel.org,
        wei.liu@kernel.org, kys@microsoft.com, sthemmin@microsoft.com,
        ardb@kernel.org
Cc:     mikelley@microsoft.com
Subject: [PATCH v12 0/5] Enable Linux guests on Hyper-V on ARM64
Date:   Wed,  4 Aug 2021 08:52:34 -0700
Message-Id: <1628092359-61351-1-git-send-email-mikelley@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain
X-ClientProxiedBy: CO2PR04CA0175.namprd04.prod.outlook.com
 (2603:10b6:104:4::29) To DM6PR21MB1514.namprd21.prod.outlook.com
 (2603:10b6:5:22d::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mhkdev.corp.microsoft.com (167.220.2.16) by CO2PR04CA0175.namprd04.prod.outlook.com (2603:10b6:104:4::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15 via Frontend Transport; Wed, 4 Aug 2021 15:53:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7631fff4-6fb4-4402-a200-08d9575ff4dc
X-MS-TrafficTypeDiagnostic: DM5PR2101MB1094:
X-MS-Exchange-Transport-Forked: True
X-LD-Processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
X-Microsoft-Antispam-PRVS: <DM5PR2101MB1094BF40455307ED0898A659D7F19@DM5PR2101MB1094.namprd21.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WUj2jkfx/l/ZUq39pHbedKpfS0nCGANgFxQfFY+4N2qcXpjxX4CHA6A66piPPJm15o2UWFGv+sscL5JJDjgi4bAZkankwFoBLo/nlgbsyEgrlxu5fPalPwNs3Oj6zGeRvB9BM7f7ynVa1GPM6DtLGXN1j+Gl0I+kE7vfQcngabQkoCkVObp+y1PZmt0uan08aMLKNEKRtxzkd1vZEG1KOXGctxl8mqO8lYA63aOBbTG6Tc59X/Zq5aC34kswBHEmjUDU1ql+1xDfNc01Djw1/mgLU8+ZuuEkqeUoEIMpqtLPQn8k4Dw9LwgaYwbSroeZN4UvX5tmQ8CFRMQKb47xAly4D4EcmiW5roHPzYii9L0BYsQUI9DjY1D9fTAhIreel9XZtKyhu9hLOhJmx6NitDz4Wt7Kam06bkwecjZWTMpFXIGuFern/ZuvotH6wS+4yjmknG9Lqn0I/FZTjiKDHSxM5L/C4/DTncT4Xd7tiTKtVTCOhrxtqV8VunYTPMGfFAqk/193HFsjQ7zyb3lkBSqzmaISQIzF5WsEFGsTphpbxLMvOrs/F1wDHz1IGADF74yuzYaABs16+WCkLojQkKQ5m3ePt2eZuTvLbspyuFaAIKx2Oa5TJx6zCvix3E6eUkG9LqXUx98hR5165+uHOGzmiwbC/J+D+68Yyv0ytYxe2pKKYZ6FMbETNTAXu/levsLvkFbdYNqag/r911+759JQENJJ4RR1WFubhmvlnUU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1514.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(5660300002)(26005)(52116002)(6666004)(186003)(7696005)(86362001)(82950400001)(82960400001)(508600001)(10290500003)(921005)(38100700002)(38350700002)(83380400001)(2906002)(66476007)(36756003)(2616005)(66556008)(107886003)(8676002)(66946007)(956004)(4326008)(8936002)(316002)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CTTYsA155+TNAgAAeX+vNI2Og7LOqaWXgRCnyaEuvR2ib4julfh+3fc8O8Iz?=
 =?us-ascii?Q?w2IaroqDXSgcpY6R5+g3O97z9jdvKcj7+kcdLcFlCxLJ5yY9QQY0ITLfCFsH?=
 =?us-ascii?Q?eUmG6xK5u4fRu56g/JvCVQHqbfRrL3DvnVC715t0lE+ObzTzx524A2iVMlsd?=
 =?us-ascii?Q?Hd2mYXQSNaC8hcjdgt/WSp+dS5WBcAQemusVVG0eHgk2ErebsiXQPnirpY9Y?=
 =?us-ascii?Q?pAd2Nf0n3BuD4oIHB8KaOJtcRws4UrNKjtErJ4Gk6vpbAw2hvLwSQcdjCbCb?=
 =?us-ascii?Q?PVEC4apJtLVv99q9dqVTTpSJK4w8cSxOgpDaNaWXo8GW4No9tYkiS2U+injB?=
 =?us-ascii?Q?vOifFivqcVEZqu6oLm3PnhR8ae/7nSv1d/HtMhGocX1a2kZ3CHOb5ETAB2rS?=
 =?us-ascii?Q?PEvfiePy665g5/zkBfPWb5ZLorAYDmSvLr2x9Z6GiaY1GbrvEcwAC9FDEkfg?=
 =?us-ascii?Q?F39T1Oq/ij+Apt295+Jj/eL08hUoH8qdiwwlzvzfgu4VIS09KrgVH1egHVX+?=
 =?us-ascii?Q?aOZqgI+Iq3Uvo4OzXAciRTeCKXP1US1Z4+I0JE7sXenu6QjVq0d9SQjswsQt?=
 =?us-ascii?Q?85v9uDmtWtZ7SrA1jxLu8SwvHSuKkH2DRXtlG7BAJX9MJAZsrz9O0/oYUV0K?=
 =?us-ascii?Q?/WLhzTgwkUiPUB4T6Tyy/mMofhEJq+mt8492Hcw8CDO6aUbBIjpfdGkJrE2V?=
 =?us-ascii?Q?cKuKIWnepbqYElsitpLfk5i87gVj6nGgUcJkICb0BoVzMuoJxsmUzfrYpdpJ?=
 =?us-ascii?Q?R1I5lJfhWGSbf/cDa+IlAZBK1MjWVO/lV6VPy68tjbyYZAi+EeymcTYcYjDz?=
 =?us-ascii?Q?gtdJTSe7rSRilaJsbAnwQiI2Ke4eXXbDoLHjtC0wpNOoX8gEExSL7g6gHSV4?=
 =?us-ascii?Q?n3DFDgFDSQYpjD6EWmWnl9pxJYbc6Wnd84bVC7Onth6dNw8s6tCpCqjaQ93y?=
 =?us-ascii?Q?ssMj6+7ZqhJY5Z+VEmW2YFs6cCSjwWgvv37VMi6xq7Kbs24EPCbHuEhDnch+?=
 =?us-ascii?Q?TCDm8YrJABWWrHoXqYmWPOzQkkSkeU1wyG9hOqCuTJJPlr+XnQ8izrDffuw3?=
 =?us-ascii?Q?9hf86ucR4xezEH7QTgi8MhMZzI2Apfz+PqfARcEmtyz4yRdUNqu1j1+XE91v?=
 =?us-ascii?Q?XPtTyiVO6lMaM8sv74XNUQkHNWHia25KF5oO8MYcc5bbvgSKmNuVNOVl2Jxd?=
 =?us-ascii?Q?0qNPjd0UiCbDNmwQ7DTfrFVgroJ8NChFEj464zlDYnz2vs2hHVh+vqPXrdM4?=
 =?us-ascii?Q?NGlieu66VZKsmVfj7ZqHifOqKNZ0aHW4u6q5OphOzuLtlrf24qFuUcARdgFX?=
 =?us-ascii?Q?gTZwkXQveHb39jCeyFMND5hF?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7631fff4-6fb4-4402-a200-08d9575ff4dc
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1514.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2021 15:53:09.2420
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QXemalu2/SMXGN9MCdTeIYsUganXZjtKSxCgIDqd2ieVg0gLilmRDX4dRApmAgShKjVFib2gYgfjelympAKd2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1094
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

This series enables Linux guests running on Hyper-V on ARM64
hardware. New ARM64-specific code in arch/arm64/hyperv initializes
Hyper-V and its hypercall mechanism.  Existing architecture
independent drivers for Hyper-V's VMbus and synthetic devices just
work when built for ARM64. Hyper-V code is built and included in
the image and modules only if CONFIG_HYPERV is enabled.

The five patches are organized as follows:

1) Add definitions and functions for making Hyper-V hypercalls
   and getting/setting virtual processor registers provided by
   Hyper-V

2) Add the function needed by the arch independent VMbus driver
   for reporting a panic to Hyper-V.

3) Add Hyper-V initialization code and utility functions that
   report Hyper-v status.

4) Export screen_info so it may be used by the Hyper-V frame buffer
   driver built as a module. It is already exported for x86,
   powerpc, and alpha architectures.

5) Make CONFIG_HYPERV selectable on ARM64 in addition to x86/x64.

Hyper-V on ARM64 runs with a 4 Kbyte page size, but allows guests
with 4K/16K/64K page size. Linux guests with this patch series
work with all three supported ARM64 page sizes.

The Hyper-V vPCI driver at drivers/pci/host/pci-hyperv.c has
x86/x64-specific code and is not being built for ARM64. Enabling
Hyper-V vPCI devices on ARM64 is in progress via a separate set
of patches.

This patch set is based on the linux-next20210720 code tree.

Changes in v12:
* Updated hyperv_init() in Patch 3 to allow a kernel built
  with CONFIG_HYPERV to run in other environments. [Marc
  Zyngier, Mark Rutland]

Changes in v11:
* Drop the previous Patch 1 as the fixes have already been
  separately accepted upstream.
* Drop the previous Patch 3 for enabling Hyper-V enlightened
  clocks/timers.  Hyper-V is now offering the full ARM64
  architectural Generic Timer in guest VMs, so the existing
  arch_arch_timer.c driver just works. [Mark Rutland, Marc
  Zyngier]
* Simplified the previous Patch 4 and Patch 5 (now Patch 2 and 3)
  by sharing more code between the x86 and ARM64 architectures.
* Combined hyperv_early_init() and hyperv_init() into a single
  initialization function that runs as an early_initcall. This
  is possible because the Hyper-V enlightened clocks/timers
  no longer need to be initialized early in the boot sequence.

Changes in v10:
* Drop previous Patch 1 for SMCCC v1.2 HVC calls in favor of
  Sudeep Holla's patch [Mark Rutland]
* Use new helper functions in 5.13 for checking Hyper-V hypercall
  return status
* Set up per-CPU hypercall argument page that is now used by the
  Hyper-V balloon driver
* Rebase on 5.13-RC1

Changes in v9:
* Added Patch 1 to enable making an SMCCC compliant hypercall
  that returns results in other than registers X0 thru X3, per
  version 1.2 and later of the SMCCC spec.
* Using the ability to return results in registers X6 and X7,
  converted hv_get_vpreg_128() to use a "fast" hypercall that
  passes inputs and outputs in registers, and in doing so eliminated
  a lot of memory allocation complexity.
* Cleaned up some extra blank lines and use of spaces in aligning
  local variables. [Sunil Muthuswamy]
* Based on discussion about future directions, reverted the
  population of hv_vp_index array to use a cpuhp state instead
  of a hypercall, which is like it was in v7 and earlier.

Changes in v8:
* Removed a lot of code based on refactoring the boundary between
  arch independent and arch dependent code for Hyper-V, per comments
  from Arnd Bergmann. The removed code was either duplicated on
  the x86 side, or has been folded into architecture independent
  code as not really being architecture dependent.
* Added config dependency on !CONFIG_CPU_BIG_ENDIAN [Arnd Bergmann]
* Reworked the approach to Hyper-V initialization. The functionality
  is the same, but is now structured like the Xen code with an early
  init function called in setup_arch() and an early initcall to
  finish the initialization. [Arnd Bergmann]

Changes in v7:
* Separately upstreamed split of hyperv-tlfs.h into arch dependent
  and independent versions.  In this patch set, update the ARM64
  hyperv-tlfs.h to include architecture independent definitions.
  This approach eliminates a lot of lines of otherwise duplicated
  code on the ARM64 side.
* Break ARM64 mshyperv.h into smaller pieces. Have an initial
  baseline, and add code along with patches for a particular
  functional area. [Marc Zyngier]
* In mshyperv.h, use static inline functions instead of #defines
  where possible. [Arnd Bergmann]
* Use VMbus INTID obtained from ACPI DSDT instead of hardcoding.
  The STIMER INTID is still hardcoded because it is needed
  before Linux has initialized the ACPI subsystem, so it can't
  be obtained from the DSDT.  Wedging it into the GTDT seems
  dubious, so was not done. [Marc Zyngier]
* Update Hyper-V page size allocation functions to use
  alloc_page() if PAGE_SIZE == HV_HYP_PAGE_SIZE [Arnd
  Bergmann]
* Various other minor changes based on feedback and to rebase
  to latest linux-next [Marc Zyngier and Arnd Bergmann]

Changes in v6:
* Use SMCCC hypercall interface instead of direct invocation
  of HVC instruction and the Hyper-V hypercall interface
  [Marc Zyngier]
* Reimplemented functions to alloc/free Hyper-V size pages
  using kmalloc/kfree since kmalloc now guarantees alignment of
  power of 2 size allocations [Marc Zyngier]
* Export screen_info in arm64 architecture so it can be used
  by the Hyper-V buffer driver built as a module
* Renamed source file arch/arm64/hyperv/hv_init.c to hv_core.c
  to better reflect its content
* Fixed the bit position of certain feature flags presented by
  Hyper-V to the guest.  The bit positions on ARM64 don't match
  the position on x86 like originally thought.
* Minor fixups to rebase to 5.6-rc5 linux-next

Changes in v5:
* Minor fixups to rebase to 5.4-rc1 linux-next

Changes in v4:
* Moved clock-related code into an architecture independent
  Hyper-V clocksource driver that is already upstream. Clock
  related code is removed from this patch set except for the
  ARM64 specific interrupt handler. [Marc Zyngier]
* Separately upstreamed the split of mshyperv.h into arch independent
  and arch dependent portions. The arch independent portion has been
  removed from this patch set.
* Divided patch #2 of the series into multiple smaller patches
  [Marc Zyngier]
* Changed a dozen or so smaller things based on feedback
  [Marc Zyngier, Will Deacon]
* Added functions to alloc/free Hyper-V size pages for use by
  drivers for Hyper-V synthetic devices when updated to not assume
  guest page size and Hyper-v page size are the same

Changes in v3:
* Added initialization of hv_vp_index array like was recently
  added on x86 branch [KY Srinivasan]
* Changed Hyper-V ARM64 register symbols to be all uppercase 
  instead of mixed case [KY Srinivasan]
* Separated mshyperv.h into two files, one architecture
  independent and one architecture dependent. After this code
  is upstream, will make changes to the x86 code to use the
  architecture independent file and remove duplication. And
  once we have a multi-architecture Hyper-V TLFS, will do a
  separate patch to split hyperv-tlfs.h in the same way.
  [KY Srinivasan]
* Minor tweaks to rebase to latest linux-next code

Changes in v2:
* Removed patch to implement slow_virt_to_phys() on ARM64.
  Use of slow_virt_to_phys() in arch independent Hyper-V
  drivers has been eliminated by commit 6ba34171bcbd
  ("Drivers: hv: vmbus: Remove use of slow_virt_to_phys()")
* Minor tweaks to rebase to latest linux-next code


Michael Kelley (5):
  arm64: hyperv: Add Hyper-V hypercall and register access utilities
  arm64: hyperv: Add panic handler
  arm64: hyperv: Initialize hypervisor on boot
  arm64: efi: Export screen_info
  Drivers: hv: Enable Hyper-V code to be built on ARM64

 MAINTAINERS                          |   3 +
 arch/arm64/Kbuild                    |   1 +
 arch/arm64/hyperv/Makefile           |   2 +
 arch/arm64/hyperv/hv_core.c          | 181 +++++++++++++++++++++++++++++++++++
 arch/arm64/hyperv/mshyperv.c         |  87 +++++++++++++++++
 arch/arm64/include/asm/hyperv-tlfs.h |  69 +++++++++++++
 arch/arm64/include/asm/mshyperv.h    |  54 +++++++++++
 arch/arm64/kernel/efi.c              |   1 +
 drivers/hv/Kconfig                   |   5 +-
 9 files changed, 401 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm64/hyperv/Makefile
 create mode 100644 arch/arm64/hyperv/hv_core.c
 create mode 100644 arch/arm64/hyperv/mshyperv.c
 create mode 100644 arch/arm64/include/asm/hyperv-tlfs.h
 create mode 100644 arch/arm64/include/asm/mshyperv.h

-- 
1.8.3.1

