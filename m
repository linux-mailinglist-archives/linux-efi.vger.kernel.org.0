Return-Path: <linux-efi+bounces-4817-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1C05B5668B
	for <lists+linux-efi@lfdr.de>; Sun, 14 Sep 2025 06:05:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6811A3A165B
	for <lists+linux-efi@lfdr.de>; Sun, 14 Sep 2025 04:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63332274671;
	Sun, 14 Sep 2025 04:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kPbZj1qM"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 756B4267B90
	for <linux-efi@vger.kernel.org>; Sun, 14 Sep 2025 04:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757822702; cv=none; b=CRIc/AVfn8Gc1Nw0MOso4a4eUjIhxlTAPoXT6WPGGPr8Vdx1gUO9LfZmTzKlpgNarPeK+dTs/9d6/0SPmX98ejGTGpVIujZiaU9qxkyJ69Dn7gtazdfFR8SQdnY5qwgKExYWPmanRagOt1Xiuiq1y18qlkn2DoBXp+THr5bcOKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757822702; c=relaxed/simple;
	bh=K5eh5PFkTwqgMsR/pgApUC7mRgd5tIkIjFvctye1Fsc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EUG+4obcnDjEg9vQvEn2+hh1gENB/Jy3v05bythZyPit/5mcgfKxmW9ZTCnvPJQGIWhqKK4kxCz1pcc8/gPsyfbI5qR0xwo7xxzgemgFlQ90hryKWnU64hZkqp31FP73UH4ZV0D2E5XPqGbdYSsoveN75S1TSy9LWlkufQWwWVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kPbZj1qM; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b07c28f390eso368921066b.2
        for <linux-efi@vger.kernel.org>; Sat, 13 Sep 2025 21:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757822698; x=1758427498; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mw6NNXq6XfJ0FNmZ5frjZGClHo0iZVSxbFf+bMTHIN8=;
        b=kPbZj1qMmGYeecjJGUIlyIHIYamuich/CNzkJDmaNgGaqWvmKRH/xWtRF41uM5qkzv
         aCOo6S2Jlgd26xKUeuaakbbG7HEqDWn4lpel7AStmc2VlwPrBzY5joso88BimDPHYlXE
         lGKrirBAgOS/lwpoTHzC/tUmPxv1QF+CBszBJWWwZ+66J7mYEyOimyL2AtSvZIWLx1gK
         5mb9tOIr2zMFazTcGHaTU8u9ffMEBQkt1YmPKV0KVFaH5qyy1RH+UXAWhuy3AcjFOjXc
         Kxvqk7LMiYKMLQ7+ce+4bi1vcyj+dMrkLMVvDZ3cpLh4Ep/R+rND2M09mBBHfKuxH8K6
         CeEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757822698; x=1758427498;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mw6NNXq6XfJ0FNmZ5frjZGClHo0iZVSxbFf+bMTHIN8=;
        b=XGPwuJBXb9kf/s86TfAHWgEyxhzfD13/NBco8F/KnZ+2nfd5e4CHmZZxWTOZvhnv6a
         xfb4qMyzTJdI/Um3Rtso18RXLJQitMj98YPi3wUKlF45e3F0wWAHPdxUzvmBco0lvLfN
         FKGDP3P0TItMTFFm0zRWP5SM5cPRWC1Lg+T31si0Sz5usKIEYmeegPxzy5jJl7yMehB2
         C+gAsH9V9Nd2kMs5MjbAH8OJh8e2D5BA/gJyhq60/VueTU1XkHIOQohpGcJM7ENR5HmY
         w11mWzjwTLcGboxxdKiaqfLWZz/UARZ8hRzPU8jSFhNnSWH/SYcuWPpHl2aYqxX+WJ8V
         vo5Q==
X-Forwarded-Encrypted: i=1; AJvYcCXGLYwNDnbsyRi8GRfGfS1qPePXyHXHyybzi+RF5jtMC1x1uEgAP92ZLCHIONr8VuRxvOi4CAHIp3M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9w9950Cq2Um3/qaJCDJcYhKshDjVqRnkNbx82k2/0hBMqj84Y
	x43z8YWyjs18BKKObffkVlqnMjolk0PHYuLn/gH3of7BkZr+/pPpNBcq
