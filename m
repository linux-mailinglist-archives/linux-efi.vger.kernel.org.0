Return-Path: <linux-efi+bounces-4753-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9592BB55AE6
	for <lists+linux-efi@lfdr.de>; Sat, 13 Sep 2025 02:41:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05B9CAE263A
	for <lists+linux-efi@lfdr.de>; Sat, 13 Sep 2025 00:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C73072631;
	Sat, 13 Sep 2025 00:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LeLgkTBj"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 172226BB5B
	for <linux-efi@vger.kernel.org>; Sat, 13 Sep 2025 00:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757724072; cv=none; b=Y6/Iac+CTygQa9KE4+aYPyN0PvA7yiDkXLLmMj4k29a2cTA+84rugy81vZyoHSpJyAgktZKnVG2ohlGFJgUuVVZ8nc/zBDeLPIuGUXn5lX6rO6hkkRkc7bkucQWodIyHaAetzh7i4Z82pJZKb+2hNZoDLtxrYhJiyVvbVb0/E3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757724072; c=relaxed/simple;
	bh=yhXDovoFaZRmENn1P/7nJEAYKmeDJf//ZQgmQHs9gQQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ey8FTpHsquBGWb5tu9mzNTnKDyZNUD4JQ+0NGWUo4hLXXRsTgn2YBSK78TK8JZVpIuX/YskMtO9v/jSHnVBrKOK5J2uxZ8gt8e/QTltbH/lcjOce8WWwX9iziAjEGEsIDSr2GDa6FyL2Oiw7qvOri3ps78D8e8M6gxo3FhfpD9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LeLgkTBj; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-62ecd3c21d3so3044107a12.0
        for <linux-efi@vger.kernel.org>; Fri, 12 Sep 2025 17:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757724067; x=1758328867; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XF39SoyvPO4HSizOmVkN9E4c/OCzbmGR6ZiNtCSz3R4=;
        b=LeLgkTBjsbam/V5tjmeu8XIRmYholHa/MziO3vhNLx5+7IbFpOtKfvXI6IrpHYIUf/
         w0rub1UynMtAbnqZl0+0PEKjR7sjO1hDuG9eElIdzeyC0wh6NG1DuL8tEcIgm7WZYVAE
         bRBWL/udapdFPjuWEKO++d8TuIQS91RBSpbwR7sXn474MD/kcz0hDjdCJXH/lQ7yNoZi
         KXKJ1sA8T4zBNUMHbJQ4WOYJyT6o8usyOrgUfIFqdFV+U+h5h0W8y20o30fXs6WP800r
         jXpUaYNhR5jQRBjTvKWUuFsdqBpRR+uQchb1e5zzEGRcMjEDpLUlPDG0wtBXsi6qN3qd
         +2Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757724067; x=1758328867;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XF39SoyvPO4HSizOmVkN9E4c/OCzbmGR6ZiNtCSz3R4=;
        b=OvWzs7I0v3sfIoebpmRm+sEVp//96oZkFyZitFT7G6hK6sdc84emRS85eD37CKG9hH
         321+xM0wd8+ENSiEQ5T6tz7ONdWsvGif+eW5GMO/UWgttStJ8I4tgUEd0qWCnMPCPFSd
         8ZhSh3VC7tIWUaG9MOECsk5BBKmEwSLQOPQ8NQI4pMdgxiAtnT9Nj4Mnrc/fU60KLPer
         0xzMBx3NHfuOA7IvFq6uPXd9FOxoesCuoyjQgZ+xfZL/RxdWXwxwCjw/G/Pxntn4dWgX
         UxQcMeI/B/TuiSwemrnxGXXyTfGLIq/FH5B8QfD9X9rWzdnVymcZDNhHdT6gGQc8olkz
         Vssw==
X-Forwarded-Encrypted: i=1; AJvYcCU7DzsnDywld6XDZ/4j7hNoTS0BOcKjwvj7hoe6Tcp8l70QXlvFJl5t7WNNXdtdlQA8cztrx8ASZ+M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlrefQMCBI6i1m9y7WJfB+nXFbvk2DxHUYukm1kJcmGlPrQQoN
	0S0Z/auSqAIEJuGCksbUv8pzU2hMOyIR+fPYyEGnkJ32mjjCgav9Tq6W
