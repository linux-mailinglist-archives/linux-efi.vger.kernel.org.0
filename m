Return-Path: <linux-efi+bounces-4776-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99841B55CA4
	for <lists+linux-efi@lfdr.de>; Sat, 13 Sep 2025 03:06:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D0CB1CC6A26
	for <lists+linux-efi@lfdr.de>; Sat, 13 Sep 2025 01:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45CFE1A3BD7;
	Sat, 13 Sep 2025 01:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i5jdjkTj"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87CF916CD33
	for <linux-efi@vger.kernel.org>; Sat, 13 Sep 2025 01:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757725580; cv=none; b=td3DWCrfeh0bDaU73z3p0XWijusW6l9Czi2I2aE9YqbN3+OLKBoE++pQI8rxJj9NjqSLXDX5KA2ThU1cMbqjyWYeKjtQQE86C9uAxplV34nxlWpanS67DRcKdk5DZOCutf8mZ4bY68sZUS3BRRLdiwRTgd2Ivc9pw1XvjWUeGKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757725580; c=relaxed/simple;
	bh=vklOel+wSCjK4qNA3bbVH6akiUZ5v6h3w1mLbg32yHc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PLYgiHAWJDxNzOrSWLa+eRS0nwsvMkmpnbDxUN4V301EUkHu3ZlEsXH5DzsQuWlAH+FLNPOln9zJaXTJN/dgs0o7zogIu+b/ugSwX45pd8LMcCvABrdks1g4527v1VsJk1E36Xo4mtmX6gHkSclK6mMwYSTZGyOSp/0WgRccrdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i5jdjkTj; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-62ed3e929d1so3247466a12.3
        for <linux-efi@vger.kernel.org>; Fri, 12 Sep 2025 18:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757725575; x=1758330375; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hRKyxFwRI2Qz0k3ZoQpZ3VLrtZiB303jicB3H5rLu1o=;
        b=i5jdjkTjtptnVRTKu9gC1FGyG631gNTKOQcNNjiV1wIGpCO9LKpi2CJ2RQ0m8t4mDH
         ONVWomxhe69fjxeYMmICCmXv0Rr8TDz7s6BVZICN9NwGb1N7pNZmRqZGBcz40knM2HMI
         W7Ji8wqwO1cw0T53Aky2TLdNt7Ux9WDivWO8koeL4yJfRdO+vqooDEJ5hMj2vZ6iRCxO
         FLSx379lFdhQ1bMH9wAjwlrmjDNUBqy5D7r979gfnOOIkIHRqh07UgA4qY+vpqOY4JKM
         u+gd3SquikxVivxA1PhfxTy/48fwXe+t0GbKjBfMbOX3kk2O1YHm9m0ES0HTMJbOYUaG
         GRiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757725575; x=1758330375;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hRKyxFwRI2Qz0k3ZoQpZ3VLrtZiB303jicB3H5rLu1o=;
        b=MQFWQS3QOH7cIPehJ+ziPt83UgEU0gP9oL1g92UyM/J63wQJ8qQNS9rzr6oaTO8bqa
         akupIjKobv7Osexx9t8Sy9D3HbNTMaDMgl23EC7TnZG1yQu8clOx5tAYv9srA4pjG98F
         XtrzG0QDELOW/ncQnP3SIZDC9OS4kIBdACqvI02Lg2uS4MW74zClId2eaMicY6F/Nhsd
         j7LHajP8AEmaQNyFFfT8xA4D02BFekKek5hc7//lvxcQA/0uuNTIgU1o3uxRMwwQU2V3
         1Q8hkkByjCdKqmLd0CybPVByLSUkpDYyo09Fxp3EiQkO3bjSwi1V5ZA3Id5H+Xmyvh7L
         mhfA==
X-Forwarded-Encrypted: i=1; AJvYcCWMYNNehiS+PbWC/SMZGPF0r2aVGE7xpTjT4r9mWs7CYOBByvYr6aocRoggL1cs8fCUzeY9/n6Zgb0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDoswkS0mkzQ5/tycmomxGdRLOsP7V9aGqWYUaHLfvPSoEsd3q
	VzM0/vgZ6NSunDCGJ7wBV79Dl8KZdommmCifLA+27flq1MYsNKhkQTNv
X-Gm-Gg: ASbGncuoyz6/C+VcGkd4bIsa+XngVIuZoCgtkaXIJglQEyVghwrIlf52aC23/mn75gZ
	VkIWiqsMQXPXr+yDiLcjhXPMhllCzKU1lWvwb2HfpHs38uUBmssDYeYQ+9SagDWE2wMPC14pPJl
	+DCO4Branoc2C7z08cyFMKl0QzP6AGt4SNibmIisOdJv3vRXjj8tyBHgaJ57clkcOPp1C52HF+3
	7C2igYJAN1hu33PsyMqEHB6dhUhC7+hpfGZdUrpVMPY+3ZJaPVjfbZp8Rs1+n6BnBMMP0tJ7xHG
	MS0obyJ2wnGoPt2RzztytBGQLhQjZ5NEGx2GBBXdgCjlVcIxb2/jc7sTs+pmg5gfoZI8VDlFyNK
	5T6hxM4xXMir1ArkcDxJ7ZZk7V3VjZw==
X-Google-Smtp-Source: AGHT+IFUls6LXsrCLze7uCxm9gIrKR+0qjIy+VauG9zkpfPwn7RwHzjJtZF9/Fq3L/RMfRZn925KxQ==
X-Received: by 2002:a17:907:c09:b0:b04:35c3:40b3 with SMTP id a640c23a62f3a-b07c384b024mr492655366b.15.1757725574734;
        Fri, 12 Sep 2025 18:06:14 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b07d9e18c24sm112553466b.61.2025.09.12.18.06.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 18:06:14 -0700 (PDT)
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
Subject: [PATCH RESEND 24/62] init: remove wrong comment
Date: Sat, 13 Sep 2025 00:38:03 +0000
Message-ID: <20250913003842.41944-25-safinaskar@gmail.com>
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

This comment is wrong. free_initrd_mem may be called
with crashk_end and initrd_end as arguments

Signed-off-by: Askar Safin <safinaskar@gmail.com>
---
 include/linux/initrd.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/initrd.h b/include/linux/initrd.h
index e49c7166dbb3..4080ba82d4c9 100644
--- a/include/linux/initrd.h
+++ b/include/linux/initrd.h
@@ -6,7 +6,6 @@
 /* 1 if it is not an error if initrd_start < memory_start */
 extern int initrd_below_start_ok;
 
-/* free_initrd_mem always gets called with the next two as arguments.. */
 extern unsigned long initrd_start, initrd_end;
 extern void free_initrd_mem(unsigned long, unsigned long);
 
-- 
2.47.2


