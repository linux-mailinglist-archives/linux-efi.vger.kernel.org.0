Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4653756647
	for <lists+linux-efi@lfdr.de>; Mon, 17 Jul 2023 16:25:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbjGQOZu (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 17 Jul 2023 10:25:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbjGQOZt (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 17 Jul 2023 10:25:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03350131
        for <linux-efi@vger.kernel.org>; Mon, 17 Jul 2023 07:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689603911;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kg+GsbYLB4O3WTuuQwregxIHX9P5sA4QNLHVsEdZbKc=;
        b=ab2dzQahp+WSdgYjVlPCB3gd2Wr2cieYk2NlbtLH2dCxtc1iSllWcsXC/8fY8XRM/TL5qs
        4vQZTQujB8nkbdTnMUu9+6dZROZthDeEGJPETigZIFN0G05p/pZhPNG6fbTJPhGoXBhywW
        T3loiawFqRjn9UxsbdyNVl3wDlgF1TA=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-620-Ma2nqGRuPvazb8_Fv6NT1A-1; Mon, 17 Jul 2023 10:25:10 -0400
X-MC-Unique: Ma2nqGRuPvazb8_Fv6NT1A-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-521a38098faso64220a12.2
        for <linux-efi@vger.kernel.org>; Mon, 17 Jul 2023 07:25:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689603909; x=1692195909;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kg+GsbYLB4O3WTuuQwregxIHX9P5sA4QNLHVsEdZbKc=;
        b=I9O+soO5nEN01g9ID8jZsv/rCz081WBKmXC9he3GCj0PWFFyGHG0ENKoPngYqJ/js8
         zGKa9qI3dGCVNErPNAlFoSl9g8pNCwa2vt7QWQK5gIIsWKu/YF6xWdZCa81c2fwOGtBn
         uSn4fKds1+PEQev0oA+zTBViwEj/VLAjAP7eSnEjV6W4V3TLyccdFmcVRB000TVTK16f
         lAUQd2QkWcpOsn53W7NeQu0wkgNHcT4Fi06nVvVzbpKy8KoNZ6Ocd5sOXj2yvGZHH+qC
         w/EgxI4Eqk25HB4PpCl+5Tm9uALfcIJnj44hN5N02gQ6GurdfZU0DSw3wZFFWd9oCzTZ
         h0Yg==
X-Gm-Message-State: ABy/qLbNQYICyMAtj86ZilhBNa1EfM8lrRSKLBCUa9Jl4WSlnen5uazn
        IeJDjgNFXnM/yJJ87t5n1qlpu10aScvM6HdSFmqeNXFQNi9ed23P2dVl/bHVVTF73oh4gg+ODjj
        1WY1SmOEC7eVL49cz8Cz//kS+RDnjFCeHWabs
X-Received: by 2002:aa7:cb52:0:b0:516:af22:bcc6 with SMTP id w18-20020aa7cb52000000b00516af22bcc6mr10499333edt.21.1689603908841;
        Mon, 17 Jul 2023 07:25:08 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEeRRv4xnmP1QWzxE9nxS6UxsaMMZ6UGX3WY7lj15U4ppSZ6Je25rTk/Td7DbyXDl4JEeQ0BcOx7tC4qAnbgMY=
X-Received: by 2002:aa7:cb52:0:b0:516:af22:bcc6 with SMTP id
 w18-20020aa7cb52000000b00516af22bcc6mr10499318edt.21.1689603908534; Mon, 17
 Jul 2023 07:25:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230601072043.24439-1-ltao@redhat.com> <20230713100459.GEZK/MS69XbphJa+tN@fat_crate.local>
 <CAO7dBbVMNKTSDi5eP4BseEUexsk0Mo0GWJpyHfOcp+tHs6cSUw@mail.gmail.com> <20230717141409.GGZLVMsU6d/9mpJvMO@fat_crate.local>
In-Reply-To: <20230717141409.GGZLVMsU6d/9mpJvMO@fat_crate.local>
From:   Tao Liu <ltao@redhat.com>
Date:   Mon, 17 Jul 2023 22:24:32 +0800
Message-ID: <CAO7dBbX4pCO7pd==2P956HFeTVrMfb0oB33EXVxWbFuPFq=Oaw@mail.gmail.com>
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
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

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
OK, thanks for the help. I will re-make, test and update the info.

> > The stack trace may not be the same all the time, I didn't dive deep
> > into the root cause, but it looks to me the patch will cause an
> > unknown issue. Also I tested the patch on kernel-5.14.0-318.el9, it
>
> This is the upstream kernel mailing list so those Frankenstein kernels
> are all left to you.
>
> Good luck. :-)
>
OK, thanks!

Thanks,
Tao Liu

> --
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette
>

