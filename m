Return-Path: <linux-efi+bounces-4718-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55852B50A93
	for <lists+linux-efi@lfdr.de>; Wed, 10 Sep 2025 03:58:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16A124E64B6
	for <lists+linux-efi@lfdr.de>; Wed, 10 Sep 2025 01:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C34E3224AFA;
	Wed, 10 Sep 2025 01:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gHsU3iZm"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A771F473A;
	Wed, 10 Sep 2025 01:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757469482; cv=none; b=Q9BxpZRkhGKkDnlcEePI0fl/E4iQY5r36nclPDC0H2Dhg9dz6uhll1v1tZtwH1IpzNPb9t8Rml1vL+Ud0FJynrSvQAxbc6E7zs4bb/J17sgEn1fdbsfanqD4EUs/jgnFt3L0XrusX8UgKhuGsM9EOAkItfciY3nj9ZuovkUHWsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757469482; c=relaxed/simple;
	bh=DwwSWKWua2fP1JnFtxyFfbR/mFvTt5o9hP0QEXPJ7UY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dd9JG02gIlNlQBs1L30c32UvKzu+dNkszNDB8xKEbHWzo1xq2+CvFu9vfyomJ8tfPJLFKzIElCPpYF4H/dUpY5oAUEuptHcKDjp7bw20uEz5IaRaTjG4h1iWuHueA/2fz7IYK25qnqrvthP9ZiOgq+ggxaM2ZFC7Z8SIlkILWLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gHsU3iZm; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-772679eb358so5904457b3a.1;
        Tue, 09 Sep 2025 18:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757469480; x=1758074280; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5GZjnq9AmQvvJ2VMhIbxJpK0z8GY39o/fsj+KeVvFsc=;
        b=gHsU3iZmVhkqPH9Ov1ENuEaMrkNCZ8vuf/0yd0axHRva2og8/bKWoXd3cpqtfun5C3
         DxvgfWA5bB6s1GCgxwH1kR9hKAgoj/LhdhQVSrJYfuNf6Jip5akWH9H1R6flV//WffQe
         4chGWnzCNJvds+8eE/tIspT4wi/ocmZFd8NmazUQUTH2IRgHTk4s2RvcVgEQt4vDfQrr
         jyMvlfpJdQtvxnKeVyTovXPb6onTgC46/mqny496j4+Mcdz4AeTnCv8eql9Cq6RRqr2T
         3KmCiy9pWN/fyP3nnTOa0sG8Z95ZEm0UBSljYoMaPguC6mztczWO8iWkgtUFxLERb1Kt
         Ds7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757469480; x=1758074280;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5GZjnq9AmQvvJ2VMhIbxJpK0z8GY39o/fsj+KeVvFsc=;
        b=nUbeIhRt0I2ldfaAHsIMkmV2L4tYyy7JOkBsRX0GL9Tmdk1uLlbvJCAGg5YLD5O2PW
         HyN0Zz0AMaoF+DxVqR6JBDTPMRo/Yu91DmNpjg/KRRh1FmtX+QWKRD3TyV4q+GMIRJyJ
         MI+0MZV/ViGiCF9WRZVxoV8kv5PANzVcubDtbOb3rWCkJQ7LpFLM7WFWTn1lIzw4J/AU
         n8O4qY+NeVzO2iamcVO1GMD+JAkVJbalbcLRjz8G6n/9ON4mSPM8o6rg5OUNtGfTpuGA
         6LKDNWu1GfjDZlgL3KgerutOX/BitnPID4c9iLAba+pa37Bw8Movod6xcHDeMHB00Zs4
         Olpw==
X-Forwarded-Encrypted: i=1; AJvYcCWejTRFOx7HCC2Re1mnXI7eyevsrORbqqsU1SbhDiWG3FAeW9Bl/9qDOgkLq3zOsq0MXbT8OD2QYi8T@vger.kernel.org, AJvYcCWqZA1M14u0PJRPzjmhjMUePqQ/YvpZyjbXA+lxRZ/0RvUCIcgpit+wfDipsZjicO/1Xuov+h4fVKY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWYybmOsERGP/thURvdOSwL5+R3uWqkLnjF3JzYVMPZyUu1uFF
	meq96rRm2W1lY58VJFZjDyX9ZhcRpr+e0KUK+YgTdtAvRKxpOPP5fUSGYXSOqd1l
