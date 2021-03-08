Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1B363317EA
	for <lists+linux-efi@lfdr.de>; Mon,  8 Mar 2021 20:58:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231594AbhCHT6P (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 8 Mar 2021 14:58:15 -0500
Received: from mail-dm6nam12on2099.outbound.protection.outlook.com ([40.107.243.99]:39904
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231359AbhCHT6G (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 8 Mar 2021 14:58:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GUAeIa2T1B7rFDr/8I9mWxnU4rVr/04pMvZx7qcXJE3dLQCVMpLhnpBIOFUaOSHlqKPfIxAs651dFifWbfEQ5hHpjoS0a7zAHAz30kL98QJvrUdm4NG20JGoTT+DGm8TKviRi0gxx45ICmASs10fKtQ88PRHApG3D1J6LqDbsbRphApLGFZZdTVDWhDV76eb/gTgdEJ3+0ivQyMcd1USg//58rb5soF5Dt5Nngn16OkWYa8dPzmOAn5Us1YuZN5F/NerY6CL66/KIJZVmSsjuCDcPXmY4MwgYYlbcnD87AsFvX4cY2Xl+HhurKxGQ7MMrCAiBfZ8IiEgOJ0PNUSXKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GsdCymlMo6Yv3Lg3uRpmqqfOVAMQRfUxyARXNotR1Nk=;
 b=cfpo4fF13szbUF0tSygzioW/+eKbaXsVS6YSAqGgJBYeM6+cR3qSD97T89RJGgHxh5lObDR6N9XkbBYXH3MKsirWKmjHj9i/jjDLbpH+W1P2a3Q2rWC2qofmYs+HY1njdNFIE+Xg9cqopJDigFeGLg+WiJoCuChHVbs1pUWwV9McsWDXsBR4meMZmgUb5JMOndyDHEtLJUmdZ998LSmr+A05WqBSzbOOjSUZAUNBgQGw/YrFoRRZKk1dZDIpa83PV38cLfCI+li73KiBKRUviDQat0uFlOHYWuxYVXQbSSpWj3fvZhKCR2qjdY9yFcrJZGBK23gcPsW30UBU1SyC9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GsdCymlMo6Yv3Lg3uRpmqqfOVAMQRfUxyARXNotR1Nk=;
 b=iiJbBTW1JZyCGRKgRrnvNl47ezohj6+8sM/0VF2pDdDwe+V68NY1fjzQqYM4+Vw4x/A4IlmZR/wERNFhgrrxSFG4PaXJgZncRCVFGGKpBuJiHba9mKxbJcGqY4Qz+ynsbbakkozJ/YjXSUo8Di261MnGquT3smeVz0roBAv8FvU=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=microsoft.com;
Received: from DM6PR21MB1514.namprd21.prod.outlook.com (2603:10b6:5:22d::11)
 by DM5PR21MB1797.namprd21.prod.outlook.com (2603:10b6:4:aa::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.4; Mon, 8 Mar
 2021 19:58:04 +0000
Received: from DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::1c32:e52a:6a36:3ff]) by DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::1c32:e52a:6a36:3ff%4]) with mapi id 15.20.3933.025; Mon, 8 Mar 2021
 19:58:04 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     will@kernel.org, catalin.marinas@arm.com, mark.rutland@arm.com,
        lorenzo.pieralisi@arm.com, sudeep.holla@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-efi@vger.kernel.org,
        arnd@arndb.de, wei.liu@kernel.org, ardb@kernel.org,
        daniel.lezcano@linaro.org, kys@microsoft.com
