Return-Path: <linux-efi+bounces-827-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4685687DD54
	for <lists+linux-efi@lfdr.de>; Sun, 17 Mar 2024 14:58:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB415B20E6A
	for <lists+linux-efi@lfdr.de>; Sun, 17 Mar 2024 13:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6BA21CA81;
	Sun, 17 Mar 2024 13:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kSTgc870"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 189931C6BE
	for <linux-efi@vger.kernel.org>; Sun, 17 Mar 2024 13:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710683891; cv=none; b=OvFxq90S3CLdJAIOaThkbSAaJqEI7xIjuq9iCSLs8nEXw+h4PetpgpIEo7dxt6V4U1umpkfkRaYx8VejpM27AILUI0giGAyAVc/Z0+sGeWIjkxvbgHyLBu2uol7PYMqUn58/xLsVuDUtWJh2xu1KEBKSfL2cgAZ67boPhk7iNwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710683891; c=relaxed/simple;
	bh=zoJeiK03Kub+m+HSfEi2Y2MmQYIrOSTkyiUxlRDu8J0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ZRPdiFbBh8iK8y3HO12op/ol58JdzfbXgNs0kFyTtkclGMYEByTgVrpJjxS3ltJFvegl4nRrFh7+0/nv8xRECCXfMImEFiqrII4GiASn6D9o32dFGsEuX0JK61AU/GN3pq9V1alStUANGGcpn4hczUYBZmtCea/DsOWQTxfWHSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kSTgc870; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60a08eb0956so56231067b3.3
        for <linux-efi@vger.kernel.org>; Sun, 17 Mar 2024 06:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710683889; x=1711288689; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=p1P6J9pjhQJmeBCYeEGZyK27cyT0Yx//OvZTCw/Ttmw=;
        b=kSTgc870xx3GszZqwBG4faXSbwNjjz+eBOkG9G+HSSiF1qWia+bDBlmTIjOrA+Bu7Z
         UkF95PIC6GSLn4A1iXQVPaVeLEPGuvWcyVvfxHZq/uWzHQkOIeiyjurfSOWPasvAPryN
         W2lNFEujY1M9JmXD+Jz193GU85aaZKn60NrOoVJct/EsGERuAJtrocnflqB2I6fz1Fll
         aJ4DNWdXxOrirKg44k0Z9gVj3om6UOinvn2Gj6jyfDKvINUB4xZX023Wf3nGIFvcpXi/
         24BXkvam2VlPukNQ6zw67TQecHO/cqTe960C6zAVtvbCEd4cfJZ/Xw5PqdhzfWTDnxqq
         FXCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710683889; x=1711288689;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p1P6J9pjhQJmeBCYeEGZyK27cyT0Yx//OvZTCw/Ttmw=;
        b=XijSZPqbQ0vXrrLBfGOdN0EcgoqPef0CLhVY512OCJlK2dsAF0TX8O/XDtg8uHt6oN
         rriUcigK3u1sth6t6cYr/Cc6xGeyTb0Nl/uxyIEToa7TT3JEesbheeJEQV78Yrao6ZAn
         1wN9utPAjwbrzjICTbvF/xaRWgjAoAwaqKWij/ovp+aaIMdnY14Ty6BQ27B3uB0/9GTb
         86IyNLQGHOaMfOepWjyRStdISxWv8zU8ufGLGztRW59plfzTY4MQ/vZ+UAg8k6p9WY4J
         XHpINaXrvaDWmRbOHl2FAXNXbE3rlO3b6s00sJHnrjrAGAjpDXXz0KAOvjiMOZyVwzUe
         EHvw==
X-Gm-Message-State: AOJu0Yztd6gvljE4Ckh/mahtqrypMx0v3fMIhDIXiyITRHRm0GKzpPdT
	jihT7O+DM6mbtltNPCmflNkQHbOE0l8uXZwkqY452YRWeb7OyPyLuvpVyqa1VT0Hd8qupw==
X-Google-Smtp-Source: AGHT+IFZnWZDXvcqYPZ7rfsMjwjhGt0bMKwwuKMbjH55/tXPlM8t93AUn1jwn+Pu3j9mVDZNGHobkGb8
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a81:a042:0:b0:60a:3487:6f7c with SMTP id
 x63-20020a81a042000000b0060a34876f7cmr1780309ywg.9.1710683889103; Sun, 17 Mar
 2024 06:58:09 -0700 (PDT)
Date: Sun, 17 Mar 2024 14:58:05 +0100
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1328; i=ardb@kernel.org;
 h=from:subject; bh=0dFjLvEEaYZsdIOSTCrG72hknPqiZknW8zk84IHpn5Y=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIfXbt7dxOVnXjqR9P31a+f38F4I8ebct40+f4lVw1vGxP
 2O5/v2yjlIWBjEOBlkxRRaB2X/f7Tw9UarWeZYszBxWJpAhDFycAjCRI+sZGY669N6/qPiwhPHY
 hx0bYuZvNenou9r+k0M5jqFTJP9+5wKG/8HdRo+02axr42/4Ps9v9WMTS2u9NOXQ3Jnf68/+5qv p5AUA
X-Mailer: git-send-email 2.44.0.291.gc1ea87d7ee-goog
Message-ID: <20240317135804.4092430-2-ardb+git@google.com>
Subject: [GIT PULL] EFI fixes for v6.9 #1
From: Ard Biesheuvel <ardb+git@google.com>
To: torvalds@linux-foundation.org
Cc: linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Hello Linus,

Please pull the EFI fix below. It fixes an oversight on my part in the recent
EFI stub rework for x86, which is needed to get Linux/x86 distro builds signed
again for secure boot by MicroSoft. For this reason, most of this work is being
backported to v6.1, which is therefore also affected by this regression.

Thanks,
Ard.


The following changes since commit 021bc4b9d7ed8dcc90dc288e59f120fa6e3087dc:

  virt: efi_secret: Convert to platform remove callback returning void (2024-03-09 11:37:18 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-fixes-for-v6.9-1

for you to fetch changes up to b3810c5a2cc4a6665f7a65bed5393c75ce3f3aa2:

  x86/efistub: Clear decompressor BSS in native EFI entrypoint (2024-03-15 19:47:09 +0100)

----------------------------------------------------------------
EFI fixes for v6.9 #1

- Explicitly wipe BSS in the native EFI entrypoint, so that globals
  shared with the legacy decompressor are zero-initialized correctly.

----------------------------------------------------------------
Ard Biesheuvel (1):
      x86/efistub: Clear decompressor BSS in native EFI entrypoint

 drivers/firmware/efi/libstub/x86-stub.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

