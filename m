Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE8A26340F2
	for <lists+linux-efi@lfdr.de>; Tue, 22 Nov 2022 17:10:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234167AbiKVQKf (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 22 Nov 2022 11:10:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233560AbiKVQKe (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 22 Nov 2022 11:10:34 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6FF77298F;
        Tue, 22 Nov 2022 08:10:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6E97061740;
        Tue, 22 Nov 2022 16:10:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13C93C433D6;
        Tue, 22 Nov 2022 16:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669133432;
        bh=Z021xpI5RSbF29MWnGe2CWEQ37RxLNV97kkgLst3V1U=;
        h=From:To:Cc:Subject:Date:From;
        b=P7hYBIN9Ur5LNSCuVSQsExrVrBLdUAVCWxg92efiq1GpoUjiT5HlKJwkqdJUHEJrD
         VV+K17AoIk5aW7WXP2FWLx56I3KaWe2FlS1hXAxihFRBy7OF7HzOugIMRHgAO5pz4T
         9BByOGOiKehnbM6/3Bp+ymvmUrGxek+F1Q48BMM6NR51lometsJWoPcfcasx9tphLV
         44lb9q4CMH2K5hhOoi80JxhjBQvrhIlcsjwzHs3mu/ncqw0MqvyoUxoZheIl8mdAml
         nRzlQ0bZbyZlrxOcrXUSpDl2tyqzw2EvRq886fY0zXLV69Pkj4hXgi6XClViLXbY90
         Ysw/iouQ7CgRA==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michael Roth <michael.roth@amd.com>
Subject: [PATCH v3 00/17] x86: head_64.S spring cleaning
Date:   Tue, 22 Nov 2022 17:10:00 +0100
Message-Id: <20221122161017.2426828-1-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2681; i=ardb@kernel.org; h=from:subject; bh=Z021xpI5RSbF29MWnGe2CWEQ37RxLNV97kkgLst3V1U=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBjfPRN2as7fjkYpXTig4cgqVqr6u5KGCC0Gjd6XlH+ ue1+e96JAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCY3z0TQAKCRDDTyI5ktmPJBWXDA CYSEcUI1Ht+tU7Cddz5l1hF2EiMYNSXNPCJ/Inw+OtBgltnWndZAjmpi9gStZLZ2uyFoUsC++pwlJu z1ElBVz3Ebd8XBbbS4rwPZ9+aLyO7j/YwH4+byKXKSahLZpklYWor+3Ha5bMeiWVoFAHRUnzoWZ20s e4lCDVwtQ4yVdoCXaOiopy6KHSYDA6/M2PPRJz/0aSU62/2Mujl+wrVqcS3R508OvkVWpgujxGSf3K 5VHWexl59bG7jaagji3qtCC2ErK1+g3TBdBSxkxvdHZEN10kabu89q1p5Z2spi64iDz9HYr8t6K2YK FNeHSFEfRQBu7cjax++V2605ErC6xHGxekuUUXDdRUqmM/EE46tviWC8i26UDTegZmmSwFCXn2rOal 9k30JMwOqtX+xXl/meEudUvW4Zi3YSztAhnmied/bCJ51pyV7vAU40TKLjI4mOJkDXLt9aATCliayn rudbrUq9JZAv8Q7D28mE7XEGZvPbRApKkmNV9rjFRG9Hk=
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

After doing some cleanup work on the EFI code in head_64.S, the mixed
mode code in particular, I noticed that the memory encryption pieces
could use some attention as well, so I cleaned that up too.

Changes since v2:
- add some clarifying comments to the EFI mixed mode changes
- include patch to make the EFI handover protocol optional that was sent
  out separately before
- rebase onto tip/master

Changes since v1:
- at Boris's request, split the patches into smaller ones that are
  easier to review

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Michael Roth <michael.roth@amd.com>

Ard Biesheuvel (17):
  x86/compressed: efi-mixed: rename efi_thunk_64.S to efi-mixed.S
  x86/compressed: efi-mixed: move 32-bit entrypoint code into .text
    section
  x86/compressed: efi-mixed: move bootargs parsing out of 32-bit startup
    code
  x86/compressed: efi-mixed: move efi32_pe_entry into .text section
  x86/compressed: efi-mixed: move efi32_entry out of head_64.S
  x86/compressed: efi-mixed: move efi32_pe_entry() out of head_64.S
  x86/compressed: efi: merge multiple definitions of image_offset into
    one
  x86/compressed: efi-mixed: simplify IDT/GDT preserve/restore
  x86/compressed: avoid touching ECX in startup32_set_idt_entry()
  x86/compressed: pull global variable ref up into startup32_load_idt()
  x86/compressed: move startup32_load_idt() into .text section
  x86/compressed: move startup32_load_idt() out of head_64.S
  x86/compressed: move startup32_check_sev_cbit() into .text
  x86/compressed: move startup32_check_sev_cbit() out of head_64.S
  x86/compressed: adhere to calling convention in
    get_sev_encryption_bit()
  x86/compressed: only build mem_encrypt.S if AMD_MEM_ENCRYPT=y
  efi: x86: Make the deprecated EFI handover protocol optional

 arch/x86/Kconfig                        |  17 +
 arch/x86/boot/compressed/Makefile       |   8 +-
 arch/x86/boot/compressed/efi_mixed.S    | 351 ++++++++++++++++++++
 arch/x86/boot/compressed/efi_thunk_64.S | 195 -----------
 arch/x86/boot/compressed/head_32.S      |   4 -
 arch/x86/boot/compressed/head_64.S      | 303 +----------------
 arch/x86/boot/compressed/mem_encrypt.S  | 152 ++++++++-
 arch/x86/boot/header.S                  |   2 +-
 arch/x86/boot/tools/build.c             |   2 +
 drivers/firmware/efi/libstub/x86-stub.c |   2 +-
 10 files changed, 533 insertions(+), 503 deletions(-)
 create mode 100644 arch/x86/boot/compressed/efi_mixed.S
 delete mode 100644 arch/x86/boot/compressed/efi_thunk_64.S

-- 
2.35.1

