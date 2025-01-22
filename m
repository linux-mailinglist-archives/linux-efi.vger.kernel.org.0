Return-Path: <linux-efi+bounces-2703-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68979A18960
	for <lists+linux-efi@lfdr.de>; Wed, 22 Jan 2025 02:12:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE6297A211B
	for <lists+linux-efi@lfdr.de>; Wed, 22 Jan 2025 01:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B38E3A1B6;
	Wed, 22 Jan 2025 01:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q5KISnRX"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9F4BE4F;
	Wed, 22 Jan 2025 01:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737508323; cv=none; b=fNbveXHC1tQjVGEKlD8daOV8LEDs/mnD/p6yHU3kaJ1Acct8RtTTyMPHGBxHaQIfcwRBvEHTBHASV85IHuVWr54AUK9kL+Qm44mmLOXRtvSAsL0c7usuzU2KtFDVYglC4Kg3FRvBiQftRZkVH4oI8kRE3T7AA7zn1pg2HR+D/Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737508323; c=relaxed/simple;
	bh=067qh52MfqeD4l0GQAtDp3/NCk6XWOSjca1yHE7uihY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=CG21Z1KZWPBbTJXFx8MSFqevYtvM4prxbEVnCNLqQ3eg8525dQxblWUCPXh8Ka9vnEoI04e9506XrE2fZE8n9BPWjfS65+mA8vmwmA01CVNJFIBC/ZuRGinNzF0aoiLgR++o8OG6fReyktv1Hl7EyRrZmGTol7gO+TdT/VplmJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q5KISnRX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F008C4CEDF;
	Wed, 22 Jan 2025 01:11:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737508322;
	bh=067qh52MfqeD4l0GQAtDp3/NCk6XWOSjca1yHE7uihY=;
	h=From:Subject:Date:To:Cc:From;
	b=Q5KISnRXviFE93iNloOmVYItSt9m5V+yUGWvK8GHXokxIeL9eQFBPLO3FjjLa/lGL
	 FAix8n3UaLJtauUwIgRcYRwfsUgrwhb/Z6UNSLETl+VCk99Q92in8sHtevo7+5Uwyp
	 PwGpp4JTb+p5QnE+VQXXY9BQkg0Un2BVzJBmn8WjMA3LuNeBnUL/JHzji3bEfqxWzQ
	 U8BbVKM3V2S6JK1eUYPz2BB+RU/6B4EKn3QYYl0XuDBF16YylIbBoVt7uJBUqsSH8W
	 g4w4C9nGuAQ3gfeMpAVFio84foHwLIgsr0vncYwvRQSIdnJpaONR4kpWvOj4S2W7B8
	 8MRfLWV3NW4Tg==
From: Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH 0/2] A couple of build fixes for x86 when using GCC 15
Date: Tue, 21 Jan 2025 18:11:32 -0700
Message-Id: <20250121-x86-use-std-consistently-gcc-15-v1-0-8ab0acf645cb@kernel.org>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMRFkGcC/x3NwQqDMAyA4VeRnBdIipXpq8gOo6YuIFWaOhTx3
 Vd2/C7/f4FJVjEYmguyfNV0TRX8aCB83mkW1KkaHDlP7BiPZ4e7CVqZMKzJ1Iqkspw4h4DsMfa
 e206IPEWolS1L1ON/GF/3/QNO5jgkcQAAAA==
X-Change-ID: 20250121-x86-use-std-consistently-gcc-15-f95146e0050f
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, Ard Biesheuvel <ardb@kernel.org>
Cc: Kees Cook <kees@kernel.org>, Sam James <sam@gentoo.org>, 
 Masahiro Yamada <masahiroy@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org, 
 stable@vger.kernel.org, 
 Kostadin Shishmanov <kostadinshishmanov@protonmail.com>, 
 Jakub Jelinek <jakub@redhat.com>, Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1045; i=nathan@kernel.org;
 h=from:subject:message-id; bh=067qh52MfqeD4l0GQAtDp3/NCk6XWOSjca1yHE7uihY=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDOkTXO/t7amujVa7v3bl8u4HvUsDXCrjQzMjffNW3e3UP
 nvndc/cjlIWBjEuBlkxRZbqx6rHDQ3nnGW8cWoSzBxWJpAhDFycAjCR8FsM/8yeuJrmhqk4Ljgu
 9mvyNCaDBt8LGacP7QtPmKb7dKl+7n6GPxzuyzp4w95oB2ttSan13Z5hzN8vMaHne9YEB5ZVa8M
 /8wMA
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

Hi all,

GCC 15 changed the default C standard version from gnu17 to gnu23, which
reveals a few places in the kernel where a C standard version was not
set, resulting in build failures because bool, true, and false are
reserved keywords in C23 [1][2]. Update these places to use the same C
standard version as the rest of the kernel, gnu11.

[1]: https://lore.kernel.org/4OAhbllK7x4QJGpZjkYjtBYNLd_2whHx9oFiuZcGwtVR4hIzvduultkgfAIRZI3vQpZylu7Gl929HaYFRGeMEalWCpeMzCIIhLxxRhq4U-Y=@protonmail.com/
[2]: https://lore.kernel.org/Z4467umXR2PZ0M1H@tucnak/

---
Nathan Chancellor (2):
      x86/boot: Use '-std=gnu11' to fix build with GCC 15
      efi: libstub: Use '-std=gnu11' to fix build with GCC 15

 arch/x86/boot/compressed/Makefile     | 1 +
 drivers/firmware/efi/libstub/Makefile | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)
---
base-commit: ffd294d346d185b70e28b1a28abe367bbfe53c04
change-id: 20250121-x86-use-std-consistently-gcc-15-f95146e0050f

Best regards,
-- 
Nathan Chancellor <nathan@kernel.org>


