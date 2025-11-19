Return-Path: <linux-efi+bounces-5610-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id AF3BFC6E7DD
	for <lists+linux-efi@lfdr.de>; Wed, 19 Nov 2025 13:34:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 6EA742E41F
	for <lists+linux-efi@lfdr.de>; Wed, 19 Nov 2025 12:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5356135A954;
	Wed, 19 Nov 2025 12:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dDitblf8"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7032935A94D
	for <linux-efi@vger.kernel.org>; Wed, 19 Nov 2025 12:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763555425; cv=none; b=pH1gmlsVJl7ZdH7ZuAlhVuVRp3swNOiQTpb8lQRSANJ9cnoqdS5PFL6MF/AxTPHl3Pa1fAIljQ3oV7Ad7f7EurBUeXNGovTB0bLMYWeYkZlv1To1Kwv3k08uIoyWdVGeu6jMwOvA4oIsuHPPUT4w8wSwAzmJnfalifrZoEDA//I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763555425; c=relaxed/simple;
	bh=r4woHUrhRL2IJe9Jn/vdqXxo2jUBTsR+ZBeRLMkjYbk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=QrIvhHWOZ8deif7CjsUXS23RqIslRNL2+S4tympW9QFB4Ma8RVKboDKBGIxAKlsrGB9cV5d6s442Kj6QKTS9UZjoiwRSg4TqH2Ks8I37VhTIHTReRWoyiKqhwWflpUKWj7jmfJFrQt4NtOukdl0RxTG2LZb9Sdr8LtUc43r8jh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dDitblf8; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-42b2b642287so3882608f8f.2
        for <linux-efi@vger.kernel.org>; Wed, 19 Nov 2025 04:30:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763555420; x=1764160220; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vTW89jrmvWQq6MNIEJqSqAliMDiYe8LvHf2aMeGrMm8=;
        b=dDitblf8HN/O4fqqL6XqVhRJmUh1rO9LWnNSp6KmxRgWdwmMMG69dYbdO8ZIV6fcWm
         WPerOD9PnNJHGXnY17d0nwMnwKOT1zE3p9uIz/yiUskqLXHsdtJQxF6cZgEFeZuRGMDD
         bydRSburXZA9nkvn4/M1fIHPLeGUubJildkh77tr5FxBXKA2uVRiwzxS72XWTmCNlqrT
         udYpwRLh/cTjawLDZNCXY7hf/sU5dsVGdwFojnMV2c2GRpr08SXOrFIwHZUr+sB4kgm4
         wkZjAlZrXixAHZrzPAxgjRH/a/MflgE+vmFG4Im6MsvRJzYxQV7HEILZ1FlTaxuVUPBq
         US2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763555420; x=1764160220;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vTW89jrmvWQq6MNIEJqSqAliMDiYe8LvHf2aMeGrMm8=;
        b=k+QxhBcGV/TaEENxslb+hDjFsCK6PXFOr3AZHa68H1HGITbzzrZDUb+uGKlozn6O54
         1QfffX5F/lcsVEsku/D/YMAPy6H0Uadxnd+0/NlYqKpkYQS6Dat07P2f5e/13AIY3wAW
         A2ZU3n0QMvh1nlqthK4t2OvWSMwvK8NUgR4QKJlvOxy3dE9GWgD9WIf83UivdhrSPVCo
         OCkfriTu0vdwfbtPWoHDxr9s5+wrUiXAAb3yPOMZa7Xj/UF3WJdvjxARaHbjcur9omgD
         1LCJqaP5HyUnS3KM+U1lI+JR7JoCF6CoMQvvimm+Svgx5JOIoDwIO9OgHqEMKL5Wb8NR
         5qWA==
X-Gm-Message-State: AOJu0Ywo4O1Jb1u2gktsdqTxmZqnEaDq3mTF+7D4H4EVEUSpBSfsmzwN
	gaIXnOZMF4T+WZqmdSAuQG6Acws9dDV+dkgYkJ7kI0mxDaU6FiQJ5rsKBCZ4XisynCOdXlMLfDP
	771nuuSuGtRuThKaLU1vQ+S3Wf+OMziI0lI4JwSTQR4739q+pt8rMJHwOuHaZ6LAzZxUDWeXTQi
	/Y/wwGatFj1IJW99o0hXjVtWL+O3qivQ==
X-Google-Smtp-Source: AGHT+IGDQ4MyC5vgGvfUbYUgKyUgnbodGaXz1mDin/posO7PudK59p8ZuqqyycSexS58rgi6gWPtb8bi
X-Received: from wrqh17.prod.google.com ([2002:a5d:4311:0:b0:42b:31dd:5803])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6000:3108:b0:42b:3ee9:4775
 with SMTP id ffacd0b85a97d-42b593394a9mr20900804f8f.11.1763555420385; Wed, 19
 Nov 2025 04:30:20 -0800 (PST)
Date: Wed, 19 Nov 2025 13:30:12 +0100
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1489; i=ardb@kernel.org;
 h=from:subject; bh=m3ZpKtpsCFwXPmxxht6hmpe2omPvu5woEIwbMl9GhAY=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIVN2R0hfbCVP6OaCezxtrI+Cw78/clZ55icp6GVSMenYh
 M2L/rzqKGVhEONikBVTZBGY/ffdztMTpWqdZ8nCzGFlAhnCwMUpABOJucnI8EPwvsrZW9+cmTLv
 teg634iUOfQj4e3pPUEtm/Yotqc7WDP8FbP9n7hjfu3E5E7ZD7/6Nrv8995QZDfRz+Sr4LVVwVr BXAA=
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
Message-ID: <20251119123011.1187249-5-ardb+git@google.com>
Subject: [PATCH 0/3] video/efi: Support FIRMWARE_EDID on non-x86
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-efi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Javier Martinez Canillas <javierm@redhat.com>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Refactor the screen_info handling so non-x86 platforms booting via the
EFI stub also have access to the EDID data exposed by the EFI boot
services.

Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Javier Martinez Canillas <javierm@redhat.com>

Ard Biesheuvel (3):
  efi: Wrap screen_info in efi_screen_info so edid_info can be added
    later
  video/edid: Use getter function for edid_info
  efi: Add FIRMWARE_EDID support

 arch/x86/kernel/setup.c                       |  8 ++++++--
 drivers/firmware/efi/earlycon.c               |  1 -
 drivers/firmware/efi/efi-init.c               | 19 ++++++++++++++-----
 drivers/firmware/efi/libstub/efi-stub-entry.c |  3 +--
 drivers/firmware/efi/libstub/efi-stub.c       | 16 ++++++++++------
 drivers/firmware/efi/libstub/efistub.h        |  9 +++------
 drivers/firmware/efi/libstub/gop.c            |  1 -
 drivers/firmware/efi/libstub/screen_info.c    |  7 +++----
 drivers/firmware/efi/libstub/zboot.c          |  2 +-
 drivers/firmware/efi/sysfb_efi.c              |  1 -
 drivers/gpu/drm/sysfb/efidrm.c                |  4 ++--
 drivers/gpu/drm/sysfb/vesadrm.c               |  4 ++--
 drivers/video/Kconfig                         |  2 +-
 drivers/video/fbdev/core/fbmon.c              |  4 ++--
 include/linux/efi.h                           | 10 +++++++++-
 include/video/edid.h                          |  2 +-
 16 files changed, 55 insertions(+), 38 deletions(-)

-- 
2.52.0.rc1.455.g30608eb744-goog


