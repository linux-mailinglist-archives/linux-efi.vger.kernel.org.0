Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD0C36EF605
	for <lists+linux-efi@lfdr.de>; Wed, 26 Apr 2023 16:11:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240010AbjDZOLP (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 26 Apr 2023 10:11:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbjDZOLO (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 26 Apr 2023 10:11:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 125E3659E
        for <linux-efi@vger.kernel.org>; Wed, 26 Apr 2023 07:11:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A30746366F
        for <linux-efi@vger.kernel.org>; Wed, 26 Apr 2023 14:11:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8949C433D2;
        Wed, 26 Apr 2023 14:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682518273;
        bh=kUHvDlh304QREoEAxxQud/4lPKTUAgBP83GHnxSAN9Y=;
        h=From:To:Cc:Subject:Date:From;
        b=E85o4l43m/zt8d6Dtw+goxCfOVoATvmnHQj6RAJT+R2Fa6WtdKU3XlaA9aZpm2qxj
         PYT1TiZT0t7f+m7/R7LVXteYtGMyAowNIWL0384RY8r9i1ZasjIFlrWSGXhKDwxdIK
         urJ5du+/bAVD5OsMSXIyZ4D3d5Mui/rWnHuukVQRKDi0XgGu8JS9sWPN037IZ8g5OV
         /t2voSunLhqoFZMzDo0hEEUB7ii8o9lvt+/wwwm3cz6mAb04VZO4z5lwgiR/D79kii
         yN71RdfgNeWSDZICAwup6blk2x+mwb1InH8jurKaQ1CD9tvREwQd5Y3iCVeaO8VaOK
         n1c9X2yXHVwTA==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-efi@vger.kernel.org, mark.rutland@arm.com,
        catalin.marinas@arm.com, will@kernel.org,
        Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH 0/2] arm64: Expose kernel code size to EFI zboot code
Date:   Wed, 26 Apr 2023 16:11:01 +0200
Message-Id: <20230426141103.2464423-1-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1122; i=ardb@kernel.org; h=from:subject; bh=kUHvDlh304QREoEAxxQud/4lPKTUAgBP83GHnxSAN9Y=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIcXT4KvYzD2ZhQ9y7nf8lea/9UKRXcb3tXPdpv06Rzs2B j3U6CzrKGVhEONgkBVTZBGY/ffdztMTpWqdZ8nCzGFlAhnCwMUpABPpdWP47xEo+Nbmzdl9M6b9 mHaYzd7ISOV531qnSxufx8512ji7czbDPyUuUxW/IzWLLx1j3Z1x99jvnCKlf0rLX0meP5Z29Pa 8Kh4A
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The EFI zboot code needs access to the kernel code size, in order to be
able to determine which part of the image needs to be cleaned to the
PoU, and does not tolerate being mapped with non-executable permissions.

Instead of adding [0] this to the kernel image header, which makes it
ABI, let's use Kbuild rules to inject this quantity into the zboot
payload ELF object.

[0] https://lore.kernel.org/all/20230418134952.1170141-1-ardb@kernel.org/

Ard Biesheuvel (2):
  efi/zboot: arm64: Inject kernel code size symbol into the zboot
    payload
  efi/zboot: arm64: Grab kernel code size from zboot payload

 arch/arm64/boot/Makefile                    |  3 +++
 arch/arm64/kernel/image-vars.h              |  4 ++++
 drivers/firmware/efi/libstub/Makefile.zboot | 16 ++++------------
 drivers/firmware/efi/libstub/arm64.c        | 19 +++++++++++++------
 drivers/firmware/efi/libstub/efistub.h      |  3 +--
 drivers/firmware/efi/libstub/zboot.c        | 15 ++++-----------
 drivers/firmware/efi/libstub/zboot.lds      |  7 +++++++
 7 files changed, 36 insertions(+), 31 deletions(-)

-- 
2.39.2

