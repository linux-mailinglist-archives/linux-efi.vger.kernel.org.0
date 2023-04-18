Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EC046E6656
	for <lists+linux-efi@lfdr.de>; Tue, 18 Apr 2023 15:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231681AbjDRNuE (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 18 Apr 2023 09:50:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbjDRNuD (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 18 Apr 2023 09:50:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3601D10DE
        for <linux-efi@vger.kernel.org>; Tue, 18 Apr 2023 06:50:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D145B62765
        for <linux-efi@vger.kernel.org>; Tue, 18 Apr 2023 13:50:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6E59C433D2;
        Tue, 18 Apr 2023 13:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681825801;
        bh=2ByK/0kia9G6JKOfj69pt/lG+ugP0FXXlC2klH9ZMxs=;
        h=From:To:Cc:Subject:Date:From;
        b=jga1qyp7YCXGuwFH+cZwO+jj3GyYezmfToRx57St1O7dl1TU0nG5ChSxHBaFjUXVL
         4EELv6SAtxnODxgyGfrJ2CoF29QbuBHxIVkskklfQ3C4nRY5R+geshpxM16JVOlPFq
         Qp8htAb0ktrSGx5W4+V91xYsXHaaI99w/fi4EEN0crY3yM92IDJ/PTtTAWZEwQ1msr
         kEq05PcqEC9wn63CMnN+L7IgMRcSabDAs/UWrmvFytM1v7G2F/FKdZX95eT0+i5JMQ
         pZeDPnqiD9INWmIf28HR/in/A93DHgQmr00CmtNZEMa5jseoH/He/NzjNscQvd5tQU
         a5mQQisAMZtTA==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, mark.rutland@arm.com,
        broonie@kernel.org, will@kernel.org, catalin.marinas@arm.com,
        Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH v2 0/6] arm64/efi/zboot: Clean up and enable BTI annotation
Date:   Tue, 18 Apr 2023 15:49:46 +0200
Message-Id: <20230418134952.1170141-1-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1722; i=ardb@kernel.org; h=from:subject; bh=2ByK/0kia9G6JKOfj69pt/lG+ugP0FXXlC2klH9ZMxs=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIcVu/g/rdCn7voedi+9tz3A5nMQtKjvjzsb//BNEvNJe3 T7b9jqjo5SFQYyDQVZMkUVg9t93O09PlKp1niULM4eVCWQIAxenAExk8mVGhsPSjxZMsXqz3e3R J3Yfofvfim2vvHpxlDOu9lTbm+ctcx4wMiw6dDuUTc6e4/m6bWvmTglX+6OaxPPmhdfmfwaO4qn LxdgA
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Some tweaks for the arm64 EFI header and the zboot version, to add the
annotation that informs the loader that the code regions may be mapped
with BTI enforcement enabled.

As a related cleanup, add the combined codesize (text+rodata+inittext)
to the arm64 Image header, so the EFI zboot loader can grab it from the
image after decompressing it.

Changes since v1:
- instead of adding a proper header field, only pass the code size via
  the image header when generating the zboot image, using the
  text_offset field which still has meaning in the bare metal ABI (which
  means bare metal loaders must honour it) but is actually no longer in
  use.

Ard Biesheuvel (6):
  efi/pe: Import new BTI/IBT header flags from the spec
  arm64: efi: Enable BTI codegen and add PE/COFF annotation
  efi/zboot: arm64: Poke kernel code size into the zboot payload image
    header
  efi/zboot: Add BSS padding before compression
  efi/zboot: Set forward edge CFI compat header flag if supported
  efi/zboot: arm64: Grab code size from image header

 arch/arm64/boot/Makefile                    | 24 ++++++-
 arch/arm64/kernel/efi-header.S              | 71 ++++++++++++--------
 arch/arm64/kernel/image-vars.h              |  4 ++
 drivers/firmware/efi/libstub/Makefile       |  3 +-
 drivers/firmware/efi/libstub/Makefile.zboot | 41 +++++++----
 drivers/firmware/efi/libstub/arm64.c        | 26 +++++--
 drivers/firmware/efi/libstub/efistub.h      |  3 +-
 drivers/firmware/efi/libstub/zboot-header.S | 51 +++++++++-----
 drivers/firmware/efi/libstub/zboot.c        | 13 +---
 include/linux/pe.h                          |  4 ++
 10 files changed, 160 insertions(+), 80 deletions(-)

-- 
2.39.2

