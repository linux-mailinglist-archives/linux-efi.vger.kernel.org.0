Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C39A69ADB9
	for <lists+linux-efi@lfdr.de>; Fri, 17 Feb 2023 15:15:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbjBQOPX (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 17 Feb 2023 09:15:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjBQOPW (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 17 Feb 2023 09:15:22 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 234C56CA1F;
        Fri, 17 Feb 2023 06:14:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6C39661C0D;
        Fri, 17 Feb 2023 14:14:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B71DCC433AC;
        Fri, 17 Feb 2023 14:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676643279;
        bh=mINpL34x/Uead5k5egJNBFMcTWkyH5EUQNil50cXnZo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=O2nFpcMuqQh9DEh416uOxvERJJofyA3yCzhKqUCR/aQZ0aLhqI8nJtoZmt7UjfXq3
         h+MC6DmYjFlWi1yTUi7RdadecyECL8G1bijbr5tNvLob4BDEu01vGW1LBYOU5cyvZh
         uI7h+MSWlBj26mujEEpg1t5t9khPqcpGo41MvaFYBIMK6S970zb7Rosf+GtMSUN+Hy
         3QbvkL/d2JI3Mbrql0K6OWZeDjzljusAIXsMKXLq5InWFx3G12gDHo/NGUd3W+znI0
         jHxfxioNWDFZFdY73Prp9Q4EJv2EuH+9PsySjqFFOBVi0l+YDvRkNDZXZPLbkTg0s4
         zEH5SunNGTcEA==
Received: by mail-lf1-f42.google.com with SMTP id t4so926392lfr.7;
        Fri, 17 Feb 2023 06:14:39 -0800 (PST)
X-Gm-Message-State: AO0yUKVmrfaqzuxq1+LBAeSYSDI3sua9cGHQ8Sf+eqRWOiF2yzZLlbuk
        tVzjKa/TY0eDZwLLp35XUUE3c1zUNrXH/iOLbkA=
X-Google-Smtp-Source: AK7set9HP1IOdlSvINow60vCQTlYUFCm095w6sOUsF/XFfnoXdettFqts1mCh0+duBh9xA5IX7sy7wQytBRjwIpyw5A=
X-Received: by 2002:ac2:5462:0:b0:4db:f0a:d574 with SMTP id
 e2-20020ac25462000000b004db0f0ad574mr494540lfn.7.1676643277675; Fri, 17 Feb
 2023 06:14:37 -0800 (PST)
MIME-Version: 1.0
References: <Y2o1hdZK9GGDVJsS@monolith.localdoman> <Y2rM/ud0JfX4QXJB@mail.local>
 <Y2u+Z7uWfokQYwKt@monolith.localdoman> <Y2wOH1X0tAWWY4zd@mail.local> <Y20l2SozLJdWtqCh@monolith.localdoman>
In-Reply-To: <Y20l2SozLJdWtqCh@monolith.localdoman>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 17 Feb 2023 15:14:26 +0100
X-Gmail-Original-Message-ID: <CAMj1kXExURYYPuLhN=PQvNN2eoK2ddMzOm6=PZsf=MeZvKEE+A@mail.gmail.com>
Message-ID: <CAMj1kXExURYYPuLhN=PQvNN2eoK2ddMzOm6=PZsf=MeZvKEE+A@mail.gmail.com>
Subject: Re: [BUG] rtc-efi: Error in efi.get_time() spams dmesg with error message
To:     Alexandru Elisei <alexandru.elisei@arm.com>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        a.zummo@towertech.it, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 10 Nov 2022 at 17:25, Alexandru Elisei <alexandru.elisei@arm.com> wrote:
>
> Hi,
>
> On Wed, Nov 09, 2022 at 09:31:27PM +0100, Alexandre Belloni wrote:
> > On 09/11/2022 14:51:19+0000, Alexandru Elisei wrote:
> > > Hi,
> > >
> > > On Tue, Nov 08, 2022 at 10:41:18PM +0100, Alexandre Belloni wrote:
> > > > On 08/11/2022 10:55:15+0000, Alexandru Elisei wrote:
> > > > > Hi,
> > > > >
> > > > > Commit d3549a938b73 ("efi/arm64: libstub: avoid SetVirtualAddressMap() when
> > > > > possible") exposed a firmware error on an Ampere Altra machine that was
> > > > > causing the machine to panic. Then commit 23715a26c8d8 ("arm64: efi:
> > > > > Recover from synchronous exceptions occurring in firmware") made the EFI
> > > > > exception non-fatal, and disabled runtime services when the exception
> > > > > happens. The interaction between those two patches are being discussed in a
> > > > > separate thread [1], but that should be orthogonal to this.
> > > > >
> > > > > Now efi.get_time() fails and each time an error message is printed to
> > > > > dmesg, which happens several times a second and clutters dmesg
> > > > > unnecessarily, to the point it becomes unusable.
> > > > >
> > > > > I was wondering if it would be possible to turn dev_err() into a
> > > > > dev_WARN_ONCE() or do something to avoid this issue. Tried to replace
> > > > > dev_err() with dev_err_ratelimited(), and the error message was displayed
> > > > > less often (about once per second), but dmesg was still being cluttered.
> > > > >
> > > >
> > > > The question this raise is what is actually trying to read the RTC this
> > > > often?
> > > >
> > > > This should be read once at boot and maybe every time you wake up from
> > > > suspend but there is no real reason to read it multiple times per
> > > > seconds.
> > >
> > > Reverted the commit the exposed the firmware bug, which means rtc-efi works as
> > > it should. Added these debug statements to check how many times efi_read_time()
> > > is called if there are no errors:
> > >
> > > --- a/drivers/rtc/rtc-efi.c
> > > +++ b/drivers/rtc/rtc-efi.c
> > > @@ -154,6 +154,7 @@ static int efi_set_alarm(struct device *dev, struct rtc_wkalrm *wkalrm)
> > >         return status == EFI_SUCCESS ? 0 : -EINVAL;
> > >  }
> > >
> > > +static unsigned long i = 0;
> > >  static int efi_read_time(struct device *dev, struct rtc_time *tm)
> > >  {
> > >         efi_status_t status;
> > > @@ -162,6 +163,9 @@ static int efi_read_time(struct device *dev, struct rtc_time *tm)
> > >
> > >         status = efi.get_time(&eft, &cap);
> > >
> > > +       i++;
> > > +       pr_info("%s: Call number %lu\n", __func__, i);
> > > +
> > >         if (status != EFI_SUCCESS) {
> > >                 /* should never happen */
> > >                 dev_err(dev, "can't read time\n");
> > >
> > > The function gets called 3 times, twice during boot and once after. I would say
> > > that efi_read_time() gets called so many times because it fails.
> > >
> >
> > It should really get called only once, at device registration when
> > CONFIG_RTC_HCTOSYS is set (which I despise):
> > https://elixir.bootlin.com/linux/latest/source/drivers/rtc/class.c#L431
> >
> > Could you maybe use dump_stack() ?
>
> Made this change to the driver:
>
> --- a/drivers/rtc/rtc-efi.c
> +++ b/drivers/rtc/rtc-efi.c
> @@ -160,6 +160,9 @@ static int efi_read_time(struct device *dev, struct rtc_time *tm)
>         efi_time_t eft;
>         efi_time_cap_t cap;
>
> +       pr_info("efi_read_time()\n");
> +       dump_stack();
> +
>         status = efi.get_time(&eft, &cap);
>
>         if (status != EFI_SUCCESS) {
>
> I don't know if it makes a difference, but the driver is compiled in
> (CONFIG_RTC_DRV_EFI=y) instead of it being a module.
>
> For the case when there's no synchronous exception (so runtime services are
> available):
>
> [   16.106871] rtc_efi: efi_read_time()
> [   16.110461] CPU: 3 PID: 1 Comm: swapper/0 Not tainted 6.1.0-rc4-00002-g5c5bcc194a43 #85
> [   16.118455] Hardware name: WIWYNN Mt.Jade Server System B81.03001.0005/Mt.Jade Motherboard, BIOS 1.08.20220218 (SCP: 1.08.20220218) 2022/02/18
> [   16.131221] Call trace:
> [   16.133657]  dump_backtrace.part.0+0xdc/0xf0
> [   16.137936]  show_stack+0x18/0x40
> [   16.141241]  dump_stack_lvl+0x68/0x84
> [   16.144902]  dump_stack+0x18/0x34
> [   16.148205]  efi_read_time+0x38/0xac
> [   16.151770]  __rtc_read_time+0x44/0x8c
> [   16.155515]  __rtc_read_alarm+0x27c/0x400
> [   16.159512]  __devm_rtc_register_device+0x100/0x300
> [   16.164378]  efi_rtc_probe+0xc4/0xf8
> [   16.167951]  platform_probe+0x68/0xe0
> [   16.171609]  really_probe+0xbc/0x2dc
> [   16.175174]  __driver_probe_device+0x78/0xe0
> [   16.179432]  driver_probe_device+0x3c/0x160
> [   16.183604]  __driver_attach+0x80/0x190
> [   16.187428]  bus_for_each_dev+0x70/0xd0
> [   16.191254]  driver_attach+0x24/0x30
> [   16.194817]  bus_add_driver+0x150/0x200
> [   16.198641]  driver_register+0x78/0x130
> [   16.202466]  __platform_driver_probe+0x58/0x11c
> [   16.206985]  efi_rtc_driver_init+0x24/0x30
> [   16.211070]  do_one_initcall+0x50/0x1c0
> [   16.214895]  kernel_init_freeable+0x214/0x280
> [   16.219245]  kernel_init+0x24/0x12c
> [   16.222725]  ret_from_fork+0x10/0x20
> [   16.226874] rtc-efi rtc-efi.0: registered as rtc0
> [   16.231577] rtc_efi: efi_read_time()
> [   16.235142] CPU: 3 PID: 1 Comm: swapper/0 Not tainted 6.1.0-rc4-00002-g5c5bcc194a43 #85
> [   16.243133] Hardware name: WIWYNN Mt.Jade Server System B81.03001.0005/Mt.Jade Motherboard, BIOS 1.08.20220218 (SCP: 1.08.20220218) 2022/02/18
> [   16.255897] Call trace:
> [   16.258331]  dump_backtrace.part.0+0xdc/0xf0
> [   16.262589]  show_stack+0x18/0x40
> [   16.265893]  dump_stack_lvl+0x68/0x84
> [   16.269544]  dump_stack+0x18/0x34
> [   16.272847]  efi_read_time+0x38/0xac
> [   16.276411]  __rtc_read_time+0x44/0x8c
> [   16.280148]  rtc_read_time+0x3c/0x70
> [   16.283711]  __devm_rtc_register_device+0x16c/0x300
> [   16.288575]  efi_rtc_probe+0xc4/0xf8
> [   16.292139]  platform_probe+0x68/0xe0
> [   16.295790]  really_probe+0xbc/0x2dc
> [   16.299353]  __driver_probe_device+0x78/0xe0
> [   16.303611]  driver_probe_device+0x3c/0x160
> [   16.307783]  __driver_attach+0x80/0x190
> [   16.311607]  bus_for_each_dev+0x70/0xd0
> [   16.315431]  driver_attach+0x24/0x30
> [   16.318994]  bus_add_driver+0x150/0x200
> [   16.322817]  driver_register+0x78/0x130
> [   16.326642]  __platform_driver_probe+0x58/0x11c
> [   16.331160]  efi_rtc_driver_init+0x24/0x30
> [   16.335245]  do_one_initcall+0x50/0x1c0
> [   16.339069]  kernel_init_freeable+0x214/0x280
> [   16.343414]  kernel_init+0x24/0x12c
> [   16.346891]  ret_from_fork+0x10/0x20
> [   16.351038] rtc-efi rtc-efi.0: setting system clock to 2022-11-10T14:57:06 UTC (1668092226)
> [..]
> [   55.871457] rtc_efi: efi_read_time()
> [   55.871483] CPU: 20 PID: 1744 Comm: kworker/20:2 Not tainted 6.1.0-rc4-00002-g5c5bcc194a43 #85
> [   55.871495] Hardware name: WIWYNN Mt.Jade Server System B81.03001.0005/Mt.Jade Motherboard, BIOS 1.08.20220218 (SCP: 1.08.20220218) 2022/02/18
> [   55.871500] Workqueue: events rtc_timer_do_work
> [   55.871529] Call trace:
> [   55.871533]  dump_backtrace.part.0+0xdc/0xf0
> [   55.871553]  show_stack+0x18/0x40
> [   55.871560]  dump_stack_lvl+0x68/0x84
> [   55.871573]  dump_stack+0x18/0x34
> [   55.871578]  efi_read_time+0x38/0xac
> [   55.871584]  __rtc_read_time+0x44/0x8c
> [   55.871589]  rtc_timer_do_work+0x64/0x1c0
> [   55.871593]  process_one_work+0x1d0/0x320
> [   55.871604]  worker_thread+0x14c/0x444
> [   55.871610]  kthread+0x10c/0x110
> [   55.871617]  ret_from_fork+0x10/0x20
>
> Running a v6.1-rc4 kernel, after the EFI synchronous abort, so runtime services
> are disabled:
>
> [   55.547383] rtc_efi: efi_read_time()
> [   55.547394] CPU: 1 PID: 829 Comm: kworker/1:1 Tainted: G        W I        6.1.0-rc4-00001-gbd8082c3515b #86
> [   55.547397] Hardware name: WIWYNN Mt.Jade Server System B81.03001.0005/Mt.Jade Motherboard, BIOS 1.08.20220218 (SCP: 1.08.20220218) 2022/02/18
> [   55.547399] Workqueue: events rtc_timer_do_work
> [   55.547405] Call trace:
> [   55.547406]  dump_backtrace.part.0+0xdc/0xf0
> [   55.547411]  show_stack+0x18/0x40
> [   55.547414]  dump_stack_lvl+0x68/0x84
> [   55.547418]  dump_stack+0x18/0x34
> [   55.547420]  efi_read_time+0x38/0xac
> [   55.547422]  __rtc_read_time+0x44/0x8c
> [   55.547424]  rtc_timer_do_work+0x64/0x1c0
> [   55.547425]  process_one_work+0x1d0/0x320
> [   55.547429]  worker_thread+0x14c/0x444
> [   55.547432]  kthread+0x10c/0x110
> [   55.547435]  ret_from_fork+0x10/0x20
> [   55.547437] efi: EFI Runtime Services are disabled!
> [   55.547441] rtc-efi rtc-efi.0: can't read time
> [   56.522572] efi: EFI Runtime Services are disabled!
> [   56.522602] rtc_efi: efi_read_time()
> [   56.522607] CPU: 46 PID: 883 Comm: kworker/46:1 Tainted: G        W I        6.1.0-rc4-00001-gbd8082c3515b #86
> [   56.522620] Hardware name: WIWYNN Mt.Jade Server System B81.03001.0005/Mt.Jade Motherboard, BIOS 1.08.20220218 (SCP: 1.08.20220218) 2022/02/18
> [   56.522627] Workqueue: events rtc_timer_do_work
> [   56.522640] Call trace:
> [   56.522644]  dump_backtrace.part.0+0xdc/0xf0
> [   56.522658]  show_stack+0x18/0x40
> [   56.522670]  dump_stack_lvl+0x68/0x84
> [   56.522680]  dump_stack+0x18/0x34
> [   56.522689]  efi_read_time+0x38/0xac
> [   56.522696]  __rtc_read_time+0x44/0x8c
> [   56.522703]  rtc_timer_do_work+0x64/0x1c0
> [   56.522710]  process_one_work+0x1d0/0x320
> [   56.522721]  worker_thread+0x14c/0x444
> [   56.522731]  kthread+0x10c/0x110
> [   56.522740]  ret_from_fork+0x10/0x20
> [   56.522751] rtc-efi rtc-efi.0: can't read time
> [   56.527202] CPU: 46 PID: 883 Comm: kworker/46:1 Tainted: G        W I        6.1.0-rc4-00001-gbd8082c3515b #86
> [   56.527205] Hardware name: WIWYNN Mt.Jade Server System B81.03001.0005/Mt.Jade Motherboard, BIOS 1.08.20220218 (SCP: 1.08.20220218) 2022/02/18
> [   56.527207] Workqueue: events rtc_timer_do_work
> [   56.527209] Call trace:
> [   56.527210]  dump_backtrace.part.0+0xdc/0xf0
> [   56.527213]  show_stack+0x18/0x40
> [   56.527217]  dump_stack_lvl+0x68/0x84
> [   56.527219]  dump_stack+0x18/0x34
> [   56.527222]  efi_read_time+0x38/0xac
> [   56.527224]  __rtc_read_time+0x44/0x8c
> [   56.527226]  rtc_timer_do_work+0x64/0x1c0
> [   56.527227]  process_one_work+0x1d0/0x320
> [   56.527230]  worker_thread+0x14c/0x444
> [   56.527234]  kthread+0x10c/0x110
> [   56.527236]  ret_from_fork+0x10/0x20
> [   56.527239] rtc-efi rtc-efi.0: can't read time
> [   56.531689] rtc_efi: efi_read_time()
> [   56.531700] CPU: 61 PID: 900 Comm: kworker/61:1 Tainted: G        W I        6.1.0-rc4-00001-gbd8082c3515b #86
> [   56.531705] Hardware name: WIWYNN Mt.Jade Server System B81.03001.0005/Mt.Jade Motherboard, BIOS 1.08.20220218 (SCP: 1.08.20220218) 2022/02/18
> [   56.531708] Workqueue: events rtc_timer_do_work
> [   56.531714] Call trace:
> [   56.531716]  dump_backtrace.part.0+0xdc/0xf0
> [   56.531723]  show_stack+0x18/0x40
> [   56.531728]  dump_stack_lvl+0x68/0x84
> [   56.531732]  dump_stack+0x18/0x34
> [   56.531737]  efi_read_time+0x38/0xac
> [   56.531741]  __rtc_read_time+0x44/0x8c
> [   56.531743]  rtc_timer_do_work+0x64/0x1c0
> [   56.531747]  process_one_work+0x1d0/0x320
> [   56.531752]  worker_thread+0x14c/0x444
> [   56.531757]  kthread+0x10c/0x110
> [   56.531761]  ret_from_fork+0x10/0x20
> [   56.531768] rtc-efi rtc-efi.0: can't read time
> [..]
>
> I've removed the first two GetTime() calls that happens before runtime
> services become unavailable, they looked similar to the calls in the first
> scenario. Can provide full log if needed.
>

Apologies - it appears I failed to follow up here.

I am sending out a patch that changes the dev_err to dev_err_once(),
as it is kind of immaterial whether the failure occurs once or
multiple times - the underlying issue is not going to be any
different.

That said, it would still be interesting to understand why this is
happening. Unfortunately, the EFI runtime calls are made from a
separate worker kthread, so the backtrace will not give you the
caller.

Recent kernels will give you the backtrace of the calling thread as
well, so if you apply the diff below, you should be able to tell where
the calls are coming from

diff --git a/drivers/firmware/efi/runtime-wrappers.c
b/drivers/firmware/efi/runtime-wrappers.c
index 7feee3d9c2bfbeec..2920849570b239d6 100644
--- a/drivers/firmware/efi/runtime-wrappers.c
+++ b/drivers/firmware/efi/runtime-wrappers.c
@@ -62,6 +62,7 @@ struct efi_runtime_work efi_rts_work;
                                                                        \
        if (!efi_enabled(EFI_RUNTIME_SERVICES)) {                       \
                pr_warn_once("EFI Runtime Services are disabled!\n");   \
+               WARN_ON(1);                                             \
                goto exit;                                              \
        }                                                               \
                                                                        \
