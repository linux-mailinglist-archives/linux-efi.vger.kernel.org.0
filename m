Return-Path: <linux-efi+bounces-6095-lists+linux-efi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-efi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AIf4B0PlhWnCHwQAu9opvQ
	(envelope-from <linux-efi+bounces-6095-lists+linux-efi=lfdr.de@vger.kernel.org>)
	for <lists+linux-efi@lfdr.de>; Fri, 06 Feb 2026 13:57:39 +0100
X-Original-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 74006FDC5C
	for <lists+linux-efi@lfdr.de>; Fri, 06 Feb 2026 13:57:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 54FB83038F77
	for <lists+linux-efi@lfdr.de>; Fri,  6 Feb 2026 12:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 409033AEF41;
	Fri,  6 Feb 2026 12:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SMIhqhjW"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F56936164F
	for <linux-efi@vger.kernel.org>; Fri,  6 Feb 2026 12:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770382624; cv=none; b=gS1FuNJprOMC5iSgybeK/qYEj0yockkGouAviLS66e193seTebsTmotpIzBsCPI+KlObijY8SK1aGbAJSzZahLWvSx0dvfL7+QwkIYBthOsRJUwc/W2G2mQZP0o+9RRu4gwUyRjVVGL1bWC1YGQ312/1wnLZf5WpIJjNoTMnkUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770382624; c=relaxed/simple;
	bh=lPMKCKine6EnGaLRHoDnAZD3pBalk/QVNk6LUOmwHIE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oaXoLzbvk661M2BXOmPTnpJQ17T2POXDCWPIlcawaQ+IDyYqJV39UcDDQYdI+LV+Yi5478wiyy4QfZOR8Yia3LDcU9fkWADFx5Yh14XrI5q0rYfcp/227l7LW8g52F4MKj0dfL99Hn+Vk5TJ8acv+TmupfAilouBl4fchLIlPlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SMIhqhjW; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2a8a7269547so19179265ad.0
        for <linux-efi@vger.kernel.org>; Fri, 06 Feb 2026 04:57:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770382623; x=1770987423; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VhIKYL6qAt2DSiA4osOFJOOBKX8k+F4lLE7VdpKfBZM=;
        b=SMIhqhjWYRZYxxOY5eb8mpPtSMsWr3wC9djUaOMR4UQFinA4zI2iHKyKMfeweAcVpI
         R3xnrxxJRoYaYEOJavpWiTM/KPGqYiwTzjQ3JCdPfIGzgvtiP2wx0DxGJ1L4gqvBk8b5
         6gejtjS9NCAnuE2TMNygTy4jRbUGMKaYxyG8ylyzMOyJqzV4KoIiWpN+X2l/lJ3bbZvU
         4zztyC5RswPexMmSLXIa+Qcs1+x/8BzdNGtVBNiON4FM5F1J4GifVlzgsOoOCtVpBt7b
         2tXxtcsBj46TJWVmarJ8R+MNf9dwBTDvYHcI5pNT9iNdjicsHF1TO7lGrYdMBSbkGTZN
         oIlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770382623; x=1770987423;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VhIKYL6qAt2DSiA4osOFJOOBKX8k+F4lLE7VdpKfBZM=;
        b=q6JZ7R9uSaJuAUM/LlWY2kBXk5RUS0ATkmSil/WPey7TGh8m3YT2S8lEOsSsufTDhI
         yEyKDpmSaSvH/pMgKM8+wLlSFN2k+adpq32My420qgLOO3O/MuoLuO+YgX0O3oJWRwcg
         gf+lIM0/rKyYE+CkPhhAABdM8yIopxFD6hmDU/Q81kZZcIn1v6FzfculfHWpJCMOidgh
         bQJm1DSxmY2BQnKjQWThUL9fQM8CYC6gJgjkvjAp3+cb/ccowHVIvuPEXrt1AWM6oS/B
         F9xxAaGGdoDYnemK2DGGd5TycUfOEFOyW/2ntG3XUQVhBrd8an5gQPLYmAKpwB/mk7yz
         uW3g==
X-Forwarded-Encrypted: i=1; AJvYcCV4Gg1uWGa9iERWIT0EPZya7yIHaQsNS94Ojmx5whJkZz+JZgM3+XgsiMrPxPOdQwcPcpoeX/2ud3w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfgNZyDiG/iN21+E4xBth8PBrmZO9adYavGUYGwaPnBFDMrm/A
	HC91u3d2dnRzTsBO2e6kVt26gUyxSqOpLenkLHW1guWI8+6sS8v0AiU=
X-Gm-Gg: AZuq6aK9tnk0LXOT8uQE4a+3454Zbamin5Hb5t4bpFOHAJYY3vfsGwbJvxY7f7LY1c9
	Qavyn7hc/IG2Mf7UNIq9r6KtpQi/fJehYjBtF+mXmK+VoA1Enl1ZDFzyQXtRZ7P0APnppTcHDyP
	pcRvditvWpZXy+K7K24xnzAVIAr0T6yRHyNNG40rj/0wzOA5+MTvaSwkpZbnGXYsQA7BO8Kk8qE
	IviP5IEAmt1a1HlR67fHFpgHzVw56RhnEosoFsXuT6BPxUCe07CWhtZPG9VS3N0g58QAeIJawBu
	iCEZGIwei/FQyllS4Vr4xqM//XGOF1LKgLNGH3MZ8GL0dghTotgUM1rqhtIc5FIfFhzrjdFCMEW
	HMyC5i1xEW3EAnJZ9aIEif93luEuquSIDYwlssXF+jWoBGiLuuWYfVhcjRhicFT8JFnlGVYlPV0
	lE122rSon0dNzlM/c=
X-Received: by 2002:a17:903:1aa6:b0:2a9:410:23fe with SMTP id d9443c01a7336-2a9516d3e18mr34008135ad.36.1770382623349;
        Fri, 06 Feb 2026 04:57:03 -0800 (PST)
Received: from at.. ([171.61.167.190])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a951a636aasm23336005ad.12.2026.02.06.04.57.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 04:57:03 -0800 (PST)
From: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
To: 
Cc: Lukas Wunner <lukas@wunner.de>,
	Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Hans de Goede <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-efi@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH 0/2] Save Brightness on Macs
Date: Fri,  6 Feb 2026 12:56:20 +0000
Message-ID: <20260206125641.12983-1-atharvatiwarilinuxdev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[wunner.de,gmail.com,kernel.org,linux.intel.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-6095-lists,linux-efi=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[atharvatiwarilinuxdev@gmail.com,linux-efi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-efi];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 74006FDC5C
X-Rspamd-Action: no action

Currently, when a Mac is rebooted, the display brightness does not reflect
the level used during the previous boot. Instead, the brightness is
reset to the value last stored by macOS, causing the system to
ignore any changes made since that time.

We fix this by writing the brightness value to efivar "backlight-level"
every 300ms.

Atharva Tiwari (2):
  efi: Save Brightness using EFI on Macs
  platform/apple-gmux: use apple_brightness to save brightness to EFI

 drivers/firmware/efi/Kconfig                  | 10 ++
 drivers/firmware/efi/Makefile                 |  1 +
 drivers/firmware/efi/apple-brightness.c       | 91 +++++++++++++++++++
 drivers/platform/x86/apple-gmux.c             |  7 ++
 .../linux/platform_data/apple-brightness.h    | 21 +++++
 5 files changed, 130 insertions(+)
 create mode 100644 drivers/firmware/efi/apple-brightness.c
 create mode 100644 include/linux/platform_data/apple-brightness.h

-- 
2.43.0


