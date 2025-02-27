Return-Path: <linux-efi+bounces-2848-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D301A47DF1
	for <lists+linux-efi@lfdr.de>; Thu, 27 Feb 2025 13:38:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F7241892B2E
	for <lists+linux-efi@lfdr.de>; Thu, 27 Feb 2025 12:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67D8C1991CD;
	Thu, 27 Feb 2025 12:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="ZrvAcelT"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1FBE22F178
	for <linux-efi@vger.kernel.org>; Thu, 27 Feb 2025 12:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740659832; cv=none; b=fWQPfbSMAXN1DgZ11l9Xgy1TJpICoZS7qDd9JgGzMwOKSoJa9RH6yNr5QUOOGo6oTPqFpAxezb9K2UDRUtKcBlg2j4oDQqr2q0oTrwCnAro/OKNP9oBru9f1vwzSMq54Bs3bPygVwx3WQB4felMLVnZWcV0rgkhrFZRH9hWugbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740659832; c=relaxed/simple;
	bh=4VsOHzcXdPVrZvK5H8lPHWXGnI2bcbkoNfx5bjphVFI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hs4DSvTHgen5K/BD/SCudR2jS5fqzrdmevWNDVqUfn1jTFyANJbIBzMCghO8l/jBLR0beQ0ivayBj/z0hEZH0aiUXvRxLc4wYscgyDU7nQ5vKYViDYv52WXW4zYmDdG/JMzT3ZMVJ7mERL16P3nStdZy8yDXxYNjzq1ex87aZHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=ZrvAcelT; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2212a930001so21337945ad.0
        for <linux-efi@vger.kernel.org>; Thu, 27 Feb 2025 04:37:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1740659830; x=1741264630; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3kGyolrr9eB+rihlUpak7d80WkLbYEDuFsdAvhSOlWk=;
        b=ZrvAcelTMkYQrfIW/FYMbl4uaDrQX69qwzbggJfFMqEQiRohCpThtuTQ8X0Sa8Ch4v
         zc6L/1W9KD5jpvZf6tirzetIFdQVNoTCdevI4TNvPlCgEYEqVB51+84x68I+i1Ph9ceY
         SGGRzQN9Bfd9D/TY0yDj5JYPO+NMfN3NhQwozfzGx8AstJHrAHp/Hmt116W3A+6tVy9Z
         CqDtw8UYzElJC9dOUYUDpzlCXQKPVX0bmH21FAkY7ttCAHlyhDwO3QGRuP9UGJQcgbhC
         IRtFBaxri7fMRoLk09cR4qeF9qPLwDLnbSdmW5OS00ViInfV1u10//fsRNrcpvJm8v9s
         0YlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740659830; x=1741264630;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3kGyolrr9eB+rihlUpak7d80WkLbYEDuFsdAvhSOlWk=;
        b=bGz+m2Ev3BWWJ5farw58ADnojbO1/f1GNmhqlC1TWE8JITjeQpbDFwaBqJpSaLJYOb
         JCXSyiQuH0MKiF0Crb2rp6AmccQTAj0ErWy84PfEMTuK31a9loMfaDl5U0qAEBHmrBkC
         z4gByKinWhIXloKoh1l7JDDtROjpYIjTWcWkjnKhRwKOio+oYVFl7yCsGTMqo//IiNRs
         j0Ad0Zh4p1vzqRWjOA/p9KKeALFFafQccSoZjLZvnyv5nIo49wJzujIR+5WY9ORkjqch
         pIfxDXMnRBpq2vraHXuoW5VYIRv0wq0CDczmSYEATiL57J15LwBgc++njwOWTbcdEVHY
         DeaA==
X-Forwarded-Encrypted: i=1; AJvYcCXPMMNLa4m87t2CS6C6us+OOY/Lsx3PVROqismPyASobJUTHlFz89GjW6h5snYbWGIeFyLn6fehixk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMU403lY2j0OYw++lUV1RTkbQy2KKEDZLGIKqmcwYnRKkfIsTy
	vv2I6OEq9J2Shxp94Sewh7It9g8P2qMV6TnpknVMKilYmj81p2aXhylAUWoNKtI=
X-Gm-Gg: ASbGncs7xgJrQb3uuqMVIazZyPuXjDp70DOk7UUV7up/G4DcaqHmRrBWyI2zO0sTO2R
	8zsurvaerEftL79cNSTsaJo6NPyYZGIS8dmvxVYnBEnnbUN4yEgubuwfbXlgInw2IZO5YDA0S28
	VSyD9DqwleWCKD3vEc3x9VbJiGMh94jdzt3Gvj3SqpQGAolDAV5auQyBK10MsUjPWPGtyC0mqpg
	KspM4DDVN0kqIJQDYX8QIheADtnZe4Mo5iCbetxWsliMY9MjvQW0hkqXOHyMQMCE7D18SezQp2u
	d4F1AlI8qROT7YiU2vMu9iktF0G6gFg3v+2k
