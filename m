Return-Path: <linux-efi+bounces-164-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F18B80C8F0
	for <lists+linux-efi@lfdr.de>; Mon, 11 Dec 2023 13:04:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC7CB281B74
	for <lists+linux-efi@lfdr.de>; Mon, 11 Dec 2023 12:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34DC2219F1;
	Mon, 11 Dec 2023 12:04:09 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com [209.85.160.70])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45AD510C4
	for <linux-efi@vger.kernel.org>; Mon, 11 Dec 2023 04:04:06 -0800 (PST)
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-1ef4f8d294eso6743206fac.1
        for <linux-efi@vger.kernel.org>; Mon, 11 Dec 2023 04:04:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702296245; x=1702901045;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NDJUaE35Q5eJ9ESGe76MeoQ2cPj301p0wZ2CK8kCF40=;
        b=VavOMGcZWKX+ZTnGcfXxlVAnshXMHyOM1UPgC4oagrZ94LStrqjQl/6tq0FO37TeUO
         tHJZI3Fxz8vILAyCfeVfkgLsVjDme1wglQEYFtDhljYfDDDHCz41Vw1gEVVBFUN/R3du
         fwlHbCeOUe3BDsyNZLuk1ObRPy7dOSnUDzQwGLQ+tG56hMoy+c8T/eLllYw6NAbxtCb0
         OkGqJvR8A0t/IvqrIdjr0lvYgjAnlC9A6UJNRL5fv+9uG2D8sbtTOQ+L31qfa4rqihQu
         O/8DUGgzraeCki6qF2MTAAtfs+NmSwyS/TMCvBU3ea3b1S8ytUa8GPl636xXDWsuVhf3
         lDtA==
X-Gm-Message-State: AOJu0Yx+Mbq56p92/nrbTx3g4Mz/lXWzGDMa6z/K/88AE1YE153A2s3u
	KEhgUEQzM94a94xczNOn5fuL+qTOgXCvK2O+NV9df2Znc9/7
X-Google-Smtp-Source: AGHT+IEpu3Rhuig8FQQm2LdUYSYrZrmJdqm7y+zGZ33VE69FZlz3JLxFDCCB3mF0tfrY72/mMQduf4Ivns8gxGgr7bTGx4ohYgn7
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6870:1703:b0:1fb:512d:f394 with SMTP id
 h3-20020a056870170300b001fb512df394mr4838184oae.3.1702296245624; Mon, 11 Dec
 2023 04:04:05 -0800 (PST)
Date: Mon, 11 Dec 2023 04:04:05 -0800
In-Reply-To: <CAMj1kXGsvR1vAfEe=9v4i=OtLpqTGCB8G8jgAvmo8_Zw3TcFnw@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000005e536060c3abb99@google.com>
Subject: Re: [syzbot] [efi] BUG: corrupted list in efivar_entry_remove
From: syzbot <syzbot+1902c359bfcaf39c46f2@syzkaller.appspotmail.com>
To: ardb@kernel.org, linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+1902c359bfcaf39c46f2@syzkaller.appspotmail.com

Tested on:

commit:         94f7f618 efivarfs: automatically update super block flag
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git next
console output: https://syzkaller.appspot.com/x/log.txt?x=1118cbeee80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ef72ff9ec2bc7165
dashboard link: https://syzkaller.appspot.com/bug?extid=1902c359bfcaf39c46f2
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

