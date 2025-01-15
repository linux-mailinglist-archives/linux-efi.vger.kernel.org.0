Return-Path: <linux-efi+bounces-2634-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 534CCA125B3
	for <lists+linux-efi@lfdr.de>; Wed, 15 Jan 2025 15:15:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7757D188900E
	for <lists+linux-efi@lfdr.de>; Wed, 15 Jan 2025 14:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EC4924A7DA;
	Wed, 15 Jan 2025 14:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KkVedJ8j"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA4924A7EC;
	Wed, 15 Jan 2025 14:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736950531; cv=none; b=YN2fTnkfxuicF71ljCrLxHWuhOGQJSI+ipsY9RWpC+gPfUpOrhO/5o5MvP864AHNrNS0N/2xQ/8UshLy2yq/IB+3W/OGMnAeBf4iioH8YdlRsCgCN9w+UXB1DdF0c7UfLaClb37vLvDCNf76QagKQuaZniRXoOPwbcDECsofC84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736950531; c=relaxed/simple;
	bh=HYSn3ig1jzOaoeCtyY4wvNYc36b13JHtY9u6Rc8dqIg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OW4oyEv2OLd135XGyQWETgHDXNP+7hRLAcX3o//R6TIBGfVQ0pXmrf4jMTDyHosHeioFf9OO7y4meDv77aY/johTmsepJRKAqpGXuwRMH4ZS3AP2he9TQzkbevM86EyreLygL2EuP43k59SbkuKCZvHhcY+zGkOe4KJyVDlheEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KkVedJ8j; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7b6f53c12adso536939685a.1;
        Wed, 15 Jan 2025 06:15:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736950528; x=1737555328; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LT0hR5zZjxEEo/cbZvgv4GcWsiMG25s7+uYGrVeJ2gU=;
        b=KkVedJ8j+dHo3qjLL3lH/Q+UvRENiskafgH1r5JHRpVEb119rIEg5+z6xiwK/yxncK
         gJmsc3da07PIDo84PGeDFUKnQWx7PBn0cHTrNAQFKOtv7GnioX/p7yWGjrdgu2dxhr6W
         ClOpr8hqhMHWB8JaqWBIBg4g+cgzYcSeIHthE2GhfY1ZE40EC0xNXJLcrTkGOk45sE3r
         KZnss8eeN/J9/5A+a8fl2LsErSYFES2hTPny5QO/KnpyF1mDjzTvDRstzublcYa6hVEn
         HdcoGfHRmPO/cUAGsOpWJnS3MOVInd+ykFzYkd2HddyNfO9DbSvWKgcfjq7gXK9PlTSv
         ABVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736950528; x=1737555328;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LT0hR5zZjxEEo/cbZvgv4GcWsiMG25s7+uYGrVeJ2gU=;
        b=gs3bDChzU97S1qNkmwkY90i70VMC2MK2Tox9t3nGI+xCPDV4gIHGRbOKRtUNSF//Jp
         QMw6Fwe6UWshDOmSM/HtPGs+jwAUbBo2fBcel9MaFsBLvAlSYnwY+ItDMcqtzTMJRlYS
         sfA/GIOX03I9C35Gsn2PIKa/HX9358mAOgI7oUljCpzMmVl/IicGcUNDlDzADziWBcVz
         R8Am79e3DK0dn6DcPTTsey+YjbUPd21GwiSW8jiBF9XBLAn4qn2D5CvuR1K8PbIoMrcg
         W7A3QNZmQfXA/7zRJungbIZ/5hl/KAL2aLSFwfMSv7mi7M8OYEesbcN/OIxayyr2Kef+
         qm7w==
X-Forwarded-Encrypted: i=1; AJvYcCXPOvMkzZd/ipwz5ylT6P6duNvfWFqknpY5qiDUuJNMXrWfuh27cIt+rcb8udMAMWBafxU8Czwwyt70v3/6@vger.kernel.org, AJvYcCXwbsnDcTohtZoM61sBWnBEIJeXUlxX+977aLS4GFmdpeEVb1Z4mgqczVJavB1cGxMb0zPx0lF1byI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxySxZ04AzX0TzycAuKEnyRr3TrrQBwSFbyrttoqEMQOwbnzNLC
	uN//VseBd76ki9e+1BR152r6O54TDQk9KyPXX2h4zOtS8zRLwSbF
X-Gm-Gg: ASbGncvLcOTRhsLttDV6prk/LYGEcNu025UAm+zzidpTzwMgNJIsYxDXhNF1ukIJ+/a
	iB+f7iMsRzK8YVd7lkO4DTmVXlWT6lvQMiX/aMkyYYnVTckEX0L78rqFAvJb1BIDk6eOC1Nq1fn
	swHSJSefGecEqFa56fgewxLGA8NNP7GyduCazKITU7xCAxH+LJqRDpEL22TSdK5XTyH+PLlLKp5
	vy99GgahHUvdbzIhDyhZhudYfJDWK0sCLoGNfYKpLqq/ieTzAvd7Tw9/pUeaeIkdw==
