Return-Path: <linux-efi+bounces-5930-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 651CCCE845E
	for <lists+linux-efi@lfdr.de>; Mon, 29 Dec 2025 23:06:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3250B3014A2F
	for <lists+linux-efi@lfdr.de>; Mon, 29 Dec 2025 22:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D625330D32;
	Mon, 29 Dec 2025 22:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="J3U5jqto"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-pl1-f225.google.com (mail-pl1-f225.google.com [209.85.214.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D7B23128BC
	for <linux-efi@vger.kernel.org>; Mon, 29 Dec 2025 22:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767045979; cv=none; b=tAx1H6ytxtEZ8ufa2Epgvy52IxZXH7AO4N6BdSg5s726jZsBfGwItgBMp7l/YLwicYTg8vyn1MdmhY/Iu1ZCzSnv71Ldvvik8yxkfFQ5OTXGQfK+Mrt4gBv2hJ3kOxfwPo5rVugZIqwe99TCIAbeHhYEB2IuT6R9h2tnPH/N4B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767045979; c=relaxed/simple;
	bh=y5YIqKVzOgea1hEskvVJXNFijZ0oP6nkRby64GmSm8c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nH5gnsrRlc+I/P00jbUXFwMwOvY6MzUEZt1NN7bUNncd+C+bONc2fo5V2ZtiTujm9PW1dQO8LfkMaQFX1FYn42HD1E3rghJMnxqk/bgb5X0xLRGk5xFfxgFsLFj2fLySuKturpIQrd0HUS9JcIOjmx7SMBqMtHB9D9XtWPo1dM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=J3U5jqto; arc=none smtp.client-ip=209.85.214.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f225.google.com with SMTP id d9443c01a7336-2a09a3bd9c5so83983795ad.3
        for <linux-efi@vger.kernel.org>; Mon, 29 Dec 2025 14:06:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767045977; x=1767650777;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UwzcNp2HYOV4Z1mSXVXCsNd5TObEfxUddJJZvW7JJZk=;
        b=sTA5OwQW++QPjyI0QTAkW6VS3KgZ4kOa62Sdc1iIxrNOMRIcxXbfTwxGC+nfOgPrhQ
         OxmU/zcoxDjdhVcQnN9dIKg1WvE7GvC9El62xfuLxn6EcecswWSMm5yHhuULLn7GraHz
         ZZBaPtYUrZWW6i7aluhT6R2huIYKdm2PAWJS6gZW69+4yfRNTrV85OzBNs6eS3lQBvOB
         PTG6b8/2frjnhqqNT6scNBhXrwyzBWv2GkLIvXzlMpH3u/0v66xs930QTxb1o50/6SYD
         JGz3nuK/y6qr40gfq5sAifnIhfmRpNgFTRCysHPnXdDN6GharXMYV/GbQXUq4tUMHvbw
         BbZA==
X-Forwarded-Encrypted: i=1; AJvYcCUZSMbmwp8k4jsofJTA/0CvjZBEWl3yy0FSxecshWzUKtP8pK+5nRhKd5tMH1znrAO+I7HEBTgpmok=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMesEZo53e2aFf+QKymJSt56F2UgSRiIn3aR2r7/6o/FHFwS4N
	HI613IAfPZ/sUHRXEX3FeYX6jtAuVOYE+BDPYXtGhqCQdz2396ePf2DMjiWrQyq9kPuBjx5khzY
	JVZAjdNYDQoRtANUoAiVdMjfy46pzkol7uodRMDLwhQMV73faP13guAdgIdyFCMmAUcAcpyB1x1
	kZC5mDf7xrcdOZjf5YmzPysDyfCp/UZHrj6bwm3AQTL0AQ3WsZNunMBRDu4whigjBVOPdMWpC50
	5aq0+qwbTwW
X-Gm-Gg: AY/fxX4iqnZtNReHhB1pGnx0km+BKaXbXgXvKX34xEsl/sQwEhoWFb2fm8/kFO9/Vss
	yy4GBc0NwZ2IxXKPJoe7XF4uJnKClpzdpjJtEIkyRc7MVgF5sA64tCQPJ8jbbzQl9kNlgMhkuke
	ERmm8M760harCxUg7MwzNpc+asbzNygLY3aloAbSAOJH92Ehlq6IhkiCzoUnAlmpQRIixXE36Ir
	5Bk6Ur/8fsm2cMQ8aKkyJ9RbQ3i51lLjq4Mg2QxtJyD2e3EuA7UyaG30X1GAUMMncNMld7MBHyz
	mPGv9bhFV0YZl6lKJTjOcvb2iQ6gDib5fB4KBRv4QJ25bHlwR7hMNyRIWKzNZZAtO1Gwh/wqAXj
	sZPwR1huFW56KwZXf9hUBTtrNpVlUZHDDq/H5d5CbyFwiEx3VELpfeap8i4oqnZLALqiOW8kQ55
	7B9BMKiNs++GOHaqX8eMGiiYq++cSxMuOeRO2wTc5xSNe9
X-Google-Smtp-Source: AGHT+IFrjiNHBs9f9hrDlxyfEtCsi8T1JdWOcDHExlukVI5+BioWeN458yiDUEZn7hADw6S9Zv83tmlUA6r7
X-Received: by 2002:a17:903:2345:b0:2a0:d629:9035 with SMTP id d9443c01a7336-2a2f220cebfmr315840155ad.3.1767045976697;
        Mon, 29 Dec 2025 14:06:16 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-101.dlp.protect.broadcom.com. [144.49.247.101])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2a2f3c65c3dsm33527185ad.10.2025.12.29.14.06.16
        for <linux-efi@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Dec 2025 14:06:16 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4f1d7ac8339so350251121cf.2
        for <linux-efi@vger.kernel.org>; Mon, 29 Dec 2025 14:06:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1767045975; x=1767650775; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UwzcNp2HYOV4Z1mSXVXCsNd5TObEfxUddJJZvW7JJZk=;
        b=J3U5jqtoHRmr3Mzs72fT8wrmQaLg/ehuDJDD71Xm9kkmbGrcLCChrwL99HGlRYqll0
         G5ffd1C5TvilxspIW1ydaPjr8Uvh/Xc5sDqqkRqQ2STJZSxu1PhCPiDtoUExgMLv/pY9
         WCd9tsyAFzZfXljDvffRlBMO1kMfigysrxasY=
X-Forwarded-Encrypted: i=1; AJvYcCX9F6Grj2TUhvFVoIeUDcp8x+rwJ16EUWygELqiYhJa0kDgOZKNkRKSUrmM4Nb3sL5/cDEIPsxhphQ=@vger.kernel.org
X-Received: by 2002:a05:6214:428e:b0:88a:3681:1d96 with SMTP id 6a1803df08f44-88d881b984fmr478636036d6.63.1767045551435;
        Mon, 29 Dec 2025 13:59:11 -0800 (PST)
X-Received: by 2002:a05:6214:428e:b0:88a:3681:1d96 with SMTP id 6a1803df08f44-88d881b984fmr478635666d6.63.1767045550918;
        Mon, 29 Dec 2025 13:59:10 -0800 (PST)
Received: from localhost.localdomain (pool-173-49-113-140.phlapa.fios.verizon.net. [173.49.113.140])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88d9759f164sm231530026d6.24.2025.12.29.13.59.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Dec 2025 13:59:10 -0800 (PST)
From: Zack Rusin <zack.rusin@broadcom.com>
To: dri-devel@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>,
	amd-gfx@lists.freedesktop.org,
	Ard Biesheuvel <ardb@kernel.org>,
	Ce Sun <cesun102@amd.com>,
	Chia-I Wu <olvaffe@gmail.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Dave Airlie <airlied@redhat.com>,
	Deepak Rawat <drawat.floss@gmail.com>,
	Dmitry Osipenko <dmitry.osipenko@collabora.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Gurchetan Singh <gurchetansingh@chromium.org>,
	Hans de Goede <hansg@kernel.org>,
	Hawking Zhang <Hawking.Zhang@amd.com>,
	Helge Deller <deller@gmx.de>,
	intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Jocelyn Falempe <jfalempe@redhat.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Lijo Lazar <lijo.lazar@amd.com>,
	linux-efi@vger.kernel.org,
	linux-fbdev@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Lyude Paul <lyude@redhat.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	"Mario Limonciello (AMD)" <superm1@kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Maxime Ripard <mripard@kernel.org>,
	nouveau@lists.freedesktop.org,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Simona Vetter <simona@ffwll.ch>,
	spice-devel@lists.freedesktop.org,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	=?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	virtualization@lists.linux.dev,
	Vitaly Prosyak <vitaly.prosyak@amd.com>
Subject: [PATCH 00/12] Recover sysfb after DRM probe failure
Date: Mon, 29 Dec 2025 16:58:06 -0500
Message-ID: <20251229215906.3688205-1-zack.rusin@broadcom.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Almost a rite of passage for every DRM developer and most Linux users
is upgrading your DRM driver/updating boot flags/changing some config
and having DRM driver fail at probe resulting in a blank screen.

Currently there's no way to recover from DRM driver probe failure. PCI
DRM driver explicitly throw out the existing sysfb to get exclusive
access to PCI resources so if the probe fails the system is left without
a functioning display driver.

Add code to sysfb to recever system framebuffer when DRM driver's probe
fails. This means that a DRM driver that fails to load reloads the system
framebuffer driver.

This works best with simpledrm. Without it Xorg won't recover because
it still tries to load the vendor specific driver which ends up usually
not working at all. With simpledrm the system recovers really nicely
ending up with a working console and not a blank screen.

There's a caveat in that some hardware might require some special magic
register write to recover EFI display. I'd appreciate it a lot if
maintainers could introduce a temporary failure in their drivers
probe to validate that the sysfb recovers and they get a working console.
The easiest way to double check it is by adding:
 /* XXX: Temporary failure to test sysfb restore - REMOVE BEFORE COMMIT */
 dev_info(&pdev->dev, "Testing sysfb restore: forcing probe failure\n");
 ret = -EINVAL;
 goto out_error;
or such right after the devm_aperture_remove_conflicting_pci_devices .

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Ce Sun <cesun102@amd.com>
Cc: Chia-I Wu <olvaffe@gmail.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: Danilo Krummrich <dakr@kernel.org>
Cc: Dave Airlie <airlied@redhat.com>
Cc: Deepak Rawat <drawat.floss@gmail.com>
Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: dri-devel@lists.freedesktop.org
Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Gurchetan Singh <gurchetansingh@chromium.org>
Cc: Hans de Goede <hansg@kernel.org>
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Cc: Helge Deller <deller@gmx.de>
Cc: intel-gfx@lists.freedesktop.org
Cc: intel-xe@lists.freedesktop.org
Cc: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Javier Martinez Canillas <javierm@redhat.com>
Cc: Jocelyn Falempe <jfalempe@redhat.com>
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: Lijo Lazar <lijo.lazar@amd.com>
Cc: linux-efi@vger.kernel.org
Cc: linux-fbdev@vger.kernel.org
Cc: linux-hyperv@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: Lyude Paul <lyude@redhat.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: "Mario Limonciello (AMD)" <superm1@kernel.org>
Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: nouveau@lists.freedesktop.org
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Simona Vetter <simona@ffwll.ch>
Cc: spice-devel@lists.freedesktop.org
Cc: "Thomas Hellström" <thomas.hellstrom@linux.intel.com>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: "Timur Kristóf" <timur.kristof@gmail.com>
Cc: Tvrtko Ursulin <tursulin@ursulin.net>
Cc: virtualization@lists.linux.dev
Cc: Vitaly Prosyak <vitaly.prosyak@amd.com>

Zack Rusin (12):
  video/aperture: Add sysfb restore on DRM probe failure
  drm/vmwgfx: Use devm aperture helpers for sysfb restore on probe
    failure
  drm/xe: Use devm aperture helpers for sysfb restore on probe failure
  drm/amdgpu: Use devm aperture helpers for sysfb restore on probe
    failure
  drm/virtio: Add sysfb restore on probe failure
  drm/nouveau: Use devm aperture helpers for sysfb restore on probe
    failure
  drm/qxl: Use devm aperture helpers for sysfb restore on probe failure
  drm/vboxvideo: Use devm aperture helpers for sysfb restore on probe
    failure
  drm/hyperv: Add sysfb restore on probe failure
  drm/ast: Use devm aperture helpers for sysfb restore on probe failure
  drm/radeon: Use devm aperture helpers for sysfb restore on probe
    failure
  drm/i915: Use devm aperture helpers for sysfb restore on probe failure

 drivers/firmware/efi/sysfb_efi.c           |   2 +-
 drivers/firmware/sysfb.c                   | 191 +++++++++++++--------
 drivers/firmware/sysfb_simplefb.c          |  10 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |   9 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |   7 +
 drivers/gpu/drm/ast/ast_drv.c              |  13 +-
 drivers/gpu/drm/hyperv/hyperv_drm_drv.c    |  23 +++
 drivers/gpu/drm/i915/i915_driver.c         |  13 +-
 drivers/gpu/drm/nouveau/nouveau_drm.c      |  16 +-
 drivers/gpu/drm/qxl/qxl_drv.c              |  14 +-
 drivers/gpu/drm/radeon/radeon_drv.c        |  15 +-
 drivers/gpu/drm/vboxvideo/vbox_drv.c       |  13 +-
 drivers/gpu/drm/virtio/virtgpu_drv.c       |  29 ++++
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.c        |  13 +-
 drivers/gpu/drm/xe/xe_device.c             |   7 +-
 drivers/gpu/drm/xe/xe_pci.c                |   7 +
 drivers/video/aperture.c                   |  54 ++++++
 include/linux/aperture.h                   |  14 ++
 include/linux/sysfb.h                      |   6 +
 19 files changed, 368 insertions(+), 88 deletions(-)

-- 
2.48.1


