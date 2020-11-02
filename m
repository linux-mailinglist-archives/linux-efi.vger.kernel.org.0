Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D5822A30D9
	for <lists+linux-efi@lfdr.de>; Mon,  2 Nov 2020 18:06:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727466AbgKBRGt (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 2 Nov 2020 12:06:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:59022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727458AbgKBRGt (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 2 Nov 2020 12:06:49 -0500
Received: from e123331-lin.nice.arm.com (lfbn-nic-1-188-42.w2-15.abo.wanadoo.fr [2.15.37.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8732622268;
        Mon,  2 Nov 2020 17:06:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604336808;
        bh=bsfyRFEbwlxkOFeQLjUfb1fobDszoMSkHie6mGaO9AY=;
        h=From:To:Cc:Subject:Date:From;
        b=Hu44G/DrfE/3HDWGjwJPmDkTknI1mpFTNtuvpYqOZMnf+99lOnsGdojPLUARz8YRj
         EI0e8Rbb95e+Ub2fz2kpPqH65v2TOwsEq5JSOYKVSzr/jx3NFL/yCX2mUaRDuRRA6w
         20QCzyEvyp8kkKhnDfWmE0xPAh4nVUsvKjMSaSxE=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>, Peter Jones <pjones@redhat.com>,
        Leif Lindholm <leif@nuviainc.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Matthew Garrett <mjg59@google.com>,
        Daniel Kiper <daniel.kiper@oracle.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [RFC PATCH 0/7] efi/libstub: measurement initrd data loaded by the EFI stub
Date:   Mon,  2 Nov 2020 18:06:27 +0100
Message-Id: <20201102170634.20575-1-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

This series enables measurement of the initrd data loaded directly by the
EFI stub into the TPM, using the TCG2 protocol exposed by the firmware (if
available). This ensures that the initrd observed and used by the OS is the
same one that got measured into the TPM, which is more difficult to guarantee
in the current situation.

This is posted as an RFC since it is mostly an invitation to discuss how
we can fit this into a longer term strategy for arch-agnostic secure and
measured boot that does not hinge on the Shim+GRUB tandem, or on deep
knowledge on the part of the bootloader regarding device trees, bootparams
structs, allocation and placement policies of various artifacts etc etc

Open questions:
- Should we do this?
- Are Linux systems in the field using PCR value prediction when updating the
  initrd? Does this approach interfere with that?
- Which PCR and event type to use
- Is a separator event needed here, given that the initrd measurement is
  recorded even if no initrd was loaded by the stub?

Note that the EFI stub ignores the initrd provided directly via bootparams or
the device tree, and it would be nice if we could keep doing that.

Build tested only.

Cc: Peter Jones <pjones@redhat.com>
Cc: Leif Lindholm <leif@nuviainc.com>
Cc: Arvind Sankar <nivedita@alum.mit.edu>
Cc: Matthew Garrett <mjg59@google.com>
Cc: Daniel Kiper <daniel.kiper@oracle.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>

Ard Biesheuvel (7):
  efi/libstub: whitespace cleanup
  efi/libstub: fix prototype of efi_tcg2_protocol::get_event_log()
  efi/libstub: x86/mixed: increase supported argument count
  efi/libstub: move TPM related prototypes into efistub.h
  efi/libstub: add prototype of
    efi_tcg2_protocol::hash_log_extend_event()
  efi/libstub: consolidate initrd handling across architectures
  efi/libstub: measure loaded initrd info into the TPM

 arch/x86/boot/compressed/efi_thunk_64.S       | 17 ++++--
 arch/x86/include/asm/efi.h                    | 13 +++--
 arch/x86/platform/efi/efi_thunk_64.S          | 17 ++++--
 .../firmware/efi/libstub/efi-stub-helper.c    | 56 +++++++++++++++----
 drivers/firmware/efi/libstub/efi-stub.c       | 10 +---
 drivers/firmware/efi/libstub/efistub.h        | 34 ++++++++++-
 drivers/firmware/efi/libstub/x86-stub.c       | 26 ++++-----
 include/linux/efi.h                           | 13 +----
 8 files changed, 123 insertions(+), 63 deletions(-)

-- 
2.17.1