X-Google-Smtp-Source: AGHT+IH/cMbfA8A7cg6gwGDkl+bJy9xDs8Rn7s3XXoR/XsEdNGuCR6o2izOM4Rnr1JCDdIyYRLj6Hg==
X-Received: by 2002:a05:620a:2688:b0:7b6:dc74:829f with SMTP id af79cd13be357-7bcd97279a6mr5250961485a.7.1736950527701;
        Wed, 15 Jan 2025 06:15:27 -0800 (PST)
Received: from ownia.localdomain ([2401:b60:5:867d:3631:b7db:c3f4:aae2])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7bce3502a56sm719646385a.91.2025.01.15.06.15.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 06:15:27 -0800 (PST)
From: Weizhao Ouyang <o451686892@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Jeremy Kerr <jk@ozlabs.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Weizhao Ouyang <o451686892@gmail.com>,
	Tim Schumacher <timschumi@gmx.de>
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-efi@vger.kernel.org
Subject: [RFC PATCH] efivarfs: Introduce efivarfs refresh remount
Date: Wed, 15 Jan 2025 22:14:58 +0800
Message-ID: <20250115141458.9182-1-o451686892@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, when setting efi variables through the runtime service,
efivarfs cannot sync variable updates properly. Introduce efivarfs
refresh remount to support efivarfs information updates from other
sources.

Signed-off-by: Weizhao Ouyang <o451686892@gmail.com>
---
 Documentation/filesystems/efivarfs.rst |  6 ++++
 fs/efivarfs/super.c                    | 40 +++++++++++++++++++++++++-
 2 files changed, 45 insertions(+), 1 deletion(-)

diff --git a/Documentation/filesystems/efivarfs.rst b/Documentation/filesystems/efivarfs.rst
index f646c3f0980f..58461e02ad01 100644
--- a/Documentation/filesystems/efivarfs.rst
+++ b/Documentation/filesystems/efivarfs.rst
@@ -18,6 +18,12 @@ efivarfs is typically mounted like this::
 
 	mount -t efivarfs none /sys/firmware/efi/efivars
 
+To support efivar updates from other sources (efi_test ioctl, runtime
+driver, etc.), set ``efivarfs.refresh=1``. After that, remount will
+update the efivar information in efivarfs, like this::
+
+	mount -t efivarfs none /sys/firmware/efi/efivars -o remount
+
 Due to the presence of numerous firmware bugs where removing non-standard
 UEFI variables causes the system firmware to fail to POST, efivarfs
 files that are not well-known standardized variables are created
diff --git a/fs/efivarfs/super.c b/fs/efivarfs/super.c
index beba15673be8..7ae22ca120e3 100644
--- a/fs/efivarfs/super.c
+++ b/fs/efivarfs/super.c
@@ -277,6 +277,44 @@ static const struct fs_parameter_spec efivarfs_parameters[] = {
 	{},
 };
 
+static bool efivarfs_refresh_default __read_mostly;
+module_param_named(refresh, efivarfs_refresh_default, bool, 0444);
+
+static void efivarfs_clean_dentry(struct dentry *dentry)
+{
+	struct dentry *child;
+
+	if (!dentry)
+		return;
+
+	if (d_is_dir(dentry)) {
+		spin_lock(&dentry->d_lock);
+		hlist_for_each_entry(child, &dentry->d_children, d_sib) {
+			if (child)
+				efivarfs_clean_dentry(child);
+		}
+		spin_unlock(&dentry->d_lock);
+	} else {
+		d_invalidate(dentry);
+	}
+}
+
+static int efivarfs_refresh(struct fs_context *fc)
+{
+	struct efivarfs_fs_info *sbi = fc->s_fs_info;
+
+	if (!efivarfs_refresh_default)
+		return 0;
+
+	if (!fc->root)
+		return -EINVAL;
+
+	efivarfs_clean_dentry(fc->root);
+	efivar_init(efivarfs_callback, fc->root->d_sb, &sbi->efivarfs_list);
+
+	return 0;
+}
+
 static int efivarfs_parse_param(struct fs_context *fc, struct fs_parameter *param)
 {
 	struct efivarfs_fs_info *sbi = fc->s_fs_info;
@@ -351,7 +389,7 @@ static int efivarfs_reconfigure(struct fs_context *fc)
 		return -EINVAL;
 	}
 
-	return 0;
+	return efivarfs_refresh(fc);
 }
 
 static const struct fs_context_operations efivarfs_context_ops = {
-- 
2.45.2


