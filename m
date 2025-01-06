Return-Path: <linux-efi+bounces-2510-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68880A03020
	for <lists+linux-efi@lfdr.de>; Mon,  6 Jan 2025 20:03:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B05B7A0FDE
	for <lists+linux-efi@lfdr.de>; Mon,  6 Jan 2025 19:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B06E31DF98D;
	Mon,  6 Jan 2025 19:03:07 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E765FFBF6;
	Mon,  6 Jan 2025 19:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736190187; cv=none; b=TmNuCzOi+Bath0PBRoPGTP9odDEggXGU2il2qg+esApT6dIFmxkVbGdTvMkmLbTSOHXv9IclWe88EqttvPQXrUOyGUQ+uDhwUcYMKQnl64U1qonvnksna+rHKg4xTfTexg7yvJ8HiIvwcudWBhJFDmevcgOU1Me+leGL+pIxhRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736190187; c=relaxed/simple;
	bh=SzCoB6sQHDFFteL8s7JGLImKCYtxlB9ZDym1wSLtA6k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LRsqC/EEMWigJd1Abtv54aI0qHrmt8HXCGuNcCy4ojIfEbxaisNDQ0wHFPQIq1S06CpcjiwSEtz8dNh0WD4UZV1VwsMvAer036/DxssHpFOn/E5xZUnMd/MKthWo4YMV8MGhXyGY4rPCJaVqad6w4kALzkCg2VeRvakTOcrQdlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-aa6c0d1833eso3059278766b.1;
        Mon, 06 Jan 2025 11:03:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736190184; x=1736794984;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qqx5dtb4zn1xEVEpLQTLVTCHxIWy4bTfVSfUtmGRb1A=;
        b=Q4RBQOWAAyxsNz20ruwmg1Fsw8f/+OEfQIONLP1ovsn36KLL3X6cCBucsem2O2jm0d
         4e/CQzo5g0YeEwPQ3WvO9NdDvo9Qj+W1OkQHwnKf0iK0NdJXZT44htpERVc0FrnEgPHl
         91VFMcBIyXd3dVyacCxyURsvz1XnRGYldu47xZnUHm+A3MXAxrD1xt+YnKspX+J5ZYE9
         cT80Tn5bO/VKxcs9zH7KtbpbTUyZYHyEyzICgmlQdX3IAVfI6+lzYPECQltEXhe6WKrf
         vyu0rCRnmPBHqhjsZDlgRl/K7XJTJejvJMawxIC5AWPfEnDJAOtPizCqoc8gMM3Sh2xd
         wL8Q==
X-Forwarded-Encrypted: i=1; AJvYcCUX2DdJyr82TciPBNGZzo9grXW7e6j8XRw7YO8z0g/DSO0EVfkacD5oi5RilZOB7g8T75O9CD6eCYuQqnk+@vger.kernel.org, AJvYcCWkgFnPDIPQvNnY24S6yjc9KEu2l0jFFr6ixad8NJxWVvAQic1UQ1Y1nu8Plw6XcCwMXgVy4cKPuVo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5IQuvvbmKWnlejDE89cwjHGd5SHrpbCsNOw5OwqZCGrzhmTkF
	KCo2oBHnfvvMoor8KzLd2v3zaNf/6Qh2ngR47IP43eVMEWVN9y0MqIeh/A==
X-Gm-Gg: ASbGnctVMEFCG8bglOXEfBdNCsFcs9wdrayaiQPtefLFJIfxtOHXPMpgJ20K2BKCLXA
	EHGF1nQqLfClZFuQgRDKHqP8SODp0jyAbGLitURE5ZcB384gJI4PmeSvhHUVnTMvORI0xi8Fldr
	53moTpZKDyO6hYc6hBxkFftOvNbCe5+ypMSX0oVe76RE9ZCuShQ8zfjcKAxA2FJs0xmyz+ysP82
	Vu0+SMcnLUeXa1LmDnmsyxsPBS447TG33Cc2YyvwakdvF4=
X-Google-Smtp-Source: AGHT+IFA2z6O7oK5pZ3aqxpwas8ITcxwjM2g2PfAQIKX/A4KeWSUnqS8BUUEw5gVXHwcQbbo+wwBSg==
X-Received: by 2002:a17:907:7dab:b0:aa6:98c9:aadc with SMTP id a640c23a62f3a-aac2d45fb01mr5408442766b.31.1736190183955;
        Mon, 06 Jan 2025 11:03:03 -0800 (PST)
