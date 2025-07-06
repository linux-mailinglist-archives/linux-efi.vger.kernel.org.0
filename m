Return-Path: <linux-efi+bounces-4141-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B04DAFA6A4
	for <lists+linux-efi@lfdr.de>; Sun,  6 Jul 2025 19:00:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 964D1178C08
	for <lists+linux-efi@lfdr.de>; Sun,  6 Jul 2025 17:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 026781714B7;
	Sun,  6 Jul 2025 17:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a4iqBf+D"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4945D3C2F;
	Sun,  6 Jul 2025 17:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751821253; cv=none; b=Sht1lCA3J27s495PQ36pv6rUM2APGDkdjcBgpzbDhnkmnI0Y27vYIbdAbKImfObYAS4hz86IfEXMcOH/wrVGeFh+bJ4r08MVjeONqSpugSArgwQ8FnfAsOZVwGMrVFYL60dHfqXJ68zfAEKuIUJKMRr1bkua+rnFQjuH0lZlEjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751821253; c=relaxed/simple;
	bh=FuTGRgSAWVVOTPTM4iY3nLVMHbEOiMxhp6w/u1qIitA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fbFjqY4kgo9nPpqPn6/kKDzGcC5If4j2Y/l5pJStD/WJMD5zWA1hE7SifHh+D1esx3RsXzU7nhYRBtfdO08uTcf8y+88luQ3NYoLbRZCsHA+oMKh971ood3cmUoLnB8MEIXwkMJhOWEBdSVcJ6oHp4xCHFELoEL3NRjW5j9zd8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a4iqBf+D; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-451d3f72391so23938275e9.3;
        Sun, 06 Jul 2025 10:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751821250; x=1752426050; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oqPmHRXTvUmmlCHl2ubMMo6baAfA2qIsMqJbDb231OA=;
        b=a4iqBf+DDnApjpbSahHDxiSNAF6H+xnViMV2b+Rwc2ll+zewJLwwhQPDaTLbSHn0zG
         XBSaVchSIqAwrSOH7rp7aQd28CqcrOrVCukFZsOx6qGHKX1BH2ycAGvlCjIEjjUYGhl6
         7os3pwdyN2Xg+lLA1lfaFbO32ySMqbeyC82Z3Hxvwpz+ZfIPc6Sn5HoWEc1KmNeeYD9d
         uZAgyGZNTpK4nCVF9wLpJCLp9IqQmSeblbt0vo1EQqA9gBy5ORzzZOojAFmu/jEGutc0
         FIuu8RY54OBYl73AyZyrTC5n1klmECvoYKZQoBfSILGqpdmpfVvbXnCK5TX2t+QforCb
         j/hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751821250; x=1752426050;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oqPmHRXTvUmmlCHl2ubMMo6baAfA2qIsMqJbDb231OA=;
        b=vBSQULtvcjBpw/mnIfYMPJuhcRnw2nbwK3+KtlUkeTjMlHTE1oe1mIHwpoXGmRJKRP
         +5A488MqwqgjWJ7A9F7M3xWCAJ7a9SciYmPkGc5bAOqfB7CAW2rKJ84EzrZoVFUWNP2w
         VDb5C4MoMOOoNEGyV6MhPH5rBmcgfZQX2KkNmN44jPwVOx+J8J35iA/EW+YsaWeJt0lt
         QARxSHfwAcZAsa2nvQm/LLaFwIjQ3DLKn+/LpLtv7oKOtfH07S8pU3KBjNnUYTfUth0U
         zvoYMA+A5oXZDrw3Mqcns46lqP90nPMWThgm4/79jAa24JPNFPQur0tmiIAJSMDeRF7J
         VWZg==
