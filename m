Return-Path: <linux-efi+bounces-926-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5972489AB21
	for <lists+linux-efi@lfdr.de>; Sat,  6 Apr 2024 15:52:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88DC01C20C61
	for <lists+linux-efi@lfdr.de>; Sat,  6 Apr 2024 13:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B82B2374C4;
	Sat,  6 Apr 2024 13:52:12 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33CC213ACC;
	Sat,  6 Apr 2024 13:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712411532; cv=none; b=Q33Yu3yflhIdnRXeHSsLWGVTmN+pTiAyCsMO9QWRtyglEfytxZNDLVKeoVXJGUhdWmbeU/eErFjcMdihw1UJAaHIZ2UEGA4Lld1uqMIOy8tHOuYy06aS1RLlVKn12JLNXgpeqcdx1o5iVha9UJIl67WpySVgtg3S7SXul/5XqYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712411532; c=relaxed/simple;
	bh=c4P6XCqXe/1/PyNm0hEV/fhObLttlXBUccidgoz+KNA=;
	h=Message-Id:From:Date:Subject:To:Cc; b=mMlODrFL13/cWyvrkYkx65xwMpCoVHsmPZGNQd/w/SVmm3Z9wc5V/f9w9+vV3bds3ENFFIaq/pn8E5nfsdbO1aUPhZgIcBoM8//qjW5aPJ03Kf8XTuspVnsIJFB3d6OVfWNxfVvIy8Q21Zpw2VAQiWcOTw3AaMltZ2Lq+HagSxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id 94813100D943C;
	Sat,  6 Apr 2024 15:51:59 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 3B10F233389; Sat,  6 Apr 2024 15:51:59 +0200 (CEST)
Message-Id: <cover.1712410202.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Sat, 6 Apr 2024 15:52:00 +0200
Subject: [PATCH 0/2] Deduplicate bin_attribute simple read() callbacks
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org
Cc: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org, Jean Delvare <jdelvare@suse.com>, Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org, Zhenyu Wang <zhenyuw@linux.intel.com>, Zhi Wang <zhi.wang.linux@gmail.com>, intel-gvt-dev@lists.freedesktop.org, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>, linux-modules@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>

For my upcoming PCI device authentication v2 patches, I have the need
to expose a simple buffer in virtual memory as a bin_attribute.

It turns out we've duplicated the ->read() callback for such simple
buffers a fair number of times across the tree.

So instead of reinventing the wheel, I decided to introduce a common
helper and eliminate all duplications I could find.

I'm open to a bikeshedding discussion on the sysfs_bin_attr_simple_read()
name. ;)

Lukas Wunner (2):
  sysfs: Add sysfs_bin_attr_simple_read() helper
  treewide: Use sysfs_bin_attr_simple_read() helper

 arch/powerpc/platforms/powernv/opal.c              | 10 +-------
 drivers/acpi/bgrt.c                                |  9 +-------
 drivers/firmware/dmi_scan.c                        | 12 ++--------
 drivers/firmware/efi/rci2-table.c                  | 10 +-------
 drivers/gpu/drm/i915/gvt/firmware.c                | 26 +++++----------------
 .../intel/int340x_thermal/int3400_thermal.c        |  9 +-------
 fs/sysfs/file.c                                    | 27 ++++++++++++++++++++++
 include/linux/sysfs.h                              | 15 ++++++++++++
 init/initramfs.c                                   | 10 +-------
 kernel/module/sysfs.c                              | 13 +----------
 10 files changed, 56 insertions(+), 85 deletions(-)

-- 
2.43.0


