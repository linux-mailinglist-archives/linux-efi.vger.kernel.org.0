Return-Path: <linux-efi+bounces-6041-lists+linux-efi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-efi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gGyqE8Ilemlk3QEAu9opvQ
	(envelope-from <linux-efi+bounces-6041-lists+linux-efi=lfdr.de@vger.kernel.org>)
	for <lists+linux-efi@lfdr.de>; Wed, 28 Jan 2026 16:05:38 +0100
X-Original-To: lists+linux-efi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BAEEEA37E9
	for <lists+linux-efi@lfdr.de>; Wed, 28 Jan 2026 16:05:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 25DC6306F248
	for <lists+linux-efi@lfdr.de>; Wed, 28 Jan 2026 14:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5E88366059;
	Wed, 28 Jan 2026 14:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FHH/W3xY"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04CC350A0A
	for <linux-efi@vger.kernel.org>; Wed, 28 Jan 2026 14:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769612356; cv=none; b=Nu3UzYm32nci7YM63C+8FjiuEE72MG+PvPB/ukbDYp9HSbAUiFFEPNwmvNvug+o9nld9+ncKXcI29W9ROAPfW9zrIVbkfJvfhNrQCU0nLu/BZyOKHH+GX4s+iMLtXEBKcrEE4SyG7GnBh77qM6bnKkPC/JOySFeBnc/9pEWmMjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769612356; c=relaxed/simple;
	bh=ONV1dULeWnr7J1TFdP6W/WMXTKfkfXZtG7CtmA+JW2c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=t6/OyLuEhHP4gGIPlgcWpQ4M7wmqDYsd4d9uEKVfG6rBNzO1PXzwOZmQPG7JIwik+srjtrJ8HL8vpA6uP2tzHtZekCgAa37RRngah/5p85s8KPgVyg5qtRY04bIKmQaJ+I5mDGIEaCVSJQ8AcEQaSbMkCe16nepdwTivhRvr8tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FHH/W3xY; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2a12ebe4b74so68086955ad.0
        for <linux-efi@vger.kernel.org>; Wed, 28 Jan 2026 06:59:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769612353; x=1770217153; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zohHYUiSSiWv89YYYBiAoIYe/d4kRFJrNEy84GzqibY=;
        b=FHH/W3xYoFLpins2yJIKceqzcihPWn3SF/80p72LiIjx51YNI8n2bvbSXmtJMFCq5b
         R4BBnn7PxqnggvnJQt/tkjgRG5cGPtp+Yzoe/jWuO6CyeVnzvZWNoaIF1xiDzipBzupF
         /ajp/lHpdGzO58eZijB5WyrOvSTCfZvPngsL5vHPjs82yvqnljVSjyHek3/UWmUqEELb
         3uR+Py+VHfRs5Guf1YzB/QwAe+Yccr6Q38/zHwGi7QD6+E5eM/qeKl5yLkxpp0FB6fls
         nQXzu6ONWxdnJ+A9ahQrqO4OtlakzH1iL/1u5OfbhbBjEXGpO8LZWPHNAzQq4JxqAxLl
         ZB9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769612353; x=1770217153;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zohHYUiSSiWv89YYYBiAoIYe/d4kRFJrNEy84GzqibY=;
        b=Jkg11RlTqhOBNxKaqcqIpCgdwy31s3Wb4N3yWGuXXEMGEOIh/ZHfFeLesU5NG5tv7/
         0lMwQQf2mnn4pNjNJklvQRO4bQtM0XF1WfAWxllW8dkS2Zn/0MqSwWpYnca2b12pNnm+
         RQ4vRoSfsRolS53wCoSsv/ZEbJ1ef+bPbEkko5WgUG80x52qvlTOU5H8S+qLBommWDDd
         lIkJFn6zzGUtOw/4ZLfqqxih9wp8LGVo8aE3tV5uF0z/2q1MkcHe476PW63gIBGT/cSS
         RydBnaJyZamQqDkOxcMx3JbgD0LjymmAiIVe84VrBZqJ5J+yegGiPXjJaxyW6cRO3FMF
         DNXw==
