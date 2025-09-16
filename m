Return-Path: <linux-efi+bounces-4843-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9723EB58F39
	for <lists+linux-efi@lfdr.de>; Tue, 16 Sep 2025 09:33:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B0FA525AB8
	for <lists+linux-efi@lfdr.de>; Tue, 16 Sep 2025 07:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 330972E8E11;
	Tue, 16 Sep 2025 07:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m2Qa4Ijn"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3C22E8B7D
	for <linux-efi@vger.kernel.org>; Tue, 16 Sep 2025 07:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758007973; cv=none; b=psLLwnw7p/uH0humfhQVaoN+eec0Pnd687cqKtM+ENgUt6nTg9361SnuLGkwOYASIXWsdbfyvQg+mR4pIB/rsufphsnGhIzpMmV94Hd+piYo9Eu7GbwmoI3+zrC3EhZOIRIm/9J8sMebNIMLKnkWzULDUxIZ2SeayiuABnKdW+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758007973; c=relaxed/simple;
	bh=N9FJ77KjbInqACHNXJGNItslR4IJ1lfdL0wiP4soTAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OQGq+b/DzjX8e2LCC1KJTJIhRkImsbfuUDmgg8lBN23O3pQ95VmFfND/a1wIcRk5gSSNzwMdwa3prE3L4MGQ7gpAwz3XmPJEQRP1Oz61KvCntWUmxPwkdgzCrzH9AnwYXJCqkezKASGrYt4p8tigAB+1JDHU1enNghgOLtNE788=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m2Qa4Ijn; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2445805aa2eso43994415ad.1
        for <linux-efi@vger.kernel.org>; Tue, 16 Sep 2025 00:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758007970; x=1758612770; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0qd6DcxlmgvS9aQ39BofpAaJyzv4vGOwbyL9YtDUN+E=;
        b=m2Qa4Ijn2mxy8enfCvmeaMmg9GFqbOHxXc3MuIU/4bMbexqAKgaZbnX9tSKVw18hk+
         8gfSxH9ZaJyXKZbMMvdo0LlR07vf7W8fzD8k7gF1JvChlyPHO/AtrWTj6bjWNdck05U7
         7J870ZLkA6DnxAvjl0VcxPLC0OktYncMk2CHJlcGVJaUvo4mDi0zhuPa+DQ5H+Ry7L1X
         MZOApOBQMuIm8zart8vdAEQz7CFR39hwkU5iFSDXIhZWVVuCEqFzkPnAidiuP2Mjjwb7
         KCniv3rHwEu7i57aG1Tc22Oj3aQb9sChE0iywl2qPlDVCOQlFUaf0TGtWsOVAtW7ZZd0
         mmIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758007970; x=1758612770;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0qd6DcxlmgvS9aQ39BofpAaJyzv4vGOwbyL9YtDUN+E=;
        b=t9SyRLAzk2nY9FioHpVsnTe+XAe65vk0Q/TbOYmPSMoHZtZzSwfzFwb8sWOuCEIGla
         XWrJavw+i9xDDdSRftBgAVeXhvM8P9NeHy5+vg4ePQWDWAM2btRO7RGkUqiiWSuo1VWm
         6omfiU9UohuOfr1hR+0kTNWFYWiSx8rARlXzk2KnvZorULkgjbY0vltkz3S6PQJniCZi
         kjUKG44uCKyO48s8yjIF+5tdYQodPkKUBBYsYFNU5EUV7r+nsf4O7oJswg4O4I4vwHqt
         AVG+mp/FRTMo7xTBUnRMZvp756efQpD0yhioX6g5LuvzipyRNIpFo/8sNb5DFYvsG32a
         eiDQ==
