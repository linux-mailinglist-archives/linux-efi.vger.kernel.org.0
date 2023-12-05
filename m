Return-Path: <linux-efi+bounces-115-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59D3D8049AF
	for <lists+linux-efi@lfdr.de>; Tue,  5 Dec 2023 07:04:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31153281574
	for <lists+linux-efi@lfdr.de>; Tue,  5 Dec 2023 06:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86FAFDDA1;
	Tue,  5 Dec 2023 06:04:40 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03040C3
	for <linux-efi@vger.kernel.org>; Mon,  4 Dec 2023 22:04:36 -0800 (PST)
X-QQ-mid: bizesmtp80t1701756249tk40rfpc
Received: from localhost.localdomain ( [222.92.8.138])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 05 Dec 2023 14:04:08 +0800 (CST)
X-QQ-SSF: 01400000000000F0W000000A0000000
X-QQ-FEAT: TVZM0Uoyj02Jtpt3OrhyruiQYo8m/4BZ+fWxZOa46FVml++gP8ceQQ0X9mRXy
	qGmd7eG0AJC8PxMS8BzzwU5HeWHG2tc0Pc7R6Cho7j/xnN2/POaF1/KBH/MeUQizLGIu4Qv
	J0JQNeLcusNn+wBmvpRnVK3zhh+owvLqlyyD6PFOi4GK8XkUOe/MQeOUppex5DYorgTM3cO
	7gDSh59IkZEY5AVz9GrHjaZ4xLTC8lfMncLPhu5nmK0m9JfHLWhN8ozNVPEWUNiCxMvzbjD
	Bl6QheujRUYYoAiT4GNk/bIzAPEl/kpcaDmQf67Q2dyV+TO06DNKsg2iywwHOzNk7V0ibtG
	xndBrXwb+a2D8MVdgyj+UxQ2/Mg1980eCkxPrtxP64y4SnZVt3Hntpm8ulhJa9ceOWISQxY
	J4ojPU8Fvbca8pw5J1O6yQ==
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 4996889953417864215
From: wangyao@lemote.com
To: ardb@kernel.org,
	chenhuacai@kernel.org,
	wangrui@loongson.cn
Cc: linux-efi@vger.kernel.org,
	ainux.wang@gmail.com,
	Wang Yao <wangyao@lemote.com>
Subject: [PATCH v3 2/2] efi/loongarch: load address is not equal to link address
Date: Tue,  5 Dec 2023 14:03:45 +0800
Message-Id: <20231205060345.7742-3-wangyao@lemote.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20231205060345.7742-1-wangyao@lemote.com>
References: <20231205060345.7742-1-wangyao@lemote.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:lemote.com:qybglogicsvrgz:qybglogicsvrgz5a-2

From: Wang Yao <wangyao@lemote.com>

This is a test patch for PIE kernel that load address is not equal to
link address.

Signed-off-by: Wang Yao <wangyao@lemote.com>
---
 drivers/firmware/efi/libstub/loongarch-stub.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/libstub/loongarch-stub.c b/drivers/firmware/efi/libstub/loongarch-stub.c
index d6ec5d4b8dbe..c13c022d18cf 100644
--- a/drivers/firmware/efi/libstub/loongarch-stub.c
+++ b/drivers/firmware/efi/libstub/loongarch-stub.c
@@ -22,12 +22,22 @@ efi_status_t handle_kernel_image(unsigned long *image_addr,
 				 efi_handle_t image_handle)
 {
 	efi_status_t status;
-	unsigned long kernel_addr = 0;
+	unsigned long kernel_addr = 0, tmp_addr = 0;
 
 	kernel_addr = (unsigned long)&kernel_offset - kernel_offset;
 
+	/*
+	 * Allocate 2M space at 0x200000(EFI_KIMG_PREFERRED_ADDRESS) for
+	 * test, this will lead to the kernel be loaded at 0x4000000.
+	 */
+	status = efi_relocate_kernel(&tmp_addr, 0x100000, 0x200000,
+		     EFI_KIMG_PREFERRED_ADDRESS, efi_get_kimg_min_align(), 0x0);
+	efi_info("@@@[%s] tmp_addr: 0x%lx\n", __func__, tmp_addr);
+
+	/* kernel_addr == 0x400000 */
 	status = efi_relocate_kernel(&kernel_addr, kernel_fsize, kernel_asize,
 		     EFI_KIMG_PREFERRED_ADDRESS, efi_get_kimg_min_align(), 0x0);
+	efi_info("@@@[%s] kernel_addr: 0x%lx\n", __func__, kernel_addr);
 
 	*image_addr = kernel_addr;
 	*image_size = kernel_asize;
-- 
2.27.0


