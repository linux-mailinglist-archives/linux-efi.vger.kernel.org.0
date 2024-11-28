Return-Path: <linux-efi+bounces-2224-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23A159DB39E
	for <lists+linux-efi@lfdr.de>; Thu, 28 Nov 2024 09:20:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDD0D1651EF
	for <lists+linux-efi@lfdr.de>; Thu, 28 Nov 2024 08:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CC051494A7;
	Thu, 28 Nov 2024 08:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vDFQCVU2"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC311482ED;
	Thu, 28 Nov 2024 08:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732782045; cv=none; b=UMRHvLgasBV18SQGTASUda0UxrhyytORHwpkJkW7PES62Fn1p1hCrCD9HcH/whRGYhB2bm+eUxZFx31K+pFicc8TWejmJEsbB1Tv+oW2H4ZVtw7/JWQQIEH1DD3/NHY2GzgPnoiDOudeXq7FBm9i1M7GtHmCbLPbFSGIMdRUQiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732782045; c=relaxed/simple;
	bh=hZXAETzwQyZavk9H2dN1vMoO8dtxzQj8THoXMEj0S3o=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=IDh+0HYqVw3qVN1ZQq3k9MIkln8T9QQEAnJzpkHdzw0wEClKRA2XIxbbJfs6N/MC1S+03V7i8D0Tk1Dg/qbckN4g8/2gAqPxVjrhisOv2Y1G/5EFRvupH5jUUDAQ5ApiZldU9sqDafyQJxequhHqR+ZKrn9SCEZEMIcyxPnrdio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vDFQCVU2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1D92C4CECE;
	Thu, 28 Nov 2024 08:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732782044;
	bh=hZXAETzwQyZavk9H2dN1vMoO8dtxzQj8THoXMEj0S3o=;
	h=Date:From:To:Cc:Subject:From;
	b=vDFQCVU2kCPXrf32ExLyf2WRXISubMmu8N+ZzyMGpZTbQg3RdTGFIWiNZ65zy+Lr8
	 QpSCO3hCcQDOBDMHE/y1h0Pquf4h0YSbBDMwJb8uG2TsB8pFzMENjGCypuT80lZdmv
	 4ZdMQenkk9x0iNfZPbM+L0/71UyptGib+m1qTY72z/VR+84DE6t9mTrYPsGioZpkix
	 7ul55mOhfK6gIm3F0mAU9vSab1VwY4EJnb7dskcajxbKqdwWPxOss1wVkaq0C3DFKS
	 gwXp+KlYOAAyRfWw69AqxJfftLE9Me8uSA4RHNuYpAfDWgkCI2VYZLJp5KHDmS8Tp7
	 NQ56WdaSk503g==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1tGZlM-000000003QH-3uzK;
	Thu, 28 Nov 2024 09:20:36 +0100
Date: Thu, 28 Nov 2024 09:20:36 +0100
From: Johan Hovold <johan@kernel.org>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Ricardo Salveti <ricardo@foundries.io>,
	Marc Zyngier <maz@kernel.org>, linux-efi@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: UEFI EBS() failures on Lenovo T14s
Message-ID: <Z0gn1N3IsP8r3gTA@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Ard,

We've run into a buggy UEFI implementation on the Qualcomm Snapdragon
based Lenovo ThinkPad T14s where ExitBootServices() often fails.

One bootloader entry may fail to start almost consistently (once in a
while it may start), while a second entry may always work even when the
kernel, dtb and initramfs images are copies of the failing entry on the
same ESP.

This can be worked around by starting and exiting a UEFI shell from the
bootloader or by starting the bootloader manually via the Boot Menu
(F12) before starting the kernel.

Notably starting the kernel automatically from the shell startup.nsh
does not work, while calling the same script manually works.

Based on your comments to a similar report for an older Snapdragon based
Lenovo UEFI implementation [1], I discovered that allocating an event
before calling ExitBootServices() can make the call succeed. There is
often no need to actually signal the event group, but the event must
remain allocated (i.e. CloseEvent() must not be called).

(Raising TPL or disabling interrupts does not seem to help.)

Also with the event signalling, ExitBootServices() sometimes fails when
starting the kernel automatically from a shell startup.nsh, while
systemd-boot seems to always work. This was only observed after removing
some efi_printk() used during the experiments from the stub...

Something is obviously really broken here, but do you have any
suggestions about what could be the cause of this as further input to
Qualcomm (and Lenovo) as they try to fix this?

For completeness, the first call to ExitBootServices() often fails also
on the x1e80100 reference design (CRD), and Qualcomm appears to have
been the ones providing the current retry implementation:

	fc07716ba803 ("efi/libstub: Introduce ExitBootServices helper")

as this was needed to prevent similar boot failures with older Qualcomm
UEFI fw.

Marc is also hitting something like this on the Qualcomm X1E devkit
(i.e. with firmware that should not have any modifications from Lenovo).

I'm attaching the patch that allows me to boot kernels on the T14s
below.