X-Forwarded-Encrypted: i=1; AJvYcCWCZld2EIsDjXIMwCpIYLi1ldYmkAfgKcOHMlIt/esWzKjx01X97Dks0WPX4e6V0cdmRBSioeBM/7k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1UaA47/XmAOTRhqEdeVGD4xPqK8S7t48mzu5f+dgRLwv5X4mM
	YW0SmqMEi4HpPxWQeLqSZJiHeCB+ZFJwEWwmP6UP4R6M+3vWgDts9/gJyOD4
X-Gm-Gg: AZuq6aJKPITFopTIY3pvIyf0O2WWC4ckxl1sNFgSeMB4JsCJ1IBM4hRsKry0UW2YdCM
	+r8ZLc9uMr19YYLr8UX+7WeFWTx4GKfdN1ALGKjXziM+SBWkTcSSvzjP3qV3mfqyCjzXJPvFHad
	WVNXhvAc2d/MlcQoy3UGZUiI4/QHpkcLvCqBwFRcKLBrYrvUfvhHAB0yExbYeeRiOGq9HClqGO2
	pPH+J3bzzo6IE8GNjpLZbEGW5ndmhmV3fcCuP1udvoivsVWnzxFuy5IJwG+sdxlMnBjVBQy6f5o
	vtF39e31ULoT4r8H8Nwp2Av3zkk/CRTo4/QyXzW+CNT3iAJBM77DDMt2klQSluvUd2HH5JAB2mQ
	DEGHu7fys3y5DMj4Ycli9gym0yT5sDHuP1gB0ZBQkX5IDS4pti7Ixn7/+kj+/0Rw4PFFRkDrLX+
	7QK7ShkypuqKMW
X-Received: by 2002:a17:903:1a88:b0:2a3:e7b6:ab53 with SMTP id d9443c01a7336-2a870db403amr54053765ad.22.1769612352864;
        Wed, 28 Jan 2026 06:59:12 -0800 (PST)
Received: from at.. ([171.61.161.8])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b5d9a7bsm25820235ad.79.2026.01.28.06.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 06:59:12 -0800 (PST)
From: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
To: 
Cc: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Lenny Szubowicz <lszubowi@redhat.com>,
	Ingo Molnar <mingo@kernel.org>,
	Francesco Pompo <francescopompo2@gmail.com>,
	linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH v2 0/2] Add support for eGPUs on Apple Products
Date: Wed, 28 Jan 2026 14:58:36 +0000
Message-ID: <20260128145855.1071-1-atharvatiwarilinuxdev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6041-lists,linux-efi=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,linux.intel.com,intel.com,ursulin.net,ffwll.ch,redhat.com,suse.de,vger.kernel.org,lists.freedesktop.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[atharvatiwarilinuxdev@gmail.com,linux-efi@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-efi];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BAEEEA37E9
X-Rspamd-Action: no action

This series adds support for eGPUs on Apple products, by
enabling apple-set-os on all apple devices.

A side effect of this patch is that the iGPU becomes enabled on iMacs.
However, iMacs can’t use the iGPU to drive the display
(They can't link-train the internal display),
so displays must be disabled on iMacs.

Changes in v2:
- Reworded cover-letter
- Transferred logic to has_no_display in the 2nd patch

Link to v1:
https://lore.kernel.org/all/20260125001111.1269-1-atharvatiwarilinuxdev@gmail.com/

Atharva Tiwari (2):
  efi/libstub: enable apple-set-os for all apple devices
  drm/i915/display: Disable display for iMac's

 drivers/firmware/efi/libstub/x86-stub.c       | 22 +++++--------------
 .../drm/i915/display/intel_display_device.c   | 13 ++++++++++-
 2 files changed, 17 insertions(+), 18 deletions(-)

-- 
2.43.0


