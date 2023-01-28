Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFF9467F966
	for <lists+linux-efi@lfdr.de>; Sat, 28 Jan 2023 17:03:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231185AbjA1QDB (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 28 Jan 2023 11:03:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231442AbjA1QDA (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 28 Jan 2023 11:03:00 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 498A14C02;
        Sat, 28 Jan 2023 08:02:56 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id 5so7739516plo.3;
        Sat, 28 Jan 2023 08:02:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RwlVhufHKdHMAsDhkVwwuRltMgkw9jFvXAOVM33QygA=;
        b=qb3iTWCOYpJLzZJAiJoBUOd+Q4nzBNn3Uf52qjxDb33bXf7q2Ka4Te/acSHzAUcLK6
         xvViOB6whN27yEnBZhECTr1EQ8Kyy0V4AIzGTygi1QSs742iFdaXNErwYuKVlDnkP14c
         5xw2t4h+kaMtenScBGYb/CtgDXhsGBVGcKfQN4HDE2gXwvQ3/k1mODhuRslStsevCwXU
         9DhxoAbN/gEj5QiA/kuGqB5Rsfx+Dn8eEuVkt532Z0pqwFVZ2mXNwrpPZe2m6P0cDawi
         AONOJjt3lh/hSft6aQH/G7Fe0npvEQSuKTo8QPwYiMaVgyL9dFaQccbO+fgCI83vPS7p
         HFBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RwlVhufHKdHMAsDhkVwwuRltMgkw9jFvXAOVM33QygA=;
        b=1FHk1FbKs7zCVUwQ0qyY+ZoLzRjPePnGIMAXEm2l9giqg+hk096CPBSHzL6INHYJCk
         A67eYCzyRQ7GzwCwUu6x8qWTahgv6lWJekebLb67fPrPFtCbY0BBDO0jcYxH2D29cARy
         hTw7/K1afhxa8ZcasqPmygn3gL4qWnOgx1GHprHDsOKL2XIVFEzpK3x0Ynfk1WwIJx+3
         RaJlPUno1cd2eU7dh+oovc2TshpvSaVl7WCKaB0iWEal+B8+p/+MVfVDDZM088LuFYC0
         wA0wJiSBbPLD0hD2yS02l+s8eChsBX9uiRaZKiceTLRu7wkosm5hl9ZggPL7o1qMfrMm
         VcbA==
X-Gm-Message-State: AO0yUKXc7O2Ob66FdU+OrL7yxyISlr/qIxW7wNu6WgPbowUXS4C6V9sG
        h6e7lWR+ST0yhOmPqVgJWN+j+0Jdzq5xfpIfnuBEK5/GKman6Q==
X-Google-Smtp-Source: AK7set/WlMFEcMiOX97bnVL/2grP2/y42wjpV9B1sAoWhkjNLOqcfFRgUaCjofhv6fG/3/rFR8sxzEB15Tij2yqWETM=
X-Received: by 2002:a17:90a:4897:b0:22c:13f5:3345 with SMTP id
 b23-20020a17090a489700b0022c13f53345mr1728166pjh.37.1674921775392; Sat, 28
 Jan 2023 08:02:55 -0800 (PST)
MIME-Version: 1.0
References: <CH0PR07MB9824F9A2F2D6B9612BCD2318ABCC9@CH0PR07MB9824.namprd07.prod.outlook.com>
In-Reply-To: <CH0PR07MB9824F9A2F2D6B9612BCD2318ABCC9@CH0PR07MB9824.namprd07.prod.outlook.com>
From:   Pedro Falcato <pedro.falcato@gmail.com>
Date:   Sat, 28 Jan 2023 16:02:43 +0000
Message-ID: <CAKbZUD15s=T7f-srA61qLkKfidDNBAoYQHk1wHqL--iRcWGqZA@mail.gmail.com>
Subject: Re: general protection fault in efivar_lock
To:     Sanan Hasanov <sanan.hasanov@knights.ucf.edu>
Cc:     "ardb@kernel.org" <ardb@kernel.org>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "contact@pgazz.com" <contact@pgazz.com>,
        "syzkaller@googlegroups.com" <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Jan 27, 2023 at 11:55 PM Sanan Hasanov
<sanan.hasanov@knights.ucf.edu> wrote:
>
> Good day, dear maintainers,
>
> We found a bug using a modified kernel configuration file used by syzbot.
>
> We enhanced the coverage of the configuration file using our tool, klocalizer.
>
> Kernel Branch: 6.2.0-rc5-next-20230125
> Kernel config: https://drive.google.com/file/d/1qDN6q_k12wcgp6dt4jfF4hpk3Ix5FaKX/view?usp=sharing
> Reproducer: https://drive.google.com/file/d/11bfgp5hzObE2om0k0bNfeSIEf_SciGY1/view?usp=sharing
>
> Thank you!
>
> Best regards,
> Sanan Hasanov
>
> general protection fault, probably for non-canonical address 0xdffffc0000000001: 0000 [#1] PREEMPT SMP KASAN
> KASAN: null-ptr-deref in range [0x0000000000000008-0x000000000000000f]
> CPU: 4 PID: 27585 Comm: syz-executor.5 Not tainted 6.2.0-rc5-next-20230125 #1
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
> RIP: 0010:efivar_lock+0x4e/0xa0
> Code: a8 28 0f fc 45 85 e4 75 3f e8 ee 2c 0f fc 48 8b 1d b7 aa c5 05 48 b8 00 00 00 00 00 fc ff df 48 8d 7b 08 48 89 fa 48 c1 ea 03 <80> 3c 02 00 75 39 48 83 7b 08 00 74 19 e8 c0 2c 0f fc 44 89 e0 5b
> RSP: 0018:ffff88802549fca8 EFLAGS: 00010212
> RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffc90003cb0000
> RDX: 0000000000000001 RSI: ffffffff85792a42 RDI: 0000000000000008
> RBP: ffff88802549fcb8 R08: 0000000000000005 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000001 R12: 0000000000000000
> R13: 0000000000000000 R14: ffffffff82595920 R15: 0000000000000000
> FS:  00007fafd9f83700(0000) GS:ffff88811a800000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f9e23270d78 CR3: 00000000233bb000 CR4: 0000000000350ee0
> Call Trace:
>  <TASK>
>  efivar_entry_iter+0x29/0x150
>  efivarfs_kill_sb+0x2f/0x40
>  deactivate_locked_super+0xa6/0x190
>  vfs_get_super+0x235/0x2b0
>  get_tree_single+0x2b/0x40
>  efivarfs_get_tree+0x21/0x30
>  vfs_get_tree+0x97/0x370
>  __do_sys_fsconfig+0x981/0xd20
>  __x64_sys_fsconfig+0xc1/0x150
>  do_syscall_64+0x3f/0x90
>  entry_SYSCALL_64_after_hwframe+0x72/0xdc
> RIP: 0033:0x7fafd8e8edcd
> Code: 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007fafd9f82bf8 EFLAGS: 00000246 ORIG_RAX: 00000000000001af
> RAX: ffffffffffffffda RBX: 00007fafd8fbbf80 RCX: 00007fafd8e8edcd
> RDX: 0000000000000000 RSI: 0000000000000006 RDI: 0000000000000004
> RBP: 00007fafd8efc59c R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007fff23221a7f R14: 00007fff23221c20 R15: 00007fafd9f82d80
>  </TASK>
> Modules linked in:
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:efivar_lock+0x4e/0xa0
> Code: a8 28 0f fc 45 85 e4 75 3f e8 ee 2c 0f fc 48 8b 1d b7 aa c5 05 48 b8 00 00 00 00 00 fc ff df 48 8d 7b 08 48 89 fa 48 c1 ea 03 <80> 3c 02 00 75 39 48 83 7b 08 00 74 19 e8 c0 2c 0f fc 44 89 e0 5b
> RSP: 0018:ffff88802549fca8 EFLAGS: 00010212
> RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffc90003cb0000
> RDX: 0000000000000001 RSI: ffffffff85792a42 RDI: 0000000000000008
> RBP: ffff88802549fcb8 R08: 0000000000000005 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000001 R12: 0000000000000000
> R13: 0000000000000000 R14: ffffffff82595920 R15: 0000000000000000
> FS:  00007fafd9f83700(0000) GS:ffff88811a800000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f9e23270d78 CR3: 00000000233bb000 CR4: 0000000000350ee0
> ----------------
> Code disassembly (best guess), 1 bytes skipped:
>    0:   28 0f                   sub    %cl,(%rdi)
>    2:   fc                      cld
>    3:   45 85 e4                test   %r12d,%r12d
>    6:   75 3f                   jne    0x47
>    8:   e8 ee 2c 0f fc          call   0xfc0f2cfb
>    d:   48 8b 1d b7 aa c5 05    mov    0x5c5aab7(%rip),%rbx        # 0x5c5aacb
>   14:   48 b8 00 00 00 00 00    movabs $0xdffffc0000000000,%rax
>   1b:   fc ff df
>   1e:   48 8d 7b 08             lea    0x8(%rbx),%rdi
>   22:   48 89 fa                mov    %rdi,%rdx
>   25:   48 c1 ea 03             shr    $0x3,%rdx
> * 29:   80 3c 02 00             cmpb   $0x0,(%rdx,%rax,1) <-- trapping instruction
>   2d:   75 39                   jne    0x68
>   2f:   48 83 7b 08 00          cmpq   $0x0,0x8(%rbx)
>   34:   74 19                   je     0x4f
>   36:   e8 c0 2c 0f fc          call   0xfc0f2cfb
>   3b:   44 89 e0                mov    %r12d,%eax
>   3e:   5b                      pop    %rbx
Hi,

Should be fixed by
https://lore.kernel.org/linux-efi/20230126112129.4602-1-johan+linaro@kernel.org/
(squashed into c3fd71b428b8fa on Ard's tree). Also in linux-next.git
301de9a205535737.

Can you see if that fixes your crash?

-- 
Pedro
