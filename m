Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C52E21B2F3
	for <lists+linux-efi@lfdr.de>; Fri, 10 Jul 2020 12:09:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726615AbgGJKJ4 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 10 Jul 2020 06:09:56 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:43081 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbgGJKJ4 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 10 Jul 2020 06:09:56 -0400
Received: from mail-qv1-f45.google.com ([209.85.219.45]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MhDIw-1kY6TI29AI-00eK63; Fri, 10 Jul 2020 12:09:54 +0200
Received: by mail-qv1-f45.google.com with SMTP id di5so2276762qvb.11;
        Fri, 10 Jul 2020 03:09:54 -0700 (PDT)
X-Gm-Message-State: AOAM532n3buQmTopmzjvj8DqP8b/9LM2Kgf0Yj3mynra1mbzcg1/8wQl
        kkHX1qyVGxXv3O5z2d1kxBj+IPGA/z1nmkyMAOs=
X-Google-Smtp-Source: ABdhPJz42eCmUaIZXAhF7p+bGv6J/eqTfJpUn8i64n/JP6ZF/QkNEGTvnQH4lELo6dycg+GyJ7Mr3FpMhnbMFtHAw/8=
X-Received: by 2002:ad4:4c09:: with SMTP id bz9mr32958807qvb.210.1594375793273;
 Fri, 10 Jul 2020 03:09:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200628182601.GA84577@gmail.com> <CAHk-=wgD+q+oDdtukYC74_cDX5i0Ynf0GLhuNe2Faaokejj6fQ@mail.gmail.com>
 <20200708162053.GU4800@hirez.programming.kicks-ass.net> <CAHk-=wggLLv8dY7ViOm7rdHxVNKJUkZMuR90vXO307WkBT8qrw@mail.gmail.com>
 <CAK8P3a1GFjM5-ENf7XL6jjUvRdJhgjzYpSGD5R7TmW6oWEhYRA@mail.gmail.com> <20200709103459.wenqhbp52vesr7e5@box>
In-Reply-To: <20200709103459.wenqhbp52vesr7e5@box>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 10 Jul 2020 12:09:36 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3Cd30gthLj-Kw8dsNa2Cse3YfUs9q8c=nc7fHtQ-QLSg@mail.gmail.com>
Message-ID: <CAK8P3a3Cd30gthLj-Kw8dsNa2Cse3YfUs9q8c=nc7fHtQ-QLSg@mail.gmail.com>
Subject: Re: [GIT PULL] EFI fixes
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:gvF83ApGf8hKP2O1vP8zoFIwS44aCFiOT/QsD3dUR7syB2ayIEp
 ZP7Wx3P2FeTmrlclGt64f46/6xp5Clr177EqCilknKtnxltjpM2k31rnCycFXG8iCDQg8l3
 JAvGf8OuyBN2mGKhLpMDcurprWw9i0tQGcgPL+TUjK5CS62ODAefH9HrniLt5aowQ1mGspF
 nGW79wKW1tkDiSFAiMnoQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:eBjNb/liNXQ=:qxrWFd//CZF+Zppew6fUEQ
 dVYZdZJQuaaVtD1lxgukJTxZEXte6aYuaCUKlEXImGBWeSg2r36c1iu2M/4P5U62mojTMXV4s
 MzLB74s/Dfhg6VagcRsKi8qNllt3pT/ikgrutvjatVjUFrpB72PzelAuYl0aSI04i2l/zOcnD
 hKttWm9NPuCaEqtuC758tfbYuv57/dVNylaab5OPLBf5VCUfH0n1QZA3hnS57CQHLaURjrcb+
 +FzTKBUnCrTUAwSQmFj3286SNgt2fyBSJvs/dm5opLhzuHTG0AC8Eeh2Wvr+9LZ/E3kCx8hJM
 MX5P5HZZd0YFj6aRUsJcFpNfFJamq5UfVNfaxpqoLGU8poM7yUbFMM9ECy3Ca9y9T5XXFBJ/u
 7/f9bO5fVY2F3+DTgr/vdJGIyrw3/+lVUu7lM0/dyURm+Nyq6Oi9qcrt7p26OHEF1QnPz+XGU
 YIn05ktBsK5JqDFb410SFQPxt3RwEsMrjdsOMCnysw4KCO35T2wSQKL/6Ja5BnEwuzwZVhOhg
 prQ1YlYw+YpyrSEnMDT9A7OKPDmqYG9dBQpKcezIp9F8odsGcvm6dIBYazLKHNzpoboB9+tuX
 RT5CcngsInSOM1QUAQEVIUpMlifrPUALnx+6kmLpyBm0n19jwQyyDV85VpoPeYL+bw50+EDZ2
 yQ1QEckn8UAlhL/V/T+aqeVhEzwx+fPOmcpefALHJMYL/J7VguhSqhnkwRKEFeRxfuY2ubIvT
 xjDJTeAW/+Y4NtAWmE/j2k7SaURwnVKEAdg6TvgFBxSstNS/kiahQh9r0+bnL8SkzwdJXEdwB
 NDxRKaZjkFNEniF97LNKAcaqQmt8wl1SlrmnvHBn1pBg5qvCAD+yOAbqGd2m/Tfx/NR6A5A
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Jul 9, 2020 at 12:35 PM Kirill A. Shutemov <kirill@shutemov.name> wrote:
>
> On Thu, Jul 09, 2020 at 11:30:27AM +0200, Arnd Bergmann wrote:
> > The most interesting version to require in the future would be
> > gcc-7, which IIRC is the point at which we can just use -std=gnu99
> > or -std=gnu11 instead of -std=gnu89 without running into the
> > problem with compound literals[1].
>
> It is gcc-5, not gcc-7. This commit:
>
> https://gcc.gnu.org/git/?p=gcc.git;a=commit;h=d303aeafa9b4

Ok, glad I was wrong here. I confirmed that with gcc-5 or higher I
can build a kernel with -std=gnu11 or -std=gnu99 instead of
-std=gnu89, but gcc-4.9.4 fails with anything other than gnu89.

I forgot why we care though -- is there any behavior of gnu11
that we prefer over the gnu99 behavior, or is it just going with
the times because it's the right thing to do? All the interesting
features of c11 seem to also be available as extensions in
gcc-4.9's gnu89, though I could not find a definite list of the
differences.

      Arnd
