Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E5CD59C506
	for <lists+linux-efi@lfdr.de>; Mon, 22 Aug 2022 19:30:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236135AbiHVRaJ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 22 Aug 2022 13:30:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236415AbiHVRaJ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 22 Aug 2022 13:30:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 525093ECC1
        for <linux-efi@vger.kernel.org>; Mon, 22 Aug 2022 10:30:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C499761245
        for <linux-efi@vger.kernel.org>; Mon, 22 Aug 2022 17:30:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24A32C433C1;
        Mon, 22 Aug 2022 17:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661189407;
        bh=yHFWnlR+USiYmHUQaqc46XgPYdk1OtHdRS5BUOYmrDg=;
        h=From:To:Cc:Subject:Date:From;
        b=NRey/iu4YM/BiFaFAoim3mvqbXbCeKHn4t51RMjwv/ef8Pdoc7EL73PTYBYMftcDz
         kAgFc2FgYVla0IWZ5QX8XoTU6Fbn1/5eezpX8fkgRShGpCozrXSK5w8AEOTfTJV/5t
         +1a0ZZiSZPuW6Qu4iSN0vjZHTOkb74t5l2/ztCs9MyjPZu1PmYidXu3ek/6dyhINkp
         GMafQDaXFF2M5b0Ry9P2ClD1o/6aXH9Z8L42HYxTlC7QeWAgdyaM1k4NLHBz3YxpMx
         0sJeW28t+B1XovYKPICZhsYfsKrTN5zmtb1vsjt5hyFdkISwW+cbXbnK4r6Is0k7De
         pVU+SHWY/ffyQ==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     keescook@chromium.org, Ard Biesheuvel <ardb@kernel.org>,
        Daniel Marth <daniel.marth@inso.tuwien.ac.at>
Subject: [PATCH] efi: libstub: Disable struct randomization
Date:   Mon, 22 Aug 2022 19:29:53 +0200
Message-Id: <20220822172953.3918414-1-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1940; i=ardb@kernel.org; h=from:subject; bh=yHFWnlR+USiYmHUQaqc46XgPYdk1OtHdRS5BUOYmrDg=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBjA70Q70c+aAZDqm4V+5KDjee7Qp72OE9hjXIiDnwl 42XCmveJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYwO9EAAKCRDDTyI5ktmPJA47C/ oDAzBf8j4Ti2WyaUJx2gNyoYL/1++cEQzw4fakPI8siDw3AE+b6etkBbklyyQLJr7/mHRfnwacOmk6 xvLbRP7Zl6F5Sw2EGz14rFNpS3UXTVFgoatIgPlG35Fv28w/40viZh1mHKibvFKjtj8eE1SBeSgpOm TnoeJtjkt65NV5OTdEP95rV1zKajtN03kFzB+ZS5oNni3HSKrEGk3LWPMzI9Mftx8+MzWm0YCYlyPz B0o8hnE4bXBTOqRqba4560DUFju2cP6FQtZa+6zPlxm9tUE+fqV40gVC+DDNPckbMxA7gpLzTqIHYF u5LsJANa1DwXQGvGOdVOyvek98XcZ6zfbgr2v+Sji1gXo3hEaZM7C7Rh9tvVLlSgpHzKKua0/IS+S1 ElAwNb/QRHKTF4h4DTczwO8Y1fC0/d8KjLnYCCEuI4Up91uerSUWoRZ4/jy0LQSXVN1y+pK99Y2OhK UGnOslwIMXmaFbwH0gskIzT+UrnZU3jq6dJ71Rbzz12c4=
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

The EFI stub is a wrapper around the core kernel that makes it look like
a EFI compatible PE/COFF application to the EFI firmware. EFI
applications run on top of the EFI runtime, which is heavily based on
so-called protocols, which are struct types consisting [mostly] of
function pointer members that are instantiated and recorded in a
protocol database.

These structs look like the ideal randomization candidates to the
randstruct plugin (as they only carry function pointers), but of course,
these protocols are contracts between the firmware that exposes them,
and the EFI applications (including our stubbed kernel) that invoke
them. This means that struct randomization for EFI protocols is not a
great idea, and given that the stub shares very little data with the
core kernel that is represented as a randomizable struct, we're better
off just disabling it completely here.

Reported-by: Daniel Marth <daniel.marth@inso.tuwien.ac.at>
Tested-by: Daniel Marth <daniel.marth@inso.tuwien.ac.at>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/Makefile | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index d0537573501e..dd8c8a218245 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -42,6 +42,13 @@ KBUILD_CFLAGS := $(filter-out $(CC_FLAGS_SCS), $(KBUILD_CFLAGS))
 # disable LTO
 KBUILD_CFLAGS := $(filter-out $(CC_FLAGS_LTO), $(KBUILD_CFLAGS))
 
+#
+# struct randomization only makes sense for Linux internal types, which the EFI
+# stub code never touches, so let's turn off struct randomization for the stub
+# altogether
+#
+KBUILD_CFLAGS := $(filter-out $(RANDSTRUCT_CFLAGS), $(KBUILD_CFLAGS))
+
 GCOV_PROFILE			:= n
 # Sanitizer runtimes are unavailable and cannot be linked here.
 KASAN_SANITIZE			:= n
-- 
2.35.1

