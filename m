Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E40D3CFCED
	for <lists+linux-efi@lfdr.de>; Tue, 20 Jul 2021 17:07:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234075AbhGTOXL (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 20 Jul 2021 10:23:11 -0400
Received: from mail-dm3nam07on2104.outbound.protection.outlook.com ([40.107.95.104]:14017
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237396AbhGTORr (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 20 Jul 2021 10:17:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N/gzQ+V1S5+Hfwawwn+ReOI3fEVdBer72lxZe7FrLct2/SnYmhVXwHhWrt/1ggB+ld7blRIygdnTXSrbCR3WbULbwq7FkdwhPVL39JU6kXkCADGS2zSaqzIbBW/Aw+DzN5TSD9fDFeQEcd4qVMelfUby7VhP6v0UOuGcrkovqwg+ygYVBbVMAI+IAyvY+vRIQmdWUb9GOMM31jZ4EA2nM1bOdasnneEsmGNHvyq45q/G1/HVGvj6/lzHGPFSb6pc1Jf6PHJndC25pvrNLU5/zvCl7LJ6lmQudj0mbm4EPPO64MNOyex7rbNF0XscnGMtMHR93C0ZQDG0IP/JnvfWHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fO+IbZKHVZD/CYykFGE4OWYx7nPAezm+xUFLlW3hkoQ=;
 b=Sbnw2MJBCSqMO6yuXc3orcuHaOyC5pXsEmKR1t8l1Vsuq6lxkx7qNPJdXSMZsjvx6yiUJYohOKV4+v/I0CL6WO/t6Oujg59E3BVFPRrqlRUD/Ez73bRdLKkd+KkWHTrzxeQ+vjFbVrwCs93MQ2DH07kkFb0Mw2pYkb1DjKeseJkwr1Q5G7GlycReGFdpIWWcGGCPPRLctbsei1dtUEu5C89hM4DAGXjOYsoE6PzFLvur0GXr2PYTtvogzliRjbFe2Z8Rm3S7qCk4O2fq6ccM6DT+AZQ/GMM1HE8hOUacN0JEh1sSP9USwC4uaUgjYdMQLlYlIea8di2FLHIrLemeUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fO+IbZKHVZD/CYykFGE4OWYx7nPAezm+xUFLlW3hkoQ=;
 b=YT8s0701Wwg2TwcHuBkLktIJCwi78JYwuVxDuwA+nTTnIkPuUCdz4Q1di3DeVeeJYtQbRoJ7VR3vM37bUd0x0JMTxpUgf7nzsvw+dETUHNskb7rwAk1nnpvs5JrhtJeXRYnJO4+4nXQjO3YNN3/+TofguHpDdoiDemWQtKHDGyc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from DM6PR21MB1514.namprd21.prod.outlook.com (2603:10b6:5:22d::11)
 by DM5PR2101MB0981.namprd21.prod.outlook.com (2603:10b6:4:a8::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.4; Tue, 20 Jul
 2021 14:57:22 +0000
Received: from DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::3505:fa47:39d0:6dc5]) by DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::3505:fa47:39d0:6dc5%9]) with mapi id 15.20.4373.005; Tue, 20 Jul 2021
 14:57:22 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     will@kernel.org, catalin.marinas@arm.com, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-efi@vger.kernel.org,
        wei.liu@kernel.org, kys@microsoft.com, sthemmin@microsoft.com,
        ardb@kernel.org
