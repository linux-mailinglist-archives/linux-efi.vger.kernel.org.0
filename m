Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 559214224AA
	for <lists+linux-efi@lfdr.de>; Tue,  5 Oct 2021 13:08:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233790AbhJELKl (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 5 Oct 2021 07:10:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:46172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233705AbhJELKk (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 5 Oct 2021 07:10:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 247AB61139;
        Tue,  5 Oct 2021 11:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633432130;
        bh=SK7eY4NLZwK5bvcJfHQqG6L6urfKlYCHvBS337E52fQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=IC85uUWO2seeOaaSFQTW+PabksX3oQUbsvNgbstYqt43b/Ex7SB+HmubJKDyTaeom
         V5LU+fBI0x8fkjbRpHiFniV3jnZivRVbXzbIMAyi4GV8fKzJeOr7X4i1VofiyizjAQ
         8YB3E93OL0wqyJlDKfB5jUIUmjpTe3WgEE5ysZBKqWGMD3esfxIiulfv7wUzhO0nW4
         k3g2XqeseKFLYTPeUHSbSkkyuRZDlq2tM775p3nGqxZX9SgGCdZCVGe8KxrJ+3oUUQ
         RDnwCSlYXV7euPSryFjEo067DR60IwkDYQwhI6Twkxk3Dg4IFLG3pJ4svwTFnNo6Yv
         Qinw+x6Y5li6A==
Received: by mail-oi1-f176.google.com with SMTP id e24so25675007oig.11;
        Tue, 05 Oct 2021 04:08:50 -0700 (PDT)
X-Gm-Message-State: AOAM532IF/73hwRnVs0GxMYddYdh41Q9c9HKY5Ut4v1qKsX37ENo2au9
        hnKQ96jHIsSFfFrCTCzK4Rch6PD5vSLmOSekA5I=
X-Google-Smtp-Source: ABdhPJw1fTVVd9mg1h4QkZ1n3WgvTTZXBC3+rEmlU4jhDoUQaaTJE71wyR4VXcF9Nl4VCy+cCK2uDn1cXhXeYOELDJc=
X-Received: by 2002:a05:6808:1148:: with SMTP id u8mr1979937oiu.33.1633432129486;
 Tue, 05 Oct 2021 04:08:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210923025340.1469836-1-chris.zjh@huawei.com>
In-Reply-To: <20210923025340.1469836-1-chris.zjh@huawei.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 5 Oct 2021 13:08:38 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFqa5ftkO0EirKeYxzaDLcSagM80qkYPdomdSc-02UK4w@mail.gmail.com>
Message-ID: <CAMj1kXFqa5ftkO0EirKeYxzaDLcSagM80qkYPdomdSc-02UK4w@mail.gmail.com>
Subject: Re: [PATCH -next] efi: Change down_interruptible() in
 virt_efi_reset_system() to down_trylock()
To:     Zhang Jianhua <chris.zjh@huawei.com>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 23 Sept 2021 at 04:51, Zhang Jianhua <chris.zjh@huawei.com> wrote:
>
> While reboot the system by sysrq, the following bug will be occur.
>
> BUG: sleeping function called from invalid context at kernel/locking/semaphore.c:90
> in_atomic(): 0, irqs_disabled(): 128, non_block: 0, pid: 10052, name: rc.shutdown
> CPU: 3 PID: 10052 Comm: rc.shutdown Tainted: G        W O      5.10.0 #1
> Call trace:
>  dump_backtrace+0x0/0x1c8
>  show_stack+0x18/0x28
>  dump_stack+0xd0/0x110
>  ___might_sleep+0x14c/0x160
>  __might_sleep+0x74/0x88
>  down_interruptible+0x40/0x118
>  virt_efi_reset_system+0x3c/0xd0
>  efi_reboot+0xd4/0x11c
>  machine_restart+0x60/0x9c
>  emergency_restart+0x1c/0x2c
>  sysrq_handle_reboot+0x1c/0x2c
>  __handle_sysrq+0xd0/0x194
>  write_sysrq_trigger+0xbc/0xe4
>  proc_reg_write+0xd4/0xf0
>  vfs_write+0xa8/0x148
>  ksys_write+0x6c/0xd8
>  __arm64_sys_write+0x18/0x28
>  el0_svc_common.constprop.3+0xe4/0x16c
>  do_el0_svc+0x1c/0x2c
>  el0_svc+0x20/0x30
>  el0_sync_handler+0x80/0x17c
>  el0_sync+0x158/0x180
>
> The reason for this problem is that irq has been disabled in
> machine_restart() and then it calls down_interruptible() in
> virt_efi_reset_system(), which would occur sleep in irq context,
> it is dangerous! Commit 99409b935c9a("locking/semaphore: Add
> might_sleep() to down_*() family") add might_sleep() in
> down_interruptible(), so the bug info is here. down_trylock()
> can solve this problem, cause there is no might_sleep.
>
> --------
>
> Signed-off-by: Zhang Jianhua <chris.zjh@huawei.com>

Thanks. I will queue this up.


> ---
>  drivers/firmware/efi/runtime-wrappers.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/firmware/efi/runtime-wrappers.c b/drivers/firmware/efi/runtime-wrappers.c
> index 1410beaef5c3..f3e54f6616f0 100644
> --- a/drivers/firmware/efi/runtime-wrappers.c
> +++ b/drivers/firmware/efi/runtime-wrappers.c
> @@ -414,7 +414,7 @@ static void virt_efi_reset_system(int reset_type,
>                                   unsigned long data_size,
>                                   efi_char16_t *data)
>  {
> -       if (down_interruptible(&efi_runtime_lock)) {
> +       if (down_trylock(&efi_runtime_lock)) {
>                 pr_warn("failed to invoke the reset_system() runtime service:\n"
>                         "could not get exclusive access to the firmware\n");
>                 return;
> --
> 2.31.0
>
