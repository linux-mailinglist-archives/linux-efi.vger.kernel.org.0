Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC4975C0059
	for <lists+linux-efi@lfdr.de>; Wed, 21 Sep 2022 16:54:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbiIUOyg (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 21 Sep 2022 10:54:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbiIUOyd (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 21 Sep 2022 10:54:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E1FF101A;
        Wed, 21 Sep 2022 07:54:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 20202B83028;
        Wed, 21 Sep 2022 14:54:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB35CC43143;
        Wed, 21 Sep 2022 14:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663772068;
        bh=nFP0scq5YobaddyVWT3m2QrQwK3XasOpsdihcJcMWvs=;
        h=From:To:Cc:Subject:Date:From;
        b=MdLgc5Ovj0cZhtRpiTEK/9khPOVzGA+itzCsItU4KhlP+/n2E3JFJdKNbEwIauGbK
         d2py0uUcAdjOzJo+Jll5zypItKWydiYwo5c3haJ20EPr2DyH23SCQHqcNIqp1qsvQu
         NYjzizfnHJ8bNPd0cxm4B7INClPDmffssYDBmCqgSkBx5e1P2d3kRJzWSKRp+hXwnQ
         u5e8xoZyc+BoadNPeCRFB+yqggN/Gig8tMK0k87ZkBLlMVBd+bKtbWdQZO+Jb1L9/n
         +f0+Pm2Ih7G+Z42OMgNORznBODbp0WRSIPq5RMYRf3I9JXhVk0CrhQ3nUZtGJHWfTV
         PVzY2ieNxH+Iw==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michael Roth <michael.roth@amd.com>
Subject: [PATCH v2 00/16] x86: head_64.S spring cleaning
Date:   Wed, 21 Sep 2022 16:54:06 +0200
Message-Id: <20220921145422.437618-1-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2607; i=ardb@kernel.org; h=from:subject; bh=nFP0scq5YobaddyVWT3m2QrQwK3XasOpsdihcJcMWvs=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBjKyWCyvtsYeIsjdqQWTxLVWqKcXc+MFORFb12WmtW 6JOLSkmJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYyslggAKCRDDTyI5ktmPJKoVC/ 4p1kCtUecDTAGcjgK8TjHwBQgP+f2J7wUVFQO4Ryhj6AChJp5Mhds3YKWdvngsRDJ/JYpNEXw/Sllu cvyVGhS9rcuE3Lzfe58J1JG5hoiY75I98w1QBmV+4L5vvuwVleQxB5NtRs9kuzOk7grXppVOWkEiWV 0gXHDms6oZO0j7iiS0HXPiqxnJIiyifij0V9d9aL/hA5uki9Fykub7rgEeWWAK1dAKKUA2GaLQCN1/ UUBFb5lrM7mLeGRr7PtlbpFJ2fDFaeXqGbfcqA+uOpTXK//7EH0Szaw/4tgTi5SLWFhMJqvm+urRfe 0Nsr0HH0Y9xvKxOX4eiCef4yw5b9mR3zcwVFl11bRy6UZ0S3+CrfguOyNASw7O5/Yhlq6W7aeX+ZGk YUqDGI1wqD6kka/rqFsy8m1Pt4EvepzzwJ8qtuNxLpnOvK63j1zGIU2zcFjWOiVmE8DF73bOzrMB8f xsW4KuLprOMEkEuem3KzkwnoF8LT1b+UBVp8uXbH2Ck3E=
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

I have been sitting on these patches since November, waiting for the
right time to post them, i.e., after the SEV/SNP review had finished.
This has yet to happen, so I'm posting them now instead. Please feel
free to disregard for the time being, and propose a suitable timeframe
to repost them if this is likely to conflict with ongoing work.

Changes since v1:
- at Boris's request, split the patches into smaller ones that are
  easier to review

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Michael Roth <michael.roth@amd.com>

Ard Biesheuvel (16):
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

 arch/x86/boot/compressed/Makefile       |   8 +-
 arch/x86/boot/compressed/efi_mixed.S    | 337 ++++++++++++++++++++
 arch/x86/boot/compressed/efi_thunk_64.S | 195 -----------
 arch/x86/boot/compressed/head_32.S      |   4 -
 arch/x86/boot/compressed/head_64.S      | 299 +----------------
 arch/x86/boot/compressed/mem_encrypt.S  | 152 ++++++++-
 drivers/firmware/efi/libstub/x86-stub.c |   2 +-
 7 files changed, 496 insertions(+), 501 deletions(-)
 create mode 100644 arch/x86/boot/compressed/efi_mixed.S
 delete mode 100644 arch/x86/boot/compressed/efi_thunk_64.S

-- 
2.35.1

