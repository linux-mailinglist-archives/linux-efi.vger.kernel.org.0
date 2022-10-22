Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84A5A608B3D
	for <lists+linux-efi@lfdr.de>; Sat, 22 Oct 2022 12:07:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbiJVKGd (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 22 Oct 2022 06:06:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbiJVKGF (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 22 Oct 2022 06:06:05 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AE0432CC54;
        Sat, 22 Oct 2022 02:22:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 96F4EB81AFB;
        Sat, 22 Oct 2022 09:01:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31F7DC43140;
        Sat, 22 Oct 2022 09:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666429275;
        bh=NVy7cwX6C23sERHy1g/nnuGIjErNtZyXyTNgD2+Z8lo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hkdoLSo4YoYvszhmKO8wDid/L8ZK2oEDeBpeBgfhSAzXitpKlqDL4xRbeqmPgY0Y/
         EEqFUomF7UshpP5lc9rladRCEJo6VbL7GX2+yw2nrt0bPsLUSja8deN8fMgc5afKN0
         tURbO0z+fjDe4sGWYpnRA2VysvFUcLZGL2E10h2stBS7U4t55ufhNnsamg9zSnHgN/
         oEm2NPFC2pP32E1IdA0bPQaMxj36naCwbeW5HkSltSPxmAWFYWEc5pGANFFBS8r6V+
         ZFD7kmV6HhMJ1EXLLhDxGblCYpHir/URlq5kP+bQ8K7xBbRsjeUIUuW0YfpoVb1cp2
         tTl/o4uOYRZVA==
Received: by mail-lj1-f173.google.com with SMTP id bs14so6660489ljb.9;
        Sat, 22 Oct 2022 02:01:15 -0700 (PDT)
X-Gm-Message-State: ACrzQf34J+gboSTV6z9lSVAmEW0T2/yhsD20vp/zgJGtbrcyYrJZ5Bps
        YFLT3Sqlgcv+4tfMfgzP6rmfYoMDdz9O/LX+5iU=
X-Google-Smtp-Source: AMsMyM5F3pcPecCVma1z4hA5Ubjj98E32W8YwWQjcBGZOhJmB8By+ME04iKb6STAkgLC/rbG8+zw0NOQeOUua+pqEwE=
X-Received: by 2002:a2e:9a81:0:b0:26c:5b63:7a83 with SMTP id
 p1-20020a2e9a81000000b0026c5b637a83mr8989214lji.291.1666429273074; Sat, 22
 Oct 2022 02:01:13 -0700 (PDT)
MIME-Version: 1.0
References: <20221018082214.569504-1-justin.he@arm.com> <20221018082214.569504-7-justin.he@arm.com>
 <Y1OtRpLRwPPG/4Il@zn.tnic>
In-Reply-To: <Y1OtRpLRwPPG/4Il@zn.tnic>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Sat, 22 Oct 2022 11:01:01 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFu36faTPoGSGPs9KhcKsoh_DE9X2rmwdenxaJwa3P_yw@mail.gmail.com>
Message-ID: <CAMj1kXFu36faTPoGSGPs9KhcKsoh_DE9X2rmwdenxaJwa3P_yw@mail.gmail.com>
Subject: Re: [PATCH v10 6/7] apei/ghes: Use xchg_release() for updating new
 cache slot instead of cmpxchg()
To:     Borislav Petkov <bp@alien8.de>
Cc:     Jia He <justin.he@arm.com>, Len Brown <lenb@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Jan Luebbe <jlu@pengutronix.de>,
        Khuong Dinh <khuong@os.amperecomputing.com>,
        Kani Toshi <toshi.kani@hpe.com>,
        James Morse <james.morse@arm.com>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
        devel@acpica.org, "Rafael J . Wysocki" <rafael@kernel.org>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Jarkko Sakkinen <jarkko@kernel.org>, linux-efi@vger.kernel.org,
        nd@arm.com, Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sat, 22 Oct 2022 at 10:44, Borislav Petkov <bp@alien8.de> wrote:
>
> On Tue, Oct 18, 2022 at 08:22:13AM +0000, Jia He wrote:
> > From: Ard Biesheuvel <ardb@kernel.org>
> >
> > From: Ard Biesheuvel <ardb@kernel.org>
> >
> > ghes_estatus_cache_add() selects a slot, and either succeeds in
> > replacing its contents with a pointer to a new cached item, or it just
> > gives up and frees the new item again, without attempting to select
> > another slot even if one might be available.
> >
> > Since only inserting new items is needed, the race can only cause a failure
> > if the selected slot was updated with another new item concurrently,
> > which means that it is arbitrary which of those two items gets
> > dropped. This means the cmpxchg() and the special case are not necessary,
>
> Hmm, are you sure about this?
>
> Looking at this complex code, I *think* the intent of the cache is to
> collect already reported errors - the ghes_estatus_cached() checks - and
> the adding happens when you report a new one:
>
>         if (!ghes_estatus_cached(estatus)) {
>                 if (ghes_print_estatus(NULL, ghes->generic, estatus))
>                         ghes_estatus_cache_add(ghes->generic, estatus);
>
> Now, the loop in ghes_estatus_cache_add() is trying to pick out the,
> well, oldest element in there. Meaning, something which got reported
> already but a long while ago. There's even a sentence trying to say what
> this does:
>
> /*
>  * GHES error status reporting throttle, to report more kinds of
>  * errors, instead of just most frequently occurred errors.
>  */
>
> And the cmpxchg() is there to make sure when that selected element
> slot_cache is removed, it really *is* that element that gets removed and
> not one which replaced it in the meantime.
>
> So it is likely I'm missing something here but it sure looks like this
> is some sort of a complex, lockless, LRU scheme...
>

You are correct.

But the point is that the new element we are adding has the same
properties as the one we want to avoid replacing inadvertently, and if
the cmpxchg() failed, we just drop it on the floor.

So instead of dropping 'our' new element, we now drop 'the other' new element.

The correct approach here would be to rerun the selection loop on
failure, but I doubt whether it is worth it. This is just a fancy rate
limiter.
