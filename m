Return-Path: <linux-efi+bounces-4026-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E5D1AEA964
	for <lists+linux-efi@lfdr.de>; Fri, 27 Jun 2025 00:13:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F0F417752F
	for <lists+linux-efi@lfdr.de>; Thu, 26 Jun 2025 22:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 405BE26157E;
	Thu, 26 Jun 2025 22:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Jy7+xLaS"
X-Original-To: linux-efi@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C832B2609CC;
	Thu, 26 Jun 2025 22:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750975982; cv=none; b=Y9Wj/cCz/Ogo5aUwto/pKskVci5mIcvts8XggxkPYPsjGyzxZsBKj8M/IOQ4WbpT/jfSRtRZlKQo1AylQ+dEGy15t64XhnAe9ZM4XgLO2/Wlhcu3yfKATOv9Wo9LF4b4ZwFOfT/O3ypZ9lpp4SUz6NlPDY/QrUYqP8+UtxZb25w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750975982; c=relaxed/simple;
	bh=SrkNd0XPfMFt6NKeyZsG845R5t7Zg/brpnKvdgY8350=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=fLSVbVYekT9+t1uDHEydM4IXIjj0rFWOSfkQCeV6zJPhzEmm2qVFZ3grTMuPj11xQ6mGB1NvgpeIg6G/GN6RPgUdDQMrArCBBAGbxwNy//HCgT4hUY4TNJfg/y3lbu5NI/FnlXtcbA/b7Q2f8i0590xD9tA/Mt2qluiptg1X++E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Jy7+xLaS; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1216)
	id 728E621176C3; Thu, 26 Jun 2025 15:12:54 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 728E621176C3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1750975974;
	bh=CTILoh0uB4sk9KuAG9w2F8VChY2gSFYEW7vcy4BQ3Cs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Jy7+xLaS4y81LfjG3tNuE68j5L56HZGz1/YFOGTKbQKA9C+iFovGbFsxO7NHU9V2J
	 r4oY+5dE2r8C3A1/LbYaw+jEOAzv4KqeB7MzsQxTPsWwB6GpJirdTwsppoMErxd+m8
	 8n07FVt3YaM02Kpb5Zf0OE3y0ZJkfkIGFHwfs+ao=
From: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
To: linux-kernel@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Yue Haibing <yuehaibing@huawei.com>,
	Tanya Agarwal <tanyaagarwal25699@gmail.com>,
	Kees Cook <kees@kernel.org>,
	linux-efi@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
Subject: [PATCH 1/2] security: introduce security_lock_kernel_down()
Date: Thu, 26 Jun 2025 15:10:38 -0700
Message-Id: <1750975839-32463-2-git-send-email-hamzamahfooz@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1750975839-32463-1-git-send-email-hamzamahfooz@linux.microsoft.com>
References: <1750975839-32463-1-git-send-email-hamzamahfooz@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>

Define and export security_lock_kernel_down(), so that we can lock down
the kernel from other parts of the kernel.

Signed-off-by: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
---
 include/linux/lsm_hook_defs.h |  1 +
 include/linux/security.h      |  8 ++++++++
 security/lockdown/lockdown.c  |  1 +
 security/security.c           | 15 +++++++++++++++
 4 files changed, 25 insertions(+)

diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index bf3bbac4e02a..08ffd103c863 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -442,6 +442,7 @@ LSM_HOOK(int, 0, bpf_token_cmd, const struct bpf_token *token, enum bpf_cmd cmd)
 LSM_HOOK(int, 0, bpf_token_capable, const struct bpf_token *token, int cap)
 #endif /* CONFIG_BPF_SYSCALL */
 
+LSM_HOOK(int, 0, lock_down, const char *where, enum lockdown_reason level)
 LSM_HOOK(int, 0, locked_down, enum lockdown_reason what)
 
 #ifdef CONFIG_PERF_EVENTS
diff --git a/include/linux/security.h b/include/linux/security.h
index cc9b54d95d22..373f8dd2a265 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -573,6 +573,7 @@ void security_inode_invalidate_secctx(struct inode *inode);
 int security_inode_notifysecctx(struct inode *inode, void *ctx, u32 ctxlen);
 int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen);
 int security_inode_getsecctx(struct inode *inode, struct lsm_context *cp);
+int security_lock_kernel_down(const char *where, enum lockdown_reason level);
 int security_locked_down(enum lockdown_reason what);
 int lsm_fill_user_ctx(struct lsm_ctx __user *uctx, u32 *uctx_len,
 		      void *val, size_t val_len, u64 id, u64 flags);
@@ -1576,6 +1577,13 @@ static inline int security_inode_getsecctx(struct inode *inode,
 {
 	return -EOPNOTSUPP;
 }
+
+static inline int security_lock_kernel_down(const char *where,
+					    enum lockdown_reason level)
+{
+    return -EOPNOTSUPP;
+}
+
 static inline int security_locked_down(enum lockdown_reason what)
 {
 	return 0;
diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
index cf83afa1d879..3839a62c2c17 100644
--- a/security/lockdown/lockdown.c
+++ b/security/lockdown/lockdown.c
@@ -73,6 +73,7 @@ static int lockdown_is_locked_down(enum lockdown_reason what)
 }
 
 static struct security_hook_list lockdown_hooks[] __ro_after_init = {
+	LSM_HOOK_INIT(lock_down, lock_kernel_down),
 	LSM_HOOK_INIT(locked_down, lockdown_is_locked_down),
 };
 
diff --git a/security/security.c b/security/security.c
index fb57e8fddd91..51fbe8124388 100644
--- a/security/security.c
+++ b/security/security.c
@@ -5789,6 +5789,21 @@ void security_bpf_token_free(struct bpf_token *token)
 }
 #endif /* CONFIG_BPF_SYSCALL */
 
+/**
+ * security_lock_kernel_down() - Lock down the kernel
+ * @where: the location from where the lock down is being initiated
+ * @level: requested lock down level
+ *
+ * Attempt to lock down the kernel at the requested level.
+ *
+ * Return: Returns 0 on success, error on failure.
+ */
+int security_lock_kernel_down(const char *where, enum lockdown_reason level)
+{
+	return call_int_hook(lock_down, where, level);
+}
+EXPORT_SYMBOL(security_lock_kernel_down);
+
 /**
  * security_locked_down() - Check if a kernel feature is allowed
  * @what: requested kernel feature
-- 
2.49.0


