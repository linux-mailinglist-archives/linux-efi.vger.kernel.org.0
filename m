Return-Path: <linux-efi+bounces-146-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 11A5A80A8CE
	for <lists+linux-efi@lfdr.de>; Fri,  8 Dec 2023 17:25:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6D60B20B14
	for <lists+linux-efi@lfdr.de>; Fri,  8 Dec 2023 16:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC3983717A;
	Fri,  8 Dec 2023 16:25:08 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EDF519BE
	for <linux-efi@vger.kernel.org>; Fri,  8 Dec 2023 08:25:05 -0800 (PST)
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-6d9f2ec6283so528882a34.1
        for <linux-efi@vger.kernel.org>; Fri, 08 Dec 2023 08:25:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702052704; x=1702657504;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NADYlLeKES7cbeGMNjbEMFy02hFJfzOn/DYe4MvOsgE=;
        b=JZV65w/sdkRWvqchfyqjtDHv010ZOIY5x8/aQA/Kk7H7F3gUH507Z9Oisf90mROvNL
         3m/SaZVqrTiXn1tJlrOHbI5PWnwP+n731QsOY+55USZ446ksPL0OUq9XW/+3SpzhgUfR
         xzEOup7tGCtu2UoAtvKaVXB15Azb23nCrgxLXNk3nIJxAnKcdBZUDOCPD59EqFMpHg6q
         CfF4BtmPuXjBEEJluxZxWfgPLQGaC96y1mP7VuILkN+csAtrZDP+5jZpiuDN4TiqsLgz
         hYwBCymSigkYBO9JJPW/L1zOb+3dgqRbTKQPnfdmkEZDAqrH8hRkt+/1N7oVIBZ97Luy
         A1Xw==
X-Gm-Message-State: AOJu0YxMu7CaezVZPQ8d5iVJgTFg6K+nYvgf/wKWc3vpRZsnOcnVDTKN
	Omp/Vvb6KA0Yg1ymc2spJtAvshgGGuhmbuPksppUFlHInT73
X-Google-Smtp-Source: AGHT+IG6BRWUkk2Xgdw5Y5u1fvjiNqnAGM4BCsPGuuj8F0d1CjG69JFxybor2IxzWlk0HV3RHkoYu1DqOVLlIZSYBq25sasO6dDP
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6830:438b:b0:6d9:f752:1d25 with SMTP id
 s11-20020a056830438b00b006d9f7521d25mr201674otv.1.1702052704621; Fri, 08 Dec
 2023 08:25:04 -0800 (PST)
Date: Fri, 08 Dec 2023 08:25:04 -0800
In-Reply-To: <CANp29Y4bxQzV-=rSQOBPfi2Rxrob_GTHZrsGAgvemvnXgC5a3g@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d91934060c020627@google.com>
Subject: Re: [syzbot] [efi] BUG: corrupted list in efivar_entry_remove
From: syzbot <syzbot+1902c359bfcaf39c46f2@syzkaller.appspotmail.com>
To: ardb@kernel.org, linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	nogikh@google.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+1902c359bfcaf39c46f2@syzkaller.appspotmail.com

Tested on:

commit:         ecbfc830 efivarfs: Move efivarfs list into superblock ..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git efivarfs-list-corruption-fix
console output: https://syzkaller.appspot.com/x/log.txt?x=147a4fcae80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f62dd67b72f86455
dashboard link: https://syzkaller.appspot.com/bug?extid=1902c359bfcaf39c46f2
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