Johan


[1] https://bugzilla.kernel.org/show_bug.cgi?id=216375#c10


From 4ceece4e15e87d0949110b835b867e7cea1bd658 Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan+linaro@kernel.org>
Date: Wed, 27 Nov 2024 16:05:37 +0100
Subject: [PATCH] hack: efi/libstub: fix t14s exit_boot_services() failure

The UEFI firmware on the Lenovo ThinkPad T14s is broken and
ExitBootServices() often fails and prevents the kernel from starting:

	EFI stub: Exiting boot services...
	EFI stub: Exit boot services failed.

One bootloader entry may fail to start almost consistently (once in a
while it may start), while a second entry may always work even when the
kernel, dtb and initramfs images are copies of the failing entry on the
same ESP.

This can be worked around by starting and exiting a UEFI shell from the
bootloader or by starting the bootloader manually via the Boot Menu
(F12) before starting the kernel.

Notably starting the kernel automatically from the shell startup.nsh
does not work, while calling the same script manually works.

Experiments have revealed that allocating an event before calling
ExitBootServices() can make the call succeed. There is often no need to
actually signal the event group, but the event must remain allocated
(i.e. CloseEvent() must not be called).

Also with the event signalling, ExitBootServices() sometimes fails when
starting the kernel automatically from a shell startup.nsh, while
systemd-boot seems to always work. This was only observed after removing
some efi_printk() used during the experiments from the stub...

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 .../firmware/efi/libstub/efi-stub-helper.c    | 20 +++++++++++++++++++
 drivers/firmware/efi/libstub/efistub.h        |  4 ++--
 2 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
index de659f6a815f..f228895bf090 100644
--- a/drivers/firmware/efi/libstub/efi-stub-helper.c
+++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
@@ -409,6 +409,9 @@ char *efi_convert_cmdline(efi_loaded_image_t *image, int *cmd_line_len)
 	return (char *)cmdline_addr;
 }
 
+#define EFI_EVENT_GROUP_BEFORE_EXIT_BOOT_SERVICES \
+	EFI_GUID(0x8be0e274, 0x3970, 0x4b44,  0x80, 0xc5, 0x1a, 0xb9, 0x50, 0x2f, 0x3b, 0xfc)
+
 /**
  * efi_exit_boot_services() - Exit boot services
  * @handle:	handle of the exiting image
@@ -429,10 +432,26 @@ efi_status_t efi_exit_boot_services(void *handle, void *priv,
 {
 	struct efi_boot_memmap *map;
 	efi_status_t status;
+	efi_guid_t guid = EFI_EVENT_GROUP_BEFORE_EXIT_BOOT_SERVICES;
+	efi_event_t event;
 
 	if (efi_disable_pci_dma)
 		efi_pci_disable_bridge_busmaster();
 
+	status = efi_bs_call(create_event_ex, 0, 0, NULL, NULL, &guid, &event);
+	if (status == EFI_SUCCESS) {
+		status = efi_bs_call(signal_event, event);
+		if (status != EFI_SUCCESS)
+			efi_err("%s - signal event failed: %02lx\n", __func__, status);
+#if 0
+		status = efi_bs_call(close_event, event);
+		if (status != EFI_SUCCESS)
+			efi_err("%s - close event failed: %02lx\n", __func__, status);
+#endif
+	} else {
+		efi_err("%s - create event ex failed: %02lx\n", __func__, status);
+	}
+
 	status = efi_get_memory_map(&map, true);
 	if (status != EFI_SUCCESS)
 		return status;
@@ -446,6 +465,7 @@ efi_status_t efi_exit_boot_services(void *handle, void *priv,
 	status = efi_bs_call(exit_boot_services, handle, map->map_key);
 
 	if (status == EFI_INVALID_PARAMETER) {
+		//efi_err("Exit boot services failed: %lx\n", status);
 		/*
 		 * The memory map changed between efi_get_memory_map() and
 		 * exit_boot_services().  Per the UEFI Spec v2.6, Section 6.4:
diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index 685098f9626f..e3f710823a29 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -272,7 +272,7 @@ union efi_boot_services {
 		efi_status_t (__efiapi *wait_for_event)(unsigned long,
 							efi_event_t *,
 							unsigned long *);
-		void *signal_event;
+		efi_status_t (__efiapi *signal_event)(efi_event_t);
 		efi_status_t (__efiapi *close_event)(efi_event_t);
 		void *check_event;
 		void *install_protocol_interface;
@@ -322,7 +322,7 @@ union efi_boot_services {
 		void *calculate_crc32;
 		void (__efiapi *copy_mem)(void *, const void *, unsigned long);
 		void (__efiapi *set_mem)(void *, unsigned long, unsigned char);
-		void *create_event_ex;
+		efi_status_t (__efiapi *create_event_ex)(u32, int, void *, void *, void *, efi_event_t *);
 	};
 	struct {
 		efi_table_hdr_t hdr;
-- 
2.45.2


