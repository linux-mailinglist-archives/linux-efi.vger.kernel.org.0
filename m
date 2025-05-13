Return-Path: <linux-efi+bounces-3683-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4883FAB5564
	for <lists+linux-efi@lfdr.de>; Tue, 13 May 2025 14:58:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0CDC3BF893
	for <lists+linux-efi@lfdr.de>; Tue, 13 May 2025 12:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FA6628DB4C;
	Tue, 13 May 2025 12:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O72exmpP"
X-Original-To: linux-efi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E3E28D8DA
	for <linux-efi@vger.kernel.org>; Tue, 13 May 2025 12:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747141108; cv=none; b=ouT3in22SGC7WxAqBEpNSqGKqf+J2qpDj2XxWRCbe9YhAHSXcVMswVAN2fyosnEPgkCVjcTN+cb9XvZKCHq5Vj4cT4//WslW6rQEIWmAjvwvXqfzHtbxRlhtG2zxpH78c+KtH8QmVtAZHIpPQU/Ungl8s2ehlbUFvdANYjlEypI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747141108; c=relaxed/simple;
	bh=T0sXzZEZf8SnXjc4Pqz33S9vO5BZO+cUZAga5earu9M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gZlzmqi+YLxA/Tyf7vICsnvr6pbwouxJDe9KWZkGXplAjE7aXlz6HHLSwdTVxnmOQRLRqAlc1jnkex2wYfurnpe8oUP7iD/GfM2+JOV6xkLhzk4CCSRR3ZWA09h5usCSKumCNA0tJXwKlk+q7Djnp8nN3HybOlvlGmMKazpCvG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O72exmpP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747141105;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=tucWRC3XFzuFyx+C0oC/MLuVq9IHMPkKp/mbZoswM9Q=;
	b=O72exmpPWhkkj5YzvErPZk17U3/yTGnRBZoT4/9y5oAyCaw0sk1eK8LNL6IPjNCs3sWkXk
	hvS+nu8XyzikHmXyjqj0UvZXjtwUMQWWCf0EgPjJiNf4Tlf/TO4/GtqMrqacfKcqisuSB2
	Tvqp5ZTSDEnMZNA8ma8mGG8XlFo2pAk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-570-EwsnQiaINuKII31rE5n2Tg-1; Tue,
 13 May 2025 08:58:22 -0400
X-MC-Unique: EwsnQiaINuKII31rE5n2Tg-1
X-Mimecast-MFC-AGG-ID: EwsnQiaINuKII31rE5n2Tg_1747141099
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5E8F51800115;
	Tue, 13 May 2025 12:58:18 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.225.16])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 33A1C30001A1;
	Tue, 13 May 2025 12:58:09 +0000 (UTC)
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
Subject: [PATCH v3 0/2] efi: Add a mechanism for embedding SBAT section
Date: Tue, 13 May 2025 14:58:06 +0200
Message-ID: <20250513125808.75510-1-vkuznets@redhat.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Changes since v2 (Ard):
(https://lore.kernel.org/linux-efi/20250505154523.231233-1-vkuznets@redhat.com/)
- Use 'textsize' intermediary in arch/x86/boot/header.S to avoid additional
 '#ifdef CONFIG_EFI_SBAT'.
- Fix indentation.
- Added R-b tags.

Original description:

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
  efi: zboot specific mechanism for embedding SBAT section
  x86/efi: Implement support for embedding SBAT data for x86

 arch/x86/boot/Makefile                      |  2 +-
 arch/x86/boot/compressed/Makefile           |  5 ++++
 arch/x86/boot/compressed/sbat.S             |  7 +++++
 arch/x86/boot/compressed/vmlinux.lds.S      |  8 ++++++
 arch/x86/boot/header.S                      | 31 +++++++++++++++------
 drivers/firmware/efi/Kconfig                | 24 ++++++++++++++++
 drivers/firmware/efi/libstub/Makefile.zboot |  4 +++
 drivers/firmware/efi/libstub/zboot-header.S | 22 +++++++++++++--
 drivers/firmware/efi/libstub/zboot.lds      | 11 ++++++++
 9 files changed, 102 insertions(+), 12 deletions(-)
 create mode 100644 arch/x86/boot/compressed/sbat.S

-- 
2.49.0


