Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A90B31F2E3
	for <lists+linux-efi@lfdr.de>; Fri, 19 Feb 2021 00:18:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbhBRXST (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 18 Feb 2021 18:18:19 -0500
Received: from mail-bn8nam12on2100.outbound.protection.outlook.com ([40.107.237.100]:10081
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230021AbhBRXSQ (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 18 Feb 2021 18:18:16 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LiK6AUVZIiKTTks5B3XaKg22FTEbFW7mOmvfhGN2+YziwAtDHf9u8NMIMZMYBoKgcRN+BxO9FxOtwcPdgOEtjUnbJVbHiUwU8nxFtfXQH/H8rqjVqSQr6UJt81Sm0f+bE99Qd4UjaWGSI3aPiC1c3CN0k3+nvr2y/Z9111J2pnzhr8JOoHOf9t+mwDVspGCsvsfwdcGJIKkUjWIGvqXOFad+N3FGsvYx5r3mtL98a27Ra8O877siSYxS9VKmsgeJKt5SingtmmN2PAMle85Q7fH5Zyca4gLeqW1NDTZneYLwLFrXqvvIK9H8NIJzFqdB22AxY9ObfJaSNLLGf/IjBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YCoGyCVrx48qh2xzerzNXZ8r9Ryot4pET1IY9hfnV38=;
 b=EwZ7BcjX7kX4tnD4x0Y/7xEKtiiHu1kCV1diGx4RiKnMk3msCHokwPNTNAZrxxTiWOvKo7G3mb1S7fwn3suaRmzaGH+bUnrPFUR55rucxbqIeH2bYRdobW3nj2i8R6KMqbLXMCRaS5AiXlasJdfLKxwwL+XOeXEOzK94oYmD8+9kefGiSkwLnR/ZYUyZV3LJIQ4vynOFUzcY2i6qbK1l246peWjTD5u4dkkUCNj2SOLFeS1d9ihBeF/cBcJE7cZKJs2fWpaat51PfdgZdNzpopZtBRqJD6DmIayZ7cG/s5JDvmgBTu+jOZ/LYIM4wAOlpu5M2YfnGmgZlOXJ07S9hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YCoGyCVrx48qh2xzerzNXZ8r9Ryot4pET1IY9hfnV38=;
 b=IvgBkxKqYY6dWrBu6raOtzf0ZJV36h4NgJWTODaCVPP9G4OOFZiUWtp7hikA6oIdMn8dBOa9yvuUxaFy1iFvrnXGCQ6bBvX+ZEkuZVK24d7gA8X++tn+e1ilI4tLtb2MtJR8unyjvFzBoH8ts+RGQ1PhBfn/shVRUy6H9uLh6s4=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=microsoft.com;
Received: from (2603:10b6:5:22d::11) by
 DM5PR2101MB0983.namprd21.prod.outlook.com (2603:10b6:4:a8::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3805.1; Thu, 18 Feb 2021 23:17:26 +0000
Received: from DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::1c32:e52a:6a36:3ff]) by DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::1c32:e52a:6a36:3ff%5]) with mapi id 15.20.3890.002; Thu, 18 Feb 2021
 23:17:26 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     will@kernel.org, catalin.marinas@arm.com, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-efi@vger.kernel.org,
        arnd@arndb.de, wei.liu@kernel.org, ardb@kernel.org,
        daniel.lezcano@linaro.org, kys@microsoft.com
