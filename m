Return-Path: <linux-efi+bounces-4308-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E62EBB036A5
	for <lists+linux-efi@lfdr.de>; Mon, 14 Jul 2025 08:12:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23FDA3B01FE
	for <lists+linux-efi@lfdr.de>; Mon, 14 Jul 2025 06:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1458D2206AA;
	Mon, 14 Jul 2025 06:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BayMHYcG"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA6E5223DC0
	for <linux-efi@vger.kernel.org>; Mon, 14 Jul 2025 06:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752473468; cv=none; b=A3NHow17yZtAYrwSoez0S0gKyyBgPfr7PObInewAYq7OGDBbc4VbwnK9BWs+nWQZz+WXWN7Ok64lDsb22Ib7R/gXSewTWLCNKKg9UY30GSkpMQkl0BehtqHJRQqdemyfbKw/slf/ExedIJ+JKlf2bZDK3EwMEKdiO51fS/HY9g4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752473468; c=relaxed/simple;
	bh=o0jlk4akGmainIxV5Q+BPyj1VBWudU2LL5NaL17Oc4E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=n3vtEoX0a41drF1x/nwH7Y0civUo2A7GR3faoWt4MDpnEaK1G3o/cUMwQkighIUytdWoGU/UGvccUZgCX2w9qaz7lTDaPBScK2U3rNSxx6aZ8lEWhukA43DCz79Gbp8pXOIT+s1lV1qpjdARaacw7iMACkC8tnGuE2AhFagFcJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BayMHYcG; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-3a4f6ff23ccso2028670f8f.2
        for <linux-efi@vger.kernel.org>; Sun, 13 Jul 2025 23:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752473463; x=1753078263; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=U+Y2ODvkU1M3Yop4Vbyu4J7zT/gX9/QfE7MMpELx/ao=;
        b=BayMHYcGBxJ5mdnTNBnKiOUDQzgGWX2hp4Zds/9GbPEVuOkysUjrMtqUSWpvLgvc7Q
         736JqyDJFbwA3qJfE1eLTqFQmk9XbsNo5R0QUoQlMg/21lSwqVTClv3iXeotnbCtt6jN
         ljbT1CxlwQa2C5ahpr5QcLomn2eI5zQTgWB6xQb1pQ20eK6/Xyl/j2fMvnaR0XakOVHM
         DtoqZ9S9Tj60a9PNm2MbAjFtTJhjnSEUgfUmTStwtdbEbV5LDQN42gcLj7rJFbc5lSPt
         dGWoMyKfx3hvWKLLHhQzOJ00BU5dsSJBGiPln6OdgPaLlmqNpoWIOxEUDntfGSvf/T1z
         8/7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752473463; x=1753078263;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U+Y2ODvkU1M3Yop4Vbyu4J7zT/gX9/QfE7MMpELx/ao=;
        b=NuaibFN9oyzGm+uMwyZLwmta+fGR9Tf+AdoJKofvRrbPqPxVMlp7zy03G63LsVqu0f
         LnFmhtcq0AI8+B6y1sjFBknztN8f5J/StA7fyXV3XdSnItgUlRt9eheegBPXJO38tIl/
         EG23z0/PRDxkULHO878eUWpbStK3h1hG/h1eGB5lgl/H7OhinZqWxYgrlq5DM8zU6Ma7
         LMhSPYw5kCvT5zJzWeFRpeZTOMGb27U9zHBmLlliWpQljASM+/25s9B1vlt8ulsKIeuR
         OvJap9bUWg6NGN3eqVvIa72ojVadOyDMIHImHSmEvDpRfI9ysE/gb3FcJpXHwCgT+MpQ
         vgmQ==
X-Forwarded-Encrypted: i=1; AJvYcCUnil+tfp1yNg4OXdoLmMaM40Tnr0G6HjY/9HDGARARaN+DjDfW3t4KfawPBsZHUxqDiw26fuAxUEw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxIUvU5nKhT5184T4gzxM9l44zrC6OSLAyd449Z21vIWwfHJIk
	BhJWX9fysa0Zp0Ucy8HbEQ6NMu3B+URKXLen8Bm9nUjQNCEJ9jU1iXHnRLpMKYq+Dh45JEVOlg=
	=