X-Forwarded-Encrypted: i=1; AJvYcCWq0f48aYSwVarZjMyZYCsK6ENoTcmp9BH6bkWWJgsQpePE+XcOK7UkblgUEfhPWgDr9eaHTBTvR3Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQNHUmsYUH9puVx2yE2N8w9CtXqIVpj1vieRA5N+awroHbPVPw
	qi5VoaxDhQ50HoHd7IaoneY8LlHFEj+2ea6MXvlcbCBWV1aWq1wbL5Pp
X-Gm-Gg: ASbGnctcQ3RNYBVGf4qUkGCybi2KjwEhVGLk4qYPhmfLzTdjGY3Selo/PtAlPU/p97S
	QCJc4BzGwSaei61kg6tF7EMilOit9/CrHDQoHg6mITSyoWMv9lUx02vA3ns0yhAKT1WSYcPmwxX
	28S88pT/Ymfmx9UzDKieTomiMnvjYH/2SVkrB2X/ropZFVFBRCyaTfyb+2FLVsITclD2N3Y+gtb
	jwCae7Z1G6kzBnh5kMvpM7w6UgAy2gOWRPIm0lEtm1RZgQ7LtiM8lPf4EefuujW9rpua4jVA/R8
	jubpE4S35XMVm+GknwaQKZn5Bs8KW1KlYCAfl/V02N0qFeQi+/hQ44y7tSCEBhxxm1uoshuoRP/
	xVE0c48H+HoL0HUkUeDTOdyEDqg==
X-Google-Smtp-Source: AGHT+IHlbmq3NUjDyNUWNQ8tAOhUsvQKoh9Ue8wE7ppuENj9P3s/gzDN/spStNwgHsIAuFNeDLKPCw==
X-Received: by 2002:a17:902:d552:b0:260:df70:f753 with SMTP id d9443c01a7336-260df70fbdcmr155594815ad.38.1758007969606;
        Tue, 16 Sep 2025 00:32:49 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2651d2df15esm62519565ad.45.2025.09.16.00.32.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 00:32:48 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id C3A3D420A809; Tue, 16 Sep 2025 14:32:46 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux EFI <linux-efi@vger.kernel.org>
Cc: Ard Biesheuvel <ardb@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Hugo Osvaldo Barrera <hugo@whynothugo.nl>,
	Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH v2] Documentation/x86: explain LINUX_EFI_INITRD_MEDIA_GUID
Date: Tue, 16 Sep 2025 14:32:44 +0700
Message-ID: <20250916073244.590483-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4501; i=bagasdotme@gmail.com; h=from:subject; bh=aM5ZPpX4fqugAwD2VJ1FrGnAK405eAtLfQy6ZZ52Yw0=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDBknhWZFd3WWtGtoM9yXDbww+3fr66cpFqfUHhvJL1B4b 7c0WJi/o5SFQYyLQVZMkWVSIl/T6V1GIhfa1zrCzGFlAhnCwMUpABOZvIThn/Jabq7HecJ/DS5a xCfKC2cIWgRuZtcsXP5+/05pNakER0aGxudvNxw2E3l3m+NU+fddXTwvq9hfbvN+dO2vn9LuFda FDAA=
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

From: Hugo Osvaldo Barrera <hugo@whynothugo.nl>

Since the Handover Protocol was deprecated, the recommended approach is
to provide an initrd using a UEFI boot service with the
LINUX_EFI_INITRD_MEDIA_GUID device path. Documentation for the new
approach has been no more than an admonition with a link to an existing
implementation.

Provide a short explanation of this functionality, to ease future
implementations without having to reverse engineer existing ones.

Signed-off-by: Hugo Osvaldo Barrera <hugo@whynothugo.nl>
Link: https://lore.kernel.org/r/20250428131206.8656-2-hugo@whynothugo.nl
[Bagas: Don't use :ref: link to EFI stub documentation and refer to
OVMF/edk2 implementation]
Co-developed-by: Bagas Sanjaya <bagasdotme@gmail.com>
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
Changes since v1 [1]:

  * Apply wording suggestion (Ard)
  * Replace candyboot reference with OVMF (Ard)
  * Invert patch subject prefix