Cc:     mikelley@microsoft.com
Subject: [PATCH v11 0/5] Enable Linux guests on Hyper-V on ARM64
Date:   Tue, 20 Jul 2021 07:56:58 -0700
Message-Id: <1626793023-13830-1-git-send-email-mikelley@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain
X-ClientProxiedBy: MWHPR07CA0023.namprd07.prod.outlook.com
 (2603:10b6:300:116::33) To DM6PR21MB1514.namprd21.prod.outlook.com
 (2603:10b6:5:22d::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mhkdev.corp.microsoft.com (167.220.2.16) by MWHPR07CA0023.namprd07.prod.outlook.com (2603:10b6:300:116::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend Transport; Tue, 20 Jul 2021 14:57:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e71c4cca-21ae-4396-8280-08d94b8ead84
X-MS-TrafficTypeDiagnostic: DM5PR2101MB0981:
X-MS-Exchange-Transport-Forked: True
X-LD-Processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
X-Microsoft-Antispam-PRVS: <DM5PR2101MB0981734E85C0977BF03C710ED7E29@DM5PR2101MB0981.namprd21.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nxDeVW1Ul+6XZFqHonQgpQ+W+8ZYvdZ5RVpq6dph8TeSQp40yEAxL9XwBR8+lq+v3xzES4MCWuDLkiwxgrppNw8MVFwCivhsNTQmQpFjIf2Ei5Db5CYxFSInQJxDDFC8LBZn9FhjtmOeu8wlG+r7VFY4n0O1lovzQkIYlwXPTHmMKiAr/DmxR1FkcpKzoWaL3yZS3Bst9X6b30u34dLI1VGYxAdW0Y2Bde1w/PygX/GI7mC0F56YoiW6jM+keWiiXK8eG9LbU2CGedjGhnuI4TOl3z7F8KrRQS/0RwHfzlYFMWhZh1Yug1TRn0s8gMreGq0wbIl4cj04vY7luEys2q2qHZncG5B1xzesoq0b4i6rF+Drm4L4Tiy0sJ/KC5Jn6ZPcUhJXhkleoTh5IMGwsm4ERdAqQbvB/iqN7dn6PfiJM564qcqx65u2Q54XIMmUr1QyUnwIQJuuPmK89qqN16mjClQHzBezi92N5tpxdouT40/X84oR1QUS/hLboF+MgE5+nOB4SC8/RplE1ADY7Wbj2sLmVPsawx+onZynlIMO7n+L4Dtsz0K1GEVTWc8XUSeWEMgQbcFgIyW/+ND/v234N3F4qxF1UMqO54beG1RE85c2K9RUCMcgRtlHn0tawb2rtgT+tKuRplCarye8YDLfE4zAqRFJYxC7IrieN457P+3RdhQ4wfPo2Te3q99uQIhOqZ6CRQyIDgKM1OxA6uiWBR+3uk/RnlYvNFZ73fc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1514.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(83380400001)(26005)(6666004)(36756003)(508600001)(956004)(10290500003)(66476007)(5660300002)(38350700002)(4326008)(8676002)(38100700002)(66946007)(2616005)(82950400001)(186003)(52116002)(7696005)(107886003)(6486002)(8936002)(82960400001)(316002)(921005)(66556008)(86362001)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tG7tb86onGuuTL00uct3+xHv23uCiTw7fIqeSiX//uzTB1m5Cwdr2XzIHWs3?=
 =?us-ascii?Q?WbSHotgxdM+0vWEgqwIsQ+8LPSWhLFxJLKqox5Nq1UOR4K8baWbGns4Geu3W?=
 =?us-ascii?Q?hPqfOzaHqZtWoJsa6l+d04/VgCrpa0cFjPPGZ+dka/SiiqgyGUc5veHNYYdj?=
 =?us-ascii?Q?spjnDR8N0bPcVtSfkX6d1WXxzFimyStRwtu4WlCrOigDWiG2H9dABZG/1dP1?=
 =?us-ascii?Q?Cn0qOZukTnT+Uat81rJpvYb7rgPGDJR6y5LUqRb4CgnuTk6YShNafqsXx9Pe?=
 =?us-ascii?Q?IGWWjLtZjxEemb8CgSqyzOI/T4t/B1M+CtsA9WHZ0sdl8rOiA58c105oOrkv?=
 =?us-ascii?Q?yVBoCyBZSuITY6XTuhBDyA6gRzc4mOD/wis+08mXKV4Afb0B/jqAhfhgO0AO?=
 =?us-ascii?Q?ndF7OdIbSGiagZicwQmKfbZS7XEAe989BnLK5fZt1NfEgov9MQOq0JxgoA0u?=
 =?us-ascii?Q?y59HRx0Ra8gkayDJgX3gyWqmafTOzXaY2Z58pWVJk1tDu6GkNGOzlCHNXAb1?=
 =?us-ascii?Q?c0bpvNSQ0bBH2jXJaWyvTzi5m+mhb3h7m4hfSKNzoxDL2xJsRGHWFtq0YCy5?=
 =?us-ascii?Q?9ponpCJh2rl+CXcsRL6tkF1nn9P851v0mHoR4mtV9SGBV+yD82LchLNHEES9?=
 =?us-ascii?Q?RB4kFP2Dv9B1/lh2NY+Zefgyotvs1KiEdYLp6BiicApuKXbjr7K32/3pa+gB?=
 =?us-ascii?Q?16m0IHQvftPI5ST3MB0yk5Tz912WFdY/Kw0e5MyQ5L1KPLcCoRjXVEB0p1L8?=
 =?us-ascii?Q?R2M1mzyvLl3vyIdVFR7Vos/QIe67in2gabs8lm0g1rdGk1pYiEFzGrU3VerH?=
 =?us-ascii?Q?UvTUIBbd/zlUrFFSbFcBlYdb5+duzydscUliEA3MFBqCbYZqsFPOF8a6EMME?=
 =?us-ascii?Q?3HOg1tj8DjyqjEmzhA3tqRXRtGZTnchFSuo+hc/x699kVf92aw2OJmdLFeC8?=
 =?us-ascii?Q?4KEsFalEcQf6wZwZRHG2gzJ/IXt3/ZiFpIfkKmn8162W8VXfvi1mfLx+o59b?=
 =?us-ascii?Q?HOq2TZZkrV1Xj/lEtEPVZUR1jf6BP1RbbFpKdQIJUvFBYrnJTX11kdPY8Grt?=
 =?us-ascii?Q?Wz4P+RPCDrkMqr9lXSo16ucElhBdIWLMYm2M1eGDOl5Cyd9ft1u9u7l6TFLp?=
 =?us-ascii?Q?Ti1c8NfvkP/ySfCFZczHVBNI7XZEmFxYqoC7XLj6pTlpmWjHdYCOP1kwcvOP?=
 =?us-ascii?Q?BuSROaOPC7r4e6PnlLQOV4FTEbIiFXPEmx7uwP6LBCbU3aoNLS6Kor0RifkB?=
 =?us-ascii?Q?mISeeO50m450Zwll8euZOBZLE5klLCjaPrditijyIlVIFaFTE1edVvk3k8Ts?=
 =?us-ascii?Q?mjihLVqfkaPaKDLPuW0BqPgd?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e71c4cca-21ae-4396-8280-08d94b8ead84
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1514.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2021 14:57:21.9322
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IGhW1feoxu3LtqLqw8rXFgpQJtd44pJvbhdZ1DC3WeSWWkWCjtwb5OPsA/UZL7L1ngleHUWZSP9Kgqu2lUrxXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0981
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
 arch/arm64/hyperv/mshyperv.c         |  83 ++++++++++++++++
 arch/arm64/include/asm/hyperv-tlfs.h |  69 +++++++++++++
 arch/arm64/include/asm/mshyperv.h    |  54 +++++++++++
 arch/arm64/kernel/efi.c              |   1 +
 drivers/hv/Kconfig                   |   5 +-
 9 files changed, 397 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm64/hyperv/Makefile
 create mode 100644 arch/arm64/hyperv/hv_core.c
 create mode 100644 arch/arm64/hyperv/mshyperv.c
 create mode 100644 arch/arm64/include/asm/hyperv-tlfs.h
 create mode 100644 arch/arm64/include/asm/mshyperv.h

-- 
1.8.3.1

