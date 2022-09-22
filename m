Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F23C65E6508
	for <lists+linux-efi@lfdr.de>; Thu, 22 Sep 2022 16:22:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbiIVOWF (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 22 Sep 2022 10:22:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231803AbiIVOVk (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 22 Sep 2022 10:21:40 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3D54FCA7B
        for <linux-efi@vger.kernel.org>; Thu, 22 Sep 2022 07:21:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 64F32CE21CC
        for <linux-efi@vger.kernel.org>; Thu, 22 Sep 2022 14:21:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAD41C433D6;
        Thu, 22 Sep 2022 14:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663856491;
        bh=ANAha4lMJ+VyRFGnKGJixExP5DKPMPZvp9fuAM0nU5Y=;
        h=From:To:Cc:Subject:Date:From;
        b=MfKaBcdUG/FE8WeMVL0efWwfbM8I4terbawAe3n4bnqMQ0NG1Gb2GBlZqvEBGAyJO
         4DHwH0jiYFh+6jqV+7lzcEqwZktWyFscfzzRRNrSP/h16qavSvARr/CxlBaTF4a9IG
         ZtyvE3q+dA8x+2r5/l+KEK9K/D34vBRoi9KnmOxqhkrcMm/+2aelqiWROH/1KsUq/f
         /Xr3r6mEOqNGZyIOHkAgVlAvorgSCaxoURDHrYlrl7ECITCI+NdQHrhWm0gi8pR5Pe
         B/JHK0AVYJsWQr8q9OaQ2gdDvXTL6FEzdHxOl/FKZ4Cxne3zq9zd3gKS1b9iR2+lS9
         lLv4aluFFpQQA==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
Subject: [GIT PULL] EFI fixes for v6.0 (#2)
Date:   Thu, 22 Sep 2022 16:21:22 +0200
Message-Id: <20220922142122.1208186-1-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1196; i=ardb@kernel.org; h=from:subject; bh=ANAha4lMJ+VyRFGnKGJixExP5DKPMPZvp9fuAM0nU5Y=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBjLG9hCFeCPujF0PiB/cJ0t6PqaHE+U3WH7kVUn84a hqN9AGqJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYyxvYQAKCRDDTyI5ktmPJCB5C/ 0TnfwBaotcNE02JGlGlyJoG9SN7rnDfDPmTfn6H2TjSZlXiyVhyTCdJqw4hFJP01T07T3slaBlOUOC jd4WWxavdO5AinSiqVczBjtDJAtVWNLAG+urWpb6FnIvbB6fREq99UABfxquaG23xJ+nQ8HiuqQshy /4Ey7pdjzg0HbWVghcgWDbtS2PmtRS0xStVZC1JWO3SxFZ+zzpnYv1IPzEVI4YjtdWDfsktqaph5Rs rx9dYTAkjOhfujcHMhrLO+q6y6FTk9ALKl/CmOlGbcl/GYE2ewg5xVqjWGyNRRevrq9w0COD4YT45M dbBSyYzrQV8XqwwgNaEqx6sQKM2JADf8fMfORliuuVmG3n8q3YcNmGVmeALoRRJLG1MxH0XbnKLIxZ SQepSp1n50YSgtgKUfDyQkgJoc/03ojlvg2Ge99Qsl+0pY4iUWn4sP+Py6u05h3R+Enx3iGGLhqAS1 GrIJoVvmTePWDfe+08F3zbr0J67DQ7cP08pt1Ot2aZ278=
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

The following changes since commit 9cb636b5f6a8cc6d1b50809ec8f8d33ae0c84c95:

  efi: capsule-loader: Fix use-after-free in efi_capsule_write (2022-09-07 18:23:56 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-urgent-for-v6.0-2

for you to fetch changes up to 5f56a74cc0a6d9b9f8ba89cea29cd7c4774cb2b1:

  efi: libstub: check Shim mode using MokSBStateRT (2022-09-22 10:15:44 +0200)

----------------------------------------------------------------
EFI fixes (take #2)

- Use the right variable to check for shim insecure mode
- Wipe setup_data field when booting via EFI
- Add missing error check to efibc driver

----------------------------------------------------------------
Ard Biesheuvel (2):
      efi: x86: Wipe setup_data on pure EFI boot
      efi: libstub: check Shim mode using MokSBStateRT

Guilherme G. Piccoli (1):
      efi: efibc: Guard against allocation failure

 drivers/firmware/efi/efibc.c              | 3 +++
 drivers/firmware/efi/libstub/secureboot.c | 8 ++++----
 drivers/firmware/efi/libstub/x86-stub.c   | 7 +++++++
 3 files changed, 14 insertions(+), 4 deletions(-)
