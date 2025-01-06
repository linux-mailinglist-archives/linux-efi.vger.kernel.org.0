Return-Path: <linux-efi+bounces-2511-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36923A03022
	for <lists+linux-efi@lfdr.de>; Mon,  6 Jan 2025 20:03:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1ED93163711
	for <lists+linux-efi@lfdr.de>; Mon,  6 Jan 2025 19:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A382C1DFDA7;
	Mon,  6 Jan 2025 19:03:09 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5F01DF99F;
	Mon,  6 Jan 2025 19:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736190189; cv=none; b=SbQlzstMhvYTTetNaOZZ1jgHuRoxGISGX5JLwmfQ+dw5XBxNAHW7dG2V6c2zUedU9RCuQSB3hwRkxgiJkTySssGpsNBohcBCCtmt4/1HFFbd9TC06k05BeQJcTBXTzdXnGgRmFj51KhIVcaBpo1So2QB+kYN77aOGyLCFgu1FwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736190189; c=relaxed/simple;
	bh=XDlQUoNtCeApaDduUy35dnCHFieyco1MPgmsEZIJluI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aZrzOaPTGZBdIxI7B37Xb1heuJie3oY5YhccxwYVPKgrgS3SCbXp4Gi73CHfEW9IMe7bXhyGoEgrgrAXj+yJ9OEErGw8GacqA7Gi8zo1avG+VsiuHFnmFDw9VI4oPOpb69mdsWAR+VMPdgs0rWfPBYrPvDQIeF2WNMMQHSm7qW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5d3d479b1e6so21120887a12.2;
        Mon, 06 Jan 2025 11:03:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736190186; x=1736794986;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WNw/CDj2AbqbsGDq693ZJ+rM8tBrERKJW3IEDPq+sNE=;
        b=voFZJ3ugdAV8e8QOnXzA9xJAJcPLzzM424YSnCGGnm1n50mMXrz9SutH4u/jesEQbF
         0j7pxtPi7h2yfru5TpB15x2G0tiSK7h8wZF56faZXioT/oPWKhlTJv+7wKIaXpm9X5FN
         QIAwMo3LQLizblTIWd6tqm5fGiXb8yZ+lpqbUsrR68nNDkFradInBp505FFR5yGZNC7e
         38k3Kn/o9Ao/SBwadJ53FufSe9zKOrzS2MEDbSXd4QMVzDuDIUv1oihzxNg9PpILZzNT
         kenrQ+Mzck17xLaCRZysv77MpOlPgZENdenPhk2yxNsmtoRQVjVlW4b395NHnFSGpxcy
         E+wg==
X-Forwarded-Encrypted: i=1; AJvYcCXLBR6XRpNd0xdE9vOeC/10JUWbnd3mwRzxmRpkvxyB0HtpfsQlgwYLatA1KV2UB7IKpzqPCemo0Lq50mag@vger.kernel.org, AJvYcCXXmJZseofO/Mtt52Cb/sstFG5+6cgNPLBXdpdZMQHR5HC7tLU9Gdy/BE86kaJscSuheHYLwHIaT8k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7NDJnRuq+BWM7XnRx+HoDftK06ZHwSLQCvtXOKvsoGBpZlTJz
	7CuFYhvfHz7mviqG0ldzPYWe6GhA2afhdLeYqifPxdAN0g8nc6Br
X-Gm-Gg: ASbGncu68IjbuaePJbbcshZMeSVC1ddqiAXwU5VvWO0Z+Rc8gwkJb2zSd4FGjKKXsjR
	VHTPCCnFIwVUjLE74hhq7ZUSjvvfO7pm62EdWx0LEZPsxZlxOechfn7JLIdSq/BWheW6EUSQ76n
	nNfSKh6bi4cPgOu0iqQdNTbCcktx6dFjPD1U/GfKRDnTjAtIM0suTZ/hiY21ShGd/hJ24zMDVPM
	lE/x0pk1ifwFrWlCSNxH7I9YSNwAUV3c4WAz2UxDVDqamU=
X-Google-Smtp-Source: AGHT+IEZDQWzmp5R71lMPn2pyV2ms78L0LJVg99guVtYekxh5sI6zcDQHYOjlstIaq5cJELBwT/M/Q==
X-Received: by 2002:a05:6402:50c6:b0:5d4:35c7:cd7a with SMTP id 4fb4d7f45d1cf-5d81dd9c7d5mr150377218a12.10.1736190186213;
        Mon, 06 Jan 2025 11:03:06 -0800 (PST)
