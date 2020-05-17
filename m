Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 231051D6809
	for <lists+linux-efi@lfdr.de>; Sun, 17 May 2020 14:58:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727979AbgEQM6b (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 17 May 2020 08:58:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:51284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727893AbgEQM6b (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sun, 17 May 2020 08:58:31 -0400
Received: from e123331-lin.nice.arm.com (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 893D2204EC;
        Sun, 17 May 2020 12:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589720310;
        bh=Rnx4PKhR9N7HkKTSbEqSZqvHuX0lxDTfH9izm/bufok=;
        h=From:To:Cc:Subject:Date:From;
        b=Z1lNhALMlTRK79px1LZ6rb2gyoKcocn1rIV58uSDYBbpgE79hr5mnBXqHehXzpgHt
         s/bJpD3kj1GSAwTcI6SPg3CueSZwZFexx4TMGY01zm1FScj4seBbFyb/k1oAe30CLd
         6XA77dQaVezUibpC0eDvv6aLgKghbd2ZXP40wq6Y=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Benjamin Thiel <b.thiel@posteo.de>,
        Borislav Petkov <bp@alien8.de>, Dave Young <dyoung@redhat.com>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Lenny Szubowicz <lszubowi@redhat.com>,
        linux-acpi@vger.kernel.org, Loic Yhuel <loic.yhuel@gmail.com>,
        Matthew Garrett <mjg59@google.com>,
        Mike Lothian <mike@fireburn.co.uk>,
        Punit Agrawal <punit1.agrawal@toshiba.co.jp>
Subject: [GIT PULL 0/7] EFI fixes for v5.7
Date:   Sun, 17 May 2020 14:57:47 +0200
Message-Id: <20200517125754.8934-1-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The following changes since commit a088b858f16af85e3db359b6c6aaa92dd3bc0921:

  efi/x86: Revert struct layout change to fix kexec boot regression (2020-04-14 08:32:17 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-urgent

for you to fetch changes up to b4f1874c62168159fdb419ced4afc77c1b51c475:

  tpm: check event log version before reading final events (2020-05-17 11:46:50 +0200)

----------------------------------------------------------------
EFI fixes for v5.7-rcX:
- fix EFI framebuffer earlycon for wide fonts
- avoid filling screen_info with garbage if the EFI framebuffer is not
  available
- fix a potential host tool build error due to a symbol clash on x86
- work around a EFI firmware bug regarding the binary format of the TPM
  final events table
- fix a missing memory free by reworking the E820 table sizing routine to
  not do the allocation in the first place
- add CPER parsing for firmware errors

----------------------------------------------------------------
Arvind Sankar (1):
      x86/boot: Mark global variables as static

Benjamin Thiel (1):
      efi: Pull up arch-specific prototype efi_systab_show_arch()

Dave Young (1):
      efi/earlycon: Fix early printk for wider fonts

Heinrich Schuchardt (1):
      efi/libstub: Avoid returning uninitialized data from setup_graphics()

Lenny Szubowicz (1):
      efi/libstub/x86: Avoid EFI map buffer alloc in allocate_e820()

Loïc Yhuel (1):
      tpm: check event log version before reading final events

Punit Agrawal (1):
      efi: cper: Add support for printing Firmware Error Record Reference

 arch/x86/boot/tools/build.c             | 16 ++++-----
 drivers/firmware/efi/cper.c             | 62 +++++++++++++++++++++++++++++++++
 drivers/firmware/efi/earlycon.c         | 14 ++++----
 drivers/firmware/efi/efi.c              |  5 +--
 drivers/firmware/efi/libstub/arm-stub.c |  6 +++-
 drivers/firmware/efi/libstub/efistub.h  | 13 +++++++
 drivers/firmware/efi/libstub/mem.c      |  2 --
 drivers/firmware/efi/libstub/tpm.c      |  5 +--
 drivers/firmware/efi/libstub/x86-stub.c | 24 +++++--------
 drivers/firmware/efi/tpm.c              |  5 ++-
 include/linux/cper.h                    |  9 +++++
 include/linux/efi.h                     |  2 ++
 12 files changed, 124 insertions(+), 39 deletions(-)
