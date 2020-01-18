Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 137DD14188A
	for <lists+linux-efi@lfdr.de>; Sat, 18 Jan 2020 17:57:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbgARQ52 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 18 Jan 2020 11:57:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:52460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726413AbgARQ52 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sat, 18 Jan 2020 11:57:28 -0500
Received: from e123331-lin.home (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B3B524699;
        Sat, 18 Jan 2020 16:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579366647;
        bh=7Ex+YbNBUv9PonmHqM8yogAq81g/a6PSF8+ANBO84Bo=;
        h=From:To:Cc:Subject:Date:From;
        b=FSiA+E8vHG1qaR/clKgal3RXWPzt2W/54Cs2zAjYKX2X96ze0NcJ1X4oWg9xnE/3s
         LWK/nBUCd6PHzLkkCv8EpSk553XvCKaRC4D/dBmEqZ02WdjsHMT19yGIJxPOccEi7H
         3N6LIGIR3AU8fwYR5EInKlugQQNr5/EEoiwhglbc=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     mingo@kernel.org, x86@kernel.org, Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH 0/3] EFI fixes for -next
Date:   Sat, 18 Jan 2020 17:57:02 +0100
Message-Id: <20200118165705.16544-1-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

A couple of fixes for more unusual configurations that weren't caught in
my testing before. One for KASAN, one for the LLVM linker and one for the
old EFI memory map when running on mixed mode systems.

These apply onto the Git pull request [0[ that I sent out at the beginning
of the week.

[0] https://lore.kernel.org/linux-efi/20200113172245.27925-1-ardb@kernel.org/

Ard Biesheuvel (3):
  efi/x86: avoid KASAN false positives when accessing the 1:1 mapping
  x86/boot/compressed: relax sed symbol type regex for LLVM ld.lld
  efi/x86: disallow efi=old_map in mixed mode

 arch/x86/boot/Makefile         |  2 +-
 arch/x86/platform/efi/efi_64.c | 11 ++++++-----
 arch/x86/platform/uv/bios_uv.c |  2 +-
 3 files changed, 8 insertions(+), 7 deletions(-)

-- 
2.17.1