Received: from localhost ([2a03:2880:30ff:1::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d80678c8dbsm23258258a12.40.2025.01.06.11.03.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2025 11:03:04 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Mon, 06 Jan 2025 11:02:52 -0800
Subject: [PATCH 3/3] efi/memattr: Include EFI memmap size in corruption
 warnings
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250106-efi_fw_bug-v1-3-01a8eb40bfeb@debian.org>
References: <20250106-efi_fw_bug-v1-0-01a8eb40bfeb@debian.org>
In-Reply-To: <20250106-efi_fw_bug-v1-0-01a8eb40bfeb@debian.org>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Gregory Price <gourry@gourry.net>, Usama Arif <usamaarif642@gmail.com>, 
 linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>, kernel-team@meta.com
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1581; i=leitao@debian.org;
 h=from:subject:message-id; bh=XDlQUoNtCeApaDduUy35dnCHFieyco1MPgmsEZIJluI=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBnfCji1e2QsBy/TWDBEo3SBADQTcBVfTF7xdR/A
 Zfp5HIZ/HmJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCZ3wo4gAKCRA1o5Of/Hh3
 bShhD/0YyAnhwhxw6D0NhVeQRYnz5YOUXqeUGgN2m+arSHAP5ivVpRutIG9uQU0AZAK0nw5r3ES
 8l6mtegPemB/nmDhLawV3ko0N+PRg4Hoc0M6MNNud7G/aTOIcYslW+T2PlSGj4zvvn3ZgWCuulz
 EBhXdNTJP546dpgH9phhPztVs57ehyehlRYoCcc2spO7NJ+4FgXti4T/cUBF7RmJOHU/3aGXXjl
 ivACPZu6ESYbY7PRd9t6qh7zGKDcKdub0OXKl1iZ2CBS2pvUu1fZAVPAAFJMB7KTglXxa7PBoEt
 tLEtz1oTvWYNsvkMcYe8uDEBH2lDeX0tTSGcZO9QFOTBuBMDAZio0pELqaIlHChkeipqtzAsVns
 tJGxJVEnvXVRs6G7Y77APJK2lA8v8ELv4SM94VGy+OAwDqGRlPjhKDOC4fuxjdVhtfeH1wa8eb2
 rwxpJzzfDqjfJCpr8651CUFdnGxVbU/i+i/yAmLL1cDK8fRyw+arhU1XWu6QZibLWnojX0sFuFg
 DYuw0YWfwgEckEdfy8c6Sr0AFeDKjdw3sFpzO5LDLwhHFRCW6hatFk3i/qSGocg1hauyoGP9D6P
 HqstDoRITxTO5BBSKBEUW4Wopheo+gNSeWQ8niWrQ3KwI23a8estH0NWhrbOhfoAeMdg1KEVUSw
 W3+EMhJJ40wv1Aw==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Add EFI memory map size to warning messages when a corrupted Memory
Attributes Table is detected, making it easier to diagnose firmware issues.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/firmware/efi/memattr.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/firmware/efi/memattr.c b/drivers/firmware/efi/memattr.c
index 5f83cdea88b05cb325e9f90c14a0048131e53cfa..2c276bcc0df48352bec6cd96b69edf67a16f6069 100644
--- a/drivers/firmware/efi/memattr.c
+++ b/drivers/firmware/efi/memattr.c
@@ -22,7 +22,7 @@ unsigned long __ro_after_init efi_mem_attr_table = EFI_INVALID_TABLE_ADDR;
 void __init efi_memattr_init(void)
 {
 	efi_memory_attributes_table_t *tbl;
-	unsigned long size;
+	unsigned long size, efi_map_size;
 
 	if (efi_mem_attr_table == EFI_INVALID_TABLE_ADDR)
 		return;
@@ -49,9 +49,10 @@ void __init efi_memattr_init(void)
 	 * just be ignored altogether.
 	 */
 	size = tbl->num_entries * tbl->desc_size;
-	if (size > 3 * efi.memmap.nr_map * efi.memmap.desc_size) {
-		pr_warn(FW_BUG "Corrupted EFI Memory Attributes Table detected! (version == %u, desc_size == %u, num_entries == %u)\n",
-			tbl->version, tbl->desc_size, tbl->num_entries);
+	efi_map_size = efi.memmap.nr_map * efi.memmap.desc_size;
+	if (size > 3 * efi_map_size) {
+		pr_warn(FW_BUG "Corrupted EFI Memory Attributes Table detected! (version == %u, desc_size == %u, num_entries == %u, efi_map_size == %lu)\n",
+			tbl->version, tbl->desc_size, tbl->num_entries, efi_map_size);
 		goto unmap;
 	}
 

-- 
2.43.5


