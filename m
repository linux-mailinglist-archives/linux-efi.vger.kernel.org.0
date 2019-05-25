Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8CD682A3FF
	for <lists+linux-efi@lfdr.de>; Sat, 25 May 2019 13:26:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726653AbfEYL0J (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 25 May 2019 07:26:09 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36479 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726793AbfEYL0I (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 25 May 2019 07:26:08 -0400
Received: by mail-wm1-f68.google.com with SMTP id v22so4267160wml.1
        for <linux-efi@vger.kernel.org>; Sat, 25 May 2019 04:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OUI4/EWFs7dysvkWkmT8oqHBgaMA7PctBGeEQk1P8DM=;
        b=Xk7crZ3SgaYp2op+gqS6Fwuo61nMeTjeaMhkrpOXWcTSb1xfkjUrv4qgMftwU/IlHy
         dmd71IcLoKhv3YHnv8AZmZuTsg4jpSLsGXYM6/1C+zs43ioBxvvNoHRI/5JwgHN+XYdg
         j/Z7lCyFj5QKDWn53ydL4gVFUQZpsjutjJhKEWcpqQMQugKiz2kR5VuJx1KGOo3E+Nda
         Npzq01tKsupdUU7myMcCnFUImgtIcE5+zDslXII4YBhFm6GEiQYQcSsxAhKCxl9s7mTw
         WcR43lBzU4NZLs10wB6Id/eI0J9TqsVC/wEVtt9E0FK78MoO54vaPBFBfACfaURgaczz
         QSYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OUI4/EWFs7dysvkWkmT8oqHBgaMA7PctBGeEQk1P8DM=;
        b=VQ3XnrIrNrg+VWPd418apSJcX4zMVtZy7WhNzIjqw2pqoOeyTTe2b1/x2IqUbVpKlp
         odS8eMzuKxB6lm09lO13ViJyBg1W3HBBWCxkyeHGooRvMaafD2SMGJE42v1gJe+c4Jdz
         Fz8kbrLSi4xoUnhmXr9/iFV3KHBlmQY3I4x7sYpPt0l35N+azW/LaXR3U3zmWS8XK4Q9
         e80lPZn9Qw9FF0xHU8P2zPcEI8fUJV+kyg6i2RNmkZP3pbX7ZhpU2BHdYSA3qaVOOET1
         BuuVPDcFN8EoNvmeljJwFg115UDWqHFNv9umJNlYbjaPszOUS19GKG1RrE/dEaEr9u8e
         vlhQ==
X-Gm-Message-State: APjAAAUPLs3OtnBnLbe/C5u8z/g5hAMNQAlXMKV20Yskw2FKueP3FYAO
        Sdz7zCvEYboA7bQQDnouj8G/In5FXhQ+Gg==
X-Google-Smtp-Source: APXvYqwSAn6kgtZ1x7GaFjsTqxhVYOxcP041eLBnfHvj1a7k3ZX05vxANVyJConZNz4fmBZsZ3o3/g==
X-Received: by 2002:a1c:1a47:: with SMTP id a68mr3134852wma.88.1558783566097;
        Sat, 25 May 2019 04:26:06 -0700 (PDT)
Received: from sudo.home ([2a01:cb1d:112:6f00:3ccc:7074:9336:6a6e])
        by smtp.gmail.com with ESMTPSA id y16sm4942010wru.28.2019.05.25.04.26.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 25 May 2019 04:26:05 -0700 (PDT)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-kernel@vger.kernel.org, Gen Zhang <blackgod016574@gmail.com>,
        Rob Bradford <robert.bradford@intel.com>
Subject: [PATCH 2/2] efi: Allow the number of EFI configuration tables entries to be zero
Date:   Sat, 25 May 2019 13:25:59 +0200
Message-Id: <20190525112559.7917-3-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190525112559.7917-1-ard.biesheuvel@linaro.org>
References: <20190525112559.7917-1-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Rob Bradford <robert.bradford@intel.com>

Only try and access the EFI configuration tables if there there are any
reported. This allows EFI to be continued to used on systems where there
are no configuration table entries.

Signed-off-by: Rob Bradford <robert.bradford@intel.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/x86/platform/efi/quirks.c | 3 +++
 drivers/firmware/efi/efi.c     | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/arch/x86/platform/efi/quirks.c b/arch/x86/platform/efi/quirks.c
index a25a9fd987a9..e92ab8002dc5 100644
--- a/arch/x86/platform/efi/quirks.c
+++ b/arch/x86/platform/efi/quirks.c
@@ -512,6 +512,9 @@ int __init efi_reuse_config(u64 tables, int nr_tables)
 	void *p, *tablep;
 	struct efi_setup_data *data;
 
+	if (nr_tables == 0)
+		return 0;
+
 	if (!efi_setup)
 		return 0;
 
diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 55b77c576c42..521a541d02ad 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -636,6 +636,9 @@ int __init efi_config_init(efi_config_table_type_t *arch_tables)
 	void *config_tables;
 	int sz, ret;
 
+	if (efi.systab->nr_tables == 0)
+		return 0;
+
 	if (efi_enabled(EFI_64BIT))
 		sz = sizeof(efi_config_table_64_t);
 	else
-- 
2.20.1

