Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84ABB89943
	for <lists+linux-efi@lfdr.de>; Mon, 12 Aug 2019 11:04:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727154AbfHLJEF (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 12 Aug 2019 05:04:05 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41647 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727391AbfHLJED (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 12 Aug 2019 05:04:03 -0400
Received: by mail-wr1-f66.google.com with SMTP id j16so1621570wrr.8
        for <linux-efi@vger.kernel.org>; Mon, 12 Aug 2019 02:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HTyv9Eu4MQrwpFFMyFc0gzzbaLMGelJD9u6D8BaDhyY=;
        b=FKkXSTB6J3Wyhrt3YpvN4go0vMK3H2f/AjafIFMoWKbvi5NmbLoPHI/SviaY0ggJWd
         ivRSdbb68Ub9njLyGKjH4NXf+EKjezD95C7dx9AWypa9mI5U/2m/wt/LwxpQSaYkARLk
         j7lBHY4hWjPoX4wN9RsKdPaTQ+pzWRMkCHUMBNn62Hk+qv1B4bCF286L3OmkNzbENfqC
         IOWJ0uObar1T5pOpzeFoRJHK8YhrsbLr9D27TBtBZuSculw41BkPqrsFAvcrSz8LegYP
         I91N6FAdwOcwoRrU+RDRHkKtaM9vOeYR+6bPaqq/3ksOHAcZ6UK7cPDEzWlLmEQBE+NL
         txZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HTyv9Eu4MQrwpFFMyFc0gzzbaLMGelJD9u6D8BaDhyY=;
        b=lnK9p1CG3ZaytSKJZcSNo96oqX0rXNRSufTymy/lLuuQPBf3X3US7fYBz5DJndFNWq
         jFO2tz+1IZuJ1wBp85Fi84FFT4Z4GadnWeCtOZGMax/de51baaQdthNHcb2UMxDmiKhB
         B2A5Bzgzjmdv1nOyOWs5Y1q0tneJqinEJGLTIEgVlxbejmV1yeyung15QGGCszyS3FvH
         M+DtZcOuv7+p90V8Bo8ta2d80REgvB+7cIqiqjGCdO2tiokfUt4OIduNQnPJy5FaWZxw
         wcutN14JP0Al5Sy6KmCRGvszqL7YXltLvvQLY0W2KfVHFi+vReWHhufrp6nArBBlw1o9
         qAwQ==
X-Gm-Message-State: APjAAAW4S8yVyHteYTyNSGN0RmuErX3zHyQn6fxNOOCsVfbQjRER6ySq
        A4/IjJYPpYbmeony8TvmUVvpGmdE+s/5/Q==
X-Google-Smtp-Source: APXvYqzqQZZVOihXfXhwihfRXR1iEKQK14Amy2esHmd0ZqbK3Zz5FlD5Iy2Mp4cqkW5NpZpqGI3cHA==
X-Received: by 2002:adf:f204:: with SMTP id p4mr41060825wro.317.1565600641516;
        Mon, 12 Aug 2019 02:04:01 -0700 (PDT)
Received: from localhost.localdomain ([2a02:587:a407:da00:1c0e:f938:89a1:8e17])
        by smtp.gmail.com with ESMTPSA id g8sm12659927wmf.17.2019.08.12.02.03.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Aug 2019 02:04:00 -0700 (PDT)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Subject: [PATCH 1/1] efi-stub: Fix get_efi_config_table on mixed-mode setups
Date:   Mon, 12 Aug 2019 12:03:30 +0300
Message-Id: <20190812090330.5779-2-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190812090330.5779-1-ard.biesheuvel@linaro.org>
References: <20190812090330.5779-1-ard.biesheuvel@linaro.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Hans de Goede <hdegoede@redhat.com>

Fix get_efi_config_table using the wrong structs when booting a
64 bit kernel on 32 bit firmware.

Fixes: 82d736ac56d7 ("Abstract out support for locating an EFI config table")
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Acked-By: Matthew Garrett <mjg59@google.com>
Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Acked-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 .../firmware/efi/libstub/efi-stub-helper.c    | 38 +++++++++++++------
 1 file changed, 27 insertions(+), 11 deletions(-)

diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
index 1db780c0f07b..3caae7f2cf56 100644
--- a/drivers/firmware/efi/libstub/efi-stub-helper.c
+++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
@@ -927,17 +927,33 @@ efi_status_t efi_exit_boot_services(efi_system_table_t *sys_table_arg,
 	return status;
 }
 
+#define GET_EFI_CONFIG_TABLE(bits)					\
+static void *get_efi_config_table##bits(efi_system_table_t *_sys_table,	\
+					efi_guid_t guid)		\
+{									\
+	efi_system_table_##bits##_t *sys_table;				\
+	efi_config_table_##bits##_t *tables;				\
+	int i;								\
+									\
+	sys_table = (typeof(sys_table))_sys_table;			\
+	tables = (typeof(tables))(unsigned long)sys_table->tables;	\
+									\
+	for (i = 0; i < sys_table->nr_tables; i++) {			\
+		if (efi_guidcmp(tables[i].guid, guid) != 0)		\
+			continue;					\
+									\
+		return (void *)(unsigned long)tables[i].table;		\
+	}								\
+									\
+	return NULL;							\
+}
+GET_EFI_CONFIG_TABLE(32)
+GET_EFI_CONFIG_TABLE(64)
+
 void *get_efi_config_table(efi_system_table_t *sys_table, efi_guid_t guid)
 {
-	efi_config_table_t *tables = (efi_config_table_t *)sys_table->tables;
-	int i;
-
-	for (i = 0; i < sys_table->nr_tables; i++) {
-		if (efi_guidcmp(tables[i].guid, guid) != 0)
-			continue;
-
-		return (void *)tables[i].table;
-	}
-
-	return NULL;
+	if (efi_is_64bit())
+		return get_efi_config_table64(sys_table, guid);
+	else
+		return get_efi_config_table32(sys_table, guid);
 }
-- 
2.17.1

