Return-Path: <linux-efi+bounces-140-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1063380A749
	for <lists+linux-efi@lfdr.de>; Fri,  8 Dec 2023 16:24:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EA721C20319
	for <lists+linux-efi@lfdr.de>; Fri,  8 Dec 2023 15:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EBE4208AB;
	Fri,  8 Dec 2023 15:24:31 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com [209.85.160.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C8BC10F1
	for <linux-efi@vger.kernel.org>; Fri,  8 Dec 2023 07:24:28 -0800 (PST)
Received: by mail-oa1-f71.google.com with SMTP id 586e51a60fabf-1fadd34d7e5so3714607fac.3
        for <linux-efi@vger.kernel.org>; Fri, 08 Dec 2023 07:24:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702049067; x=1702653867;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A1HT6KdMEtZzB/+LWM0YZABVs05WlLcsC/jFOBBJO7c=;
        b=cbzJOzsH3cFGpQp3VKfwWatljvUCUo3Al3Mn2iEbzQ6q0irSMDAON4BCinudcfM+EX
         +GzjUPJQwcpIi/9Id7OpkLeqNTnCRCqn2y4/etWljcTX9wxDPvfVatZndHRmX1GiZNRX
         dLrOs6SjDsQQNvpIwlYg0IB4QNj6a66EUPD0HKi8s457N6aUOXi4dBpFj7TPPw118nxw
         /s1rohy1k5PhgoMwVzm5SCsc3PW5tb4nR/LQH4XaY84acXudj8Yo5thaTncJLwUutQy9
         3qEnCNG1vBVUhUx8lwmu+TaM1KYM5jhMLxxmKmcSJcsVFI5xkiEMTGkp3ccJJL4o4p/b
         iESw==
X-Gm-Message-State: AOJu0YyoTpX76b7eNUA12ntmaTQdlp2k8RmD1JAP50qcSA1lUA93+JWY
	q27niGaU4jHh8yI8pPJfS+Ic6rWKZmGOlNaim0suKRCfxVJi
X-Google-Smtp-Source: AGHT+IH3zWKK4v1FlR7+V+9DN7EhFjDbW/pgByFdpA0Zp8hdex+2ghQB/Uf7uJziE44YsPhRqi4uZ5QO68h5TOCl/nj8xzQVnNYy
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6870:b01a:b0:1fa:e0c9:56e9 with SMTP id
 y26-20020a056870b01a00b001fae0c956e9mr186218oae.6.1702049067564; Fri, 08 Dec
 2023 07:24:27 -0800 (PST)
Date: Fri, 08 Dec 2023 07:24:27 -0800
In-Reply-To: <CAMj1kXFrexNBSDGGRaQQh=6_O=nm2NET_unZ4Qy618461H6maw@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000010057c060c012e63@google.com>
Subject: Re: [syzbot] BUG: corrupted list in efivar_entry_remove
From: syzbot <syzbot+1902c359bfcaf39c46f2@syzkaller.appspotmail.com>
To: ardb@kernel.org
Cc: ardb@kernel.org, linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

> On Fri, 26 Aug 2022 at 13:10, syzbot
> <syzbot+1902c359bfcaf39c46f2@syzkaller.appspotmail.com> wrote:
>>
>> Hello,
>>
>> syzbot found the following issue on:
>>
>> HEAD commit:    680fb5b009e8 Merge tag 'arm64-upstream' into for-kernelci
>> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
>> console output: https://syzkaller.appspot.com/x/log.txt?x=126f0865080000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=4557ad2600fc45f4
>> dashboard link: https://syzkaller.appspot.com/bug?extid=1902c359bfcaf39c46f2
>> compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
>> userspace arch: arm64
>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10039fc3080000
>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16f4ebc3080000
>>
>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>> Reported-by: syzbot+1902c359bfcaf39c46f2@syzkaller.appspotmail.com
>
> #syz test git://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git

want either no args or 2 args (repo, branch), got 1

> efivarfs-list-corruption-fix

