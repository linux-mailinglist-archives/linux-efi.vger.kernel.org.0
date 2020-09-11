Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 506CD266827
	for <lists+linux-efi@lfdr.de>; Fri, 11 Sep 2020 20:17:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725851AbgIKSRH (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 11 Sep 2020 14:17:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:55176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725730AbgIKSRD (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 11 Sep 2020 14:17:03 -0400
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4E21121D79;
        Fri, 11 Sep 2020 18:17:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599848222;
        bh=u8/mPrVURYhPqdDyFTV/A2D8Sgo7S+0VEGhgujlLGjg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Yw2QzwBKV1KqPoZf8Ei2GtXzn4V9U7IT3oemiHPGZmKrN1okBSsbOFZpjTqbRRRSn
         UWyGKJBWppRXdbU9wNH6JjNEA0KAqvoJzTkqr9Dy5/iCTqBcyhVdrTAd7JRkszq3Mm
         8QubACqXP4q9KuQr2vlYn3+OrT40fdCkTSYUBKJM=
Received: by mail-ot1-f53.google.com with SMTP id 60so9117216otw.3;
        Fri, 11 Sep 2020 11:17:02 -0700 (PDT)
X-Gm-Message-State: AOAM530OWSk5puoZ5i9EwuvnYaVwUBDQk+EAlXGkwiI91mtFK6pqQDom
        O+VkNoDy2xp8SvmRM3kwvOIOMndlsjbrqV6CcjI=
X-Google-Smtp-Source: ABdhPJwtLMTM9vEIWrzMubKwSTEJ8uvh7kjUufPCPqKEc5oc2KztzVNpmf1BlFnttv+vj/fKFZDRvMMYjoTBPJFwYa4=
X-Received: by 2002:a9d:6250:: with SMTP id i16mr2081474otk.77.1599848221567;
 Fri, 11 Sep 2020 11:17:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200905013107.10457-1-lszubowi@redhat.com> <20200905013107.10457-3-lszubowi@redhat.com>
 <CAMj1kXEdkdeE8VSZqEzhd__Kb7_ZmG2af6iBpbY3=nsj1-phYw@mail.gmail.com>
 <f0a079b1-5f02-8618-fdfe-aea2278113c9@redhat.com> <cb8b4ebaa35d79eba65b011d042d20a991adf540.camel@linux.ibm.com>
 <394190b9-59bd-5cb3-317e-736852f190f4@redhat.com>
In-Reply-To: <394190b9-59bd-5cb3-317e-736852f190f4@redhat.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 11 Sep 2020 21:16:50 +0300
X-Gmail-Original-Message-ID: <CAMj1kXEz8y+X6KjqWWFD=38dDowqXDBvnPbgeh30+o83KpmKrg@mail.gmail.com>
Message-ID: <CAMj1kXEz8y+X6KjqWWFD=38dDowqXDBvnPbgeh30+o83KpmKrg@mail.gmail.com>
Subject: Re: [PATCH V2 2/3] integrity: Move import of MokListRT certs to a
 separate routine
To:     Lenny Szubowicz <lszubowi@redhat.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org,
        linux-security-module@vger.kernel.org, andy.shevchenko@gmail.com,
        James Morris <jmorris@namei.org>, serge@hallyn.com,
        Kees Cook <keescook@chromium.org>,
        Borislav Petkov <bp@alien8.de>,
        Peter Jones <pjones@redhat.com>,
        David Howells <dhowells@redhat.com>, prarit@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, 11 Sep 2020 at 20:18, Lenny Szubowicz <lszubowi@redhat.com> wrote:
>
> On 9/11/20 11:59 AM, Mimi Zohar wrote:
> > On Fri, 2020-09-11 at 11:54 -0400, Lenny Szubowicz wrote:
> >> On 9/11/20 11:02 AM, Ard Biesheuvel wrote:
> >>> On Sat, 5 Sep 2020 at 04:31, Lenny Szubowicz <lszubowi@redhat.com> wrote:
> >>>>
> >>>> Move the loading of certs from the UEFI MokListRT into a separate
> >>>> routine to facilitate additional MokList functionality.
> >>>>
> >>>> There is no visible functional change as a result of this patch.
> >>>> Although the UEFI dbx certs are now loaded before the MokList certs,
> >>>> they are loaded onto different key rings. So the order of the keys
> >>>> on their respective key rings is the same.
> >>>>
> >>>> Signed-off-by: Lenny Szubowicz <lszubowi@redhat.com>
> >>>
> >>> Why did you drop Mimi's reviewed-by from this patch?
> >>
> >> It was not intentional. I was just not aware that I needed to propagate
> >> Mimi Zohar's reviewed-by from V1 of the patch to V2.
> >>
> >> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> >>
> >> V2 includes changes in that patch to incorporate suggestions from
> >> Andy Shevchenko. My assumption was that the maintainer would
> >> gather up the reviewed-by and add any signed-off-by as appropriate,
> >> but it sounds like my assumption was incorrect. In retrospect, I
> >> could see that having the maintainer dig through prior versions
> >> of a patch set for prior reviewed-by tags could be burdensome.
> >
> > As much as possible moving code should be done without making changes,
> > simpler for code review.   Then as a separate patch you make changes.
> > That way you could also have retained my Reviewed-by.
> >
> > Mimi
>
> If you or Ard think I should, I can do a V3 with:
>
>    Patch V3 01: Unchanged from V2
>    Patch V3 02: Goes back to V1 of patch 02 that Mimi reviewed
>    Patch V3 03: New. Has Andy's cleanup suggestions separated from patch 02
>    Patch V3 04: This would most probably just be the V2 of patch 03 with no changes
>

I think we can just merge the patches as they are, with Mimi's R-b carried over.
