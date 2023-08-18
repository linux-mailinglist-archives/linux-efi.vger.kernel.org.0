Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 152CA780CD6
	for <lists+linux-efi@lfdr.de>; Fri, 18 Aug 2023 15:46:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377266AbjHRNpy (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 18 Aug 2023 09:45:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377301AbjHRNpb (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 18 Aug 2023 09:45:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D6913C34;
        Fri, 18 Aug 2023 06:45:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 180876687F;
        Fri, 18 Aug 2023 13:45:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADB9FC433CA;
        Fri, 18 Aug 2023 13:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692366314;
        bh=B8e/GlBS9y5XQvKhnA7moHi7ggUXYtzy41FY6p2n4uA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fnAyx4DVZ49Zxq2ChlLb2DYtNCyXQwsmPXvKkVaZvl2MdGQ7vBtycpxPJbrWKoNoJ
         N+XyOffZvGfwMgLYjJjbDjiY0NWVJLgXk3SgsdxlsMWR01n9/dR/m7eXUpSQfE1zo9
         bh/IXIIhHfXjfT6eGVY6JjXLd5qKQJmyGv7oc6nm+bFn5RT1rkKt8XDtDRjIu5hZkW
         e4NwdeDmoPQROSvnPw2MrIH2lI/xVkzx78a0m2JA3yp2ZvAph3ecDAoZSu3qfahMH3
         RCHf7GuzmrgyhX6Dz2Cgfpmm3NeSGY250h9Bs05XoW37uNWfNikoFkUjklzYMv28h2
         Qy2IZfR666JwA==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Evgeniy Baskov <baskov@ispras.ru>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Jones <pjones@redhat.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        =?UTF-8?q?Marvin=20H=C3=A4user?= <mhaeuser@posteo.de>
Subject: [PATCH 10/17] x86/boot: Drop workaround for binutils 2.14 in linker script ASSERTs
Date:   Fri, 18 Aug 2023 15:44:15 +0200
Message-Id: <20230818134422.380032-11-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230818134422.380032-1-ardb@kernel.org>
References: <20230818134422.380032-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1116; i=ardb@kernel.org; h=from:subject; bh=B8e/GlBS9y5XQvKhnA7moHi7ggUXYtzy41FY6p2n4uA=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIeV+6fJO/VdHM11tDlTECoV5ZedKPsjWsjq05aDiqdCgh yfOMO/pKGVhEONgkBVTZBGY/ffdztMTpWqdZ8nCzGFlAhnCwMUpABPZE8/wz6qcw+04xzHrGIvX jTM5d30v9VEKy3gie8v0yN4jHDVH0xgZLvusyS52fnUstcoocLJtno6fp5NIMNfNV9nC4qyi0/w 5AA==
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The minimum binutils version was bumped to 2.20 in 2017 so there is no
longer a need to work around quirks in older versions than that. So drop
some meaningless linker script assignments to '.' of ASSERT() return
values.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/setup.ld | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/arch/x86/boot/setup.ld b/arch/x86/boot/setup.ld
index b11c45b9e51ed90e..a05dcaa4b74cd9f8 100644
--- a/arch/x86/boot/setup.ld
+++ b/arch/x86/boot/setup.ld
@@ -56,12 +56,8 @@ SECTIONS
 		*(.note*)
 	}
 
-	/*
-	 * The ASSERT() sink to . is intentional, for binutils 2.14 compatibility:
-	 */
-	. = ASSERT(_end <= 0x8000, "Setup too big!");
-	. = ASSERT(hdr == 0x1f1, "The setup header has the wrong offset!");
+	ASSERT(_end <= 0x8000, "Setup too big!")
+	ASSERT(hdr == 0x1f1, "The setup header has the wrong offset!")
 	/* Necessary for the very-old-loader check to work... */
-	. = ASSERT(__end_init <= 5*512, "init sections too big!");
-
+	ASSERT(__end_init <= 5*512, "init sections too big!")
 }
-- 
2.39.2

