Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2C292A30DA
	for <lists+linux-efi@lfdr.de>; Mon,  2 Nov 2020 18:06:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727452AbgKBRGv (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 2 Nov 2020 12:06:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:59046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727265AbgKBRGv (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 2 Nov 2020 12:06:51 -0500
Received: from e123331-lin.nice.arm.com (lfbn-nic-1-188-42.w2-15.abo.wanadoo.fr [2.15.37.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 11AEC222EC;
        Mon,  2 Nov 2020 17:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604336811;
        bh=Xjb4xa/5vDe+i0xPIIEdzQySk2rIZzlAhG5qwMC8cVU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cdSb1lsavmUslZH08rhRzBO2oLVX+uHCVimwj/7sJhblNiKUruSs7UFHJ1M74gAmG
         P3+QdoTTW1KnXIdvsQY3NtfA287Y4IQqGKMblSP/foz/Q8OiBk3EjV5Ip1IBKSOCmd
         3qyW3JR0iN5LAzJteJ2CT9imz9/1jkuWd7gXy1qA=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>, Peter Jones <pjones@redhat.com>,
        Leif Lindholm <leif@nuviainc.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Matthew Garrett <mjg59@google.com>,
        Daniel Kiper <daniel.kiper@oracle.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [RFC PATCH 1/7] efi/libstub: whitespace cleanup
Date:   Mon,  2 Nov 2020 18:06:28 +0100
Message-Id: <20201102170634.20575-2-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201102170634.20575-1-ardb@kernel.org>
References: <20201102170634.20575-1-ardb@kernel.org>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Trivial whitespace cleanup.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 include/linux/efi.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/efi.h b/include/linux/efi.h
index d7c0e73af2b9..0ac54295ec0b 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -29,10 +29,10 @@
 #include <asm/page.h>
 
 #define EFI_SUCCESS		0
-#define EFI_LOAD_ERROR          ( 1 | (1UL << (BITS_PER_LONG-1)))
+#define EFI_LOAD_ERROR		( 1 | (1UL << (BITS_PER_LONG-1)))
 #define EFI_INVALID_PARAMETER	( 2 | (1UL << (BITS_PER_LONG-1)))
 #define EFI_UNSUPPORTED		( 3 | (1UL << (BITS_PER_LONG-1)))
-#define EFI_BAD_BUFFER_SIZE     ( 4 | (1UL << (BITS_PER_LONG-1)))
+#define EFI_BAD_BUFFER_SIZE	( 4 | (1UL << (BITS_PER_LONG-1)))
 #define EFI_BUFFER_TOO_SMALL	( 5 | (1UL << (BITS_PER_LONG-1)))
 #define EFI_NOT_READY		( 6 | (1UL << (BITS_PER_LONG-1)))
 #define EFI_DEVICE_ERROR	( 7 | (1UL << (BITS_PER_LONG-1)))
-- 
2.17.1