X-Gm-Gg: ASbGncv+cjT5m40bNJfuEf7kxVIguKRegHkW6DgDpN7D2E+a+LilXYS03c0WGvB+VD6
	1QAc5QEpz542MuhjFRjAhho5CpNJGDRYA2/rbDN+VQ+xsq/wBb0nfVNfHo8SFca8f5dFC27pjpm
	oBuGoxLsCDFh3VYQJBryKMhFH0btr4uNIBZ7R6liZQGiGmKdpve9qgoQgPHx5000rRF1xW4IPMI
	Qkjp2Rh1qm/e7IE0WirGzhkgJIObm5TWNDLrr7UoenUJkS+ORBzAQbJQMrt91nB4H+cqWKMjgtZ
	PWFLXom0iVrv3Qihvff0JriLwy0uZTTQYL1jAZzgYzlSMYUZXBDUitrFCdIi2HLyn1Aa4vdr/ne
	YJFctHz12f0Jc3NMqJBxv7aSonzgyQ68TYa0K1N5s7JlkVzs=
X-Google-Smtp-Source: AGHT+IF9ZvsbQcYo1OI1i2Nra/8Uzua4Ps3+RVKqPqc+4dH6P2hNuY3FstQmH2W39cN4w5gWqaTbLw==
X-Received: by 2002:a05:6a00:148d:b0:771:bfed:bd61 with SMTP id d2e1a72fcca58-7742dde5047mr19743321b3a.17.1757469480435;
        Tue, 09 Sep 2025 18:58:00 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-774660e545bsm3452584b3a.19.2025.09.09.18.57.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 18:57:59 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 1E31841FA3A1; Wed, 10 Sep 2025 08:57:57 +0700 (WIB)
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
Subject: [PATCH] x86/Documentation: explain LINUX_EFI_INITRD_MEDIA_GUID
Date: Wed, 10 Sep 2025 08:57:39 +0700
Message-ID: <20250910015738.14848-2-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4037; i=bagasdotme@gmail.com; h=from:subject; bh=EBUSWss9E9WENovDBzaOhhA52uBfbXMQiYxAZXQrvQc=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDBkHbk1Svfbda0dru3/3Tf2iM9+j57vPehbc4mobe+phq NyTyr1zO0pZGMS4GGTFFFkmJfI1nd5lJHKhfa0jzBxWJpAhDFycAjCR/g+MDO1JPBPe/Luy9+pq DY7/k6Ve7X9/nOmZo/i+yX+3zZkUu+4Qw//4oivrYgSuKK/VCvRom+P47Onsj9UhgT9exueFVOu Zt3IBAA==
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
[Bagas: Don't use :ref: link to EFI stub documentation]
Co-developed-by: Bagas Sanjaya <bagasdotme@gmail.com>
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/admin-guide/efi-stub.rst |  3 +++
 Documentation/arch/x86/boot.rst        | 35 ++++++++++++++++++++------
 2 files changed, 30 insertions(+), 8 deletions(-)

diff --git a/Documentation/admin-guide/efi-stub.rst b/Documentation/admin-guide/efi-stub.rst
index 090f3a185e1897..2f0f040f6913a4 100644
--- a/Documentation/admin-guide/efi-stub.rst
+++ b/Documentation/admin-guide/efi-stub.rst
@@ -79,6 +79,9 @@ because the image we're executing is interpreted by the EFI shell,
 which understands relative paths, whereas the rest of the command line
 is passed to bzImage.efi.
 
+.. hint::
+   It is also possible to provide an initrd using UEFI boot services. See
+   :ref:`pe-coff-entry-point` for details.
 
 The "dtb=" option
 -----------------
diff --git a/Documentation/arch/x86/boot.rst b/Documentation/arch/x86/boot.rst
index 77e6163288db08..fadbe66517bdf2 100644
--- a/Documentation/arch/x86/boot.rst
+++ b/Documentation/arch/x86/boot.rst
@@ -1431,12 +1431,31 @@ The boot loader *must* fill out the following fields in bp::
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
+the firmware or bootloader needs to register a handle which implements the
+``EFI_LOAD_FILE2`` protocol with the ``LINUX_EFI_INITRD_MEDIA_GUID`` device
+path. In this case, a kernel booting via the EFI stub will use the ``LoadFile``
+function on the registered handle to obtain a reference to the initrd.
+
+This approach removes the need for any knowledge on the part of the EFI
+bootloader regarding the internal representation of boot_params or any
+requirements/limitations regarding the placement of the command line and
+ramdisk in memory, or the placement of the kernel image itself.
+
+For sample implementations, refer to `the original u-boot implementation`_ or
+`the implementation in candyboot`_.
+
+.. _the original u-boot implementation: https://github.com/u-boot/u-boot/commit/ec80b4735a593961fe701cc3a5d717d4739b0fd0
+.. _the implementation in candyboot: https://git.sr.ht/~whynothugo/candyboot/tree/4097b2538d7f1cf85f03922bf42409490b666202/item/src/main.rs#L225

base-commit: f44a29784f685804d9970cfb0d3439c9e30981d7
-- 
An old man doll... just what I always wanted! - Clara


