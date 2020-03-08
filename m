Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8FE5A17D25D
	for <lists+linux-efi@lfdr.de>; Sun,  8 Mar 2020 09:09:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726202AbgCHIJK (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 8 Mar 2020 04:09:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:36128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725854AbgCHIJK (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sun, 8 Mar 2020 04:09:10 -0400
Received: from e123331-lin.home (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1545C20866;
        Sun,  8 Mar 2020 08:09:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583654950;
        bh=0L3JnpVh2/V/1uqvO5VAW63G8ir+cLFE9qbDxePw4yA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tOUxJ/cieC/Cjpan6NQ85Ks5fNxFZKhpmDPL3yE4pNxfTJFkBQVbMIWOjnUmDthiq
         yg1ocfkLKppZk4KBfYYG5wH7Ewo4NSqu2asw6RdMZJE3Qlv6MPprpBMQCV3/b/244G
         4PRYA8UDR+WKB9IAJuCPLk1Xtjcyzn0p5lOGrLJs=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Christoph Hellwig <hch@lst.de>,
        David Hildenbrand <david@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Guenter Roeck <linux@roeck-us.net>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nikolai Merinov <n.merinov@inango-systems.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Vladis Dronov <vdronov@redhat.com>
Subject: [PATCH 01/28] efi/x86: Add TPM related EFI tables to unencrypted mapping checks
Date:   Sun,  8 Mar 2020 09:08:32 +0100
Message-Id: <20200308080859.21568-2-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200308080859.21568-1-ardb@kernel.org>
References: <20200308080859.21568-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Tom Lendacky <thomas.lendacky@amd.com>

When booting with SME active, EFI tables must be mapped unencrypted since
they were built by UEFI in unencrypted memory. Update the list of tables
to be checked during early_memremap() processing to account for the EFI
TPM tables.

This fixes a bug where an EFI TPM log table has been created by UEFI, but
it lives in memory that has been marked as usable rather than reserved.

Cc: <stable@vger.kernel.org> # v5.4+
Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
Link: https://lore.kernel.org/r/4144cd813f113c20cdfa511cf59500a64e6015be.1582662842.git.thomas.lendacky@amd.com
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/platform/efi/efi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
index ebcec4bd273f..3ce695501681 100644
--- a/arch/x86/platform/efi/efi.c
+++ b/arch/x86/platform/efi/efi.c
@@ -88,6 +88,8 @@ static const unsigned long * const efi_tables[] = {
 #ifdef CONFIG_EFI_RCI2_TABLE
 	&rci2_table_phys,
 #endif
+	&efi.tpm_log,
+	&efi.tpm_final_log,
 };
 
 u64 efi_setup;		/* efi setup_data physical address */
-- 
2.17.1

