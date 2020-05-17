Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1F641D67EC
	for <lists+linux-efi@lfdr.de>; Sun, 17 May 2020 14:10:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727893AbgEQMKD (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 17 May 2020 08:10:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:41054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727833AbgEQMKD (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sun, 17 May 2020 08:10:03 -0400
Received: from e123331-lin.nice.arm.com (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0FCC7204EC;
        Sun, 17 May 2020 12:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589717402;
        bh=auZDmc8uW6OcQB29fEJ/RnVaomBCvmNLzYuYDuMv4n8=;
        h=From:To:Cc:Subject:Date:From;
        b=OhDp4xjxAPH8UmXGt0bUrepFuOBr9FJ4zkNK/zQqlf6R0qvFgOcwan2lzTUyaxtcL
         yf5Cb5Joq00APMtzgpMh6B2WU4RNjzPKIBzyEKVhod/dQRw060KiAyDSJzQYht9vP4
         X+KAUOuXUhCGAMjJh1Jqc8w8KHVnoSTRJD1s3hoI=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux+pull@armlinux.org.uk
Subject: [GIT PULL] ARM: simplify handover from UEFI to decompressor
Date:   Sun, 17 May 2020 14:09:59 +0200
Message-Id: <20200517120959.7191-1-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The following changes since commit 91e4f3d37e1a932396801fc2831286353821ff23:

  ARM: 8972/1: boot: Obtain start of physical memory from DTB (2020-04-29 13:30:29 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git tags/pr-efi-arm-no-relocate

for you to fetch changes up to ea98a6da3baf477541f8cbb036d1827e6b84ac91:

  ARM: decompressor: run decompressor in place if loaded via UEFI (2020-05-06 09:58:24 +0200)

----------------------------------------------------------------
Simply EFI handover to decompressor

The EFI stub in the ARM kernel runs in the context of the firmware, which
means it usually runs with the caches and MMU on. Currently, we relocate
the zImage so it appears in the first 128 MiB, disable the MMU and caches
and invoke the decompressor via its ordinary entry point. However, since we
can pass the base of DRAM directly, there is no need to relocate the zImage,
which also means there is no need to disable and re-enable the caches and
create new page tables etc.

----------------------------------------------------------------
Ard Biesheuvel (5):
      ARM: decompressor: move headroom variable out of LC0
      ARM: decompressor: split off _edata and stack base into separate object
      ARM: decompressor: defer loading of the contents of the LC0 structure
      ARM: decompressor: move GOT into .data for EFI enabled builds
      ARM: decompressor: run decompressor in place if loaded via UEFI

 arch/arm/boot/compressed/head.S           | 91 +++++++++++++------------------
 arch/arm/boot/compressed/vmlinux.lds.S    |  5 ++
 drivers/firmware/efi/libstub/arm32-stub.c | 45 ++-------------
 3 files changed, 48 insertions(+), 93 deletions(-)
