Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88ABF4FB887
	for <lists+linux-efi@lfdr.de>; Mon, 11 Apr 2022 11:52:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245634AbiDKJy2 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 11 Apr 2022 05:54:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344909AbiDKJwR (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 11 Apr 2022 05:52:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2754D41326
        for <linux-efi@vger.kernel.org>; Mon, 11 Apr 2022 02:49:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D659CB80F97
        for <linux-efi@vger.kernel.org>; Mon, 11 Apr 2022 09:49:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B614CC385A3;
        Mon, 11 Apr 2022 09:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649670594;
        bh=1qxefU9ioI70as0lbJZH1S8z3I47C60UFcTZFTnl2os=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n+rblAVRH4wDlEtdFm7egzo+8XH9XkP+N9ksYrhYr0XqMyHVhUPUVjemwfV6fqmy5
         PRjAqC8+Kf5qwGUoAzG0JEX+IKVS81z2av8dnUyThc+yEAO+VsLKwNi0ngvJEOXgod
         5KiLFlaE1/+Bg+10ZFQzcH0F02hbn1b1PEAl2GKPeD6P1TLPC9+iLNxGOOggy57RXj
         3e3enBZ2z2N5mqNc6VE82oNGG8OClP+llsmNzKP/ZZQC0tTV4OrTj6yPRSrT6pUiy6
         j4VgCWxiq9d7QOHJH3xrtDPpfSMxeweobEWAHwzO+CiYUJNANm99/b0Hh8zivnjk/q
         w7MFxb/dXiLfg==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v3 30/30] arm64: efi/libstub: enter with the MMU on if executing in place
Date:   Mon, 11 Apr 2022 11:48:24 +0200
Message-Id: <20220411094824.4176877-31-ardb@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220411094824.4176877-1-ardb@kernel.org>
References: <20220411094824.4176877-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=986; h=from:subject; bh=1qxefU9ioI70as0lbJZH1S8z3I47C60UFcTZFTnl2os=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBiU/lnFUYaEzHCp/GnbA810DD+iTSzsBU687E/JIft 4fc53xCJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYlP5ZwAKCRDDTyI5ktmPJHQcC/ 92qP+noLshpJmyk5f21siOVQ14gjQqcxRXRd3mQAmsSR5m586LNL+dJdre3/Y/k6UQ/6VK1kvODh6Y VyLa73v4SF6I/dInO+KGJt5sOexXtTBr2XeKK4TydG2faSK0ZjEzdbZcJK0gJ5fDHMn1+bp2ymhl1t xG94oC8bEQmGp+MeX7Op9gOOqSTeo6TyXwsKkp4z0jApClWEqXGgb7ntv0uKaoXwEbE23j9V9TKDAf bTWCij7AVbE/l9wPG59Jlo12EAWvYDTtGSwFweMhxuDbcGge/P3XlCkzwjrMSDrMALOZmjA2jYReBM 23WUxyDmwW7tkMgVm9HmkVQwl4cXWu0fM8RMFr0FKvD+22+MQ9/Sz5la1UiMSQmAPifylVVwbEII52 NEEFf8RPBMh5B2Sa4+ZPLAZYMlmOeaQHBYYwwXLEK7xDFLXovNU1Mwa7/Rw0ZQiJ3O70U1faR5JDl3 SID408Az8bMDf9dvjBJXLa8Y63E8G51uv65SahI9z324k=
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

If the kernel image has not been moved from the place where it was
loaded by the firmware, just call the kernel entrypoint directly, and
keep the MMU and caches enabled. This removes the need for any cache
invalidation in the entry path.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/kernel/efi-entry.S | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/kernel/efi-entry.S b/arch/arm64/kernel/efi-entry.S
index 61a87fa1c305..0da0b373cf32 100644
--- a/arch/arm64/kernel/efi-entry.S
+++ b/arch/arm64/kernel/efi-entry.S
@@ -23,6 +23,10 @@ SYM_CODE_START(efi_enter_kernel)
 	add	x19, x0, x2		// relocated Image entrypoint
 	mov	x20, x1			// DTB address
 
+	adrp	x3, _text		// just call the entrypoint
+	cmp	x0, x3			// directly if the image was
+	b.eq	2f			// not moved around in memory
+
 	/*
 	 * Clean the copied Image to the PoC, and ensure it is not shadowed by
 	 * stale icache entries from before relocation.
-- 
2.30.2

