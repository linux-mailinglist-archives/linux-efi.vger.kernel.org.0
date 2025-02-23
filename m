Return-Path: <linux-efi+bounces-2819-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE419A40FB8
	for <lists+linux-efi@lfdr.de>; Sun, 23 Feb 2025 17:29:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D0AC1894C39
	for <lists+linux-efi@lfdr.de>; Sun, 23 Feb 2025 16:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCD477DA6A;
	Sun, 23 Feb 2025 16:29:04 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C16377F11
	for <linux-efi@vger.kernel.org>; Sun, 23 Feb 2025 16:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740328144; cv=none; b=nfdebUjBxGQiTE7paRmkDOPFQe++Q877y06OvrJO3sjs0Xv5NBSQQ+V1aadfHXOfUPReDW0QdWCLXPhRvLKP/DWMAnQF5x3gz1gqIZqIvc4Dln6Da/fhRf0+e9/rkrK4R1chsYXOaDXE/e+ndr2RgfuA/VRCB2SPuFaINn8N2aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740328144; c=relaxed/simple;
	bh=BJJMIAODFBZ2zV28pMTXGqIeFv9HDdzI5mGygrT99MQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=LlxDBTAjtgZaovsKA1eZkMHGp/I5snisGS0893ZKy6+MhaNafAyhWQ+J8sCgJVOIsetQOUf++hhu3Qf/p0nTNWfshP/lYLGh45FZRnRnOM0MJFAW+GbygMtfCZAQFq30HsmNrT5cNowjHW0M39RcfT/C6HvQT5TaZ++3kfRn4Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3d2b70f5723so75502485ab.1
        for <linux-efi@vger.kernel.org>; Sun, 23 Feb 2025 08:29:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740328142; x=1740932942;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qePKE6DKwAycNvqydZPkWZJjbpYUhcvm8VYZZd2e7n8=;
        b=kGDqathlN4AZp25P48vMgJFsyd/U2rFr2X1+/7iGzwKIjLuyain+PIcvQXyW/HMcaO
         1PB+eNZwh5JCdxxHRf2BauQ3ZjbAXU5JrZBe5YsH0SBkjzHlIBLk/9XIUC5lDE9wLkVg
         /sTBLeCCcmAzh7CHR/OAGaBdRiFyxNhh3arIkMd61qs3nIqCHRm42hsEl7STa58kaGrk
         H9wlwjp0/V9Ne4ke2YuVrCnZ8+EOfVVnzu+U7a96NVzvHxpbINPwvZ3nE8KbxneUofTV
         WXboxRa4oqaCUDwtOqVPjPSXAV5y6KwbmHVPnWQrjb5Q3zUe1JB9rtYnF44UgMr+8y2Z
         MWSQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1vxg2IsCTQV55Tz++vh1+EE2AyZcryrgfkhjKKvZOvGUGWq8X+yw1rWbpSPEsWLc5VJnTWM9oY5o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFtIJHIjpsm+2knrBO7/UcROPdQ0d7NlV3TUmXVNVMO6uBeCjJ
	TX+kVqaSnsoNRmo9/BhvL+6HOuafmJhP7msOtCV5icGFc//DFPrnS96ESVJLBJ2oQ6/G///U4QU
	iFfVEpEVEvI4+V+Jw1YpKQglqlWcvZflecCk73KdvcGo1FVvuphlgMCk=
X-Google-Smtp-Source: AGHT+IF6ncIokCXD/xSm4YeShFCIAC7B7m+EQVnJ7HuY8dQfDkKW8DFwMJjcCjPOGWK9RChupBmxaF8xlmmMNx5tXa4n6XlTSQkl
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3092:b0:3d0:21aa:a756 with SMTP id
 e9e14a558f8ab-3d2cae4c215mr112255575ab.5.1740328142383; Sun, 23 Feb 2025
 08:29:02 -0800 (PST)
Date: Sun, 23 Feb 2025 08:29:02 -0800
In-Reply-To: <CAMj1kXE1WgFkP5RG-VhC_P-gMDtyipW7nvE+i+JBSWXW1bqbhg@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67bb4cce.050a0220.bbfd1.0032.GAE@google.com>
Subject: Re: [syzbot] [efi?] [fs?] BUG: unable to handle kernel paging request
 in efivarfs_pm_notify
From: syzbot <syzbot+00d13e505ef530a45100@syzkaller.appspotmail.com>
To: ardb@kernel.org, jk@ozlabs.org, linux-efi@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+00d13e505ef530a45100@syzkaller.appspotmail.com
Tested-by: syzbot+00d13e505ef530a45100@syzkaller.appspotmail.com

Tested on:

commit:         ec7518a8 efivarfs: Defer PM notifier registration unti..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git urgent
console output: https://syzkaller.appspot.com/x/log.txt?x=15dfc7a4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3a97cba3fb7e034
dashboard link: https://syzkaller.appspot.com/bug?extid=00d13e505ef530a45100
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

