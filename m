Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E69F5A388C
	for <lists+linux-efi@lfdr.de>; Sat, 27 Aug 2022 17:59:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232214AbiH0P7H (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 27 Aug 2022 11:59:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbiH0P7G (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 27 Aug 2022 11:59:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D75229CBD
        for <linux-efi@vger.kernel.org>; Sat, 27 Aug 2022 08:59:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 29733B80955
        for <linux-efi@vger.kernel.org>; Sat, 27 Aug 2022 15:59:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13E30C433C1;
        Sat, 27 Aug 2022 15:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661615942;
        bh=Zc4YrJv1PKS6UmK/2ZaBAZTAapFWIn3lpJIv2guccUc=;
        h=From:To:Cc:Subject:Date:From;
        b=kyit3FMZBNt+KVkp7FkzCwlAVy4+RWSnwiUd+F9SazPQq6BY+vyqEXPGthPkK1SAM
         adE3lGSXvWlto05w/mNVn+LclKdVRQG8RsSh1VMLyB99fK8mFMscVIM7V6UeUDzgtr
         qAYfDwqIoHL6wZIqOVWmfh+z21Dnds8A0K55nKX4BckYHK29tg0cudeKg3CXqYl3fC
         fdWNSc74ADf4oko2SjlmGjYpHosyozTpLhoiKo0aKlHEk38FBASAm8hzEbCgp5kxbi
         3q8nPjaSzNvMcy08wjRau/AKezpfDdl77HTH96+sT/lLuR/yw/9kvVP4fdnS/6OqMX
         VNPPEoYL/Y5zg==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     will@kernel.org, catalin.marinas@arm.com, maz@kernel.org,
        mark.rutland@arm.com, linux-efi@vger.kernel.org,
        keescook@chromium.org, Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH v3 0/7] arm64: efi: leave MMU and caches on at boot
Date:   Sat, 27 Aug 2022 17:58:45 +0200
Message-Id: <20220827155852.3338551-1-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2370; i=ardb@kernel.org; h=from:subject; bh=Zc4YrJv1PKS6UmK/2ZaBAZTAapFWIn3lpJIv2guccUc=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBjCj8ulIUNsSetCk7QzKICxL5C5HGjRxFT5CoMtrG6 RTSNojmJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYwo/LgAKCRDDTyI5ktmPJBtdC/ 4mxMAauudObV/s7D67c7EpyAPdghKDu/T3b4QTCW/uT8P4cDZN/GMWCAcl6G5ZMT4+AAI+eqZLnMHl PMtR1jKq1oI1JIFuzrTsTjIPY859nJK/hbjq8Cu2EmpRTZC6A4A3Opp+M4pW97VAVonx6uDG1mohLe V2YhaTVzeJRdGBTxEby6IVK4k5X64TEftP/GRgOmANXx0YutR2KKQoZeATh/25IfwgD3puwm+I78IU 0iQYT23R/4k+kEUC0SKlTnCDn0P6qcJdMyEvlufzeTJWJ5XOn3i1sJ+QFEXu1CarGnBs5TCKsm+8uW F1KXGVqoeWvlg0QiQreAW5gocvzI3stEz295L5VbbIQ2bJngH1q1IyQUSb95HdQLR4GAEgpF/EdWbD qhHm+L8Zan+YKTOAlA3xYnpp/CbGE7ceTkxEOhEYw70vXe2ERbSCEkjVP+Rf3fN96K3IuW9/dCvnuF x8wQ5/yUA5srydZqFfeJ6Afjy+ymrL1+yv/3/TcyN2P3s=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Even though some of the patches in this series made an appearance in my
WXN series as well, this set amounts to a v3 of $SUBJECT, with only the
pieces that remain now that the groundwork has been merged into
v6.0-rc1. The v2 can be found here:
https://lore.kernel.org/all/20220330154205.2483167-1-ardb@kernel.org/

The purpose of this series is to remove any explicit cache maintenance
for coherency during early boot that becomes unnecessary if we simply
retain the cacheable 1:1 mapping of all of system RAM provided by EFI,
and use it to populate the ID map page tables. After setting up this
preliminary ID map, we disable the MMU, drop to EL1, reprogram the MAIR,
TCR and SCTLR registers as before, and proceed as usual, avoiding the
need for any manipulations of memory while the MMU and caches are off.

The only property of the firmware provided 1:1 map we rely on is that it
does not require any explicit cache maintenance for coherency - all else
is under control of the kernel itself, as before.

Ard Biesheuvel (7):
  arm64: lds: reduce effective minimum image alignment to 64k
  arm64: kernel: move ID map out of .text mapping
  arm64: head: record the MMU state at primary entry
  arm64: head: avoid cache invalidation when entering with the MMU on
  arm64: head: clean the ID map page to the PoC
  arm64: efi/libstub: use EFI_LOADER_CODE region when moving the kernel
    in memory
  arm64: efi/libstub: enter with the MMU on

 arch/arm64/include/asm/efi.h               |  7 --
 arch/arm64/kernel/Makefile                 |  9 +--
 arch/arm64/kernel/efi-entry.S              | 69 --------------------
 arch/arm64/kernel/head.S                   | 46 +++++++++++--
 arch/arm64/kernel/image-vars.h             |  6 +-
 arch/arm64/kernel/vmlinux.lds.S            | 13 +++-
 arch/arm64/mm/cache.S                      |  5 +-
 arch/arm64/mm/proc.S                       |  2 -
 drivers/firmware/efi/libstub/alignedmem.c  |  5 +-
 drivers/firmware/efi/libstub/arm64-stub.c  | 26 ++++++--
 drivers/firmware/efi/libstub/efistub.h     |  6 +-
 drivers/firmware/efi/libstub/mem.c         |  3 +-
 drivers/firmware/efi/libstub/randomalloc.c |  5 +-
 include/linux/efi.h                        |  6 +-
 14 files changed, 95 insertions(+), 113 deletions(-)
 delete mode 100644 arch/arm64/kernel/efi-entry.S

-- 
2.35.1

