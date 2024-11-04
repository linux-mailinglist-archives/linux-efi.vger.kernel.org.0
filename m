Return-Path: <linux-efi+bounces-2121-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 72BBF9BB3D5
	for <lists+linux-efi@lfdr.de>; Mon,  4 Nov 2024 12:49:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 571DBB22CA7
	for <lists+linux-efi@lfdr.de>; Mon,  4 Nov 2024 11:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 539C718A6B6;
	Mon,  4 Nov 2024 11:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gOV0EX5h"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D47D23A6;
	Mon,  4 Nov 2024 11:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730720631; cv=none; b=ub74TbEohl19ZnxuClElxl07nSvs02Bac2+7DEDXFJC2W3lhnMFBY90wK8EpE5fYI+2eMCdj8a+z8gADMPoKN4EA03ltsXfBUM/W1TR2uIQ8kyQTjACrMrL9u5hZuVmVWIYf2zHpMondUTxJtdszfiY3OgJhB0rYbl8iRPdCh7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730720631; c=relaxed/simple;
	bh=6cZrjlqDP9qVoHVK8n/qqIaWJapezYHGXflMcQcPads=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=U8fVupgkPybki19rlCefT9RjyQEhdLhqVOL/62A4pcFlHUF0sk1m3nPVE17Pu2g7gMqccrhSePKYEE5uVtbSUAxPJgBuFaKDlc8UWYONxzp0Gt1DaFaft5eygWrRwZk+7rBdEVibMow/KSgrIQqf/W80VIN57M5CWVChYgo72zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gOV0EX5h; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2fb3debdc09so28605351fa.3;
        Mon, 04 Nov 2024 03:43:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730720628; x=1731325428; darn=vger.kernel.org;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yyhmjhlw3L5uzKJvXgYEOHuWe4ZiY7h27g/SLzwsVCU=;
        b=gOV0EX5hY+8tAuXe4FGEmvyLpaokpFLB9bx4ns6QJa3cTxfK90gfB+Rnu8fo8DuxTe
         6lh1Io9Z8shbe/T+vlbr4BY5kqKKF9lI1SRq0IxGDEad+PNpySHwM0IfbO1Tsrhst68I
         HHL/2Z+WnDQSOQ8JrPKc3Beekpi1gMLNyeVvkh4xpMd9/bn5Fh/Bymupvbt2RJogLu/S
         8/8d6XYb+JrB1Q/leli0qZLHV2nGNTUzqsX1teHovwQ4e/I32h/Ku6EuOSWfjGjFwNXo
         +d1pYqb8cGhbXL66ciZsN6kM0KhP1ytve7UCBV+Jt6+bRSqglc35FQVzmmcS/rggHbgj
         R44A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730720628; x=1731325428;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yyhmjhlw3L5uzKJvXgYEOHuWe4ZiY7h27g/SLzwsVCU=;
        b=M6vvgH/leJaGOWATRbKtk+G+oRUUWLvuNml3Gr25y5JjcxX00T1PEKD2nbCxkvFAuG
         P/4xa9OWnZU2rB0nqZOcbM61E7ti6JNMLwKeinFpxLcmSGzyLBGM3A7XpbU9idrDtIMC
         PLiILRNwuzY6lCUj7u+AsfC39eVt78sJMuYq+r4mQSZJlCs+X6wWCFM+CqyiFSvV9Rca
         SA/U5xzFlEUCwBax5Gum3+ezWzvaITPyM+rwKOXkhtIEarnSnqkeALlvk72kTV0bc/Mz
         awHwjZBKmK2H5XBVPAWzNq7brGU3f+FSwR2sIELvghpFjvZTN+b0aF3fovgWjwfg3MEc
         7GVA==
X-Forwarded-Encrypted: i=1; AJvYcCUIYo9LCgnflxcjYqDCduM9Hu84NwYaY6f6sOkH+Dis8dfcYkkSMGZxV+QXpc5+OpduKBS9v+275qk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8MWC4n7mMYNc5KQii3wkxWHNgstuyWf/tuyf9f/mkqTJgs4hI
	8emYbKEcU+ZjdmrF1sycAc7/NVIaFRWVrihb5EkBGASwwYb3fbhXMjxMEEeL
X-Google-Smtp-Source: AGHT+IEon6g8rsUOAKboBUan5eSh7SftyIJAVjz48aAdfBHNIfNNaYYuAiLKX1ddFnZzTf0PmskSSg==
X-Received: by 2002:a05:651c:2204:b0:2fb:50e9:34b4 with SMTP id 38308e7fff4ca-2fdec47a3f4mr74687091fa.8.1730720627448;
        Mon, 04 Nov 2024 03:43:47 -0800 (PST)
