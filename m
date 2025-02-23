Return-Path: <linux-efi+bounces-2818-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CAE21A40FA0
	for <lists+linux-efi@lfdr.de>; Sun, 23 Feb 2025 16:58:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 318173B4AEC
	for <lists+linux-efi@lfdr.de>; Sun, 23 Feb 2025 15:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C85FE5FDA7;
	Sun, 23 Feb 2025 15:58:07 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2D35BAF0
	for <linux-efi@vger.kernel.org>; Sun, 23 Feb 2025 15:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740326287; cv=none; b=jdreZRXkwXEB6Q9f7pgeGE+bKaD2gYU1zgEhf1h5SPWXg0rINpxon93TQR0RLvQ5rtuma3WO1niqmIEETqGVecvVC4TEAYm+UxNs0ClmszUm0pL/PxFwz3yP0ZbAYjBext3dcUqVoc6UuWseGRKeGtiY6wDQRvOQrwCXkBvjsT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740326287; c=relaxed/simple;
	bh=CEvphsc2E/R5iTREyGDwJ+DBlFN5f9hpVolHGcFMNQo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=BKwenNrlLi/L9BjsvsTKyEN8qOIJGL6VYL8BIFLX5+UyHVso/P4ioa1iLntPGZ+ohMzFqZ4of9xZY4OmigBb3RGQtTaOsI0Jrau8hZYGg2EhyWjfYeiD39rxAb6iF9s03b5xTtKf+U5cxvK/BHm+23WHllv3KsbwXeb4uIm1RDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3ce8cdf1898so29114035ab.1
        for <linux-efi@vger.kernel.org>; Sun, 23 Feb 2025 07:58:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740326285; x=1740931085;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EgB9+fNCSp76PfETamdpndoQ+g56KwwlJiC9JLaUFxY=;
        b=u7nxFYMDLylZogaLFtl0lUA0o2k2YsgB1D528fzs1Xc1uNSzohh/sT5IwCDu/fIoV8
         dUrErOGPyyI6XIr0Ri2rgoJ7bvXZQJJnbO/0Up/Nhe01YxqoQ6S6VrgjDs3+q/7Y116S
         tC4ywt56neXm0uNkKzrk6JFy/LCsKvHELCFeDGae4an2DRf5NAcKsqeezcQd7j6L4qqM
         L47rOg5DVI/ITQFhXu+H7+HNozmUDfDl30mkdVmTbeMJ/LFiSHxvFVMQV4felSosOTTG
         mk720WiCU49Ff/9SJJHP2CzTR9/wcPx0Yu/WjQOGpCq/BwmCL0JKfCLPG2+PhPPqaHtJ
         o5+A==
X-Forwarded-Encrypted: i=1; AJvYcCX6OBTg4BmXbWxAnANmznaH7eWju4EsEVCbUydFMDjPiFSIdpPRiWTtp0fput5kyt4vXrpJcLV34NQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRvSShvRGKNAftOqvOPRcamuRmqII7vrJE+BpcM5GZOHbwWH0X
	FPLoQB9+zaLl7QBvtvYm1+vK2AdxvOkiqYXWJFKoYCdqr1lm76o6WmP1oPg/4pPYbCpovHFHUTV
	8jV5/QvUYP4gBKXIsVV6ME/C6+xs3ax5n8SarZpt1DMBfsSP1vuHbj7g=
X-Google-Smtp-Source: AGHT+IEf48EhhTca6NrDfMe6cgbGuj+dvNOVO9lGR88kP0GA1oZuJvG6WTTigu5HZaNxLPIiiaFOqJNHzdrbAeoRcCdqQPRZ48UX
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c26d:0:b0:3d1:9992:bf11 with SMTP id
 e9e14a558f8ab-3d2cb52e5a5mr100678235ab.21.1740326285480; Sun, 23 Feb 2025
 07:58:05 -0800 (PST)
Date: Sun, 23 Feb 2025 07:58:05 -0800
In-Reply-To: <CAMj1kXG1mhe1_eB0oeWukpA_FMTzH5F6zFFszpDTr_x2smvzig@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67bb458d.050a0220.bbfd1.0031.GAE@google.com>
Subject: Re: [syzbot] [efi?] [fs?] BUG: unable to handle kernel paging request
 in efivarfs_pm_notify
From: syzbot <syzbot+00d13e505ef530a45100@syzkaller.appspotmail.com>
To: ardb@kernel.org, jk@ozlabs.org, linux-efi@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file fs/efivarfs/super.c
patch: **** unexpected end of file in patch



Tested on:

commit:         a1c24ab8 Merge branch 'for-next/el2-enable-feat-pmuv3p..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
kernel config:  https://syzkaller.appspot.com/x/.config?x=f6b108de97771157
dashboard link: https://syzkaller.appspot.com/bug?extid=00d13e505ef530a45100
compiler:       
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17fe06e4580000


