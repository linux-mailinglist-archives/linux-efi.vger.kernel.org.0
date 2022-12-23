Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35977654BE6
	for <lists+linux-efi@lfdr.de>; Fri, 23 Dec 2022 05:15:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbiLWEO7 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 22 Dec 2022 23:14:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbiLWEO6 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 22 Dec 2022 23:14:58 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2106923172
        for <linux-efi@vger.kernel.org>; Thu, 22 Dec 2022 20:14:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671768850;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=W8v+3G849+2S0xHy0EcZ+6a57gHNI9cJdTWoIlTjt0o=;
        b=hYHs1Wt61XNUCX/a+0h1bz0C0IVqAQCRO3RTl+lr/8X4bn/wHPEPtPgVry9y4JMGfa97Qb
        af2PN8z8UjAjx1PcvvIxKqtBo73dcMSv1bTIuTdprYvRELjI9a4EZQHSbmjqPbxDs7w5j/
        zdQE/xsXe52pwwVvtnY9sdYVpWVIj6M=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-177-qWPSDaJXM_aNejQX4zb6hg-1; Thu, 22 Dec 2022 23:14:06 -0500
X-MC-Unique: qWPSDaJXM_aNejQX4zb6hg-1
Received: by mail-lj1-f199.google.com with SMTP id n13-20020a2e720d000000b0027b49bf1de1so859802ljc.14
        for <linux-efi@vger.kernel.org>; Thu, 22 Dec 2022 20:14:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W8v+3G849+2S0xHy0EcZ+6a57gHNI9cJdTWoIlTjt0o=;
        b=dFYo2DOGKnQqbZdu5hcVKcwmL8V65+8eIoylJI9HsONawenx8mgoWAlO2iU8QZVGHE
         Urbf1wTg5bvRtv79QEcDuy13oY4hNDYiEE+2zuHTu8Yn3hKjbF7OaaIExkAwIGIU2ZdL
         wpnXnRqp7h7ovBsQK69dre0n6aqocZFhHWtDjMqIIfi3hitdtnzd38C5whiCRoDELRXz
         WJUe6763x+4wnY/Oi2DTWzsiw/wRF1q6jmgYEFD0mu8QedKYfv5cHvqpifZROlvNmX9H
         9o138qZnkEb913KxJNv/GD/nCPPzUWDF07PoTKG6lFsHDFrRccV+CpGeSHQsy7qaLF45
         sOJA==
X-Gm-Message-State: AFqh2kpijzkTYDSTVuf20zlygFyZailQAKHqkAznR1vrI+0m3aH0nq86
        r5Am6eAsJq8zFa3JC+prH65PlbPIxRE8DQzIMhRx0Sg0BvfoeYqgogMZnY2zqvFUVCYvOwIg/rS
        5287QDryNa7gxD1ENVcbEq/vrZkz+EyVbvIRB
X-Received: by 2002:a19:6551:0:b0:4b6:eb4d:4b7f with SMTP id c17-20020a196551000000b004b6eb4d4b7fmr753906lfj.530.1671768845405;
        Thu, 22 Dec 2022 20:14:05 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtbx+XA7ibSIzMkjc1Pgf3D7cSeL9iy+3/xaOLVs4mkXZk7ekHoty6BJcJu83VHPGDODdsDRqGrYYzOSR4UF4w=
X-Received: by 2002:a19:6551:0:b0:4b6:eb4d:4b7f with SMTP id
 c17-20020a196551000000b004b6eb4d4b7fmr753900lfj.530.1671768845216; Thu, 22
 Dec 2022 20:14:05 -0800 (PST)
MIME-Version: 1.0
References: <CALu+AoSXOCJPH0edbb-BmyTz2zUywY8-QfjYjjKJggSTmK=WyQ@mail.gmail.com>
 <bfd82c75c5a387a0cad0da4ebe6e9d4c87ca7ac0.camel@HansenPartnership.com>
In-Reply-To: <bfd82c75c5a387a0cad0da4ebe6e9d4c87ca7ac0.camel@HansenPartnership.com>
From:   Dave Young <dyoung@redhat.com>
Date:   Fri, 23 Dec 2022 12:12:53 +0800
Message-ID: <CALu+AoSjo0Gs=299yGnDEY5fY9EwiSQzxFYCwKvBF89kxwgbGQ@mail.gmail.com>
Subject: Re: Queries about disabling EFI runtime services late
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org,
        Coiby Xu <coxu@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Clark Williams <williams@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Added Thomas and Clark if any more inputs

On Tue, 20 Dec 2022 at 23:06, James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
> On Tue, 2022-12-20 at 11:43 +0800, Dave Young wrote:
> > Hi Ard,
> >
> > Real time kernels usually disable efi runtime for latency issues,
>
> Could you say a bit more about this?  I was under the impression we
> only call efi runtime services when asked: for variable or capsule
> updates or if you use the EFI RTC.  So if you don't use EFI services in
> a real time kernel, you shouldn't suffer any latency issues due to
> having them enabled.

I do not have much background, but from below kconfig option, it will
be disabled by default when PREEMPT_RT is set

config EFI_DISABLE_RUNTIME
        bool "Disable EFI runtime services support by default"
        default y if PREEMPT_RT


>
> >  but for some use cases, e.g. when Secure Boot is used kexec needs to
> > get the UEFI keys to verify the kernel signatures with
> > kexec_file_load syscall.
>
> It's not just kexec.  Without EFI variable services, you won't be able
> to update the MoK keys for new kernels either.

Yes, one workaround is people can use kernel cmdline to enable runtime
and update MoK keys, then reboot with the default setup.

This is not ideal though.

>
> James
>
>
> >
> > Do you have suggestions on how to make both work?
> > Is it possible to have something like CONFIG_EFI_DISABLE_RUNTIME_LATE
> > so the runtime can be disabled after init phase or a runtime switch
> > in sysctl?
> >
> > Thanks
> > Dave
> >
>