X-Google-Smtp-Source: AGHT+IGX28n5QiyMHbS8lBZuZk7ytkYxLROV5L6i8XeWU2qCGkPvK5JXtsuwoSWms4DVodcgWH84OylK
X-Received: from wrpd13.prod.google.com ([2002:adf:f2cd:0:b0:3a5:7de1:2a54])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6000:2d03:b0:3b1:9259:3ead
 with SMTP id ffacd0b85a97d-3b5f188ea57mr7903902f8f.28.1752473463212; Sun, 13
 Jul 2025 23:11:03 -0700 (PDT)
Date: Mon, 14 Jul 2025 08:08:47 +0200
In-Reply-To: <20250714060843.4029171-5-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250714060843.4029171-5-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=10631; i=ardb@kernel.org;
 h=from:subject; bh=AM0I+cBVbRNRbkYjQz/D1G435xAIpZLDBEjL19MJg2w=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIaNk3r/ty443O28umjfLomTz8/SAuPdT3B3Omps26nft3
 bZh76H7HaUsDGJcDLJiiiwCs/++23l6olSt8yxZmDmsTCBDGLg4BWAiK6oZGboeRfLG+Ldu+j6J
 WUg46/ZEw41PP6Yf5ZxVHXwxuP9BnyUjw6wCn6md1VrPOid8avq4xaWe957uwZsiURsf/WZuDzM QZwIA
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250714060843.4029171-8-ardb+git@google.com>
Subject: [RFC PATCH 3/3] efi: Remove support for pointless, unused EFI services
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Ard Biesheuvel <ardb@kernel.org>, 
	Heinrich Schuchardt <heinrich.schuchardt@canonical.com>, Feng Tang <feng.tang@linux.alibaba.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Juergen Gross <jgross@suse.com>, 
	Stefano Stabellini <sstabellini@kernel.org>, 
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>, Sunil V L <sunilvl@ventanamicro.com>, 
	Bibo Mao <maobibo@loongson.cn>, linux-rtc@vger.kernel.org, linux-efi@vger.kernel.org, 
	xen-devel@lists.xenproject.org, x86@kernel.org, 
	linux-riscv@lists.infradead.org, loongarch@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

The get/set wakeup time EFI runtime services are often broken, and
rarely if ever used in practice. But the GetNextHighMonoCount() EFI
runtime services really takes the cake for most pointless API in the
history of computing.

So let's stop exposing them in Linux, hopefully removing the urge some
folks seem to feel to test these APIs, and send emails around when they
don't work.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/platform/efi/efi_64.c          | 22 -------
 drivers/firmware/efi/runtime-wrappers.c | 68 --------------------
 drivers/xen/efi.c                       | 56 ----------------
 include/linux/efi.h                     |  6 --
 4 files changed, 152 deletions(-)

diff --git a/arch/x86/platform/efi/efi_64.c b/arch/x86/platform/efi/efi_64.c
index e7e8f77f77f8..0207937ab39d 100644
--- a/arch/x86/platform/efi/efi_64.c
+++ b/arch/x86/platform/efi/efi_64.c
@@ -540,19 +540,6 @@ static efi_status_t efi_thunk_set_time(efi_time_t *tm)
 	return EFI_UNSUPPORTED;
 }
 