Received: from localhost ([2a03:2880:30ff:9::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aac0e89490dsm2267389766b.45.2025.01.06.11.03.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2025 11:03:03 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Mon, 06 Jan 2025 11:02:51 -0800
Subject: [PATCH 2/3] efi/memattr: Add FW_BUG prefix to firmware error
 messages
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250106-efi_fw_bug-v1-2-01a8eb40bfeb@debian.org>
References: <20250106-efi_fw_bug-v1-0-01a8eb40bfeb@debian.org>
In-Reply-To: <20250106-efi_fw_bug-v1-0-01a8eb40bfeb@debian.org>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Gregory Price <gourry@gourry.net>, Usama Arif <usamaarif642@gmail.com>, 
 linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>, kernel-team@meta.com
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1124; i=leitao@debian.org;
 h=from:subject:message-id; bh=SzCoB6sQHDFFteL8s7JGLImKCYtxlB9ZDym1wSLtA6k=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBnfCjiuDGAe0GVCy3Hv7yfI8K9aJu5yMo1TmQq4
 dzbSyIAd8CJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCZ3wo4gAKCRA1o5Of/Hh3
 bcMAEACb0hycfKstg+T1pVxX0J/1kBOiZZEdSX5aO3NjTP13qwPWtUadaXqlIXmbvh2zhC2mNwW
 aHTi2TlaA2zMdWhemhxjSeB2K6DYgY0k49xEAZE9Q/A/l8oVry1QqAkuuE0z0/x8yjAF1v5Bp2N
 gyqyZYhNV+kKvXK/OcGS3hHMefBsxEFFePjghSu/HThWCJicVBMUcSGKrSdHTBLmmsIQ+Bso5Se
 5uNFUf9kqRuU/YzH1OLBTfdZ8firXYtayzdEgwdFlcHyKAUIotrwxq3QP91jG6yIQWhBMlLD3wh
 Eow9xATOzoTU/nF86S7ogO737mAxqz4Ry2zzH/QRmguTCSv1UE5M+gdjObfQrrvCZ0kRYx6mqeU
 JZDGxJQKTrEgI/TxJx7qMr7YGymnqR4QD6p18C2hpEtkW7O525N78T9ZLeTtsYCPrF1+tcxjhd2
 ctdgOMJRIz+t0tMrnzlXnrfKNXheS40oq0P/mce5HFykMKH6X+HHaooWnFDbEZa3qiR3wts+kQg
 vM0xqVUK1vAOKG/AVDW3/Rdmf0KZ+EvSvF0/lrAe79ua2+0Yzu5GwQEI5/i5OgOyQhNag/SVfbN
 zMFYsHcfdQXtZncOfremWw+099w5myeoEMEo2FBmhdSdt+yIb/EEjPtwooRLkVQVJSyTrrnooS6
 2QQ1k+OzIOWw/yQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Tag firmware-related error messages with FW_BUG in efi_memattr_init() to
make EFI firmware issues more discoverable and consistent with kernel
error reporting conventions.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/firmware/efi/memattr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/efi/memattr.c b/drivers/firmware/efi/memattr.c
index e727cc5909cb676c47d787ab0d7754b6fdcb493d..5f83cdea88b05cb325e9f90c14a0048131e53cfa 100644
--- a/drivers/firmware/efi/memattr.c
+++ b/drivers/firmware/efi/memattr.c
@@ -29,13 +29,13 @@ void __init efi_memattr_init(void)
 
 	tbl = early_memremap(efi_mem_attr_table, sizeof(*tbl));
 	if (!tbl) {
-		pr_err("Failed to map EFI Memory Attributes table @ 0x%lx\n",
+		pr_err(FW_BUG "Failed to map EFI Memory Attributes table @ 0x%lx\n",
 		       efi_mem_attr_table);
 		return;
 	}
 
 	if (tbl->version > 2) {
-		pr_warn("Unexpected EFI Memory Attributes table version %d\n",
+		pr_warn(FW_BUG "Unexpected EFI Memory Attributes table version %d\n",
 			tbl->version);
 		goto unmap;
 	}

-- 
2.43.5