X-Forwarded-Encrypted: i=1; AJvYcCUAaKPVPrG+RwPd3yRUa7YigvrPzbIXPd0/t7ozndPyYpNSj5w4if36LF1kNQBJNbL4MaQPbdJ+YCw=@vger.kernel.org, AJvYcCWdu0Ndst1DBU1aPLQ6TFqnPir+NWdN+Ex4yc7IopLSEaJxbKbTZVZeyCse0XnrxjVcdDviTqGrBTbDpgse@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6Ht/t118sWTkrLOXu31PCMOQPGA8mOgD9pupH5lO+mXG1SoL+
	UslOk7UihWXOLsmK5Bg2n4w3im/2k73dnpGXV4ISmPZ52aml1BXskBBf
X-Gm-Gg: ASbGnctoIzhJpdh8JWMJIuUU+1HDxm0tCL/z8xGfYcW0lKmbS65KqY1KUqo96IFfRTm
	n8l9UYLJ1Wj0X63b+ez1x0j3+AO8ERzJxpHn1Rz0Wk7wbptcVPlnq/PQQz5UtxL/Nf4JpDf0ZUE
	qNI91jzlzvDOaWPur3d7fGL+IRDrxopEG5w03di4BOom98KWtNCLrGYo8fBRpJPGmWYBMi0PU1V
	Eh1E/e3PLo7joHWt7Miz7cxLsF9hbxW4q1ylWhjeB5HVgAHidcBn5UmnP569qmP7qcuDoWPU7ru
	6QydsMUpNGZCQMOTDnq/hDPwuyPavrgkEqONu7ufPNkRPHrpBOPtvGkhpLJEprmWqiHu/bbZesy
	T
X-Google-Smtp-Source: AGHT+IFYnNXzW8pZtpPwme80Li3YAU/twWpziA5QZ1BVLVPRP1HBYFVFDGHr7cRBiYWFM1wUal6TnA==
X-Received: by 2002:a05:6000:2502:b0:3a4:f744:e00e with SMTP id ffacd0b85a97d-3b4964f4e0dmr6671679f8f.4.1751821249997;
        Sun, 06 Jul 2025 10:00:49 -0700 (PDT)
Received: from localhost.localdomain ([41.79.198.24])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b47225a720sm7958695f8f.77.2025.07.06.10.00.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Jul 2025 10:00:49 -0700 (PDT)
From: Khalid Ali <khaliidcaliy@gmail.com>
X-Google-Original-From: Khalid Ali <khaliidcaliy@gmail.com
To: ardb@kernel.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu
Cc: alex@ghiti.fr,
	jonathan@marek.ca,
	chenhuacai@kernel.org,
	jiaxun.yang@flygoat.com,
	viro@zeniv.linux.org.uk,
	gourry@gourry.net,
	ilias.apalodimas@linaro.org,
	lukas@wunner.de,
	gargaditya08@live.com,
	kees@kernel.org,
	linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Khalid Ali <khaliidcaliy@gmail.com>
Subject: [PATCH v3 1/2] efi/libstub: Print error message if efi_allocate_bootparams() fails
Date: Sun,  6 Jul 2025 16:58:28 +0000
Message-ID: <20250706165850.1090-1-khaliidcaliy@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Khalid Ali <khaliidcaliy@gmail.com>

Print error message in case efi_allocate_bootparams() fails before exit.

Change the direct call of efi_exit() to "goto fail". This allows the
general error message in fail label to get printed.

Signed-off-by: Khalid Ali <khaliidcaliy@gmail.com>
---
 drivers/firmware/efi/libstub/x86-stub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index cafc90d4caaf..13d8eba06e4b 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -824,7 +824,7 @@ void __noreturn efi_stub_entry(efi_handle_t handle,
 	if (!IS_ENABLED(CONFIG_EFI_HANDOVER_PROTOCOL) || !boot_params) {
 		status = efi_allocate_bootparams(handle, &boot_params);
 		if (status != EFI_SUCCESS)
-			efi_exit(handle, status);
+			goto fail;
 	}
 
 	hdr = &boot_params->hdr;
-- 
2.49.0


