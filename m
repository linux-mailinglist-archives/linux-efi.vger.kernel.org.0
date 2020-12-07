Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 915192D181D
	for <lists+linux-efi@lfdr.de>; Mon,  7 Dec 2020 19:06:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726247AbgLGSDF (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 7 Dec 2020 13:03:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:52666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726243AbgLGSDF (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 7 Dec 2020 13:03:05 -0500
From:   Ard Biesheuvel <ardb@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     linux-efi@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Ard Biesheuvel <ardb@kernel.org>,
        Samer El-Haj-Mahmoud <Samer.El-Haj-Mahmoud@arm.com>
Subject: [PATCH 0/2] efi capsule loader fixes
Date:   Mon,  7 Dec 2020 19:02:14 +0100
Message-Id: <20201207180216.3349-1-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

A couple of fixes for the EFI capsule loader. Patch #1 switches from
kmap() to kmap_atomic(). Patch #2 adds cache maintenance of the scatter
gather list entries passed to UpdateCapsule.

Cc: Samer El-Haj-Mahmoud <Samer.El-Haj-Mahmoud@arm.com>

Ard Biesheuvel (2):
  efi: capsule: use atomic kmap for transient sglist mappings
  efi: capsule: clean scatter-gather entries from the D-cache

 arch/arm/include/asm/efi.h     |  5 +++++
 arch/arm64/include/asm/efi.h   |  5 +++++
 drivers/firmware/efi/capsule.c | 16 ++++++++++++++--
 3 files changed, 24 insertions(+), 2 deletions(-)

-- 
2.17.1

