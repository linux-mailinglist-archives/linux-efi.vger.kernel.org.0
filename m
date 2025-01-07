Return-Path: <linux-efi+bounces-2525-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E349FA04BC7
	for <lists+linux-efi@lfdr.de>; Tue,  7 Jan 2025 22:33:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C8AA7A2D44
	for <lists+linux-efi@lfdr.de>; Tue,  7 Jan 2025 21:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0B001F7574;
	Tue,  7 Jan 2025 21:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="f1fRj/54"
X-Original-To: linux-efi@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [104.223.66.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC4B1802AB;
	Tue,  7 Jan 2025 21:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.223.66.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736285514; cv=none; b=gksiYTvDYh7HwDQI08yM1n0qZxiKdSm1Y/cWeuqr321uE8vm5dmy3EcDfnWLERw4Iqo7hNybm4cKwLyZGG2eg+3o8lSCaYaX7hVmL3E6sR7L/4zqRXk7i+GZIXmj9oQV9YXQOg7sHKtJmKPePHSBb1pSDYdSW0B7xO0fU4hLhOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736285514; c=relaxed/simple;
	bh=0ee1yytagWWh+LM17oG9lW48tso28G+hG5WX4aNO+14=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TaAfLwimuGwWtvE+xS9WMqWuCoXyPDwterUEncZJSMizO6lHLv+L0emwqPErRTqilqJpEDRWH0X60KkJaANmdDsu4QhdKpkU34NtXJZPo0K5dPWppjPCjbNL+ij2QyH4Z63N+e8YQh+KiZOIdlWEjHgZkpwQ6ugY87cQm51VnqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=f1fRj/54; arc=none smtp.client-ip=104.223.66.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1736285510;
	bh=0ee1yytagWWh+LM17oG9lW48tso28G+hG5WX4aNO+14=;
	h=From:To:Subject:Date:Message-Id:From;
	b=f1fRj/540GLnGrFTx/Un2Gs9kKxRrNuzpcPTDtlAuEbW/Pprw5iJMAVwfeudQwQMd
	 ar5Y6HRge+VKCyucYJDXU4ZVzj5O2Z+2J0JUmbdKaOJezVA8nNEhrIQhO+OkxV1SRe
	 Xw0sPM5pEKeC6Elncb1hiMnbYdXyA2X1YlgNQosc=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 25EB01286BD6;
	Tue, 07 Jan 2025 16:31:50 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id Cfeyics6kfPZ; Tue,  7 Jan 2025 16:31:50 -0500 (EST)
Received: from lingrow.int.hansenpartnership.com (unknown [153.66.160.227])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 36B311286B13;
	Tue, 07 Jan 2025 16:31:49 -0500 (EST)
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: linux-fsdevel@vger.kernel.org,
	linux-efi@vger.kernel.org,
	linux-pm@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>,
	Jeremy Kerr <jk@ozlabs.org>,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Lennart Poettering <mzxreary@0pointer.de>
Subject: [PATCH 0/2] efivarfs: fix hibernation problem with EFI variables
Date: Tue,  7 Jan 2025 13:31:27 -0800
Message-Id: <20250107213129.28454-1-James.Bottomley@HansenPartnership.com>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I've cc'd both fsdevel and linux-pm on this because no other
filesystem actually has a hook for hibernation so I need people to
think whether the way I've done it (adding a direct PM hook per
superblock) is the right way and then whether the mechanism is the
best one for addressing the problem.

Problem statement: efivarfs is a pseudo filesystem that is used to
interact with the EFI variables.  After the system is booted, the only
way to retrieve and update variables is via the UEFI Runtime Variable
Services, which are mediated by efivarfs, so it caches the state of
the variables (existence and size) in a dentry tree that ls can see.
However, on hibernation the variables may get altered either by other
operating systems or directly in UEFI setup.  This means that on
hibernation restore, the dentry cache may be out of sync and thus
should be updated.  The added PM_POST_HIBERNATION hook brings the
dentry tree back into sync again.

The first patch abstracts variable creation so it can be reused from
the second patch which, on resume from hibernation, firstly loops over
all the dentries and deletes those which don't exist in the UEFI
variable store and then loops over the variable store creating
dentries for ones that don't exist.

Regards,

James

---

James Bottomley (2):
  efivarfs: abstract initial variable creation routine
  efivarfs: add variable resync after hibernation

 fs/efivarfs/internal.h |   3 +-
 fs/efivarfs/super.c    | 187 +++++++++++++++++++++++++++++++++++++----
 fs/efivarfs/vars.c     |   5 +-
 3 files changed, 177 insertions(+), 18 deletions(-)

-- 
2.35.3