-static efi_status_t
-efi_thunk_get_wakeup_time(efi_bool_t *enabled, efi_bool_t *pending,
-			  efi_time_t *tm)
-{
-	return EFI_UNSUPPORTED;
-}
-
-static efi_status_t
-efi_thunk_set_wakeup_time(efi_bool_t enabled, efi_time_t *tm)
-{
-	return EFI_UNSUPPORTED;
-}
-
 static unsigned long efi_name_size(efi_char16_t *name)
 {
 	return ucs2_strsize(name, EFI_VAR_NAME_LEN) + 1;
@@ -681,12 +668,6 @@ efi_thunk_get_next_variable(unsigned long *name_size,
 	return status;
 }
 
-static efi_status_t
-efi_thunk_get_next_high_mono_count(u32 *count)
-{
-	return EFI_UNSUPPORTED;
-}
-
 static void
 efi_thunk_reset_system(int reset_type, efi_status_t status,
 		       unsigned long data_size, efi_char16_t *data)
@@ -788,13 +769,10 @@ void __init efi_thunk_runtime_setup(void)
 
 	efi.get_time = efi_thunk_get_time;
 	efi.set_time = efi_thunk_set_time;
-	efi.get_wakeup_time = efi_thunk_get_wakeup_time;
-	efi.set_wakeup_time = efi_thunk_set_wakeup_time;
 	efi.get_variable = efi_thunk_get_variable;
 	efi.get_next_variable = efi_thunk_get_next_variable;
 	efi.set_variable = efi_thunk_set_variable;
 	efi.set_variable_nonblocking = efi_thunk_set_variable_nonblocking;
-	efi.get_next_high_mono_count = efi_thunk_get_next_high_mono_count;
 	efi.reset_system = efi_thunk_reset_system;
 	efi.query_variable_info = efi_thunk_query_variable_info;
 	efi.query_variable_info_nonblocking = efi_thunk_query_variable_info_nonblocking;
diff --git a/drivers/firmware/efi/runtime-wrappers.c b/drivers/firmware/efi/runtime-wrappers.c
index 708b777857d3..2b66efb5ffef 100644
--- a/drivers/firmware/efi/runtime-wrappers.c
+++ b/drivers/firmware/efi/runtime-wrappers.c
@@ -52,17 +52,6 @@ union efi_rts_args {
 		efi_time_t	*time;
 	} SET_TIME;
 
-	struct {
-		efi_bool_t	*enabled;
-		efi_bool_t	*pending;
-		efi_time_t	*time;
-	} GET_WAKEUP_TIME;
-
-	struct {
-		efi_bool_t	enable;
-		efi_time_t	*time;
-	} SET_WAKEUP_TIME;
-
 	struct {
 		efi_char16_t	*name;
 		efi_guid_t	*vendor;
@@ -92,10 +81,6 @@ union efi_rts_args {
 		u64		*max_variable_size;
 	} QUERY_VARIABLE_INFO;
 
-	struct {
-		u32		*high_count;
-	} GET_NEXT_HIGH_MONO_COUNT;
-
 	struct {
 		efi_capsule_header_t **capsules;
 		unsigned long	count;
@@ -232,17 +217,6 @@ static void __nocfi efi_call_rts(struct work_struct *work)
 		status = efi_call_virt(set_time,
 				       args->SET_TIME.time);
 		break;
-	case EFI_GET_WAKEUP_TIME:
-		status = efi_call_virt(get_wakeup_time,
-				       args->GET_WAKEUP_TIME.enabled,
-				       args->GET_WAKEUP_TIME.pending,
-				       args->GET_WAKEUP_TIME.time);
-		break;
-	case EFI_SET_WAKEUP_TIME:
-		status = efi_call_virt(set_wakeup_time,
-				       args->SET_WAKEUP_TIME.enable,
-				       args->SET_WAKEUP_TIME.time);
-		break;
 	case EFI_GET_VARIABLE:
 		status = efi_call_virt(get_variable,
 				       args->GET_VARIABLE.name,
@@ -272,10 +246,6 @@ static void __nocfi efi_call_rts(struct work_struct *work)
 				       args->QUERY_VARIABLE_INFO.remaining_space,
 				       args->QUERY_VARIABLE_INFO.max_variable_size);
 		break;
-	case EFI_GET_NEXT_HIGH_MONO_COUNT:
-		status = efi_call_virt(get_next_high_mono_count,
-				       args->GET_NEXT_HIGH_MONO_COUNT.high_count);
-		break;
 	case EFI_UPDATE_CAPSULE:
 		status = efi_call_virt(update_capsule,
 				       args->UPDATE_CAPSULE.capsules,
@@ -366,30 +336,6 @@ static efi_status_t virt_efi_set_time(efi_time_t *tm)
 	return status;
 }
 
-static efi_status_t virt_efi_get_wakeup_time(efi_bool_t *enabled,
-					     efi_bool_t *pending,
-					     efi_time_t *tm)
-{
-	efi_status_t status;
-
-	if (down_interruptible(&efi_runtime_lock))
-		return EFI_ABORTED;
-	status = efi_queue_work(GET_WAKEUP_TIME, enabled, pending, tm);
-	up(&efi_runtime_lock);
-	return status;
-}
-
-static efi_status_t virt_efi_set_wakeup_time(efi_bool_t enabled, efi_time_t *tm)
-{
-	efi_status_t status;
-
-	if (down_interruptible(&efi_runtime_lock))
-		return EFI_ABORTED;
-	status = efi_queue_work(SET_WAKEUP_TIME, enabled, tm);
-	up(&efi_runtime_lock);
-	return status;
-}
-
 static efi_status_t virt_efi_get_variable(efi_char16_t *name,
 					  efi_guid_t *vendor,
 					  u32 *attr,
@@ -488,17 +434,6 @@ virt_efi_query_variable_info_nb(u32 attr, u64 *storage_space,
 	return status;
 }
 
-static efi_status_t virt_efi_get_next_high_mono_count(u32 *count)
-{
-	efi_status_t status;
-
-	if (down_interruptible(&efi_runtime_lock))
-		return EFI_ABORTED;
-	status = efi_queue_work(GET_NEXT_HIGH_MONO_COUNT, count);
-	up(&efi_runtime_lock);
-	return status;
-}
-
 static void __nocfi
 virt_efi_reset_system(int reset_type, efi_status_t status,
 		      unsigned long data_size, efi_char16_t *data)
@@ -556,13 +491,10 @@ void __init efi_native_runtime_setup(void)
 {
 	efi.get_time			    = virt_efi_get_time;
 	efi.set_time			    = virt_efi_set_time;
-	efi.get_wakeup_time		    = virt_efi_get_wakeup_time;
-	efi.set_wakeup_time		    = virt_efi_set_wakeup_time;
 	efi.get_variable		    = virt_efi_get_variable;
 	efi.get_next_variable		    = virt_efi_get_next_variable;
 	efi.set_variable		    = virt_efi_set_variable;
 	efi.set_variable_nonblocking	    = virt_efi_set_variable_nb;
-	efi.get_next_high_mono_count	    = virt_efi_get_next_high_mono_count;
 	efi.reset_system 		    = virt_efi_reset_system;
 	efi.query_variable_info		    = virt_efi_query_variable_info;
 	efi.query_variable_info_nonblocking = virt_efi_query_variable_info_nb;
diff --git a/drivers/xen/efi.c b/drivers/xen/efi.c
index fb321cd6415a..baccf2d90af0 100644
--- a/drivers/xen/efi.c
+++ b/drivers/xen/efi.c
@@ -76,47 +76,6 @@ static efi_status_t xen_efi_set_time(efi_time_t *tm)
 	return efi_data(op).status;
 }
 
-static efi_status_t xen_efi_get_wakeup_time(efi_bool_t *enabled,
-					    efi_bool_t *pending,
-					    efi_time_t *tm)
-{
-	struct xen_platform_op op = INIT_EFI_OP(get_wakeup_time);
-
-	if (HYPERVISOR_platform_op(&op) < 0)
-		return EFI_UNSUPPORTED;
-
-	if (tm) {
-		BUILD_BUG_ON(sizeof(*tm) != sizeof(efi_data(op).u.get_wakeup_time));
-		memcpy(tm, &efi_data(op).u.get_wakeup_time, sizeof(*tm));
-	}
-
-	if (enabled)
-		*enabled = !!(efi_data(op).misc & XEN_EFI_GET_WAKEUP_TIME_ENABLED);
-
-	if (pending)
-		*pending = !!(efi_data(op).misc & XEN_EFI_GET_WAKEUP_TIME_PENDING);
-
-	return efi_data(op).status;
-}
-
-static efi_status_t xen_efi_set_wakeup_time(efi_bool_t enabled, efi_time_t *tm)
-{
-	struct xen_platform_op op = INIT_EFI_OP(set_wakeup_time);
-
-	BUILD_BUG_ON(sizeof(*tm) != sizeof(efi_data(op).u.set_wakeup_time));
-	if (enabled)
-		efi_data(op).misc = XEN_EFI_SET_WAKEUP_TIME_ENABLE;
-	if (tm)
-		memcpy(&efi_data(op).u.set_wakeup_time, tm, sizeof(*tm));
-	else
-		efi_data(op).misc |= XEN_EFI_SET_WAKEUP_TIME_ENABLE_ONLY;
-
-	if (HYPERVISOR_platform_op(&op) < 0)
-		return EFI_UNSUPPORTED;
-
-	return efi_data(op).status;
-}
-
 static efi_status_t xen_efi_get_variable(efi_char16_t *name, efi_guid_t *vendor,
 					 u32 *attr, unsigned long *data_size,
 					 void *data)
@@ -204,18 +163,6 @@ static efi_status_t xen_efi_query_variable_info(u32 attr, u64 *storage_space,
 	return efi_data(op).status;
 }
 
-static efi_status_t xen_efi_get_next_high_mono_count(u32 *count)
-{
-	struct xen_platform_op op = INIT_EFI_OP(get_next_high_monotonic_count);
-
-	if (HYPERVISOR_platform_op(&op) < 0)
-		return EFI_UNSUPPORTED;
-
-	*count = efi_data(op).misc;
-
-	return efi_data(op).status;
-}
-
 static efi_status_t xen_efi_update_capsule(efi_capsule_header_t **capsules,
 				unsigned long count, unsigned long sg_list)
 {
@@ -280,8 +227,6 @@ void __init xen_efi_runtime_setup(void)
 {
 	efi.get_time			= xen_efi_get_time;
 	efi.set_time			= xen_efi_set_time;
-	efi.get_wakeup_time		= xen_efi_get_wakeup_time;
-	efi.set_wakeup_time		= xen_efi_set_wakeup_time;
 	efi.get_variable		= xen_efi_get_variable;
 	efi.get_next_variable		= xen_efi_get_next_variable;
 	efi.set_variable		= xen_efi_set_variable;
@@ -290,7 +235,6 @@ void __init xen_efi_runtime_setup(void)
 	efi.query_variable_info_nonblocking = xen_efi_query_variable_info;
 	efi.update_capsule		= xen_efi_update_capsule;
 	efi.query_capsule_caps		= xen_efi_query_capsule_caps;
-	efi.get_next_high_mono_count	= xen_efi_get_next_high_mono_count;
 	efi.reset_system		= xen_efi_reset_system;
 }
 
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 50db7df0efab..516afdc8a49d 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -650,8 +650,6 @@ extern struct efi {
 
 	efi_get_time_t			*get_time;
 	efi_set_time_t			*set_time;
-	efi_get_wakeup_time_t		*get_wakeup_time;
-	efi_set_wakeup_time_t		*set_wakeup_time;
 	efi_get_variable_t		*get_variable;
 	efi_get_next_variable_t		*get_next_variable;
 	efi_set_variable_t		*set_variable;
@@ -660,7 +658,6 @@ extern struct efi {
 	efi_query_variable_info_t	*query_variable_info_nonblocking;
 	efi_update_capsule_t		*update_capsule;
 	efi_query_capsule_caps_t	*query_capsule_caps;
-	efi_get_next_high_mono_count_t	*get_next_high_mono_count;
 	efi_reset_system_t		*reset_system;
 
 	struct efi_memory_map		memmap;
@@ -1235,13 +1232,10 @@ enum efi_rts_ids {
 	EFI_NONE,
 	EFI_GET_TIME,
 	EFI_SET_TIME,
-	EFI_GET_WAKEUP_TIME,
-	EFI_SET_WAKEUP_TIME,
 	EFI_GET_VARIABLE,
 	EFI_GET_NEXT_VARIABLE,
 	EFI_SET_VARIABLE,
 	EFI_QUERY_VARIABLE_INFO,
-	EFI_GET_NEXT_HIGH_MONO_COUNT,
 	EFI_RESET_SYSTEM,
 	EFI_UPDATE_CAPSULE,
 	EFI_QUERY_CAPSULE_CAPS,
-- 
2.50.0.727.gbf7dc18ff4-goog


