Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74C51619DD6
	for <lists+linux-efi@lfdr.de>; Fri,  4 Nov 2022 17:53:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232224AbiKDQxM (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 4 Nov 2022 12:53:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232208AbiKDQwi (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 4 Nov 2022 12:52:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 052C43E0A9
        for <linux-efi@vger.kernel.org>; Fri,  4 Nov 2022 09:51:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8217762294
        for <linux-efi@vger.kernel.org>; Fri,  4 Nov 2022 16:51:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00ED4C433C1;
        Fri,  4 Nov 2022 16:51:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667580718;
        bh=/OBg7L/gJAEz552y4X96YIrN1O5w8vqBLudo3R2a+GU=;
        h=From:To:Cc:Subject:Date:From;
        b=C0m3T0za0+p7EG+/BYQkkxA/gVe5kcrv8Cq3Kbm3ALeflAK+ct0Iof5bdsP5778xh
         hfdvbMU3e8EGoe6Dg/mVwnOI+2gaDKtwH90jj8b13rAG5R6g1KYGpSvtr/8dThX1zC
         O0vGvvBWf96pr/0zi5BUT+fLT3U85WM/wY2w6+7mJehfy5lMdmt9b99US9pkuH0pYS
         TSXT+ZbuIZIFNE4pBhCmG05K9ZDeXcmdGzToz+YHjzIl9f89UpwIdXF8J9L68W24yI
         Pce0rOpM1nxjr/5Tf6uYcdUei/cg8tNji9SUtCYd3SoHML+Umjjwe2tZyZ1NWUBmy9
         PTmCphXiOxXXA==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
Subject: [GIT PULL] EFI fixes for v6.1 (#2)
Date:   Fri,  4 Nov 2022 17:51:49 +0100
Message-Id: <20221104165149.2397431-1-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2205; i=ardb@kernel.org; h=from:subject; bh=/OBg7L/gJAEz552y4X96YIrN1O5w8vqBLudo3R2a+GU=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBjZUMkTxjg16fxh+tTa83/DEcsTztTeZEq9ZVxLj72 EETCcfOJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCY2VDJAAKCRDDTyI5ktmPJN3MDA CncYxYMJDeADd8l+bzEEez7CrR4+fhevB1Zr16+7UBv9gW/V9kunscNvF41UZzrpdhC9fS1/dscuBy LnN/3dPJ8gTSwpJqTUIsDQs94H8IMX4JouDpp9i3i08vvZ1NRMwvz6vBUfvdMojtCRoIbpr5DxWnLE 1qVYgqNUmhiX0AQYdmbaAI+1nQ8Gkwp3p/ONe0PuuPMDQTOctAoEQMmB/JlRBHFvd9oYM00a9gBI3j tjqXhklJ+OjWwGO+5gILBco0AXnol7Rr5GSiqv/IyY87CNANyGx2TVStEK0kCe/YbbQhWcjFoN3lGC QkbkNL+AbK9uEwWxgRGyDj/ErnaubRDl99S+IazInfAod4TaDpCceQ4DMNMMHMaD6tU3Fnt+79JsJl PqUtc1R40G9nM+EF5vrNXprHWFY826wmNLCojxSYPmq0J/Wj4auLvughSAq9o6xk+NOB3lR+c5IrkF GwySr1M+/wOpEQKLp+z0KLtbSxb0Q3MHxGskHBsrJiCHY=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hello Linus,

Please pull the EFI fixes below.

The arm64 exception recovery is not a real fix, but it will be useful to have
in v6.1 going forward, so I've incorporated it here. I hope that's alright.


The following changes since commit 37926f96302d8b6c2bc97990d33e316a3ed6d67f:

  efi: runtime: Don't assume virtual mappings are missing if VA == PA == 0 (2022-10-21 11:09:41 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-fixes-for-v6.1-2

for you to fetch changes up to 23715a26c8d812912a70c6ac1ce67af649b95914:

  arm64: efi: Recover from synchronous exceptions occurring in firmware (2022-11-03 18:01:15 +0100)

----------------------------------------------------------------
Second batch of EFI fixes for v6.1

- A pair of tweaks to the EFI random seed code so that externally
  provided version of this config table are handled more robustly
- Another fix for the v6.0 EFI variable refactor that turned out to
  break Apple machines which don't provide QueryVariableInfo()
- Add some guard rails to the EFI runtime service call wrapper so we can
  recover from synchronous exceptions caused by firmware

----------------------------------------------------------------
Ard Biesheuvel (4):
      efi: random: reduce seed size to 32 bytes
      efi: random: Use 'ACPI reclaim' memory for random seed
      efi: efivars: Fix variable writes with unsupported query_variable_store()
      arm64: efi: Recover from synchronous exceptions occurring in firmware

Jerry Snitselaar (1):
      efi/tpm: Pass correct address to memblock_reserve

 arch/arm64/include/asm/efi.h          |  8 +++++
 arch/arm64/kernel/efi-rt-wrapper.S    | 33 +++++++++++++++--
 arch/arm64/kernel/efi.c               | 26 ++++++++++++++
 arch/arm64/mm/fault.c                 |  4 +++
 drivers/firmware/efi/efi.c            |  2 +-
 drivers/firmware/efi/libstub/random.c |  7 +++-
 drivers/firmware/efi/tpm.c            |  2 +-
 drivers/firmware/efi/vars.c           | 68 +++++++++++------------------------
 include/linux/efi.h                   |  2 +-
 9 files changed, 98 insertions(+), 54 deletions(-)
