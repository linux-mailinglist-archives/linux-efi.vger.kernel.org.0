Return-Path: <linux-efi+bounces-143-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 995E780A795
	for <lists+linux-efi@lfdr.de>; Fri,  8 Dec 2023 16:38:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81C5D1C20858
	for <lists+linux-efi@lfdr.de>; Fri,  8 Dec 2023 15:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 898CB31A61;
	Fri,  8 Dec 2023 15:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zPsInmfB"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B7291985
	for <linux-efi@vger.kernel.org>; Fri,  8 Dec 2023 07:38:52 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1d0b40bb704so184435ad.0
        for <linux-efi@vger.kernel.org>; Fri, 08 Dec 2023 07:38:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702049932; x=1702654732; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7xwVmZrzP0c2lIlODnSl4xYYxWzG0SjlRwViyc8gK0c=;
        b=zPsInmfByl69vmTd/f6fFeKnS6aOdf8nOPZJjsFZrCkpLnEs3g98/W09BOnn62cVdp
         XZJ8TWV/ux+YJg0137D+Ugwy5bs/5Il7CFs4SdHxBC/bNeSV+xx2CG06OZ2kc5Ib3EPQ
         cpKcVu0TnIrBQUGp246KJWZJTFJPesCIVkBkCB2ZKhhI1mRLSqdy2USeJ8HS5xjCCU8z
         U2O7vFiFhBR9MaDMzuD9wln/M9JVtCJblq7p3GGRx35Crl1hPeS0KivgdaX+/pO40LsA
         5I9d7E+POZmwbbXlnVxcIvlaPtbmwpH6T8T5upUdQxwaUCXNRIVV6126vy4sHYmYUcDV
         MNWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702049932; x=1702654732;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7xwVmZrzP0c2lIlODnSl4xYYxWzG0SjlRwViyc8gK0c=;
        b=P8Bu6Z6YCjKmwG/+R+57JYF1UuM0p6hD64vyqUwwYHyV6f1H3UYzowvp425wfLSY5f
         TITkunXRYaug5Cf5ZqlVvRjVerF23PZO2YA/w6DQPytU/vUPbTy5SDdpH3lCEmD2njAv
         i6DlhWy5iOwJQ61s0Ca5vFDMN0XYHDIIP8YrWSMOP1B1QvwHbx7Nu9dJN8u6oKaou5vW
         V4akG0QMbQq97yXtAfIbPNsEefjcmqzJ4T6mlU3IKyNmUvTenpVs7NQPpaN4ujTYzl+9
         ZzJwgdO6eTbqSJtFhMX6hUHDCUs4+IVvVyX7sJc58Lf6pmJkt9cFyhFXv8YjpCvwIxbk
         uqlQ==
X-Gm-Message-State: AOJu0YxMYu7YjyEfTknA5iEpslPG5PRQ2Kkp0JZc3MUhqdbkaXDul+sA
	fzohuxHWN36pM+9OsHfoRG2xm3jDt9St7er4yW0SBg==
X-Google-Smtp-Source: AGHT+IFAr+OJQDAATO0NDetvfyN7mUgDq/VtMB3soqVtPhPFpvmluSMPXED5oik5CmeV+1r7PhLsnzGVvbAO4qHeKIc=
X-Received: by 2002:a17:902:ced2:b0:1c9:e48c:726d with SMTP id
 d18-20020a170902ced200b001c9e48c726dmr141229plg.4.1702049931742; Fri, 08 Dec
 2023 07:38:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMj1kXFrexNBSDGGRaQQh=6_O=nm2NET_unZ4Qy618461H6maw@mail.gmail.com>
 <00000000000010057c060c012e63@google.com>
In-Reply-To: <00000000000010057c060c012e63@google.com>
From: Aleksandr Nogikh <nogikh@google.com>
Date: Fri, 8 Dec 2023 16:38:37 +0100
Message-ID: <CANp29Y4bxQzV-=rSQOBPfi2Rxrob_GTHZrsGAgvemvnXgC5a3g@mail.gmail.com>
Subject: Re: [syzbot] BUG: corrupted list in efivar_entry_remove
To: syzbot <syzbot+1902c359bfcaf39c46f2@syzkaller.appspotmail.com>
Cc: ardb@kernel.org, linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

If a command spans over two lines, syzbot expects a colon.

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git
efivarfs-list-corruption-fix

On Fri, Dec 8, 2023 at 4:24=E2=80=AFPM syzbot
<syzbot+1902c359bfcaf39c46f2@syzkaller.appspotmail.com> wrote:
>
> > On Fri, 26 Aug 2022 at 13:10, syzbot
> > <syzbot+1902c359bfcaf39c46f2@syzkaller.appspotmail.com> wrote:
> >>
> >> Hello,
> >>
> >> syzbot found the following issue on:
> >>
> >> HEAD commit:    680fb5b009e8 Merge tag 'arm64-upstream' into for-kerne=
lci
> >> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/li=
nux.git for-kernelci
> >> console output: https://syzkaller.appspot.com/x/log.txt?x=3D126f086508=
0000
> >> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D4557ad2600=
fc45f4
> >> dashboard link: https://syzkaller.appspot.com/bug?extid=3D1902c359bfca=
f39c46f2
> >> compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c=
2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
> >> userspace arch: arm64
> >> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D10039fc3=
080000
> >> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D16f4ebc308=
0000
> >>
> >> IMPORTANT: if you fix the issue, please add the following tag to the c=
ommit:
> >> Reported-by: syzbot+1902c359bfcaf39c46f2@syzkaller.appspotmail.com
> >
> > #syz test git://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git
>
> want either no args or 2 args (repo, branch), got 1
>
> > efivarfs-list-corruption-fix
>
> --
> You received this message because you are subscribed to the Google Groups=
 "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgi=
d/syzkaller-bugs/00000000000010057c060c012e63%40google.com.

