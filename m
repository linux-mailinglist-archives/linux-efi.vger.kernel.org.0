Return-Path: <linux-efi+bounces-709-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB3F787004C
	for <lists+linux-efi@lfdr.de>; Mon,  4 Mar 2024 12:21:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A7D41F24106
	for <lists+linux-efi@lfdr.de>; Mon,  4 Mar 2024 11:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3B4A39AC2;
	Mon,  4 Mar 2024 11:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xhee1bmY"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D99238F9D
	for <linux-efi@vger.kernel.org>; Mon,  4 Mar 2024 11:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709551260; cv=none; b=ovFoNXPvrCNe4f5xAEs/FsoI3wF0eCoJdkf0Sb9ocs2oj8ibQuZkk+tnhmOGehrQvNuNOELb7QACMfUowFec7nGpNUmiwgAKY/NQboY8L0VJO87Z/lUmvzAcwTSyB9KKyon5/zs+lhZ63aVELhfhtHLs4JxIDkNk8VS1qUlM+d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709551260; c=relaxed/simple;
	bh=kvVb9rM/zWIaYsKZQGAbxcSbYx2xXmqrEd/H/nkI1SY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=K/J8sHYYIBSHaXQa3ci4GnaHe4rVlUuEROpZwY21xEfDXKaDVDaOZ0mif5EsF+o3RHOj72pEudiYGeG/5GO6Ro+pupwpX6l/MiUx/FqzR8Xg63/TCGEdyl8l/ik8F4GfxpBgU5WFr/uG8qSCFemRnj5KsLdbQPDDMrjJTYapbLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xhee1bmY; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-608dc99b401so74193637b3.0
        for <linux-efi@vger.kernel.org>; Mon, 04 Mar 2024 03:20:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709551258; x=1710156058; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2LhOwOzHkxHuVhWTs2btQdkfA3eV3msZyzNfgIjErYs=;
        b=xhee1bmYBYF/EqDR3SIeyW5eVpeDkcLXcnx9N5JcxL0qrkhro5nEM8GdV5zSrJgMQy
         H66YYvcgFopCgHpYLnWKQ2rDa7+dZJlEJ326gUwyc/98sg/MGPweZkeRQD5Zx4wUukcE
         3M0ApWoFBSotg+BiTMJ/Gu9VpOfXG1bkvzj1wC3UwNbX7QWfITEcLesDapkCg70erXYI
         wVPTJuYo0Rr1fd0iLcTJjp4+Zc8VFqq9Ga6Zi8R5/TQV4tSZ/GXnRL1TZ3kfzj2PuJZJ
         sR3K3qMhQcd9hOTRtbyWBXpSBv6kCPffqNREo+6aHaQZ/SHR3lmwV38qW7CnIaI9UeFK
         nQgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709551258; x=1710156058;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2LhOwOzHkxHuVhWTs2btQdkfA3eV3msZyzNfgIjErYs=;
        b=SWZudjCodhYTLpZUitPmNOGTUcSJASy74JzaH03sC+LfGxzW3Gcfo9XwPYiYRnUDA/
         +iL2L0j6Slme0xzdmTPj+/s4DMyybvGawr9f1PWbe7tKciljg1BN43byhyX6lVp1TZ3b
         yBALGOOfaNjjybIUc8tjFPu+yQ7mrlqwCKMyydmzKg9OZtDYuBAQDrG4xXHqmCjLmQhT
         qqD3hqJAMxaYUa+3cI8+axQCKb96gC4X/4qXpkcNDwiAStMG4Tb2HmXetINpdW0xLl08
         llb5Ff6LGfIq4mORy3juuYH9oiBZOaA5tEBaavAGgpnZ9vgk7Au9+XNoSexRv67erune
         IbrA==
X-Gm-Message-State: AOJu0Yyr2fTbF7JkAxGOpCbWzdeqpFmbDU6A1VWdtIFqt9PShZ96e6ZC
	8/s9DQfm5itPAf5D5ahcl00qniiEqtx/GIXBSJYM8e+juf+gPm+cgxhSU8ej/f4tzai1lA==
X-Google-Smtp-Source: AGHT+IGpxFebHuPRrnrKutY6UaBRxHlLnZEUfA2P6Ez5usPEiMTlBTuYRNv1+Le8qQNmx8QM08We7VBz
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:6902:1101:b0:dc6:c2e4:5126 with SMTP id
 o1-20020a056902110100b00dc6c2e45126mr2359837ybu.12.1709551258241; Mon, 04 Mar
 2024 03:20:58 -0800 (PST)
Date: Mon,  4 Mar 2024 12:19:55 +0100
In-Reply-To: <20240304111937.2556102-20-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240304111937.2556102-20-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1102; i=ardb@kernel.org;
 h=from:subject; bh=3MvQwDOg8k0kEsWziCH2fXQbR+gICBNnYrHiUwxP/7c=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIfXpupiVE61FXquncPxOiU5UuxSl+c/iqveX3PqoDb6nO
 Ve4Z+h2lLIwiHEwyIopsgjM/vtu5+mJUrXOs2Rh5rAygQxh4OIUgInIrWFkWBV07CvDIw2lN1+3
 3IoRDmSoPxD+kk3GZX+YsYbWvO+ruRn+GbcsOsS4IaxzhtejhCWSn5adjmoW9px/0d9DX+lIoPs EFgA=
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240304111937.2556102-37-ardb+git@google.com>
Subject: [PATCH stable-v6.1 17/18] x86/boot: efistub: Assign global
 boot_params variable
From: Ard Biesheuvel <ardb+git@google.com>
To: stable@vger.kernel.org
Cc: linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>, 
	Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

[ Commit 50dcc2e0d62e3c4a54f39673c4dc3dcde7c74d52 upstream ]

Now that the x86 EFI stub calls into some APIs exposed by the
decompressor (e.g., kaslr_get_random_long()), it is necessary to ensure
that the global boot_params variable is set correctly before doing so.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/x86-stub.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index c1dcc86fcc3d..b183b40195ee 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -827,6 +827,8 @@ void __noreturn efi_stub_entry(efi_handle_t handle,
 	unsigned long kernel_entry;
 	efi_status_t status;
 
+	boot_params_ptr = boot_params;
+
 	efi_system_table = sys_table_arg;
 	/* Check if we were booted by the EFI firmware */
 	if (efi_system_table->hdr.signature != EFI_SYSTEM_TABLE_SIGNATURE)
-- 
2.44.0.278.ge034bb2e1d-goog


