Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFBC7791651
	for <lists+linux-efi@lfdr.de>; Mon,  4 Sep 2023 13:42:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232903AbjIDLm2 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 4 Sep 2023 07:42:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjIDLm0 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 4 Sep 2023 07:42:26 -0400
Received: from mail.kapsi.fi (mail.kapsi.fi [IPv6:2001:67c:1be8::25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B68A218C;
        Mon,  4 Sep 2023 04:42:22 -0700 (PDT)
Received: from kapsi.fi ([91.232.154.11] helo=lakka.kapsi.fi)
        by mail.kapsi.fi with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <mcfrisk@lakka.kapsi.fi>)
        id 1qd7yC-000GpZ-1s;
        Mon, 04 Sep 2023 14:42:16 +0300
Received: from mcfrisk by lakka.kapsi.fi with local (Exim 4.94.2)
        (envelope-from <mcfrisk@lakka.kapsi.fi>)
        id 1qd7om-00HPf9-IM; Mon, 04 Sep 2023 14:32:32 +0300
From:   mikko.rapeli@linaro.org
To:     linux-doc@vger.kernel.org
Cc:     Mikko Rapeli <mikko.rapeli@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-efi@vger.kernel.org,
        stable@kernel.org
Subject: [PATCH] Documentation efi-stub.rst: fix arm64 EFI source location
Date:   Mon,  4 Sep 2023 14:32:14 +0300
Message-Id: <20230904113214.4147021-1-mikko.rapeli@linaro.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspam-Score: -1.4 (-)
X-Rspam-Report: Action: no action
 Symbol: ARC_NA(0.00)
 Symbol: DMARC_POLICY_SOFTFAIL(0.10)
 Symbol: RCVD_TLS_LAST(0.00)
 Symbol: TO_DN_SOME(0.00)
 Symbol: R_MISSING_CHARSET(0.50)
 Symbol: R_SPF_ALLOW(-0.20)
 Symbol: MIME_GOOD(-0.10)
 Symbol: TO_MATCH_ENVRCPT_ALL(0.00)
 Symbol: RCPT_COUNT_FIVE(0.00)
 Symbol: BLOCKLISTDE_FAIL(0.00)
 Symbol: FROM_NO_DN(0.00)
 Symbol: MID_CONTAINS_FROM(1.00)
 Symbol: NEURAL_HAM(0.00)
 Symbol: FORGED_SENDER(0.30)
 Symbol: R_DKIM_NA(0.00)
 Symbol: MIME_TRACE(0.00)
 Symbol: ASN(0.00)
 Symbol: FROM_NEQ_ENVFROM(0.00)
 Symbol: BAYES_HAM(-3.00)
 Symbol: RCVD_COUNT_TWO(0.00)
 Message-ID: 20230904113214.4147021-1-mikko.rapeli@linaro.org
X-SA-Exim-Connect-IP: 91.232.154.11
X-SA-Exim-Mail-From: mcfrisk@lakka.kapsi.fi
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Mikko Rapeli <mikko.rapeli@linaro.org>

arch/arm64/kernel/efi-entry.S has been moved to
drivers/firmware/efi/libstub/arm64-entry.S by commit
v6.1-rc4-6-g4ef806096bdb and to
drivers/firmware/efi/libstub/arm64.c by commit
v6.2-rc3-6-g617861703830

Fixes: 4ef806096bdb (arm64: efi: Move efi-entry.S into the libstub source directory)
Fixes: 617861703830 (efi: arm64: enter with MMU and caches enabled)

Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-efi@vger.kernel.org
Cc: stable@kernel.org
Signed-off-by: Mikko Rapeli <mikko.rapeli@linaro.org>
---
 Documentation/admin-guide/efi-stub.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/efi-stub.rst b/Documentation/admin-guide/efi-stub.rst
index b24e7c40d832..090f3a185e18 100644
--- a/Documentation/admin-guide/efi-stub.rst
+++ b/Documentation/admin-guide/efi-stub.rst
@@ -15,7 +15,7 @@ between architectures is in drivers/firmware/efi/libstub.
 
 For arm64, there is no compressed kernel support, so the Image itself
 masquerades as a PE/COFF image and the EFI stub is linked into the
-kernel. The arm64 EFI stub lives in arch/arm64/kernel/efi-entry.S
+kernel. The arm64 EFI stub lives in drivers/firmware/efi/libstub/arm64.c
 and drivers/firmware/efi/libstub/arm64-stub.c.
 
 By using the EFI boot stub it's possible to boot a Linux kernel
-- 
2.34.1

