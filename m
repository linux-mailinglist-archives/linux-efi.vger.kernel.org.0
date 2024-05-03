Return-Path: <linux-efi+bounces-1013-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 344628BAB53
	for <lists+linux-efi@lfdr.de>; Fri,  3 May 2024 13:03:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2E89283583
	for <lists+linux-efi@lfdr.de>; Fri,  3 May 2024 11:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65C4B17758;
	Fri,  3 May 2024 11:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N2rw7GJn"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46E3433DD
	for <linux-efi@vger.kernel.org>; Fri,  3 May 2024 11:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714734190; cv=none; b=A7kXQPV0UgONOYxvzi/p/sHN6cHDWoyRB6U2BNOLnpXYlp5CmucSuS5TUADoQ1+bu7krDkNEH3UcrR33ZDp5vbl48/hQQXI6k2YP4J0VwaJAmnGoDgwUjD92pw/XWqA7e0qoDtSP8c2+fSrFMCZK/0k9cFVb8h/CDrU34y+Btnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714734190; c=relaxed/simple;
	bh=/L8DKAaiE0QuNDT21zX7T9vKybgi4ccoWQ4z7dC2lPw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=BzH1HPGPozpa2Fsf9AUB6KJISKVm+qU/A5ygxQ9T6jxPli+tdOJRxBYPAmpbq1MTY3/kG0DndGHyp+CRgSNrsQV/aMuwyjFu07VSQqXngtZjLxkP3y590GgFx49KRC2JiXOsAl+h7/IO4x6SbXShtlgQHf13RXWe/7bF43Eesa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=N2rw7GJn; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-416ac21981dso14879405e9.1
        for <linux-efi@vger.kernel.org>; Fri, 03 May 2024 04:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714734187; x=1715338987; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Pbh948z5RzOxpK+Sdb/eGhVahB6iLv7w1vf3gkp3W7A=;
        b=N2rw7GJn5/wJkO+BzgZWTYleMOumss4Wa+VFw5ogVSFZjoVz9/Nu2tqwYHXV3yMh1h
         vnhtqYCKJZpAXaQ4kjLgQN9wcQBnsTiLecU1vM+Xjqq8BABeNTMuJsO5aFriM9vhAog1
         K9V1PCoLb6iL9LXvT3aNMjUZdjpmOPnkN8XNQ/g2L/72hg3lk9Bla0h/RZ+u9OYIbwJI
         wpfpl6OWoTH3dX37xVhzRqoP0cvL+7p9ASy7yDUaKOcFMfIU4LuU5uoKJfxJDugdw4ag
         v5ODSW0muuTVhc97TS775iY2we36nQxiihWqPNkc4qdz42hTDEaYUnZ296Qeo/rX0ML7
         GBrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714734187; x=1715338987;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Pbh948z5RzOxpK+Sdb/eGhVahB6iLv7w1vf3gkp3W7A=;
        b=us/Jt/JuB6YikDhZmj0oudhiAhDLNg+yWh55kXOwLuwKy9UXO0fOcJTx+mSS70lxAT
         1OXBMBoosOhjsvDuFzEWj0V47RMVYxFi/lraIotcabYYX6bdhI5EX9RM/tgTPAtS69zt
         tryOOrCoXlH2d0/a8HdZIR+wj1eurK7aZ9DfnKy6I3QcZ8sYzNN3CLPyG1UOYUv0YytR
         C+/Of79NKrpZIT8CcQxKC03CuCOtt++8X6gqnFeIsAKemgPf60XLB/T20mD4AoELmg1W
         +a+isKPiuAgewIaSypMuqlsKO7+x9UQWs/HeRVWiyuIjnWGiC/sEoQAI/vHteo0MESJN
         dzTg==
X-Gm-Message-State: AOJu0YxVzozqldgQdl6MLxSGtragIRbnge13d0u//G40/IjKQcOQAsrq
	9UNVpRZCODMe9b33IpfxOPGdyfke2E+meNTvi9OawYBJCP1yurJa0TFX9O/h8gBm9yZU/g==
X-Google-Smtp-Source: AGHT+IE8t6kk+9DfHgXzfDj71ve4pfN46UshK2d+0WLw/NBG13tjjn2LcdYswWNZgWaIvULAx5Y0vh9+
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:600c:1d08:b0:419:e61c:f388 with SMTP id
 l8-20020a05600c1d0800b00419e61cf388mr77272wms.4.1714734187202; Fri, 03 May
 2024 04:03:07 -0700 (PDT)
Date: Fri,  3 May 2024 13:03:03 +0200
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1237; i=ardb@kernel.org;
 h=from:subject; bh=7jIF8x0cFTlwcoDbiDOjxZgat/RrYAFkzKt1Oo1lGNk=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIc3kSPqad5E290+tqV146bGWl8/KVsFHXT3/5mZ07N7y6
 5SOfsqrjlIWBjEOBlkxRRaB2X/f7Tw9UarWeZYszBxWJpAhDFycAjAR3pmMDFOC3sps0Gpp/7H7
 x/42wQpui70Ryg7CvV335MsMpeIlVzD8Zu+ekvbhupHumrNzfy0yed94ZLlazoOpXQmhbldMZLf IsgEA
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Message-ID: <20240503110302.2339230-2-ardb+git@google.com>
Subject: [GIT PULL] EFI fix for v6.9 (#1)
From: Ard Biesheuvel <ardb+git@google.com>
To: torvalds@linux-foundation.org
Cc: linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Hello Linus,

Please pull the EFI fix below - it works around a shortcoming in the memory
acceptation API, which may apparently hog the CPU for long enough to trigger
the softlockup watchdog. Note that this only affects confidential VMs running
under the Intel TDX hypervisor, which is why I accepted this for now, but this
should obviously be fixed properly in the future.


The following changes since commit 0bbac3facb5d6cc0171c45c9873a2dc96bea9680:

  Linux 6.9-rc4 (2024-04-14 13:38:39 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-urgent-for-v6.9-1

for you to fetch changes up to 1c5a1627f48105cbab81d25ec2f72232bfaa8185:

  efi/unaccepted: touch soft lockup during memory accept (2024-04-24 19:11:34 +0200)

----------------------------------------------------------------
EFI fix for v6.9 (#1)

- Avoid triggering the softlockup watchdog when accepting large chunks
  of memory from the hypervisor

----------------------------------------------------------------
Chen Yu (1):
      efi/unaccepted: touch soft lockup during memory accept

 drivers/firmware/efi/unaccepted_memory.c | 4 ++++
 1 file changed, 4 insertions(+)

