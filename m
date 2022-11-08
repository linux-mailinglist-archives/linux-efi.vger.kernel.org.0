Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B8AB621BC8
	for <lists+linux-efi@lfdr.de>; Tue,  8 Nov 2022 19:22:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234312AbiKHSW1 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 8 Nov 2022 13:22:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234769AbiKHSW0 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 8 Nov 2022 13:22:26 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CB68E63
        for <linux-efi@vger.kernel.org>; Tue,  8 Nov 2022 10:22:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1BA1961725
        for <linux-efi@vger.kernel.org>; Tue,  8 Nov 2022 18:22:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC87DC433D6;
        Tue,  8 Nov 2022 18:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667931743;
        bh=7KTOHQgQNiVS1k9MMhWHllX/ItO65TK+RnTvpa43MpM=;
        h=From:To:Cc:Subject:Date:From;
        b=oSjUmhIrBFHzTqCbkle/Uquc/h/HLjugfsMRVIApozVHZAGK45v9VGXWnhck0K0nU
         b6fyzG6q9mDgLvQuThwQmw3ROO5EbzPxVijtenpHQ+sjgRtSlhOyylQg4Bunkl0HsR
         rtigwuSmPJR602HhiAXD8VThH49WOPxkzkOecuqedpcosArPTB54k30GmlkUSCDYms
         nuZ9huMCYDjq14XV2o+FYiYPoo+zf7HI5qPubnbsbTFCMJLwVTlgYg6XZNDaIk44ap
         TN5QnJL9JPZw28z6YlYj75RgW0PkAuy2ddtMWGZJG3U79lD/sKn94FhzsUW5P+dGOl
         8ovZ+D4HSc4aA==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-efi@vger.kernel.org, keescook@chromium.org,
        Ard Biesheuvel <ardb@kernel.org>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v5 0/7] arm64: efi: leave MMU and caches on at boot
Date:   Tue,  8 Nov 2022 19:21:57 +0100
Message-Id: <20221108182204.2447664-1-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2957; i=ardb@kernel.org; h=from:subject; bh=7KTOHQgQNiVS1k9MMhWHllX/ItO65TK+RnTvpa43MpM=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBjap4/7kf4dTo8ns7jXKIE3a0LqfmKE9PSUIguHZ3Z Mt4G9lyJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCY2qePwAKCRDDTyI5ktmPJI/mC/ kBgDNf01cXFP2YZfyCk4pofdb1TfR3yHUrtpC4SAP0D1GFDcC2s7i55wXrIMGd582NGtu2vvRE7vKI u8t/Ac6+5zyP0AbUCTEg7Phz29Ddx7MOC1etbiV+oQhyrzzHYM0hdLBGw3xxeNCjVSw3y662RuBKtV I+gOoFFmWW4MU2L9xPG9YAudRZJDJhVEss+SDAGN723TFmY0OcZPvsI3aO3ERFPXdoyn8R8s25zxPf FZqz3EY1nSuZjBWSd7gBdZQtfqGb7XZ5pa8MRpTG4W1zXpM1m70dYUSbfMV8GzUrGqa2DujNGPPOhz nsOsbioroCwK96ODU173MqvuhX8tcU9n1AlDIGHrKaEJ0QLvv0TwvyKdct/W9wutGHKZG78GRCvVOB VXUgWEjmzZQW5fPYsgzrbEvL+saKMK29RRQbTAtbkDcFMsIHZOfjdNHmn7HuTjYRXs88ekLz7CSixZ OqAQz62ehoPVoNAjP5GYCQMdNTtWlIIIAIrJXOOJNgf3o=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

Changes since v4:
- add patch to align the callers of finalise_el2()
- also clean HYP text to the PoC when booting at EL2 with the MMU on
- add a warning and a taint when doing non-EFI boot with the MMU and
  caches enabled
- rebase onto zboot changes in efi/next - this means that patches #6 and
  #7 will not apply onto arm64/for-next so a shared stable branch will
  be needed if we want to queue this up for v6.2

Changes since v3:
- drop EFI_LOADER_CODE memory type patch that has been queued in the
  mean time
- rebased onto [partial] series that moves efi-entry.S into the libstub/
  source directory
- fixed a correctness issue in patch #2

Cc: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>

Ard Biesheuvel (7):
  arm64: head: Move all finalise_el2 calls to after __enable_mmu
  arm64: kernel: move identity map out of .text mapping
  arm64: head: record the MMU state at primary entry
  arm64: head: avoid cache invalidation when entering with the MMU on
  arm64: head: Clean the ID map and the HYP text to the PoC if needed
  arm64: lds: reduce effective minimum image alignment to 64k
  efi: arm64: enter with MMU and caches enabled

 arch/arm64/include/asm/efi.h               |  9 +-
 arch/arm64/kernel/head.S                   | 93 +++++++++++++++-----
 arch/arm64/kernel/image-vars.h             |  5 +-
 arch/arm64/kernel/setup.c                  |  9 +-
 arch/arm64/kernel/sleep.S                  |  6 +-
 arch/arm64/kernel/vmlinux.lds.S            | 13 ++-
 arch/arm64/mm/cache.S                      |  5 +-
 arch/arm64/mm/proc.S                       |  2 -
 drivers/firmware/efi/libstub/Makefile      |  4 +-
 drivers/firmware/efi/libstub/arm64-entry.S | 67 --------------
 drivers/firmware/efi/libstub/arm64-stub.c  | 26 ++++--
 drivers/firmware/efi/libstub/arm64.c       | 41 +++++++--
 include/linux/efi.h                        |  6 +-
 13 files changed, 159 insertions(+), 127 deletions(-)
 delete mode 100644 drivers/firmware/efi/libstub/arm64-entry.S

-- 
2.35.1

