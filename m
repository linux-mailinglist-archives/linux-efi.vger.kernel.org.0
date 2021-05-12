Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4504837EB3C
	for <lists+linux-efi@lfdr.de>; Thu, 13 May 2021 00:09:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379916AbhELTUb (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 12 May 2021 15:20:31 -0400
Received: from mail-dm6nam12on2136.outbound.protection.outlook.com ([40.107.243.136]:63366
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1348888AbhELRjh (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 12 May 2021 13:39:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JKq585dbKkc9e9AQR2Ao+ZaurSVekzK3FuYpsv9PvCndBNsaxhzJrJXB8s+UzvySGeL9dj+2h05ReIo+qXa3UhINSWTeBM6zN96Lwk025Iuuk9gyKY51Rh2C7FVcDGK7WSQzmtu+lPtRdNb5pMc+cCHO/OlXQwiwhFIHZWst7y/k9w69Ap2xKUQ1zXj4CE6zTrO5Lfue3nZUBi+qlXz/FgF60Kn2s5RBxBvatV4/fOxomCFiWFMkybCF5ZcmoLKiV62Eh+aO2eYr6Su29ErA8Jm2N+TTTGwu6x5zF6We3medb2cWHVM4BU34k3x8A19U3fHmnEX9+eRuToqFmRy/CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3LzmHiY7F96BvI9UX4Dh+NQN9qlISS5xhpozhiC/xqg=;
 b=II42U4EJTDRiA0jay2RvLqwcEMcYrJ0mwOqFatxKe4Hd+WLJx6kcaDjQhM3wJceE1BJGL52rxUpnTmgIosUNTNHtVJK8SMnasPUJjdb45b10R2izlZrdZojWslhE/ICr3pkL/dmqKqFksatzORNQJ/TkkeTt69wZwmE5ZErK2itL1HhTC6QKRpa661WtACUzyGyY9mvcJ0Ly0DZ0qPbOgK9EzIXRB5/rgshY/IOP8AVUdqsM3eQKNjBhpGOUZqxdBHur0V/wAZVSjzDPDZCljCyhHrd/tO/4/ViYRuhFUk2Z0VZn20hfSIX8+AvdWqLybVvD1yVVbfBqmJFnQrAupA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3LzmHiY7F96BvI9UX4Dh+NQN9qlISS5xhpozhiC/xqg=;
 b=Tyyzo7xzGZew+3bKWxVEhNRfLwPNvMH4tPhZe0AqZRHq7MBvV8Z3RwvOwKKKP2VcIo9qSRZg94+yn19cyJwJzpOBu5DoupNT9TgDNchvmZNE3QR6Mqnwwl+JbCc7pxE+ZXX+4h6SVGF+r8Jc2P8OdThHcAzR+5qT2MLq0vK+a/M=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=microsoft.com;
Received: from DM6PR21MB1514.namprd21.prod.outlook.com (2603:10b6:5:22d::11)
 by DM6PR21MB1483.namprd21.prod.outlook.com (2603:10b6:5:25c::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.5; Wed, 12 May
 2021 17:38:26 +0000
Received: from DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::fdb1:c8ac:5a1f:8588]) by DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::fdb1:c8ac:5a1f:8588%5]) with mapi id 15.20.4150.011; Wed, 12 May 2021
 17:38:26 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     will@kernel.org, catalin.marinas@arm.com, mark.rutland@arm.com,
        lorenzo.pieralisi@arm.com, sudeep.holla@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-efi@vger.kernel.org,
        arnd@arndb.de, wei.liu@kernel.org, ardb@kernel.org,
        daniel.lezcano@linaro.org, kys@microsoft.com
