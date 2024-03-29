Return-Path: <linux-efi+bounces-901-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A8B5892166
	for <lists+linux-efi@lfdr.de>; Fri, 29 Mar 2024 17:17:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4393D1C23636
	for <lists+linux-efi@lfdr.de>; Fri, 29 Mar 2024 16:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 666DD8564D;
	Fri, 29 Mar 2024 16:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="khBxdBHA"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6374F606
	for <linux-efi@vger.kernel.org>; Fri, 29 Mar 2024 16:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711729048; cv=none; b=OZ2nmwTDQsdqCNhi3m7HvZY8mebCOHDdfV41xKkqOVpaoptCC43mHnDMKj8z4vcL3x7vsuLSXMe2VIdz0CRZ0FyEK1yOCgp+gIFjIYa+U+KRpHXNSKF6xwdxLYYurkzDUjUkuFEoUHRwFYjQHQq7pBhsMrPhWMWhZQvVZXhuQE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711729048; c=relaxed/simple;
	bh=gb2exoSaphVTg/uuxrw0pJeVgNSnYs6lTbYioWpQQOo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=eI60m02Tdn8KxzGVKDg9Wt2l8tT8uVDa7kUrRr5uVbo5QlwI8XWC66A5EmIsBRvqJ4mNbjMS8vG37UQLvM8knchcAr6nhmNIiklaD6Qn/QxSaW+CHuG1JKgCG+4Iz+GM7cBnT5hLADOSCB9SMja0zkY0Ukg3eAr4vukc8SmcJzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=khBxdBHA; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dd1395fd1bfso3400009276.0
        for <linux-efi@vger.kernel.org>; Fri, 29 Mar 2024 09:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711729046; x=1712333846; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Qzld6YuveTxhxuUBOwnQStE8q3rjFMDizR1DDW/x1g8=;
        b=khBxdBHAChihLWjIheL3cY630uhuHuwAItMi+2IyXC6z0BBAe6mZGrdQsMyWSx4ljC
         JAbOTU9eJR7lF/q9O6IRxpc+kByH7sgY4Cspes4ZbXaTMFEuGqhhfdIJkkQLJw3TE+1U
         iSp5sTDQAY/0XsG5eJMALKlgmG8LNwFVVY26YbJH1DIayAFyjuvsFx0wtArNg4YNEmW0
         DNX9rqDyDi+iyD6hg0WoDmyKj0iW/s18Y5dBLfXGTSrSDL0sHPeXbrUnxLTqRT2CREWI
         Eysr0z1gcj/rqoqd0ikV+WOZZx6uEfnNuGaOa84pUvZ4rzkSmEfmsX7mHZ1rGHXM8o5J
         EI/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711729046; x=1712333846;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Qzld6YuveTxhxuUBOwnQStE8q3rjFMDizR1DDW/x1g8=;
        b=NowBhPY41jYLTdiArS2z55bURFkPq3ryXciqHLB8cmPUeWMkYQ6+TNzKgI1LQFsiPi
         +fbB5bhUfLpLRASdPkGvw1t/0A/Jw7dDslxpakjbGvz3fKpGYeGf7r0kXcSHEjmLbKYE
         xsR9L8pJ3HMTdV/jBycefHtj/horOfnqDcnpWnOpWYdnAZo3RDVass/He3V3qMdX3vhw
         GPLg8MYcN/CoYIUuuGNdiZnGZEorwsXS1SPl6vxH3ULkuto/M4XLCMGDpVMeJCXsd+F4
         ONwaharMrIVK2nFUN5Mf0RN4UGstQ8iMJTPOsB3x1ivzmUmajXz5urm+JK9+1iOK7Daz
         1ZLA==
X-Gm-Message-State: AOJu0Yxi2ztmBnEL6E2z0yLY94xq9HbX/o5MyOWZQ00KdkFCzg7YXgHY
	/g2hc5VnjpD9OE7jQd8LYDCTJhZvf+AyF4QnK+0lmxkgnMPjjzJvvqjgvWBucWZP07uTcA==
X-Google-Smtp-Source: AGHT+IEvItu9ZsOTf+5gIyNBbVkFlkqGAJEq96LGMyu/e7sIasc+V2S4Ukq5xhYiK+h/ntqpY8hVwai1
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:6902:248d:b0:dc7:49a9:6666 with SMTP id
 ds13-20020a056902248d00b00dc749a96666mr807074ybb.3.1711729045833; Fri, 29 Mar
 2024 09:17:25 -0700 (PDT)
Date: Fri, 29 Mar 2024 17:17:13 +0100
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1438; i=ardb@kernel.org;
 h=from:subject; bh=oYZVQo6AZozQUzya0EP6J+8q03JtOSkwKUBTmg0AMpo=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIY3tZaf3RA8FlsJHv7f/nfqdfX5Xs2fE1b9syo+MAttLQ
 r+fcmPpKGVhEONgkBVTZBGY/ffdztMTpWqdZ8nCzGFlAhnCwMUpABNprWf4X+80ze7hZy8t3obl
 j32aMnd2PL9122Df+RcCoaac6zdNZmdk+Mwv9Tq89emdfa+9bK4r7158weO22rxv71vftO7bquL 9lBkA
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240329161712.596062-2-ardb+git@google.com>
Subject: [GIT PULL] EFI fixes for v6.9 #3
From: Ard Biesheuvel <ardb+git@google.com>
To: torvalds@linux-foundation.org
Cc: linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Hello Linus,

Please pull the EFI fixes below. These address all the outstanding EFI/x86 boot
related regressions.


The following changes since commit 4cece764965020c22cff7665b18a012006359095:

  Linux 6.9-rc1 (2024-03-24 14:10:05 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-fixes-for-v6.9-3

for you to fetch changes up to decd347c2a75d32984beb8807d470b763a53b542:

  x86/efistub: Reinstate soft limit for initrd loading (2024-03-28 16:19:46 +0100)

----------------------------------------------------------------
EFI fixes for v6.9 #3

- Revert to the old initrd memory allocation soft limit of INT_MAX,
  which was dropped inadvertently

- Ensure that startup_32() is entered with a valid boot_params pointer
  when using the new EFI mixed mode protocol

- Fix a compiler warning introduced by a fix from the previous PR

----------------------------------------------------------------
Ard Biesheuvel (3):
      x86/efistub: Add missing boot_params for mixed mode compat entry
      efi/libstub: Cast away type warning in use of max()
      x86/efistub: Reinstate soft limit for initrd loading

 arch/x86/boot/compressed/efi_mixed.S       | 20 +++++++++++++++-----
 drivers/firmware/efi/libstub/randomalloc.c |  2 +-
 drivers/firmware/efi/libstub/x86-stub.c    |  1 +
 3 files changed, 17 insertions(+), 6 deletions(-)

