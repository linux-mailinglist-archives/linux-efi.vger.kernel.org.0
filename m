Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4395465DB6B
	for <lists+linux-efi@lfdr.de>; Wed,  4 Jan 2023 18:44:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234990AbjADRoq (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 4 Jan 2023 12:44:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbjADRop (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 4 Jan 2023 12:44:45 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED0341A3A6
        for <linux-efi@vger.kernel.org>; Wed,  4 Jan 2023 09:44:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 92D04616C3
        for <linux-efi@vger.kernel.org>; Wed,  4 Jan 2023 17:44:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 784EFC433EF;
        Wed,  4 Jan 2023 17:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672854284;
        bh=4TD447+1AlzzfNQIM/zTYXzGWHZkZTqSZMuk5jvGLqg=;
        h=From:To:Cc:Subject:Date:From;
        b=KC+IgMwAw3LMKX3/Dg74V+HH3BCW0SA2HH/RSAr729snK+/rv0Ze9hGYEeqSPsEJI
         dIVNqzDf/9eKFZpAZ+E+y/A0tQvY6QDbEy7cx/GGyqOKpDnVfqGN9DKFdXFXhU3CZg
         GPOOT6yYEGv37qB33txVkQWDhehqg4h5fPK24lrjn9tvEIAzfx6P0jtSyxYNtwexto
         gyOrlIWc0Tj2NyAS/TF1YwyF+QyyPrF2waIG79eC/n5zOSvO7iRnxD07ripyWU4w4s
         57uEa7UA8iVrBSctnDQBHMXPqQFZEyXireuWwu8e/EUY1bWKzQA2TL36rLC4cEfHlO
         vUIhtaHVSa/kw==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-efi@vger.kernel.org, catalin.marinas@arm.com,
        will@kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Lee Jones <lee@kernel.org>
Subject: [PATCH v2 0/2] efi: Follow-up fixes for EFI runtime stack
Date:   Wed,  4 Jan 2023 18:44:31 +0100
Message-Id: <20230104174433.1259428-1-ardb@kernel.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1233; i=ardb@kernel.org; h=from:subject; bh=4TD447+1AlzzfNQIM/zTYXzGWHZkZTqSZMuk5jvGLqg=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBjtbr8dl/IUsYlUPeg8qb3atDV6dgiABFcQsE0kdp/ inxSgqyJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCY7W6/AAKCRDDTyI5ktmPJGgNC/ 4xwp23Qtf5dJVpYsoOVH3V9PZJUXrOUfxufQsLqdEs/vfr1Ln27ryXFKxQFk3Z0xvxktomoBamc1NF GGFRrfYxWMedZnaVMfJbmMzvSYEDCh3tRJMGEZLNMexfpo49EOouEdmIYewIujFwyRgO094ruMhwku cXbV+34E3WqJyYVAVDyEA92zpJzTUB0yOnM2KwCHm5tCI6zOpt6yhVfYTlbK96K0FjPf5fWw8MDlVI dL++ZsPy2KwFQQzqRQK6uw9UhxusEr/guqtJoQOLnEbkCaqorL18qtsCFQwgP9Zr0eyBmWnI+flT3E wirDEDMp5Vy7hnqgRZ6y0yyqeSmjP+q0WW6dprFjoMMiWpfGgLQ15gcU4T+T15MpDsEr3zseUTSavz 5BNGkGXul0n1Cq23RCYTYnPAqMBBbOiGJBknDsPqJgRVoQ07NUZwQ6uRLG2o/i6rkVN3n17INhY+cB AHUXodoZw+glUEmpKeMK+uvS2KGUP7AjXTIdLLNK5Asa0=
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

Commit ff7a167961d1b ("arm64: efi: Execute runtime services from a
dedicated stack") introduced a dedicated stack for EFI runtime services,
in an attempt to make the execution of EFI runtime services more robust,
given that they execute at the same privilege level as the kernel.

However, this stack needs to be declared to the stacktrace machinery,
which is careful not to walk the stack when it leads into memory regions
that are not known to be allocated for stack use.

Also, given that the ACPI code may invoke the low-level EFI runtime call
wrapper without using the dedicated kernel thread and workqueue, we
should take this into account when trying to gracefully handle
synchronous exceptions.

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Lee Jones <lee@kernel.org>

Ard Biesheuvel (2):
  arm64: efi: Avoid workqueue to check whether EFI runtime is live
  arm64: efi: Account for the EFI runtime stack in stack unwinder

 arch/arm64/include/asm/efi.h        | 10 ++++++++++
 arch/arm64/include/asm/stacktrace.h | 15 +++++++++++++++
 arch/arm64/kernel/efi.c             |  3 ++-
 arch/arm64/kernel/stacktrace.c      | 12 ++++++++++++
 4 files changed, 39 insertions(+), 1 deletion(-)

-- 
2.39.0

