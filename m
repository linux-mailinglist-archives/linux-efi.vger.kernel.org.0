Return-Path: <linux-efi+bounces-1441-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7980933787
	for <lists+linux-efi@lfdr.de>; Wed, 17 Jul 2024 09:02:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 908AA1F23407
	for <lists+linux-efi@lfdr.de>; Wed, 17 Jul 2024 07:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 397B1156E4;
	Wed, 17 Jul 2024 07:02:00 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2323B14267;
	Wed, 17 Jul 2024 07:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.194.254.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721199720; cv=none; b=PERVbLUzBqibs6kuA+ahzl0E/F3ecX+y82U1EV4AYqhKgnw1kqPrG8qFFkhDzVgAPdHMmZdWKBRn239znFEJNAE/6z5fOUscMqNtR+blCbD6W/xB0B96Ncptu3nrOz90b8j8Ims82pA2Fflqd2MqtIawEKvsdqklVTaJJ1jUmmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721199720; c=relaxed/simple;
	bh=COMSs26WDHH3W3GaXqX91BUWJqXnP5pjm/PKUPTyTbw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XdU5YQ2XO4Bs5vPzcllkx8ZqkSE/KYWqt/Is+KHamzXxHyDIl9KRahC/e4YUGrO7uLqs5Qsf5WMnns9COFRIarBtjB/HfT/EbhHtQN8t/E0CA11L/as9Stpg3x0FwBQsHiANte38679KzMhIgNIQay+yrmV61uQ5IMwWesihf6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; arc=none smtp.client-ip=18.194.254.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
X-QQ-mid: bizesmtp85t1721199693t7a3oh7i
X-QQ-Originating-IP: A9FY9NoLCG30nA+8sH8dgrm9bjJyZ7YWSFv3sJxaXfc=
Received: from localhost.localdomain ( [123.114.60.34])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 17 Jul 2024 15:01:31 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 64416234002545300
From: Qiang Ma <maqianga@uniontech.com>
To: ardb@kernel.org
Cc: linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Qiang Ma <maqianga@uniontech.com>
Subject: [PATCH] efi/libstub: Fixed an issue with screen_info not being initialized
Date: Wed, 17 Jul 2024 15:00:43 +0800
Message-Id: <20240717070043.5537-1-maqianga@uniontech.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybglogicsvrsz:qybglogicsvrsz4a-0

After calling uefi interface allocate_pool to apply for memory, we
should clear 0 to prevent the possibility of using random values.

Signed-off-by: Qiang Ma <maqianga@uniontech.com>
---
 drivers/firmware/efi/libstub/screen_info.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/firmware/efi/libstub/screen_info.c b/drivers/firmware/efi/libstub/screen_info.c
index a51ec201ca3c..5d3a1e32d177 100644
--- a/drivers/firmware/efi/libstub/screen_info.c
+++ b/drivers/firmware/efi/libstub/screen_info.c
@@ -32,6 +32,8 @@ struct screen_info *__alloc_screen_info(void)
 	if (status != EFI_SUCCESS)
 		return NULL;
 
+	memset(si, 0, sizeof(*si));
+
 	status = efi_bs_call(install_configuration_table,
 			     &screen_info_guid, si);
 	if (status == EFI_SUCCESS)
-- 
2.20.1


