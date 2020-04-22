Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30BDE1B4B9A
	for <lists+linux-efi@lfdr.de>; Wed, 22 Apr 2020 19:24:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbgDVRYq (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 22 Apr 2020 13:24:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:41374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726372AbgDVRYq (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 22 Apr 2020 13:24:46 -0400
Received: from cam-smtp0.cambridge.arm.com (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B3D720776;
        Wed, 22 Apr 2020 17:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587576286;
        bh=4uB87pnCakWm+ahms4D0ucT5sZSewG+3xTWlAcpDBw4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M3un+b432WzQQKP170CHaNABVf9PRCR/jUXsn65ATwcQi1h/HEu10vUetVcd+4BTH
         8rkvfscc2UC9/6nFKdlYf+nChmaRkYZVtjvwmvNbYi6l6t2Q6f31Aharm4XgBdbVlc
         MYmK2gWreVWARN21Xuf0odyQIvYLrvJpYVb0YcPk=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Atish Patra <atish.patra@wdc.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org
Subject: [PATCH v5 4/7] include: pe.h: Add RISC-V related PE definition
Date:   Wed, 22 Apr 2020 19:24:11 +0200
Message-Id: <20200422172414.6662-5-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200422172414.6662-1-ardb@kernel.org>
References: <20200422172414.6662-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Atish Patra <atish.patra@wdc.com>

Define RISC-V related machine types.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
Link: https://lore.kernel.org/r/20200415195422.19866-3-atish.patra@wdc.com
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 include/linux/pe.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/pe.h b/include/linux/pe.h
index 8ad71d763a77..daf09ffffe38 100644
--- a/include/linux/pe.h
+++ b/include/linux/pe.h
@@ -55,6 +55,9 @@
 #define	IMAGE_FILE_MACHINE_POWERPC	0x01f0
 #define	IMAGE_FILE_MACHINE_POWERPCFP	0x01f1
 #define	IMAGE_FILE_MACHINE_R4000	0x0166
+#define	IMAGE_FILE_MACHINE_RISCV32	0x5032
+#define	IMAGE_FILE_MACHINE_RISCV64	0x5064
+#define	IMAGE_FILE_MACHINE_RISCV128	0x5128
 #define	IMAGE_FILE_MACHINE_SH3		0x01a2
 #define	IMAGE_FILE_MACHINE_SH3DSP	0x01a3
 #define	IMAGE_FILE_MACHINE_SH3E		0x01a4
-- 
2.17.1

