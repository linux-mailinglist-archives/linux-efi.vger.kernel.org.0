Return-Path: <linux-efi+bounces-4388-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 029B7B079BB
	for <lists+linux-efi@lfdr.de>; Wed, 16 Jul 2025 17:26:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D84F6A4395F
	for <lists+linux-efi@lfdr.de>; Wed, 16 Jul 2025 15:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E91EA2F530E;
	Wed, 16 Jul 2025 15:23:27 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ECA62F50A2;
	Wed, 16 Jul 2025 15:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752679407; cv=none; b=o56TXg1pJsmwL6rtm0s2mo1QnOFKhx/fOglvKuJqD3RaXMU7/pULdckbwIGzgN1Og1yFoqdXVkXH+lwhn6FTRp0jcHGOW2fzY6g2LnF5qij/mMiW0YsdXqKm597fT6KA6vJhH0Hc6az40ooE2BxF96JZ0iZ78l4n6YsrWaW4QJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752679407; c=relaxed/simple;
	bh=6d/z/JM0vRopTks4Dy05BIgYYynaCP/0UpCIvbjGVro=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=s6JrbEPFHh783ZYcQhtbnh0EhGWdS7PDHyylAhzaWBaWxMU2fWYy7L4RUcMICHT1ISfitULdXtksg8UseWN/lX7s2W4up+VhyqGY2eH8SaGfI9ORnI43UYZQEvRt7BdOB5yhqAPUJpd9HJ5CcxbbqsCaU86g6yaqv2ehGmFXlMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ae3703c2a8bso1249959666b.0;
        Wed, 16 Jul 2025 08:23:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752679404; x=1753284204;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jdr7eFxAVBCcDOsPNpaxeLOEWWpZL0xyOYM5/939UUE=;
        b=GOpTJZmNysEZC99yPwGmyvNpP+V1RlxNkToNMPz1KjmnkVM1utGpO8hJtaUNZ+G15x
         jSPl0f8nXCf/3x4DTGP2MYLXg0yUuNVWHTkN4jPdGrP+t8klFFhGzV/DQZVGG5oSjbYF
         X1tplO/6ls5hNPkK3v7hNg33hf51uaLBosNGRGS5qslul3iNrJ5hGD9cBqbjPSvXoALR
         w44oszLvTsHL8XRioloPmdrgoA4XFUH3pMPXNQt3e/X5yg9/qC9C3GsbLt5kghgOsd84
         KfaXhHwvktWSsQNDKxgKRhKDTgxPG/fwnqWS696GKVXuIMo1hRZe8iUDwul5zwSlfjwi
         GCsg==
X-Forwarded-Encrypted: i=1; AJvYcCVjzrJcmCtB/Q9nbAL8fOzWu/AF5l+7RDbzMTGJ3dY99SHVo4qQ8vAcxIgxkA9KLq9+N2dNqouDgD5Urdw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiKAbekSJ95nRFyS6ezNqrn1CXBvKnDbE7zyJzfLtgTacG1j3v
	HK0AJPpRQKrUL2RqQBXxrQx7dTGT6PNldA5a9jA6LlhbsDfwBJFgbJZt
X-Gm-Gg: ASbGncs2xuelw6K8bhwEsbhX1Z8MUwG8r2mpuUQ+MOrKHoFyDmkkLKiPLJrj1kFgpo9
	gykpb8kbtCBICA9SeMdFt5+MDQUP5ZN2aBzCN0LcxyZjBY6dCJOmOscBW4P7C9Oek5P9EqPrMxv
	cgl5/l5c9dZsR9/VXClFUeryLJls1UD0BYNXsT4PkI8zVozZ9YwxdYl5yVRlAblFgae8Xs14LvX
	0SXCIwep3xXJUdJ3JtgCuDPCrbMgGaiTWBPGFrzRfuZCwvdptHvVyDqzUNCjbmrkH7kSZx/rCYU
	H4lnGokWx1yIGurPi1bicZOnLQU6WIfNX04jg/neov8/m3m24uy9CuKqnoK6Ro63FGL+tKEo8aH
	QDwedpJUzSpuLCw==
X-Google-Smtp-Source: AGHT+IFZbL+/2sJddqrKb4phOIKXDl53PiA5uPHHd6EEAnxpw1PQuA6/wv3Q0nabeydTFVJko60AWw==
X-Received: by 2002:a17:907:3ccc:b0:ad8:9257:5717 with SMTP id a640c23a62f3a-ae9c9997303mr358177766b.13.1752679404040;
        Wed, 16 Jul 2025 08:23:24 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:72::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e7ee471asm1226983166b.54.2025.07.16.08.23.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 08:23:23 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Wed, 16 Jul 2025 08:23:12 -0700
