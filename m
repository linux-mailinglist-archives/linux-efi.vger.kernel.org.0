Return-Path: <linux-efi+bounces-4764-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9583BB55BC2
	for <lists+linux-efi@lfdr.de>; Sat, 13 Sep 2025 02:53:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3CE9C7B5DB5
	for <lists+linux-efi@lfdr.de>; Sat, 13 Sep 2025 00:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8481072629;
	Sat, 13 Sep 2025 00:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KGKxaKJJ"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82CD7145B27
	for <linux-efi@vger.kernel.org>; Sat, 13 Sep 2025 00:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757724793; cv=none; b=rZQbud+dVqiP8R48KFCCB9Dqv7RkX+l8bqLAliHB6BNX1+LSMzNd7LuS6M0Jw75OYvm0WRoY3k7k2z117TXhC87V6B5qnt0mgrIhRZmlRfjxKPgadlx5juQfiwgf53RZPCSlND9HZTHkDu+acXtQR0ma2k1ednSe/fTD7D6uqCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757724793; c=relaxed/simple;
	bh=x5NNVyIF1R5eB/2ANpkfxinDkMZ4lHIXMUphyEE4B54=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mPDcOfCZ9W/BoXnvp3gVW2bmI88YxZPVbAguI1K0cV5ohslNgC6rDURpTNy7V05c775JuPopMw6do8qwDPTbulesewE6UoEi4YpiqfOxB4YZP0eYOonl5BqS+wVqnWqLcEPoook4Ca4mzi9IcwrIJqzyhvFMo6lw3J/J029zsyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KGKxaKJJ; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b079c13240eso406062066b.1
        for <linux-efi@vger.kernel.org>; Fri, 12 Sep 2025 17:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757724788; x=1758329588; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qPSAK5Fj4YQSUyCSJit30V41XYzOMHEP2qtV3SbNp88=;
        b=KGKxaKJJAEmQb6XUp3nRwdDCCxc+u+hiDne6Z/NPf1uixihci6LE3WqQK66IqjXdY4
         Xb/SIK40YfVhek6ziJiApcg4teUqoYD+EUABCY4ZDilpIOpcxVeVt4xnP8Y3hMV830Jd
         BgRCzsXLuAt/64gYNvjWjTt0faQGDNZq5VES2V7LFxosLo+CyBxCqy0cFlgLTUfnd41y
         g5A5xGHGNE2ZrRJQWf4a4OG0sSfOVWqShG7OAgFkdiIQMVcQX7NExVIHdtllyNXyAyPe
         SXalYa6zfu1Jnx/pFPicmNaDPB3e4ynKFhUSu4lO0eWu8UaD73J3NMjlvmNcETXjIJLv
         jaTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757724788; x=1758329588;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qPSAK5Fj4YQSUyCSJit30V41XYzOMHEP2qtV3SbNp88=;
        b=gIY6M2Ovsaq17cOlerBBlPPUsYpu6dSC0GOi/Nfon9F857/yzEDh9IU6SnqToOAmZo
         SsAIapPmtNCLnQqcAzc6YeKkRk9PBjYeMHkKjZXgQuD8M+m5vjejfpNA1Du938n7JTj5
         +hW7z+jh4Tn4iWHlQQUIqn5EXspNZsxJ6fP3CiyMmGaIgZyRSU4gvbofPy0e1pkh88Tz
         dzg5KG2CYF8XuE3kqvhLeb/iT07/KtRxuiaDtAlAn7if0lhymoba/HF7fBIUWjpDcjhV
         +xCb4kBvr534pTww6NDLBhq4CemG1RuETnCAtCheEcbtiK0gX/VRRC46NRxrnIELoN8Y
         rt/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWf9wy32SceZedVVO1LmFM0bdv0S5hIA9/cBICgM+xxi/mCtigcwhLJEBHvz7hEdweZf7mSSLrR1z0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2E3pBhxf0IKG972MXLdr9KvgBvNQB/xnU7PBmOd1EnHvldS3U
	BWk5pQXS8uIrattTyoxgWazOIRYIKeAq9Qj9n/e4O4tUUUBU1p9ene3U
X-Gm-Gg: ASbGncssXraoPtobNQKTHsI+aQZicWhH0Wp0aNO6gTAa50dH1XFhTWcyuD0zQjBbrus
	OVXykKW4LPjA4q3kW0BDgbklYm3erV7QarsCSrtkXwuDqDAqlJG7b6yDt58qy2/+BwOonfVf81D
	QZeQYmA9ViDhZqhT7HwKgMiUoIxgQJF9I86DC8BeytuIzzyaBSg2c2mJlYCDct/vasDhU7JsiKJ
	/yeRJmkk+5KFZRrJpYZBU1LUGOwf+5C59n/iL9aJa6gku8y/dw8NrOC/yXSPPcoXC9xQ+VcYiVo
	Ga928qEjapY5sWKlESOqLl+SLw8T5ofiP18MWuoHgYJ/umb91hgaFnMA6AZLj+E4f+taeXCg6Zr
	UT7XETnRPb437Sa1QaCgX/WZywuiHrQ==
