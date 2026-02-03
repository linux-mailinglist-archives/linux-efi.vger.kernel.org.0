Return-Path: <linux-efi+bounces-6081-lists+linux-efi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-efi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2MJDJvikgWktIQMAu9opvQ
	(envelope-from <linux-efi+bounces-6081-lists+linux-efi=lfdr.de@vger.kernel.org>)
	for <lists+linux-efi@lfdr.de>; Tue, 03 Feb 2026 08:34:16 +0100
X-Original-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E49D6D5C1E
	for <lists+linux-efi@lfdr.de>; Tue, 03 Feb 2026 08:34:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3B98930994DF
	for <lists+linux-efi@lfdr.de>; Tue,  3 Feb 2026 07:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF6362FE04E;
	Tue,  3 Feb 2026 07:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GMKWlEEl"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53DC52EFDA2
	for <linux-efi@vger.kernel.org>; Tue,  3 Feb 2026 07:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770103912; cv=none; b=bMmAkP/hk3DBUgBrPh1vXv0T1qO6mjGZhLtYz7A3z9aNGKhJ1Y94M6AxZ8OkCUBu3i/VHikKB3Qt5NqvNLBCD/vEMl4GkrmMtEz/oAjteV1OPzvXxZlQ0N7/FGz7tCbsz1kUl0la6yV9bdj02+LXtBi8UAWFRqfKoWmTJ+FCP60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770103912; c=relaxed/simple;
	bh=45PIjMo/z6DggtsXPfuJkBLlw0PtjHPx4PhAmUfs/pM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VPAUJt0tFLWgSbfNhucFory8MYpbuVnys7gaq8IqsEtVZh061ZkrBeOGqaawFE5GnJrxLahX+rEDDKreFHAj6rMLj2jmClRBfFN6Leaf7B5U5tPHZNx9LDHFpXF4uz7FUKTcvsnbVPPgyDgeUkisBPaqlDG5r1wE3LUoPOmBvAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GMKWlEEl; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-8230c2d3128so2842466b3a.0
        for <linux-efi@vger.kernel.org>; Mon, 02 Feb 2026 23:31:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770103909; x=1770708709; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=f1PNOi1oh0/Zk5XEHIqvUN6ECXvN0Y2KoNmyJjB7WcQ=;
        b=GMKWlEElkCKLZQ3kDDBuvlYwKRbnBcvOeoRKZ1Y/KYleVTPLlh+qWPqDmiwHJnWE5Z
         JACwi8WwF4vfYEjErggNTB3w7AvFtk48xMxFymHcL+JC+4mgEVBVSQI1hspy3lVm//qv
         XlDYMmGiTYcoUGbJ2HMxcBwDhnutADRFPha/3d0eaXiburZ2wkiYvFbc3/xUpJZVikOR
         gipzy0WD5i7GLDjJKjMi0A4CthpZqsQ+CJjmZg5DBbT0YDCNMWRKIDpv+0NkF+xSoLVj
         kQvVggUgwTJoyx60VYXRluoAvh+W2RGUFhvj1Dytr3wv9FiAKZSPhPm8hNbZ3f9vIvCn
         RbIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770103909; x=1770708709;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f1PNOi1oh0/Zk5XEHIqvUN6ECXvN0Y2KoNmyJjB7WcQ=;
        b=MMwAoD8fM0mA/rQ9pXwSgvChTDk7mQ5y/6x8WAdVPM/QmXy8S/2QjW3QMPtD5RO10+
         yJM7LQD2Gk0JyInttB5hLw+jYi7uVVDOmyq3vfWTmEeb7aFSxpLBlf5NDFUNISGeZ8Nk
         KL4mX0E51lfe3pFHOzdWhmLt9C5C2naHjwvVtYUS74j8ik5n6AgbbRi6Xf/iUC5InBa2
         hXHvJzzzrCDl71f+3CWCk+qSwqMY+01SzWu4sPp+WkT0LGrBo2P+r3EpufS4ykU4nnWu
         cE7SO0RsCToAMhmVnDCil19dxF7IMLnln02GdllRxyIOAtBtG7VVOeYsF5TC+2YMzx48
         qxOw==