Cc:     mikelley@microsoft.com
Subject: [PATCH v10 0/7] Enable Linux guests on Hyper-V on ARM64
Date:   Wed, 12 May 2021 10:37:40 -0700
Message-Id: <1620841067-46606-1-git-send-email-mikelley@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain
X-Originating-IP: [131.107.1.144]
X-ClientProxiedBy: CO2PR04CA0102.namprd04.prod.outlook.com
 (2603:10b6:104:6::28) To DM6PR21MB1514.namprd21.prod.outlook.com
 (2603:10b6:5:22d::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mhkdev.corp.microsoft.com (131.107.1.144) by CO2PR04CA0102.namprd04.prod.outlook.com (2603:10b6:104:6::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend Transport; Wed, 12 May 2021 17:38:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 33d8000d-dfe8-4536-24e3-08d9156cbf9a
X-MS-TrafficTypeDiagnostic: DM6PR21MB1483:
X-MS-Exchange-Transport-Forked: True
X-LD-Processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
X-Microsoft-Antispam-PRVS: <DM6PR21MB1483B8CC652CC842FFDC3F76D7529@DM6PR21MB1483.namprd21.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sNEBnTfacsE6ZesxL00GomtJVIXSmwWEVgAgG2dICv6QLcZFrpbXh/zP6CmEFPCR72i+C+KgJnxMs2NpPNrv0uLQytFg6Z8C7+fOpRuB4DePza2k01dqnnvXnUX/4vugx0rLK1+KyKye0KxLkOvb5XoFKN07O1ryt5ys2S0XyM/OV9PayL6TiJ5CVpYkDaJm4QSQQbFpl6DQnunZ6GQ5pRg/FShEx1aW+JZFv2jgPGn0C0MrP54ei1hOxLV8I3mT8Jqj+wsmLYBxTEoNB7LxMLI0yxzErHv0c4aqQ6m+ZUYiW9rsU0AZ7JYq7TYeMSoR5WhoPIvo2nKyjF1qpo2DmrEkXA3cAo6WocOZeBx9k+Vir4qJlhAun9WZPOyVGMLmt/3k/sQ6ScFi5f7Y+xcvqc+5ayi9DSwXT3sKI4G8S5X4HANmQQD0zJxFlsGFZ7E8iaP1MZCJLmwgnbv4telkeZl85Jw4hHFc53D6vXKkxHrE+8JvSrJUNnxG7ro3G8CPFi8JhlFAb3/BQAtHy9TqEeUGIFKyAmnfY6mgf9pOASylWKBMcWs9hi41/BGX47J/42/QFTXMRYIrr/kjCqRMIP9+Ty4Tkvq12ff0QhCJYZrT1YPSdAAFeDOP/FzNqYEGy/ya3S6z9BImQwwn447LLpChTN53D7A5hF4+OWQ8f1Z/Bq68S3+NySvxEIDxusgwvfkLuIKMgUS4B8MxlOKex1rYhxNae9l4wkNtNLAQMoJe5IGD0F6Yrbhh+meQknae/KS5SQlRIhoIw3QLeHG6qXtUbN/OPj6Qht3ESmYVGJs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1514.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8936002)(6636002)(316002)(478600001)(8676002)(86362001)(66556008)(921005)(16526019)(10290500003)(7696005)(52116002)(7416002)(2906002)(186003)(966005)(66476007)(4326008)(82960400001)(2616005)(82950400001)(956004)(66946007)(6486002)(6666004)(38100700002)(38350700002)(5660300002)(107886003)(36756003)(26005)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yQWxmgLlXX/9io51bI11K24hrThVcSzGJO38me7/KpN5VxWCiI0oDwMHLKDk?=
 =?us-ascii?Q?hIhazBvi3iG/2wpZ+Ocf6ZKM/JdUcha+Z/6wHP/QIVDdlA9ijGK3D56oRTfQ?=
 =?us-ascii?Q?AIvcnHnmHfMvRNZl0wVHWbQi+24F67eU2SCtG8nqZHES4b8+9ZBzaC8urKwy?=
 =?us-ascii?Q?2yvrBkusogcCDxp859AQ/RTN8Ch2RETnBUpVUr+eNYxvfJYlaFU3dzfZSW6m?=
 =?us-ascii?Q?AB0RxXku8fWOjYdm2ohQt+gG3UcEda8H2QYbvXkCar+pnU9X8dcjnVnxLW6g?=
 =?us-ascii?Q?qUYihyirIkZqBeRaj1O5OicNrLDXbFZDp6Q1jXcB17GvEiaqDjSuTyMVlwUU?=
 =?us-ascii?Q?MOoPKCQ1QbFLrBobw6eHRUPI80eHFfsIIQKypetdInqk8biUPfoltSbC+B/P?=
 =?us-ascii?Q?7PzqJVKB2HxR16LkCgI3AV4XUAs8dCM+57TIKLs9/jg/4fnE/CKS4RGHW7xe?=
 =?us-ascii?Q?Mi6gQmhcLfrBNbypwHnvVtIBjUnVbWwUVWJaUq9sQtqQzU9md2PDXZZn7vV2?=
 =?us-ascii?Q?/3ZKrqBt9bMZEE2NlNim5+jVEoldgo1Nb0SAqE4ncEmVhhZteye7SzReQYdJ?=
 =?us-ascii?Q?fZ5kG/JmaH7heFaGKXvwJYXRhwGhIT9JwMzZ98qSBLelZwuFgFpQHHcLwJ6w?=
 =?us-ascii?Q?/D6t1MXhDgFYjHmBsVt78d7kJpwcvwXYi0rJHqtK9FwGI+Igflvmc+DAv6ZZ?=
 =?us-ascii?Q?1nvjLfBYL80ZI0dJy7YiSBcie73IK8yv/uZYPenLeGFlcNKsjkH0Ycxd1Qjw?=
 =?us-ascii?Q?oJkn3SIc1f92nnAQF9Uc4JRqxKBWJw1ke/kzCkEFDPGfkDDOEXYG0IHZ+NLz?=
 =?us-ascii?Q?JVB7ceKqnx3dTfeCWl9CYFu+6op4mQvJH1bKfBBZJYNL0L/eohxcXI6fonEP?=
 =?us-ascii?Q?SBpyAB+DBhNNpwA2XHdfP1gieaBYEuTnCzdoBI6BpZuEsAjg/441vKcHduQZ?=
 =?us-ascii?Q?Zf2iM3P5IzU8q5jPoD7qn+97kpHlmZB8VM3IkXjR?=
X-MS-Exchange-AntiSpam-MessageData-1: ZfI3eO6q+Wq7Q1vMNM/1T2fu7zxCojNLcxCwBm3bNdGVjsXxFed+YyMFkx75ZgNUKghR/fpOYMTPb0sDz3yHPdwHrSXFwkwt2DYHmxZWGcN8WL5h0ffmcP0F0mOOBQlA5MXPeMbKGhwiIwae95PHmykls8XK5JRD7NO/IgB9LI7p/rd60U097YISyViTg1blBO1cNDH1+Y6amSwrz3qqHZi3JpiYhfIOmhjsPFG1ph3+Npq1LcFbimrNsZL/esxkrqPjCTzIJc9DYYSs+uxtnMY4s2bXwccXWv296Diu4oUabWbUMJsVhVaVIX9/6Yw8BN0WXM/i7vhSTKZRFFHdegQM
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33d8000d-dfe8-4536-24e3-08d9156cbf9a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1514.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2021 17:38:26.7445
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GIOYLWcL6BoSqQVeIQygQaxNfdc5dAZvXgMoifAIX1HdrJi7Lckix0dziCyExLJ3gcrHkxpzjlzHKJc2sk0bKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR21MB1483
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

1) Fix some minor places where x86-dependencies crept into
   architecture independent Hyper-V code

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
with 4K/16K/64K page size. Linux guests with this patch series
work with all three supported ARM64 page sizes.