X-Google-Smtp-Source: AGHT+IFLH7pCvIgBYHEI5BCYMw7iR++gatKVbesXKTxSAgJfhChwCe/V59YIUp3mRnJ55soXUGFMnw==
X-Received: by 2002:a17:907:da4:b0:b04:2cc2:e49c with SMTP id a640c23a62f3a-b07c35bbcbbmr535243766b.19.1757724787764;
        Fri, 12 Sep 2025 17:53:07 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b07b32f22e8sm477916866b.87.2025.09.12.17.53.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 17:53:07 -0700 (PDT)
From: Askar Safin <safinaskar@gmail.com>
To: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Aleksa Sarai <cyphar@cyphar.com>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	Julian Stecklina <julian.stecklina@cyberus-technology.de>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Art Nikpal <email2tema@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Eric Curtin <ecurtin@redhat.com>,
	Alexander Graf <graf@amazon.com>,
	Rob Landley <rob@landley.net>,
	Lennart Poettering <mzxreary@0pointer.de>,
	linux-arch@vger.kernel.org,
	linux-alpha@vger.kernel.org,
	linux-snps-arc@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-csky@vger.kernel.org,
	linux-hexagon@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org,
	linux-openrisc@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-sh@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-um@lists.infradead.org,
	x86@kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	linux-block@vger.kernel.org,
	initramfs@vger.kernel.org,
	linux-api@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-efi@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	"Theodore Y . Ts'o" <tytso@mit.edu>,
	linux-acpi@vger.kernel.org,
	Michal Simek <monstr@monstr.eu>,
	devicetree@vger.kernel.org,
	Luis Chamberlain <mcgrof@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Heiko Carstens <hca@linux.ibm.com>,
	patches@lists.linux.dev
Subject: [PATCH RESEND 12/62] init: remove /proc/sys/kernel/real-root-dev
Date: Sat, 13 Sep 2025 00:37:51 +0000
Message-ID: <20250913003842.41944-13-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250913003842.41944-1-safinaskar@gmail.com>
References: <20250913003842.41944-1-safinaskar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It was used for initrd support, which was removed in previous
commits

Signed-off-by: Askar Safin <safinaskar@gmail.com>
---
 Documentation/admin-guide/sysctl/kernel.rst |  6 ------
 include/uapi/linux/sysctl.h                 |  1 -
 init/do_mounts_initrd.c                     | 20 --------------------
 3 files changed, 27 deletions(-)

diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
index 8b49eab937d0..cc958c228bc2 100644
--- a/Documentation/admin-guide/sysctl/kernel.rst
+++ b/Documentation/admin-guide/sysctl/kernel.rst
@@ -1215,12 +1215,6 @@ that support this feature.
 ==  ===========================================================================
 
 
-real-root-dev
-=============
-
-See Documentation/admin-guide/initrd.rst.
-
-
 reboot-cmd (SPARC only)
 =======================
 
diff --git a/include/uapi/linux/sysctl.h b/include/uapi/linux/sysctl.h
index 63d1464cb71c..1c7fe0f4dca4 100644
--- a/include/uapi/linux/sysctl.h
+++ b/include/uapi/linux/sysctl.h
@@ -92,7 +92,6 @@ enum
 	KERN_DOMAINNAME=8,	/* string: domainname */
 
 	KERN_PANIC=15,		/* int: panic timeout */
-	KERN_REALROOTDEV=16,	/* real root device to mount after initrd */
 
 	KERN_SPARC_REBOOT=21,	/* reboot command on Sparc */
 	KERN_CTLALTDEL=22,	/* int: allow ctl-alt-del to reboot */
diff --git a/init/do_mounts_initrd.c b/init/do_mounts_initrd.c
index bec1c5d684a3..d5264e9a52e0 100644
--- a/init/do_mounts_initrd.c
+++ b/init/do_mounts_initrd.c
@@ -14,30 +14,10 @@
 
 unsigned long initrd_start, initrd_end;
 int initrd_below_start_ok;
-static unsigned int real_root_dev;	/* do_proc_dointvec cannot handle kdev_t */
 
 phys_addr_t phys_initrd_start __initdata;
 unsigned long phys_initrd_size __initdata;
 
-#ifdef CONFIG_SYSCTL
-static const struct ctl_table kern_do_mounts_initrd_table[] = {
-	{
-		.procname       = "real-root-dev",
-		.data           = &real_root_dev,
-		.maxlen         = sizeof(int),
-		.mode           = 0644,
-		.proc_handler   = proc_dointvec,
-	},
-};
-
-static __init int kernel_do_mounts_initrd_sysctls_init(void)
-{
-	register_sysctl_init("kernel", kern_do_mounts_initrd_table);
-	return 0;
-}
-late_initcall(kernel_do_mounts_initrd_sysctls_init);
-#endif /* CONFIG_SYSCTL */
-
 static int __init early_initrdmem(char *p)
 {
 	phys_addr_t start;
-- 
2.47.2