X-Forwarded-Encrypted: i=1; AJvYcCVMTwVXpT6Jt6cKQvEI+fQviy/b/UiljuGTAYBuQfgsRfexeYO0OGPhvK0XIK2U6Za77PpcOOqKPOw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8LLkXA4xZgd3qVd58SIaP96ELOMFSrl+hJz5Wp+zJ7Gbn3rQF
	x8YWVZD119WzJkprcYrUgOjrAIS4X2b0Gdk9ijh0JD2KTRA1a5Q62vXJwqkH
X-Gm-Gg: AZuq6aLRc5lqq86E8M9WS326Ws7CigjT4A8/jQzu0NryRZLO7XhZBfJEOifE92wnNDO
	j1evHy3h9wY66gCPIVQekJSNcxGujFJQzXFr0fPwlQ86IoQeb2NBCpqJrddMr+jqOzBbK5q7ZAD
	04BoKqweZ1LifINyrq41Zxfj2isf4mGnu22MKfPtBQngA6wGuZwGZILymI/OSQLH2zGUBNkZlRZ
	vOKMnNjxEK2mdKgSyIL1/7/aMD2CqmM/R4GUXcdKHciy6g2dasdn4ubbC4Wq69jnvl+lmKe649U
	ooo0zsYVDZzgmthy/7dSH2afviMEwoFEwDKsBcLOBLgLWN5NHr5dV/2FaygKp4GQ/GHRmQnyQkB
	ynmDCKeG8BDIJvBySkG7xBVHa16nIlEa7A6AceyzsH2SJI9kiix0AcWqwLYv2dKSAqU6/tYgVb1
	G5j+yUCBWK6jMIzXA=
X-Received: by 2002:a05:6300:4093:b0:38d:e674:b5ef with SMTP id adf61e73a8af0-392e01aa144mr12357123637.75.1770103909557;
        Mon, 02 Feb 2026 23:31:49 -0800 (PST)
Received: from at.. ([171.61.163.171])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a8dc225534sm108280865ad.68.2026.02.02.23.31.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 23:31:49 -0800 (PST)
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
	Thomas Zimmermann <tzimmermann@suse.de>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Francesco Pompo <francescopompo2@gmail.com>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Lenny Szubowicz <lszubowi@redhat.com>,
	linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH v3 0/2] Add support for eGPUs on Apple Products
Date: Tue,  3 Feb 2026 07:31:16 +0000
Message-ID: <20260203073130.1111-1-atharvatiwarilinuxdev@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6081-lists,linux-efi=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,linux.intel.com,intel.com,ursulin.net,ffwll.ch,suse.de,redhat.com,alien8.de,vger.kernel.org,lists.freedesktop.org];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E49D6D5C1E
X-Rspamd-Action: no action

This series adds support for eGPUs on Apple products, by
enabling apple-set-os on all apple devices.

A side effect of this patch is that the iGPU becomes enabled on iMacs.
However, iMacs can’t use the iGPU to drive the display
(They can't link-train the internal display),
so displays must be disabled on iMacs.

Changes in v3:
- Disabled apple-set-os on MacBookAir6,1 and 7,1 to avoid regressions
- Reworded 1st patch
Changes in v2:
- Reworded cover-letter
- Transferred logic to has_no_display in the 2nd patch

Link to v2:
https://lore.kernel.org/all/20260128145855.1071-1-atharvatiwarilinuxdev@gmail.com/#t

Link to v1:
https://lore.kernel.org/all/20260125001111.1269-1-atharvatiwarilinuxdev@gmail.com/

Atharva Tiwari (2):
  efi/libstub: Enable apple-set-os for most apple devices
  drm/i915/display: Disable display for iMac's

 drivers/firmware/efi/libstub/x86-stub.c       | 20 +++++++------------
 .../drm/i915/display/intel_display_device.c   | 14 ++++++++++++-
 2 files changed, 20 insertions(+), 14 deletions(-)

-- 
2.43.0


