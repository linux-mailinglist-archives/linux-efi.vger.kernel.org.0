Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21F2B3CF555
	for <lists+linux-efi@lfdr.de>; Tue, 20 Jul 2021 09:33:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231366AbhGTGwm (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 20 Jul 2021 02:52:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:42244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229916AbhGTGwm (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 20 Jul 2021 02:52:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BD61F61165;
        Tue, 20 Jul 2021 07:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626766400;
        bh=rW9S7ogWFZZraiZY3Dvv5WOzU9HQmKUcmM+vyw6+Kss=;
        h=From:To:Cc:Subject:Date:From;
        b=TvkQtlMNnOkK1/xAcOuz08Sb5uj9fGvO+EVXCbe24VDTEQTNsaZagR6cyCrv4i1Zc
         l1qACGPDNzHeLnc4ghlOEgPRwNXzyPgKyP7InVFg7NhTjKDiudYtC5IEyoB33bAU8f
         RErfpUg/Q+1LhAGJp8SyW5Okdz4JyHLTBqNXa1BjaaNeHNOVQT2ebxwfOs3TBhaf1X
         HSYPOHST5X0ECscQVtU3OKFXWDJLAS+9A11wDQWUqa7MBbmRXnBTFG4lNdznmP16YU
         YhTs93lvWRWjiYP0U/5Anogb4dpvHDNvp9fRIgz46DzTiTK/Fg5WxRJh/lPxFsx4X/
         k8b1vLwoKCW6A==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>
Subject: [GIT PULL] EFI fixes for v5.14-rc2
Date:   Tue, 20 Jul 2021 09:33:11 +0200
Message-Id: <20210720073311.55452-1-ardb@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The following changes since commit e73f0f0ee7541171d89f2e2491130c7771ba58d3:

  Linux 5.14-rc1 (2021-07-11 15:07:40 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-urgent-for-v5.14-rc2

for you to fetch changes up to 47e1e233e9d822dfda068383fb9a616451bda703:

  efi/mokvar: Reserve the table only if it is in boot services data (2021-07-20 09:28:09 +0200)

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Borislav Petkov <bp@alien8.de>

----------------------------------------------------------------
EFI fixes for v5.14-rc2:

- Ensure that memblock reservations and IO reserved resources remain in
sync when using the EFI memreserve feature.
- Don't complain about invalid TPM final event log table if it is
missing altogether.
- Comment header fix for the stub.
- Avoid a spurious warning when attempting to reserve firmware memory
that is already reserved in the first place.

----------------------------------------------------------------
Atish Patra (1):
      efi/libstub: Fix the efi_load_initrd function description

Borislav Petkov (1):
      efi/mokvar: Reserve the table only if it is in boot services data

Marc Zyngier (1):
      firmware/efi: Tell memblock about EFI iomem reservations

Michal Suchanek (1):
      efi/tpm: Differentiate missing and invalid final event log table.

 drivers/firmware/efi/efi.c                     | 13 ++++++++++++-
 drivers/firmware/efi/libstub/efi-stub-helper.c |  4 ++--
 drivers/firmware/efi/mokvar-table.c            |  5 ++++-
 drivers/firmware/efi/tpm.c                     |  8 +++++---
 4 files changed, 23 insertions(+), 7 deletions(-)
