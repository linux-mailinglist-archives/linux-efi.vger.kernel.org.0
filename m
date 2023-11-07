Return-Path: <linux-efi+bounces-4-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C44C7E34E7
	for <lists+linux-efi@lfdr.de>; Tue,  7 Nov 2023 06:42:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 682A8B20B58
	for <lists+linux-efi@lfdr.de>; Tue,  7 Nov 2023 05:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F16811FBC;
	Tue,  7 Nov 2023 05:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kLXf473p"
X-Original-To: linux-efi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5074C1C2F
	for <linux-efi@vger.kernel.org>; Tue,  7 Nov 2023 05:42:08 +0000 (UTC)
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 767E9114
	for <linux-efi@vger.kernel.org>; Mon,  6 Nov 2023 21:42:06 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-27ff83feb29so4995753a91.3
        for <linux-efi@vger.kernel.org>; Mon, 06 Nov 2023 21:42:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699335726; x=1699940526; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+DgvxotwaTtWteL5tabHmVGGI55WW2NP7qS80NJ0jj8=;
        b=kLXf473pHIUnsqLonPpBOYzD/HkaJd8IBAgLDKb4HgvcFYMEA10Ws0fc6QIJNbUwKQ
         ALAGec/Pvc72Pqc+3PLHjLh7vFv+71MNDTiGmbXqGMvhKbuq3QrkbsdVIhX7SfrqM0qA
         zaBzKuosYatuQ+iBNNFYuRXoZdrLAbAiBmHBtHrpPI32jJaXprVnyb3OYFwpCC6Mgoaa
         iRK9owfgrPv0uE3oyjXT/s/sM6u7RBKBH0LuuIi7y4P28uOzLN160GDgREMdZqco/8dx
         m5FcAjFDKWgdDN3KVfShcHsC0CvJDOiipg1WXoVYb5kXy3/vQAxFkE8Qxxc/T8MCPVcn
         aMBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699335726; x=1699940526;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+DgvxotwaTtWteL5tabHmVGGI55WW2NP7qS80NJ0jj8=;
        b=Hp6UoVgXoWeV8oCDeTOEP4Zqdvb1BdnEdboy8kJweFhKifJ1mdVsm99hYMCf6RQXDK
         DVZWgAWzeSx7SQJZMNBHf8yY6UpfTVY/VTnZf0NS+EN7pNurnnsYkR0G78AWhM9ojHLi
         gOqgr78Zlj3zoeFRxiwz08n7uppqKM8s71OOMO05PC+DgWll21WREsMeEMkoduGX8wwB
         WsUDAf7P6nFXSgBFwKP4MC5fqlTuTglYOE6nGGvZR2vltn6ddw0dZsK0rH51A1W8a/ac
         YNR0tSxN/rOpwzi2gJTDX1Iu6ct6wNrvvPfedXmq1MIGD2y2qkuADDpX97Me/8nWT5Uy
         rbbg==
X-Gm-Message-State: AOJu0YyMc6E9RMOEabvdEGSvwa4bRrZI5BpFa8UoOj3P8e+iVzGch16E
	RjeP50Byd1dVA8/63zZCptlavw==
X-Google-Smtp-Source: AGHT+IHZ3idJRm1aXs9l9xP/m9GfU8LEl5Lj5EkDsfn6ACMSyljS0zsakSZkEiN5ZV7gZIgIsSIedA==
X-Received: by 2002:a17:90a:194:b0:27d:5562:7e0b with SMTP id 20-20020a17090a019400b0027d55627e0bmr27688025pjc.7.1699335725847;
        Mon, 06 Nov 2023 21:42:05 -0800 (PST)
Received: from localhost.localdomain (fp9875a45d.knge128.ap.nuro.jp. [152.117.164.93])
        by smtp.gmail.com with ESMTPSA id b17-20020a170902ed1100b001cc530c495asm6752053pld.113.2023.11.06.21.42.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 21:42:05 -0800 (PST)
From: Masahisa Kojima <masahisa.kojima@linaro.org>
To: Ard Biesheuvel <ardb@kernel.org>,
	Jens Wiklander <jens.wiklander@linaro.org>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Sumit Garg <sumit.garg@linaro.org>,
	linux-kernel@vger.kernel.org,
	op-tee@lists.trustedfirmware.org
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Johan Hovold <johan+linaro@kernel.org>,
	Masahisa Kojima <masahisa.kojima@linaro.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-efi@vger.kernel.org
Subject: [PATCH v10 2/5] efi: Add EFI_ACCESS_DENIED status code
Date: Tue,  7 Nov 2023 14:40:53 +0900
Message-Id: <20231107054057.1893-3-masahisa.kojima@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231107054057.1893-1-masahisa.kojima@linaro.org>
References: <20231107054057.1893-1-masahisa.kojima@linaro.org>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit adds the EFI_ACCESS_DENIED status code.

Acked-by: Sumit Garg <sumit.garg@linaro.org>
Co-developed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
---
 include/linux/efi.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/efi.h b/include/linux/efi.h
index 08bc00dad66e..3db43957bf19 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -40,6 +40,7 @@ struct screen_info;
 #define EFI_WRITE_PROTECTED	( 8 | (1UL << (BITS_PER_LONG-1)))
 #define EFI_OUT_OF_RESOURCES	( 9 | (1UL << (BITS_PER_LONG-1)))
 #define EFI_NOT_FOUND		(14 | (1UL << (BITS_PER_LONG-1)))
+#define EFI_ACCESS_DENIED	(15 | (1UL << (BITS_PER_LONG-1)))
 #define EFI_TIMEOUT		(18 | (1UL << (BITS_PER_LONG-1)))
 #define EFI_ABORTED		(21 | (1UL << (BITS_PER_LONG-1)))
 #define EFI_SECURITY_VIOLATION	(26 | (1UL << (BITS_PER_LONG-1)))
-- 
2.39.2


