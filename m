Return-Path: <linux-efi+bounces-142-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B894480A793
	for <lists+linux-efi@lfdr.de>; Fri,  8 Dec 2023 16:38:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FBB91F20FF7
	for <lists+linux-efi@lfdr.de>; Fri,  8 Dec 2023 15:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73BB431A61;
	Fri,  8 Dec 2023 15:38:41 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B553110F9
	for <linux-efi@vger.kernel.org>; Fri,  8 Dec 2023 07:38:38 -0800 (PST)
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-3b9f0dce5bfso412674b6e.3
        for <linux-efi@vger.kernel.org>; Fri, 08 Dec 2023 07:38:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702049918; x=1702654718;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ahIWnqlLG7o2GvCS3sSEr4BJBQZlUuM+Rx7DCDWofl0=;
        b=wVlIPkUh0MEahuSrHfJbWCK24favsqapZtDxWD89ZZcvQICxGrfd8N3UoI42FxaAUK
         BfqY5YhGPv7hLuLeACsLqTFLi9e0ArllL0TLiWq488/sYw8KsvilNyLnX/AKPl9pCQLS
         HPH+Wlm5KoeNAiuSVvCzNL6AEJg4zYXeWBiic/Yj9Gvnt/6SRxboyFCMH8yLJrvBCTV6
         MJKY07A6l5oeIIUYHgpgF2CaUJjZqDXDzNDxA9OjftgqWB4hlY2eSxkZYlts8rNyoKJ1
         6xfU7qTEb3eugz9qrPC+v3l+SpRMknyw3E13c6c8tbXe6D8SChqb/Swdus4iKcPMJ2nq
         jJpQ==
X-Gm-Message-State: AOJu0YwWVyqIlbjqD1FRhmR8F+CK2USnrjhsAakSjwudnJGSOHCnPRpj
	jgncNuPY/+hGfvV3RbjDTX+uQtwS6UIpJ5L0LQy9kQEDgkUM
X-Google-Smtp-Source: AGHT+IHOLAlnD/04ddOH1uufUFXo9s24hIBEAnNH7j41Fr4mr8Igody3/IJiBE0UC3p5YBKjvsGu9nur80cbbsvG6kDgSmnfun12
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:3082:b0:3b9:ef48:de85 with SMTP id
 bl2-20020a056808308200b003b9ef48de85mr151647oib.2.1702049918089; Fri, 08 Dec
 2023 07:38:38 -0800 (PST)
Date: Fri, 08 Dec 2023 07:38:38 -0800
In-Reply-To: <CAMj1kXFBa2z3FKaEzRyJ1ugZy7P3VfS18hheDs8-+pZ+Gch4pQ@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c2015d060c016027@google.com>
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
>>
>
> #syz test git://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git

want either no args or 2 args (repo, branch), got 1

> ecbfc830fd039

