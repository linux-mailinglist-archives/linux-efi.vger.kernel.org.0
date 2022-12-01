Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E17663F1DC
	for <lists+linux-efi@lfdr.de>; Thu,  1 Dec 2022 14:40:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbiLANkb (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 1 Dec 2022 08:40:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbiLANka (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 1 Dec 2022 08:40:30 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA6E3B2B61
        for <linux-efi@vger.kernel.org>; Thu,  1 Dec 2022 05:40:28 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id y131so362440iof.9
        for <linux-efi@vger.kernel.org>; Thu, 01 Dec 2022 05:40:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tKguKo1XmUP31FlNvdaT70p0o/lwuxyZc7lK6ytX1QU=;
        b=exIoeOCrlPb+Uw2FGLRsALkrLYWj9cDaTvcr81Evjsi5DXIR/uPZJTWsXlu/PiLLI3
         HTBr5t4pzsWnn6M0lC4H5pNT0n3aLXEpcSRixu/mfsu8XeXoSArYBYlbqRz6mRys5h3T
         IyXf+jqyVq8u6L+O/LqO4biBjWXlb+7RKXSc0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tKguKo1XmUP31FlNvdaT70p0o/lwuxyZc7lK6ytX1QU=;
        b=BoCvjJRw2fAjFhNhdk+w0rIkumgd8GdLrDD8dS6WeJsO3bKJPNFRWCBPN+6HV9UBiP
         v2hhKhKIMw/VvqnYXvBIYpXfN1TV75CY8DhESd/bAjW24f36Lpa6YwjNprAXzRJY3rXB
         OfbCUUtOqePf6dPAdnt8O0ZhANPr2i9lVucMoh258OHZgFBFnMKaKgS4Thk4gW0t9G9f
         wB+UXGa34j1xwCJ+ie5fPiC2vITfklLEomXxZnlPo7/jJkDCI4+96fQTEO/XJzooLlKv
         CPy0HxlqfGSipqjqS1ZJpyoAQmGmHrnl/5Yz9ZG2gmyc88AjD2UM7cy6sgUrcadcLrhi
         ISPw==
X-Gm-Message-State: ANoB5pliCOLM0DLkka0WT8vhe06xjoUoYamu2DWBBbXBlaaAePMb7TN2
        gBJM10KGdIxrRvxKwjZrpNgDb8uIPsgovd8h
X-Google-Smtp-Source: AA0mqf5n/czDlFaRnw6cmHfu8XJRUX6A8qbY93sDkOzxopLRporTDFT+dR/gl/YrOo79Txto2v891g==
X-Received: by 2002:a02:cc96:0:b0:364:e67:8d26 with SMTP id s22-20020a02cc96000000b003640e678d26mr1394221jap.117.1669902028157;
        Thu, 01 Dec 2022 05:40:28 -0800 (PST)
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com. [209.85.166.50])
        by smtp.gmail.com with ESMTPSA id y6-20020a027306000000b00389d6a02740sm1647155jab.157.2022.12.01.05.40.27
        for <linux-efi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Dec 2022 05:40:27 -0800 (PST)
Received: by mail-io1-f50.google.com with SMTP id q79so5717iod.4
        for <linux-efi@vger.kernel.org>; Thu, 01 Dec 2022 05:40:27 -0800 (PST)
X-Received: by 2002:a92:ca89:0:b0:302:385e:eeb4 with SMTP id
 t9-20020a92ca89000000b00302385eeeb4mr24829482ilo.66.1669901667796; Thu, 01
 Dec 2022 05:34:27 -0800 (PST)
MIME-Version: 1.0
References: <20221127-snd-freeze-v8-0-3bc02d09f2ce@chromium.org>
 <20221127-snd-freeze-v8-3-3bc02d09f2ce@chromium.org> <716e5175-7a44-7ae8-b6bb-10d9807552e6@suse.com>
 <CANiDSCtwSb50sjn5tM7jJ6W2UpeKzpuzng+RdJuywiC3-j2zdg@mail.gmail.com> <d3730d1d-6f92-700a-06c4-0e0a35e270b0@suse.com>
In-Reply-To: <d3730d1d-6f92-700a-06c4-0e0a35e270b0@suse.com>
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Thu, 1 Dec 2022 14:34:16 +0100
X-Gmail-Original-Message-ID: <CANiDSCtm7dCst_atiWk=ZcK_D3=VzvD0+kWXVQr4gEn--JjGkw@mail.gmail.com>
Message-ID: <CANiDSCtm7dCst_atiWk=ZcK_D3=VzvD0+kWXVQr4gEn--JjGkw@mail.gmail.com>
Subject: Re: [PATCH v8 3/3] ASoC: SOF: Fix deadlock when shutdown a frozen userspace
To:     Oliver Neukum <oneukum@suse.com>
Cc:     Juergen Gross <jgross@suse.com>, Mark Brown <broonie@kernel.org>,
        Chromeos Kdump <chromeos-kdump@google.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Len Brown <len.brown@intel.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Eric Biederman <ebiederm@xmission.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Joel Fernandes <joel@joelfernandes.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Pavel Machek <pavel@ucw.cz>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Ingo Molnar <mingo@redhat.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Dexuan Cui <decui@microsoft.com>,
        Takashi Iwai <tiwai@suse.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        kexec@lists.infradead.org, alsa-devel@alsa-project.org,
        stable@vger.kernel.org, sound-open-firmware@alsa-project.org,
        linuxppc-dev@lists.ozlabs.org, linux-hyperv@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        xen-devel@lists.xenproject.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Oliver

On Thu, 1 Dec 2022 at 14:22, 'Oliver Neukum' via Chromeos Kdump
<chromeos-kdump@google.com> wrote:
>
> On 01.12.22 14:03, Ricardo Ribalda wrote:
>
> Hi,
>
> > This patchset does not modify this behaviour. It simply fixes the
> > stall for kexec().
> >
> > The  patch that introduced the stall:
> > 83bfc7e793b5 ("ASoC: SOF: core: unregister clients and machine drivers
> > in .shutdown")
>
> That patch is problematic. I would go as far as saying that
> it needs to be reverted.
>

It fixes a real issue. We have not had any complaints until we tried
to kexec in the platform.
I wont recommend reverting it until we have an alternative implementation.

kexec is far less common than suspend/reboot.

> > was sent as a generalised version of:
> > https://github.com/thesofproject/linux/pull/3388
> >
> > AFAIK, we would need a similar patch for every single board.... which
> > I am not sure it is doable in a reasonable timeframe.
> >
> > On the meantime this seems like a decent compromises. Yes, a
> > miss-behaving userspace can still stall during suspend, but that was
> > not introduced in this patch.
>
> Well, I mean if you know what wrong then I'd say at least return to
> a sanely broken state.
>
> The whole approach is wrong. You need to be able to deal with user
> space talking to removed devices by returning an error and keeping
> the resources association with the open file allocated until
> user space calls close()

In general, the whole shutdown is broken for all the subsystems ;).
It is a complicated issue. Users handling fds, devices with DMAs in
the middle of an operation, dma fences....

Unfortunately I am not that familiar with the sound subsystem to make
a proper patch for this.

>
>         Regards
>                 Oliver
>
>
>
> --
> You received this message because you are subscribed to the Google Groups "Chromeos Kdump" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to chromeos-kdump+unsubscribe@google.com.
> To view this discussion on the web, visit https://groups.google.com/a/google.com/d/msgid/chromeos-kdump/d3730d1d-6f92-700a-06c4-0e0a35e270b0%40suse.com.



-- 
Ricardo Ribalda
