Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 951B27A7466
	for <lists+linux-efi@lfdr.de>; Wed, 20 Sep 2023 09:39:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233727AbjITHju (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 20 Sep 2023 03:39:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233681AbjITHjt (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 20 Sep 2023 03:39:49 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D0CE9E;
        Wed, 20 Sep 2023 00:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695195583; x=1726731583;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=hcN5dyOX2piu1MHW4eheSWMp4q3vJNBIWWMTg8pcyZs=;
  b=IkncGxvFMn56sh7LB+j2t1jKzPhwILqqk1RfcHzPjYRbW4WCJ2swrQaf
   4YQ2YYguw4ClQxy9cHRacCrTi6rMmsRXeli2+36xi2KkU6hW9Wstrut92
   OLD1G21tsEtJllC+f78CBNxgtP/LNx6ne2ToFhD1Dh7WdClMOg8vNUuHF
   7JLTVSfJ+gKM6O1uqAjsMFHeksVcsx3suWqnwirgcp14Zmi+rIX0uQNeq
   VENuLN45pvkAjiHfQAJTbUIdwKMgB5Qx3eQG5TQxVAuD8yS+br6QFi7iC
   X0ucrYeDWkH7k2X/KRdfKAwPVzyH8N0sBciC8KBWAD6ZuGLZaGpipcIRA
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="446622591"
X-IronPort-AV: E=Sophos;i="6.02,161,1688454000"; 
   d="scan'208";a="446622591"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2023 00:39:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="816791812"
X-IronPort-AV: E=Sophos;i="6.02,161,1688454000"; 
   d="scan'208";a="816791812"
Received: from xiao-desktop.sh.intel.com ([10.239.46.158])
  by fmsmga004.fm.intel.com with ESMTP; 20 Sep 2023 00:39:39 -0700
From:   Xiao Wang <xiao.w.wang@intel.com>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, ardb@kernel.org
Cc:     anup@brainfault.org, haicheng.li@intel.com,
        ajones@ventanamicro.com, linux-riscv@lists.infradead.org,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xiao Wang <xiao.w.wang@intel.com>
Subject: [PATCH v2 0/2] riscv: Optimize bitops with Zbb extension
Date:   Wed, 20 Sep 2023 15:46:51 +0800
Message-Id: <20230920074653.2509631-1-xiao.w.wang@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

The first patch rearranges the content in hwcap.h cpufeature.h, it helps
to avoid a cyclic header including issue for patch 2.

The second patch leverages the alternative mechanism to dynamically apply
this optimization.

The series has following dependency:
https://lore.kernel.org/linux-riscv/20230918131518.56803-8-ajones@ventanamicro.com/

Thanks,
Xiao

v2:
- Remove the "EFI_" prefix from macro name "EFI_NO_ALTERNATIVE" to make it
  generic. (Ard)
- patch-1 is added, it's based on "RISC-V: Enable cbo.zero in usermode". (Andrew)

Xiao Wang (2):
  riscv: Rearrange hwcap.h and cpufeature.h
  riscv: Optimize bitops with Zbb extension

 arch/riscv/include/asm/bitops.h       | 266 +++++++++++++++++++++++++-
 arch/riscv/include/asm/cpufeature.h   |  83 ++++++++
 arch/riscv/include/asm/hwcap.h        |  91 ---------
 arch/riscv/include/asm/pgtable.h      |   1 +
 arch/riscv/include/asm/switch_to.h    |   2 +-
 arch/riscv/include/asm/vector.h       |   2 +-
 drivers/firmware/efi/libstub/Makefile |   2 +-
 7 files changed, 350 insertions(+), 97 deletions(-)

-- 
2.25.1

