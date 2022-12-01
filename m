Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD68863F12E
	for <lists+linux-efi@lfdr.de>; Thu,  1 Dec 2022 14:05:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231547AbiLANF2 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 1 Dec 2022 08:05:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbiLANFL (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 1 Dec 2022 08:05:11 -0500
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BFFEA894D
        for <linux-efi@vger.kernel.org>; Thu,  1 Dec 2022 05:04:23 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id i80so998699ioa.0
        for <linux-efi@vger.kernel.org>; Thu, 01 Dec 2022 05:04:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=l7Y2FkbIVTKFtl+HxieOmsxNGhmLoxEmtYJ88v/cdgw=;
        b=Sxbi0cvSliG9a00Ry4hRL3209ix85X2kIBcjhC5k1nEv5BOdHhFeI7Ixds0JdL6dZ6
         7K72xHH++bcFQ6L4GeTVOnVIGmY3VxFsiE1PwDgAbEFd1Qg/8JsKJA/ZZABySB5cfN5I
         rXB/aOLFPlnEkVyBmH4j/VAB0BH/L38J6evN4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l7Y2FkbIVTKFtl+HxieOmsxNGhmLoxEmtYJ88v/cdgw=;
        b=emnhU6ORnL5Qa8fpLx1fI6BW9LlFDnfbunxTFkxCgmnr+N34B8Zf6TaAVUkqrkMsqn
         MEt7KnhmgFVjik0+aAAOjzuaFV4rIDbgwbHsuNWzrPCHxWU/oo5cTMNUjjBoZMD/EF+Z
         0hJgd5PcV615SPYDNEqlfP2Rz7fcundWGwHltoN+uT0cz51ybYcRawrAEMYhg+iRTfOS
         SEn7jm2nw+WtRcZ8lWh1Bv3U8Gq35mYfyN/SuE/f5ogO/7XZ2w6YrI0m8jhpnoLsWaYS
         P+hUqHhvKXTeSX1qlxes4zi4mmGKjbPlWafrPazUxtS8/pSn00CCtAMKi9OAiObYNoUI
         Eo8g==
X-Gm-Message-State: ANoB5pmsp4Jny91uUtj1JfZ1YiWSp9zPUr2CWMMqVERicCFt6PoQFTIz
        ohHBhLGiNByDqYqtY0Ay4PJ2+X/ZCiAxr+tl
X-Google-Smtp-Source: AA0mqf73RZUOyvzB5/JfbThjcvKvkGObFKi++TE2K5lQIiNyqDZeD4pFgB0L+CDzlwJLICaHPLFXEA==
X-Received: by 2002:a05:6602:3302:b0:6de:bb17:4821 with SMTP id b2-20020a056602330200b006debb174821mr21319881ioz.157.1669899862312;
        Thu, 01 Dec 2022 05:04:22 -0800 (PST)
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com. [209.85.166.50])
        by smtp.gmail.com with ESMTPSA id q22-20020a02a996000000b00375147442f3sm1638868jam.16.2022.12.01.05.04.17
        for <linux-efi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Dec 2022 05:04:17 -0800 (PST)
Received: by mail-io1-f50.google.com with SMTP id p83so978021iod.2
        for <linux-efi@vger.kernel.org>; Thu, 01 Dec 2022 05:04:17 -0800 (PST)
X-Received: by 2002:a05:6e02:66d:b0:303:1196:96c7 with SMTP id
 l13-20020a056e02066d00b00303119696c7mr9848943ilt.133.1669899845427; Thu, 01
 Dec 2022 05:04:05 -0800 (PST)
MIME-Version: 1.0
References: <20221127-snd-freeze-v8-0-3bc02d09f2ce@chromium.org>
 <20221127-snd-freeze-v8-3-3bc02d09f2ce@chromium.org> <716e5175-7a44-7ae8-b6bb-10d9807552e6@suse.com>
In-Reply-To: <716e5175-7a44-7ae8-b6bb-10d9807552e6@suse.com>
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Thu, 1 Dec 2022 14:03:54 +0100
X-Gmail-Original-Message-ID: <CANiDSCtwSb50sjn5tM7jJ6W2UpeKzpuzng+RdJuywiC3-j2zdg@mail.gmail.com>
Message-ID: <CANiDSCtwSb50sjn5tM7jJ6W2UpeKzpuzng+RdJuywiC3-j2zdg@mail.gmail.com>
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

Thanks for your review

On Thu, 1 Dec 2022 at 13:29, Oliver Neukum <oneukum@suse.com> wrote:
>
> On 01.12.22 12:08, Ricardo Ribalda wrote:
> > If we are shutting down due to kexec and the userspace is frozen, the
> > system will stall forever waiting for userspace to complete.
> >
> > Do not wait for the clients to complete in that case.
>
> Hi,
>
> I am afraid I have to state that this approach is bad in every case,
> not just this corner case. It basically means that user space can stall
> the kernel for an arbitrary amount of time. And we cannot have that.
>
>         Regards
>                 Oliver

This patchset does not modify this behaviour. It simply fixes the
stall for kexec().

The  patch that introduced the stall:
83bfc7e793b5 ("ASoC: SOF: core: unregister clients and machine drivers
in .shutdown")

was sent as a generalised version of:
https://github.com/thesofproject/linux/pull/3388

AFAIK, we would need a similar patch for every single board.... which
I am not sure it is doable in a reasonable timeframe.

On the meantime this seems like a decent compromises. Yes, a
miss-behaving userspace can still stall during suspend, but that was
not introduced in this patch.

Regards!
>


-- 
Ricardo Ribalda