Cc:     mikelley@microsoft.com
Subject: [PATCH v8 0/6] Enable Linux guests on Hyper-V on ARM64
Date:   Thu, 18 Feb 2021 15:16:28 -0800
Message-Id: <1613690194-102905-1-git-send-email-mikelley@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain
X-Originating-IP: [131.107.147.144]
X-ClientProxiedBy: MWHPR10CA0017.namprd10.prod.outlook.com (2603:10b6:301::27)
 To DM6PR21MB1514.namprd21.prod.outlook.com (2603:10b6:5:22d::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mhkdev.corp.microsoft.com (131.107.147.144) by MWHPR10CA0017.namprd10.prod.outlook.com (2603:10b6:301::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27 via Frontend Transport; Thu, 18 Feb 2021 23:17:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: dfdd465d-1b78-4658-528e-08d8d4635aab
X-MS-TrafficTypeDiagnostic: DM5PR2101MB0983:
X-MS-Exchange-Transport-Forked: True
X-LD-Processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
X-Microsoft-Antispam-PRVS: <DM5PR2101MB09834EF3A04CCE3D9CB53C0ED7859@DM5PR2101MB0983.namprd21.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ivV3MJLIQt6lN6a8lRBI8CCqzBTZqZJETc0k1VtFhjPbWtdPq8JB2q2t768ecAcBUWguNkL40gnS0nSxids/wSDSg8I64iunwwPCjGgy7Ned9/TkrkpqJfnENQlbyzTwZu+olK+m9Ty2onmOTBgbWAJ861tVh4PSCVRfG61rWiQl2sbiCj34A3XkcETZBxKQW7CdFB5SBrjWQc7nyLjbA8/Gic/FOr5NFdPT/BB1Z6YTYQ1T/MKs8eBjB+Slu1jtEmAFARuBZKr2M9Xl0RqSp0Bj1PNpHDNVnRODmA06uzWuSzfkeEI462JpA2BpENBqowVfXaAEP1wuhrI3Q7ovONvVVBg5kEK2XkDiYuuSyRQsnHTvtNsNWmyIMAJM0qhnNoiXPEoEIM8K+7k1FIyYE1PbHIk3vne+3pUO0aPCJUgMmLR2gQplz/L507X1B47suBWCQWgwwyYdBPqRqJIyO709/4bKb+cOHmImdwu5QIKQPYYNaTf/YiJv+Xbfoe2ulOv/nJzoNRozNOCKDlDhp8LHKWwWgK24lIexAOGJLEGtSL8QyIpOFUHJfZhaniajqj2IAR72dHPPpvSXVW6ysninohxK3bJxyCAGOy2Yp7TnoHHgc5fBibjWv3jQHu0fwSVPAiAkF3fH9ZjtpNUSLA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1514.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(396003)(346002)(366004)(136003)(966005)(5660300002)(6486002)(921005)(107886003)(8676002)(7416002)(82950400001)(2616005)(4326008)(66476007)(478600001)(2906002)(83380400001)(36756003)(186003)(66556008)(6636002)(66946007)(86362001)(10290500003)(956004)(16526019)(26005)(82960400001)(8936002)(52116002)(7696005)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?gA7t9E/NErgB6GAhUrPxXVXceyrbZ7YkOm16JPCl9076kVeMQ1T/uPMF/5AN?=
 =?us-ascii?Q?wgsBfhiiPVxgZRIsPQ/OH1kUxovy6Io4VDg+RuZCUcPtjobXtpx3Y0kxKefj?=
 =?us-ascii?Q?fEEkF18aeTPX9UyJpEpJh5RAGGxpddsQ+Fxph+br/R0YlT9T1vw4osFOIVEj?=
 =?us-ascii?Q?xz7kfpRDXU+ASbaMtbpvKevuU/hsVTwZIbv/CVE9LbAe+Jv5Q5ZeEnq2SPa3?=
 =?us-ascii?Q?7Zr3KERdq6f5p4a5QIXv0yYSsd2FuqHKs502IWiwQgm/XHDPVYkXVMgI+6rA?=
 =?us-ascii?Q?dLeTurD31bb2Ka1czfQvdgInQHPu0g/UZoVGXTRGXIT0RDUFox8qP72adTN9?=
 =?us-ascii?Q?oEzXCm+hNeWyxyoa7YPKBUTLs+wMCeTCxqp2I+9ObEutH5X1q2uIyT/lJ2r3?=
 =?us-ascii?Q?UVJsC60Wk8ycbQxIow3h8q6lQPiGcIYgq1X9sT6FCX1yap50GVnxD57bE2k6?=
 =?us-ascii?Q?Fs+mCXsqlOMQmig+YoITIvhuOS5UFPaQWJdfWq+3ne9PpEsrgkPQJqzLboNy?=
 =?us-ascii?Q?gimKvwAeeNPmKHXE7JPIUl0foLBuWkZ790VM6add8HzzMYj5h+PKockhD481?=
 =?us-ascii?Q?PBUnIMK7UhFlHhjJWDRBf7Upa8hU4JtPVfEix/eHnbOsM+hF6WRaDC2Ip3a/?=
 =?us-ascii?Q?u4AkFnx5ebOQME8iCaVepJeqOKaxIpFwr7dcNRBvGiEmKw/7542oanlZh+he?=
 =?us-ascii?Q?OFPEgxYtmE+4+iCbgZTiu4Sk1+vtRjNvUng/FVC6/nOtu3pJlL6OohL9ttFp?=
 =?us-ascii?Q?SIX8gtM2FAxj8QTnsXAU8rjXGe583SCcjSe2jevi+7tM8W4f1KMOQKrCXaiP?=
 =?us-ascii?Q?6DxiaP5avcsbdWTnE+rGbhVvMZjCFZ8Tmlsv0In+VwHqK6QQ0D/uVuEeCOQ1?=
 =?us-ascii?Q?2b6Ur9+vopxWqmQfe+/tZFswbBZ6QkftHgP/neC5dK98x74BkdCwnDlaL0ta?=
 =?us-ascii?Q?UFtNZ4YxmqO1a6/2wHL4VfHfvYmMeZKbhL6lXBIXUQ/9Iq+8+RyTbpXApJGM?=
 =?us-ascii?Q?iNc9HIOqJjWZK1ahgejcADD7V/k6QWH+HH5PzS/DDi7FpoU0WoyWViivEjJY?=
 =?us-ascii?Q?yZEF3gsQrUi/vrMP83JkW9yhj7YLO40vnH/N50wBxHh99wO8a8ZI6NvooV6S?=
 =?us-ascii?Q?Py6RANKAOm3/2xvBg1+34xYGkrcgnaGV1tkJInvWqZi3HvGabkrrKsz4ZMEG?=
 =?us-ascii?Q?KDhBFWw/jONejWFi9NQAC97joQv8xZXQFMzHGXP5IMVVarFDl4DOrUE6z40g?=
 =?us-ascii?Q?wbJXMvWpy3N1/tXFhWy6khB5AQq93V06Eg7vQ+aX1Wxem3runS/60cAitUM9?=
 =?us-ascii?Q?mNBX8swNKh7uMH/hWq9SPdcu?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfdd465d-1b78-4658-528e-08d8d4635aab
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1514.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2021 23:17:26.4089
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vJT2gz3afAs62nB5/7N65IaD2Z0CDs68cyDL7A9HaOUyB0yCE1ehLNCxci0OKeWVb4CV87eZXMdTLg5JefDQqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0983
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

This series enables Linux guests running on Hyper-V on ARM64
hardware. New ARM64-specific code in arch/arm64/hyperv initializes
Hyper-V, including its interrupts and hypercall mechanism.
Existing architecture independent drivers for Hyper-V's VMbus and
synthetic devices just work when built for ARM64. Hyper-V code is
built and included in the image and modules only if CONFIG_HYPERV
is enabled.

The six patches are organized as follows:

1) Add definitions and functions for making Hyper-V hypercalls
   and getting/setting virtual processor registers provided by
   Hyper-V

2) Add architecture specific definitions needed by the
   architecture independent Hyper-V clocksource driver in
   drivers/clocksource/hyperv_timer.c. Update the clocksource
   driver to be initialized on ARM64.

