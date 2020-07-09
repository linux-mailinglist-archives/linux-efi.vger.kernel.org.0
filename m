Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8375521A0D7
	for <lists+linux-efi@lfdr.de>; Thu,  9 Jul 2020 15:28:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbgGIN2M (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 9 Jul 2020 09:28:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:55778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726444AbgGIN2M (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 9 Jul 2020 09:28:12 -0400
Received: from e123331-lin.nice.arm.com (adsl-53.109.242.3.tellas.gr [109.242.3.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C29F2065D;
        Thu,  9 Jul 2020 13:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594301291;
        bh=qKFlvzdKJIdXoAJvOUJRYxlcZWO4xSIwX0ct9M196ow=;
        h=From:To:Cc:Subject:Date:From;
        b=yBeMvLkmO+C1myn6KOIxDoMPvqQINLIx+TfT0cX8lKhQlrZLG9vrqmAwWp1GWZNjJ
         GcqePWa0a8pkYBrP0oBs9AM/oCGn2swHvpfUSx3NfuTpMez9h1f7XIzf3XZaab/KY/
         nIoGSboyceuPSb3gs3oKzTcAHPPZTSLmAZF2x5Qw=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, mingo@kernel.org,
        tglx@linutronix.de, bp@alien8.de
Subject: [GIT PULL] EFI fixes for v5.8-rc
Date:   Thu,  9 Jul 2020 16:28:07 +0300
Message-Id: <20200709132807.32232-1-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The following changes since commit 2a55280a3675203496d302463b941834228b9875:

  efi/libstub: arm: Print CPU boot mode and MMU state at boot (2020-06-17 15:29:11 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-urgent-for-v5.8-rc4

for you to fetch changes up to 769e0fe1171e95d90ea5a2d6d0b2bdc7d5d2e7b2:

  efi: Revert "efi/x86: Fix build with gcc 4" (2020-07-09 10:14:29 +0300)

----------------------------------------------------------------
EFI fixes for v5.8-rc4:
- Fix the layering violation in the use of the EFI runtime services
  availability mask in users of the 'efivars' abstraction
- Revert build fix for GCC v4.8 which is no longer supported
- Some fixes for build issues found by Atish while working on RISC-V support
- Avoid --whole-archive when linking the stub on arm64
- Some x86 EFI stub cleanups from Arvind

----------------------------------------------------------------
Ard Biesheuvel (2):
      efi/efivars: Expose RT service availability via efivars abstraction
      efi: Revert "efi/x86: Fix build with gcc 4"

Arvind Sankar (2):
      efi/x86: Remove unused variables
      efi/x86: Only copy upto the end of setup_header

Atish Patra (2):
      efi/libstub: Fix gcc error around __umoddi3 for 32 bit builds
      efi/libstub: Move the function prototypes to header file

Masahiro Yamada (1):
      efi/libstub/arm64: link stub lib.a conditionally

 arch/arm64/Makefile                       |  2 +-
 drivers/firmware/efi/efi-pstore.c         |  5 +----
 drivers/firmware/efi/efi.c                | 12 ++++++++----
 drivers/firmware/efi/efivars.c            |  5 +----
 drivers/firmware/efi/libstub/Makefile     |  3 +--
 drivers/firmware/efi/libstub/alignedmem.c |  2 +-
 drivers/firmware/efi/libstub/efi-stub.c   | 17 -----------------
 drivers/firmware/efi/libstub/efistub.h    | 16 ++++++++++++++++
 drivers/firmware/efi/libstub/x86-stub.c   |  8 ++++----
 drivers/firmware/efi/vars.c               |  6 ++++++
 fs/efivarfs/super.c                       |  6 +++---
 include/linux/efi.h                       |  1 +
 12 files changed, 43 insertions(+), 40 deletions(-)
