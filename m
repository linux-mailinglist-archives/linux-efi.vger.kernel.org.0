Return-Path: <linux-efi+bounces-3046-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE5D6A69FE1
	for <lists+linux-efi@lfdr.de>; Thu, 20 Mar 2025 07:37:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B1753A6327
	for <lists+linux-efi@lfdr.de>; Thu, 20 Mar 2025 06:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C395143748;
	Thu, 20 Mar 2025 06:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e5aQKXjN"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE9F829A0
	for <linux-efi@vger.kernel.org>; Thu, 20 Mar 2025 06:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742452674; cv=none; b=nopYsXlc1HWeHgYeZksSr3kyeGfrCltyndzanhj2+Fk9gR9vBVvUCCvtlb0UM42NVUjBWqk4yWxpRFXDynBNI02+eHuiHxxIdBGkSGwcRg46dEZFEookxdScWJI7a8MtrwO/3Q4dv+ZfrnlODHeVc/d/YFlPlimewW7naYTLwgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742452674; c=relaxed/simple;
	bh=L1MmH0h3kJSrGhRmI2suggn8bkdsfX5St7meYMUsBk8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=OLpo+uZG5Ux1XJsrPdjFotwWK9qP+mVSKtWCGAJXWGfaoIKBrkfvLddo+i6G2BiKeibLtaXSPob4zAYhSn3MmlpNC1cyRPOzEmGAKvUBRd32y5sPz+T5+8qZsGLN7Yo0FdnA6yjdQ4JAdY0VnRgSlZha8kDD1eXGBAYIi2jm79Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e5aQKXjN; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-3912580843fso278110f8f.2
        for <linux-efi@vger.kernel.org>; Wed, 19 Mar 2025 23:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742452671; x=1743057471; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cTQzeSTn0/32b0jJbv0Le3HqoI48U3RMBJiD1YXcXfs=;
        b=e5aQKXjNBxRaC6hh1uBv1+zqx8bNR2i42DOJgePW3RjV3LBDXEWTM4E1Vjs6DYjTUL
         bFu+QmjY84oV93Sg4DhBUi1WbvC0F25d9z+FtrMv7PrRT2JrnOkvCl8AvUC1BSA2egjG
         av1CGmmbGcpLjx/o5Da/u4/bNqL7HCXSV/vFZ6kIJbWm2xNwkkmShAcxDhufvxVIJoLa
         vXEm5mbN4d+F22dp2pKNRYaeOEE3qtVjtoZk2X4kQYrfHxB2auxDr6cFmk2J7FHo5cGG
         9pxbxRjJIaDTsjmvk1S0UQxtndlhJ3hmG3j9ATG4tsnwrRsgx2fX89lJPXPrpWZsb114
         W/2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742452671; x=1743057471;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cTQzeSTn0/32b0jJbv0Le3HqoI48U3RMBJiD1YXcXfs=;
        b=QhRR+6IpRL7CkBJU3i5JHonNMGl2LQcGQ7hs9P9UYJR3hiPbYa7TskG+ptT4U1+PQ8
         0W9hDqwlg08kTR3l8vPd4YQHjDY7SzBejzGoIIrnS3LDC6BtAEn+ygvpw/4Ldms9Ri9e
         P6N9u9Se1S29y1kjOyAacT+09EYh2nvVDuShRVaAYap06VMJKBLD69vp2bna8r6ee8ME
         MOZVCI0d2BJDf+Xw2bIUUlcP+fxKP7sxLiip02op8IvSqawp7twgF4LzRScnZebb780i
         X3uQ3LFUeS3TQ00nUh48kAyMsulHtKcJSJ5VvkrcTQIjl8Q5V3mhg8PXFf6+nYvgGbNi
         wcsQ==
X-Gm-Message-State: AOJu0YzZnD+pLH+MfiYE2XpmzL6jJvZ/JPgD2VwEGnKOgVX2LHhCmtE8
	Lq+l5GwDHmd2bHmiN113BWwEXMT1Lk768MilZadjtboE64mWxivnM1MiecQHKyjEUwim3A==
X-Google-Smtp-Source: AGHT+IFc8hk1KoeUwDd9x5nZhTeyxo1t4+8qm8k9NG02y2NLF6RLJhg3ksSmb1/yP1oSQgN+YwRXbtt1
X-Received: from wrgb10.prod.google.com ([2002:a05:6000:3ca:b0:391:281c:9942])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6000:18af:b0:391:329b:893e
 with SMTP id ffacd0b85a97d-399739b437amr4529235f8f.5.1742452671082; Wed, 19
 Mar 2025 23:37:51 -0700 (PDT)
Date: Thu, 20 Mar 2025 07:37:47 +0100
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1567; i=ardb@kernel.org;
 h=from:subject; bh=+ivhOjQ6eXvusO1RqxCuuXYXi4ybWXnRQ+iffx9sFtA=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIf329t3sIa/MTpou/ZqVGvuKKf0M3/7+u64Pn3iKfmhYK
 nFf6IJFRykLgxgHg6yYIovA7L/vdp6eKFXrPEsWZg4rE8gQBi5OAZhIYBjDT8acVUG11zrPeT2v
 mLV212L3WzdazO9atImuVW7uzn22qIiR4b7yseN3Y1dJlH1Rubr+w1Qd2yuetj36B6prdY5/qNm ynAUA
X-Mailer: git-send-email 2.49.0.rc1.451.g8f38331e32-goog
Message-ID: <20250320063746.4177561-2-ardb+git@google.com>
Subject: [GIT PULL] EFI fixes for v6.14 #3
From: Ard Biesheuvel <ardb+git@google.com>
To: torvalds@linux-foundation.org
Cc: linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Hi Linus,

Here's a final batch of EFI fixes for v6.14. The efivarfs ones are fixes for
changes that were made this cycle. James's fix is somewhat of a band-aid, but
it was blessed by the VFS folks, who are working with James to come up with
something better for the next cycle.

Please pull.

The following changes since commit e3cf2d91d0583cae70aeb512da87e3ade25ea912:

  efi/mokvar-table: Avoid repeated map/unmap of the same page (2025-02-27 18:25:44 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-fixes-for-v6.14-3

for you to fetch changes up to 11092db5b57377ac99e6339cfd16ca35ef011f3c:

  efivarfs: fix NULL dereference on resume (2025-03-18 08:46:08 +0100)

----------------------------------------------------------------
EFI fixes for v6.14 #3

- Avoid physical address 0x0 for random page allocations

- Add correct lockdep annotation when traversing efivarfs on resume

- Avoid NULL mount in kernel_file_open() when traversing efivarfs on
  resume

----------------------------------------------------------------
Ard Biesheuvel (2):
      efi/libstub: Avoid physical address 0x0 when doing random allocation
      efivarfs: use I_MUTEX_CHILD nested lock to traverse variables on resume

James Bottomley (1):
      efivarfs: fix NULL dereference on resume

 drivers/firmware/efi/libstub/randomalloc.c |  4 +++
 fs/efivarfs/super.c                        | 52 ++++++++++++++++++++++++++++--
 2 files changed, 53 insertions(+), 3 deletions(-)

