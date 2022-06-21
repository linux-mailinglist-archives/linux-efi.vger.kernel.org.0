Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64F985537B5
	for <lists+linux-efi@lfdr.de>; Tue, 21 Jun 2022 18:16:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353844AbiFUQQu (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 21 Jun 2022 12:16:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353149AbiFUQQu (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 21 Jun 2022 12:16:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B783DB7F5
        for <linux-efi@vger.kernel.org>; Tue, 21 Jun 2022 09:16:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 63EC9B819FA
        for <linux-efi@vger.kernel.org>; Tue, 21 Jun 2022 16:16:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AA3EC3411C;
        Tue, 21 Jun 2022 16:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655828207;
        bh=qjDCXnj1MVtIljAfNQtY0RB+mBqv1XcHPlPdiefrxO4=;
        h=From:To:Cc:Subject:Date:From;
        b=NxGCLdiPlxERe+nRZElg71cw1A+Y2SGDc5FMnNKuaEwUZtfSAD8epyd8W+KDcfhqZ
         AotZzUGMRuZnJ12vvatbafTT5MouCeTfLTleZVDGCp9NgrA4gQPPhsdOZlTm1T7Vqc
         fDSfpK8lrBh/mMt5jWuVyBSI3ZfJ1HdHX9+mJiCTyhlPtO7AMw3VqIQWM+vP+seMSs
         eFgeAe5uGeJzCbCqn/9wsa+oRUzi9CXs3mWxVazcdP4QvqGTjsHP3vZuX6JTdxMWXP
         nnfUqMLgFq5pQWmNGBdBWzWi9UyELIF9p8NxaMi9UtLDbuiz4FCumMPlHv8DQYqdir
         UYje/NmZcfDfw==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
Subject: [GIT PULL] EFI fixes for v5.19 #1
Date:   Tue, 21 Jun 2022 18:16:18 +0200
Message-Id: <20220621161618.3787669-1-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1083; h=from:subject; bh=qjDCXnj1MVtIljAfNQtY0RB+mBqv1XcHPlPdiefrxO4=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBise7RorEmYOOyG3aSzgNMhzvDwtvpuMOYMI01ltKd pWIMTayJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYrHu0QAKCRDDTyI5ktmPJFkcDA CIGG9x12GkjJyBn3cogQWRSybVyx65VSJAqglXwkus8wtpFmTco06fydWUfXzPJ7C5WNrj2Vt20tDF bgUD+egKYGqPnVREUdfGc3pnbuVjQRb0/Ocs4lUxGM6TLMUcn1ZLNNLMtTnBiOAEmM5yXoY+j2dtym 3TAEOyhsu+WNtgHkfLmwt8rz7XXItIhp2UxSxGtS3egTT5q9JpWNAde9aHkWcBPFbhVBiXfwx0MlZK NHz+5L3ZhPYFiL6DuNDfuVJywWE4R4ksDGV04iVvkgfnC1+E22Wt2VZmnBnMKsdofOPV9w5CGK6MUj nB08G1Tn8Ko1J0P/dFCdtmAqiSw9KN3fZAo1+HV+DQ3myoz6l59X04cYP7K5dAuukH6n9n21jmOi7r sI8/Ye8YWEaj8PH3a+yRtpjq/ki6PWOZZM9pvfqKMDT3WMNynL2fQHzlLRN3nsd1NK0RFwLr8PkZk2 wYS7E7M1jMOCbuu83yWeIzMVUKMYdtuPi/4YZf8gIvnq0=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Linus,

Please pull this pair of EFI fixes.

The following changes since commit f2906aa863381afb0015a9eb7fefad885d4e5a56:

  Linux 5.19-rc1 (2022-06-05 17:18:54 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-urgent-for-v5.19-1

for you to fetch changes up to aa6d1ed107eba26f49933216cffe797253914132:

  efi/x86: libstub: Fix typo in __efi64_argmap* name (2022-06-21 18:11:46 +0200)

----------------------------------------------------------------
First batch of EFI fixes for v5.19

- remove pointless include of asm/efi.h, which does not exist on ia64
- fix DXE service marshalling prototype for mixed mode

----------------------------------------------------------------
Evgeniy Baskov (1):
      efi/x86: libstub: Fix typo in __efi64_argmap* name

Javier Martinez Canillas (1):
      efi: sysfb_efi: remove unnecessary <asm/efi.h> include

 arch/x86/include/asm/efi.h       | 2 +-
 drivers/firmware/efi/sysfb_efi.c | 2 --
 2 files changed, 1 insertion(+), 3 deletions(-)
