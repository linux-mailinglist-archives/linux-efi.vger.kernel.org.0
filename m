Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 588303BA440
	for <lists+linux-efi@lfdr.de>; Fri,  2 Jul 2021 21:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbhGBTNZ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 2 Jul 2021 15:13:25 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:56404 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230207AbhGBTNZ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 2 Jul 2021 15:13:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1625253052; x=1656789052;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+18ySfuvDzgsI0DOUgOGRN7v2OJzsUrRqSmjwnWVG3E=;
  b=fffeWqEw+MJhQYpowyo+DxpdqDz5Rix4CVBQa2TifuBFkBze1wcDI2WX
   D6C32/TdaKjJ7feNo1F1xxcslgkH/9NHC+fGF55mjiwQ5FH9cI9xp7cnR
   tFw87dBpxZq5ZYK+TvozHn/zETEGwE51eBdcT7L4E93w+5Bkd0bYs1S/k
   LTT339iocNnPF9OSgTpeiXwYjviiZte9M0YlCroKvFrn/4JVjZ//BDHM6
   oi6wSlWhB9gcmVZbmdhHZsETwRpWqCuT4sGbZ96n2bMnb4Nax7Uzc62EH
   5EvHmcCBVhr7+qK8vcGOU4d1AHO9MdfWCIoPTbWEmc5fk2zDQv0ZUPA9D
   w==;
IronPort-SDR: BHFMs0HIqlmHYcUks1tkcdcZk1G9YPpsYWy3MPg2EAPP+B7jfWg6aG6HbrEAk010rTIMjnzMtn
 TZVSNn3IoHM84Iz1xZtGddJTHiC+9YuuybVki1fep9vnsog72ynNiapJdOCfdOtRrHPyAXrs6f
 7iRWrxGxKLnbSsQkJk0ciUa/bKoh+zXmrXcsJSbYri7Jy8UhbcWNEtrViOBj6+JVXa0tsOfc1J
 YXllmEL74hlgJL1E4km1/JNJ8NnH7abf93tqRBo+ghf3KQkPP/pVM39Z85AoOxNRnQixjCSLay
 IoM=
X-IronPort-AV: E=Sophos;i="5.83,319,1616428800"; 
   d="scan'208";a="172836536"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 03 Jul 2021 03:10:51 +0800
IronPort-SDR: fVNB+frFIG2GCHnNp8G4x15voFPIXgLr5UqMiWhrCYOV8jQneNv+PZVB9kdsJf/AzofLTD0iq2
 +FFLooFL/F5CO9u5wiueXP8eELqwEiRzxuLxIe3j51CUH3IbWRFbJIcc7UlkeWCFT/6gCh3HFV
 EMuaY4dv72Tkl0YGpyWItWEmItprSbTSCK0L6o8AazkjD2rWK/YU7+kOW9C6FFMWaYLtoMjoX9
 i1vyspXeUjbXNYOVxLvCBBb3bLu6nXJJV4wDjuNuV+Q3DEJGF5CHKepiuE+Vyd/BP4mt6QrJ6V
 +LThrHzf78VAzL1MfWvITqEX
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2021 11:49:14 -0700
IronPort-SDR: oXuZK9tWZsPf5TjfLrrXIhWyvdxRPucqcBMokTg6tZ9oo/UDUyB7Ax/Vu939mSQNokO4vGFF4N
 6z+F5Cxad4kR1rMfpxBh0edrVre3xE7U5caqt1QU+heOQgo8sFKllfAlhu9K2LxqreZfVxiHuW
 77Ki++IIVI7XOXKvHQW4UTtT0HzcUWxhf6h6cqsruxqunqw7SkYICOyjv9RJ3iGVCrHEKGrgJK
 cI4f+wpez0M9lEg9HL2/rie7PyslYDY4u3I+PM20B/bfPKJKtDftStD0LIXFVEXa6QMOOp/lix
 Udw=
WDCIronportException: Internal
Received: from unknown (HELO fedora.wdc.com) ([10.225.163.29])
  by uls-op-cesaip02.wdc.com with ESMTP; 02 Jul 2021 12:10:49 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        linux-efi@vger.kernel.org, Will Deacon <will@kernel.org>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH] efi/libstub: Fix the efi_load_initrd function description
Date:   Fri,  2 Jul 2021 12:10:44 -0700
Message-Id: <20210702191044.988401-1-atish.patra@wdc.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The soft_limit and hard_limit in the function efi_load_initrd describes
the preferred and max address of initrd loading location respectively.
However, the description wrongly describes it as the size of the
allocated memory.

Fix the function description.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
---
 drivers/firmware/efi/libstub/efi-stub-helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
index aa8da0a49829..ae87dded989d 100644
--- a/drivers/firmware/efi/libstub/efi-stub-helper.c
+++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
@@ -630,8 +630,8 @@ efi_status_t efi_load_initrd_cmdline(efi_loaded_image_t *image,
  * @image:	EFI loaded image protocol
  * @load_addr:	pointer to loaded initrd
  * @load_size:	size of loaded initrd
- * @soft_limit:	preferred size of allocated memory for loading the initrd
- * @hard_limit:	minimum size of allocated memory
+ * @soft_limit:	preferred address for loading the initrd
+ * @hard_limit:	upper limit address for loading the initrd
  *
  * Return:	status code
  */
-- 
2.31.1