[1]: https://lore.kernel.org/linux-doc/20250910015738.14848-2-bagasdotme@gmail.com/

 Documentation/admin-guide/efi-stub.rst |  3 ++
 Documentation/arch/x86/boot.rst        | 38 ++++++++++++++++++++------
 2 files changed, 33 insertions(+), 8 deletions(-)

diff --git a/Documentation/admin-guide/efi-stub.rst b/Documentation/admin-guide/efi-stub.rst
index 090f3a185e1897..f8e7407698bd2a 100644
--- a/Documentation/admin-guide/efi-stub.rst
+++ b/Documentation/admin-guide/efi-stub.rst
@@ -79,6 +79,9 @@ because the image we're executing is interpreted by the EFI shell,
 which understands relative paths, whereas the rest of the command line
 is passed to bzImage.efi.
 
+.. hint::
+   It is also possible to provide an initrd using a Linux-specific UEFI
+   protocol at boot time. See :ref:`pe-coff-entry-point` for details.
 
 The "dtb=" option
 -----------------
diff --git a/Documentation/arch/x86/boot.rst b/Documentation/arch/x86/boot.rst
index 77e6163288db08..32eea3d2807e1c 100644
--- a/Documentation/arch/x86/boot.rst
+++ b/Documentation/arch/x86/boot.rst
@@ -1431,12 +1431,34 @@ The boot loader *must* fill out the following fields in bp::
 All other fields should be zero.
 
 .. note::
-     The EFI Handover Protocol is deprecated in favour of the ordinary PE/COFF
-     entry point, combined with the LINUX_EFI_INITRD_MEDIA_GUID based initrd
-     loading protocol (refer to [0] for an example of the bootloader side of
-     this), which removes the need for any knowledge on the part of the EFI
-     bootloader regarding the internal representation of boot_params or any
-     requirements/limitations regarding the placement of the command line
-     and ramdisk in memory, or the placement of the kernel image itself.
+   The EFI Handover Protocol is deprecated in favour of the ordinary PE/COFF
+   entry point described below.
 
-[0] https://github.com/u-boot/u-boot/commit/ec80b4735a593961fe701cc3a5d717d4739b0fd0
+.. _pe-coff-entry-point:
+
+PE/COFF entry point
+===================
+
+When compiled with ``CONFIG_EFI_STUB=y``, the kernel can be executed as a
+regular PE/COFF binary. See Documentation/admin-guide/efi-stub.rst for
+implementation details.
+
+The stub loader can request the initrd via a UEFI protocol. For this to work,
+the firmware or bootloader needs to register a handle which carries
+implementations of the ``EFI_LOAD_FILE2`` protocol and the device path
+protocol exposing the ``LINUX_EFI_INITRD_MEDIA_GUID`` vendor media device path.
+In this case, a kernel booting via the EFI stub will invoke
+``LoadFile2::LoadFile()`` method on the registered protocol to instruct the
+firmware to load the initrd into a memory location chosen by the kernel/EFI
+stub.
+
+This approach removes the need for any knowledge on the part of the EFI
+bootloader regarding the internal representation of boot_params or any
+requirements/limitations regarding the placement of the command line and
+ramdisk in memory, or the placement of the kernel image itself.
+
+For sample implementations, refer to `the original u-boot implementation`_ or
+`the OVMF implementation`_.
+
+.. _the original u-boot implementation: https://github.com/u-boot/u-boot/commit/ec80b4735a593961fe701cc3a5d717d4739b0fd0
+.. _the OVMF implementation: https://github.com/tianocore/edk2/blob/1780373897f12c25075f8883e073144506441168/OvmfPkg/LinuxInitrdDynamicShellCommand/LinuxInitrdDynamicShellCommand.c

base-commit: f44a29784f685804d9970cfb0d3439c9e30981d7
-- 
An old man doll... just what I always wanted! - Clara


