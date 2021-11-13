Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37CA744F108
	for <lists+linux-efi@lfdr.de>; Sat, 13 Nov 2021 04:29:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232723AbhKMDcR (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 12 Nov 2021 22:32:17 -0500
Received: from smtpbg604.qq.com ([59.36.128.82]:56677 "EHLO smtpbg604.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232113AbhKMDcR (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 12 Nov 2021 22:32:17 -0500
X-QQ-mid: bizesmtp42t1636774110tco0shkf
Received: from localhost.localdomain (unknown [125.69.41.88])
        by esmtp6.qq.com (ESMTP) with 
        id ; Sat, 13 Nov 2021 11:28:28 +0800 (CST)
X-QQ-SSF: 01000000000000C0F000B00A0000000
X-QQ-FEAT: 5YkfsBQ8D09UoePCN3Atr56y9jtXDPlgLiS+yJNjn2fIH+5IAQGCshWXG0+X4
        CYTeTrKTcD4RCEOeyCru52XrnBRShZ+suTsmcfFzi6ZnZAQwMHYxnY+kuly2X62jpRUj32e
        LguzkqWXRLok4PAVLQEAH3VlTNrDVzk8lApce9EhvE55flsxPi8hxaCd1k/MLRU81tvtrL2
        mhuZ0AJRhvws3Llx57ZGG1JzDYYz3EZ/o/+Gi8gR5uta7ygdXQNDehZQBpvHc0xn2njGRKS
        j78shJ3cXgvedAhUzuGuJLaESFVVm2kAwUVajOOBnYS3A7hHtsubfBWh/lKEGH7p35fUunI
        eBQxqVAre3P+KoX2WqWTUPrvbM77A==
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     tglx@linutronix.de
Cc:     ardb@kernel.org, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, dvhart@infradead.org,
        andy@infradead.org, hpa@zytor.com, linux-efi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH] x86/efi: Remove a repeated word in a comment
Date:   Sat, 13 Nov 2021 11:28:26 +0800
Message-Id: <20211113032826.57606-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam4
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The repeated word `there' in a comment is redundant, thus
one of them was removed from the comment.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 arch/x86/platform/efi/efi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
index 147c30a81f15..2a970fb27744 100644
--- a/arch/x86/platform/efi/efi.c
+++ b/arch/x86/platform/efi/efi.c
@@ -189,7 +189,7 @@ static void __init do_add_efi_memmap(void)
 }
 
 /*
- * Given add_efi_memmap defaults to 0 and there there is no alternative
+ * Given add_efi_memmap defaults to 0 and there is no alternative
  * e820 mechanism for soft-reserved memory, import the full EFI memory
  * map if soft reservations are present and enabled. Otherwise, the
  * mechanism to disable the kernel's consideration of EFI_MEMORY_SP is
-- 
2.33.0

