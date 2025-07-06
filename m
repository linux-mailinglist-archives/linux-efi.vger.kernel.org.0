Return-Path: <linux-efi+bounces-4135-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88AA7AFA436
	for <lists+linux-efi@lfdr.de>; Sun,  6 Jul 2025 11:59:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3F2517D48C
	for <lists+linux-efi@lfdr.de>; Sun,  6 Jul 2025 09:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9B0D203706;
	Sun,  6 Jul 2025 09:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e8U0g3o1"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39652202C48;
	Sun,  6 Jul 2025 09:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751795914; cv=none; b=flWxixEflEwrs42P/Kt/kAtpT9UlWH0T2lKfvh/P2wCFQFilg5ErxIDteCPT3bmVQQH/n/EWx8oeGAjoLfyhmNshPL8HgRKXOG1fb7TQV0FN/nor2ycqxgUtJOGTB4r935pYUtGfCzzg8+T7uHqdGzqm7L+QG1iSxhHoTUgW5QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751795914; c=relaxed/simple;
	bh=1diWdmZBf2S4Y5qISywodxu19nf7hNxT4rMUHChpw9U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TkCrhCutc9LJp1pbtsRSFbZcHCzX9TZjm0Ivvij41ipveU5qSn/MjulMSr2LQTiTaxnYzOqE5LRfAUOclCJAnGV9RMTZw1KrCIVUjDkDK5jTq9DQX35QneYTyKySGEn/8eYVKAZtRDBYVlFrMzf/zW5ISZ0+5dzem+Zud3M41qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e8U0g3o1; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4530921461aso14439905e9.0;
        Sun, 06 Jul 2025 02:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751795911; x=1752400711; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=i6xlWZG3q339ZhjZezaZxN0+SbBnE2IfVSlIzuvRhdw=;
        b=e8U0g3o1Zxu+F+xoIYVW0YKM6gjTVxeGqgJEJ7D0C4+3Qti72cE0VnHVm9TSrvGo3E
         /AmQ0Cei3Mp7rXagfkR2QrkPhm07dD3YWPzt2bcVfE0XVw8QBltMdsBVrxHlrq9ZwZng
         kEQHmvj+9rhgqF8zoNZQpRnGGOzKChSjtSkCDn+ja6y33DY+hzjFqQs2DMHI6p/e1IDP
         bLoYilsqy3NbswI5m0exUqlgmuIkMceDSV2NLDSa9xn8OKPcLgYxFyn1mI6jdNZLNvg2
         LFry/1n/iECmRVPiGdFPtN4oXbzqynPNdCeIDK7h0zF5A1RNEO/wgE7sfiQ5droHIPX+
         jCOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751795911; x=1752400711;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i6xlWZG3q339ZhjZezaZxN0+SbBnE2IfVSlIzuvRhdw=;
        b=InvjHx1dNo9fNkEkqWerWNi/llSZ0SUeDiqdCQtl8eUAzrSalbgyIXwkLnDGQXPIh+
         nIAlWt92kt4j4UrYOx4MFHcskeL7B+ORqI/9s/vzj89wWOIfQMcNvk8m75RDmlkv9ZlE
         +JG1RRZ6YnTtkBPT4JbvPp5NwHRfx6AlvG4tUfh3qxXZ6tSb9kqE45TWDXik3AezlKqF
         alnTIA+cumAeKoAntNJioJZ8qSTtQNfp6dBWbdStiEXF998+vOLFc7BhP6mlKzv517V6
         T//W1zFCYAkGmMsRnoTY2Gj5oxmLb2xkYSRswgBz3y5Rj1Qf23vq8XpIF0mQahwXG49Y
         NKFg==
X-Forwarded-Encrypted: i=1; AJvYcCURbe4hjdJFcF6zPdE37RsddvMVXWFk7XrkeBOgHLyiKJEhb6RoxtpQXvvKk8w4NnshkDBkCwHI3vk=@vger.kernel.org, AJvYcCV4wIeHXjuUKBhAuDBNXUMLZL8DrCCXYs41Pg10t/gTCIKyvXuFFUN9UoFb0C7HwdgF1RJeuIzngs2v+Nxs@vger.kernel.org
X-Gm-Message-State: AOJu0YxfDlxzq+yH0w6AraCl3UkmSf8hIrqfatsaG7S1CWHdzDyXQIzl
	9qQOuI5qCpOuGtwCZYT2pLwSVfV6EsQhlYvV7YZUR+1rpVFyeP8OGEVXB8yB8eKOkmI=
X-Gm-Gg: ASbGncvx0XUKULoyLo7YDf9XiSEcleQB0ElPY3n17e7ks4MUxZSGf8v+NSgib9fK/Tc
	1iweoJ2kUXODZaKB1AhBvHmmeaSq4DowEullQ40ZsFU8fOiwxm0Cp144OEaqyG/X4Hw+g1z5thy
	Ju4rSyGJL2eLTgx8hyoJb3KsP6Gw1ibfYUOExNf8EEkpvaGfyOQnlN2cn8JaJvjxPgeNS0Xy9RP
	3RrQXLMu7wfi6FKz54fTnXeDNgnK5+X2dzdQX6bBaYoHwDKVBK3bke4mDI6o/iZKrDxhSgjjIic
	n/2mtwXPDksRHvge9CTW4LRLytrLQX1DVJXt4WCl3dBRwMEipVWWHrv1hHLvCV5R8WM49XJ0wmu
	0yTnUUUB+IoPA
X-Google-Smtp-Source: AGHT+IHZdVWOTtzoX+RsBOk9tza7IjFpr/bV5xAEd4ydpEvwXI75CZ/v/no7rHxxswCEr+A3+AJ6XQ==
X-Received: by 2002:a05:600c:a06:b0:450:cac5:45e7 with SMTP id 5b1f17b1804b1-454bb7e777emr38245405e9.1.1751795911027;
        Sun, 06 Jul 2025 02:58:31 -0700 (PDT)
Received: from localhost.localdomain ([41.79.198.24])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454a9969a8bsm107598805e9.2.2025.07.06.02.58.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Jul 2025 02:58:30 -0700 (PDT)
From: Khalid Ali <khaliidcaliy@gmail.com>
X-Google-Original-From: Khalid Ali <khaliidcaliy@gmail.com
To: ardb@kernel.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr
Cc: gargaditya08@live.com,
	jonathan@marek.ca,
	kees@kernel.org,
	linux-efi@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	lukas@wunner.de,
	linux-kernel@vger.kernel.org,
	Khalid Ali <khaliidcaliy@gmail.com>
Subject: [PATCH v2 1/2] efi/libstub: Print error message if efi_allocate_bootparams() fails
Date: Sun,  6 Jul 2025 09:57:00 +0000
Message-ID: <20250706095705.1386-1-khaliidcaliy@gmail.com>
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
general error message in "fail" label to get printed.

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


