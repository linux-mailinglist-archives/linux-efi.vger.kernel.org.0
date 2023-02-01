Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 146756866CA
	for <lists+linux-efi@lfdr.de>; Wed,  1 Feb 2023 14:25:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232319AbjBANZs (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 1 Feb 2023 08:25:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232308AbjBANZr (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 1 Feb 2023 08:25:47 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBA454ED1
        for <linux-efi@vger.kernel.org>; Wed,  1 Feb 2023 05:25:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 577AA617A2
        for <linux-efi@vger.kernel.org>; Wed,  1 Feb 2023 13:25:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B0E6C433EF;
        Wed,  1 Feb 2023 13:25:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675257945;
        bh=XK/Ho6oGJr4EHcGcxAtvUb7RihbSYDJ1yJ5DhPWt7Ag=;
        h=From:To:Cc:Subject:Date:From;
        b=QHTLx9gmC1p/+lG24tVd5iKFBtXyO+FsMB3tKugxAS3gt02oWlxBbhOO5DD/RRNwr
         W4cjr+cyp540yp54nHqlJ00qs+bdBzVCrNcjSBRMquBVpRppdOIq2ahYLQjca/ncbX
         uUocfkA28ziJ+G0w5gU1XmzIA0huXkZZhPqG7h4IK5+AjpnhRTGf0G4ronWuav8TyX
         wQKjfvLAKUb39+z52jyGdFkCY82305wVjaDslAzzc8xPRsJd87yeVlzWii9HdXjkqq
         MDT7CIzBEY5Pu/lQG6lLmcdGzt4Uo+aSMHQ7EiQdhlcdU9kweYApBzslhITC0FaIYL
         bWmC95AZV61UA==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Ard Biesheuvel <ardb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 0/2] efi: Enable BTI for EFI runtimes services
Date:   Wed,  1 Feb 2023 14:25:38 +0100
Message-Id: <20230201132540.2196065-1-ardb@kernel.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1084; i=ardb@kernel.org; h=from:subject; bh=XK/Ho6oGJr4EHcGcxAtvUb7RihbSYDJ1yJ5DhPWt7Ag=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBj2mhRvEODZjV/MzatlpuC5NrH0e51XiZUZSMpJ 3wDQGUkXmOJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCY9poUQAKCRDDTyI5ktmP JPD4C/40u7PCLh2/WrRd3JAvh4bxZ5FKYP+/8fn4thfPMu+zMJ0fL+VU1v6cKQ4ppXH5lkvkwQU YgRDG9TT8T3eRCcBofEyDEr4YT5U2m7b5iTOVY59B59AYilpFpeMQ5rFDLuk/pQgFq5Ij18WFdi l+QajW5eQo3KYjs74u73Tu7W1fw+A4F3xZE2C1N8Ho7v9aDyTTFAIS1crJS6cb0FAOC5fLVCRDa MRkqmB1w74JEp5QTtwub4POfjh9c/78UWuJvonnUklwfg8bo/wGfW442tcC3iw05MtrWZcovBXP UzX3Z8KFq0NfJWAhvtSEi/YwI0YayUcI49uko8UmwZX5gOUvLIzfaHXTo2oUAhdZRhFHcaHQk06 7JYusR75TO6iQUq/mHr9ks8doPUmqfoMCOtLJDC1KQjk+0tyCQa6vMyCSnXjYHAjhDsI7ChbDFN 7JWuRL5c0E6XuPcTwAdwG+ps9jP02JLc7eO/dn8nKZYqEcCDKJFzNdL0kQif7JddiVd+Y=
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

The EFI spec v2.10 introduces a global flag in the memory attributes
table that indicates whether the EFI runtime code regions were emitted
with BTI landing pads, and can therefore tolerate being mapped with BTI
enforcement enabled.

Add the generic plumbing for this, and wire it up for arm64.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Mark Rutland <mark.rutland@arm.com>

Ard Biesheuvel (2):
  efi: Discover BTI support in runtime services regions
  efi: arm64: Wire up BTI annotation in memory attributes table

 arch/arm/include/asm/efi.h     |  2 +-
 arch/arm/kernel/efi.c          |  5 +++--
 arch/arm64/include/asm/efi.h   |  3 ++-
 arch/arm64/kernel/efi.c        | 18 +++++++++++++++---
 arch/riscv/include/asm/efi.h   |  2 +-
 arch/riscv/kernel/efi.c        |  3 ++-
 arch/x86/platform/efi/efi_64.c |  3 ++-
 drivers/firmware/efi/memattr.c |  9 +++++++--
 include/linux/efi.h            |  8 ++++++--
 9 files changed, 39 insertions(+), 14 deletions(-)

-- 
2.39.0

