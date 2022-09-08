Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06DC35B1A66
	for <lists+linux-efi@lfdr.de>; Thu,  8 Sep 2022 12:45:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231533AbiIHKp0 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 8 Sep 2022 06:45:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231401AbiIHKpG (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 8 Sep 2022 06:45:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D3E563F35
        for <linux-efi@vger.kernel.org>; Thu,  8 Sep 2022 03:44:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 07E96B820BD
        for <linux-efi@vger.kernel.org>; Thu,  8 Sep 2022 10:44:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7FCCC433D7;
        Thu,  8 Sep 2022 10:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662633872;
        bh=NKYJCLAWhrYyrrHwlwT5hNVYetsBT+7lnZ4+YR82A3w=;
        h=From:To:Cc:Subject:Date:From;
        b=lAN27rHxpBRa32XdoQvBxtZttUTP3fHHNYd0ajd7Y+gBw6knQgfzpe1qvSmfNEt8N
         TxsXDt84WB28ydhYsgYkkyPgr0dFm2GtITW58FlReQu6UcA4WuAHVcwxBeqjfIOibp
         3sXZESISEEVdphsvi3h5Y1iz7PUE+UJwcd6BTUHp+xz09XSD8+YYdMfBr1eoMWJ4g+
         5MYR6WZ5KAuiWcNoUDqQfkhRnhU5bZrkXvLG+IhKOizA3r3T69rE1EwzglcqSsY/gw
         U2pObdh0qUESFVJLfd65tusb25hEbTxhXYbNeu8gOq4v7erYo+nJpLLhILVFsMuqw0
         A+5fh/8UhOhCg==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     linux-efi@vger.kernel.org, gregkh@linuxfoundation.org,
        Ard Biesheuvel <ardb@kernel.org>
Subject: [GIT PULL] EFI fixes for v6.0 #1
Date:   Thu,  8 Sep 2022 12:43:59 +0200
Message-Id: <20220908104359.1416858-1-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1215; i=ardb@kernel.org; h=from:subject; bh=NKYJCLAWhrYyrrHwlwT5hNVYetsBT+7lnZ4+YR82A3w=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBjGcdup+F1cyxtdeKpEIw9MgE+NWA6XiDuuI8Q3X1M TgIR1MeJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYxnHbgAKCRDDTyI5ktmPJH4tC/ 9cRItcmRpswXvOWaPzvRaNKU66J4sJaEkTF78edjmCcnKIWrUm95RIJfSIiiiai40cScufjHfTkd38 msyeh7pjlSkPxRM8UA906irT+y7mOtx1DJDnJ5yRJVnGidEwphzS6/cZLPhq4gcN/olspTXhZl8Kqo D12c3RfN5RwFfAll1fyvuOi4kUyRSTEyQMHS1BjY8to4DMlHPrNOmGw7DMrc6iP5UoHCNVcPXds2qy uUiKrQ6z4tqtw4odhsfZISOMRpnhLu01FVmcNaKz5bmIGyZiblj3EFHi2TOOM3dvoUGNdpkYPvwJjh wBDH0RM6fh9D/6B8WvqJgVa7aJEsA8ZDSdmoHv1m0Ccf6VZaDQIddfdvBgVq8Si1kS9iWJKVXMqjCm sxEybLKYp1StFm5vOyqZJiGqEa1XzE969NrQ1ahJfMwldjaaQE7PGesyL89COh1zH3baIbtYoxmu4d REZLuvv3+3WmFAliE9/Yh/kPbEq+sn2Z12RqU7enE2qls=
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

The following changes since commit 568035b01cfb107af8d2e4bd2fb9aea22cf5b868:

  Linux 6.0-rc1 (2022-08-14 15:50:18 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-urgent-for-v6.0-1

for you to fetch changes up to 9cb636b5f6a8cc6d1b50809ec8f8d33ae0c84c95:

  efi: capsule-loader: Fix use-after-free in efi_capsule_write (2022-09-07 18:23:56 +0200)

----------------------------------------------------------------
A couple of low-priority EFI fixes

- prevent the randstruct plugin from re-ordering EFI protocol
  definitions;
- fix a use-after-free in the capsule loader
- drop unused variable

----------------------------------------------------------------
Ard Biesheuvel (1):
      efi: libstub: Disable struct randomization

Hyunwoo Kim (1):
      efi: capsule-loader: Fix use-after-free in efi_capsule_write

chen zhang (1):
      efi/x86: libstub: remove unused variable

 drivers/firmware/efi/capsule-loader.c   | 31 +++++++------------------------
 drivers/firmware/efi/libstub/Makefile   |  7 +++++++
 drivers/firmware/efi/libstub/x86-stub.c |  1 -
 3 files changed, 14 insertions(+), 25 deletions(-)
