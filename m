Return-Path: <linux-efi+bounces-3448-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ACDFA9A563
	for <lists+linux-efi@lfdr.de>; Thu, 24 Apr 2025 10:11:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D2E87AF134
	for <lists+linux-efi@lfdr.de>; Thu, 24 Apr 2025 08:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEFE2201035;
	Thu, 24 Apr 2025 08:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hw0A6NrR"
X-Original-To: linux-efi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0180A1E9B00
	for <linux-efi@vger.kernel.org>; Thu, 24 Apr 2025 08:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745482219; cv=none; b=qjMbZYB4Lqfp9xkHgueaPOL0hfaVP9QRpGIQOKUuYD2QHPGHLYSWjZ/4fQcnHkazdjjSI2fqlFcPYkL39G38EaU699tamZ6uoHzbfa650pqMgSZkcWjkgHg7CTnEQ53x5fn3VIbO8869aMGSkMQDBW+qhBO+d2hnyd+l3AOcVWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745482219; c=relaxed/simple;
	bh=k2UBmoUMCKhFXCdGdxw238KcC86Dq7f7xe7KDiWi77c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iVlznyKf0PA1dptXYBly5u/kZMhlPX1zp4DE5hP4z7JMETPIlDqyYxgieZmpzRtA7QCwBflJKC+Ey7nkge7xkMJvVESG/u7LHLnwqDNvhwWd2ke0FTjc/042raaAPclg43TOL9PoDSKfY0dmrmZwlRuiDFSkltd1drb+omsBOp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Hw0A6NrR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745482216;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=PZaDOlwgs+a0eg3mppTrQoff4ytVBOHdk4tnOUhy/gU=;
	b=Hw0A6NrRn0ohmXNuhdBjlPrjPbi1blRSqkcAov9YU58Wa+IK+/LPgpPoHMFeZNvRh9sps2
	/PYGifSBlZ1AKyouwqlem0Wa1bishsvNYkKflTGQ/ruLpjsE9teRCpA0++DEhR81I123aG
	oge4wheP84e7gQTBgaWE1NJUfu3rOsg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-404-kVvFzdLzNvuPIu-z6mnAIg-1; Thu,
 24 Apr 2025 04:10:15 -0400
X-MC-Unique: kVvFzdLzNvuPIu-z6mnAIg-1
X-Mimecast-MFC-AGG-ID: kVvFzdLzNvuPIu-z6mnAIg_1745482212
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id ED54C1800264;
	Thu, 24 Apr 2025 08:10:10 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.224.198])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E142F30001A2;
	Thu, 24 Apr 2025 08:09:52 +0000 (UTC)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: x86@kernel.org,
	linux-efi@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Peter Jones <pjones@redhat.com>,
	Daniel Berrange <berrange@redhat.com>,
	Emanuele Giuseppe Esposito <eesposit@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Greg KH <gregkh@linuxfoundation.org>,
	Luca Boccassi <bluca@debian.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Matthew Garrett <mjg59@srcf.ucam.org>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] efi: Add a mechanism for embedding SBAT section
Date: Thu, 24 Apr 2025 12:09:48 +0400
Message-ID: <20250424080950.289864-1-vkuznets@redhat.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Changes since RFC:
(https://lore.kernel.org/linux-efi/20250305101744.1706803-1-vkuznets@redhat.com/)

- Implement SBAT embedding for zboot. (Smoke tested on aarch64 only,
 apologies if I missed some important differences on other arches!)
 It would've been possible to implement SBAT embedding for !zboot case 
 too I think but this looks like an unnecessary complication: 
 SecureBoot signing is likely to be done by distro vendors only and these
 will likely want zboot enabled anyway.
  
- x86: Thanks to Ard, CRC32 is now gone (see commit 9c54baab4401 ("x86/boot:
 Drop CRC-32 checksum and the build tool that generates it")) and thus
 SBAT can be placed to the very end of the binary, this simplifies things
 a bit.

SBAT is a mechanism which improves SecureBoot revocations of UEFI binaries
by introducing a generation-based technique. Compromised or vulnerable UEFI
binaries can be prevented from booting by bumping the minimal required
generation for the specific component in the bootloader. More information
on the SBAT can be obtained here:

https://github.com/rhboot/shim/blob/main/SBAT.md

Currently, shim checks .sbat data for itself in self-test and for second
stage bootloaders (grub, sd-boot, UKIs with sd-stub, ...) but kernel
revocations require cycling signing keys or adding kernel hashes to shim's
internal dbx. Adding .sbat to kernel and enforcing it on kernel loading
will allow to do the same tracking and revocation distros are already
doing with a simplified mechanism, and without having to keep lists of
kernels outside of the git repos.

Previously, an attempt was made to add ".sbat" section to the linux kernel:

https://lwn.net/Articles/938422/

The approach was rejected mainly because currently there's no policy on how
to update SBAT generation number when a new vulnerability is discovered. In
particular, it is unclear what to do with stable kernels which may or may
not backport certain patches making it impossible to describe the current
state with a simple number.

This series suggests a different approach: instead of defining SBAT
information, provide a mechanism for downstream kernel builders (distros)
to include their own SBAT data. This leaves the decision on the policy to
the distro vendors. Basically, each distro implementing SecureBoot today,
will have an option to inject their own SBAT data during kernel build and
before it gets signed by their SecureBoot CA. Different distro do not need
to agree on the common SBAT component names or generation numbers as each
distro ships its own 'shim' with their own 'vendor_cert'/'vendor_db'. Linux
upstream will never, ever need to care about the data unless they choose in
the future to participate in that way.

Vitaly Kuznetsov (2):
  efi/libstub: zboot specific mechanism for embedding SBAT section
  x86/efi: Implement support for embedding SBAT data for x86

 arch/x86/boot/Makefile                      |  2 +-
 arch/x86/boot/compressed/Makefile           |  2 ++
 arch/x86/boot/compressed/vmlinux.lds.S      | 13 +++++++++++
 arch/x86/boot/header.S                      | 13 +++++++++++
 drivers/firmware/efi/Kconfig                | 25 +++++++++++++++++++++
 drivers/firmware/efi/libstub/Makefile       |  7 ++++++
 drivers/firmware/efi/libstub/Makefile.zboot |  3 ++-
 drivers/firmware/efi/libstub/sbat.S         |  7 ++++++
 drivers/firmware/efi/libstub/zboot-header.S | 14 ++++++++++++
 drivers/firmware/efi/libstub/zboot.lds      | 17 ++++++++++++++
 10 files changed, 101 insertions(+), 2 deletions(-)
 create mode 100644 drivers/firmware/efi/libstub/sbat.S

-- 
2.49.0


