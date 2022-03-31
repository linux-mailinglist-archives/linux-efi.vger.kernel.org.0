Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3C114EE1BA
	for <lists+linux-efi@lfdr.de>; Thu, 31 Mar 2022 21:30:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240274AbiCaTay (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 31 Mar 2022 15:30:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240705AbiCaTax (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 31 Mar 2022 15:30:53 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9975F21244;
        Thu, 31 Mar 2022 12:29:04 -0700 (PDT)
Date:   Thu, 31 Mar 2022 21:29:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1648754942;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SyRunJIttOSoKPtRPHVIrqd1pxkb0TjVve+voxhbD10=;
        b=Kb6NtKDnhx71zz0GNRf097nKYq6nD1t7B3ApI8gUlJpzEqWyM/bVV04hZFHUhd66cgwkkB
        s5QzvQIF4+pXqVYxkIopLCiEhvVpiw/vLG+43VyDaLWf0CQInoDz8VJFu9YkNwEkfJrbFX
        rrwCCl7DxjIcb9N/o6dHp0vGghmY6cd6YkZGtHAqGWKUHvYa6ZfDLNy48EBbJZk9VB4sbz
        6S6OPPGD6o9tRtxWQRMDTv4ENqC9Bbh7ggeByeklACXiFLxlasYMtZfrKCqaxJIK4W+V6l
        euVywUCvpP/kzuk9vAlsY/uvtevd5a0llcjqeOysKcu1Gk32esIxCo6Zae0H8A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1648754942;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SyRunJIttOSoKPtRPHVIrqd1pxkb0TjVve+voxhbD10=;
        b=uWFmRx5ti2WzkyyQpub6TqK7NwdfLKb6opOH0V23cijzXiMLlrEA+HR0IUlKfLppY7UdjY
        Hqhkzoo4hWHiWNCQ==
From:   "Ahmed S. Darwish" <a.darwish@linutronix.de>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Brian Masney <bmasney@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Al Stone <ahs3@redhat.com>,
        Peter Robinson <pbrobinson@gmail.com>,
        Robbie Harwood <rharwood@redhat.com>,
        Peter Jones <pjones@redhat.com>,
        Alexander Larsson <alexl@redhat.com>,
        Andrew Halaney <ahalaney@redhat.com>,
        linux-rt-users@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2] efi: Allow to enable EFI runtime services by default
 on RT
Message-ID: <YkYA/Wpqa/PMczkp@lx-t490>
References: <20220331151654.184433-1-javierm@redhat.com>
 <CAMj1kXHgyjB_BVzXx+CK0tBuJpZ3h=8XKus7nWiyovECjVQ0gw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMj1kXHgyjB_BVzXx+CK0tBuJpZ3h=8XKus7nWiyovECjVQ0gw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Ard, Javier,

Am Do, Mar 31, 2022, schrieb Ard Biesheuvel:
> On Thu, 31 Mar 2022 at 17:17, Javier Martinez Canillas
> <javierm@redhat.com> wrote:
> >
> > Commit d9f283ae71af ("efi: Disable runtime services on RT") disabled EFI
> > runtime services by default when the CONFIG_PREEMPT_RT option is enabled.
> >
> > The rationale for that commit is that some EFI calls could take too much
> > time, leading to large latencies which is an issue for Real-Time kernels.
> >
> > But a side effect of that change was that now is not possible anymore to
> > enable the EFI runtime services by default when CONFIG_PREEMPT_RT is set,
> > without passing an efi=runtime command line parameter to the kernel.
> >
> > Instead, let's add a new EFI_DISABLE_RUNTIME boolean Kconfig option, that
> > would be set to n by default but to y if CONFIG_PREEMPT_RT is enabled.
> >
> > That way, the current behaviour is preserved but gives users a mechanism
> > to enable the EFI runtimes services in their kernels if that is required.
> > For example, if the firmware could guarantee bounded time for EFI calls.
> >
> > Also, having a separate boolean config could allow users to disable the
> > EFI runtime services by default even when CONFIG_PREEMPT_RT is not set.
> >
> > Reported-by: Alexander Larsson <alexl@redhat.com>
> > Fixes: d9f283ae71af ("efi: Disable runtime services on RT")
> > Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> > ---
> >
> > Changes in v2:
> > - Improve commit description to make clear the motivation for the change
> >   (Sebastian Andrzej Siewior).
> >
>
> This looks ok to me. I'll queue this up once the merge window closes.
>

In case of (CONFIG_PREEMPT_RT=y && CONFIG_EFI_DISABLE_RUNTIME=n),
shouldn't we add a small message in the kernel log warning that EFI
runtime services are enabled for the RT kernel?

In almost all HW, except custom ones with "verified" firmware, such a
warning would be useful... This is especially true since in the embedded
domain, manually-configured RT kernels are almost always the norm.

Thanks,

--
Ahmed S. Darwish
Linutronix GmbH | Bahnhofstrasse 3 | D-88690 Uhldingen-Mühlhofen
Phone: +49 7556 25 999 31; Fax.: +49 7556 25 999 99

Hinweise zum Datenschutz finden Sie hier (Informations on data privacy
can be found here): https://linutronix.de/kontakt/Datenschutz.php

Linutronix GmbH | Firmensitz (Registered Office): Uhldingen-Mühlhofen |
Registergericht (Registration Court): Amtsgericht Freiburg i.Br., HRB700
806 | Geschäftsführer (Managing Directors): Heinz Egger, Thomas Gleixner
