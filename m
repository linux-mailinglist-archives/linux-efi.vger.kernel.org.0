Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 428801734DA
	for <lists+linux-efi@lfdr.de>; Fri, 28 Feb 2020 11:02:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbgB1KCv (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 28 Feb 2020 05:02:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:33352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726440AbgB1KCv (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 28 Feb 2020 05:02:51 -0500
Received: from e123331-lin.home (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DD7E7246A2;
        Fri, 28 Feb 2020 10:02:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582884170;
        bh=zMhTh1fEfwgt/vck5y1Sbfo0lS1eqp78sZZjcrmBQBc=;
        h=From:To:Cc:Subject:Date:From;
        b=VoxtxAEETiZ3qKC3KRK9YciAvGy5yd4sKq+Ih2yD3xSjgRh6VSn6Yj6fOI0QMcvB1
         AUonoFMWIGFUDpbi8uopXiVskgpZ7Jl8461x0IOjQq13GYkEVLZSQfn+iv1YSzBIzo
         UHQ8E2AC7mbGDDFBxZz/Z346YP1EgcARHX0ajXDM=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH efi-next 0/3] efi: assorted fixes
Date:   Fri, 28 Feb 2020 11:02:41 +0100
Message-Id: <20200228100244.10979-1-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Some fixes for the code that is currentely queued up in efi/next for
v5.7

Patch #3 fixes a boot regression for non-EFI boot in linux-next, so
that will be sent onwards reasonably quickly.

Ard Biesheuvel (3):
  efi/arm: clean EFI stub exit code from cache instead of avoiding it
  efi/arm64: clean EFI stub exit code from cache instead of avoiding it
  efi: mark all EFI runtime services as unsupported on non-EFI boot

 arch/arm/boot/compressed/head.S | 18 ++++++++----------
 arch/arm64/kernel/efi-entry.S   | 18 +++++++++---------
 arch/arm64/kernel/image-vars.h  |  2 +-
 drivers/firmware/efi/efi.c      |  6 +++---
 4 files changed, 21 insertions(+), 23 deletions(-)

-- 
2.17.1