Cc:     mikelley@microsoft.com
Subject: [PATCH v9 0/7] Enable Linux guests on Hyper-V on ARM64
Date:   Mon,  8 Mar 2021 11:57:12 -0800
Message-Id: <1615233439-23346-1-git-send-email-mikelley@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain
X-Originating-IP: [131.107.174.144]
X-ClientProxiedBy: MW4PR03CA0161.namprd03.prod.outlook.com
 (2603:10b6:303:8d::16) To DM6PR21MB1514.namprd21.prod.outlook.com
 (2603:10b6:5:22d::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mhkdev.corp.microsoft.com (131.107.174.144) by MW4PR03CA0161.namprd03.prod.outlook.com (2603:10b6:303:8d::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend Transport; Mon, 8 Mar 2021 19:58:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7d24951b-111f-45de-85bc-08d8e26c7c11
X-MS-TrafficTypeDiagnostic: DM5PR21MB1797:
X-MS-Exchange-Transport-Forked: True
X-LD-Processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
X-Microsoft-Antispam-PRVS: <DM5PR21MB1797CE3A6B7C0F4CAEE23128D7939@DM5PR21MB1797.namprd21.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rGCWeRkuUu9LqPn7h8+uJmX9O5zATbB/FjBU8CoEQuS/DjuIin9EcV1qSL6LOYJ//DX/Hw/bEBOhquQgr+oIhxtdQ4AuuT23B8t4+Siynqepi68JKJWmpIA5fmy4I60QB+mFZ9DCa+9JHavRBCIPX9oZe16NwAqxd9jVOOBlcAg5nWDHhrjIGrvKi3EW7a/peaEPbR695VGCQOPqlqrNWtnHlDjy/Of2LhjvFb1vdyAovfqSEi4eGHwEPPC+BrH6NpM9DfrfOPlzcJLuPUFCl86s0GUm06w/59C8iwgHfGzElVYqm/2YOynBOxlqIjyHJxbhBYyRjRu//7rOJgFzTNplx+JofDevozpY39Lz8HyeOOvwgwLhAsmYP/gWdXv0Rx2ySPFzn/XZzfDdiLscfRzb9B4Nm55r98JafQZ89dsL1EPi7jKfDz7Q3Ul5IcXXLDixxgyBJMbTiiMh53MdZOtB3y/0hUgqYjdyfzgJ/yrwsSWChwE6av/xfy716ZU/Y9gSuEBNaghozo5nFq5zN/TZ5B8CX3YdcWVZmW30sNtApL1n8heme7x2oELsCs3RYO0T702msUVW7wv0gqIBNKeC3BmrPJlIIQ9tgsxtG85uxAU0lXoo84XlKUoJ+hyKulqC3qYgOONOpAKW9QtFfXuG96eJKMzJqQHot29NJyy/3ky09desCPc+eCwZMLaf
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1514.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(376002)(346002)(396003)(366004)(66556008)(186003)(52116002)(66476007)(66946007)(10290500003)(478600001)(26005)(16526019)(966005)(5660300002)(2906002)(36756003)(8936002)(6666004)(316002)(7696005)(8676002)(6486002)(2616005)(82960400001)(4326008)(6636002)(107886003)(82950400001)(7416002)(921005)(956004)(83380400001)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?y+sTtw6snoO88HPYP+oasuudZY2RAD0GtNo9IyqaXVj6aurLIqGmvbnQtcRJ?=
 =?us-ascii?Q?NdVjgIfAWBHTFIYV4lHqUg3x+1uMW5HzWMVMilPjK41U3STH3mxZgBKCpbSZ?=
 =?us-ascii?Q?g3e0/YKULrznAa3nK7BcQhmB3HKx6cDyOYgh6nK3EZFb/4E1CEXub3JpPloP?=
 =?us-ascii?Q?G6BYDLoxdoORT0TF2MrMkeQkATIM+w9e02uvSd9BLoWHF8puTrM2ujpwpSp3?=
 =?us-ascii?Q?3OCbJH+t8t5wSXaCJffD+6uUbc+M32t3oxha+bxVhwO4PlAogCZFc6FbmvMY?=
 =?us-ascii?Q?c2l6pTQJfVCj0WLU7I/5oYeAr1uSLuxeiVwEj05Te8kwxK49vF51x1jvSTS8?=
 =?us-ascii?Q?Xb51fThesqKhDDv0qBPAgifxjqNkCH6M9J1CG2sJCOufazxPTWQ5bYhHvErQ?=
 =?us-ascii?Q?CvvDsIE/YEQMUznhLzbdsttji3yoGNF1zSaQgifX1ly0XQ5BOVBkDmiPCXcW?=
 =?us-ascii?Q?XYQKSNDGuVGjlZap7LPDhMKbV7iuYijfyDO99yLIiW22ZHDi+qMICpeOBOE/?=
 =?us-ascii?Q?WElI763EnhB8oRAlZmTnh35UAXAi8lF+e1P5VObVJC8OSMLup9cqycQf1oTe?=
 =?us-ascii?Q?EGsoc/1Q9e50HVb+Ep8Se/2uTaqfsMdZbYBSnwMM5jKPW0JaZCZL9Vhpv4YG?=
 =?us-ascii?Q?umUokNrV60/0ueQrQbqGQ6OSCF75OZ5tBdWm75xE/Kl7ZzHovhsGpayw5FJC?=
 =?us-ascii?Q?faxvOzJdu629pTF1MMieQ0xbSs/PhRHfzuDy1DfUnuuJJiqJkQzXGnn3gKN/?=
 =?us-ascii?Q?8fS9Lrtr++KJZDAlSuNeJxm3F6EOjN0iCCGpKjNBTs47Y1k/dSQWBgzzNvC4?=
 =?us-ascii?Q?mf+CYdFrQMQH4G+EMNOy49bXNNy8Esfzz6grPQyErcRt6wms4BNBYZsNuHKI?=
 =?us-ascii?Q?WgwxuN73k8O0M9NCob1EUhhMiUprYaR9h0ji4DSWpWeCWphxTUYoGQfo0wkM?=
 =?us-ascii?Q?CQCopFkm/sCab3MTrroJf6JlxX4dMuaP4sj4DJqf9+dkilEwarb4ln1I2+iL?=
 =?us-ascii?Q?ewJtbmpQosJo1Zj+GR4N4SBArVbjOFDcW6h4hu4Oi5Usst/zEuZe+DKY6tLJ?=
 =?us-ascii?Q?H8vVhEL+FHJplb1wZ91JOq6N3Aqv3nTPfX8L/Bm9i56dkrcEK2IdylRX7Wck?=
 =?us-ascii?Q?lFygdhbDk/mqASUDfuq/Q1PatHjSBBYXarwogIa4CSlPQlXMFHdrvfSToADO?=
 =?us-ascii?Q?asG5m9njipNtBb7ThMyGBmX5Rw0edlc7RtjulROsDYHOillDZqXr903VlOMM?=
 =?us-ascii?Q?uZxXwgEmulkMSdBsnWuS2Z+rffYcet9bmHZHCobfZSgfYzyFCIEEy95yCyaB?=
 =?us-ascii?Q?J8uBe9MJAUAqtdygcHyYLjCw?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d24951b-111f-45de-85bc-08d8e26c7c11
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1514.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2021 19:58:04.0038
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eMgkGMkbwwqd1iPjRkPh656DS9nbIXf8DDIs0Gq8ub9+Mw6jofYXNRDcr9lMBRe06QhzH9iiEcyE5cnTgBNrEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB1797
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

The seven patches are organized as follows:

1) Update include/linux/arm-smccc.h to provide an HVC wrapper
   variant that returns results in other than X0 thru X3

2) Add definitions and functions for making Hyper-V hypercalls
   and getting/setting virtual processor registers provided by
   Hyper-V

