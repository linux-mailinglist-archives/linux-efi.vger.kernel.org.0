Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 804A766E09E
	for <lists+linux-efi@lfdr.de>; Tue, 17 Jan 2023 15:29:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbjAQO3C (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 17 Jan 2023 09:29:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232682AbjAQO2b (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 17 Jan 2023 09:28:31 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EF4D7EFE
        for <linux-efi@vger.kernel.org>; Tue, 17 Jan 2023 06:27:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C2A7CB81646
        for <linux-efi@vger.kernel.org>; Tue, 17 Jan 2023 14:27:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7F1AC433D2;
        Tue, 17 Jan 2023 14:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673965652;
        bh=frMaMPiQkCkfpk+aLJFZL8Ueto1dVpQns0bzs5KnRls=;
        h=From:To:Cc:Subject:Date:From;
        b=uUPvXOtK3Bpcoixgdj4zUqgDoPyXYkKkkf42/Pe4fOLoL7nir/IANa4g06Gijs277
         MywcWVoieqK8E4f6XZ1GXGmn+pGvCqitXJ4qwOTYaT3KcYNgXJzH33I/k8qG32gUj+
         vBxu2nQ+2Z6LjrRefB8LBkDJY75WUdEKnYL/HMTJ/XY9a8Y13llQzUh4MKdVTj4Tyr
         jWs3dzKeSoWbDv1BeTDmwuBL5pmUx9FZtSmdo2zsD3+VxXI8YLyDi4d2Iqml5NxZC3
         QgqvxKV7e+zJFaLspRjeC9ofD/Md7tPn0iQaYnpQU7wV38NFGL94pU6+u5x8hoKmYY
         zkY/rGltlQVHQ==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Ard Biesheuvel <ardb@kernel.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Steev Klimaszewski <steev@kali.org>,
        Shawn Guo <shawn.guo@linaro.org>
Subject: [RFT PATCH 0/2] arm64: efi: Call SetVaMap() with a 1:1 mapping
Date:   Tue, 17 Jan 2023 15:27:16 +0100
Message-Id: <20230117142718.564299-1-ardb@kernel.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2088; i=ardb@kernel.org; h=from:subject; bh=frMaMPiQkCkfpk+aLJFZL8Ueto1dVpQns0bzs5KnRls=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBjxrBClj6w9F1o/JsCvEP4WELlpTSSvs7iUvuFa7h8 VRaF3wKJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCY8awQgAKCRDDTyI5ktmPJCHGDA C7b/YUWdeP9E7lgDK0018Ku2/nsjfDwBmzWrrTYvlUV2aoWO9pRZ4yqVFB7j0BBUJbuC3s09MXwaT7 /CsiYSqZPTLC66OtIwjaS0spOErg3hQTZehkk/NcKM6beC0emL9/HkzOYLIf5q3uiGTWq72Bfu4/U+ Aiv8CnrCudDUsr+jsKiIr4l3kZZodPFaprVFmaLPP4lFsfgoadn+yc00ySPlrUokmLK4QSepKzkhy5 MkUp+0N2tthf6uSKlYd09TTshD5Pjt04G9prF90864JjQQkvNHoY8pxmjzUUsRc28KW2VBKvA9y92Q FgfFZafZvYDCkAbjsV7duQYpg9VvIV0VDHPnb00fIpAD/9s0v2Q8UKnMoTkUFZVBOmuDOKiO5zfBUD TQnKjYMLhbofyhOv8AGi+53Xb9hWefeyjT0hwWfxYcywckmwWz22P50mR+EG5jV7DIfWMREAnxQkfY 3vMmWkYPWjZU4jij3BqDtlREAV/gLtL8R+7xsSeVgUldI=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Linux on arm64 is now in the same boat as x86, where supporting laptops
that were built to run Windows and never tested beyond what is required
for the Windows Logo certification need workarounds for all kinds of
bizarre behaviors.

On Snapdragon laptops, we cannot call SetVirtualAddressMap() from the
stub, because the firmware will crash while trying to access memory via
the virtual addresses being installed, which is explicitly unsupported
by the EFI spec.

However, not calling SetVirtualAddressMap() results in other problems:
on Ampere Altra, it causes SetTime() to crash. On Surface and Flex5g
Windows-on-ARM laptops, it causes ResetSystem() to crash.

So let's try to work around this while not making too much of a mess.

First of all, install a 1:1 mapping instead of avoiding SetVaMap()
altogether - from the EFI spec pov, this should amount to the same
thing.

Then, given that we already use a SMBIOS based hack for Altra to force
the use of SetVirtualAddressMap(), let's check for Surface systems in
the same way.

Please test, and please report the SMBIOS type 1 family field for which
this workaround is needed.

Also, note that these changes will not make a difference if the
EFI_RT_PROPERTIES_TABLE lists SetVirtualAddressMap() as not implemented.

Nathan, I would appreciate it if you could give this a spin on your
Altra box (only patch #1 should make a difference), and for good
measure, double check that hwclock still works as it should.

Cc: Johan Hovold <johan+linaro@kernel.org>
Cc: Maximilian Luz <luzmaximilian@gmail.com>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Steev Klimaszewski <steev@kali.org>
Cc: Shawn Guo <shawn.guo@linaro.org>

Ard Biesheuvel (2):
  arm64: efi: Prefer a flat virtual mapping of the runtime services
  arm64: efi: Force use of SetVirtualAddressMap() on MS Surface

 arch/arm64/include/asm/efi.h            | 2 ++
 drivers/firmware/efi/libstub/arm64.c    | 3 ++-
 drivers/firmware/efi/libstub/efi-stub.c | 6 +++++-
 3 files changed, 9 insertions(+), 2 deletions(-)

-- 
2.39.0

