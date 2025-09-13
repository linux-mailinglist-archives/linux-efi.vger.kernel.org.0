Return-Path: <linux-efi+bounces-4760-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69647B55B6C
	for <lists+linux-efi@lfdr.de>; Sat, 13 Sep 2025 02:48:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E70D17E1BC
	for <lists+linux-efi@lfdr.de>; Sat, 13 Sep 2025 00:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FF64155322;
	Sat, 13 Sep 2025 00:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LXC5LHaV"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E4F136672
	for <linux-efi@vger.kernel.org>; Sat, 13 Sep 2025 00:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757724531; cv=none; b=Oj3L5KQPsqc4GIFEEA8BYGO8iUTl74vXhsGTtkobIW0BWd6Gguo8MllSJ1gr87MlIGAqHvoP7nV9GkL+l53THUmwg78/H4QTPR8usxV/crhXdKkhp5dkS+c8ZYO92oW6yI9k3qoEjvVnm8s2uOroHvh7PAzPG7ljXBg4ZJA2wcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757724531; c=relaxed/simple;
	bh=xKqULWXz/2FiENcJWmfzamYmMIE4imk3W/BtNdWBiQw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YGlugMvamI3Jv/uyBmL9HGBvddcQWPjdnBzkJ5Ojer+SIRyYEscQKUYbiHqiCBVU6rGEJ7yYYeuhSxIFHH+t7ESNCtUwTTJbuhr+1+8txsgMIwFIhoSFiOauGgJUFZqoSDX55/Ua6wlobakYWhGWDV0HKmouQJvfr/kkVpxzi7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LXC5LHaV; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b07c38680b3so226188266b.1
        for <linux-efi@vger.kernel.org>; Fri, 12 Sep 2025 17:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757724526; x=1758329326; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AaXPZ8GS+1OiGE0ZCje70+VbQ3y123W+k6t1ILETLlQ=;
        b=LXC5LHaVko3hLgitulh2D+X+9QzDfKDNhew7kFXwh3JBpMXe8S8TiFwp92HLY5PnX/
         nE0PBrgrSYYmvUr7nB60XBcUGWbD3ENdwZDdGEZEpmftZ+HtA+EeeF7PR1uT2dDM52dc
         ZMVq+Hm8pSzt/CvRPR7Me2trqTMPiaCvHkP6+b+IEQvD5eF5k0u5n4FsZ31R41RDQcDQ
         BrBCpUlXV52huKpy2TgomHW9QVs9Ykrr2tU/v4K4dgAQoo0ONvDQb+XsjiZSFbJ2IgvS
         xrCTwIgGWYosdnf/NGyWsk7DdhjDkNLnA/ofhmUV8ldCxH2yGyu11Sj/DxoAM0vBqfC8
         jM3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757724526; x=1758329326;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AaXPZ8GS+1OiGE0ZCje70+VbQ3y123W+k6t1ILETLlQ=;
        b=sO7J7sY9lpu3bEeqDyKWRG1zaJY4HpcwdHHi6a8ZWpHl/mNQMldtt4BCaGEg/qlAxQ
         Y96g3w/Ni9tlawWKjOXD70ei5cNBkajo9JuWPgLaPW31SCOdKLQyeZc7iv5LhAx9A2v3
         U5unfUm9vwEeR+FqhGEHpPiGFAHrRziHmeQUMmURBw/L+tqA/rRZRzW59TgGjzktdI4Y
         gSJqiqvxMJ/3aTuRwv7C02Mnf4iWKaMWAPvISxHLcVukosu54Surgep8OM8T4GPBlU4A
         y0mjJ5VMX/USQACP+oS1PFFHPvr9pe22ZyY/4SzfdtfrIFSfnFXDRR2QQuKln5mAwVKL
         pdag==
X-Forwarded-Encrypted: i=1; AJvYcCU7G/z02wO0mnXZM1jWUhMG0Ax900wl/58M2IKdkJrIEnEgszvm60MKLa0fn+lKpPv8u9VWSVEV9JE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2zAx65K9vKNCkDKK//EX4EHckCvIXVlpGiKnQFVYO7YY+vPXR
	qpy2d7feDYN8ngAsuWNU11ytp7XtuU0uTwaxL1L79NIMKwJ27DTdBlRq
X-Gm-Gg: ASbGnctGRHFXpRne2yqNNb+i6/n4rHfUmTtwa9W79LHEWqrP46CqUjHQJ90M3Z02N6J
	lvF8CS8pKExoXXZqKcunxjDjKqV182qz8SCVMJxeKzuXsNhljpYKwJVzBLdKGoihIV5xd+Ipsh6
	BjHmgycuxfinnoWzSy0J8MKj6ET9vBd1kLlHIOlw8YUZYv1JHTnSKYaNhciGA2YX8KYbrfGojxE
	Qu9KmzYVVjp2cBjRDx8M89c/Nk/esvYqakNoJ/4SH4XHxXlCM2JDzFeoIdphgC/rviuGgO4lwYa
	CQDu566ZLnTZbfUBG8NYOjwXC16Aek0ekrUzKGiOhVWNdwkWg8bQYwJBzXsrqiMtsO6Wu3WYHKl
	pVby76+/P99e2qti5x04=
X-Google-Smtp-Source: AGHT+IG9OWg6vz1Y30fO80tUWulNMPWiUpAt7xVByuYcp52he6rblxs++6dTXTQkGfdvR2czpiOABA==
X-Received: by 2002:a17:907:d88:b0:af9:add3:6bbb with SMTP id a640c23a62f3a-b07c35fb469mr433586666b.29.1757724525627;
        Fri, 12 Sep 2025 17:48:45 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b07b32dd5bfsm461777466b.63.2025.09.12.17.48.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 17:48:45 -0700 (PDT)
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
Subject: [PATCH RESEND 08/62] arm: init: remove FLAG_RDLOAD and FLAG_RDPROMPT
Date: Sat, 13 Sep 2025 00:37:47 +0000
Message-ID: <20250913003842.41944-9-safinaskar@gmail.com>
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

They are unused since previous commit

Signed-off-by: Askar Safin <safinaskar@gmail.com>
---
 Documentation/arch/arm/setup.rst | 4 ++--
 arch/arm/kernel/atags_compat.c   | 2 --
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/Documentation/arch/arm/setup.rst b/Documentation/arch/arm/setup.rst
index 8e12ef3fb9a7..be77d4b2aac1 100644
--- a/Documentation/arch/arm/setup.rst
+++ b/Documentation/arch/arm/setup.rst
@@ -35,8 +35,8 @@ below:
     =====   ========================
     bit 0   1 = mount root read only
     bit 1   unused
-    bit 2   0 = load ramdisk
-    bit 3   0 = prompt for ramdisk
+    bit 2   unused
+    bit 3   unused
     =====   ========================
 
  rootdev
diff --git a/arch/arm/kernel/atags_compat.c b/arch/arm/kernel/atags_compat.c
index b9747061fa97..8d04edee3066 100644
--- a/arch/arm/kernel/atags_compat.c
+++ b/arch/arm/kernel/atags_compat.c
@@ -44,8 +44,6 @@ struct param_struct {
 	    unsigned long ramdisk_size;		/*  8 */
 	    unsigned long flags;		/* 12 */
 #define FLAG_READONLY	1
-#define FLAG_RDLOAD	4
-#define FLAG_RDPROMPT	8
 	    unsigned long rootdev;		/* 16 */
 	    unsigned long video_num_cols;	/* 20 */
 	    unsigned long video_num_rows;	/* 24 */
-- 
2.47.2


