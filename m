Return-Path: <linux-efi+bounces-2123-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A05A9BB45F
	for <lists+linux-efi@lfdr.de>; Mon,  4 Nov 2024 13:14:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D8C61C21A8C
	for <lists+linux-efi@lfdr.de>; Mon,  4 Nov 2024 12:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 745C91B85D1;
	Mon,  4 Nov 2024 12:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eJJqf0TI"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896C21B652B;
	Mon,  4 Nov 2024 12:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730722440; cv=none; b=JtIOgBpJiUn8rTb/AZqdVXxMF7wX52Ogh1CDYJ2Zf5xs9V0zpEn442BZhGsopYTNqSYRFIKFWpe+68fhiMcxF0m9UjkgLLANJJ6mk4Rr5NVo8/F4H1cbuiQojXX0ZhGX6ruZha4rlyWyRIvXUEpZW+qHDExYsbqaM4m7pOK3Usc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730722440; c=relaxed/simple;
	bh=+FgPmna2yZYdpj3UFinnNH2q5GuuHS84mHOrxv7TxxM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uR4m53kN5gNXlwySb0TkerQCF8xDF2oFiWLlgw6JaSONzM9DZPtzbLmprqNDLNYlzzOHBPwKGYlHddBNqxYiuC1wzzqrUcIX0IbsEwlFYXQ7nAorqBnvtAoNJn5hQpCpO9tS4i/5n4UgXolag2MnY+Uk8z2+d6dU1nRJEjhenP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eJJqf0TI; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-539e13375d3so4154478e87.3;
        Mon, 04 Nov 2024 04:13:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730722437; x=1731327237; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FYskZ8T2jr5T8EblrfJJEhdK6BsHIwyTYKsdEZJGC9g=;
        b=eJJqf0TIkl8oal7cuwK+ijQFIXcW00ywgxq7L6UlJIltcUV0LZnVuPdMWOgSD634J2
         nIGMjp1PGoVwNIXgqWVtTNB5roFwvhdcBUxWD+kbW26ylsj0saQA8UirUq6LJ/mcEWBP
         nZkBvmXlhlNdEOhkWH6usubp1B+oach/Hu/6psfdKdowoOTbrlbcjXdKs+pGfZKdP9AV
         QYf9+nAph09MPjTt2P5t/18cIyqe30mX70Lope7gxZqhzYAoDzS7hYe+Xrl9U3xbyV7K
         E63Tvdb28Gb+a8FQklx2b4pgxH1iAGpJIOB4QC8YV+x0tojhSmaRdRfsG0gi8piWGGM7
         vGNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730722437; x=1731327237;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FYskZ8T2jr5T8EblrfJJEhdK6BsHIwyTYKsdEZJGC9g=;
        b=o6K1LZC+OF2O2pNIqnQkz8iU/ZS9aXSI4cbX419nVEBgzxm9nBSbJVzc5wqb/4o8O1
         SXvVBC9e5J0KUiifm3uxjs3dm5ggcCFS4IzYevsDwAExogsaNc32ZpyIoXPxYfEcpBew
         Pid+jBwfA0bxMcmsF9zfyNN2WPQGNEIgroOXoedVKCkzt08YVevIx9yUEFJKK9ogNIdY
         XtTT2ezGdGmJ0tBdWL2LY39kuilXAkXxrUehveeEwBfZTNh2mQ9CWQ4DrDQArQUHhQRQ
         VGzxiB4zPrYp8W/vV55IdjqOuQa5c5wJ0JncnsZPchn/qHIP+cUe3pOulfJU9GhYioQS
         rVYg==
X-Forwarded-Encrypted: i=1; AJvYcCUyZ3Sz1xDXUMEbQb92t3Qo6j+Eg5w1btmJ+YgTcxFJZnAPDHdm4HDGnU7Ly2oSCtUqy53OGea9oP0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz72GxfeDJh7zCnbaL1wAyLkvvYeJAsBbCvenCuge6hdATG8v0I
	qHyP/8tyL91BZv3EdY3183Gf+aJcLRXfdB61gUB9ZWziDiX1LTgZPG5xFHMw
X-Google-Smtp-Source: AGHT+IFbNToplnnRUfn1KF9Fr4torBzIilIwgS+jtoCykgAETFELOGlixWAh20O2s93UKXwn7sRtWw==
X-Received: by 2002:a05:6512:1595:b0:539:e2cc:d380 with SMTP id 2adb3069b0e04-53c79e494ebmr7420697e87.27.1730722436375;
        Mon, 04 Nov 2024 04:13:56 -0800 (PST)
Received: from grain.localdomain ([5.18.251.97])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53c7bde3265sm1666224e87.278.2024.11.04.04.13.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 04:13:56 -0800 (PST)
Received: by grain.localdomain (Postfix, from userid 1000)
	id 6CF475A0127; Mon,  4 Nov 2024 15:13:55 +0300 (MSK)
Date: Mon, 4 Nov 2024 15:13:55 +0300
From: Cyrill Gorcunov <gorcunov@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>, linux-efi@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH v2] efi: Fix memory leak in efivar_ssdt_load
Message-ID: <Zyi6g8W0OqKcng6S@grain>
References: <ZyizcvscUWIyZYdE@grain>
 <Zyi11v-6V_ivKS5x@grain>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zyi11v-6V_ivKS5x@grain>
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
It is still unclear for me why we don't exit with error if acpi_load_table
failed but continue to iterate keys and don't report a caller with error
instead. I didn't change this logic for backward compatibility sake but
still looks suspicious.

 drivers/firmware/efi/efi.c |   41 ++++++++++++++++++++++++++++-------------
 1 file changed, 28 insertions(+), 13 deletions(-)

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
@@ -309,26 +310,38 @@ static __init int efivar_ssdt_load(void)
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
-			acpi_status ret = acpi_load_table(data, NULL);
-			if (ret)
-				pr_err("failed to load table: %u\n", ret);
-			else
+			acpi_status acpi_ret = acpi_load_table(data, NULL);
+			if (ACPI_FAILURE(acpi_ret)) {
+				pr_err("efivar_ssdt: failed to load table: %u\n",
+				       acpi_ret);
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
@@ -433,7 +446,9 @@ static int __init efisubsys_init(void)
 		error = generic_ops_register();
 		if (error)
 			goto err_put;
-		efivar_ssdt_load();
+		error = efivar_ssdt_load();
+		if (error)
+			pr_err("efi: failed to load SSDT, error %d.\n", error);
 		platform_device_register_simple("efivars", 0, NULL, 0);
 	}
 

