Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 713BC4C1A38
	for <lists+linux-efi@lfdr.de>; Wed, 23 Feb 2022 18:51:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242788AbiBWRvv (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 23 Feb 2022 12:51:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231815AbiBWRvt (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 23 Feb 2022 12:51:49 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF65926C
        for <linux-efi@vger.kernel.org>; Wed, 23 Feb 2022 09:51:20 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id bn33so25782446ljb.6
        for <linux-efi@vger.kernel.org>; Wed, 23 Feb 2022 09:51:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RrdEVsjsD+nqXmQqBvUEIQg+R+7+UWVmueHZbvxi/fY=;
        b=HrqUskcTi7myVyE20lUHGxJ5Cbqhrcee6XGl5vkm8NnzpACCfPRFm/+h5jJFvLnJIH
         J09n5gnVJYBhqvTpCNt326dmBcHXVR9YUWVcgJOUx74XOdS76Di+Wn+9quQYy+pi6ymr
         AsBJ+RxttBSyKX71ZYQ6bNvnrcXsiJ1bMJZvziOq0mEDMa/C6SnANiHyPjCmlEDftBo/
         /dmao04eFUAwrM4TWxdQ2+Jv6uDUNIJ/Y7xhQ5+9z5AGuZ7My4MfYahlXf0wQULDAW0S
         WUl4lShCV5B1BEGM+itp8+KvXaDTINCwBbb3TuBr8OUEIxfhmCSDYRJNrwhzTrZlOXR8
         AoMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RrdEVsjsD+nqXmQqBvUEIQg+R+7+UWVmueHZbvxi/fY=;
        b=nErAFeEuRdEOUdpfh++IAE1JQVe0RuR01RTvaG4biM9nvA5blfRcHmX7C/ElmGbrDJ
         HfMT7I/WNfLKycncbeQB1i+OPDTYYCwJXoiXKt8XCQoeQmhzlLrhZlaMxxsTK/J4iaOf
         jPdsT7zuqW5uYsjrgOdBEYRhOTE7rpnioCP7lGb8Nen68Dyz+n6oO3dub8COfLLP5o2A
         yfeWWnMvawOnOuxUmct2jzYqzhSleqCI84eXYA+F4ws4KNVyqZTcBaDSDpu6cZMPuadp
         IkAF2s7ens7cjx/sUXsiIKY+72J/NVPGL2JOmgB6i/+HvRaYtQeKM/WB8qnU4jCD10xp
         1gdw==
X-Gm-Message-State: AOAM5303JniwMoGrxSpF0Bf46z7QFsvxKo00rISUaZkMu/CUBGhdqAFe
        0j0CKW2Dg+aLutN4uoiS3w161nCEbKOET4sFeq5DrA==
X-Google-Smtp-Source: ABdhPJyy2+PbEHWjK5m1pGy4RMoMiz8/1ddYOLWwa6WdZj216uctOj7fPykTeNcuWhj9vtR5ujN+1LSrAt9hQfe4l5g=
X-Received: by 2002:a2e:b78f:0:b0:246:6331:c1bc with SMTP id
 n15-20020a2eb78f000000b002466331c1bcmr378483ljo.188.1645638679148; Wed, 23
 Feb 2022 09:51:19 -0800 (PST)
MIME-Version: 1.0
References: <20220218181950.1438236-1-jannh@google.com> <8D85619E-99BD-4DB5-BDDB-A205B057C910@chromium.org>
In-Reply-To: <8D85619E-99BD-4DB5-BDDB-A205B057C910@chromium.org>
From:   Jann Horn <jannh@google.com>
Date:   Wed, 23 Feb 2022 18:50:52 +0100
Message-ID: <CAG48ez0UJDBzoaB4=c0Uju6L-eZvhWMdnzAp8N3QfeERbzYv2w@mail.gmail.com>
Subject: Re: [PATCH v2] pstore: Don't use semaphores in always-atomic-context code
To:     Kees Cook <keescook@chromium.org>
Cc:     Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Feb 23, 2022 at 8:50 AM Kees Cook <keescook@chromium.org> wrote:
> On February 18, 2022 10:19:50 AM PST, Jann Horn <jannh@google.com> wrote:
> >pstore_dump() is *always* invoked in atomic context (nowadays in an RCU
> >read-side critical section, before that under a spinlock).
> >It doesn't make sense to try to use semaphores here.
>
> Ah, very nice. Thanks for the analysis!
>
> >[...]
> >-static bool pstore_cannot_wait(enum kmsg_dump_reason reason)
> >+bool pstore_cannot_block_path(enum kmsg_dump_reason reason)
>
> Why the rename,

That's one of the parts of commit ea84b580b955 that I included in the
revert. "wait" in the name is not accurate, since "wait" in the kernel
normally refers to scheduling away until some condition is fulfilled.
(Though I guess "block" also isn't the best name either... idk.) The
place where we might want to have different behavior depending on
whether we're handling a kernel crash are spinlocks; during a kernel
crash, we shouldn't deadlock on them, but otherwise, AFAIK it's fine
to block on them.

> extern, and EXPORT? This appears to still only have the same single caller?

Also part of the revert. I figured it might make sense to also revert
that part because:

With this commit applied, the EFI code will always take the "nonblock"
path for now, but that's kinda suboptimal; on some platforms the
"blocking" path uses a semaphore, so we really can't take that, but on
x86 it uses a spinlock, which we could block on if we're not oopsing.
We could avoid needlessly losing non-crash dmesg dumps there; I don't
know whether we care about that though.

So I figured that we might want to start adding new callers to this
later on. But if you want, I'll remove that part of the revert and
resend?

> > [...]
> >-                      pr_err("dump skipped in %s path: may corrupt error record\n",
> >-                              in_nmi() ? "NMI" : why);
> >-                      return;
> >-              }
> >-              if (down_interruptible(&psinfo->buf_lock)) {
> >-                      pr_err("could not grab semaphore?!\n");
> >+      if (pstore_cannot_block_path(reason)) {
> >+              if (!spin_trylock_irqsave(&psinfo->buf_lock, flags)) {
> >+                      pr_err("dump skipped in %s path because of concurrent dump\n"
> >+                                     , in_nmi() ? "NMI" : why);
>
> The pr_err had the comma following the format string moved,

Ah, whoops, that was also part of the revert, but I guess I should
have left that part out...

> and the note about corruption removed. Is that no longer accurate?

There should be no more corruption since commit 959217c84c27 ("pstore:
Actually give up during locking failure") - if we're bailing out, we
can't be causing corruption, I believe?