X-Gm-Gg: ASbGnctFOwBfXjhe7QikVwsBlinnIO+hbR6uCDfVXSb6ttkve4id6N2skw9x7yyJkw/
	kVZblrqHrHZL7qNM/pwLkWRfTkgZ7O7YJin0doCNArCaqQo6iBCFSZHK5vrl2+fNkzVqRwXlNqv
	Ipw0vcyWKl74Un9J675+wdfrZ8AHvtuNJn2juK4R/PgkjlQc/HDo2WBIx3v7fjPcn8FrdXEEijD
	CLc7XPvVW132IYj3h5PKKRDHC/5nQZhWPhAsC/GuYQAVQN9jFk8MKwPQOlE0d44brlavxVlr8kz
	YZBnMeqvz2xuRuDe9bjXeU/2Q+JAl/r+rHTB+MS7D+af/JwaSaR1nzY36MfaB/mLbSbA1lmg38C
	untK7k7rKzc9sxSfguPfMTls65Uor9uOQQtjPPD1C
X-Google-Smtp-Source: AGHT+IEtE+sLJ/l9Jfm7JaiF1fYpyMVV9PhBGBMQ2H0UV0Mi6JbllI7aH7Kqq18B0Ua9aQ0IxOB0Jg==
X-Received: by 2002:a05:6402:3552:b0:62e:ed2f:a660 with SMTP id 4fb4d7f45d1cf-62eed2fa993mr2339876a12.11.1757724067127;
        Fri, 12 Sep 2025 17:41:07 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-62f0c7a5546sm189920a12.43.2025.09.12.17.41.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 17:41:06 -0700 (PDT)
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
Subject: [PATCH RESEND 01/62] init: remove deprecated "load_ramdisk" command line parameter, which does nothing
Date: Sat, 13 Sep 2025 00:37:40 +0000
Message-ID: <20250913003842.41944-2-safinaskar@gmail.com>
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

This is preparation for initrd removal

Signed-off-by: Askar Safin <safinaskar@gmail.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 2 --
 arch/arm/configs/neponset_defconfig             | 2 +-
 init/do_mounts.c                                | 7 -------
 3 files changed, 1 insertion(+), 10 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 747a55abf494..d3b05ce249ff 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3275,8 +3275,6 @@
 			If there are multiple matching configurations changing
 			the same attribute, the last one is used.
 
-	load_ramdisk=	[RAM] [Deprecated]
-
 	lockd.nlm_grace_period=P  [NFS] Assign grace period.
 			Format: <integer>
 
diff --git a/arch/arm/configs/neponset_defconfig b/arch/arm/configs/neponset_defconfig
index 2227f86100ad..16f7300239da 100644
--- a/arch/arm/configs/neponset_defconfig
+++ b/arch/arm/configs/neponset_defconfig
@@ -9,7 +9,7 @@ CONFIG_ASSABET_NEPONSET=y
 CONFIG_ZBOOT_ROM_TEXT=0x80000
 CONFIG_ZBOOT_ROM_BSS=0xc1000000
 CONFIG_ZBOOT_ROM=y
-CONFIG_CMDLINE="console=ttySA0,38400n8 cpufreq=221200 rw root=/dev/mtdblock2 mtdparts=sa1100:512K(boot),1M(kernel),2560K(initrd),4M(root) load_ramdisk=1 prompt_ramdisk=0 mem=32M noinitrd initrd=0xc0800000,3M"
+CONFIG_CMDLINE="console=ttySA0,38400n8 cpufreq=221200 rw root=/dev/mtdblock2 mtdparts=sa1100:512K(boot),1M(kernel),2560K(initrd),4M(root) prompt_ramdisk=0 mem=32M noinitrd initrd=0xc0800000,3M"
 CONFIG_FPE_NWFPE=y
 CONFIG_PM=y
 CONFIG_MODULES=y
diff --git a/init/do_mounts.c b/init/do_mounts.c
index 6af29da8889e..0f2f44e6250c 100644
--- a/init/do_mounts.c
+++ b/init/do_mounts.c
@@ -34,13 +34,6 @@ static int root_wait;
 
 dev_t ROOT_DEV;
 
-static int __init load_ramdisk(char *str)
-{
-	pr_warn("ignoring the deprecated load_ramdisk= option\n");
-	return 1;
-}
-__setup("load_ramdisk=", load_ramdisk);
-
 static int __init readonly(char *str)
 {
 	if (*str)
-- 
2.47.2


