Return-Path: <linux-efi+bounces-4937-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77853B9AA61
	for <lists+linux-efi@lfdr.de>; Wed, 24 Sep 2025 17:30:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9461C1BC0D8E
	for <lists+linux-efi@lfdr.de>; Wed, 24 Sep 2025 15:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4C9B30FF13;
	Wed, 24 Sep 2025 15:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZLITzbtE"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0CFE30E830
	for <linux-efi@vger.kernel.org>; Wed, 24 Sep 2025 15:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758727649; cv=none; b=lwKdoF+3nkTXAAuWloFhsoqJvgjH2+wYeNulJUVc9oEBGAJdjSSCTVrsjfk2SpJBLIBUKwV2uzZV4U7S8IxnF8OghIRDcI3SjoBSPVlH561ZEJfDa/srOCVnM9JIal3lCmxwyTRbtAAP3B9W9kEGoK9dQf4Eoab4ktCecxrAgbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758727649; c=relaxed/simple;
	bh=a7tVQStslwAHx6kkGqhgIP6cKTCoEwcRZomLtv4AIzU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=o65Rk1cOiYIqkU9Sa0yk46YHwlr8bgUkgyl71xSvecK8pvfNnQnYiY0CnfxWA9Pk5oIvtnRqMEbuqXWDYhKqflzfIHgr8v9DmrMZ9rLrAOf94eRwqif7cTdnKFFndhB6+JVgnS8tunJUpXiu9/n2KG/lOYOJNjOKV6fKU4WcL1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZLITzbtE; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-3ee130237e1so8437f8f.0
        for <linux-efi@vger.kernel.org>; Wed, 24 Sep 2025 08:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758727646; x=1759332446; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1Dq6c0ZGM/PcmsQNtaG9zqEgKMUiGLsTw4kpN5BfNGA=;
        b=ZLITzbtE0Gp/hC/Ni7iW7Hf8tOLefyVYuZWfVot3G3BpRYC0D+KtHKR3lkKe9Byblo
         Z1HLCi40o1tHJo/JAHRD0D/usbhR/9+18KEBL6i0/s/4zK+TClrbpbPg8rG/p+g8+Ajn
         lEeepL5Ay3ZiKCpNqcCxlXH/fusml/CpXS/mFYxOhVrx/IUZD6P6zPuBc5VamOiWODA+
         zs7zZ0FSc2RgryMEQ7ocXQJJmAK0soFv1blt3Pze/YWoCmZEi2NIwQZ0vHHPtRXT7qI+
         aT46fXynOtOvkDq76oFhARtA3g8IzQx12PSEM+lMw8+fI8iXBu6ijBO+6YD5njl2LVn8
         /kFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758727646; x=1759332446;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1Dq6c0ZGM/PcmsQNtaG9zqEgKMUiGLsTw4kpN5BfNGA=;
        b=hw/SLwqexqiSgKf/5YgA2NzA7JiK6WRqPlykP8qt1UXb77HlyliepQAWpLuXg4UTl9
         bfEcS5Igfuz8oYuaNc2F6HSsNnN1zTSaUP85YkT/9pCPfuMuEe7fq/X/Q1Jr2EUuI7iX
         KIh9oly5Mh0ZdB9rwlLQH1HJkUJBaJRpPATFYn3aHVGDrQfTv3mlnq1at0iJyhZpMLZ1
         T/kp3XQqR5DdkAOLMav4GxYxhV7QW6wHMw6XB0vgddgt6a8/Jf8F/ph1njGHQwHeNuoo
         NSxL1Evfkm7pkQ3i1JBjjvc5/lEkLTY1jXMcBALQN5Y/3h7HQzYX+gMz5CGJ3rUFbUtv
         fL3g==
X-Gm-Message-State: AOJu0YyKZ0gvK2BXtmt/ITJWggwBprZWuMS9JeYMdleWV8K3inqiNMZd
	jG1eCGlxG9RJGXqinJgXQc+VanJmr8bwxY4FwFrdZ9hQMTINPDAp1OaKvC4ThNawFAIIahUux+n
	jDp4EFa3nNd7dAEBjwiZrF6hhqGb8208l+aRXTGo+2wihFvJxD6l7SGFNZxstPgwLLXwVw37iLa
	v2divCT4dnhDGZwyG6COYqqy/cA6da1Q==
X-Google-Smtp-Source: AGHT+IFEdA9MBtNZtoCuFX5LdOx2I1XqFRDSTgfNjpmBTAhcuyQh7YpEfjehwPy3DZrnvKS1vcvIWvse
X-Received: from wmbjh7.prod.google.com ([2002:a05:600c:a087:b0:46e:297b:900c])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6000:3105:b0:3fb:9950:b9fe
 with SMTP id ffacd0b85a97d-40e48a56cb5mr294011f8f.47.1758727646359; Wed, 24
 Sep 2025 08:27:26 -0700 (PDT)
Date: Wed, 24 Sep 2025 17:26:53 +0200
In-Reply-To: <20250924152651.3328941-9-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250924152651.3328941-9-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=804; i=ardb@kernel.org;
 h=from:subject; bh=430ZoAUsLaGRjbsT1dmBVnqyeLcQQst70F5MXr1Sm+A=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIeMK7z6nI8LhS+KvvXC853dwu7jtO5brkVs70ndXeG6Yv
 rXK/Ix1RykLgxgXg6yYIovA7L/vdp6eKFXrPEsWZg4rE8gQBi5OAZjIa26G/yWXNv/sbD8Uoucg
 ty7/un116hFW7Wlba/s7MmdmlUyx52Zk+Of3+/+aar6yKRzC6q1PleeeyW3mjxAXDDNldw7Z1bW UFwA=
X-Mailer: git-send-email 2.51.0.534.gc79095c0ca-goog
Message-ID: <20250924152651.3328941-10-ardb+git@google.com>
Subject: [PATCH v4 1/7] efi: Add missing static initializer for efi_mm::cpus_allowed_lock
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-efi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Ard Biesheuvel <ardb@kernel.org>, Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Mark Brown <broonie@kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Initialize the cpus_allowed_lock struct member of efi_mm.

Cc: <stable@vger.kernel.org>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/efi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 1ce428e2ac8a..fc407d891348 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -74,6 +74,9 @@ struct mm_struct efi_mm = {
 	.page_table_lock	= __SPIN_LOCK_UNLOCKED(efi_mm.page_table_lock),
 	.mmlist			= LIST_HEAD_INIT(efi_mm.mmlist),
 	.cpu_bitmap		= { [BITS_TO_LONGS(NR_CPUS)] = 0},
+#ifdef CONFIG_SCHED_MM_CID
+	.cpus_allowed_lock	= __RAW_SPIN_LOCK_UNLOCKED(efi_mm.cpus_allowed_lock),
+#endif
 };
 
 struct workqueue_struct *efi_rts_wq;
-- 
2.51.0.534.gc79095c0ca-goog


