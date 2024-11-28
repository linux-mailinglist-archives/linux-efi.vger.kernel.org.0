Return-Path: <linux-efi+bounces-2229-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CACCA9DB9DA
	for <lists+linux-efi@lfdr.de>; Thu, 28 Nov 2024 15:46:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C4FD1642A0
	for <lists+linux-efi@lfdr.de>; Thu, 28 Nov 2024 14:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C524194A7C;
	Thu, 28 Nov 2024 14:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gLqxnHeL"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5912233A;
	Thu, 28 Nov 2024 14:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732805181; cv=none; b=ZTiHwTUGlmDJ21V+PKQ+N3TxEv0kfMRYEJwWS3hpG/ksEUu4Dg6o1YC9nNqCiTNIw7MmHUicDyzJ3nglhZXk7FPbWTSBRVoYFkXoiiZOc4M+hYh9B0fI9ku4wPXXDVTYqsf+lN8IUN0FOJBq/CM0SD9+Hjz4kzp3PbRqMrOWgWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732805181; c=relaxed/simple;
	bh=nM1YIPt3xK38HIq6W7KgltvqgYeZUWpbOdjuEOs7MXI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rw9JyXTnJ+otFxUYcbRmG87zUq70KnQKmxefoaK6Vdb7yenF7IGYM6Gv9WLXXcrKRzgpwMihlNBeRpfoURxxUYM3S3OfYEScxjYYRzX+folYrS+mnc7pmX86sR3UojNkfcG+6P3HxbflIuvs6cM1jXXyxjvVr/u3h60EeyS8+DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gLqxnHeL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF529C4CECE;
	Thu, 28 Nov 2024 14:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732805179;
	bh=nM1YIPt3xK38HIq6W7KgltvqgYeZUWpbOdjuEOs7MXI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gLqxnHeLM6Tw/I4WrTnBd+q5Uip3+dASDuKZZ+2tZkbtfbXXus/i9H/fgp1VIv8h3
	 bHF9y9Ct3P4EJ9Pq0xMLSj6dwcu0K+NA/O1nReIJ9yzLaXHqBXL2H+brl+ldE6EcxT
	 bl7p8iyuAxF+s2kQWETekR0krUKRVJv7WLaFJOXEBZg0My5hVNk4PR/f1ppPwlP+uJ
	 jPp+08iIJPZ7+Zh8ehE2ZUT/kLYuzOm4QE/fNGtl3LMyPAKyk5HgjiFytkJXyVjWVr
	 LiEPYZWf8/1W0itAZav+k6pyqaQGn9vMi+yAZi2W0vATufEi1YsU3RS3nRFUukuMFw
	 9T63WSdwRJfdQ==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1tGfmW-000000000mo-0NFf;
	Thu, 28 Nov 2024 15:46:12 +0100
Date: Thu, 28 Nov 2024 15:46:12 +0100
From: Johan Hovold <johan@kernel.org>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Leif Lindholm <leif.lindholm@oss.qualcomm.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Ricardo Salveti <ricardo@foundries.io>,
	Marc Zyngier <maz@kernel.org>, linux-efi@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: UEFI EBS() failures on Lenovo T14s
Message-ID: <Z0iCNJVWNzBzdq0C@hovoldconsulting.com>
References: <Z0gn1N3IsP8r3gTA@hovoldconsulting.com>
 <CAMj1kXGjiA1HydMaY82MQsYvkchpN7v7CMOB5i3NEdqcYGn19Q@mail.gmail.com>
 <Z0g_HL01eqXu4cwQ@hovoldconsulting.com>
 <CAMj1kXFtr7ejEjjSRj9dcRa7YbO0SR5OR3pm+K6OvbX2=RfhAQ@mail.gmail.com>
 <CAMj1kXHS_TY=jfBT=dqUQSXf2pBXbt12uaLsMw-FLX3uU_X6uA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXHS_TY=jfBT=dqUQSXf2pBXbt12uaLsMw-FLX3uU_X6uA@mail.gmail.com>

On Thu, Nov 28, 2024 at 12:05:09PM +0100, Ard Biesheuvel wrote:

> If you're happy to experiment more, you could try and register a
> notification for EFI_EVENT_GROUP_BEFORE_EXIT_BOOT_SERVICES using
> CreateEventEx(), and see if it gets called when ExitBootServices() is
> called. That would at least help narrow it down.

Thanks for the suggestion.

I see the notify function being called when I signal it as well as on
each ExitBootServices().

With an efi_printk() in the callback ExitBootServices() fails as
expected, but with an empty function the kernel seems to start every
time.

Interestingly, ExitBootServices() now succeeds also if I add back the
CloseEvent() call. In fact, it works also if I never signal the event
(i.e. if I just create and close the event).

The patch below should suffice as a workaround I can carry until the
firmware has been fixed.

Johan


From 1464360c7c16d1a6ce454bf88ee5815663f27283 Mon Sep 17 00:00:00 2001
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
ExitBootServices() can make the call succeed. When providing a
notification function there apparently is no need to actually signal the
event group and CloseEvent() could also be called directly.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 .../firmware/efi/libstub/efi-stub-helper.c    | 24 +++++++++++++++++++
 drivers/firmware/efi/libstub/efistub.h        |  4 ++--
 2 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
index de659f6a815f..9c9c7a1f1718 100644
--- a/drivers/firmware/efi/libstub/efi-stub-helper.c
+++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
@@ -409,6 +409,13 @@ char *efi_convert_cmdline(efi_loaded_image_t *image, int *cmd_line_len)
 	return (char *)cmdline_addr;
 }
 
+#define EFI_EVENT_GROUP_BEFORE_EXIT_BOOT_SERVICES \
+	EFI_GUID(0x8be0e274, 0x3970, 0x4b44,  0x80, 0xc5, 0x1a, 0xb9, 0x50, 0x2f, 0x3b, 0xfc)
+
+static void efi_before_ebs_notify(efi_event_t event, void *context)
+{
+}
+
 /**
  * efi_exit_boot_services() - Exit boot services
  * @handle:	handle of the exiting image
@@ -429,10 +436,27 @@ efi_status_t efi_exit_boot_services(void *handle, void *priv,
 {
 	struct efi_boot_memmap *map;
 	efi_status_t status;
+	efi_guid_t guid = EFI_EVENT_GROUP_BEFORE_EXIT_BOOT_SERVICES;
+	efi_event_t event;
 
 	if (efi_disable_pci_dma)
 		efi_pci_disable_bridge_busmaster();
 
+	status = efi_bs_call(create_event_ex, EFI_EVT_NOTIFY_SIGNAL,
+			     EFI_TPL_CALLBACK, efi_before_ebs_notify, NULL,
+			     &guid, &event);
+	if (status == EFI_SUCCESS) {
+		status = efi_bs_call(signal_event, event);
+		if (status != EFI_SUCCESS)
+			efi_err("%s - signal event failed: %02lx\n", __func__, status);
+
+		status = efi_bs_call(close_event, event);
+		if (status != EFI_SUCCESS)
+			efi_err("%s - close event failed: %02lx\n", __func__, status);
+	} else {
+		efi_err("%s - create event ex failed: %02lx\n", __func__, status);
+	}
+
 	status = efi_get_memory_map(&map, true);
 	if (status != EFI_SUCCESS)
 		return status;
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


