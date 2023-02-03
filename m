Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 609E468A0F6
	for <lists+linux-efi@lfdr.de>; Fri,  3 Feb 2023 18:56:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232616AbjBCR4J (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 3 Feb 2023 12:56:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233681AbjBCRz5 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 3 Feb 2023 12:55:57 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6081AC238
        for <linux-efi@vger.kernel.org>; Fri,  3 Feb 2023 09:55:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 52F57B82B65
        for <linux-efi@vger.kernel.org>; Fri,  3 Feb 2023 17:55:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FDF6C4339B;
        Fri,  3 Feb 2023 17:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675446945;
        bh=NVM4s6u2/cXAP0wT3PSbufDgMUykQY/AvlJEbT/xuLc=;
        h=From:To:Cc:Subject:Date:From;
        b=jmI7Zs6/9j1lKNO4YAQI0OFnKu5ZWuwXRdAvBIPT/2nT5SKP0I43BIOdTl8s7wyra
         /ef29h0ZIpEpspbyot4Qy2kerJFfwoGRrz8NrNn6Nx5n69h+iPw6od8v9fYS0OEG3I
         KHjI7+IS4oGMIVudGkM3vWOw3lsnW4YFK4mdMeMFQntHDUGc3G+ZiNR/rHJSgpm68j
         DCIIYJPiuotFUofu8zvZ5v73BADX+0PAEHQX2TLtOGaVzxKli40cfjR4zBj4fLQaRy
         pAizHFQQkHgtCbIGrrX5mTYKgaFKJbaAOgJ8GvkJIg2j0atQcFtxvGdAy8d/9kQT3r
         yxWCVO2lalG1Q==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
Subject: [GIT PULL] EFI fixes for v6.2 batch #3
Date:   Fri,  3 Feb 2023 18:55:37 +0100
Message-Id: <20230203175537.2694499-1-ardb@kernel.org>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1117; i=ardb@kernel.org; h=from:subject; bh=NVM4s6u2/cXAP0wT3PSbufDgMUykQY/AvlJEbT/xuLc=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBj3UqYGvlonHNkZZX0S1gECxJueldE30EJuLTfQ RBV7NHHouCJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCY91KmAAKCRDDTyI5ktmP JAN4C/wPpDYafrnpBTMVSN7ROjd80EVo7sZEsQlwhszdNaUcLGlma4Fe+HZ6Tye5KpKethcBRez sKarii3jsHv1ATgsDSZAcjjVMjgUWu9WhyRduEU4fCz+6olD0tqI8VYCNIurygq1bBW4eHWtxVj uCw9K1hnBVbgtj2MlRF0nIsvbGW3bvyxQQcnM3MCGAits6YVEEvLE87HL1i8tbmR+4WYJDGjOeE v0hR6dU4f0eIMuS0LxXnjfyYQLOsfZZFhgXgH8fioLR49YajwbwytaIRjwu7+3OszvGIdykKdYh mBNb+32PdvKcvTGWS6t1LA8Hs/eKN9a6XNmRi885bvJ7OfEFYvvkopVURqOVui+YnF53temoGsx IHLPeNmz2ESjUlWYfjuecgqVXgpKOvcxJnrsYdAtfLoBrWnm/3O3dpyS5xbUf46DGHPd3KUz7b/ e4+QvNLPLJWzT6YZr9rvX46v37qJ7VnTY4MmkpTRFoe0QdM5DVGMC4gPIRYIGucal0s3g=
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

Just a pair of tiny fixes, both cc'ed to stable@. Please pull.


The following changes since commit e1fabbc83cb1dd4ba63932faa86c9cacb8bf791e:

  efi: Remove Matthew Garrett as efivarfs maintainer (2023-01-18 09:24:48 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-fixes-for-v6.2-3

for you to fetch changes up to 966d47e1f27c45507c5df82b2a2157e5a4fd3909:

  efi: fix potential NULL deref in efi_mem_reserve_persistent (2023-02-03 14:52:10 +0100)

----------------------------------------------------------------
Batch #3 of EFI fixes for v6.2

- handle potential mremap() failure gracefully

- don't reject EFI memory attributes table version 2

----------------------------------------------------------------
Anton Gusev (1):
      efi: fix potential NULL deref in efi_mem_reserve_persistent

Ard Biesheuvel (1):
      efi: Accept version 2 of memory attributes table

 drivers/firmware/efi/efi.c     | 2 ++
 drivers/firmware/efi/memattr.c | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)