Subject: [PATCH v2] efivarfs: Fix memory leak of efivarfs_fs_info in
 fs_context error paths
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250716-kmemleak_efi-v2-1-871878b767f5@debian.org>
X-B4-Tracking: v=1; b=H4sIAN/Dd2gC/1XMSwqDMBQF0K2ENzYlsf5w1H0UKdFc9WE1JSmhR
 bL3UqGDTs/g7BTgGYFasZNH5MBuo1bkmaBhNtsEyZZaQbnKS1XrQi4r1jvMcsPIsocdUTTmrAp
 LmaCHx8ivo7t2maCZw9P597FH/dVfVP5HUUstB1Wjaoa6MmguFj2b7eT8RF1K6QPaT5yaqQAAA
 A==
X-Change-ID: 20250714-kmemleak_efi-bedfe48a304d
To: Jeremy Kerr <jk@ozlabs.org>, Ard Biesheuvel <ardb@kernel.org>, 
 Matthew Garrett <mgarrett@aurora.tech>, Jiao Zhou <jiaozhou@google.com>
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel-team@meta.com, 
 James Bottomley <James.Bottomley@HansenPartnership.com>, 
 Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15-dev-dd21f
X-Developer-Signature: v=1; a=openpgp-sha256; l=1830; i=leitao@debian.org;
 h=from:subject:message-id; bh=6d/z/JM0vRopTks4Dy05BIgYYynaCP/0UpCIvbjGVro=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBod8Pq4jj/t+MfByIcYcekmZBjU65+EWlMz7s8l
 /cfs0fG6pWJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaHfD6gAKCRA1o5Of/Hh3
 bQDKD/9jTqRDa48z4FMb5skPOyKO7xMKaCMpXiYWVb4TXICyv/I7iAGJjIDGHljGNoy1fOrwxJ0
 WkU1o6W5I0v7GHtmMKIG3maiZY5vyc091TYknfVTmRY0w4d2PjjSLFKsC59chh0nr8tKzZLQMMM
 NLr9w8iNriHiWiCJ4nQYBGOhi2Ho7rR1EPRl1Ra2/Yw28hlIcOkSu7kyKSS/WhOyPueks1JUNej
 kvakmgn8wrP02X1SM7bCZ9h+mW1eu6zNzrU/qhj8+GlajPOha27lbMDkG8Hpn0e96FmQ7SR8O92
 5IUTlo6qeSo+/r6nP8zBloYjD/VM0OLrypLYUQoSfr+jC4J/Wt2YTX0G21Rgn51iMkTE5V01hIA
 8eWEf2qVCTQa+qn3KM1IW2ji/Z278ITh2bYApTTLp2C/39t1d6lR4b9oiH6Ta+YUP3HW2rCVTTP
 Ch2SxYwDJvRyzxRMcZZrgJ4rtxigir/bGUapDkBVNLoELwBnHNPlughi/63cc7S1DM1xlz+pHeu
 JQ1+ktYX5iTsnRTC77MFb1b/Mo7a4kGev0WeohEhUI0hIiz6FYKH138WlT6jCiRlFB++ls2wT1r
 CiZ41UdxjxWT7bPLGhiryLmtIr0Drdw/QE/FJljEsG+YdcokeuohsutHPvw1gMpmkgEk+NlNeM5
 PHSsiOWQbGr3qQA==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

When processing mount options, efivarfs allocates efivarfs_fs_info (sfi)
early in fs_context initialization. However, sfi is associated with the
superblock and typically freed when the superblock is destroyed. If the
fs_context is released (final put) before fill_super is called—such as
on error paths or during reconfiguration—the sfi structure would leak,
as ownership never transfers to the superblock.

Implement the .free callback in efivarfs_context_ops to ensure any
allocated sfi is properly freed if the fs_context is torn down before
fill_super, preventing this memory leak.

Suggested-by: James Bottomley <James.Bottomley@HansenPartnership.com>
Fixes: 5329aa5101f73c ("efivarfs: Add uid/gid mount options")
Signed-off-by: Breno Leitao <leitao@debian.org>
---
Changes in v2:
- instead of silenting the warning, just fix the problem.
- Link to v1: https://lore.kernel.org/r/20250715-kmemleak_efi-v1-1-c07e68c76ae8@debian.org
---
 fs/efivarfs/super.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/efivarfs/super.c b/fs/efivarfs/super.c
index c900d98bf4945..284d6dbba2ece 100644
--- a/fs/efivarfs/super.c
+++ b/fs/efivarfs/super.c
@@ -390,10 +390,16 @@ static int efivarfs_reconfigure(struct fs_context *fc)
 	return 0;
 }
 
+static void efivarfs_free(struct fs_context *fc)
+{
+	kfree(fc->s_fs_info);
+}
+
 static const struct fs_context_operations efivarfs_context_ops = {
 	.get_tree	= efivarfs_get_tree,
 	.parse_param	= efivarfs_parse_param,
 	.reconfigure	= efivarfs_reconfigure,
+	.free		= efivarfs_free,
 };
 
 static int efivarfs_check_missing(efi_char16_t *name16, efi_guid_t vendor,

---
base-commit: 8c2e52ebbe885c7eeaabd3b7ddcdc1246fc400d2
change-id: 20250714-kmemleak_efi-bedfe48a304d

Best regards,
--  
Breno Leitao <leitao@debian.org>


