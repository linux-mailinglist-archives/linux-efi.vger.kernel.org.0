Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 693486D6711
	for <lists+linux-efi@lfdr.de>; Tue,  4 Apr 2023 17:20:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235583AbjDDPUL (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 4 Apr 2023 11:20:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235595AbjDDPUI (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 4 Apr 2023 11:20:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B40144488
        for <linux-efi@vger.kernel.org>; Tue,  4 Apr 2023 08:20:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5002A635AD
        for <linux-efi@vger.kernel.org>; Tue,  4 Apr 2023 15:20:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D8DCC433EF;
        Tue,  4 Apr 2023 15:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680621606;
        bh=bmx05/9L9HmqEuX9FxtcTRzHw8Tj9+xjoqSPcHU9RrE=;
        h=From:To:Cc:Subject:Date:From;
        b=gWYnS+BHUWP927mDpZBhn2USrwWBCauWknnLAEc78npzuFfs2L52FOOx7eJlz/WmN
         xnsv95l1s54ky3JysdOnIADN8Eror4TLgWZ1fNGovoPjFySQHYbRFjrosmKT/zJlpH
         bd3v6DGyunRpE8Z1nSHYAmmeQ0LaBGdMHOm6vdz+V6MJe6ObL8yxqYaUeEvdAMooq3
         XUbGRFjgJ6dtMUe1o9yo99CqJMMoF1dA8QjtQ/YXhb1wqn76A+MutsRKCSq6mVSqnW
         4MOTiCGrYt1qxU1jJxyE4OIZXVPDGDaszPzqgfwVM5hBMAsqo6pqPZ00ZpxA7lVSy5
         DdcBpxRYM+tcw==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, will@kernel.org,
        catalin.marinas@arm.com, mark.rutland@arm.com, broonie@Kernel.org,
        Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH 0/6] arm64/efi/zboot: Clean up and enable BTI annotation
Date:   Tue,  4 Apr 2023 17:19:53 +0200
Message-Id: <20230404151959.2774612-1-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1533; i=ardb@kernel.org; h=from:subject; bh=bmx05/9L9HmqEuX9FxtcTRzHw8Tj9+xjoqSPcHU9RrE=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIUXHQWx38d6qeBP1CxE1xWfc1k8pcrnWd+rZ2vrXJr9yp RZz7W3qKGVhEONgkBVTZBGY/ffdztMTpWqdZ8nCzGFlAhnCwMUpABNZps3wV252uPl20bIrZybJ 7I6y+p+Y+yfsI0d9mP4rJp6lF6/d0mf47xKjf6ru87flMnU6Cl9eFd//0uxp5rjZflsL17at6Z0 2rAA=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
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

Ard Biesheuvel (6):
  efi/pe: Import new BTI/IBT header flags from the spec
  arm64: efi: Enable BTI codegen and add PE/COFF annotation
  arm64: image: Add code size to the image header
  efi/zboot: Add BSS padding before compression
  efi/zboot: Set forward edge CFI compat header flag if supported
  efi/zboot: arm64: Grab code size from image header

 Documentation/arm64/booting.rst             |  3 +-
 arch/arm64/boot/Makefile                    |  1 +
 arch/arm64/include/asm/image.h              |  3 +-
 arch/arm64/kernel/efi-header.S              | 71 ++++++++++++--------
 arch/arm64/kernel/head.S                    |  3 +-
 arch/arm64/kernel/image.h                   | 10 ++-
 drivers/firmware/efi/libstub/Makefile       |  3 +-
 drivers/firmware/efi/libstub/Makefile.zboot | 41 +++++++----
 drivers/firmware/efi/libstub/arm64.c        | 18 +++--
 drivers/firmware/efi/libstub/efistub.h      |  3 +-
 drivers/firmware/efi/libstub/zboot-header.S | 51 +++++++++-----
 drivers/firmware/efi/libstub/zboot.c        | 13 +---
 include/linux/pe.h                          |  4 ++
 13 files changed, 139 insertions(+), 85 deletions(-)

-- 
2.39.2