3) Add functions needed by the arch independent VMbus driver
   for reporting a panic to Hyper-V and as stubs for the kexec
   and crash handlers.

4) Add Hyper-V initialization code and utility functions that
   report Hyper-v status.

5) Export screen_info so it may be used by the Hyper-V frame buffer
   driver built as a module. It is already exported for x86,
   powerpc, and alpha architectures.

6) Make CONFIG_HYPERV selectable on ARM64 in addition to x86/x64.

Hyper-V on ARM64 runs with a 4 Kbyte page size, but allows guests
with 4K/16K/64K page size. Linux guests with this ARM64 enablement
code work with all three supported ARM64 page sizes.

The Hyper-V vPCI driver at drivers/pci/host/pci-hyperv.c has
x86/x64-specific code and is not being built for ARM64. Fixing
this driver to enable vPCI devices on ARM64 will be done later.

In a few cases, terminology from the x86/x64 world has been carried
over into the ARM64 code ("MSR", "TSC").  Hyper-V still uses the
x86/x64 terminology and has not replaced it with something more
generic, so the code uses the Hyper-V terminology.  This will be
fixed when Hyper-V updates the usage in the TLFS.

This patch set is based on the 5.11.0 code tree, plus this patch series
https://lore.kernel.org/lkml/1611779025-21503-1-git-send-email-mikelley@microsoft.com/
that refactors the boundary between arch independent and arch
dependent code for Hyper-V.

Changes in v8:
* Removed a fair amount of code based on refactoring the boundary between
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

Michael Kelley (6):
  arm64: hyperv: Add Hyper-V hypercall and register access utilities
  arm64: hyperv: Add Hyper-V clocksource/clockevent support
  arm64: hyperv: Add kexec and panic handlers
  arm64: hyperv: Initialize hypervisor on boot
  arm64: efi: Export screen_info
  Drivers: hv: Enable Hyper-V code to be built on ARM64

 MAINTAINERS                          |   3 +
 arch/arm64/Kbuild                    |   1 +
 arch/arm64/hyperv/Makefile           |   2 +
 arch/arm64/hyperv/hv_core.c          | 220 +++++++++++++++++++++++++++++++++++
 arch/arm64/hyperv/mshyperv.c         | 194 ++++++++++++++++++++++++++++++
 arch/arm64/include/asm/hyperv-tlfs.h |  69 +++++++++++
 arch/arm64/include/asm/mshyperv.h    |  73 ++++++++++++
 arch/arm64/kernel/efi.c              |   1 +
 arch/arm64/kernel/setup.c            |   4 +
 drivers/clocksource/hyperv_timer.c   |  14 +++
 drivers/hv/Kconfig                   |   3 +-
 11 files changed, 583 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/hyperv/Makefile
 create mode 100644 arch/arm64/hyperv/hv_core.c
 create mode 100644 arch/arm64/hyperv/mshyperv.c
 create mode 100644 arch/arm64/include/asm/hyperv-tlfs.h
 create mode 100644 arch/arm64/include/asm/mshyperv.h

-- 
1.8.3.1

