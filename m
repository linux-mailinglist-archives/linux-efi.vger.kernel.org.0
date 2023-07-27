Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E06D7651EF
	for <lists+linux-efi@lfdr.de>; Thu, 27 Jul 2023 13:04:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232936AbjG0LEy (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 27 Jul 2023 07:04:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232058AbjG0LEx (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 27 Jul 2023 07:04:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF19630CF
        for <linux-efi@vger.kernel.org>; Thu, 27 Jul 2023 04:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690455845;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Dk3LN9ysCMp0nX/c571qwFAAMC2Qp+rntI/6p9s/CFU=;
        b=U3NuZVGQwSwuLwWTmTtzjcntHvaj3sRMmpjQhgDuhwFaJuUbnH6INY6nXRSiuWj2KciT8G
        q68MhdiUkFOENuXzBS+YR6HIPxreA+Zk7cdoSX2R/tbk9JTRY2vVPBCMmW2a07Ss+WVcUR
        6qUK+vGD6YoSFovCcOq8DCd05QNfwLg=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-61-0VtngynSMx2VQEOfPVGVTA-1; Thu, 27 Jul 2023 07:04:04 -0400
X-MC-Unique: 0VtngynSMx2VQEOfPVGVTA-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-50daa85e940so541611a12.0
        for <linux-efi@vger.kernel.org>; Thu, 27 Jul 2023 04:04:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690455843; x=1691060643;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dk3LN9ysCMp0nX/c571qwFAAMC2Qp+rntI/6p9s/CFU=;
        b=fMDaDk2wRc/5N2wOCwcaWoE5VDEZBJhLRdDWz8D/8JaQv7FLmr61BthoXbBh7ZK/kW
         sJMI06qswt0S4sOzK78r5gH4hCUd1BrfAuNjnM6r0tuf3LUbEmbOpVfaQO8qFHLOedoy
         PYPmFuiRHkDWIslPJ47oKig6OWrewKxsSoOwWDERIhQ+QRGY0x4gx/FcTbIUlJLgNREt
         1xx60te+Z2wg8yycqY0lflIHlPogjxEhX8MFgaexS660aVHbcPJs2SrGZ+9dLBtX4JYF
         5TLWjOx+6urAIHj1QH+KOIskFnNGqueC7eypJgM46KprGPdM5tqbDlW/wZ/yxXk0M9GU
         a6Ug==
X-Gm-Message-State: ABy/qLaVSvUk2cogjy7R35wNpBNOuIS1utliN5FnkDx3xzUc2p4kKPfy
        mHZtHweJlLr2sOA1B4OmARAqWWCo5dkJQVD8jtpKyf3gji791qsC+GVOBuyEBRXhQzCv4JycKdc
        MLwohqq3mWzERKd2R/sNFAyc1/6WgOVRh/mWf
X-Received: by 2002:a05:6402:1816:b0:522:3790:1303 with SMTP id g22-20020a056402181600b0052237901303mr1439872edy.32.1690455843443;
        Thu, 27 Jul 2023 04:04:03 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGVNw/Z6wVqm/KZzUEarit/lmkOUef30Ga5juO1p3ACM6osXPaYMMA5sLXXHwivu6UQMvBnH0lT00nmKBGSQa4=
X-Received: by 2002:a05:6402:1816:b0:522:3790:1303 with SMTP id
 g22-20020a056402181600b0052237901303mr1439861edy.32.1690455843131; Thu, 27
 Jul 2023 04:04:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230601072043.24439-1-ltao@redhat.com> <20230713100459.GEZK/MS69XbphJa+tN@fat_crate.local>
 <CAO7dBbVMNKTSDi5eP4BseEUexsk0Mo0GWJpyHfOcp+tHs6cSUw@mail.gmail.com> <20230717141409.GGZLVMsU6d/9mpJvMO@fat_crate.local>
In-Reply-To: <20230717141409.GGZLVMsU6d/9mpJvMO@fat_crate.local>
From:   Tao Liu <ltao@redhat.com>
Date:   Thu, 27 Jul 2023 19:03:26 +0800
Message-ID: <CAO7dBbXJv9JzDbSa-DLT03+osYCQXNUXFwz63gbq=NGDxEVyEA@mail.gmail.com>
Subject: Re: [PATCH v2] x86/kexec: Add EFI config table identity mapping for
 kexec kernel
To:     Borislav Petkov <bp@alien8.de>
Cc:     tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, ardb@kernel.org,
        linux-kernel@vger.kernel.org, bhe@redhat.com, dyoung@redhat.com,
        kexec@lists.infradead.org, linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Borislav,

Sorry for the late response. I spent some time retesting your patch
against 6.5.0-rc1 and 6.5.0-rc3, and it is OK. So

Reported-and-tested-by: Tao Liu <ltao@redhat.com>

And will we use this patch as a workaround or will we wait for a
better solution as proposed by Michael?

On Mon, Jul 17, 2023 at 10:14=E2=80=AFPM Borislav Petkov <bp@alien8.de> wro=
te:
>
> On Mon, Jul 17, 2023 at 09:53:06PM +0800, Tao Liu wrote:
> > ...snip...
> > [   21.360763]  nvme0n1: p1 p2 p3
> > [   21.364207] igc 0000:03:00.0: PTM enabled, 4ns granularity
> > [   21.421097] pps pps1: new PPS source ptp1
> > [   21.425396] igc 0000:03:00.0 (unnamed net_device) (uninitialized): P=
HC added
> > [   21.457005] igc 0000:03:00.0: 4.000 Gb/s available PCIe bandwidth
> > (5.0 GT/s PCIe x1 link)
> > [   21.465210] igc 0000:03:00.0 eth1: MAC: ...snip...
> > [   21.473424] igc 0000:03:00.0 enp3s0: renamed from eth1
> > [   21.479446] BUG: kernel NULL pointer dereference, address: 000000000=
0000008
> > [   21.486405] #PF: supervisor read access in kernel mode
> > [   21.491519] mmc1: Failed to initialize a non-removable card
> > [   21.491538] #PF: error_code(0x0000) - not-present page
> > [   21.502229] PGD 0 P4D 0
> > [   21.504773] Oops: 0000 [#1] PREEMPT SMP NOPTI
> > [   21.509133] CPU: 3 PID: 402 Comm: systemd-udevd Not tainted 6.5.0-rc=
1+ #1
> > [   21.515905] Hardware name: ...snip...
> > [   21.522851] RIP: 0010:kernfs_dop_revalidate+0x2b/0x120
>
> So something's weird here - my patch should not cause a null ptr deref
> here.

The random kernel panic I encountered is irrelevant to this patch, and
I'm pretty sure it is caused by some driver, highly suspicious it is
the graphic card driver i915.ko. When I apply this patch, 1)
disconnect the monitor(using serial port to login) and keep i915, or
2) connect the monitor but remove i915, the kexec kernel will not
fail. Though i915 has provided a pci shutdown function, maybe some bug
triggered and caused memory overwrite after kexec. Anyway, it is
another issue.

Thanks,
Tao Liu

>
> > [   21.527995] Code: 1f 44 00 00 83 e6 40 0f 85 07 01 00 00 41 55 41
> > 54 55 53 48 8b 47 30 48 89 fb 48 85 c0 0f 84 a2 00 00 00 48 8b a87
>
> This looks weird too. There's no "<>" brackets denoting which byte it
> was exactly where RIP pointed to when the NULL ptr happened.
>
> Do
>
> make fs/kernfs/dir.s
>
> and upload dir.s and the dir.o file somewhere.
>
> In any case, my patch shouldn't be causing this. At least I don't see
> it.
>
> I'm testing a better version of the patch and it should not cause this
> thing even less.
>
> > The stack trace may not be the same all the time, I didn't dive deep
> > into the root cause, but it looks to me the patch will cause an
> > unknown issue. Also I tested the patch on kernel-5.14.0-318.el9, it
>
> This is the upstream kernel mailing list so those Frankenstein kernels
> are all left to you.
>
> Good luck. :-)
>
> --
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette
>

