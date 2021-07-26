Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C52C3D5717
	for <lists+linux-efi@lfdr.de>; Mon, 26 Jul 2021 12:09:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232792AbhGZJ3D (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 26 Jul 2021 05:29:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:57988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232156AbhGZJ3C (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 26 Jul 2021 05:29:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9591660C41;
        Mon, 26 Jul 2021 10:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627294171;
        bh=rpkzxWGwcsoVhXPiuidhFC1go/zVDd33ERQnYqRCb+c=;
        h=From:To:Cc:Subject:Date:From;
        b=hw5txQHBSW9x801jUF91Wvr7QVvzSBIERjs+Wvm7iA5+myq/iHwD+OYUArjWAkgfj
         h+0nnXi6zu/0zmGpJBc1P5AoTs+NdKQ3KnIqEYY75CvQIucfg5DRon4he2R/9NZJPG
         JsdSgyXp4XghLEKfhI6w/qoRwEg86J+Fp48rELpjwMuj5ON8Q+RJbJy58Y6EOIdr/8
         rrmj/+igbeA0KyvfTIeO4e8loaeGd8AKhdqz0SNuuf4t4oLMpLc3X3aEtYnrAHIE4L
         63RqSLxe9QWQoIj/f6fDorJzbpJZQYC6xjFSm9z5DjLNrVbmMhJ0rEGpb1O8BRtJvU
         f2oO49fTH84Hw==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Ard Biesheuvel <ardb@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH v2 0/2] efi/arm64: work around Image placement issues
Date:   Mon, 26 Jul 2021 12:09:20 +0200
Message-Id: <20210726100922.120029-1-ardb@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Ben reported that distro GRUB may fail to boot in some circumstances,
and tracked it down to an issue in the way distro GRUB allocates space
for the image. Due to an oversight (addressed in patch #2), this
condition is rarely triggered, but let's work around it in any case (#1)

Build tested only.

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Ard Biesheuvel (2):
  efi/libstub: arm64: Force Image reallocation if BSS was not reserved
  efistub: arm64: relax 2M alignment again for relocatable kernels

 drivers/firmware/efi/libstub/arm64-stub.c | 65 +++++++++++++++++---
 1 file changed, 55 insertions(+), 10 deletions(-)

-- 
2.20.1