X-Google-Smtp-Source: AGHT+IGCecOAkzBb0oLJqkAuzU2vtPXYUZlAY6MApfNhCwxjDIHSb/IyUg2/UngOj1IqUQZUagR0Tg==
X-Received: by 2002:a17:902:daca:b0:220:c164:6ee1 with SMTP id d9443c01a7336-221a1148bdcmr409969065ad.32.1740659829813;
        Thu, 27 Feb 2025 04:37:09 -0800 (PST)
Received: from ventana-bhyve.. ([49.37.249.43])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223504c5bddsm13219135ad.140.2025.02.27.04.37.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 04:37:09 -0800 (PST)
From: Himanshu Chauhan <hchauhan@ventanamicro.com>
To: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-efi@vger.kernel.org,
	acpica-devel@lists.linux.dev
Cc: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	lenb@kernel.org,
	james.morse@arm.com,
	tony.luck@intel.com,
	ardb@kernel.org,
	conor@kernel.org,
	cleger@rivosinc.com,
	robert.moore@intel.com,
	sunilvl@ventanamicro.com,
	apatel@ventanamicro.com,
	Himanshu Chauhan <hchauhan@ventanamicro.com>
Subject: [RFC PATCH v1 06/10] riscv: Add functions to register ghes having SSE notification
Date: Thu, 27 Feb 2025 18:06:24 +0530
Message-ID: <20250227123628.2931490-7-hchauhan@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250227123628.2931490-1-hchauhan@ventanamicro.com>
References: <20250227123628.2931490-1-hchauhan@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add functions to register the ghes entries which have SSE as
notification type. The vector inside the ghes is the SSE event
ID that should be registered.

Signed-off-by: Himanshu Chauhan <hchauhan@ventanamicro.com>
---
 drivers/firmware/riscv/riscv_sse.c | 147 +++++++++++++++++++++++++++++
 include/linux/riscv_sse.h          |  15 +++
 2 files changed, 162 insertions(+)

diff --git a/drivers/firmware/riscv/riscv_sse.c b/drivers/firmware/riscv/riscv_sse.c
index c165e32cc9a5..511db9ad7a9e 100644
--- a/drivers/firmware/riscv/riscv_sse.c
+++ b/drivers/firmware/riscv/riscv_sse.c
@@ -5,6 +5,8 @@
 
 #define pr_fmt(fmt) "sse: " fmt
 
+#include <acpi/ghes.h>
+#include <linux/acpi.h>
 #include <linux/cpu.h>
 #include <linux/cpuhotplug.h>
 #include <linux/cpu_pm.h>
@@ -689,3 +691,148 @@ static int __init sse_init(void)
 	return ret;
 }
 arch_initcall(sse_init);
