Return-Path: <linux-efi+bounces-778-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 702C6876072
	for <lists+linux-efi@lfdr.de>; Fri,  8 Mar 2024 09:58:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 277FB285589
	for <lists+linux-efi@lfdr.de>; Fri,  8 Mar 2024 08:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 430F72D056;
	Fri,  8 Mar 2024 08:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RzUAcXhV"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB4B524C3
	for <linux-efi@vger.kernel.org>; Fri,  8 Mar 2024 08:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709888295; cv=none; b=DLPqEPX8eRcErbuPCJun6zFTtdpsdhDlNHlWNXVhrjz3AR70Ivj9vVXBET/xjybgc1puUgWw/WJEKnmTANjmkmNTIlbrmx4VlPELc5WGh4cX0fZs4EpgikTNU4Ok6HgH9qxPp/lucxWaVdo59sv7bKjQwy4bP5q5z/6F3Po3Ccw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709888295; c=relaxed/simple;
	bh=89Fo04Kf8u+l4YHEdTmROroSLRpIHr7WLaVSC4uYyK4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=nqZjME0WOTOnGZTWCZ3Xx5n4VflKNSZ9pESxbtUwceUL4Ta8/MPeuckapFhiq2ORWM8tGBxTrNs5xUHwCMHRdOD1pR/ZAmY+9l2J8etnC3talh3c6B6dlcE17tbAnod7Bo73357cucow4J4SjhMW4k1bpb55IYjU0mjp580uxF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RzUAcXhV; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-40e53200380so11739835e9.3
        for <linux-efi@vger.kernel.org>; Fri, 08 Mar 2024 00:58:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709888292; x=1710493092; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZlsIWuBGq/1+/Il03K2GJRQT78w8fUPScrkjeMZPQC8=;
        b=RzUAcXhVJTKdDTjVMsnPHaa7z2MQD6qVnRCyvovDWaFbtaJgmWjA7ZPQXe04YwbU6b
         oi9ebZS/A6tz6hvB6ToD+hWl87tWUbsRsYyTyg1nPof8CugSe6wTN9DgB48o6cPRttNV
         phQAVrXXVnhfnB7I6LCbKy7WB9QClKxWN82sExoIE1936SUl8AERuLcsDBOsvS5hxZeG
         YAUX3jy65WbMxAZgkvoTeP/hVcE2FoitvE2YlcH9ggsxdscp07wGpMRgPtF6X1Z9ZFPT
         kg5w7bhVxVEq/jfdCVFHrF3BL01y/QKRp9Yii8U2jVma8gCVYLk2kRHpQS5gvzXv/0iU
         xMAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709888292; x=1710493092;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZlsIWuBGq/1+/Il03K2GJRQT78w8fUPScrkjeMZPQC8=;
        b=gkvkh0FijwPUpmCQPLM5NPEeLpbJn/1qFuZZURneVQGJHPHqKO7UtFJ0M+ULaq73Wz
         I0kvsu+8CkJDBmCCG6qUEI9y0tNpIWB6zoiH/rKB8B7YYmOwH+2jk8h0yHMmi25PLqss
         jbNhCfQExWbp/FSTOB1bDXV4KRhRAan1J0vH7lfyV0HqYTdRSzB4ynLmWbLtQjaQNYfN
         yZdHKI3tvrGcAVq/Wd++G0noDJvyhxI3a+Krjmqm7F9yWEeliyDrFPcqfvs9R7wNBv1a
         Kmsr+jttVeAuxczGFlaFaidZjbzVVm7YMZ3s1QknD8WQSeAWRH7iCNIW6UZlbTo3RUK5
         N3Hw==
X-Gm-Message-State: AOJu0YzEAwut863ZnJqOnZejEiThUazfV8g/NPjfKxE9/79VruLYJwQv
	zCtRqWR4BFMqbkAwmsYVFbTjN7FXkKhJff+5TmtXYurqb2IXQU9uPMFmWueD6gIPhDC1xlwP8H2
	oj/M3ryB5VgMKSN+w227QZYRJDzYcj1z5CJtXoj/ghaHng+QMAPpHq3+Ll8DCF9erYNO4RH84zi
	CpIGorTpau7LYAwPGA99HlS6IC9g==
X-Google-Smtp-Source: AGHT+IEPD8keadXgOhV2dGjS/dk4MZswGCMuTcTBZ8rJiwCllwUaS6lRZOuk7Gpq7z/SCfJn3UUhRc0O
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:600c:b92:b0:412:e783:bf5b with SMTP id
 fl18-20020a05600c0b9200b00412e783bf5bmr158502wmb.4.1709888291257; Fri, 08 Mar
 2024 00:58:11 -0800 (PST)
Date: Fri,  8 Mar 2024 09:57:55 +0100
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1825; i=ardb@kernel.org;
 h=from:subject; bh=InBBNPBH0BCQA/t6tSrON7UMzidtHfWAqxCf4hnlHwo=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIfXVZSHe+1f/pURtt4zbH/tSyKl9W9S+ZxzF3bMulhyxC
 /4leIyto5SFQYyDQVZMkUVg9t93O09PlKp1niULM4eVCWQIAxenAExksQrDP8tL8uXPDnh+n7L6
 2uf/H6TKO7fYifEd8TPImeXTLrfJbwMjw6RbxvFrLF8k39Y/u49PPPzBj4Z/H7fXcWVpG/zm+Xx fmgsA
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240308085754.476197-7-ardb+git@google.com>
Subject: [PATCH v3 0/5] efi/libstub: Fall back to CC proto for measurement
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-efi@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

This is a follow-up to Kuppuswamy's series [0] to add TDX based
measurement of the initrd and command line to the EFI stub.

Changes since v2 [1]:
- fix incorrect assertion that efi_tcg2_tagged_event is a local
  invention; it comes from the TCG PC Client spec
- fix deviation from TCG PC Client spec in how the event size field is
  populated

Changes since v1:
- add patch to switch to the TCG2 spec's symbolic GUID name for the
  final events table
- omit flex array member in efi_cc_event_t
- avoid version confusion between CC and TCG2 both using version 2

Cc: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>

[0] https://lore.kernel.org/all/20240215030002.281456-1-sathyanarayanan.kuppuswamy@linux.intel.com/
[1] https://lkml.kernel.org/r/20240307162214.272314-7-ardb%2Bgit%40google.com

Ard Biesheuvel (3):
  efi/libstub: Use correct event size when measuring data into the TPM
  efi/tpm: Use symbolic GUID name from spec for final events table
  efi/libstub: Measure into CC protocol if TCG2 protocol is absent

Kuppuswamy Sathyanarayanan (2):
  efi/libstub: Add Confidential Computing (CC) measurement typedefs
  efi/libstub: Add get_event_log() support for CC platforms

 drivers/firmware/efi/efi.c                     |  3 +-
 drivers/firmware/efi/libstub/efi-stub-helper.c | 98 ++++++++++++++------
 drivers/firmware/efi/libstub/efi-stub.c        |  2 +-
 drivers/firmware/efi/libstub/efistub.h         | 95 +++++++++++++++++--
 drivers/firmware/efi/libstub/tpm.c             | 82 ++++++++++------
 drivers/firmware/efi/libstub/x86-stub.c        |  2 +-
 include/linux/efi.h                            |  4 +-
 7 files changed, 219 insertions(+), 67 deletions(-)

-- 
2.44.0.278.ge034bb2e1d-goog


