Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E4D459301B
	for <lists+linux-efi@lfdr.de>; Mon, 15 Aug 2022 15:42:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231912AbiHONme (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 15 Aug 2022 09:42:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231840AbiHONmd (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 15 Aug 2022 09:42:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 926292654;
        Mon, 15 Aug 2022 06:42:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4A970B80EBD;
        Mon, 15 Aug 2022 13:42:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 357C4C433C1;
        Mon, 15 Aug 2022 13:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660570950;
        bh=vOrjNzXszuYSKIoVOutNND6b9HJPnaJFwYZ99c1sEpM=;
        h=From:To:Cc:Subject:Date:From;
        b=L6AofjnmkPKGcf53VtHVQyNxg8hoyPkOuo23lpP8yQ0gvQfK/EGiV54aPb2lQTwY7
         +i0v333J9s8ncEyz/nP4AEjY78wndP0GBDbNJuz96GesijRNq6zw3kN/IwUhXTNs5P
         F60/7UlxJd5BwyuM9JD8fGfo4/lv6mSrERWFtzZwdi0hlsTylqGza3CIOsh3HuWYn5
         FZFDi2t6GVuNGHHwX7YdmlK1cZLmOxtf4DP76rIQAr21z5f7tq2MBeetJkFXiHlLqd
         iZ8ufzMsbf0ZyBWumFCU/eClWeK3W2CUZ1EIpDuS5KlIpjv80XHnj1VWxDPHZG0x89
         xUMVe6rhLYnjw==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michael Roth <michael.roth@amd.com>
Subject: [PATCH 0/6] x86: head_64.S spring cleaning
Date:   Mon, 15 Aug 2022 15:42:17 +0200
Message-Id: <20220815134223.740112-1-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1754; i=ardb@kernel.org; h=from:subject; bh=vOrjNzXszuYSKIoVOutNND6b9HJPnaJFwYZ99c1sEpM=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBi+k0wclk1/FLjSLfWMne91Li85TFGgIkZ7TAsYPfl EDfg9p6JAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYvpNMAAKCRDDTyI5ktmPJDvTC/ 91TWwxW89Jdi9hYfqKtN1SxQ21esuUJrsjCFV2BIX5rqtEbSU9e/eKbQn7OeuZx1U+DNGe73al4Ugj pvABnxTAtH3YX59H3lLZgv1M8701imI5m6HFYz5i96rjA0Cq1Wl7dJ2IuQz51FNRgVlI3qcKatK+b6 XgL2PaoKknYL1KMpF3rW924KY0RNxEmi5hkL7fMUJWkR5uq1iktuXZy1G+qBPrlZz2E+IlRjbDFe3E UchUsch+5yyMqmuelp/EbUaTBRViZlR7wLLUf5y1s5XvIodgRaRZ43rdVZ/87an6ZgeUzmi1tRphbI rv7FU+lnxhIBsafjLgAk9f/XskG0NbLK0cQ4iroIC9W1xNVGvo5UHsx9taOkX9yoc5NsycnS9zgrTO h5DuV+aEwHaRXaRZ3ZCY1gO/WZM2D3vIY0szGbVNuT5VhJVC+gSHBXhFdvv2xrO9JErqslitzX++j/ x/x743bwARdAuPG6TSDy1Pf7sVm/hCnNbDoWZ2JtXGuZE=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Michael Roth <michael.roth@amd.com>

Ard Biesheuvel (6):
  x86/head_64: clean up mixed mode 32-bit entry code
  efi/x86: simplify IDT/GDT preserve/restore
  x86/compressed: move startup32_load_idt() out of startup code
  x86/compressed: move startup32_check_sev_cbit out of startup code
  x86/compressed: adhere to calling convention in
    get_sev_encryption_bit()
  x86/compressed: only build mem_encrypt.S if AMD_MEM_ENCRYPT=y

 arch/x86/boot/compressed/Makefile       |   8 +-
 arch/x86/boot/compressed/efi_mixed.S    | 352 ++++++++++++++++++++
 arch/x86/boot/compressed/efi_thunk_64.S | 195 -----------
 arch/x86/boot/compressed/head_32.S      |   4 -
 arch/x86/boot/compressed/head_64.S      | 309 +----------------
 arch/x86/boot/compressed/mem_encrypt.S  | 146 +++++++-
 drivers/firmware/efi/libstub/x86-stub.c |   3 +-
 7 files changed, 506 insertions(+), 511 deletions(-)
 create mode 100644 arch/x86/boot/compressed/efi_mixed.S
 delete mode 100644 arch/x86/boot/compressed/efi_thunk_64.S

-- 
2.35.1

