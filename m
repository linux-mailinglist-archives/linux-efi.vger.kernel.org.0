Return-Path: <linux-efi+bounces-2379-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F296E9F2440
	for <lists+linux-efi@lfdr.de>; Sun, 15 Dec 2024 14:51:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A1A5188640B
	for <lists+linux-efi@lfdr.de>; Sun, 15 Dec 2024 13:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E360814EC60;
	Sun, 15 Dec 2024 13:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ccL86O2A"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 248071487D5
	for <linux-efi@vger.kernel.org>; Sun, 15 Dec 2024 13:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734270658; cv=none; b=maORoCzq60pih7rcbEMt+5he/V9A2ix3GkNQnv7T9whk2zfDEl6/qv3EOgQ1roA0zkZ5vRgdZ5/IXG0czHSWzgtKZnKsn2ztX6wvTj19zfekSkSp5uc/RRYjCRI7S7mRNmYzjA19qQV6KsXg8szexESRjukSLyyH3PcxL+c18AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734270658; c=relaxed/simple;
	bh=33dv0BIRv0mp9dCyxjP6gA8M+dUllJtrMNHa358IXW0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Uz1RyipGWgu7hoX+MBHb3vi1IYMVurs9pE2PxjmHGA6AYibuAgBL1fE+makNNTC+6pgjcFFc+DrfJzSYfEDO/kgOM8ioSPttLEB3RQRZmssEr21t9o09UaC9mo3eAuwp1XUuqslSCg8PgRVyFGYieHtn0MJIhYBmb0OrLGugfFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ccL86O2A; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4362b9c1641so10892385e9.3
        for <linux-efi@vger.kernel.org>; Sun, 15 Dec 2024 05:50:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734270655; x=1734875455; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zO1A6gg0jRr2kbdONWLMVEKUBcJlUXAuwOF5vi0EDqM=;
        b=ccL86O2AfNLfmAa3xFAcubluLIZRgs8IFdEC889xJSnuhjp9agW3LJSn/Rog9TOp96
         NGMnHlsy+6fUDX1oXhFAhNhI4ZBwjGV3C54G8/plTwZ+nZWTSTC7QSixei5jpz9LuHOC
         OmuMK5QLS3A6DgBTHTqk21G35oxUaGRhlRXCTRM05a0icWneRp0hEo2X8s+wR2X+XqW8
         W9gyQcCCZ2HSRjkGt+OxTUwbKhyGCHEnGf7MQdYsBrTypwVEC1XM/Vo3em/DzVZEzKH3
         JcjwBMltqIjpML45Bil+sQ5CTyhUdNTebDsxTsY7ZZIigSRfueUpeqOniWeR32XbfAX5
         Uzsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734270655; x=1734875455;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zO1A6gg0jRr2kbdONWLMVEKUBcJlUXAuwOF5vi0EDqM=;
        b=EjpU33A0uVedeIeMMx9gQxVuVBDrxucRQxyh9bdUZDtF5+eTUcw74V1fc7O+zcyBnC
         0RYJpDgtJwgsgHnBAQE5pKNQNbtwkNYceDF8Dmiu6e72WdssbAeWqmFIimkRmV6AdkdO
         9ZAk2X06nufr1eNfiKvXBceq6kY3gELhZjJCNbzqv0DvuGIHPVEJSMpXMNXqVFuAT6N9
         ZyQH04zdGF2i8oJ+dz+MfX+JBwj7FvqEk4fxNz8qSjy/KqoDZtysb/mLSNxT/m0Q2QYd
         /o+6Da7CydyItRGq66pq3dzM8csAyh4JPYUTo7TtcrFZIcqaYZjkUqzq7a6mkf/rh28w
         gV8A==
X-Gm-Message-State: AOJu0YyA7ac8VTTPaqWX5zVOsTEu919gETJfFHeekIWUxtwhZsXumJ2O
	Jt0fdw4HIKXNJqrlLEg4DHBlMcZEvJEHX2yJshuTSdCw/lhvvUfCXWdjTEEcAlaxBhdswg==
X-Google-Smtp-Source: AGHT+IFxy3PgqHVCRKabVBBqwomUFEPnQrsQYT3OFaP0SQiiYPDp/a69XSPhSOr1mUnmG7XtehBtJeN5
X-Received: from wmc3.prod.google.com ([2002:a05:600c:6003:b0:435:dde5:2c3b])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6000:2ad:b0:385:ee59:44eb
 with SMTP id ffacd0b85a97d-3888e0bd28amr9187973f8f.33.1734270655601; Sun, 15
 Dec 2024 05:50:55 -0800 (PST)
Date: Sun, 15 Dec 2024 14:50:48 +0100
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1632; i=ardb@kernel.org;
 h=from:subject; bh=n+Xs9d6vmRosyqSJaa104jPyfcPzv0tdZ7Om3dZ7u/M=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIT3u3o7F1ld6vzhUm5sJ27mr/NfijJUxnCEzYVrhvZru/
 MyMadc6SlkYxDgYZMUUWQRm/3238/REqVrnWbIwc1iZQIYwcHEKwETcPBj+Sh77qsGr0t2+uWBT
 fPlN2TiuO5Xduz/krRE633Fo+btfoQz/4/6JPE9nPjm1mifB9GPC/+xTOod7L7++9ER3ukTlpnc sXAA=
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241215135047.8749-2-ardb+git@google.com>
Subject: [GIT PULL] First batch of EFI fixes for v6.13
From: Ard Biesheuvel <ardb+git@google.com>
To: torvalds@linux-foundation.org
Cc: linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Hi Linus,

A handful of EFI fixes. There are some more efivarfs fixes from James in the
pipeline, but some or all of that work may end up getting deferred to the next
cycle.

Please pull,

The following changes since commit 40384c840ea1944d7c5a392e8975ed088ecf0b37:

  Linux 6.13-rc1 (2024-12-01 14:28:56 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-fixes-for-v6.13-1

for you to fetch changes up to 145ac100b63732291c0612528444d7f5ab593fb2:

  efi/esrt: remove esre_attribute::store() (2024-12-13 08:43:58 +0100)

----------------------------------------------------------------
First batch of EFI fixes for v6.13

- Limit EFI zboot to GZIP and ZSTD before it comes in wider use

- Fix inconsistent error when looking up a non-existent file in efivarfs
  with a name that does not adhere to the NAME-GUID format

- Drop some unused code

----------------------------------------------------------------
Ard Biesheuvel (1):
      efi/zboot: Limit compression options to GZIP and ZSTD

James Bottomley (1):
      efivarfs: Fix error on non-existent file

Jiri Slaby (SUSE) (1):
      efi/esrt: remove esre_attribute::store()

 drivers/firmware/efi/Kconfig                |  4 ----
 drivers/firmware/efi/esrt.c                 |  2 --
 drivers/firmware/efi/libstub/Makefile.zboot | 18 ++++++------------
 fs/efivarfs/inode.c                         |  2 +-
 fs/efivarfs/internal.h                      |  1 -
 fs/efivarfs/super.c                         |  3 ---
 6 files changed, 7 insertions(+), 23 deletions(-)