X-Gm-Gg: ASbGncvh85soD4rTGdUaQtXWDMb7snZ3etxbKnwNsrjzUm3tW4bw5r/jF1WBqiq0B8L
	xNEBa1LgMWhrK1gmGATxEwzYGYAn7xx2tLWdsApRdkY9sP0aV33l3tsx+nqnY3n6vkR3b0ertYA
	tSqto2UWXOpkN36Rnr/qlA0vRi6/7b+amJn/+F3jkRpUAtaY2CT3UfrL443hCGIsSrczmPn4GLu
	KRJFAXSyyJ/1JvHGs4ULrl8lIK3KvbnuPnMHdlKrFtlP0JDEtbCxuRH+L3Wp9Cz3xqAcFZ+IIe0
	q4MTzi61lIacfBr0Tg5YY+Wtl63BknGh4OZ3ZXv782dm/MG9/yJ4lfWzuvKadgTu4xkbqcSZUmK
	ibXBzAcYZ5qnNyTFInRo=
X-Google-Smtp-Source: AGHT+IEha/cEycx+vu0xF7TxjEegwfvZABBYj962u8Q3zWPEYF1LD+BxwewIqIoCpytaOJDSx3nrIQ==
X-Received: by 2002:a17:907:3d8e:b0:b04:706a:bcfc with SMTP id a640c23a62f3a-b07c37fd45cmr876333266b.33.1757822697695;
        Sat, 13 Sep 2025 21:04:57 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b07dbf5dbf5sm308085466b.79.2025.09.13.21.04.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Sep 2025 21:04:57 -0700 (PDT)
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
Subject: [PATCH RESEND 62/62] init: rename CONFIG_RD_ZSTD to CONFIG_INITRAMFS_DECOMPRESS_ZSTD
Date: Sun, 14 Sep 2025 07:04:51 +0300
Message-ID: <20250914040451.3848715-1-safinaskar@gmail.com>
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

Initrd support was removed,
and CONFIG_RD_ZSTD has nothing to do with ramdisks.

Update your configs

Signed-off-by: Askar Safin <safinaskar@gmail.com>
---
 arch/riscv/configs/nommu_k210_defconfig | 2 +-
 usr/Kconfig                             | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/configs/nommu_k210_defconfig b/arch/riscv/configs/nommu_k210_defconfig
index 6e961256a941..68cae0496b54 100644
--- a/arch/riscv/configs/nommu_k210_defconfig
+++ b/arch/riscv/configs/nommu_k210_defconfig
@@ -7,7 +7,7 @@ CONFIG_INITRAMFS=y
 # CONFIG_INITRAMFS_DECOMPRESS_XZ is not set
 # CONFIG_INITRAMFS_DECOMPRESS_LZO is not set
 # CONFIG_INITRAMFS_DECOMPRESS_LZ4 is not set
-# CONFIG_RD_ZSTD is not set
+# CONFIG_INITRAMFS_DECOMPRESS_ZSTD is not set
 CONFIG_CC_OPTIMIZE_FOR_SIZE=y
 # CONFIG_SYSFS_SYSCALL is not set
 # CONFIG_FHANDLE is not set
diff --git a/usr/Kconfig b/usr/Kconfig
index 3a891a0c9ef4..06e1c1474b68 100644
--- a/usr/Kconfig
+++ b/usr/Kconfig
@@ -100,7 +100,7 @@ config INITRAMFS_DECOMPRESS_LZ4
 	  Support loading of a LZ4 encoded initial ramfs.
 	  If unsure, say N.
 
-config RD_ZSTD
+config INITRAMFS_DECOMPRESS_ZSTD
 	bool "Support initial ramfs compressed using ZSTD"
 	default y
 	select DECOMPRESS_ZSTD
@@ -206,7 +206,7 @@ config INITRAMFS_COMPRESSION_LZ4
 
 config INITRAMFS_COMPRESSION_ZSTD
 	bool "ZSTD"
-	depends on RD_ZSTD
+	depends on INITRAMFS_DECOMPRESS_ZSTD
 	help
 	  ZSTD is a compression algorithm targeting intermediate compression
 	  with fast decompression speed. It will compress better than GZIP and
-- 
2.47.2


