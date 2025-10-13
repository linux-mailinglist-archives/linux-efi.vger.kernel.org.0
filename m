Return-Path: <linux-efi+bounces-5032-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A9A0BD22BE
	for <lists+linux-efi@lfdr.de>; Mon, 13 Oct 2025 10:57:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 037A94EDB4F
	for <lists+linux-efi@lfdr.de>; Mon, 13 Oct 2025 08:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 201032DF139;
	Mon, 13 Oct 2025 08:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m2gKTCSY"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB5634BA41
	for <linux-efi@vger.kernel.org>; Mon, 13 Oct 2025 08:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760345851; cv=none; b=pw+Ibx2VAEgCmvfEgEeKi8w+suKGqbyyXaMfhMzsglN3i0EAS8lKGK57PV8cw8OisFXI8Z6bKEUniRCKtpvrPVNBn1soBYQn0c2Gkt/xUWByKsRYs1sW/9lovsmICtrXgVCPQSnBK0esVT62kYwe3XG151SSEpCopkdNYWfiQng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760345851; c=relaxed/simple;
	bh=PbjBUK1Z7pXMZ1LfaCuEVsag2X/hL916dnnkBuDLQYs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KbRJFBndYpsoJYmkXzemixVOZUTzpgRAWX/lGQJtb3lUnUYJ78fNDHnKs8Y+txO1fTTtN6ptHCGf9ZdCCsYRFQCSUKVWDIAAPlDS3ySpn45Qfo3z+JThhL/JvC9V1sqsNOzUF2BZnxOpJjhhcPjyUKqxYVW4X7osqfiUzxVolOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m2gKTCSY; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-791c287c10dso3403597b3a.1
        for <linux-efi@vger.kernel.org>; Mon, 13 Oct 2025 01:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760345849; x=1760950649; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9i4BBpfXsDT8eFnFn/jmS3zn1/Abb7iqLYlBRwjQgWU=;
        b=m2gKTCSYk0mI2pgteGHGkyNPjl7VDQo8t7fe/6UN19lnQ9nefk5JQ76jqzQN5rX1eg
         4EKhD7Hx8PItYNw0drwupNGTEtZrGn5dtcwZolrZnQgxoEfvvuEFoo1AZ3cQiYUXmaY6
         e84xCXZGgxn5S9jUWi8+FGKVFYGUmSEep2uufftGTCiK4+npHiBrO404ALJeCAuNwcmZ
         fnKbWADEey3dUYw/uGRGaKg+3JzS9438FiMW//gHAcl4rH24A4D8SHPl9Xm9dnRXvVnF
         iamtKjz2wXKt7zJ/7XKLfjiD6zy4YTzBXgSb3Ihf3heCyiCr7pTXjtDKHT/32phSmkBb
         EIBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760345849; x=1760950649;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9i4BBpfXsDT8eFnFn/jmS3zn1/Abb7iqLYlBRwjQgWU=;
        b=GOpW37GCKqQ3NdjMgK+t/zjmeiTj7UCwr1BLSDXLDwTq/YCYFL2p8hVl79lsIxFJUn
         zjfqVmPv6aVX5/qGu7jWWUvYnu16T19thZgAftAICHj4VQ2DsWyAWDaG4t6Diton+JPo
         VMMV+9SGLdDZSLlypUAbmsnN6jhqYCWC7kTYjXRUR1q77CGbeDslLBlisxrZ4WjuwgFC
         Mh1/zkf3Cun8lXELJYHwcdvt0dBzKdTaynJZKU0R/Q8N3mxSmbks5YqN5FS5gKIct//p
         xzOePS+rZc4iwWsdjOdO9eoUCvb4rvPBOEze7bniYKcSm5pmOHcS7UbpA6y9njbUG+vt
         sdDg==
X-Forwarded-Encrypted: i=1; AJvYcCWDy5nc4kxZtxF4GFnCva1nqT3pbyNpgJG1HtRD9M3lICSOdPl4f0GJ7yYpupINEqL7w57oabRAPfo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQI32ztIaqvjb9oKfc0R+1Oc+vcSQR/oMcC3VBEjiq0vQZHZnv
	PlYOYZfcbMqHzNcKBicQUdPtLm+0cew4TBr+cdotRRGu5WcbmJmCuy95dvBX3EXE
X-Gm-Gg: ASbGncvep7eauBoTaC8kW9JFUAmqmLzZxcK/Pw7cnbmdOszXyTBGUd+C5SbhvNl7mwt
	dhC92qZvAxB7m0uFj+JKbWZFRw4oORunPitFRXylZgBnfTyRoQMF9i+GrHwHapdFXl6p/dRH3ro
	+Qzp5b4Xc+PYV5n1ClU0mRr//faTatlS8ogXAI0xJ1sTcyDxK3xGvi1ViHK1Rb7IkwVnPj8odeP
	rL9B426IMYAjS+ohdab0b0/aNuJwUonuQFK6ilpOD5hnRX45OUT1VdDlet/Z61fNsFiHZhGDOi+
	zmuzjSrF3dxyxw0VEHtParW7JvvL8PAg2tLGbVZbAvxmQ2cH2o/Ic7R3tJXJ8dXlIzKaHV+gQC7
	wL/zgqpixKm0fZKkk6KCvH6IymjBpbOQnEjTucTqJ77D36JqlOCsSXz0=
X-Google-Smtp-Source: AGHT+IEchI617YKWuzuNKaFi+lyotd9RD/lcD21mjz/5MfFqEjsOczpStBEFEZvQnAKRfjX4ZFT9TA==
X-Received: by 2002:a05:6a21:999d:b0:266:1f27:a01e with SMTP id adf61e73a8af0-32da839fe85mr26147206637.39.1760345848542;
        Mon, 13 Oct 2025 01:57:28 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992d096527sm10786617b3a.44.2025.10.13.01.57.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 01:57:27 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 257F4424BFFB; Mon, 13 Oct 2025 15:57:25 +0700 (WIB)
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
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Hugo Osvaldo Barrera <hugo@whynothugo.nl>
Subject: [PATCH v3] Documentation/x86: explain LINUX_EFI_INITRD_MEDIA_GUID
Date: Mon, 13 Oct 2025 15:57:18 +0700
Message-ID: <20251013085718.27085-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4509; i=bagasdotme@gmail.com; h=from:subject; bh=UnARZcEOs3ird8NeNavJwy55YoDgK0PnaYvM7PciqCM=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDBlv9lX5Xt6xpaaw3UHTfOeuZaYXIg5dKGXmn1Z/gZs7/ nXW8j87OkpZGMS4GGTFFFkmJfI1nd5lJHKhfa0jzBxWJpAhDFycAjARG2eGf5psv962P7G5sXlF rs1GxcMvhP9bdXes1fjufE5jsp/rQweGfyr2a24903vhpy30OmXmjt/zAksyjq2T98lU8Fu3W0t PhxMA
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
No changes since v2 [1].

EFI/x86 maintainers: Would you like to apply this patch on tip/efi tree
or let Jon handle it through docs-next instead?

[1]: https://lore.kernel.org/linux-doc/20250916073244.590483-1-bagasdotme@gmail.com/

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

base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
-- 
An old man doll... just what I always wanted! - Clara


