Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 517C47DB337
	for <lists+linux-efi@lfdr.de>; Mon, 30 Oct 2023 07:29:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231289AbjJ3G3a (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 30 Oct 2023 02:29:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjJ3G33 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 30 Oct 2023 02:29:29 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DFF8C0;
        Sun, 29 Oct 2023 23:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698647367; x=1730183367;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=EOx93d6rorzC+eSitj0kGZenM894c+BPrPvevSZ3o3Y=;
  b=KkzMygMpUft4VPXfdgss6dqrPlqbgzwm2FD4YVbvVoa/9tEVekb1jvyu
   dYgK5+u+OJ/vn9yoDt359k0FmUro90JMaRjdqD56YuNojfkTwyWV5t3v/
   4dren/HaxYW2mopAFalF7Uhh4TdId/6sW1ag831BYs6NlnYjOQKT3zoYT
   1N8CXOQRAbTv0S8mVNQdczA+69LTjYVBF/Ozxir6TG9nbm53P+YhNxLZO
   EAFcCNex7wcRPoIuO5DmyMp5DnrqFb7CrLqRHbnuO5pof6r9Jwelnu+BD
   yMpnGAmjKfxAUVwCekdJ4z+ERREkwnPWKYfHqvoMHh4oO+p25wBIQd8ZW
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10878"; a="452277976"
X-IronPort-AV: E=Sophos;i="6.03,262,1694761200"; 
   d="scan'208";a="452277976"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2023 23:29:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10878"; a="903893068"
X-IronPort-AV: E=Sophos;i="6.03,262,1694761200"; 
   d="scan'208";a="903893068"
Received: from xiao-desktop.sh.intel.com ([10.239.46.158])
  by fmsmga001.fm.intel.com with ESMTP; 29 Oct 2023 23:29:22 -0700
From:   Xiao Wang <xiao.w.wang@intel.com>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, ardb@kernel.org
Cc:     anup@brainfault.org, haicheng.li@intel.com,
        ajones@ventanamicro.com, yujie.liu@intel.com, charlie@rivosinc.com,
        linux-riscv@lists.infradead.org, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xiao Wang <xiao.w.wang@intel.com>
Subject: [PATCH v4 0/2] riscv: Optimize bitops with Zbb extension
Date:   Mon, 30 Oct 2023 14:39:02 +0800
Message-Id: <20231030063904.2116277-1-xiao.w.wang@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

The first patch rearranges the content in hwcap.h and cpufeature.h, it helps
to avoid a cyclic header including issue for patch 2.

The second patch leverages the alternative mechanism to dynamically apply
this optimization.

Thanks,
Xiao

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

 arch/riscv/include/asm/bitops.h       | 255 +++++++++++++++++++++++++-
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
 drivers/bitopstest/Kconfig            |   1 +
 drivers/clocksource/timer-riscv.c     |   2 +-
 drivers/firmware/efi/libstub/Makefile |   2 +-
 drivers/perf/riscv_pmu_sbi.c          |   2 +-
 17 files changed, 349 insertions(+), 106 deletions(-)

-- 
2.25.1

