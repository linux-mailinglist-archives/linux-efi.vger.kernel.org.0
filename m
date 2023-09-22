Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CB667AAE65
	for <lists+linux-efi@lfdr.de>; Fri, 22 Sep 2023 11:40:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231335AbjIVJkt (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 22 Sep 2023 05:40:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbjIVJks (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 22 Sep 2023 05:40:48 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9397E94
        for <linux-efi@vger.kernel.org>; Fri, 22 Sep 2023 02:40:42 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B45FC433C8;
        Fri, 22 Sep 2023 09:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695375642;
        bh=LQ3eqXLec29XxS8ZEV2rNoQC090pcEttxo87mziz+ls=;
        h=From:To:Cc:Subject:Date:From;
        b=tb533mNcOPB9gqFD1u901ijRbYUgmB1zl5juTPsQe/eEaRuKh+DlquXRLaHWVfXLV
         wXZsHxPcEI8t69O2xZGZNfEW9InV8C2OAT6OJ2hj3f3nDWkYz06++fJPBWpCf8jBgN
         /F5Lp2IAL7Ks8smwtJFNxRWY5sY3EMNwYsl0LNjfVmeyfsnQHrUWaWy1VIp9xGVf7n
         rZ0M28a9ZnLV5Uspw+VpmimziswjSCK00nsoAn9FzGPfueLb3q5SV9u0e8brJSRYk7
         5SfZ2bv/CvgKtpkakIxyc9O06qzwZ/yvdwIGI/vVe6vYoJaGoDCAWTq9HUp+tE/sdS
         L7qOgQlN/TTgA==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
Subject: [GIT PULL] EFI fixes for v6.6 (#2)
Date:   Fri, 22 Sep 2023 09:40:27 +0000
Message-Id: <20230922094027.204834-1-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1277; i=ardb@kernel.org; h=from:subject; bh=LQ3eqXLec29XxS8ZEV2rNoQC090pcEttxo87mziz+ls=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIZU3kXvDPxaRLYyeWcuSphz5fV2F9c8pm/nqJ04vqaxYo nLnE7NgRykLgxgHg6yYIovA7L/vdp6eKFXrPEsWZg4rE8gQBi5OAZjI63aG/6Xxrhcf5WVM8rrp xPDSfc2tlW9WLrjMb6v69YFO59am5vUM/wwWrHy6ef3rgHKZDE/DfdvbZ4VOvXNitc2mKuuyJ5q XdvIBAA==
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hello Linus,

Please pull this follow-up fix for the unaccepted memory fix merged last week
as part of the first EFI fixes batch. The unaccepted memory table needs to be
accessible very early, even in cases (such as crashkernels) where the direct
map does not cover all of DRAM, and so it is added to memblock explicitly, and
subsequently memblock_reserve()'d as before.

The following changes since commit 79b83606abc778aa3cbee535b362ce905d0b9448:

  efivarfs: fix statfs() on efivarfs (2023-09-11 09:10:02 +0000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-fixes-for-v6.6-2

for you to fetch changes up to 8dbe33956d96c9d066ef15ca933ede30748198b2:

  efi/unaccepted: Make sure unaccepted table is mapped (2023-09-19 16:11:36 +0000)

----------------------------------------------------------------
EFI fixes for v6.6 take 2:

- fix boot regression on SEV-SNP (and TDX) caused by a fix in the
  preceding batch

----------------------------------------------------------------
Kirill A. Shutemov (1):
      efi/unaccepted: Make sure unaccepted table is mapped

 drivers/firmware/efi/efi.c | 32 +++++++++++++++++++++++++++++---
 1 file changed, 29 insertions(+), 3 deletions(-)
