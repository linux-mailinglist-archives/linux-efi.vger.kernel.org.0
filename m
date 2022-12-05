Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D626A64355D
	for <lists+linux-efi@lfdr.de>; Mon,  5 Dec 2022 21:12:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232690AbiLEUMX (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 5 Dec 2022 15:12:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232724AbiLEUMW (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 5 Dec 2022 15:12:22 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 939962648D
        for <linux-efi@vger.kernel.org>; Mon,  5 Dec 2022 12:12:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 49A6DB81212
        for <linux-efi@vger.kernel.org>; Mon,  5 Dec 2022 20:12:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52DCEC433D6;
        Mon,  5 Dec 2022 20:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670271139;
        bh=nXlidHvAKRSH+hnyeVxJwIn22hAVhBTWUOE+g1ZVpSY=;
        h=From:To:Cc:Subject:Date:From;
        b=jap6pZNRebQfrztQOJS2DNOvrVlNMvP9OaJlmusBnYO8OaSwcnPz2fR5rUk63jAhY
         0jH7JFOjzXohl8l0NhazTR/ih1NSaJa5XJybFPQD8b9k7Op2bTpVGbMkD1UZdcYL0A
         IlN8JGLn/B2qIrl7r9gZSi9gXLjaMe0XSTz9PwRLqC4OVDVzKdV1qxjDugbHpsE0X3
         as/qPB3pFXeHOSI3L/clxasEqylHXbXGKKmDRsYsg9ulcdT7bDWJmgX16YGIXyX8Sy
         YHeNmVPw95qWc9gkLVDt3Assox2qJYX+hVh2Vsny0JyATxSx8MHnK2UV5gOfMS3vPh
         umYUKCgModCNA==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, will@kernel.org,
        catalin.marinas@arm.com, mark.rutland@arm.com,
        Ard Biesheuvel <ardb@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH 0/2] arm64: efi: Robustify EFI runtime wrapper code
Date:   Mon,  5 Dec 2022 21:12:08 +0100
Message-Id: <20221205201210.463781-1-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1079; i=ardb@kernel.org; h=from:subject; bh=nXlidHvAKRSH+hnyeVxJwIn22hAVhBTWUOE+g1ZVpSY=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBjjlCWKpikSzgv/OddSsuJEDlsH8hNbkBHq/isH3Li MRmQ2FCJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCY45QlgAKCRDDTyI5ktmPJIEDC/ wJ6z/eFUTShuOKC8NskBZqpqLqgIawl+bLOluLP/Dgr2j2zJ7S91fWsc6SnDUnVUpGCy37HwPF0dHt T7oCQbWj6cYOVYyvFxnQsdD8s71XWzIK2l8sxeFoSmx8suCcOa/8XyG/cpVHwg18Tp0eOZWb8Uww8v Q1WWNzc/uhcZLy6ilEtfUJzka/fNg07tgmFg1lguqgSr01C8zGHuaR0HOlwODSXd/wXTi/KpyMD7El /s3ZTXvuMlPsvR3mf88h7Lr/XD/o6V0YMWvwxNFxcXdC1lqvAgU4PTsUUX9vm+Od8v5jqJYpFPJlxk dqKvX7vrzIarwjZyV1zc/s0da7qHTCIjqlTR2wsDaonMzaPnwcc4+g6agPl2QK1iYo7OcUTHdYRU4R SJOFbeax8XJZ9bfYBI5Qz1dSOuac6YcvUHVwrMzUIcebSp7Hk+ccBMKu9BEnbyDqilaiumXaBlxXYG BtAQbmPcgxmEx6G9MqR7NRpxo0kN1d4j3q0OSsIiOjsW8=
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

Make the EFI runtime wrapper code more robust, by switching to a
dedicated stack and dealing with sync exceptions occurring in firmware
by unwinding it. While at it, move the backup copy of register X18 onto
the base of that stack too so we can can restore it if needed without
reloading it from the ordinary stack.

Patch #2 is a v2 of a patch that got merged and reverted again in
v6.1-rc.

This supersedes 'arm64: efi: Move runtime services asm wrapper out of
.text'

Cc: Sami Tolvanen <samitolvanen@google.com>
Cc: Kees Cook <keescook@chromium.org>

Ard Biesheuvel (2):
  arm64: efi: Execute runtime services from a dedicated stack
  arm64: efi: Recover from synchronous exceptions occurring in firmware

 arch/arm64/include/asm/efi.h            | 11 +++++
 arch/arm64/kernel/efi-rt-wrapper.S      | 38 ++++++++++++++--
 arch/arm64/kernel/efi.c                 | 47 ++++++++++++++++++++
 arch/arm64/mm/fault.c                   |  4 ++
 drivers/firmware/efi/runtime-wrappers.c |  1 +
 5 files changed, 98 insertions(+), 3 deletions(-)

-- 
2.35.1

