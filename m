Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D674A263460
	for <lists+linux-efi@lfdr.de>; Wed,  9 Sep 2020 19:19:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728971AbgIIRTu (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 9 Sep 2020 13:19:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:54046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730116AbgIIP1W (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 9 Sep 2020 11:27:22 -0400
Received: from e123331-lin.nice.arm.com (adsl-204.109.242.29.tellas.gr [109.242.29.204])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 712642226A;
        Wed,  9 Sep 2020 15:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599664608;
        bh=j8vJl1ywEzmd2fl0OyqRb55B0LHSNpXDxq3MpWw+2Ro=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MfswMFxxpoeNhNBwXRQ8HeNN5wAhq9WMSYVNE1w01BAqMGZJOxQXT3Z5uSPJUFsfv
         tVrQfGXs6rzn4Iq4Y8o/ZkbKuDlnwubTQ3cnLJ/gHa/qRqNHuVSzttxsqFQtMldB7o
         bJBfKnvhoQeDemks+OrCl9pBuUF9FG6cnWMFqz34=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Ard Biesheuvel <ardb@kernel.org>,
        Maxim Uvarov <maxim.uvarov@linaro.org>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Atish Patra <atish.patra@wdc.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Francois Ozog <francois.ozog@linaro.org>,
        Etienne CARRIERE <etienne.carriere@st.com>,
        Takahiro Akashi <takahiro.akashi@linaro.org>,
        Patrice CHOTARD <patrice.chotard@st.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        Grant Likely <Grant.Likely@arm.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Christophe Priouzeau <christophe.priouzeau@linaro.org>,
        Rouven Czerwinski <r.czerwinski@pengutronix.de>,
        Patrick DELAUNAY <patrick.delaunay@st.com>
Subject: [PATCH RFC/RFT 1/3] efi/libstub: Export efi_low_alloc_above() to other units
Date:   Wed,  9 Sep 2020 18:16:21 +0300
Message-Id: <20200909151623.16153-2-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200909151623.16153-1-ardb@kernel.org>
References: <20200909151623.16153-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Permit arm32-stub.c to access efi_low_alloc_above() in a subsequent
patch by giving it external linkage and declaring it in efistub.h.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/efistub.h  | 3 +++
 drivers/firmware/efi/libstub/relocate.c | 4 ++--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index 85050f5a1b28..158f86f1f9fc 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -740,6 +740,9 @@ efi_status_t efi_allocate_pages(unsigned long size, unsigned long *addr,
 efi_status_t efi_allocate_pages_aligned(unsigned long size, unsigned long *addr,
 					unsigned long max, unsigned long align);
 
+efi_status_t efi_low_alloc_above(unsigned long size, unsigned long align,
+				 unsigned long *addr, unsigned long min);
+
 efi_status_t efi_relocate_kernel(unsigned long *image_addr,
 				 unsigned long image_size,
 				 unsigned long alloc_size,
diff --git a/drivers/firmware/efi/libstub/relocate.c b/drivers/firmware/efi/libstub/relocate.c
index 9b1aaf8b123f..8ee9eb2b9039 100644
--- a/drivers/firmware/efi/libstub/relocate.c
+++ b/drivers/firmware/efi/libstub/relocate.c
@@ -20,8 +20,8 @@
  *
  * Return:	status code
  */
-static efi_status_t efi_low_alloc_above(unsigned long size, unsigned long align,
-					unsigned long *addr, unsigned long min)
+efi_status_t efi_low_alloc_above(unsigned long size, unsigned long align,
+				 unsigned long *addr, unsigned long min)
 {
 	unsigned long map_size, desc_size, buff_size;
 	efi_memory_desc_t *map;
-- 
2.17.1