+
+struct sse_ghes_callback {
+	struct list_head head;
+	struct ghes *ghes;
+	sse_event_handler *callback;
+};
+
+struct sse_ghes_event_data {
+	struct list_head head;
+	u32 event_num;
+	struct list_head callback_list;
+	struct sse_event *event;
+};
+
+static DEFINE_SPINLOCK(sse_ghes_event_list_lock);
+static LIST_HEAD(sse_ghes_event_list);
+
+static int sse_ghes_handler(u32 event_num, void *arg, struct pt_regs *regs)
+{
+	struct sse_ghes_event_data *ev_data = arg;
+	struct sse_ghes_callback *cb = NULL;
+
+	list_for_each_entry(cb, &ev_data->callback_list, head) {
+		if (cb && cb->ghes && cb->callback) {
+			cb->callback(ev_data->event_num, cb->ghes, regs);
+		}
+	}
+
+	return 0;
+}
+
+int sse_register_ghes(struct ghes *ghes, sse_event_handler *lo_cb,
+		      sse_event_handler *hi_cb)
+{
+	struct sse_ghes_event_data *ev_data, *evd;
+	struct sse_ghes_callback *cb;
+	u32 ev_num;
+	int err;
+
+	if (!sse_available)
+		return -EOPNOTSUPP;
+	if (!ghes || !lo_cb || !hi_cb)
+		return -EINVAL;
+
+	ev_num = ghes->generic->notify.vector;
+
+	ev_data = NULL;
+	spin_lock(&sse_ghes_event_list_lock);
+	list_for_each_entry(evd, &sse_ghes_event_list, head) {
+		if (evd->event_num == ev_num) {
+			ev_data = evd;
+			break;
+		}
+	}
+	spin_unlock(&sse_ghes_event_list_lock);
+
+	if (!ev_data) {
+		ev_data = kzalloc(sizeof(*ev_data), GFP_KERNEL);
+		if (!ev_data)
+			return -ENOMEM;
+
+		INIT_LIST_HEAD(&ev_data->head);
+		ev_data->event_num = ev_num;
+
+		INIT_LIST_HEAD(&ev_data->callback_list);
+
+		ev_data->event = sse_event_register(ev_num, ev_num,
+						    sse_ghes_handler, ev_data);
+		if (IS_ERR(ev_data->event)) {
+			pr_err("%s: Couldn't register event 0x%x\n", __func__, ev_num);
+			kfree(ev_data);
+			return -ENOMEM;
+		}
+
+		err = sse_event_enable(ev_data->event);
+		if (err) {
+			pr_err("%s: Couldn't enable event 0x%x\n", __func__, ev_num);
+			sse_event_unregister(ev_data->event);
+			kfree(ev_data);
+			return err;
+		}
+
+		spin_lock(&sse_ghes_event_list_lock);
+		list_add_tail(&ev_data->head, &sse_ghes_event_list);
+		spin_unlock(&sse_ghes_event_list_lock);
+	}
+
+	list_for_each_entry(cb, &ev_data->callback_list, head) {
+		if (cb->ghes == ghes)
+			return -EALREADY;
+	}
+
+	cb = kzalloc(sizeof(*cb), GFP_KERNEL);
+	if (!cb)
+		return -ENOMEM;
+	INIT_LIST_HEAD(&cb->head);
+	cb->ghes = ghes;
+	cb->callback = lo_cb;
+	list_add_tail(&cb->head, &ev_data->callback_list);
+
+	return 0;
+}
+
+int sse_unregister_ghes(struct ghes *ghes)
+{
+	struct sse_ghes_event_data *ev_data, *tmp;
+	struct sse_ghes_callback *cb;
+	int free_ev_data = 0;
+
+	if (!ghes)
+		return -EINVAL;
+
+	spin_lock(&sse_ghes_event_list_lock);
+
+	list_for_each_entry_safe(ev_data, tmp, &sse_ghes_event_list, head) {
+		list_for_each_entry(cb, &ev_data->callback_list, head) {
+			if (cb->ghes != ghes)
+				continue;
+
+			list_del(&cb->head);
+			kfree(cb);
+			break;
+		}
+
+		if (list_empty(&ev_data->callback_list))
+			free_ev_data = 1;
+
+		if (free_ev_data) {
+			spin_unlock(&sse_ghes_event_list_lock);
+
+			sse_event_disable(ev_data->event);
+			sse_event_unregister(ev_data->event);
+			ev_data->event = NULL;
+
+			spin_lock(&sse_ghes_event_list_lock);
+
+			list_del(&ev_data->head);
+			kfree(ev_data);
+		}
+	}
+
+	spin_unlock(&sse_ghes_event_list_lock);
+
+	return 0;
+}
diff --git a/include/linux/riscv_sse.h b/include/linux/riscv_sse.h
index c73184074b8c..16700677f1e8 100644
--- a/include/linux/riscv_sse.h
+++ b/include/linux/riscv_sse.h
@@ -12,6 +12,8 @@
 struct sse_event;
 struct pt_regs;
 
+struct ghes;
+
 typedef int (sse_event_handler)(u32 event_num, void *arg, struct pt_regs *regs);
 
 #ifdef CONFIG_RISCV_SSE
@@ -27,6 +29,9 @@ int sse_event_enable(struct sse_event *sse_evt);
 
 void sse_event_disable(struct sse_event *sse_evt);
 
+int sse_register_ghes(struct ghes *ghes, sse_event_handler *lo_cb,
+		      sse_event_handler *hi_cb);
+int sse_unregister_ghes(struct ghes *ghes);
 #else
 static inline struct sse_event *sse_event_register(u32 event_num, u32 priority,
 						   sse_event_handler *handler,
@@ -50,6 +55,16 @@ static inline int sse_event_enable(struct sse_event *sse_evt)
 
 static inline void sse_event_disable(struct sse_event *sse_evt) {}
 
+static inline int sse_register_ghes(struct ghes *ghes, sse_event_handler *lo_cb,
+				    sse_event_handler *hi_cb)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int sse_unregister_ghes(struct ghes *ghes)
+{
+	return -EOPNOTSUPP;
+}
 
 #endif
 
-- 
2.43.0


