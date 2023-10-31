Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 553877DC69E
	for <lists+linux-efi@lfdr.de>; Tue, 31 Oct 2023 07:36:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236053AbjJaGgR (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 31 Oct 2023 02:36:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233629AbjJaGgR (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 31 Oct 2023 02:36:17 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E85CBD;
        Mon, 30 Oct 2023 23:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698734175; x=1730270175;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=D+Aqhz12Bpi1YAVZ9gwZAkjrkKUZGH7axOamL/bkDyY=;
  b=kEizfTSclGE00zIXcQwq8wqgKYs0ksKI5IDNqX71zjqJmkWPfIPMzY4m
   PTZ6lROoBjEkDFYPou4P3W/Rmaqd0MS7ADVzsKLNLg1d4+pEb7wVUFOfB
   r+RFQ57jejq3dXsBXsVmfKTlUvT4Yk0a0YFzhU+tN0WB8rm7sPciijI5p
   7MRjH2pwQM9kTHpmuw79VZXKuZetcokIYv7a2QCR29aYXVTSFVf8joOuF
   AD2JmkWB2w5MrAygdTkIs+ZMQ/GUwgz/CjgTH5DXCDmT/O5G7WcnB8WYg
   1Y9RBW2iMAEIAX1WOKIXn3kW1C94F1A9ks1MEt5uye1sgzJGvDH6nhJKr
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="474463650"
X-IronPort-AV: E=Sophos;i="6.03,265,1694761200"; 
   d="scan'208";a="474463650"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2023 23:36:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="1091896282"
X-IronPort-AV: E=Sophos;i="6.03,265,1694761200"; 
   d="scan'208";a="1091896282"
Received: from xiao-desktop.sh.intel.com ([10.239.46.158])
  by fmsmga005.fm.intel.com with ESMTP; 30 Oct 2023 23:35:59 -0700
From:   Xiao Wang <xiao.w.wang@intel.com>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, ardb@kernel.org
Cc:     anup@brainfault.org, haicheng.li@intel.com,
        ajones@ventanamicro.com, yujie.liu@intel.com, charlie@rivosinc.com,
        linux-riscv@lists.infradead.org, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xiao Wang <xiao.w.wang@intel.com>
Subject: [PATCH v5 0/2] riscv: Optimize bitops with Zbb extension
Date:   Tue, 31 Oct 2023 14:45:51 +0800
Message-Id: <20231031064553.2319688-1-xiao.w.wang@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Bitops optimization with specialized instructions is common practice in
popular ISAs, this patch set uses RISC-V Zbb extension to optimize four
bitops: __ffs, __fls, ffs and fls.

The first patch rearranges the content in hwcap.h and cpufeature.h, it helps
to avoid a cyclic header including issue for patch 2.

The second patch leverages the alternative mechanism to dynamically apply
this optimization.

Thanks,
Xiao

v5:
- Fix all the checkpatch complaints from "scripts/checkpatch.pl --strict". (Charlie)
  There're three kinds of complaints on patch 2/2 code style:
  * CHECK: Lines should not end with a '('
  * CHECK: spaces preferred around that '-' (ctx:VxV)
  * CHECK: Macro argument reuse 'x' - possible side-effects?
  The third warning on fls(x) macro is fixed alongside with code style improvement.
- Drop the mistakenly added content in v4. (Charlie)
- Link to v4: https://lore.kernel.org/all/20231030063904.2116277-1-xiao.w.wang@intel.com/

v4:
- Simplify the asm code in ffs() and fls() by moving general logic into C
  implementation. (Charlie)
- Add a comment to decorating the large #ifdef block. (Charlie)
- Link to v3: https://lore.kernel.org/all/20230926094655.3102758-1-xiao.w.wang@intel.com/

v3:
- Fix riscv32 build issue reported by kernel test robot. V3 changes "hwcap.h" to
  "cpufeature.h" for files where cpu feature detection APIs are used. (Yujie)
- Link to v2: https://lore.kernel.org/all/20230920074653.2509631-1-xiao.w.wang@intel.com/

v2:
- Remove the "EFI_" prefix from macro name "EFI_NO_ALTERNATIVE" to make it
  generic. (Ard)
- patch-1 is added, it's based on "RISC-V: Enable cbo.zero in usermode". (Andrew)
- Link to v1: https://lore.kernel.org/all/20230806024715.3061589-1-xiao.w.wang@intel.com/

Xiao Wang (2):
  riscv: Rearrange hwcap.h and cpufeature.h
  riscv: Optimize bitops with Zbb extension

 arch/riscv/include/asm/bitops.h       | 254 +++++++++++++++++++++++++-
 arch/riscv/include/asm/cpufeature.h   |  83 +++++++++
 arch/riscv/include/asm/elf.h          |   2 +-
 arch/riscv/include/asm/hwcap.h        |  91 ---------
 arch/riscv/include/asm/pgtable.h      |   1 +
 arch/riscv/include/asm/switch_to.h    |   2 +-
 arch/riscv/include/asm/vector.h       |   2 +-
 arch/riscv/kvm/aia.c                  |   2 +-
 arch/riscv/kvm/main.c                 |   2 +-
 arch/riscv/kvm/tlb.c                  |   2 +-
 arch/riscv/kvm/vcpu_fp.c              |   2 +-
 arch/riscv/kvm/vcpu_onereg.c          |   2 +-
 arch/riscv/kvm/vcpu_vector.c          |   2 +-
 drivers/clocksource/timer-riscv.c     |   2 +-
 drivers/firmware/efi/libstub/Makefile |   2 +-
 drivers/perf/riscv_pmu_sbi.c          |   2 +-
 16 files changed, 347 insertions(+), 106 deletions(-)

-- 
2.25.1

