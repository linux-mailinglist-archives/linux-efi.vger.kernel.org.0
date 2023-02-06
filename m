Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2C6168BD46
	for <lists+linux-efi@lfdr.de>; Mon,  6 Feb 2023 13:49:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbjBFMtv (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 6 Feb 2023 07:49:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjBFMtu (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 6 Feb 2023 07:49:50 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 705BD1114F
        for <linux-efi@vger.kernel.org>; Mon,  6 Feb 2023 04:49:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 21CB7B8100F
        for <linux-efi@vger.kernel.org>; Mon,  6 Feb 2023 12:49:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68680C433D2;
        Mon,  6 Feb 2023 12:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675687786;
        bh=fSkpN+gT5cuBhbCnweyTH9Ry8FXA4fNsNVToxzaN468=;
        h=From:To:Cc:Subject:Date:From;
        b=ZXDSHVGHQJZtsZYWvL90JW/pG2F5O+jiFraaz9QcqY74aCUGzOP8tWpIUu+LdsBSt
         wnzM1p1NrDdMOGmWhD3nx/9TQFEzg8IQMhqKC0z4HotVuoVP86O9W5PzUOFXYTJLJb
         zDFDXxUMwzHz8Ypj+XAtNMZjyBOsFI0bv07dt40KlGyqbp4M7MX9EX5UBZPsAZLxOw
         hXxa5xYMCd2wpMwdiHKdPbZQsEq6MW7ScDzt3Q5sWtJUKjnjPINZt7CHoJbHwFzQzO
         F1hUpnMHpHYURuHfpuxoQa4H3QKWvTreIPMQVI1n+qlQpMga8c1FxEj0pp9J2UyRD5
         Mi9TxfzAJdC6w==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Ard Biesheuvel <ardb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: [PATCH v2 0/3] efi: Enable BTI for EFI runtimes services
Date:   Mon,  6 Feb 2023 13:49:35 +0100
Message-Id: <20230206124938.272988-1-ardb@kernel.org>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1774; i=ardb@kernel.org; h=from:subject; bh=fSkpN+gT5cuBhbCnweyTH9Ry8FXA4fNsNVToxzaN468=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBj4PdcIh2OTQBLySYPjqXUEBgp6kblCsSE0GY/Y Xpi16zhQwWJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCY+D3XAAKCRDDTyI5ktmP JFV7DACTGjFtc41BWSTho5LIkJla8YVyqX1QjJixLvvTsbeR4pUwKTVoE7NigKNdfOv+LuPAFLU 9eT4UgE7931be/Rjfljyv3hrnaoL1JQpUIml+gaOjfvaEuaPvefositf5nUYBMdYO9ft4umMkrg wxSJvAlqfGl5Zy2UnUc0On2HXcTQ1u1lcu3kxuwVYLzbhY//EZ6svkd5dzVvPaKxXXHgW/gHCi1 y6wNKnS8ZpCGPOzdKArWfIMGcHcJuBTESFa6/cvFnQ9EUg+1Waqnv5428OwiZqyTjeTiRqWRVyB 1u821NxCBQbFIYZ0uQLS+SeR0vNd6ZZ88v0mJFMi6h+Xvn2yhTN/ySduR+811v0d1aOZKuEschN bSP6yIzgHJeMxsBUq5i8NSD2h+hVwV+/d+wZR5cliAkiyP9NpD7Gdjw7nirMgGCNvouZ6G8fSEU Fk4ETVSnFXhnvc7QImbrH3M9JO4Tg1UNKdaZhhHzhSRKndaA+4wllxN2rR7YD9TbFx/jo=
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

The EFI spec v2.10 introduces a global flag in the memory attributes
table that indicates whether the EFI runtime code regions were emitted
with BTI landing pads, and can therefore tolerate being mapped with BTI
enforcement enabled.

Add the generic plumbing for this, and wire it up for arm64.

Changes since v1:
- enable BTI in UEFI code regions even if CONFIG_ARM64_BIT_KERNEL=n
- deal with BTI exceptions occuring in EFI code gracefully
- add equivalent handling to x86
- add Kees's R-b

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>

Ard Biesheuvel (3):
  efi: Discover BTI support in runtime services regions
  efi: arm64: Wire up BTI annotation in memory attributes table
  efi: x86: Wire up IBT annotation in memory attributes table

 arch/arm/include/asm/efi.h     |  2 +-
 arch/arm/kernel/efi.c          |  5 +++--
 arch/arm64/include/asm/efi.h   |  3 ++-
 arch/arm64/kernel/efi.c        | 17 ++++++++++++++---
 arch/arm64/kernel/traps.c      |  6 ++++++
 arch/riscv/include/asm/efi.h   |  2 +-
 arch/riscv/kernel/efi.c        |  3 ++-
 arch/x86/include/asm/efi.h     |  4 +++-
 arch/x86/include/asm/ibt.h     |  4 ++--
 arch/x86/kernel/apm_32.c       |  4 ++--
 arch/x86/kernel/cpu/common.c   |  5 +++--
 arch/x86/platform/efi/efi_64.c |  8 +++++++-
 drivers/firmware/efi/memattr.c |  7 ++++++-
 include/linux/efi.h            |  8 ++++++--
 14 files changed, 58 insertions(+), 20 deletions(-)

-- 
2.39.1