3) Add architecture specific definitions needed by the
   architecture independent Hyper-V clocksource driver in
   drivers/clocksource/hyperv_timer.c. Update the clocksource
   driver to be initialized on ARM64.

4) Add functions needed by the arch independent VMbus driver
   for reporting a panic to Hyper-V and as stubs for the kexec
   and crash handlers.

5) Add Hyper-V initialization code and utility functions that
   report Hyper-v status.

6) Export screen_info so it may be used by the Hyper-V frame buffer
   driver built as a module. It is already exported for x86,
   powerpc, and alpha architectures.

7) Make CONFIG_HYPERV selectable on ARM64 in addition to x86/x64.

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

This patch set is based on the hyperv-next branch of the code tree
https://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git/

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
*** BLURB HERE ***

Michael Kelley (7):
  smccc: Add HVC call variant with result registers other than 0 thru 3
  arm64: hyperv: Add Hyper-V hypercall and register access utilities
  arm64: hyperv: Add Hyper-V clocksource/clockevent support
  arm64: hyperv: Add kexec and panic handlers
  arm64: hyperv: Initialize hypervisor on boot
  arm64: efi: Export screen_info
  Drivers: hv: Enable Hyper-V code to be built on ARM64

 MAINTAINERS                          |   3 +
 arch/arm64/Kbuild                    |   1 +
 arch/arm64/hyperv/Makefile           |   2 +
 arch/arm64/hyperv/hv_core.c          | 178 +++++++++++++++++++++++++++++++++++
 arch/arm64/hyperv/mshyperv.c         | 173 ++++++++++++++++++++++++++++++++++
 arch/arm64/include/asm/hyperv-tlfs.h |  69 ++++++++++++++
 arch/arm64/include/asm/mshyperv.h    |  72 ++++++++++++++
 arch/arm64/kernel/efi.c              |   1 +
 arch/arm64/kernel/setup.c            |   4 +
 drivers/clocksource/hyperv_timer.c   |  14 +++
 drivers/hv/Kconfig                   |   3 +-
 include/linux/arm-smccc.h            |  29 ++++--
 12 files changed, 542 insertions(+), 7 deletions(-)
 create mode 100644 arch/arm64/hyperv/Makefile
 create mode 100644 arch/arm64/hyperv/hv_core.c
 create mode 100644 arch/arm64/hyperv/mshyperv.c
 create mode 100644 arch/arm64/include/asm/hyperv-tlfs.h
 create mode 100644 arch/arm64/include/asm/mshyperv.h

-- 
1.8.3.1

