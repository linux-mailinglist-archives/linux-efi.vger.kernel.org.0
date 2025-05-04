Return-Path: <linux-efi+bounces-3566-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CB0EAA85BA
	for <lists+linux-efi@lfdr.de>; Sun,  4 May 2025 11:56:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5833189A4A3
	for <lists+linux-efi@lfdr.de>; Sun,  4 May 2025 09:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 604B61E51E5;
	Sun,  4 May 2025 09:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k/RUd3+N"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7CF1E5B7C
	for <linux-efi@vger.kernel.org>; Sun,  4 May 2025 09:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746352419; cv=none; b=cu4eUKCU7aWFsfv3Ed9M3jtcUG+UkfMlckeDPb+ijT/YDKRmAnibUtLgOkblQ27oEh76VChPWajtyw2lnY6YBQUMDRWaCGIvDlbKGahCFealf20bPY0/zTjkyolJ9ep/3MHmS276PJk5CjG6bwUSKO6w5Vy27imeosBlMICL1i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746352419; c=relaxed/simple;
	bh=ZBSTtuc/SHZrCynYqyN5o0yl/kE4GBgwDpGzNrdh3Pg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eWfLTSky1S/a5TAtzTLCA5ggNYZQgvzJXHTaa24XD+aXwrZXY5infCx2qgIE6BLZdYhbPpmnXj5W8+saxhw5rN2W34LuN7eo/oxujfMFXNGQl7bhzTpZ34c8dKoDxpeffGwZnhDMIfgujqbFraJ02rJ3MHOgrKpL9+QKmTiyhUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k/RUd3+N; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-39131f2bbe5so1040627f8f.3
        for <linux-efi@vger.kernel.org>; Sun, 04 May 2025 02:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746352416; x=1746957216; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vtMDjkMYmNedwHhZa0cXr3HfTQY0/WG8XydWhWIUIFo=;
        b=k/RUd3+NhBz1j0jvxXZIyfL0pYq3mcMWW6llztqWOHN1RLyic6mWSg+ZygvoqUhYgG
         Tb7EzAaTQYTih8IXXHvSYNkX57TLF349t+9I90ILke9grERwg0ogqR78/1rAU6lmPdQk
         AW8a56CCKd3HK1OlguyW/9jh0ilEzE+soVuJG07hTFqxx9J59G0G3AANrsHs+jKFATaa
         YQHAbEGNAdrOd5r2DI5PAuFLRLUp7KnSV7LOFq8sj08X81kbYJUY2UIHq/20NuLMkSX5
         pxEYx3Q7meleZbacl2S4pTYZYlzzvHtITRdLhHkFt5dMKj8QSesvbfhFYfviIJHE7JJn
         CBkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746352416; x=1746957216;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vtMDjkMYmNedwHhZa0cXr3HfTQY0/WG8XydWhWIUIFo=;
        b=eZd3sWjBHZrIUa4YOg4ZDL75EtL4FnJlGulc8YZUPhrz4XkSMBpRFoz97QvMGqBbR5
         tUGXZmhpeqB5gu8lYuQoHR/LTyXxMDDjon9lDg4OAoYK23rPU/u9bX7qy2ECAtABc4H8
         tG77V94lrs2/rjwL5MsAUBzNgDubU4WkS85cPeOaBYiNu5hwJ+DG+2KUge/u2EmRjpOD
         2DD2BoRKbg7JLWsMvY0Fzq5wwK4WAKIEs3SGPSLPkXzBCPhXUMxNCHmjXMIlQMoNx+FW
         HLy/IfEJSe1diVrXE3bGJfLWRESdQjUauXPiRw4YvZ/FVEqmBJwzrtNJuMcX2HW1xPVL
         /Jnw==
X-Gm-Message-State: AOJu0YxThxJ4XqRf+dEaaUcVEvGqGPkmi49xiAoH8Yjmpqk8ecrEfdHX
	/oW7/M15kT7EBYCygXik0BEyXiBpKAgQ8jAk+H6oflpI8KZvWimsWbLUdvJsMnFMcwuKDA==
X-Google-Smtp-Source: AGHT+IHzM9sbmgfFD5bqalsjiElI995bcq0K3rL9cQY0mQCUn5LiV79+CyQPKzABCIynM/3ZCgU5uMRJ
X-Received: from wmbfl15.prod.google.com ([2002:a05:600c:b8f:b0:441:b38b:9cc3])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6000:40e1:b0:3a0:9dd8:4ba7
 with SMTP id ffacd0b85a97d-3a09fdd8438mr2913867f8f.52.1746352415647; Sun, 04
 May 2025 02:53:35 -0700 (PDT)
Date: Sun,  4 May 2025 11:52:45 +0200
In-Reply-To: <20250504095230.2932860-25-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250504095230.2932860-25-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1393; i=ardb@kernel.org;
 h=from:subject; bh=jNeHtJDyRJuUYx7C5oayW7yyMKmGvkftnluPCF2j4+Q=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIUPc4lOksVvdH1ZJ/7h68fyVr9wDQudmxb6pm5Vi17/r8
 p80u1kdpSwMYhwMsmKKLAKz/77beXqiVK3zLFmYOaxMIEMYuDgFYCKSnAz/rC/c3Xm/NK0kNDep
 kpc7yjN026x34Umi9g26j2q/RpzZAVQhxp5Zmf8hMvDjDn6e5yr5grVLeXlqlTe86X6guuvTQ2Y A
X-Mailer: git-send-email 2.49.0.906.g1f30a19c02-goog
Message-ID: <20250504095230.2932860-40-ardb+git@google.com>
Subject: [RFT PATCH v2 15/23] x86/boot: Provide __pti_set_user_pgtbl() to
 startup code
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: linux-efi@vger.kernel.org, x86@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>, 
	Dionna Amalie Glaze <dionnaglaze@google.com>, Kevin Loughlin <kevinloughlin@google.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

The SME encryption startup code populates page tables using the ordinary
set_pXX() helpers, and in a PTI build, these will call out to
__pti_set_user_pgtbl() to manipulate the shadow copy of the page tables
for user space.

This is unneeded for the startup code, which only manipulates the
swapper page tables, and so this call could be avoided in this
particular case. So instead of exposing the ordinary
__pti_set_user_pgtblt() to the startup code after its gets confined into
its own symbol space, provide an alternative which just returns pgd,
which is always correct in the startup context.

Annotate it as __weak for now, this will be dropped in a subsequent
patch.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/startup/sme.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/x86/boot/startup/sme.c b/arch/x86/boot/startup/sme.c
index 7fc6a689cefe..1e9f1f5a753c 100644
--- a/arch/x86/boot/startup/sme.c
+++ b/arch/x86/boot/startup/sme.c
@@ -557,3 +557,12 @@ void __head sme_enable(struct boot_params *bp)
 	cc_vendor	= CC_VENDOR_AMD;
 	cc_set_mask(me_mask);
 }
+
+#ifdef CONFIG_MITIGATION_PAGE_TABLE_ISOLATION
+/* Local version for startup code, which never operates on user page tables */
+__weak
+pgd_t __pti_set_user_pgtbl(pgd_t *pgdp, pgd_t pgd)
+{
+	return pgd;
+}
+#endif
-- 
2.49.0.906.g1f30a19c02-goog


