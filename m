Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C17FC1F0B8D
	for <lists+linux-efi@lfdr.de>; Sun,  7 Jun 2020 15:58:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726590AbgFGN6q (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 7 Jun 2020 09:58:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:51874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726522AbgFGN6q (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sun, 7 Jun 2020 09:58:46 -0400
Received: from dogfood.home (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EDB3720663;
        Sun,  7 Jun 2020 13:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591538326;
        bh=kQo6hsNrluWIYjLBJA/GB7FOOAsY0HPaIOIhhqRewug=;
        h=From:To:Cc:Subject:Date:From;
        b=gcNyI7E60YmnU4u+cUGSDPlSjJYoQGq6+fsDZXc/TuMpkyae+98+i1MONNVIE7l+y
         zQuu/u9481F8XdgojaYSugyK6/2szPa4Mea9fNiSzUeqziHzYpq/Z47ElBQNyjfO6x
         s5oBoPXc/8zlAIEa+CQLi3U0L+UNjSaCvXehnA2A=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, maz@kernel.org,
        linux@armlinux.org.uk, xypron.glpk@gmx.de,
        Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH v2 0/2] efi/arm: deal with HYP mode boot
Date:   Sun,  7 Jun 2020 15:58:32 +0200
Message-Id: <20200607135834.898294-1-ardb@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Some changes to make booting in HYP mode via EFI more robust.

Changes since v2:
- Use the correct register for testing/disabling the HYP MMU
- Don't pretend we're in SVC mode for the HYP+caches case, but set up a HYP
  exception handler for HVC instructions issued from HYP mode*** BLURB HERE ***

Ard Biesheuvel (2):
  efi/arm: decompressor: deal with HYP mode boot gracefully
  efi/arm: libstub: print boot mode and MMU state at boot

 arch/arm/boot/compressed/head.S           | 61 ++++++++++++++++++++
 drivers/firmware/efi/libstub/arm32-stub.c | 11 ++++
 2 files changed, 72 insertions(+)

-- 
2.26.2

