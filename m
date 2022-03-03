Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA7D64CBFE3
	for <lists+linux-efi@lfdr.de>; Thu,  3 Mar 2022 15:21:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234010AbiCCOWV (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 3 Mar 2022 09:22:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233875AbiCCOWU (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 3 Mar 2022 09:22:20 -0500
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 453C5186456;
        Thu,  3 Mar 2022 06:21:35 -0800 (PST)
Received: from localhost.localdomain (unknown [80.240.223.29])
        by mail.ispras.ru (Postfix) with ESMTPSA id DB2C440755C1;
        Thu,  3 Mar 2022 14:21:32 +0000 (UTC)
From:   Baskov Evgeniy <baskov@ispras.ru>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Baskov Evgeniy <baskov@ispras.ru>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] Handle UEFI NX-restricted page tables
Date:   Thu,  3 Mar 2022 17:21:18 +0300
Message-Id: <20220303142120.1975-1-baskov@ispras.ru>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

UEFI specification does not guarantee all memory to executable and/or
writable. There are some firmware implementations that enforce stricter
memory protection attributes and that prevents Linux kernel from booting
normally causing page fault during boot process.

This patch uses DXE services to check and modified memory attributes
while booting via EFISTUB, in such way that memory regions used
by the kernel until extraction and are expected to be executable
have appropriate attributes.

Unlike v2 of the patch this version only modifies memory attributes
if it is really required to reduce the probability of facing firmware
bugs. "Really required" in this case means:

 - DXE services table is published by EFI;
 - GetMemorySpaceDescriptor() works can return descriptor(s)
   of regions, where attributes modification might be required;
 - EFI_MEMORY_RO or EFI_MEMORY_XP is set for these regions;
 - Region describes system memory, i.e. generic RAM.

Also we cannot simply replace EFI_LOADER_DATA with EFI_LOADER_CODE
to mitigate the issue, since:

 - It is not guaranteed by specification that memory allocated
   with loader code type is executable. And firmware where
   this issue is present is modified in such way that
   memory EFI_LOADER_CODE is not executable;
 - Linux still uses memory not allocated via EFI boot
   services for trampoline code placement, that would
   remain non-executable after replacement of EFI_LOADER_DATA with
   EFI_LOADER_CODE.

Baskov Evgeniy (2):
       efi: declare DXE services table
       libstub: ensure allocated memory to be executable

 arch/x86/include/asm/efi.h              |    5 +
 drivers/firmware/efi/Kconfig            |   12 ++
 drivers/firmware/efi/libstub/efistub.h  |   74 ++++++++++++++
 drivers/firmware/efi/libstub/x86-stub.c |   10 +-
 include/linux/efi.h                     |    2 
 drivers/firmware/efi/libstub/x86-stub.c |  110 +++++++++++++++++++++-
 6 files changed, 208 insertions(+), 5 deletions(-)
