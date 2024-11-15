Return-Path: <linux-efi+bounces-2153-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE7399CDB8D
	for <lists+linux-efi@lfdr.de>; Fri, 15 Nov 2024 10:29:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 942B82832B1
	for <lists+linux-efi@lfdr.de>; Fri, 15 Nov 2024 09:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22CF118F2FC;
	Fri, 15 Nov 2024 09:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zEwVNLBN"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A8CA18D621
	for <linux-efi@vger.kernel.org>; Fri, 15 Nov 2024 09:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731662945; cv=none; b=uQW9Lbf9BIghaBvN91R7Pul8JspaCyyspbHwWT/xG7vM3GLSlS3BK+vc7a+ktVpdsOdlJPhbWOZPyiO1swXEJNZTVG1LjZfeLJ+gOTj+IAs7EF98UbXpcJ0yxAOvsb+75Cqz5ex15F34NRcqVQOUHrxsJBCHQbmxrfuQGjnEHNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731662945; c=relaxed/simple;
	bh=bxKNKy+x/UttdmJzS38zLgxiwsrmMRUitTbKK744Gs8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JCJW9eTex9Wu8xGZH9DkyIBke/pRp1SGCCKrju0Sha/4WWGhPivyLu0es/UHMmGXSMcxvixQHza2MfEYu3XX0YPD88LiYmZXQCyXAEFwZ8cacQ+g0Z1v8Yapa7lHZeIw8UHXCbdeIU2wttqY8GDlWVLH7iDpRIQ6sIGKOyoPIvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zEwVNLBN; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-37d4854fa0eso1018318f8f.2
        for <linux-efi@vger.kernel.org>; Fri, 15 Nov 2024 01:29:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731662941; x=1732267741; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=I36NvbzpYB+4pn0OOA4a7gl5c6PkC9vkt88/N2JLADs=;
        b=zEwVNLBNHZAFPC/jkdf7j1awAO+rzSbrS6Gf2VzyGqk4fN/RzifXlpvlPTDT9AiUoF
         Nmf9i18+aa1TVFp+LBkzrlNmDK4Ck9rs4P487EbmNdeEkVhbcctxX60NixbjeoB7vaL5
         Wtsqi9ZspwvyxOZ6N6s29puKOXSWobgjjwbIbQM86J++CFlutOHB14hPRzXQ/WU1Ravi
         icxHa7qp7/9M/xl0H/MM17vtL/Amm2LhjCrGmzQckPthaLT+patJY5qIUmjZpeFBQfWU
         cXIAFGkjy63xMl27ECWZs3bAvUY4Ou8iCSHyE/VtYPTtmjr4nMpZ4XV2X3MFip+ylHQ2
         rvmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731662941; x=1732267741;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I36NvbzpYB+4pn0OOA4a7gl5c6PkC9vkt88/N2JLADs=;
        b=ZX0kYKD+4ZIcHPl/r5y6i/4iijQLtR5QprrACLqQiFAbWgJ6eZWcScOSoR1LSSu/DV
         l/zUXAnbA2Wlw+4mo8hmTg2JrSCx9NKpmgQge9vyfMQN31qqxQOYoSzZnJth55JGeo+d
         mWDpDIIioq8pOklpdRt8YnlPwkOv+6dH55hZ0X7x/Tvty+u6HU3GNh8liHNHxAjZWKKa
         d56xrEZC2rEH0BUPHzHZEOe+ORq+TYyPlXv1s0Kh598RchKB/in4aTKbyvZeS2XUkPmz
         yNDmJhGADRl6XcoO/OVMi3PPGGS7R/CiaZeat/Z6GAy1/3PHTipvcL1b3NmTjiJJL3TG
         +epA==
X-Gm-Message-State: AOJu0YzsfDPC7gk47UEC0OKeccdrNNhi2H+RIsqfa62nBXfKS2MYeJOj
	Uv0GbGgIoCDaYQZrxlVHnqlT6AkFMJ66hAYdYcnRBYdEInEPEo/vndmi4KXCvwaMVVbB2pDWgD2
	iWpAQLoIli/MLTEXByANBP+uPrrn/MQMtLXX0PcTb1L4NTjLk1a/dXsmVu8TjdNm34ekWWHYlyN
	aFKaxICvqhDT/g7gSqBNmp5n32tA==
X-Google-Smtp-Source: AGHT+IFW94hI0wAgH+GxHjCI2992OY8jthRU/+UgjaKYnoMoS+FMVWXTQDhPRG2RH3idUV1/V4tbLgPt
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:7b:198d:ac11:8138])
 (user=ardb job=sendgmr) by 2002:adf:ef50:0:b0:37d:45dd:dfbf with SMTP id
 ffacd0b85a97d-3822590612fmr1319f8f.4.1731662940947; Fri, 15 Nov 2024 01:29:00
 -0800 (PST)
Date: Fri, 15 Nov 2024 10:28:42 +0100
In-Reply-To: <20241115092838.3080857-5-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241115092838.3080857-5-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1204; i=ardb@kernel.org;
 h=from:subject; bh=XMY0HDGBMeYwkWGjATAWo9goi0Uyg1ks4hbjHQr6n/I=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JId1cxHPNfcUmbcv4bqaIRslVK3alLjmUw6ibvM6loPzdl
 6Da2EsdpSwMYhwMsmKKLAKz/77beXqiVK3zLFmYOaxMIEMYuDgFYCLXjzP8U1xuIdLy4ZmQWpZ1
 78aN/+Pt8lh//3ncHlt408V7u5Hwb0aGXw+3z5SQFuVuvarFqXrdrl9i7Qlu3/XdaqvOKul+ztj EDQA=
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241115092838.3080857-8-ardb+git@google.com>
Subject: [PATCH 4/4] efi/libstub: Take command line overrides into account for
 loaded files
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-efi@vger.kernel.org
Cc: Jonathan Marek <jonathan@marek.ca>, Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

When CONFIG_CMDLINE_OVERRIDE or CONFIG_CMDLINE_FORCE are configured, the
command line provided by the boot stack should be ignored, and only the
built-in command line should be taken into account.

Add the required handling of this when dealing with initrd= or dtb=
command line options in the EFI stub.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/file.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/libstub/file.c b/drivers/firmware/efi/libstub/file.c
index 17bf25dccc07..0e41b88238b1 100644
--- a/drivers/firmware/efi/libstub/file.c
+++ b/drivers/firmware/efi/libstub/file.c
@@ -189,7 +189,8 @@ efi_status_t handle_cmdline_files(efi_loaded_image_t *image,
 				  unsigned long *load_addr,
 				  unsigned long *load_size)
 {
-	const bool ignore_load_options = false;
+	const bool ignore_load_options = IS_ENABLED(CONFIG_CMDLINE_OVERRIDE) ||
+					 IS_ENABLED(CONFIG_CMDLINE_FORCE);
 	const efi_char16_t *cmdline = efi_table_attr(image, load_options);
 	u32 cmdline_len = efi_table_attr(image, load_options_size);
 	unsigned long efi_chunk_size = ULONG_MAX;
-- 
2.47.0.338.g60cca15819-goog


