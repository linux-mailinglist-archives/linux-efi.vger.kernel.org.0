Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE4656029CE
	for <lists+linux-efi@lfdr.de>; Tue, 18 Oct 2022 13:05:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbiJRLFD (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 18 Oct 2022 07:05:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbiJRLEz (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 18 Oct 2022 07:04:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD0911FCD3
        for <linux-efi@vger.kernel.org>; Tue, 18 Oct 2022 04:04:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1958FB81D4C
        for <linux-efi@vger.kernel.org>; Tue, 18 Oct 2022 11:04:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16E08C433D6;
        Tue, 18 Oct 2022 11:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666091090;
        bh=p2GzVR7CDEVST3fskml0dtCDxTSRl+k3mcvEEY33Or4=;
        h=From:To:Cc:Subject:Date:From;
        b=NlWl9PawVuA+SlfKAY2hA7TefSWSDSceR+XQ8Eyczorn4XWn4MoBGYwOA6hqFoJ+G
         HKphrvdbywHBLM3eyaM5hLrGK0vo+W9EWm71FBKxJeixaJHh3rI3VmWgDjJSMLR7ZY
         g73U0n8AF/g5snEQORx/6Y+38q972OQh4S9ftPn7cS9gkFUT/NHOMsuwzfKN8n7prX
         aCV5+LOYGqMFUi+5nEECFe3YMGWK2TzjQKitbr75SrW8DjwwrmAmm1K6RTRSch/YQ2
         MxhnhYslQG9fjDsVZ9UTSPRSas46rQT92thdsbhZZtElq3prgfrX6KqBlehOdwcAEy
         AvI7EhToO6Jpg==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-efi@vger.kernel.org, keescook@chromium.org,
        Ard Biesheuvel <ardb@kernel.org>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v4 0/6] arm64: efi: leave MMU and caches on at boot
Date:   Tue, 18 Oct 2022 13:04:35 +0200
Message-Id: <20221018110441.3855148-1-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2479; i=ardb@kernel.org; h=from:subject; bh=p2GzVR7CDEVST3fskml0dtCDxTSRl+k3mcvEEY33Or4=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBjTog6MkiEZimE+24iR2sKsysS21ikI266zpw6I6yM ML/PYdSJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCY06IOgAKCRDDTyI5ktmPJBMvC/ 9thiErL7/pXNZ/I8OIsAHcB0fwLk4++SnkFzvpNau4AUlg60Ao4S2e4mQbfU52W8TGEaoH1w3WsAZ6 8nW0p+25GVzzBRZYk0gXJGfCyji2vxnKeMZB8b1UZIWk8v2T8jfTf91gQJJOdcenxXl2mfOrYcRs7l aIOnYok6tWjAVcmqG4YTb2slqu3JSUuIbv4G9AU/OPSYf2Rm6GVIEcdCmj/jjI2JMbY4ML6nJCGUam UInfuiFr27JC0oqNg7CCHO1vKRMn7iKZl4hVelvhTB4u3RKE+QwzQU8mGZx8L/9sHNNHrtliPUR4QU F9lsoy5o4vsVapmqpbAIlJTKg+9jDyTsJzJJQ/B2Jygw31mYlCxxxP/BqAALwoa9LpE1dXy70VkrrB Oj+0653Nul9TB3MR9b35SWyk/AxfVN+7KkOYRydGfZqiHCca/5AuNdPVZ0dKHL1LleZOcFccNVaHwr G2asyU8Nrj6aZ4Pl7vqwMyuVY+XKm6+Bds7KUE7NnOQTg=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The purpose of this series is to remove any explicit cache maintenance
for coherency during early boot that becomes unnecessary if we simply
retain the cacheable 1:1 mapping of all of system RAM provided by EFI,
and use it to populate the ID map page tables. After setting up this
preliminary ID map, we disable the MMU, drop to EL1, reprogram the MAIR,
TCR and SCTLR registers as before, and proceed as usual, avoiding the
need for any manipulations of memory while the MMU and caches are off.

The only properties of the firmware provided 1:1 map we rely on is that
it does not require any explicit cache maintenance for coherency, and
that it covers the entire memory footprint of the image, including the
BSS and padding at the end - all else is under control of the kernel
itself, as before.

Changes since v3:
- drop EFI_LOADER_CODE memory type patch that has been queued in the
  mean time
- rebased onto [partial] series that moves efi-entry.S into the libstub/
  source directory [0]
- fixed a correctness issue in patch #2

[0] https://lore.kernel.org/all/20221017171700.3736890-1-ardb@kernel.org/

Applying the last patch in the series will require some coordination
with the EFI tree, but I can manage that using a secondary 'late' PR
during the merge window, if needed.

Cc: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>

Ard Biesheuvel (6):
  arm64: lds: reduce effective minimum image alignment to 64k
  arm64: kernel: move identity map out of .text mapping
  arm64: head: record the MMU state at primary entry
  arm64: head: avoid cache invalidation when entering with the MMU on
  arm64: head: clean the ID map page to the PoC
  arm64: efi/libstub: enter with the MMU on

 arch/arm64/include/asm/efi.h               |  7 --
 arch/arm64/kernel/head.S                   | 70 +++++++++++++++-----
 arch/arm64/kernel/image-vars.h             |  5 +-
 arch/arm64/kernel/vmlinux.lds.S            | 13 +++-
 arch/arm64/mm/cache.S                      |  5 +-
 arch/arm64/mm/proc.S                       |  2 -
 drivers/firmware/efi/libstub/arm64-entry.S | 57 ----------------
 drivers/firmware/efi/libstub/arm64-stub.c  | 19 +++++-
 include/linux/efi.h                        |  6 +-
 9 files changed, 89 insertions(+), 95 deletions(-)
 delete mode 100644 drivers/firmware/efi/libstub/arm64-entry.S

-- 
2.35.1