The Hyper-V vPCI driver at drivers/pci/host/pci-hyperv.c has
x86/x64-specific code and is not being built for ARM64. Fixing
this driver to enable vPCI devices on ARM64 will be done later.
The Hyper-V balloon driver also recently picked up some x86
dependencies that will be fixed separately, so it currently
doesn't build for ARM64 and CONFIG_HYPERV_BALLOON must be "N".

In a few cases, terminology from the x86/x64 world has been carried
over into the ARM64 code ("MSR", "TSC").  Hyper-V still uses the
x86/x64 terminology and has not replaced it with something more
generic, so the code uses the Hyper-V terminology.  This will be
fixed when Hyper-V updates the usage in the TLFS.

This patch set is based on the 5.13-rc1 code tree, plus a patch
from Sudeep Holla that implements SMCCC v1.2 HVC calls:
https://lore.kernel.org/linux-arm-kernel/20210505093843.3308691-2-sudeep.holla@arm.com/

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

Michael Kelley (7):
  asm-generic: hyperv: Fix incorrect architecture dependencies
  arm64: hyperv: Add Hyper-V hypercall and register access utilities
  arm64: hyperv: Add Hyper-V clocksource/clockevent support
  arm64: hyperv: Add kexec and panic handlers
  arm64: hyperv: Initialize hypervisor on boot
  arm64: efi: Export screen_info
  Drivers: hv: Enable Hyper-V code to be built on ARM64

 MAINTAINERS                          |   3 +
 arch/arm64/Kbuild                    |   1 +
 arch/arm64/hyperv/Makefile           |   2 +
 arch/arm64/hyperv/hv_core.c          | 182 +++++++++++++++++++++++++++++++
 arch/arm64/hyperv/mshyperv.c         | 206 +++++++++++++++++++++++++++++++++++
 arch/arm64/include/asm/hyperv-tlfs.h |  69 ++++++++++++
 arch/arm64/include/asm/mshyperv.h    |  72 ++++++++++++
 arch/arm64/kernel/efi.c              |   1 +
 arch/arm64/kernel/setup.c            |   4 +
 arch/x86/include/asm/mshyperv.h      |   3 -
 drivers/clocksource/hyperv_timer.c   |  14 +++
 drivers/hv/Kconfig                   |   3 +-
 include/asm-generic/mshyperv.h       |   5 +
 13 files changed, 561 insertions(+), 4 deletions(-)
 create mode 100644 arch/arm64/hyperv/Makefile
 create mode 100644 arch/arm64/hyperv/hv_core.c
 create mode 100644 arch/arm64/hyperv/mshyperv.c
 create mode 100644 arch/arm64/include/asm/hyperv-tlfs.h
 create mode 100644 arch/arm64/include/asm/mshyperv.h

-- 
1.8.3.1