Received: from grain.localdomain ([5.18.251.97])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2fdef3b7243sm16309651fa.23.2024.11.04.03.43.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 03:43:47 -0800 (PST)
Received: by grain.localdomain (Postfix, from userid 1000)
	id 52C6F5A003D; Mon,  4 Nov 2024 14:43:46 +0300 (MSK)
Date: Mon, 4 Nov 2024 14:43:46 +0300
From: Cyrill Gorcunov <gorcunov@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>, linux-efi@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH] efi: Fix memory leak in efivar_ssdt_load
Message-ID: <ZyizcvscUWIyZYdE@grain>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/2.2.12 (2023-09-09)

When we load ssdt from efi variable (specified with efivar_ssdt=something
boot command line argument) a name for the variable is allocated
dynamically because we traverse all efi variables. Unlike an acpi table
data, which is later used by acpi engine, the name is no longer needed
once traverse is complete -- don't forget to free this memory.

Same time we silently ignore any errors happened here lets print
a message if something went wrong (but do not exit since this is
not a critical error and the system should continue to boot).

Also while here -- add a note why we keep ssdt table on success.

Signed-off-by: Cyrill Gorcunov <gorcunov@gmail.com>
Cc: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/efi.c |   38 ++++++++++++++++++++++++++------------
 1 file changed, 26 insertions(+), 12 deletions(-)

Index: linux-tip.git/drivers/firmware/efi/efi.c
===================================================================
--- linux-tip.git.orig/drivers/firmware/efi/efi.c
+++ linux-tip.git/drivers/firmware/efi/efi.c
@@ -273,6 +273,7 @@ static __init int efivar_ssdt_load(void)
 	efi_char16_t *name = NULL;
 	efi_status_t status;
 	efi_guid_t guid;
+	int ret = 0;
 
 	if (!efivar_ssdt[0])
 		return 0;
@@ -294,8 +295,8 @@ static __init int efivar_ssdt_load(void)
 			efi_char16_t *name_tmp =
 				krealloc(name, name_size, GFP_KERNEL);
 			if (!name_tmp) {
-				kfree(name);
-				return -ENOMEM;
+				ret = -ENOMEM;
+				goto out;
 			}
 			name = name_tmp;
 			continue;
@@ -309,26 +310,37 @@ static __init int efivar_ssdt_load(void)
 		pr_info("loading SSDT from variable %s-%pUl\n", efivar_ssdt, &guid);
 
 		status = efi.get_variable(name, &guid, NULL, &data_size, NULL);
-		if (status != EFI_BUFFER_TOO_SMALL || !data_size)
-			return -EIO;
+		if (status != EFI_BUFFER_TOO_SMALL || !data_size) {
+			ret = -EIO;
+			goto out;
+		}
 
 		data = kmalloc(data_size, GFP_KERNEL);
-		if (!data)
-			return -ENOMEM;
+		if (!data) {
+			ret = -ENOMEM;
+			goto out;
+		}
 
 		status = efi.get_variable(name, &guid, NULL, &data_size, data);
 		if (status == EFI_SUCCESS) {
 			acpi_status ret = acpi_load_table(data, NULL);
-			if (ret)
-				pr_err("failed to load table: %u\n", ret);
-			else
+			if (ret) {
+				pr_err("efivar_ssdt: failed to load table: %u\n", ret);
+			} else {
+				/*
+				 * The @data will be in use by ACPI engine,
+				 * do not free it!
+				 */
 				continue;
+			}
 		} else {
-			pr_err("failed to get var data: 0x%lx\n", status);
+			pr_err("efivar_ssdt: failed to get var data: 0x%lx\n", status);
 		}
 		kfree(data);
 	}
-	return 0;
+out:
+	kfree(name);
+	return ret;
 }
 #else
 static inline int efivar_ssdt_load(void) { return 0; }
@@ -433,7 +445,9 @@ static int __init efisubsys_init(void)
 		error = generic_ops_register();
 		if (error)
 			goto err_put;
-		efivar_ssdt_load();
+		error = efivar_ssdt_load();
+		if (error)
+			pr_err("efi: failed to load SSDT, error %d.\n", error);
 		platform_device_register_simple("efivars", 0, NULL, 0);
 	}
 

