Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51A2D72657E
	for <lists+linux-efi@lfdr.de>; Wed,  7 Jun 2023 18:10:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239982AbjFGQKk (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 7 Jun 2023 12:10:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236205AbjFGQKj (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 7 Jun 2023 12:10:39 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B6811BE8
        for <linux-efi@vger.kernel.org>; Wed,  7 Jun 2023 09:10:36 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2b1bf74e080so9673211fa.1
        for <linux-efi@vger.kernel.org>; Wed, 07 Jun 2023 09:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686154234; x=1688746234;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mobcZ56EDAdsOHl632zWujZw9/4eeNxhULAqtWzwvkA=;
        b=Kv4edJf7c0QwvwcuX2ywFfhpmOSbNMc7rTrCCS5+0hjLRNCRxnz1zprOMxqDkw4oiq
         v1HJGMU3Dy6TS4VL6FyRm8HBChkmM6tq8fTvzyuK+vYL6SQcPAtxsJLfGTQvM8Wcbd11
         woGLdTbcAsUT+p49vl/Xp+M5Q/sblovZHdu2LHsYq09q+Ws6mfu5eVrejY7w/eJF9cGe
         KUor7Aw5bweVmImTUmgREkFoHFkDZiVMNIatQTxF0KyYb+A+Wd8ELeIRVZvdxwkR8v1M
         jvz1n4EWM8ZTfbDST/XuQU9DTWEZINYGv1GgWAEUpZMTnreu1pjctWFw5IzUBOTIWFsl
         nA7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686154234; x=1688746234;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mobcZ56EDAdsOHl632zWujZw9/4eeNxhULAqtWzwvkA=;
        b=SeTfteXdRAKjbU9V9tCkY/I5hSZN5p3dWCOv8uVEjnsLa3XSRf3VppIxuCbl3ILuXY
         IAasGKxx8qCUVRfpNAigi/t99/exgE2rwvlQjo/sRPYsP9JzugihQrkbUIJq096PMhht
         GKXZQ+kazGv+Rx3c3HlbTH2bVH18uzcQhcQTBcyO49DjRP0NMPq1+DbMfY5xeG657/7Y
         /M4RtOGxmtYlyKbFfdd/7Xqq/miWZHO0vhKxfWDzDVvHocl5HZAdrJBseVJ/XEFN/TBm
         MSPRS+mIMxo/A02Sud+2iIkVivq4kp64X0DZdAEVbuOpZozs8gVYixhJrDz30OAso7A9
         3Bqg==
X-Gm-Message-State: AC+VfDxyV8BvdYH1lteKxFr6raUJ0ljbFIqQAjJB7AYDTnx6Tla+pmCf
        AXJF27+46KJlU03GISWuZeAaMG7dM9sVVAkLq4WNwnFLKUHLEo3I
X-Google-Smtp-Source: ACHHUZ72xoObYskF04yUaFiFLbj75B6Hfbfnk9UARypsDOQvzmyprC1ItarwPmQDt1vrGJZTwM30Ap4H9U6dHq2ZMlk=
X-Received: by 2002:a2e:b5d3:0:b0:2a8:bd1d:bfb6 with SMTP id
 g19-20020a2eb5d3000000b002a8bd1dbfb6mr5293641ljn.13.1686154234191; Wed, 07
 Jun 2023 09:10:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230526010748.1222-1-masahisa.kojima@linaro.org>
 <20230526010748.1222-4-masahisa.kojima@linaro.org> <0d3e0370-eb76-010f-3d30-9acc9b59645c@siemens.com>
 <CAFA6WYPnWJNPvhT2JDkO-qXRUaJoxBGZEvSfhxcRynV7=VSdQA@mail.gmail.com>
 <CAMj1kXFM45PCTU--+CCed6Cq_N5XqDG6tTu6fnQTSCpW2BWA5A@mail.gmail.com>
 <4ff09002-e871-38b9-43ec-227a64bac731@siemens.com> <CAC_iWjJJ5E9Q1or5yTiDynzv_WAYH-g+N24aRdu9rvcsbWqnrg@mail.gmail.com>
 <CAFA6WYNFYB1LiOFB_iwTsdD5PmnDdSbtDSH2J4FVFPx3uik8rQ@mail.gmail.com>
 <CAC_iWj+E7-XK6dCeSn4205K0O3EZCLxCaC+adu-14ST6sdudfA@mail.gmail.com>
 <76da826f-b608-6add-5401-6de818b180e3@siemens.com> <CAFA6WYPCDRjFzsUMU=SNzEt88nT7Fcm1eOFL8z4HiQO+=2JeVA@mail.gmail.com>
 <cc6bd203-83ea-c247-0986-7fec6f327ee8@siemens.com>
In-Reply-To: <cc6bd203-83ea-c247-0986-7fec6f327ee8@siemens.com>
From:   Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date:   Wed, 7 Jun 2023 19:09:58 +0300
Message-ID: <CAC_iWjKZNHJxq4VMFnV7oQngwBBCQveh=s34u1LZ59YUqViPbw@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] efi: Add tee-based EFI variable driver
To:     Jan Kiszka <jan.kiszka@siemens.com>
Cc:     Sumit Garg <sumit.garg@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Masahisa Kojima <masahisa.kojima@linaro.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org,
        Johan Hovold <johan+linaro@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-efi@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        "Su, Bao Cheng (RC-CN DF FA R&D)" <baocheng.su@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Jan,

[...]
> >>> No I don't, this will work reliably without the need to remount the e=
fivarfs.
> >>> As you point out you will still have this dependency if you end up
> >>> building them as modules and you manage to mount the efivarfs before
> >>> those get inserted.  Does anyone see a reasonable workaround?
> >>> Deceiving the kernel and making the bootloader set the RT property bi=
t
> >>> to force the filesystem being mounted as rw is a nasty hack that we
> >>> should avoid.  Maybe adding a kernel command line parameter that says
> >>> "Ignore the RTPROP I know what I am doing"?  I don't particularly lov=
e
> >>> this either, but it's not unreasonable.
> >>
> >> In the context of https://github.com/OP-TEE/optee_os/issues/6094,
> >> basically this issue mapped on reboot/shutdown, I would really love to
> >> see the unhandy tee-supplicant daemon to be overcome.
> >
> > I have seen this error before and it has been on my todo list. So I
> > have tried to fix it here [1]. Feel free to test it and let me know if
> > you see any further issues.
> >
> > [1] https://lkml.org/lkml/2023/6/7/927
> >
>
> Ah, nice, will test ASAP!
>
> Meanwhile more food: I managed to build a firmware that was missing
> STMM. But the driver loaded, and I got this:

Thanks for the testing. I'll try to reproduce it locally and get back to yo=
u

/Ilias
>
> root@iot2050-debian:~# efi-updatevar -f PK.auth PK
> [  243.407097] Unable to handle kernel NULL pointer dereference at virtua=
l address 0000000000000000
> [  243.415959] Mem abort info:
> [  243.418801]   ESR =3D 0x86000004
> [  243.422099]   EC =3D 0x21: IABT (current EL), IL =3D 32 bits
> [  243.427529]   SET =3D 0, FnV =3D 0
> [  243.430755]   EA =3D 0, S1PTW =3D 0
> [  243.433931] user pgtable: 4k pages, 48-bit VAs, pgdp=3D000000008b74e00=
0
> [  243.440438] [0000000000000000] pgd=3D0000000000000000, p4d=3D000000000=
0000000
> [  243.447274] Internal error: Oops: 86000004 [#1] PREEMPT SMP
> [  243.452835] Modules linked in: ctr ccm mt7601u mac80211 cfg80211 rfkil=
l libarc4 cp210x usbserial pci_endpoint_test ti_k3_r5_remoteproc optee_rng =
rng_core ti_cal ti_am335x_adc videobuf2_dma_contig kfifo_buf v4l2_fwnode vi=
deobuf2_memops videobuf2_v4l2 videobuf2_common irq_pruss_intc at24 fuse ip_=
tables x_tables ipv6 tpm_ftpm_tee icssg_prueth pru_rproc icss_iep ptp pps_c=
ore ti_am335x_tscadc pruss
> [  243.487733] CPU: 0 PID: 875 Comm: efi-updatevar Not tainted 5.10.162-c=
ip24 #1
> [  243.494851] Hardware name: Unknown Unknown Product/Unknown Product, BI=
OS 2023.07-rc3-00018-g0afdaac6505 07/01/2023
> [  243.505180] pstate: 00000005 (nzcv daif -PAN -UAO -TCO BTYPE=3D--)
> [  243.511179] pc : 0x0
> [  243.513366] lr : efivar_entry_set_get_size+0xd4/0x1e0
> [  243.518404] sp : ffff8000127a3d00
> [  243.521708] x29: ffff8000127a3d00 x28: 0000000000000f87
> [  243.527012] x27: ffff000005bae400 x26: ffff800011254000
> [  243.532315] x25: ffff000005baf000 x24: ffff800011254aa0
> [  243.537618] x23: ffff8000127a3dab x22: ffff8000111d0268
> [  243.542921] x21: ffff8000127a3db0 x20: 0000000000000000
> [  243.548224] x19: ffff000005bae000 x18: 0000000000000000
> [  243.553527] x17: 0000000000000000 x16: 0000000000000000
> [  243.558829] x15: 0000aaab0876f264 x14: 35cd6a1025d11a20
> [  243.564132] x13: ac6f8dda3945638d x12: fb482642e3487f2d
> [  243.569435] x11: 0000000000000003 x10: ffff00000b792a80
> [  243.574738] x9 : a098e2bf989ff097 x8 : 0000000000000010
> [  243.580041] x7 : ffff800010e35c00 x6 : 4ddcbe2ecfc8fc79
> [  243.585345] x5 : 0000000000000000 x4 : ffff000005baf000
> [  243.590647] x3 : 0000000000000f87 x2 : 0000000000000027
> [  243.595950] x1 : ffff000005bae400 x0 : ffff000005bae000
> [  243.601254] Call trace:
> [  243.603695]  0x0
> [  243.605531]  efivarfs_file_write+0xa4/0x170
> [  243.609709]  vfs_write+0xf0/0x2a4
> [  243.613016]  ksys_write+0x68/0xf4
> [  243.616323]  __arm64_sys_write+0x1c/0x2c
> [  243.620241]  el0_svc_common.constprop.0+0x78/0x1c4
> [  243.625022]  do_el0_svc+0x24/0x8c
> [  243.628331]  el0_svc+0x14/0x20
> [  243.631378]  el0_sync_handler+0xb0/0xb4
> [  243.635206]  el0_sync+0x180/0x1c0
> [  243.638523] Code: bad PC value
> [  243.641573] ---[ end trace 369e4632cb003adc ]---
>
> Jan
>
> --
> Siemens AG, Technology
> Competence Center Embedded Linux
>
