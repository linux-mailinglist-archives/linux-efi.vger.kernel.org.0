Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C85CE7AE961
	for <lists+linux-efi@lfdr.de>; Tue, 26 Sep 2023 11:38:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234225AbjIZJip (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 26 Sep 2023 05:38:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234233AbjIZJin (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 26 Sep 2023 05:38:43 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0D6DFB;
        Tue, 26 Sep 2023 02:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695721116; x=1727257116;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=d3ouO7jf+iohjm9VzwU5wpln3TMDOcB1Wp/B8vx8bWU=;
  b=VK4gJehMFjuUw8VKb3uTso1OpAoo2hJQNgHAi4zshColBlT7gfZrs0D5
   F9yQugKH/wBpcj0qCjl1Ww7VwjKKn93eSzsgdcRKeOg5INyj/ZK/gGe9T
   wbBi93v8aAAdtEX5qznKAE3bwqb0PUqE4tFuFc1doKDWYDSMHNrL3UlCj
   xsYmSpMaO8LegdfMwAXBcvhi32QVWbf91myBSCsZWTgISDzGRucJkfyEd
   kcYURbshD98qZcxR9KCX7vTBje2FjT8O2XdVMB6MPj/OD0r/WFGhyN9Zc
   9gO4EtCWN6kMi9hR5dED2KLJkMBnmLgsDNIXP6mY4easJAXkgt0vdQy9R
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="361773009"
X-IronPort-AV: E=Sophos;i="6.03,177,1694761200"; 
   d="scan'208";a="361773009"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 02:38:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="995767726"
X-IronPort-AV: E=Sophos;i="6.03,177,1694761200"; 
   d="scan'208";a="995767726"
Received: from xiao-desktop.sh.intel.com ([10.239.46.158])
  by fmsmga006.fm.intel.com with ESMTP; 26 Sep 2023 02:38:30 -0700
From:   Xiao Wang <xiao.w.wang@intel.com>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, ardb@kernel.org
Cc:     anup@brainfault.org, haicheng.li@intel.com,
        ajones@ventanamicro.com, yujie.liu@intel.com,
        linux-riscv@lists.infradead.org, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xiao Wang <xiao.w.wang@intel.com>
Subject: [PATCH v3 0/2] riscv: Optimize bitops with Zbb extension
Date:   Tue, 26 Sep 2023 17:46:53 +0800
Message-Id: <20230926094655.3102758-1-xiao.w.wang@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Bitops optimization with specialized instructions is common practice in
popular ISAs, this patch set uses RISC-V Zbb extension to optimize four
bitops: __ffs, __fls, ffs and fls.

The first patch rearranges the content in hwcap.h cpufeature.h, it helps
to avoid a cyclic header including issue for patch 2.

The second patch leverages the alternative mechanism to dynamically apply
this optimization.

The series has following dependency:
https://lore.kernel.org/linux-riscv/20230918131518.56803-8-ajones@ventanamicro.com/

Thanks,
Xiao

v3:
- Fix riscv32 build issue reported by kernel test robot. V3 changes "hwcap.h" to
  "cpufeature.h" for files where cpu feature detection APIs are used. (Yujie)

v2:
- Remove the "EFI_" prefix from macro name "EFI_NO_ALTERNATIVE" to make it
  generic. (Ard)
- patch-1 is added, it's based on "RISC-V: Enable cbo.zero in usermode". (Andrew)


Xiao Wang (2):
  riscv: Rearrange hwcap.h and cpufeature.h
  riscv: Optimize bitops with Zbb extension

 arch/riscv/include/asm/bitops.h       | 266 +++++++++++++++++++++++++-
 arch/riscv/include/asm/cpufeature.h   |  83 ++++++++
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
 16 files changed, 359 insertions(+), 106 deletions(-)

-- 
2.25.1

