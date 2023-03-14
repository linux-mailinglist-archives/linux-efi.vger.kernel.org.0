Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB18E6B8FC3
	for <lists+linux-efi@lfdr.de>; Tue, 14 Mar 2023 11:25:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231300AbjCNKZS (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 14 Mar 2023 06:25:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbjCNKYp (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 14 Mar 2023 06:24:45 -0400
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26BAD5FE94;
        Tue, 14 Mar 2023 03:24:18 -0700 (PDT)
Received: from localhost.localdomain (unknown [83.149.199.65])
        by mail.ispras.ru (Postfix) with ESMTPSA id 3AEEF40755C6;
        Tue, 14 Mar 2023 10:23:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 3AEEF40755C6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
        s=default; t=1678789405;
        bh=+Rs2iCTiek3yYBbmemqEMQIzt9ito44oHZ0zp2gqc10=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YIY13fl2vX+jnARjSEo+Jv4ClNtCdXk4Pb/VJtM+8ZvDtbZgMkT8CnMO0Ah0uRMCh
         EOva3BjomKBhR5fGAuUY6HWaCaBouOUtq33ZsGbwBST0QntXMNxWXIFx2EJIIWcl8y
         Sp1t4Pjeb6CQWgnhTvv22eHB2np7MU6/5q4HTYuk=
From:   Evgeniy Baskov <baskov@ispras.ru>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Evgeniy Baskov <baskov@ispras.ru>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Peter Jones <pjones@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        "Limonciello, Mario" <mario.limonciello@amd.com>,
        joeyli <jlee@suse.com>, lvc-project@linuxtesting.org,
        x86@kernel.org, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH v5 22/27] x86/build: set type_of_loader for EFISTUB
Date:   Tue, 14 Mar 2023 13:13:49 +0300
Message-Id: <111d4120936d23e6023619660778444eb226a22f.1678785672.git.baskov@ispras.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1678785672.git.baskov@ispras.ru>
References: <cover.1678785672.git.baskov@ispras.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

After switching to the local copy of boot_params, EFISTUB stopped
setting type_of_loader, using the default value of 0. Restore that
behavior by assigning the right value at the build time.

Signed-off-by: Evgeniy Baskov <baskov@ispras.ru>
---
 arch/x86/boot/tools/build.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/boot/tools/build.c b/arch/x86/boot/tools/build.c
index 476ef05f16fb..5ac4f08ed923 100644
--- a/arch/x86/boot/tools/build.c
+++ b/arch/x86/boot/tools/build.c
@@ -588,6 +588,8 @@ int main(int argc, char **argv)
 	memcpy(output + setup_size + efi_boot_params + SETUP_HEADER_OFFSET,
 	       setup_header, 0x290 - SETUP_HEADER_OFFSET
 	       /* == max possible sizeof(struct setup_header) */);
+	/* Set type_of_loader to the one that EFISTUB uses for the local copy */
+	output[setup_size + efi_boot_params + SETUP_HEADER_OFFSET + 0x1F] = 0x21;
 #endif
 
 	/* Calculate and write kernel checksum. */
-- 
2.39.2

